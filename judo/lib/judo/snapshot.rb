module Judo
  class Snapshot
    attr_accessor :name, :server_id

    def initialize(base, name, server_id)
      @base = base
      @name = name
      @server_id = server_id
    end

    def server_name
      server.name rescue '(deleted)'
    end

    def server
      @server ||= @base.servers.detect { |s| s.id == server_id }
    end

    def fetch_state
      @base.sdb.get_attributes(@base.snapshot_domain, name)[:attributes]
    end

    def state
      @base.snapshots_state[name] ||= fetch_state
    end

    def group_name
      get("group")
    end

    def created_at
      Time.at(get("created_at").to_i)
    end

    def version
      get("version").to_i
    end

    def metadata
      metadata_json = get("metadata_json")
      JSON.load(metadata_json) if metadata_json
    end

    def virgin
      get("virgin").to_s == "true"
    end

    def devs
      (state["devs"] || []).inject({}) { |out, kv| k, v = kv.split(':'); out[k] = v; out }
    end

    def create
      raise JudoError,"snapshot already exists" unless state.empty?
      raise JudoError,"server has no disks to clone: #{server.volumes}" if server.volumes.empty?
      @base.task("Snapshotting #{server.name}") do
        devs = server.volumes.map do |dev,vol|
          "#{dev}:#{@base.ec2.create_snapshot(vol)[:aws_id]}"
        end
        @base.sdb.put_attributes(@base.snapshot_domain, name, {
          "version" => server.version,
          "virgin" => server.virgin?,
          "metadata_json" => server.get("metadata_json"),
          "devs" => devs,
          "server" => server.id,
          "group" => server.group.name,
          "created_at" => Time.now.to_i.to_s
        }, :replace)
      end
    end

    def animate(new_server_name)
      raise JudoError, "cannot animate, snapshotting not complete" unless completed?
      @base.create_server(new_server_name, group_name,
        :version => version, :snapshots => devs, :virgin => virgin,
        :metadata => metadata , :clone => name, :instance_type => server.instance_type)
    end

    def delete
      raise JudoError, "cannot delete, snapshotting not complete" unless completed?
      @base.sdb.delete_attributes(@base.snapshot_domain, name)
    end

    def get(key)
      state[key] && [state[key]].flatten.first
    end

    def destroy
      devs.each do |dev,snapshot_id|
        @base.task("Deleting snapshot #{snapshot_id}") do
          begin
            @base.ec2.delete_snapshot(snapshot_id)
          rescue Object => e
            puts "Error destrotying snapshot #{e.message}"
          end
        end
      end
      delete
    end

    def ec2_ids
      devs.values
    end

    def ec2_data
      @base.ec2_snapshots.select { |s| ec2_ids.include? s[:aws_id] }
    end

    def completed?
      not ec2_data.detect { |s| s[:aws_status] != "completed" }
    end

    def progress
      min_percent = ec2_data.map { |s| s[:aws_progress].to_i }.min
      "#{min_percent}%"
    end

    def size(snap_id)
      @base.ec2_snapshots.detect { |s| s[:aws_id] == snap_id }
    end

    def version_desc
      group.version_desc(version)
    end

    def group
      @group ||= @base.groups.detect { |g| g.name == group_name }
    end

    def fetch_state
      @base.sdb.get_attributes(@base.snapshot_domain, name)[:attributes]
    end
  end
end
