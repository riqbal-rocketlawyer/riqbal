#!/usr/bin/env ruby
# encoding: utf-8

require "git"
require "json"

puts "Cloning Repo"

repo_name="OPS-Chef"
container_name="doc-document-backend"

if !File.directory?("#{repo_name}")
    repo = Git.clone("git://github.com/riqbal-rocketlawyer/riqbal.git", "#{repo_name}")
    Dir.chdir(Dir.pwd + "/#{repo_name}")
else
    puts Dir.pwd
    Dir.chdir(Dir.pwd + "/#{repo_name}")
    repo = Git.init
    repo.pull("git://github.com/riqbal-rocketlawyer/riqbal.git", "master")
end

f_json = File.read("containers.json")
data = JSON.parse(f_json)

data["containers"]["#{container_name}"]["image"] = "DUMMMMMMYY"

data = JSON.pretty_generate(data)

File.open('containers.json', "w") do |f|
  f.write(data)
end

#puts "#{data['containers']['doc-document-backend']['image']}"
puts data