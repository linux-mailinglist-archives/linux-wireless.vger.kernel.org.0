Return-Path: <linux-wireless+bounces-25279-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E4D0B0208B
	for <lists+linux-wireless@lfdr.de>; Fri, 11 Jul 2025 17:35:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2DF427BA93F
	for <lists+linux-wireless@lfdr.de>; Fri, 11 Jul 2025 15:33:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FC4A2ED84D;
	Fri, 11 Jul 2025 15:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TdgVpVWz"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A9F62E88B1
	for <linux-wireless@vger.kernel.org>; Fri, 11 Jul 2025 15:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752248098; cv=none; b=RvDlAbzhs8S499I2w6ouimrvzkMTlNguQBsyIcPY1KwAEk8G3shzdLY8M34YQMYyON82dmiwOdPoTul6XQF9IBpYQ+y76uyIFO1BkCSlr82M9qCI14W7UNT7COGPFXd8q0oultmMu4/8cZdWHpUdloxc9+xrxG40nIIwT2kzu6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752248098; c=relaxed/simple;
	bh=ENDhATDHHPGN5xwAuh0DDXOyIDcMYp+1ECkAcdFd3fY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Qy4na8X5VsIINPMJ0i7cBHMqcyGXNAI0hIfLN2BnkmakzimlerSSeHew0L9FBbT25wVuzcxHBuW3J5TgIDX4kCSI4nYxMvipGJw7KlRiwX5lsfXltICf2n2vcVS5OeXbrbhWKghFsnvp6EaqqtQyC+q93Wz5GWI5E/bW7TUb7wA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TdgVpVWz; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752248097; x=1783784097;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ENDhATDHHPGN5xwAuh0DDXOyIDcMYp+1ECkAcdFd3fY=;
  b=TdgVpVWzwMGUos2nGddx+GM4OooVHtMn4coNz0P30rFFH4FdzTpA9QCt
   0aJy4N8JzCJNHvr211t4At+CpVvr4v/0g5pJfrJclRrgKoRL9DDWHMFNY
   jStb2hSRJHOLUJXCZ73sKDv+SdjzbudRpDXArmsCq/TRj4n17YWIHx6+v
   GSuKtzKZTZc7i0xnlXexST/BOiDh72csDuijKXtNxVKZ3xqMpbYRGN2mO
   p7jPqV2kO+NdkpBUAu2NYr3YkfX5Rjv/GUzlrMZPWTEBnwgCcdolT7xxE
   J8ad8FQE78lreLNTZ1wwvsWHcDyXMf0+jbRPDuRjjbTnWA7jEBT2ehPiR
   A==;
X-CSE-ConnectionGUID: YOLOQ5asR/arHu6imCTyjg==
X-CSE-MsgGUID: C+V74zxNQ8Wk8mAubAvFaA==
X-IronPort-AV: E=McAfee;i="6800,10657,11491"; a="54264154"
X-IronPort-AV: E=Sophos;i="6.16,304,1744095600"; 
   d="scan'208";a="54264154"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2025 08:34:55 -0700
X-CSE-ConnectionGUID: WG0pltj0RvW3LH4BVbAI2w==
X-CSE-MsgGUID: xfarrnl6QGmpI/7YPzpBAA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,304,1744095600"; 
   d="scan'208";a="156485096"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2025 08:34:53 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH iwlwifi-next 03/15] wifi: iwlwifi: mvm/mld: use average RSSI for beacons
Date: Fri, 11 Jul 2025 18:34:17 +0300
Message-Id: <20250711183056.324bfe7027ff.I160f947e7aab30e0110a7019ed46186e57c3de14@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250711153429.3417098-1-miriam.rachel.korenblit@intel.com>
References: <20250711153429.3417098-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

When connected to an AP, the PHY will typically be tuned to
a higher bandwidth than the beacons are transmitted on, as
they are normally only transmitted on 20 MHz. This can mean
that another STA is simultaneously transmitting on another
channel of the higher bandwidth, and apparently this energy
may be taken into account by the PHY, resulting in elevated
energy readings.

