Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6E257127B4A
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Dec 2019 13:51:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727422AbfLTMvi (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 20 Dec 2019 07:51:38 -0500
Received: from paleale.coelho.fi ([176.9.41.70]:54066 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727413AbfLTMvh (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 20 Dec 2019 07:51:37 -0500
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.92.2)
        (envelope-from <luca@coelho.fi>)
        id 1iiHkl-0007lx-6f; Fri, 20 Dec 2019 14:51:35 +0200
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Fri, 20 Dec 2019 14:51:18 +0200
Message-Id: <20191220125124.1315679-6-luca@coelho.fi>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191220125124.1315679-1-luca@coelho.fi>
References: <20191220125124.1315679-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.2
Subject: [PATCH 05/11] iwlwifi: mvm: add support for responder config command version 7
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Avraham Stern <avraham.stern@intel.com>

The new API requires the driver to config the supported frame format
(legacy, HT, VHT etc.).

Signed-off-by: Avraham Stern <avraham.stern@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 .../wireless/intel/iwlwifi/fw/api/location.h  | 40 +++++++-
 .../intel/iwlwifi/mvm/ftm-responder.c         | 95 +++++++++++++++----
 2 files changed, 113 insertions(+), 22 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/location.h b/drivers/net/wireless/intel/iwlwifi/fw/api/location.h
index a51fda4c9588..a0d6802c2715 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/location.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/location.h
@@ -240,7 +240,7 @@ enum iwl_tof_responder_cfg_flags {
 };
 
 /**
- * struct iwl_tof_responder_config_cmd - ToF AP mode (for debug)
+ * struct iwl_tof_responder_config_cmd_v6 - ToF AP mode (for debug)
  * @cmd_valid_fields: &iwl_tof_responder_cmd_valid_field
  * @responder_cfg_flags: &iwl_tof_responder_cfg_flags
  * @bandwidth: current AP Bandwidth: &enum iwl_tof_bandwidth
@@ -258,7 +258,7 @@ enum iwl_tof_responder_cfg_flags {
  * @bssid: Current AP BSSID
  * @reserved2: reserved
  */
-struct iwl_tof_responder_config_cmd {
+struct iwl_tof_responder_config_cmd_v6 {
 	__le32 cmd_valid_fields;
 	__le32 responder_cfg_flags;
 	u8 bandwidth;
@@ -274,6 +274,42 @@ struct iwl_tof_responder_config_cmd {
 	__le16 reserved2;
 } __packed; /* TOF_RESPONDER_CONFIG_CMD_API_S_VER_6 */
 
+/**
+ * struct iwl_tof_responder_config_cmd - ToF AP mode (for debug)
+ * @cmd_valid_fields: &iwl_tof_responder_cmd_valid_field
+ * @responder_cfg_flags: &iwl_tof_responder_cfg_flags
+ * @format_bw: bits 0 - 3: &enum iwl_location_frame_format.
+ *             bits 4 - 7: &enum iwl_location_bw.
+ * @rate: current AP rate
+ * @channel_num: current AP Channel
+ * @ctrl_ch_position: coding of the control channel position relative to
+ *	the center frequency, see iwl_mvm_get_ctrl_pos()
+ * @sta_id: index of the AP STA when in AP mode
+ * @reserved1: reserved
+ * @toa_offset: Artificial addition [pSec] for the ToA - to be used for debug
+ *	purposes, simulating station movement by adding various values
+ *	to this field
+ * @common_calib: XVT: common calibration value
+ * @specific_calib: XVT: specific calibration value
+ * @bssid: Current AP BSSID
+ * @reserved2: reserved
+ */
+struct iwl_tof_responder_config_cmd {
+	__le32 cmd_valid_fields;
+	__le32 responder_cfg_flags;
+	u8 format_bw;
+	u8 rate;
+	u8 channel_num;
+	u8 ctrl_ch_position;
+	u8 sta_id;
+	u8 reserved1;
+	__le16 toa_offset;
+	__le16 common_calib;
+	__le16 specific_calib;
+	u8 bssid[ETH_ALEN];
+	__le16 reserved2;
+} __packed; /* TOF_RESPONDER_CONFIG_CMD_API_S_VER_6 */
+
 #define IWL_LCI_CIVIC_IE_MAX_SIZE	400
 
 /**
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/ftm-responder.c b/drivers/net/wireless/intel/iwlwifi/mvm/ftm-responder.c
index 1513b8b4062f..834564198409 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/ftm-responder.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/ftm-responder.c
@@ -6,7 +6,7 @@
  * GPL LICENSE SUMMARY
  *
  * Copyright(c) 2015 - 2017 Intel Deutschland GmbH
- * Copyright (C) 2018 Intel Corporation
+ * Copyright (C) 2018 - 2019 Intel Corporation
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of version 2 of the GNU General Public License as
@@ -27,7 +27,7 @@
  * BSD LICENSE
  *
  * Copyright(c) 2015 - 2017 Intel Deutschland GmbH
- * Copyright (C) 2018 Intel Corporation
+ * Copyright (C) 2018 - 2019 Intel Corporation
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
@@ -62,12 +62,72 @@
 #include "mvm.h"
 #include "constants.h"
 
+static int iwl_mvm_ftm_responder_set_bw_v1(struct cfg80211_chan_def *chandef,
+					   u8 *bw, u8 *ctrl_ch_position)
+{
+	switch (chandef->width) {
+	case NL80211_CHAN_WIDTH_20_NOHT:
+		*bw = IWL_TOF_BW_20_LEGACY;
+		break;
+	case NL80211_CHAN_WIDTH_20:
+		*bw = IWL_TOF_BW_20_HT;
+		break;
+	case NL80211_CHAN_WIDTH_40:
+		*bw = IWL_TOF_BW_40;
+		*ctrl_ch_position = iwl_mvm_get_ctrl_pos(chandef);
+		break;
+	case NL80211_CHAN_WIDTH_80:
+		*bw = IWL_TOF_BW_80;
+		*ctrl_ch_position = iwl_mvm_get_ctrl_pos(chandef);
+		break;
+	default:
+		return -ENOTSUPP;
+	}
+
+	return 0;
+}
+
+static int iwl_mvm_ftm_responder_set_bw_v2(struct cfg80211_chan_def *chandef,
+					   u8 *format_bw,
+					   u8 *ctrl_ch_position)
+{
+	switch (chandef->width) {
+	case NL80211_CHAN_WIDTH_20_NOHT:
+		*format_bw = IWL_LOCATION_FRAME_FORMAT_LEGACY;
+		*format_bw |= IWL_LOCATION_BW_20MHZ << LOCATION_BW_POS;
+		break;
+	case NL80211_CHAN_WIDTH_20:
+		*format_bw = IWL_LOCATION_FRAME_FORMAT_HT;
+		*format_bw |= IWL_LOCATION_BW_20MHZ << LOCATION_BW_POS;
+		break;
+	case NL80211_CHAN_WIDTH_40:
+		*format_bw = IWL_LOCATION_FRAME_FORMAT_HT;
+		*format_bw |= IWL_LOCATION_BW_40MHZ << LOCATION_BW_POS;
+		*ctrl_ch_position = iwl_mvm_get_ctrl_pos(chandef);
+		break;
+	case NL80211_CHAN_WIDTH_80:
+		*format_bw = IWL_LOCATION_FRAME_FORMAT_VHT;
+		*format_bw |= IWL_LOCATION_BW_80MHZ << LOCATION_BW_POS;
+		*ctrl_ch_position = iwl_mvm_get_ctrl_pos(chandef);
+		break;
+	default:
+		return -ENOTSUPP;
+	}
+
+	return 0;
+}
+
 static int
 iwl_mvm_ftm_responder_cmd(struct iwl_mvm *mvm,
 			  struct ieee80211_vif *vif,
 			  struct cfg80211_chan_def *chandef)
 {
 	struct iwl_mvm_vif *mvmvif = iwl_mvm_vif_from_mac80211(vif);
+	/*
+	 * The command structure is the same for versions 6 and 7, (only the
+	 * field interpretation is different), so the same struct can be use
+	 * for all cases.
+	 */
 	struct iwl_tof_responder_config_cmd cmd = {
 		.channel_num = chandef->chan->hw_value,
 		.cmd_valid_fields =
@@ -76,27 +136,22 @@ iwl_mvm_ftm_responder_cmd(struct iwl_mvm *mvm,
 				    IWL_TOF_RESPONDER_CMD_VALID_STA_ID),
 		.sta_id = mvmvif->bcast_sta.sta_id,
 	};
+	u8 cmd_ver = iwl_mvm_lookup_cmd_ver(mvm->fw, LOCATION_GROUP,
+					    TOF_RESPONDER_CONFIG_CMD);
+	int err;
 
 	lockdep_assert_held(&mvm->mutex);
 
-	switch (chandef->width) {
-	case NL80211_CHAN_WIDTH_20_NOHT:
-		cmd.bandwidth = IWL_TOF_BW_20_LEGACY;
-		break;
-	case NL80211_CHAN_WIDTH_20:
-		cmd.bandwidth = IWL_TOF_BW_20_HT;
-		break;
-	case NL80211_CHAN_WIDTH_40:
-		cmd.bandwidth = IWL_TOF_BW_40;
-		cmd.ctrl_ch_position = iwl_mvm_get_ctrl_pos(chandef);
-		break;
-	case NL80211_CHAN_WIDTH_80:
-		cmd.bandwidth = IWL_TOF_BW_80;
-		cmd.ctrl_ch_position = iwl_mvm_get_ctrl_pos(chandef);
-		break;
-	default:
-		WARN_ON(1);
-		return -EINVAL;
+	if (cmd_ver == 7)
+		err = iwl_mvm_ftm_responder_set_bw_v2(chandef, &cmd.format_bw,
+						      &cmd.ctrl_ch_position);
+	else
+		err = iwl_mvm_ftm_responder_set_bw_v1(chandef, &cmd.format_bw,
+						      &cmd.ctrl_ch_position);
+
+	if (err) {
+		IWL_ERR(mvm, "Failed to set responder bandwidth\n");
+		return err;
 	}
 
 	memcpy(cmd.bssid, vif->addr, ETH_ALEN);
-- 
2.24.0

