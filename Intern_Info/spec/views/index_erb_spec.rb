require 'pry'
describe "widgets/index.erb" do
  it "displays all the widgets" do
    assign(:widgets, [
    	binding.pry
      stub_model(Widget, :name => "slicer"),
      stub_model(Widget, :name => "dicer")
    ])

    render

    rendered.should contain("slicer")
    rendered.should contain("dicer")
  end
end