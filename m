Return-Path: <linux-wireless+bounces-28806-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 89133C47DCD
	for <lists+linux-wireless@lfdr.de>; Mon, 10 Nov 2025 17:18:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BE9344F7DB3
	for <lists+linux-wireless@lfdr.de>; Mon, 10 Nov 2025 16:10:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D937E27E054;
	Mon, 10 Nov 2025 16:09:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YGXYv3ip"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9F5028466C
	for <linux-wireless@vger.kernel.org>; Mon, 10 Nov 2025 16:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762790946; cv=none; b=SxGTpVw6Z6copm6hXlCJbPxSREXLT1N2vFQRCw5hFA5oIhF3s3z6C7RM32B14Ny4TlfoH6yozLXxjFRgSHJbLgjPTMNa6J5aLMqOoyiyEXLKCWvlbReo+miAitQ7JxYJaeQTeY63yGlQd8LuOLbf8gCODjI7//EuC9ikZZXJh+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762790946; c=relaxed/simple;
	bh=iy2I9I4+wD8Bngpxa5S86Sy8rGsTOQ/FDqms/ovf9BE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rb6s0VwEQJu7OLzwySfWXoQTOkfA0Zcan4HiQf7aYb7vXDsZWciTa4RZlTrN4X4eeoJ1EEzuIeO1TMAu2BC53DoMTKHIlalUnR+7dHUJc326xVf4rn+aOj6VFmubneQZPJYHaT/L9qImCeQLhMIy36j4s+BlKxMSiOw70hFy23g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YGXYv3ip; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762790945; x=1794326945;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=iy2I9I4+wD8Bngpxa5S86Sy8rGsTOQ/FDqms/ovf9BE=;
  b=YGXYv3ipeaFewovw7gz8I9o/op1txJFDK/C/y6BfWOx82OuXHbEAkJWC
   xKzeToZPS3IbX7Odmb8VsJgg/lLfzlywZMCXyPxHS6tgoW5+8g/fwVVtZ
   bcJgqpZCljY3LB7fwwn1KN46veS7jNEHtKozpQE0kHqCctptAQ6B3FvPG
   GBf5P94SHVRco/04xZGn5ZsfYo7Rf5TdPKuFlm6pkzS9Avr3MK/jw4fpx
   rITiKym1K9mXw9KDQfT3q3CWUhPaIN9u6BIJw9u4EJljwESLVniT/Loz2
   8146/bwZ/T36HLOqZfxkIVYYuQHqgdZ0hQT/tkKQyXEbFU3k7hoPm1A9R
   Q==;
X-CSE-ConnectionGUID: ePH3so90RQ6YQeEUPDsCuw==
X-CSE-MsgGUID: Dp4jcoLHRlaoMEfYbBthHw==
X-IronPort-AV: E=McAfee;i="6800,10657,11609"; a="64725169"
X-IronPort-AV: E=Sophos;i="6.19,294,1754982000"; 
   d="scan'208";a="64725169"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2025 08:09:05 -0800
X-CSE-ConnectionGUID: 1fmoVi6xT9+eRFh4GCk/zA==
X-CSE-MsgGUID: WvYSMeRcS5mMxrDDk+810A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,294,1754982000"; 
   d="scan'208";a="188877178"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2025 08:09:03 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Ilan Peer <ilan.peer@intel.com>
Subject: [PATCH iwlwifi-next v2 4/6] wifi: iwlwifi: mld: Extend the NAN configuration
Date: Mon, 10 Nov 2025 18:08:48 +0200
Message-Id: <20251110180612.5353d9520f0f.Ie41dcea815afbb5da6cc870ea50a271c18f66639@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251110160850.366979-1-miriam.rachel.korenblit@intel.com>
References: <20251110160850.366979-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Ilan Peer <ilan.peer@intel.com>

Configure the FW based on the NAN cluster configuration provided
by higher layers.

Signed-off-by: Ilan Peer <ilan.peer@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mld/nan.c | 131 +++++++++++--------
 1 file changed, 79 insertions(+), 52 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mld/nan.c b/drivers/net/wireless/intel/iwlwifi/mld/nan.c