To work around this, track the firmware's corrected beacon
energy data and replace the RSSI in beacons by that. The
replacement happens for all beacons received in the context
of the current MAC or link (depending on FW version), in
which case the filters will drop all else. For a scan, which
is only tuning to 20 MHz channels, the MAC/link ID will be
one that isn't found (the AUX ID 4), and no correction will
be done (nor is it needed.)

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 .../wireless/intel/iwlwifi/fw/api/datapath.h  |  5 +
 .../net/wireless/intel/iwlwifi/fw/api/rx.h    | 24 ++++-
 drivers/net/wireless/intel/iwlwifi/mld/link.c | 20 ++++
 drivers/net/wireless/intel/iwlwifi/mld/link.h |  6 ++
 drivers/net/wireless/intel/iwlwifi/mld/mld.c  |  1 +
 .../net/wireless/intel/iwlwifi/mld/notif.c    |  4 +
 drivers/net/wireless/intel/iwlwifi/mld/rx.c   | 73 +++++++++++++--
 .../net/wireless/intel/iwlwifi/mvm/mac80211.c |  2 +
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h  |  6 ++
 drivers/net/wireless/intel/iwlwifi/mvm/ops.c  |  6 ++
 drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c | 91 +++++++++++++++++--
 11 files changed, 223 insertions(+), 15 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/datapath.h b/drivers/net/wireless/intel/iwlwifi/fw/api/datapath.h
