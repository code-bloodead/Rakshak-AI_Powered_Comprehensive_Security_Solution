import { useEffect, useState } from "react";
import SlidingPanel from "react-sliding-side-panel";
import { toast, ToastOptions } from "react-toastify";

import MapWithSearch from "./MapWithSearch";
import { CctvDetails } from "./cctvs.types";
import PublicCctvFootages from "./PublicCctvFootages";
import { getCctvs } from "./cctvsApi";

import "./publicctvs.css";

const PublicCCTVs = () => {
  const [shownCctvs, setShownCctvs] = useState<CctvDetails[]>([]);
  const [showMapDrawer, setShowMapDrawer] = useState<boolean>(false);

  const addFootageToScreen = (cctv: CctvDetails) => {
    const footageToastOptions: ToastOptions = {
      position: "bottom-left",
      autoClose: 2000,
    };
    if (shownCctvs.find((shownCctv) => shownCctv.id === cctv.id)) {
      toast.warn("Already added !", footageToastOptions);
    } else {
      setShownCctvs([...shownCctvs, cctv]);
      toast.success("Added footage", footageToastOptions);
    }
    // closeMapDrawer();
  };

  const toggleMapDrawer = () =>
    setShowMapDrawer((alreadyShown) => !alreadyShown);
  const closeMapDrawer = () => setShowMapDrawer(false);

  // // Dev mode
  // useEffect(() => {
  //   getCctvs().then((cctvs) => setShownCctvs(cctvs.slice(0, 2)));
  // }, []);

  return (
    <div className="pt-3 public-cctvs-container">
      {shownCctvs.length == 0 ? (
        <MapWithSearch onFootageSelected={addFootageToScreen} />
      ) : (
        <>
          <PublicCctvFootages
            cctvs={shownCctvs}
            onToggleMapDrawer={toggleMapDrawer}
          />
          <SlidingPanel
            type={"right"}
            isOpen={showMapDrawer}
            size={70}
            backdropClicked={closeMapDrawer}
            onClose={closeMapDrawer}
          >
            <MapWithSearch drawerMode onFootageSelected={addFootageToScreen} />
          </SlidingPanel>
        </>
      )}
    </div>
  );
};

export default PublicCCTVs;
