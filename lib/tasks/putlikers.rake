namespace :putlikers do
    desc "likerを補充するタスク"
    task show_likers: :environment do
        users = User.all
        users.each do |user|
            cnt = Liker.where(user_id: user.id).count
            max = 10 - cnt
            puts "user :"
            puts user.id
            puts user.name
            puts "max :"
            puts max
            num = 0
            while num < max do
                liker = Liker.new(user_id: user.id)
                liker.save
                puts "liker.id :"
                puts liker.id
                puts "num :"
                puts num
                num += 1
            end
        end
    end
end
