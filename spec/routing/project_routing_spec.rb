require 'rails_helper'

RSpec.describe ProjectsHelper, :type => :helper do
  let(:project) { Project.new(name: "Project Runway") }

  it "augments with status info" do
    allow(project).to receive(:on_schedule?).and_return(true)
    actual = helper.name_with_status(project)
    expect(actual).to have_selector("span.on_schedule", text: "Project Runway")
  end

  it "augments project name with status info when behind schedule" do
    allow(project).to receive(:on_schedule?).and_return(false)
    actual = helper.name_with_status(project)
    expect(actual).to have_selector("span.behind_schedule", text: "Project Runway")
  end

end

RSpec.describe "project routing" do
  it 'routes projects' do
    expect(get: "/projects").to route_to(
      controller: "projects", action: "index")
    expect(post: "/projects").to route_to(
      controller: "projects", action: "create")
    expect(get: "/projects/new").to route_to(
      controller: "projects", action: "new")
    expect(get: "/projects/1").to route_to(
      controller: "projects", action: "show", id: "1")
    expect(get: "/projects/1/edit").to route_to(
      controller: "projects", action: "edit", id: "1")
    expect(patch: "/projects/1").to route_to(
      controller: "projects", action: "update", id: "1")
    expect(delete: "/projects/1").to route_to(
      controller: "projects", action: "destroy", id: "1")
  end
end
