FactoryGirl.define do
  factory :vulnerability, class: Gaas::Vulnerability do
    description "Example Vulnerability"
    cve nil
    url "https://example.com/vulnerability"
    patched_versions "> 1.2.3"
    gem_version { create :gem_version }
  end
end
