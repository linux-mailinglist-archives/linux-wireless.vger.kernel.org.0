Return-Path: <linux-wireless+bounces-28805-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B5DBC47DB8
	for <lists+linux-wireless@lfdr.de>; Mon, 10 Nov 2025 17:18:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4257E1895309
	for <lists+linux-wireless@lfdr.de>; Mon, 10 Nov 2025 16:10:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4361272E56;
	Mon, 10 Nov 2025 16:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Uv1PlLfO"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C65A7283C83
	for <linux-wireless@vger.kernel.org>; Mon, 10 Nov 2025 16:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762790944; cv=none; b=qTuZa5nc1y1se11NXTml7jKFV5G0IsNP8wRDZDad+QJftvhFKIpJ06dTGnV9PkiCGVPaYtqbdZ8CvnRF2lXxxa5P1EMoK9nH3aDY5cEB2/MHCJCmt56rnprBJjWaYCz3TKUvY/e0SA56S9Sk5FwHJ6rVO7AadAneKXwXEviVEA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762790944; c=relaxed/simple;
	bh=B4bZCkzj62fTbCf1hnm6OZYs27hSgmsPPJRNKROH5no=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OeLln6ZYcyWE/No2gHCwxgxXDYLLRJ87r54e0tOe1+CL/cJXHyrIfsYHZdKoMw4npZu4P1a0PjY0AJfs3du86RhLs9ZAcAYEh/B9nKNg4zV0lz0ZCc3W74dF4PYbplOlCFmTRTRBUmuW8zx0NifAZk6BVNeIJDCyVzZmSC0CjsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Uv1PlLfO; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762790943; x=1794326943;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=B4bZCkzj62fTbCf1hnm6OZYs27hSgmsPPJRNKROH5no=;
  b=Uv1PlLfO/EomyW99RrARRcN7VSwoeBumKQFYOmMbIo9ZiLCetWso2lb1
   hElcqooIVEnv70xlN1+iJm0o+ixmdOYXM6d32CQCS5j+5Ba0WTzHP0mpd
   PbU+rSkbARy9YkAjVcOcRfxmimyf6GgyppaQ3dBzAakGFYX9cMy8bcwVN
   KGpfn6J3+xjP5orM9+xC82ppFnjC5sSkZYLwlrbUqjfcOGH3TPBONKtaE
   ftaolx5Bx9us7u+k1ZDUjVsfP/ZjaH0Y6MdgMdSTqDpg0qFQivo671o3Q
   GjN70rolI4j76dUpyjFcPZR+YQhSqKwSAcYMxfqASOyG+FSUSLOplZg+o
   w==;
X-CSE-ConnectionGUID: Y5XVPbMkT7GPFVD8/Waniw==
X-CSE-MsgGUID: y53od4esSmOh8rOwdSS5Hg==
X-IronPort-AV: E=McAfee;i="6800,10657,11609"; a="64725165"
X-IronPort-AV: E=Sophos;i="6.19,294,1754982000"; 
   d="scan'208";a="64725165"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2025 08:09:03 -0800
X-CSE-ConnectionGUID: xVtu7eWcSuGb7hstYP+3IQ==
X-CSE-MsgGUID: 1j30wJgRSDm3ETbySWn3Cw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,294,1754982000"; 
   d="scan'208";a="188877167"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2025 08:09:02 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Ilan Peer <ilan.peer@intel.com>
Subject: [PATCH iwlwifi-next v2 3/6] wifi: iwlwifi: mld: Declare support for NAN capabilities
Date: Mon, 10 Nov 2025 18:08:47 +0200
Message-Id: <20251110180612.eb49cb2172ce.Iaf59884242cb52351e24cb0711875851b5c863f8@changeid>
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

And notify cfg80211 about NAN cluster events and DW end events.

Signed-off-by: Ilan Peer <ilan.peer@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 .../net/wireless/intel/iwlwifi/mld/mac80211.c | 16 +++++
 drivers/net/wireless/intel/iwlwifi/mld/nan.c  | 71 ++++++++++++++++++-
 drivers/net/wireless/intel/iwlwifi/mld/nan.h  |  6 ++
 .../net/wireless/intel/iwlwifi/mld/notif.c    | 11 +--
 .../net/wireless/intel/iwlwifi/mld/notif.h    |  1 +
 5 files changed, 99 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mld/mac80211.c b/drivers/net/wireless/intel/iwlwifi/mld/mac80211.c
index 357e1e80bdc5..9a58f2751d4e 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/mac80211.c
@@ -344,6 +344,22 @@ static void iwl_mac_hw_set_wiphy(struct iwl_mld *mld)
 		if (mld->nvm_data->bands[NL80211_BAND_5GHZ].n_channels)
 			hw->wiphy->nan_supported_bands |=
 				BIT(NL80211_BAND_5GHZ);
