class Gaas::VulnerabilitiesController < GaasController
  def index
    @vulnerabilities = Gaas::Vulnerability.joins(:resources)
  end
end
