def run
  create_services()
#   create_users()
#   create_groups()
#   add_users_to_groups()
end

def create_services()
  Service.create(provider: 'github', logo: "Octocat.jpg")
  Service.create(provider: 'twitter', logo: "TwitterLogo.png")
end

# def create_users()
#   user_data.each do |k, user_data|
#     User.create(user_data)
#   end
# end
#
# def create_groups()
#   group_data.each do |k, group_data|
#     Group.create(group_data)
#   end
# end
#
# def add_users_to_groups
#   groups = Group.all
#   users = User.all
#
#   groups.each_with_index do |group, index|
#     group.users << users[index] if index < users.count - 1
#     group.users << users[index + 1] if index < users.count
#   end
# end
#
# def group_data
#   {
#     group1: {
#       name: "Turing Staff",
#       description: "Only the mediocre need apply.",
#       owner_id: User.find_by(uid: user_data[:user2][:uid]).id
#     },
#     group2: {
#       name: "1505",
#       description: "Going, going, gone.",
#       owner_id: User.find_by(uid: user_data[:user2][:uid]).id
#     },
#     group3: {
#       name: "1507",
#       description: "Must be cool with wierd people noises to belong.",
#       owner_id: User.find_by(uid: user_data[:user3][:uid]).id
#     }
#   }
# end
#
# def user_data
#   {
#     user1: {
#       provider: "github",
#       uid:      "3605799",
#       username: "sudbutt",
#       token:    "ccf8e335ac66712dcab05f2a6aa32a57eeeed492"
#     },
#     user2: {
#       provider: "github",
#       uid:      "8325508",
#       username: "noobjey",
#       token:    "d088f5075d8e264517cee9665f0f3659a92c3744"
#     },
#     user3: {
#       provider: "github",
#       uid:      "3893765",
#       username: "jbrr",
#       token:    "3ff74a83b1c6379c7de3ea4cdf440200d64b850f"
#     },
#     user4: {
#       provider: "github",
#       uid:      "10360311",
#       username: "Jpease1020",
#       token:    "d204cadb7af3278300543fa3f31a8b46fb137377"
#     }
#   }
# end
#
run()
