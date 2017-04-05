FactoryGirl.define do
  factory :gem_info, class: Gaas::GemInfo do
    sequence(:name) {|i| "TestGem##{i}" }
  end
end
