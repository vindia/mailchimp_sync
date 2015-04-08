require 'gibbon'
require 'csv'
require_relative './list.rb'

def csv_file
  ARGV.first || 'users.csv'
end

def active_status(status)
  status == 'true' ? 'yes' : 'no'
end

gibbon = Gibbon::API.new "b0c785bf5245c286c93f903b2157ebe1-us7"
lists = gibbon.lists.list['data'].map{|l| List.new(l['id'], l['name'])}

CSV.foreach(csv_file, col_sep: ';', headers: true) do |user|
  puts "User: #{user['username']} #{user['name']} #{user['email']}"
  lists.each do |list|
    begin
      gibbon.lists.update_member({
        id: list.id,
        email: { email: user['email'] },
        merge_vars: { MMERGE4: active_status(user['active']) }
      })
    rescue Gibbon::MailChimpError => error
      puts "#{error.message} (#{list.name})"
    else
      puts "Updated #{user['email']} in #{list.name}"
    end
  end
end