+
+		hw->wiphy->nan_capa.flags = WIPHY_NAN_FLAGS_CONFIGURABLE_SYNC |
+					    WIPHY_NAN_FLAGS_USERSPACE_DE;
+
+		hw->wiphy->nan_capa.op_mode = NAN_OP_MODE_PHY_MODE_MASK |
+					      NAN_OP_MODE_80P80MHZ |
+					      NAN_OP_MODE_160MHZ;
+
+		/* Support 2 antenna's for Tx and Rx */
+		hw->wiphy->nan_capa.n_antennas = 0x22;
+
+		/* Maximal channel switch time is 4 msec */
+		hw->wiphy->nan_capa.max_channel_switch_time = 4;
+		hw->wiphy->nan_capa.dev_capabilities =
+			NAN_DEV_CAPA_EXT_KEY_ID_SUPPORTED |
+			NAN_DEV_CAPA_NDPE_SUPPORTED;
 	} else {
 		wiphy->iface_combinations = iwl_mld_iface_combinations;
 		/* Do not include NAN combinations */
diff --git a/drivers/net/wireless/intel/iwlwifi/mld/nan.c b/drivers/net/wireless/intel/iwlwifi/mld/nan.c
index 0bce7a48ab2c..5104ba75b38c 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/nan.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/nan.c
@@ -131,6 +131,12 @@ int iwl_mld_stop_nan(struct ieee80211_hw *hw,
 	iwl_mld_flush_link_sta_txqs(mld, mld_vif->aux_sta.sta_id);
 	iwl_mld_remove_aux_sta(mld, vif);
 
+	/* cancel based on object type being NAN, as the NAN objects do
+	 * not have a unique identifier associated with them
+	 */
+	iwl_mld_cancel_notifications_of_object(mld,
+					       IWL_MLD_OBJECT_TYPE_NAN,
+					       0);
 	return 0;
 }
 
@@ -138,10 +144,43 @@ void iwl_mld_handle_nan_cluster_notif(struct iwl_mld *mld,
 				      struct iwl_rx_packet *pkt)
 {
 	struct iwl_nan_cluster_notif *notif = (void *)pkt->data;
+	struct wireless_dev *wdev = mld->nan_device_vif ?
+		ieee80211_vif_to_wdev(mld->nan_device_vif) : NULL;
+	bool new_cluster = !!(notif->flags &
+			      IWL_NAN_CLUSTER_NOTIF_FLAG_NEW_CLUSTER);
+	u8 cluster_id[ETH_ALEN] __aligned(2) = {
+		0x50, 0x6f, 0x9a, 0x01, 0x00, 0x00
+	};
+	u16 id = le16_to_cpu(notif->cluster_id);
 
 	IWL_DEBUG_INFO(mld,
 		       "NAN: cluster event: cluster_id=0x%x, flags=0x%x\n",
-		       le16_to_cpu(notif->cluster_id), notif->flags);
+		       id, notif->flags);
+
+	if (IWL_FW_CHECK(mld, !wdev, "NAN: cluster event without wdev\n"))
+		return;
+
+	if (IWL_FW_CHECK(mld, !ieee80211_vif_nan_started(mld->nan_device_vif),
+			 "NAN: cluster event without NAN started\n"))
+		return;
+
+	*((u16 *)(cluster_id + 4)) = id;
+
+	cfg80211_nan_cluster_joined(wdev, cluster_id, new_cluster, GFP_KERNEL);
+}
+
+bool iwl_mld_cancel_nan_cluster_notif(struct iwl_mld *mld,
+				      struct iwl_rx_packet *pkt,
+				      u32 obj_id)
+{
+	return true;
+}
+
+bool iwl_mld_cancel_nan_dw_end_notif(struct iwl_mld *mld,
+				     struct iwl_rx_packet *pkt,
+				     u32 obj_id)
+{
+	return true;
 }
 
 void iwl_mld_handle_nan_dw_end_notif(struct iwl_mld *mld,
@@ -151,10 +190,16 @@ void iwl_mld_handle_nan_dw_end_notif(struct iwl_mld *mld,
 	struct iwl_mld_vif *mld_vif = mld->nan_device_vif ?
 		iwl_mld_vif_from_mac80211(mld->nan_device_vif) :
 		NULL;
+	struct wireless_dev *wdev;
+	struct ieee80211_channel *chan;
 
 	IWL_INFO(mld, "NAN: DW end: band=%u\n", notif->band);
 
-	if (!mld_vif)
+	if (IWL_FW_CHECK(mld, !mld_vif, "NAN: DW end without mld_vif\n"))
+		return;
+
+	if (IWL_FW_CHECK(mld, !ieee80211_vif_nan_started(mld->nan_device_vif),
+			 "NAN: DW end without NAN started\n"))
 		return;
 
 	if (WARN_ON(mld_vif->aux_sta.sta_id == IWL_INVALID_STA))
@@ -164,4 +209,26 @@ void iwl_mld_handle_nan_dw_end_notif(struct iwl_mld *mld,
 		       mld_vif->aux_sta.sta_id);
 
 	iwl_mld_flush_link_sta_txqs(mld, mld_vif->aux_sta.sta_id);
+
+	/* TODO: currently the notification specified the band on which the DW
+	 * ended. Need to change that to the actual channel on which the next DW
+	 * will be started.
+	 */
+	switch (notif->band) {
+	case IWL_NAN_BAND_2GHZ:
+		chan = ieee80211_get_channel(mld->wiphy, 2437);
+		break;
+	case IWL_NAN_BAND_5GHZ:
+		/* TODO: use the actual channel */
+		chan = ieee80211_get_channel(mld->wiphy, 5745);
+		break;
+	default:
+		IWL_FW_CHECK(mld, false,
+			     "NAN: Invalid band %u in DW end notif\n",
+			     notif->band);
+		return;
+	}
+
+	wdev = ieee80211_vif_to_wdev(mld->nan_device_vif);
+	cfg80211_next_nan_dw_notif(wdev, chan, GFP_KERNEL);
 }
diff --git a/drivers/net/wireless/intel/iwlwifi/mld/nan.h b/drivers/net/wireless/intel/iwlwifi/mld/nan.h
index c7b621393655..97607b74a177 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/nan.h
+++ b/drivers/net/wireless/intel/iwlwifi/mld/nan.h
@@ -16,3 +16,9 @@ void iwl_mld_handle_nan_cluster_notif(struct iwl_mld *mld,
 				      struct iwl_rx_packet *pkt);
 void iwl_mld_handle_nan_dw_end_notif(struct iwl_mld *mld,
 				     struct iwl_rx_packet *pkt);
+bool iwl_mld_cancel_nan_cluster_notif(struct iwl_mld *mld,
+				      struct iwl_rx_packet *pkt,
+				      u32 obj_id);
+bool iwl_mld_cancel_nan_dw_end_notif(struct iwl_mld *mld,
+				     struct iwl_rx_packet *pkt,
+				     u32 obj_id);
diff --git a/drivers/net/wireless/intel/iwlwifi/mld/notif.c b/drivers/net/wireless/intel/iwlwifi/mld/notif.c
index eedb4818c647..555542dc5e37 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/notif.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/notif.c
@@ -111,6 +111,9 @@ static bool iwl_mld_cancel_##name##_notif(struct iwl_mld *mld,			\
 #define RX_HANDLER_OF_FTM_REQ(_grp, _cmd, _name)				\
 	RX_HANDLER_OF_OBJ(_grp, _cmd, _name, FTM_REQ)
 
+#define RX_HANDLER_OF_NAN(_grp, _cmd, _name)				\
+	RX_HANDLER_OF_OBJ(_grp, _cmd, _name, NAN)
+
 static void iwl_mld_handle_mfuart_notif(struct iwl_mld *mld,
 					struct iwl_rx_packet *pkt)
 {
@@ -461,10 +464,10 @@ const struct iwl_rx_handler iwl_mld_rx_handlers[] = {
 			   beacon_filter_notif)
 	RX_HANDLER_OF_FTM_REQ(LOCATION_GROUP, TOF_RANGE_RESPONSE_NOTIF,
 			      ftm_resp_notif)
-	RX_HANDLER_NO_OBJECT(MAC_CONF_GROUP, NAN_JOINED_CLUSTER_NOTIF,
-			     nan_cluster_notif, RX_HANDLER_ASYNC)
-	RX_HANDLER_NO_OBJECT(MAC_CONF_GROUP, NAN_DW_END_NOTIF,
-			     nan_dw_end_notif, RX_HANDLER_ASYNC)
+	RX_HANDLER_OF_NAN(MAC_CONF_GROUP, NAN_JOINED_CLUSTER_NOTIF,
+			  nan_cluster_notif)
+	RX_HANDLER_OF_NAN(MAC_CONF_GROUP, NAN_DW_END_NOTIF,
+			  nan_dw_end_notif)
 };
 EXPORT_SYMBOL_IF_IWLWIFI_KUNIT(iwl_mld_rx_handlers);
 
diff --git a/drivers/net/wireless/intel/iwlwifi/mld/notif.h b/drivers/net/wireless/intel/iwlwifi/mld/notif.h
index adcdd9dec192..373c1a90d98e 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/notif.h
+++ b/drivers/net/wireless/intel/iwlwifi/mld/notif.h
@@ -25,6 +25,7 @@ enum iwl_mld_object_type {
 	IWL_MLD_OBJECT_TYPE_ROC,
 	IWL_MLD_OBJECT_TYPE_SCAN,
 	IWL_MLD_OBJECT_TYPE_FTM_REQ,
+	IWL_MLD_OBJECT_TYPE_NAN,
 };
 
 void iwl_mld_cancel_notifications_of_object(struct iwl_mld *mld,
-- 
2.34.1


