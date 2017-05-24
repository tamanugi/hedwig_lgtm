defmodule HedwigLgtm.Responders.LgtmTest  do
  use Hedwig.RobotCase

  @moduletag start_robot: true, name: "fukurou", responders: [{HedwigLgtm.Responders.Lgtm, []}]

  describe "" do
    test "lgtm responds with a LGTM image url", %{adapter: adapter, msg: msg} do
      send adapter, {:message, %{msg | text: "fukurou lgtm"}}
      assert_receive {:message, %{text: text}}, 5000
      assert text =~ "testuser: http"
    end

    test "lgtm <username> responds with a LGTM image url and mention", %{adapter: adapter, msg: msg} do
      send adapter, {:message, %{msg | text: "fukurou lgtm alfred"}}
      assert_receive {:message, %{text: text}}, 5000
      assert text =~ "alfred: http"
    end
  end

end
