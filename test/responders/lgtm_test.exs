defmodule HedwigLgtm.Responders.LgtmTest  do
  use Hedwig.RobotCase

  @moduletag start_robot: true, name: "fukurou", responders: [{HedwigLgtm.Responders.Lgtm, []}]

  describe "" do
    test "responds with a LGTM image url", %{adapter: adapter, msg: msg} do
      send adapter, {:message, %{msg | text: "fukurou lgtm"}}
      assert_receive {:message, %{text: text}}, 5000
      assert text =~ "testuser: http"
    end
  end

end