index 5104ba75b38c..6cdee2aa0f50 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/nan.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/nan.c
@@ -11,30 +11,30 @@
 #define IWL_NAN_RSSI_CLOSE 55
 #define IWL_NAN_RSSI_MIDDLE 70
 
-/* possible discovery channels for the 5 GHz band*/
-#define IWL_NAN_CHANNEL_UNII1 44
-#define IWL_NAN_CHANNEL_UNII3 149
-
 bool iwl_mld_nan_supported(struct iwl_mld *mld)
 {
 	return fw_has_capa(&mld->fw->ucode_capa,
 			   IWL_UCODE_TLV_CAPA_NAN_SYNC_SUPPORT);
 }
 
-static bool iwl_mld_nan_can_beacon(struct ieee80211_vif *vif,
-				   enum nl80211_band band, u8 channel)
+static int iwl_mld_nan_send_config_cmd(struct iwl_mld *mld,
+				       struct iwl_nan_config_cmd *cmd,
+				       u8 *beacon_data, size_t beacon_data_len)
 {
-	struct wiphy *wiphy = ieee80211_vif_to_wdev(vif)->wiphy;
-	int freq = ieee80211_channel_to_frequency(channel, band);
-	struct ieee80211_channel *chan = ieee80211_get_channel(wiphy,
-							       freq);
-	struct cfg80211_chan_def def;
+	struct iwl_host_cmd hcmd = {
+		.id = WIDE_ID(MAC_CONF_GROUP, NAN_CFG_CMD),
+	};
 
-	if (!chan)
-		return false;
+	hcmd.len[0] = sizeof(*cmd);
+	hcmd.data[0] = cmd;
+
+	if (beacon_data_len) {
+		hcmd.len[1] = beacon_data_len;
+		hcmd.data[1] = beacon_data;
+		hcmd.dataflags[1] = IWL_HCMD_DFL_DUP;
+	}
 
-	cfg80211_chandef_create(&def, chan, NL80211_CHAN_NO_HT);
-	return cfg80211_reg_can_beacon(wiphy, &def, vif->type);
+	return iwl_mld_send_cmd(mld, &hcmd);
 }
 
 int iwl_mld_start_nan(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
@@ -45,21 +45,8 @@ int iwl_mld_start_nan(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 	struct iwl_mld_int_sta *aux_sta = &mld_vif->aux_sta;
 	struct iwl_nan_config_cmd cmd = {
 		.action = cpu_to_le32(FW_CTXT_ACTION_ADD),
-		.discovery_beacon_interval =
-			cpu_to_le32(IWL_NAN_DISOVERY_BEACON_INTERNVAL_TU),
-		.band_config = {
-			{
-				.rssi_close = IWL_NAN_RSSI_CLOSE,
-				.rssi_middle = IWL_NAN_RSSI_MIDDLE,
-				.dw_interval = 1,
-			},
-			{
-				.rssi_close = IWL_NAN_RSSI_CLOSE,
-				.rssi_middle = IWL_NAN_RSSI_MIDDLE,
-				.dw_interval = 1,
-			},
-		},
 	};
+	u8 *data __free(kfree) = NULL;
 	int ret;
 
 	lockdep_assert_wiphy(mld->wiphy);
@@ -68,25 +55,66 @@ int iwl_mld_start_nan(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 
 	ether_addr_copy(cmd.nmi_addr, vif->addr);
 	cmd.master_pref = conf->master_pref;
-	cmd.flags = IWL_NAN_FLAG_DW_END_NOTIF_ENABLED;
-
-	if (WARN_ON(!(conf->bands & BIT(NL80211_BAND_2GHZ))))
-		return -EINVAL;
-
-	if (conf->bands & BIT(NL80211_BAND_5GHZ)) {
-		if (iwl_mld_nan_can_beacon(vif, NL80211_BAND_5GHZ,
-					   IWL_NAN_CHANNEL_UNII1)) {
-			cmd.hb_channel = IWL_NAN_CHANNEL_UNII1;
-		} else if (iwl_mld_nan_can_beacon(vif, NL80211_BAND_5GHZ,
-						  IWL_NAN_CHANNEL_UNII3)) {
-			cmd.hb_channel = IWL_NAN_CHANNEL_UNII3;
-		} else {
-			IWL_ERR(mld, "NAN: Can't beacon on 5 GHz band\n");
-			ret = -EINVAL;
-		}
-	} else {
-		memset(&cmd.band_config[IWL_NAN_BAND_5GHZ], 0,
-		       sizeof(cmd.band_config[0]));
+
+	if (conf->cluster_id)
+		cmd.cluster_id =
+			cpu_to_le16(*(const u16 *)(conf->cluster_id + 4));
+
+	cmd.scan_period = conf->scan_period < 255 ? conf->scan_period : 255;
+	cmd.dwell_time =
+		conf->scan_dwell_time < 255 ? conf->scan_dwell_time : 255;
+
+	if (conf->discovery_beacon_interval)
+		cmd.discovery_beacon_interval =
+			cpu_to_le32(conf->discovery_beacon_interval);
+	else
+		cmd.discovery_beacon_interval =
+			cpu_to_le32(IWL_NAN_DISOVERY_BEACON_INTERNVAL_TU);
+
+	if (conf->enable_dw_notification)
+		cmd.flags = IWL_NAN_FLAG_DW_END_NOTIF_ENABLED;
+
+	/* 2 GHz band must be supported */
+	cmd.band_config[IWL_NAN_BAND_2GHZ].rssi_close =
+		abs(conf->band_cfgs[NL80211_BAND_2GHZ].rssi_close);
+	cmd.band_config[IWL_NAN_BAND_2GHZ].rssi_middle =
+		abs(conf->band_cfgs[NL80211_BAND_2GHZ].rssi_middle);
+	cmd.band_config[IWL_NAN_BAND_2GHZ].dw_interval =
+		conf->band_cfgs[NL80211_BAND_2GHZ].awake_dw_interval;
+
+	/* 5 GHz band operation is optional. Configure its operation if
+	 * supported. Note that conf->bands might be zero, so we need to check
+	 * the channel pointer, not the band mask.
+	 */
+	if (conf->band_cfgs[NL80211_BAND_5GHZ].chan) {
+		cmd.hb_channel =
+			conf->band_cfgs[NL80211_BAND_5GHZ].chan->hw_value;
+
+		cmd.band_config[IWL_NAN_BAND_5GHZ].rssi_close =
+			abs(conf->band_cfgs[NL80211_BAND_5GHZ].rssi_close);
+		cmd.band_config[IWL_NAN_BAND_5GHZ].rssi_middle =
+			abs(conf->band_cfgs[NL80211_BAND_5GHZ].rssi_middle);
+		cmd.band_config[IWL_NAN_BAND_5GHZ].dw_interval =
+			conf->band_cfgs[NL80211_BAND_5GHZ].awake_dw_interval;
+	}
+
+	if (conf->extra_nan_attrs_len || conf->vendor_elems_len) {
+		data = kmalloc(conf->extra_nan_attrs_len +
+			       conf->vendor_elems_len, GFP_KERNEL);
+		if (!data)
+			return -ENOMEM;
+
+		cmd.nan_attr_len = cpu_to_le32(conf->extra_nan_attrs_len);
+		cmd.nan_vendor_elems_len = cpu_to_le32(conf->vendor_elems_len);
+
+		if (conf->extra_nan_attrs_len)
+			memcpy(data, conf->extra_nan_attrs,
+			       conf->extra_nan_attrs_len);
+
+		if (conf->vendor_elems_len)
+			memcpy(data + conf->extra_nan_attrs_len,
+			       conf->vendor_elems,
+			       conf->vendor_elems_len);
 	}
 
 	ret = iwl_mld_add_aux_sta(mld, aux_sta);
@@ -95,10 +123,9 @@ int iwl_mld_start_nan(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 
 	cmd.sta_id = aux_sta->sta_id;
 
-	ret = iwl_mld_send_cmd_pdu(mld,
-				   WIDE_ID(MAC_CONF_GROUP, NAN_CFG_CMD),
-				   &cmd);
-
+	ret = iwl_mld_nan_send_config_cmd(mld, &cmd, data,
+					  conf->extra_nan_attrs_len +
+					  conf->vendor_elems_len);
 	if (ret) {
 		IWL_ERR(mld, "Failed to start NAN. ret=%d\n", ret);
 		iwl_mld_remove_aux_sta(mld, vif);
-- 
2.34.1