index 9c88bb280609..6c8e6874a5e7 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/datapath.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/datapath.h
@@ -124,6 +124,11 @@ enum iwl_data_path_subcmd_ids {
 	 */
 	TLC_MNG_UPDATE_NOTIF = 0xF7,
 
+	/**
+	 * @BEACON_FILTER_IN_NOTIF: &struct iwl_beacon_filter_notif
+	 */
+	BEACON_FILTER_IN_NOTIF = 0xF8,
+
 	/**
 	 * @STA_PM_NOTIF: &struct iwl_mvm_pm_state_notification
 	 */
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/rx.h b/drivers/net/wireless/intel/iwlwifi/fw/api/rx.h
index 7cf6d6ac7430..d751789998ac 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/rx.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/rx.h
@@ -194,7 +194,9 @@ enum iwl_rx_mpdu_amsdu_info {
 };
 
 enum iwl_rx_mpdu_mac_phy_band {
+	/* whether or not this is MAC or LINK depends on the API */
 	IWL_RX_MPDU_MAC_PHY_BAND_MAC_MASK	= 0x0f,
+	IWL_RX_MPDU_MAC_PHY_BAND_LINK_MASK	= 0x0f,
 	IWL_RX_MPDU_MAC_PHY_BAND_PHY_MASK	= 0x30,
 	IWL_RX_MPDU_MAC_PHY_BAND_BAND_MASK	= 0xc0,
 };
@@ -671,7 +673,7 @@ struct iwl_rx_mpdu_desc {
 	 */
 	__le16 phy_info;
 	/**
-	 * @mac_phy_band: MAC ID, PHY ID, band;
+	 * @mac_phy_band: MAC/link ID, PHY ID, band;
 	 *	see &enum iwl_rx_mpdu_mac_phy_band
 	 */
 	u8 mac_phy_band;
@@ -1019,4 +1021,24 @@ struct iwl_rfh_queue_config {
 	struct iwl_rfh_queue_data data[];
 } __packed; /* RFH_QUEUE_CONFIG_API_S_VER_1 */
 
+/**
+ * struct iwl_beacon_filter_notif_v1 - beacon filter notification
+ * @average_energy: average energy for the received beacon
+ * @mac_id: MAC ID the beacon was received for
+ */
+struct iwl_beacon_filter_notif_v1 {
+	__le32 average_energy;
+	__le32 mac_id;
+} __packed; /* BEACON_FILTER_IN_NTFY_API_S_VER_1 */
+
+/**
+ * struct iwl_beacon_filter_notif - beacon filter notification
+ * @average_energy: average energy for the received beacon
+ * @link_id: link ID the beacon was received for
+ */
+struct iwl_beacon_filter_notif {
+	__le32 average_energy;
+	__le32 link_id;
+} __packed; /* BEACON_FILTER_IN_NTFY_API_S_VER_2 */
+
 #endif /* __iwl_fw_api_rx_h__ */
diff --git a/drivers/net/wireless/intel/iwlwifi/mld/link.c b/drivers/net/wireless/intel/iwlwifi/mld/link.c
index c65ac6ecbd1d..ff237f78a468 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/link.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/link.c
@@ -783,6 +783,7 @@ iwl_mld_init_link(struct iwl_mld *mld, struct ieee80211_bss_conf *link,
 {
 	mld_link->vif = link->vif;
 	mld_link->link_id = link->link_id;
+	mld_link->average_beacon_energy = 0;
 
 	iwl_mld_init_internal_sta(&mld_link->bcast_sta);
 	iwl_mld_init_internal_sta(&mld_link->mcast_sta);
@@ -1216,3 +1217,22 @@ unsigned int iwl_mld_get_link_grade(struct iwl_mld *mld,
 	return grade;
 }
 EXPORT_SYMBOL_IF_IWLWIFI_KUNIT(iwl_mld_get_link_grade);
+
+void iwl_mld_handle_beacon_filter_notif(struct iwl_mld *mld,
+					struct iwl_rx_packet *pkt)
+{
+	const struct iwl_beacon_filter_notif *notif = (const void *)pkt->data;
+	u32 link_id = le32_to_cpu(notif->link_id);
+	struct ieee80211_bss_conf *link_conf =
+		iwl_mld_fw_id_to_link_conf(mld, link_id);
+	struct iwl_mld_link *mld_link;
+
+	if (IWL_FW_CHECK(mld, !link_conf, "invalid link ID %d\n", link_id))
+		return;
+
+	mld_link = iwl_mld_link_from_mac80211(link_conf);
+	if (WARN_ON_ONCE(!mld_link))
+		return;
+
+	mld_link->average_beacon_energy = le32_to_cpu(notif->average_energy);
+}
diff --git a/drivers/net/wireless/intel/iwlwifi/mld/link.h b/drivers/net/wireless/intel/iwlwifi/mld/link.h
index 39f04aae5579..881823be07ba 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/link.h
+++ b/drivers/net/wireless/intel/iwlwifi/mld/link.h
@@ -41,6 +41,8 @@ struct iwl_probe_resp_data {
  * @mcast_sta: station used for multicast packets. Used in AP, GO and IBSS.
  * @mon_sta: station used for TX injection in monitor interface.
  * @link_id: over the air link ID
+ * @average_beacon_energy: average beacon energy for beacons received during
+ *	client connections
  * @ap_early_keys: The firmware cannot install keys before bcast/mcast STAs,
  *	but higher layers work differently, so we store the keys here for
  *	later installation.
@@ -85,6 +87,7 @@ struct iwl_mld_link {
 
 	/* we can only have 2 GTK + 2 IGTK + 2 BIGTK active at a time */
 	struct ieee80211_key_conf *ap_early_keys[6];
+	u32 average_beacon_energy;
 	bool silent_deactivation;
 	struct iwl_probe_resp_data __rcu *probe_resp_data;
 };
@@ -150,4 +153,7 @@ void iwl_mld_omi_ap_changed_bw(struct iwl_mld *mld,
 			       struct ieee80211_bss_conf *link_conf,
 			       enum ieee80211_sta_rx_bandwidth bw);
 
+void iwl_mld_handle_beacon_filter_notif(struct iwl_mld *mld,
+					struct iwl_rx_packet *pkt);
+
 #endif /* __iwl_mld_link_h__ */
diff --git a/drivers/net/wireless/intel/iwlwifi/mld/mld.c b/drivers/net/wireless/intel/iwlwifi/mld/mld.c
index 12682396bdc3..e7cbfb9009af 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/mld.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/mld.c
@@ -255,6 +255,7 @@ static const struct iwl_hcmd_names iwl_mld_data_path_names[] = {
 	HCMD_NAME(ESR_MODE_NOTIF),
 	HCMD_NAME(MONITOR_NOTIF),
 	HCMD_NAME(TLC_MNG_UPDATE_NOTIF),
+	HCMD_NAME(BEACON_FILTER_IN_NOTIF),
 	HCMD_NAME(MU_GROUP_MGMT_NOTIF),
 };
 
diff --git a/drivers/net/wireless/intel/iwlwifi/mld/notif.c b/drivers/net/wireless/intel/iwlwifi/mld/notif.c
index ff1a3b9079e2..4bfed90c30c5 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/notif.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/notif.c
@@ -351,6 +351,7 @@ CMD_VERSIONS(time_sync_confirm_notif,
 CMD_VERSIONS(omi_status_notif,
 	     CMD_VER_ENTRY(1, iwl_omi_send_status_notif))
 CMD_VERSIONS(ftm_resp_notif, CMD_VER_ENTRY(10, iwl_tof_range_rsp_ntfy))
+CMD_VERSIONS(beacon_filter_notif, CMD_VER_ENTRY(2, iwl_beacon_filter_notif))
 
 DEFINE_SIMPLE_CANCELLATION(session_prot, iwl_session_prot_notif, mac_link_id)
 DEFINE_SIMPLE_CANCELLATION(tlc, iwl_tlc_update_notif, sta_id)
@@ -368,6 +369,7 @@ DEFINE_SIMPLE_CANCELLATION(uapsd_misbehaving_ap, iwl_uapsd_misbehaving_ap_notif,
 			   mac_id)
 #define iwl_mld_cancel_omi_status_notif iwl_mld_always_cancel
 DEFINE_SIMPLE_CANCELLATION(ftm_resp, iwl_tof_range_rsp_ntfy, request_id)
+DEFINE_SIMPLE_CANCELLATION(beacon_filter, iwl_beacon_filter_notif, link_id)
 
 /**
  * DOC: Handlers for fw notifications
@@ -460,6 +462,8 @@ const struct iwl_rx_handler iwl_mld_rx_handlers[] = {
 			     time_sync_confirm_notif, RX_HANDLER_ASYNC)
 	RX_HANDLER_OF_LINK(DATA_PATH_GROUP, OMI_SEND_STATUS_NOTIF,
 			   omi_status_notif)
+	RX_HANDLER_OF_LINK(DATA_PATH_GROUP, BEACON_FILTER_IN_NOTIF,
+			   beacon_filter_notif)
 	RX_HANDLER_OF_FTM_REQ(LOCATION_GROUP, TOF_RANGE_RESPONSE_NOTIF,
 			      ftm_resp_notif)
 };
diff --git a/drivers/net/wireless/intel/iwlwifi/mld/rx.c b/drivers/net/wireless/intel/iwlwifi/mld/rx.c
index ce0093d5c638..3d19cec3f696 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/rx.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/rx.c
@@ -143,7 +143,55 @@ void iwl_mld_pass_packet_to_mac80211(struct iwl_mld *mld,
 }
 EXPORT_SYMBOL_IF_IWLWIFI_KUNIT(iwl_mld_pass_packet_to_mac80211);
 
-static void iwl_mld_fill_signal(struct iwl_mld *mld,
+static bool iwl_mld_used_average_energy(struct iwl_mld *mld, int link_id,
+					struct ieee80211_hdr *hdr,
+					struct ieee80211_rx_status *rx_status)
+{
+	struct ieee80211_bss_conf *link_conf;
+	struct iwl_mld_link *mld_link;
+
+	if (unlikely(!hdr || link_id < 0))
+		return false;
+
+	if (likely(!ieee80211_is_beacon(hdr->frame_control)))
+		return false;
+
+	/*
+	 * if link ID is >= valid ones then that means the RX
+	 * was on the AUX link and no correction is needed
+	 */
+	if (link_id >= mld->fw->ucode_capa.num_links)
+		return false;
+
+	/* for the link conf lookup */
+	guard(rcu)();
+
+	link_conf = rcu_dereference(mld->fw_id_to_bss_conf[link_id]);
+	if (!link_conf)
+		return false;
+
+	mld_link = iwl_mld_link_from_mac80211(link_conf);
+	if (!mld_link)
+		return false;
+
+	/*
+	 * If we know the link by link ID then the frame was
+	 * received for the link, so by filtering it means it
+	 * was from the AP the link is connected to.
+	 */
+
+	/* skip also in case we don't have it (yet) */
+	if (!mld_link->average_beacon_energy)
+		return false;
+
+	IWL_DEBUG_STATS(mld, "energy override by average %d\n",
+			mld_link->average_beacon_energy);
+	rx_status->signal = -mld_link->average_beacon_energy;
+	return true;
+}
+
+static void iwl_mld_fill_signal(struct iwl_mld *mld, int link_id,
+				struct ieee80211_hdr *hdr,
 				struct ieee80211_rx_status *rx_status,
 				struct iwl_mld_rx_phy_data *phy_data)
 {
@@ -159,9 +207,11 @@ static void iwl_mld_fill_signal(struct iwl_mld *mld,
 	IWL_DEBUG_STATS(mld, "energy in A %d B %d, and max %d\n",
 			energy_a, energy_b, max_energy);
 
+	if (iwl_mld_used_average_energy(mld, link_id, hdr, rx_status))
+		return;
+
 	rx_status->signal = max_energy;
-	rx_status->chains =
-	    (rate_n_flags & RATE_MCS_ANT_AB_MSK) >> RATE_MCS_ANT_POS;
+	rx_status->chains = u32_get_bits(rate_n_flags, RATE_MCS_ANT_AB_MSK);
 	rx_status->chain_signal[0] = energy_a;
 	rx_status->chain_signal[1] = energy_b;
 }
@@ -1160,7 +1210,10 @@ static void iwl_mld_add_rtap_sniffer_config(struct iwl_mld *mld,
 }
 #endif
 
-static void iwl_mld_rx_fill_status(struct iwl_mld *mld, struct sk_buff *skb,
+/* Note: hdr can be NULL */
+static void iwl_mld_rx_fill_status(struct iwl_mld *mld, int link_id,
+				   struct ieee80211_hdr *hdr,
+				   struct sk_buff *skb,
 				   struct iwl_mld_rx_phy_data *phy_data,
 				   int queue)
 {
@@ -1182,7 +1235,7 @@ static void iwl_mld_rx_fill_status(struct iwl_mld *mld, struct sk_buff *skb,
 	    phy_data->phy_info & IWL_RX_MPDU_PHY_SHORT_PREAMBLE)
 		rx_status->enc_flags |= RX_ENC_FLAG_SHORTPRE;
 
-	iwl_mld_fill_signal(mld, rx_status, phy_data);
+	iwl_mld_fill_signal(mld, link_id, hdr, rx_status, phy_data);
 
 	/* This may be overridden by iwl_mld_rx_he() to HE_RU */
 	switch (rate_n_flags & RATE_MCS_CHAN_WIDTH_MSK) {
@@ -1733,7 +1786,7 @@ void iwl_mld_rx_mpdu(struct iwl_mld *mld, struct napi_struct *napi,
 	struct sk_buff *skb;
 	size_t mpdu_desc_size = sizeof(*mpdu_desc);
 	bool drop = false;
-	u8 crypto_len = 0, band;
+	u8 crypto_len = 0, band, link_id;
 	u32 pkt_len = iwl_rx_packet_payload_len(pkt);
 	u32 mpdu_len;
 	enum iwl_mld_reorder_result reorder_res;
@@ -1822,7 +1875,10 @@ void iwl_mld_rx_mpdu(struct iwl_mld *mld, struct napi_struct *napi,
 				SCHED_SCAN_PASS_ALL_STATE_FOUND;
 	}
 
-	iwl_mld_rx_fill_status(mld, skb, &phy_data, queue);
+	link_id = u8_get_bits(mpdu_desc->mac_phy_band,
+			      IWL_RX_MPDU_MAC_PHY_BAND_LINK_MASK);
+
+	iwl_mld_rx_fill_status(mld, link_id, hdr, skb, &phy_data, queue);
 
 	if (iwl_mld_rx_crypto(mld, sta, hdr, rx_status, mpdu_desc, queue,
 			      le32_to_cpu(pkt->len_n_flags), &crypto_len))
@@ -2035,7 +2091,8 @@ void iwl_mld_rx_monitor_no_data(struct iwl_mld *mld, struct napi_struct *napi,
 	rx_status->freq = ieee80211_channel_to_frequency(channel,
 							 rx_status->band);
 
-	iwl_mld_rx_fill_status(mld, skb, &phy_data, queue);
+	/* link ID is ignored for NULL header */
+	iwl_mld_rx_fill_status(mld, -1, NULL, skb, &phy_data, queue);
 
 	/* No more radiotap info should be added after this point.
 	 * Mark it as mac header for upper layers to know where
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
index 448492d94926..9e9e76b67ef0 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
@@ -1769,6 +1769,8 @@ void iwl_mvm_mac_init_mvmvif(struct iwl_mvm *mvm, struct iwl_mvm_vif *mvmvif)
 	if (test_bit(IWL_MVM_STATUS_IN_HW_RESTART, &mvm->status))
 		return;
 
+	mvmvif->deflink.average_beacon_energy = 0;
+
 	INIT_DELAYED_WORK(&mvmvif->csa_work,
 			  iwl_mvm_channel_switch_disconnect_wk);
 
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
index 6c024a681508..9e83c671f4e2 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
@@ -304,6 +304,8 @@ struct iwl_probe_resp_data {
  * @mcast_sta: multicast station
  * @phy_ctxt: phy context allocated to this link, if any
  * @bf_data: beacon filtering data
+ * @average_beacon_energy: average beacon energy for beacons received during
+ *	client connections
  */
 struct iwl_mvm_vif_link_info {
 	u8 bssid[ETH_ALEN];
@@ -342,6 +344,7 @@ struct iwl_mvm_vif_link_info {
 	u16 mgmt_queue;
 
 	struct iwl_mvm_link_bf_data bf_data;
+	u32 average_beacon_energy;
 };
 
 /**
@@ -2074,6 +2077,9 @@ void iwl_mvm_channel_switch_start_notif(struct iwl_mvm *mvm,
 					struct iwl_rx_cmd_buffer *rxb);
 void iwl_mvm_channel_switch_error_notif(struct iwl_mvm *mvm,
 					struct iwl_rx_cmd_buffer *rxb);
+void iwl_mvm_rx_beacon_filter_notif(struct iwl_mvm *mvm,
+				    struct iwl_rx_cmd_buffer *rxb);
+
 /* Bindings */
 int iwl_mvm_binding_add_vif(struct iwl_mvm *mvm, struct ieee80211_vif *vif);
 int iwl_mvm_binding_remove_vif(struct iwl_mvm *mvm, struct ieee80211_vif *vif);
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/ops.c b/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
index c7a3fbc49b59..892b1564677b 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
@@ -489,6 +489,11 @@ static const struct iwl_rx_handlers iwl_mvm_rx_handlers[] = {
 	RX_HANDLER_GRP(SCAN_GROUP, CHANNEL_SURVEY_NOTIF,
 		       iwl_mvm_rx_channel_survey_notif, RX_HANDLER_ASYNC_LOCKED,
 		       struct iwl_umac_scan_channel_survey_notif),
+	RX_HANDLER_GRP(DATA_PATH_GROUP, BEACON_FILTER_IN_NOTIF,
+		       iwl_mvm_rx_beacon_filter_notif,
+		       RX_HANDLER_ASYNC_LOCKED,
+		       /* same size as v1 */
+		       struct iwl_beacon_filter_notif),
 };
 #undef RX_HANDLER
 #undef RX_HANDLER_GRP
@@ -659,6 +664,7 @@ static const struct iwl_hcmd_names iwl_mvm_data_path_names[] = {
 	HCMD_NAME(ESR_MODE_NOTIF),
 	HCMD_NAME(MONITOR_NOTIF),
 	HCMD_NAME(THERMAL_DUAL_CHAIN_REQUEST),
+	HCMD_NAME(BEACON_FILTER_IN_NOTIF),
 	HCMD_NAME(STA_PM_NOTIF),
 	HCMD_NAME(MU_GROUP_MGMT_NOTIF),
 	HCMD_NAME(RX_QUEUES_NOTIFICATION),
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c b/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c
index 077aadbf95db..4b57ca56e1f6 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c
@@ -246,13 +246,62 @@ static void iwl_mvm_pass_packet_to_mac80211(struct iwl_mvm *mvm,
 	ieee80211_rx_napi(mvm->hw, sta, skb, napi);
 }
 
+static bool iwl_mvm_used_average_energy(struct iwl_mvm *mvm,
+					struct iwl_rx_mpdu_desc *desc,
+					struct ieee80211_hdr *hdr,
+					struct ieee80211_rx_status *rx_status)
+{
+	struct iwl_mvm_vif *mvm_vif;
+	struct ieee80211_vif *vif;
+	u32 id;
+
+	if (unlikely(!hdr || !desc))
+		return false;
+
+	if (likely(!ieee80211_is_beacon(hdr->frame_control)))
+		return false;
+
+	/* for the link conf lookup */
+	guard(rcu)();
+
+	/* MAC or link ID depending on FW, but driver has them equal */
+	id = u8_get_bits(desc->mac_phy_band,
+			 IWL_RX_MPDU_MAC_PHY_BAND_MAC_MASK);
+
+	/* >= means AUX MAC/link ID, no energy correction needed then */
+	if (id >= ARRAY_SIZE(mvm->vif_id_to_mac))
+		return false;
+
+	vif = iwl_mvm_rcu_dereference_vif_id(mvm, id, true);
+	if (!vif)
+		return false;
+
+	mvm_vif = iwl_mvm_vif_from_mac80211(vif);
+
+	/*
+	 * If we know the MAC by MAC or link ID then the frame was
+	 * received for the link, so by filtering it means it was
+	 * from the AP the link is connected to.
+	 */
+
+	/* skip also in case we don't have it (yet) */
+	if (!mvm_vif->deflink.average_beacon_energy)
+		return false;
+
+	IWL_DEBUG_STATS(mvm, "energy override by average %d\n",
+			mvm_vif->deflink.average_beacon_energy);
+	rx_status->signal = -mvm_vif->deflink.average_beacon_energy;
+	return true;
+}
+
 static void iwl_mvm_get_signal_strength(struct iwl_mvm *mvm,
+					struct iwl_rx_mpdu_desc *desc,
+					struct ieee80211_hdr *hdr,
 					struct ieee80211_rx_status *rx_status,
 					u32 rate_n_flags, int energy_a,
 					int energy_b)
 {
 	int max_energy;
-	u32 rate_flags = rate_n_flags;
 
 	energy_a = energy_a ? -energy_a : S8_MIN;
 	energy_b = energy_b ? -energy_b : S8_MIN;
@@ -261,9 +310,11 @@ static void iwl_mvm_get_signal_strength(struct iwl_mvm *mvm,
 	IWL_DEBUG_STATS(mvm, "energy In A %d B %d, and max %d\n",
 			energy_a, energy_b, max_energy);
 
+	if (iwl_mvm_used_average_energy(mvm, desc, hdr, rx_status))
+		return;
+
 	rx_status->signal = max_energy;
-	rx_status->chains =
-		(rate_flags & RATE_MCS_ANT_AB_MSK) >> RATE_MCS_ANT_POS;
+	rx_status->chains = u32_get_bits(rate_n_flags, RATE_MCS_ANT_AB_MSK);
 	rx_status->chain_signal[0] = energy_a;
 	rx_status->chain_signal[1] = energy_b;
 }
@@ -1906,8 +1957,11 @@ static void iwl_mvm_rx_get_sta_block_tx(void *data, struct ieee80211_sta *sta)
 /*
  * Note: requires also rx_status->band to be prefilled, as well
  * as phy_data (apart from phy_data->info_type)
+ * Note: desc/hdr may be NULL
  */
 static void iwl_mvm_rx_fill_status(struct iwl_mvm *mvm,
+				   struct iwl_rx_mpdu_desc *desc,
+				   struct ieee80211_hdr *hdr,
 				   struct sk_buff *skb,
 				   struct iwl_mvm_rx_phy_data *phy_data,
 				   int queue)
@@ -1962,7 +2016,7 @@ static void iwl_mvm_rx_fill_status(struct iwl_mvm *mvm,
 
 	rx_status->freq = ieee80211_channel_to_frequency(phy_data->channel,
 							 rx_status->band);
-	iwl_mvm_get_signal_strength(mvm, rx_status, rate_n_flags,
+	iwl_mvm_get_signal_strength(mvm, desc, hdr, rx_status, rate_n_flags,
 				    phy_data->energy_a, phy_data->energy_b);
 
 	/* using TLV format and must be after all fixed len fields */
@@ -2215,7 +2269,7 @@ void iwl_mvm_rx_mpdu_mq(struct iwl_mvm *mvm, struct napi_struct *napi,
 		goto out;
 	}
 
-	iwl_mvm_rx_fill_status(mvm, skb, &phy_data, queue);
+	iwl_mvm_rx_fill_status(mvm, desc, hdr, skb, &phy_data, queue);
 
 	if (sta) {
 		struct iwl_mvm_sta *mvmsta = iwl_mvm_sta_from_mac80211(sta);
@@ -2445,7 +2499,7 @@ void iwl_mvm_rx_monitor_no_data(struct iwl_mvm *mvm, struct napi_struct *napi,
 	rx_status->band = phy_data.channel > 14 ? NL80211_BAND_5GHZ :
 		NL80211_BAND_2GHZ;
 
-	iwl_mvm_rx_fill_status(mvm, skb, &phy_data, queue);
+	iwl_mvm_rx_fill_status(mvm, NULL, NULL, skb, &phy_data, queue);
 
 	/* no more radio tap info should be put after this point.
 	 *
@@ -2548,3 +2602,28 @@ void iwl_mvm_rx_bar_frame_release(struct iwl_mvm *mvm, struct napi_struct *napi,
 out:
 	rcu_read_unlock();
 }
+
+void iwl_mvm_rx_beacon_filter_notif(struct iwl_mvm *mvm,
+				    struct iwl_rx_cmd_buffer *rxb)
+{
+	struct iwl_rx_packet *pkt = rxb_addr(rxb);
+	/* MAC or link ID in v1/v2, but driver has the IDs equal */
+	struct iwl_beacon_filter_notif *notif = (void *)pkt->data;
+	u32 id = le32_to_cpu(notif->link_id);
+	struct iwl_mvm_vif *mvm_vif;
+	struct ieee80211_vif *vif;
+
+	/* >= means AUX MAC/link ID, no energy correction needed then */
+	if (IWL_FW_CHECK(mvm, id >= ARRAY_SIZE(mvm->vif_id_to_mac),
+			 "invalid link ID %d\n", id))
+		return;
+
+	vif = iwl_mvm_rcu_dereference_vif_id(mvm, id, false);
+	if (!vif)
+		return;
+
+	mvm_vif = iwl_mvm_vif_from_mac80211(vif);
+
+	mvm_vif->deflink.average_beacon_energy =
+		le32_to_cpu(notif->average_energy);
+}
-- 
2.34.1


