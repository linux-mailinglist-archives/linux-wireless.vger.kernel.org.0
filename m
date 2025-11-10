Return-Path: <linux-wireless+bounces-28750-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 79A66C4643C
	for <lists+linux-wireless@lfdr.de>; Mon, 10 Nov 2025 12:30:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 266304EE202
	for <lists+linux-wireless@lfdr.de>; Mon, 10 Nov 2025 11:27:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03CC630AACE;
	Mon, 10 Nov 2025 11:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HJ5Ki9NS"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 856E32FC88B
	for <linux-wireless@vger.kernel.org>; Mon, 10 Nov 2025 11:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762774019; cv=none; b=fbcJrSPZGWfu+dAnvw+eAo31zO7lfb6/o7afkipPJgg2X6k6duOceyUPLCbVvaOWkobBG8KM5SVxfbyfSlQK5frzywsFVHlNqANnWRxsUbWbJ19HYLmRyKooliStolknqMeg/YlP92exeTPJhYrccPz8Iq05TUhuYGL1mPeHxY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762774019; c=relaxed/simple;
	bh=Ghf/nW3lg9abn5LilhkrTBa2T9br/CCKS9dOYWNMLpU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Ip3fV2r8wn60VLb+l76qRl7c6vnZBwrRvWtBNg9xl8OHpEoX0LxWyH77WJccGTRtMeYOd+gZ7DLbAxyHDAnOYIzy2wROGx3xzEcmTU14ASJ4leqb4UIUtsnryNuSNgmJIZ5Qs6wnX7QbWaBPHFD5VPnV+t42QvRZl4bwxkqvPYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HJ5Ki9NS; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762774017; x=1794310017;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Ghf/nW3lg9abn5LilhkrTBa2T9br/CCKS9dOYWNMLpU=;
  b=HJ5Ki9NSmS76mNiOjZWi8lMXpA8MaTTYkJDpGNBKlUFPL5HNHau60xOe
   gCNZ9JTBtFD3U7yhaDtAZA0lzaRzXd+S4AdqWjwsxoBRH/Tf6w4A+ExG6
   n7u9znBwdM0E4FA9rx4dPWw05lvIEczFXcvvzUsTX+xaZMALjqkqVjl/i
   K8uKnioxzNIKnGwBoSx6/K6YpRebHfOpJdjkVAevqZtBqJtGKpp5pYlA+
   qwa7JlnRYAk4zPGeKAZwhXC8NIvFCz7kE03DtY9wRriveMruZLS1Rzd16
   L7SW80WRyB3t908uszaYUPgO0rEkny8BsaC01EXqRlWVlq4gJ36euoZMT
   g==;
X-CSE-ConnectionGUID: x0zUQUb2R6K2MGdReBjIIw==
X-CSE-MsgGUID: B6FuJuQ2Teu+9kEnT0Ia8Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11608"; a="64856413"
X-IronPort-AV: E=Sophos;i="6.19,293,1754982000"; 
   d="scan'208";a="64856413"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2025 03:26:56 -0800
X-CSE-ConnectionGUID: OUIpl5QgTM+MmJCaRceWGQ==
X-CSE-MsgGUID: pbBZt2vgRW+cjwOSjmXNVg==
X-ExtLoop1: 1
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2025 03:26:55 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Ilan Peer <ilan.peer@intel.com>
Subject: [PATCH wireless-next 1/6] wifi: iwlwifi: mld: Add support for NAN
Date: Mon, 10 Nov 2025 13:26:43 +0200
Message-Id: <20251110132506.76dd4d45b91e.I5abfab64b4f27bed442aeca6231ffebad979cad6@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251110112648.4149049-1-miriam.rachel.korenblit@intel.com>
References: <20251110112648.4149049-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Ilan Peer <ilan.peer@intel.com>

- Add firmware API definitions related to NAN.
- Indicate support for NAN Device interface operation, if supported
  by the firmware.
- Add support for starting and stopping NAN cluster functionality.
  The NAN cluster operation is offloaded to the FW, which notifies
  the driver on:
  - cluster events: Start/Join cluster.
  - Discovery Window (DW) end, which allows the driver to flush the
    HW queues and update the higher layers

Signed-off-by: Ilan Peer <ilan.peer@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 .../wireless/intel/iwlwifi/fw/api/mac-cfg.h   | 129 ++++++++++++++
 drivers/net/wireless/intel/iwlwifi/fw/file.h  |   2 +
 .../net/wireless/intel/iwlwifi/mld/Makefile   |   2 +-
 .../net/wireless/intel/iwlwifi/mld/iface.c    |  21 ++-
 .../net/wireless/intel/iwlwifi/mld/mac80211.c |  69 +++++++-
 drivers/net/wireless/intel/iwlwifi/mld/mld.c  |   3 +
 drivers/net/wireless/intel/iwlwifi/mld/mld.h  |   3 +
 drivers/net/wireless/intel/iwlwifi/mld/nan.c  | 167 ++++++++++++++++++
 drivers/net/wireless/intel/iwlwifi/mld/nan.h  |  18 ++
 .../net/wireless/intel/iwlwifi/mld/notif.c    |   6 +
 drivers/net/wireless/intel/iwlwifi/mld/sta.c  |   3 +-
 drivers/net/wireless/intel/iwlwifi/mld/tx.c   |   6 +
 12 files changed, 411 insertions(+), 18 deletions(-)
 create mode 100644 drivers/net/wireless/intel/iwlwifi/mld/nan.c
 create mode 100644 drivers/net/wireless/intel/iwlwifi/mld/nan.h

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/mac-cfg.h b/drivers/net/wireless/intel/iwlwifi/fw/api/mac-cfg.h
index f76cea6e9ec8..628f39917a6f 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/mac-cfg.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/mac-cfg.h
@@ -65,6 +65,18 @@ enum iwl_mac_conf_subcmd_ids {
 	 * @TWT_OPERATION_CMD: &struct iwl_twt_operation_cmd
 	 */
 	TWT_OPERATION_CMD = 0x10,
+	/**
+	 * @NAN_CFG_CMD: &struct iwl_nan_config_cmd
+	 */
+	NAN_CFG_CMD = 0x12,
+	/**
+	 * @NAN_DW_END_NOTIF: &struct iwl_nan_dw_end_notif
+	 */
+	NAN_DW_END_NOTIF = 0xf4,
+	/**
+	 * @NAN_JOINED_CLUSTER_NOTIF: &struct iwl_nan_cluster_notif
+	 */
+	NAN_JOINED_CLUSTER_NOTIF = 0xf5,
 	/**
 	 * @MISSED_BEACONS_NOTIF: &struct iwl_missed_beacons_notif
 	 */
@@ -990,4 +1002,121 @@ struct iwl_twt_operation_cmd {
 	u8 ul_tid_bitmap;
 } __packed; /* TWT_OPERATION_API_S_VER_1 */
 
+enum iwl_nan_band {
+	IWL_NAN_BAND_5GHZ = 0,
+	IWL_NAN_BAND_2GHZ = 1,
+	IWL_NUM_NAN_BANDS,
+};
+
+/**
+ * struct iwl_nan_band_config - NAN band configuration
+ *
+ * @rssi_close: RSSI threshold for close proximity in dBm
+ * @rssi_middle: RSSI threshold for middle proximity in dBm
+ * @dw_interval: Discovery Window (DW) interval for synchronization beacons and
+ *	SDFs. Valid values of DW interval are: 1, 2, 3, 4 and 5 corresponding to
+ *	1, 2, 4, 8, and 16 DWs.
+ * @reserved: reserved
+ */
+struct iwl_nan_band_config {
+	u8 rssi_close;
+	u8 rssi_middle;
+	u8 dw_interval;
+	u8 reserved;
+}; /* NAN_BAND_SPECIFIC_CONFIG_API_S_VER_1 */
+
+/**
+ * enum iwl_nan_flags - flags for NAN configuration
+ *
+ * @IWL_NAN_FLAG_DW_END_NOTIF_ENABLED: indicates that the host wants to receive
+ *	notifications when a DW ends.
+ */
+enum iwl_nan_flags {
+	IWL_NAN_FLAG_DW_END_NOTIF_ENABLED = BIT(0),
+};
+
+/**
+ * struct iwl_nan_config_cmd - NAN configuration command
+ *
+ * @action: action to perform, see &enum iwl_ctxt_action
+ * @nmi_addr: NAN Management Interface (NMI) address
+ * @reserved_for_nmi_addr: reserved
+ * @discovery_beacon_interval: discovery beacon interval in TUs
+ * @cluster_id: local cluster ID, in case the local device starts a cluster
+ * @sta_id: station ID of the NAN station
+ * @hb_channel: channel for 5 GHz if the device supports operation on 5 GHz.
+ *	Valid values are 44 and 149, which correspond to the 5 GHz channel, and
+ *	0 which means that NAN operation on the 5 GHz band is disabled.
+ * @master_pref: master preference
+ * @dwell_time: dwell time on the discovery channel during scan (milliseconds).
+ *	If set to 0, the dwell time is determined by the firmware.
+ * @scan_period: scan period in seconds. If set to 0, the scan period is
+ *	determined by the firmware.
+ * @flags: flags for NAN configuration, see &enum iwl_nan_flags
+ * @band_config: band configuration for NAN, one for each band
+ * @nan_attr_len: length of the NAN attributes to be added to the beacon (bytes)
+ * @nan_vendor_elems_len: length of the NAN vendor elements to be added to the
+ *	beacon (bytes)
+ * @beacon_data: variable length data that contains the NAN attributes
+ *	(&nan_attr_len) followed by the NAN vendor elements
+ *	(&nan_vendor_elems_len).
+ */
+struct iwl_nan_config_cmd {
+	__le32 action;
+	u8 nmi_addr[6];
+	__le16 reserved_for_nmi_addr;
+	__le32 discovery_beacon_interval;
+
+	__le16 cluster_id;
+	u8 sta_id;
+	u8 hb_channel;
+
+	u8 master_pref;
+	u8 dwell_time;
+	u8 scan_period;
+	u8 flags;
+
+	struct iwl_nan_band_config band_config[IWL_NUM_NAN_BANDS];
+
+	__le32 nan_attr_len;
+	__le32 nan_vendor_elems_len;
+	u8 beacon_data[];
+} __packed; /*  NAN_CONFIG_CMD_API_S_VER_1 */
+
+/**
+ * enum iwl_nan_cluster_notif_flags - flags for the cluster notification
+ *
+ * @IWL_NAN_CLUSTER_NOTIF_FLAG_NEW_CLUSTER: indicates that the device has
+ *	started a new cluster. If not set, the device has joined an existing
+ *	cluster.
+ */
+enum iwl_nan_cluster_notif_flags {
+	IWL_NAN_CLUSTER_NOTIF_FLAG_NEW_CLUSTER	= BIT(0),
+}; /* NAN_JOINED_CLUSTER_FLAG_E_VER_1 */
+
+/**
+ * struct iwl_nan_cluster_notif - event sent when the device starts or joins a
+ *	NAN cluster.
+ *
+ * @cluster_id: cluster ID
+ * @flags: combination of &enum iwl_nan_cluster_notif_flags
+ * @reserved: reserved
+ */
+struct iwl_nan_cluster_notif {
+	__le16 cluster_id;
+	u8 flags;
+	u8 reserved;
+}; /* NAN_JOINED_CLUSTER_NTF_API_S_VER_1 */
+
+/**
+ * struct iwl_nan_dw_end_notif - sent to notify the host the end of a DW.
+ *
+ * @band: band on which the DW ended. See &enum iwl_nan_band.
+ * @reserved: reserved
+ */
+struct iwl_nan_dw_end_notif {
+	u8 band;
+	u8 reserved[3];
+} __packed; /* NAN_DW_END_NTF_API_S_VER_1 */
+
 #endif /* __iwl_fw_api_mac_cfg_h__ */
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/file.h b/drivers/net/wireless/intel/iwlwifi/fw/file.h
index b9e0b69c6680..378788de1d74 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/file.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/file.h
@@ -447,6 +447,7 @@ typedef unsigned int __bitwise iwl_ucode_tlv_capa_t;
  *	during assert handling even if the dump isn't split
  * @IWL_UCODE_TLV_CAPA_FW_ACCEPTS_RAW_DSM_TABLE: Firmware has capability of
  *	handling raw DSM table data.
+ * @IWL_UCODE_TLV_CAPA_NAN_SYNC_SUPPORT: Supports NAN synchronization
  *
  * @NUM_IWL_UCODE_TLV_CAPA: number of bits used
  */
@@ -550,6 +551,7 @@ enum iwl_ucode_tlv_capa {
 
 	IWL_UCODE_TLV_CAPA_RESET_DURING_ASSERT		= (__force iwl_ucode_tlv_capa_t)(4 * 32 + 0),
 	IWL_UCODE_TLV_CAPA_FW_ACCEPTS_RAW_DSM_TABLE 	= (__force iwl_ucode_tlv_capa_t)(4 * 32 + 1),
+	IWL_UCODE_TLV_CAPA_NAN_SYNC_SUPPORT		= (__force iwl_ucode_tlv_capa_t)(4 * 32 + 2),
 	NUM_IWL_UCODE_TLV_CAPA
 /*
  * This construction make both sparse (which cannot increment the previous
diff --git a/drivers/net/wireless/intel/iwlwifi/mld/Makefile b/drivers/net/wireless/intel/iwlwifi/mld/Makefile
index c966e573f430..5740c0510b61 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/Makefile
+++ b/drivers/net/wireless/intel/iwlwifi/mld/Makefile
@@ -4,7 +4,7 @@ obj-$(CONFIG_IWLWIFI_KUNIT_TESTS) += tests/
 
 iwlmld-y += mld.o notif.o mac80211.o fw.o power.o iface.o link.o rx.o mcc.o session-protect.o phy.o
 iwlmld-y += scan.o sta.o tx.o coex.o tlc.o agg.o key.o regulatory.o ap.o thermal.o roc.o stats.o
-iwlmld-y += low_latency.o mlo.o ptp.o time_sync.o ftm-initiator.o
+iwlmld-y += low_latency.o mlo.o ptp.o time_sync.o ftm-initiator.o nan.o
 iwlmld-$(CONFIG_IWLWIFI_DEBUGFS) += debugfs.o
 iwlmld-$(CONFIG_IWLWIFI_LEDS) += led.o
 iwlmld-$(CONFIG_PM_SLEEP) += d3.o
diff --git a/drivers/net/wireless/intel/iwlwifi/mld/iface.c b/drivers/net/wireless/intel/iwlwifi/mld/iface.c
index a5ececfc13e4..3ca3e169738e 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/iface.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/iface.c
@@ -339,6 +339,10 @@ int iwl_mld_mac_fw_action(struct iwl_mld *mld, struct ieee80211_vif *vif,
 
 	lockdep_assert_wiphy(mld->wiphy);
 
+	/* NAN interface type is not known to FW */
+	if (vif->type == NL80211_IFTYPE_NAN)
+		return 0;
+
 	if (action == FW_CTXT_ACTION_REMOVE)
 		return iwl_mld_rm_mac_from_fw(mld, vif);
 
@@ -387,21 +391,16 @@ static void iwl_mld_mlo_scan_start_wk(struct wiphy *wiphy,
 IWL_MLD_ALLOC_FN(vif, vif)
 
 /* Constructor function for struct iwl_mld_vif */
-static int
+static void
 iwl_mld_init_vif(struct iwl_mld *mld, struct ieee80211_vif *vif)
 {
 	struct iwl_mld_vif *mld_vif = iwl_mld_vif_from_mac80211(vif);
-	int ret;
 
 	lockdep_assert_wiphy(mld->wiphy);
 
 	mld_vif->mld = mld;
 	mld_vif->roc_activity = ROC_NUM_ACTIVITIES;
 
-	ret = iwl_mld_allocate_vif_fw_id(mld, &mld_vif->fw_id, vif);
-	if (ret)
-		return ret;
-
 	if (!mld->fw_status.in_hw_restart) {
 		wiphy_work_init(&mld_vif->emlsr.unblock_tpt_wk,
 				iwl_mld_emlsr_unblock_tpt_wk);
@@ -415,8 +414,6 @@ iwl_mld_init_vif(struct iwl_mld *mld, struct ieee80211_vif *vif)
 					iwl_mld_mlo_scan_start_wk);
 	}
 	iwl_mld_init_internal_sta(&mld_vif->aux_sta);
-
-	return 0;
 }
 
 int iwl_mld_add_vif(struct iwl_mld *mld, struct ieee80211_vif *vif)
@@ -426,7 +423,13 @@ int iwl_mld_add_vif(struct iwl_mld *mld, struct ieee80211_vif *vif)
 
 	lockdep_assert_wiphy(mld->wiphy);
 
-	ret = iwl_mld_init_vif(mld, vif);
+	iwl_mld_init_vif(mld, vif);
+
+	/* NAN interface type is not known to FW */
+	if (vif->type == NL80211_IFTYPE_NAN)
+		return 0;
+
+	ret = iwl_mld_allocate_vif_fw_id(mld, &mld_vif->fw_id, vif);
 	if (ret)
 		return ret;
 
diff --git a/drivers/net/wireless/intel/iwlwifi/mld/mac80211.c b/drivers/net/wireless/intel/iwlwifi/mld/mac80211.c
index 55b484c16280..357e1e80bdc5 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/mac80211.c
@@ -50,7 +50,7 @@
 	{							\
 		.max = 1,					\
 		.types = BIT(NL80211_IFTYPE_P2P_DEVICE),	\
-	}
+	},
 
 static const struct ieee80211_iface_limit iwl_mld_limits[] = {
 	IWL_MLD_LIMITS(0)
@@ -60,6 +60,22 @@ static const struct ieee80211_iface_limit iwl_mld_limits_ap[] = {
 	IWL_MLD_LIMITS(BIT(NL80211_IFTYPE_AP))
 };
 
+static const struct ieee80211_iface_limit iwl_mld_limits_nan[] = {
+	{
+		.max = 2,
+		.types = BIT(NL80211_IFTYPE_STATION),
+	},
+	{
+		.max = 1,
+		.types = BIT(NL80211_IFTYPE_NAN),
+	},
+	/* Removed when two channels are permitted */
+	{
+		.max = 1,
+		.types = BIT(NL80211_IFTYPE_AP),
+	},
+};
+
 static const struct ieee80211_iface_combination
 iwl_mld_iface_combinations[] = {
 	{
@@ -74,6 +90,19 @@ iwl_mld_iface_combinations[] = {
 		.limits = iwl_mld_limits_ap,
 		.n_limits = ARRAY_SIZE(iwl_mld_limits_ap),
 	},
+	/* NAN combinations follow, these exclude P2P */
+	{
+		.num_different_channels = 2,
+		.max_interfaces = 3,
+		.limits = iwl_mld_limits_nan,
+		.n_limits = ARRAY_SIZE(iwl_mld_limits_nan) - 1,
+	},
+	{
+		.num_different_channels = 1,
+		.max_interfaces = 4,
+		.limits = iwl_mld_limits_nan,
+		.n_limits = ARRAY_SIZE(iwl_mld_limits_nan),
+	}
 };
 
 static const u8 ext_capa_base[IWL_MLD_STA_EXT_CAPA_SIZE] = {
@@ -305,8 +334,22 @@ static void iwl_mac_hw_set_wiphy(struct iwl_mld *mld)
 
 	wiphy->hw_timestamp_max_peers = 1;
 
-	wiphy->iface_combinations = iwl_mld_iface_combinations;
-	wiphy->n_iface_combinations = ARRAY_SIZE(iwl_mld_iface_combinations);
+	if (iwl_mld_nan_supported(mld)) {
+		hw->wiphy->interface_modes |= BIT(NL80211_IFTYPE_NAN);
+		hw->wiphy->iface_combinations = iwl_mld_iface_combinations;
+		hw->wiphy->n_iface_combinations =
+			ARRAY_SIZE(iwl_mld_iface_combinations);
+
+		hw->wiphy->nan_supported_bands = BIT(NL80211_BAND_2GHZ);
+		if (mld->nvm_data->bands[NL80211_BAND_5GHZ].n_channels)
+			hw->wiphy->nan_supported_bands |=
+				BIT(NL80211_BAND_5GHZ);
+	} else {
+		wiphy->iface_combinations = iwl_mld_iface_combinations;
+		/* Do not include NAN combinations */
+		wiphy->n_iface_combinations =
+			ARRAY_SIZE(iwl_mld_iface_combinations) - 2;
+	}
 
 	wiphy_ext_feature_set(wiphy, NL80211_EXT_FEATURE_VHT_IBSS);
 	wiphy_ext_feature_set(wiphy, NL80211_EXT_FEATURE_DFS_CONCURRENT);
@@ -616,10 +659,11 @@ int iwl_mld_mac80211_add_interface(struct ieee80211_hw *hw,
 	 * Add the default link, but not if this is an MLD vif as that implies
 	 * the HW is restarting and it will be configured by change_vif_links.
 	 */
-	if (!ieee80211_vif_is_mld(vif))
+	if (vif->type != NL80211_IFTYPE_NAN && !ieee80211_vif_is_mld(vif)) {
 		ret = iwl_mld_add_link(mld, &vif->bss_conf);
-	if (ret)
-		goto err;
+		if (ret)
+			goto err;
+	}
 
 	if (vif->type == NL80211_IFTYPE_STATION) {
 		vif->driver_flags |= IEEE80211_VIF_REMOVE_AP_AFTER_DISASSOC;
@@ -647,6 +691,9 @@ int iwl_mld_mac80211_add_interface(struct ieee80211_hw *hw,
 	if (vif->type == NL80211_IFTYPE_P2P_DEVICE)
 		mld->p2p_device_vif = vif;
 
+	if (vif->type == NL80211_IFTYPE_NAN)
+		mld->nan_device_vif = vif;
+
 	return 0;
 
 err:
@@ -674,7 +721,10 @@ void iwl_mld_mac80211_remove_interface(struct ieee80211_hw *hw,
 	if (vif->type == NL80211_IFTYPE_P2P_DEVICE)
 		mld->p2p_device_vif = NULL;
 
-	iwl_mld_remove_link(mld, &vif->bss_conf);
+	if (vif->type == NL80211_IFTYPE_NAN)
+		mld->nan_device_vif = NULL;
+	else
+		iwl_mld_remove_link(mld, &vif->bss_conf);
 
 #ifdef CONFIG_IWLWIFI_DEBUGFS
 	debugfs_remove(iwl_mld_vif_from_mac80211(vif)->dbgfs_slink);
@@ -1506,6 +1556,9 @@ iwl_mld_mac80211_conf_tx(struct ieee80211_hw *hw,
 
 	lockdep_assert_wiphy(mld->wiphy);
 
+	if (vif->type == NL80211_IFTYPE_NAN)
+		return 0;
+
 	link = iwl_mld_link_dereference_check(mld_vif, link_id);
 	if (!link)
 		return -EINVAL;
@@ -2699,4 +2752,6 @@ const struct ieee80211_ops iwl_mld_hw_ops = {
 	.set_hw_timestamp = iwl_mld_set_hw_timestamp,
 	.start_pmsr = iwl_mld_start_pmsr,
 	.can_neg_ttlm = iwl_mld_can_neg_ttlm,
+	.start_nan = iwl_mld_start_nan,
+	.stop_nan = iwl_mld_stop_nan,
 };
diff --git a/drivers/net/wireless/intel/iwlwifi/mld/mld.c b/drivers/net/wireless/intel/iwlwifi/mld/mld.c
index 8a4c96385640..495e9d8f3af6 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/mld.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/mld.c
@@ -234,6 +234,9 @@ static const struct iwl_hcmd_names iwl_mld_mac_conf_names[] = {
 	HCMD_NAME(AUX_STA_CMD),
 	HCMD_NAME(STA_REMOVE_CMD),
 	HCMD_NAME(ROC_CMD),
+	HCMD_NAME(NAN_CFG_CMD),
+	HCMD_NAME(NAN_DW_END_NOTIF),
+	HCMD_NAME(NAN_JOINED_CLUSTER_NOTIF),
 	HCMD_NAME(MISSED_BEACONS_NOTIF),
 	HCMD_NAME(EMLSR_TRANS_FAIL_NOTIF),
 	HCMD_NAME(ROC_NOTIF),
diff --git a/drivers/net/wireless/intel/iwlwifi/mld/mld.h b/drivers/net/wireless/intel/iwlwifi/mld/mld.h
index 22efe8e10f53..66c7a7d31409 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/mld.h
+++ b/drivers/net/wireless/intel/iwlwifi/mld/mld.h
@@ -35,6 +35,7 @@
 #include "ptp.h"
 #include "time_sync.h"
 #include "ftm-initiator.h"
+#include "nan.h"
 
 /**
  * DOC: Introduction
@@ -199,6 +200,7 @@
  * @ptp_data: data of the PTP clock
  * @time_sync: time sync data.
  * @ftm_initiator: FTM initiator data
+ * @nan_device_vif: points to the NAN device vif if exists
  */
 struct iwl_mld {
 	/* Add here fields that need clean up on restart */
@@ -228,6 +230,7 @@ struct iwl_mld {
 #endif /* CONFIG_PM_SLEEP */
 		struct ieee80211_vif *p2p_device_vif;
 		bool bt_is_active;
+		struct ieee80211_vif *nan_device_vif;
 	);
 	struct ieee80211_link_sta __rcu *fw_id_to_link_sta[IWL_STATION_COUNT_MAX];
 	/* And here fields that survive a fw restart */
diff --git a/drivers/net/wireless/intel/iwlwifi/mld/nan.c b/drivers/net/wireless/intel/iwlwifi/mld/nan.c
new file mode 100644
index 000000000000..0bce7a48ab2c
--- /dev/null
+++ b/drivers/net/wireless/intel/iwlwifi/mld/nan.c
@@ -0,0 +1,167 @@
+// SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
+/*
+ * Copyright (C) 2025 Intel Corporation
+ */
+
+#include "mld.h"
+#include "iface.h"
+#include "fw/api/mac-cfg.h"
+
+#define IWL_NAN_DISOVERY_BEACON_INTERNVAL_TU 512
+#define IWL_NAN_RSSI_CLOSE 55
+#define IWL_NAN_RSSI_MIDDLE 70
+
+/* possible discovery channels for the 5 GHz band*/
+#define IWL_NAN_CHANNEL_UNII1 44
+#define IWL_NAN_CHANNEL_UNII3 149
+
+bool iwl_mld_nan_supported(struct iwl_mld *mld)
+{
+	return fw_has_capa(&mld->fw->ucode_capa,
+			   IWL_UCODE_TLV_CAPA_NAN_SYNC_SUPPORT);
+}
+
+static bool iwl_mld_nan_can_beacon(struct ieee80211_vif *vif,
+				   enum nl80211_band band, u8 channel)
+{
+	struct wiphy *wiphy = ieee80211_vif_to_wdev(vif)->wiphy;
+	int freq = ieee80211_channel_to_frequency(channel, band);
+	struct ieee80211_channel *chan = ieee80211_get_channel(wiphy,
+							       freq);
+	struct cfg80211_chan_def def;
+
+	if (!chan)
+		return false;
+
+	cfg80211_chandef_create(&def, chan, NL80211_CHAN_NO_HT);
+	return cfg80211_reg_can_beacon(wiphy, &def, vif->type);
+}
+
+int iwl_mld_start_nan(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
+		      struct cfg80211_nan_conf *conf)
+{
+	struct iwl_mld *mld = IWL_MAC80211_GET_MLD(hw);
+	struct iwl_mld_vif *mld_vif = iwl_mld_vif_from_mac80211(vif);
+	struct iwl_mld_int_sta *aux_sta = &mld_vif->aux_sta;
+	struct iwl_nan_config_cmd cmd = {
+		.action = cpu_to_le32(FW_CTXT_ACTION_ADD),
+		.discovery_beacon_interval =
+			cpu_to_le32(IWL_NAN_DISOVERY_BEACON_INTERNVAL_TU),
+		.band_config = {
+			{
+				.rssi_close = IWL_NAN_RSSI_CLOSE,
+				.rssi_middle = IWL_NAN_RSSI_MIDDLE,
+				.dw_interval = 1,
+			},
+			{
+				.rssi_close = IWL_NAN_RSSI_CLOSE,
+				.rssi_middle = IWL_NAN_RSSI_MIDDLE,
+				.dw_interval = 1,
+			},
+		},
+	};
+	int ret;
+
+	lockdep_assert_wiphy(mld->wiphy);
+
+	IWL_DEBUG_MAC80211(mld, "Start NAN: bands=0x%x\n", conf->bands);
+
+	ether_addr_copy(cmd.nmi_addr, vif->addr);
+	cmd.master_pref = conf->master_pref;
+	cmd.flags = IWL_NAN_FLAG_DW_END_NOTIF_ENABLED;
+
+	if (WARN_ON(!(conf->bands & BIT(NL80211_BAND_2GHZ))))
+		return -EINVAL;
+
+	if (conf->bands & BIT(NL80211_BAND_5GHZ)) {
+		if (iwl_mld_nan_can_beacon(vif, NL80211_BAND_5GHZ,
+					   IWL_NAN_CHANNEL_UNII1)) {
+			cmd.hb_channel = IWL_NAN_CHANNEL_UNII1;
+		} else if (iwl_mld_nan_can_beacon(vif, NL80211_BAND_5GHZ,
+						  IWL_NAN_CHANNEL_UNII3)) {
+			cmd.hb_channel = IWL_NAN_CHANNEL_UNII3;
+		} else {
+			IWL_ERR(mld, "NAN: Can't beacon on 5 GHz band\n");
+			ret = -EINVAL;
+		}
+	} else {
+		memset(&cmd.band_config[IWL_NAN_BAND_5GHZ], 0,
+		       sizeof(cmd.band_config[0]));
+	}
+
+	ret = iwl_mld_add_aux_sta(mld, aux_sta);
+	if (ret)
+		return ret;
+
+	cmd.sta_id = aux_sta->sta_id;
+
+	ret = iwl_mld_send_cmd_pdu(mld,
+				   WIDE_ID(MAC_CONF_GROUP, NAN_CFG_CMD),
+				   &cmd);
+
+	if (ret) {
+		IWL_ERR(mld, "Failed to start NAN. ret=%d\n", ret);
+		iwl_mld_remove_aux_sta(mld, vif);
+	}
+
+	return ret;
+}
+
+int iwl_mld_stop_nan(struct ieee80211_hw *hw,
+		     struct ieee80211_vif *vif)
+{
+	struct iwl_mld *mld = IWL_MAC80211_GET_MLD(hw);
+	struct iwl_mld_vif *mld_vif = iwl_mld_vif_from_mac80211(vif);
+	struct iwl_nan_config_cmd cmd = {
+		.action = cpu_to_le32(FW_CTXT_ACTION_REMOVE),
+	};
+	int ret;
+
+	lockdep_assert_wiphy(mld->wiphy);
+
+	ret = iwl_mld_send_cmd_pdu(mld,
+				   WIDE_ID(MAC_CONF_GROUP, NAN_CFG_CMD),
+				   &cmd);
+	if (ret)
+		IWL_ERR(mld, "NAN: Failed to stop NAN. ret=%d\n", ret);
+
+	/* assume that higher layer guarantees that no additional frames are
+	 * added before calling this callback
+	 */
+	iwl_mld_flush_link_sta_txqs(mld, mld_vif->aux_sta.sta_id);
+	iwl_mld_remove_aux_sta(mld, vif);
+
+	return 0;
+}
+
+void iwl_mld_handle_nan_cluster_notif(struct iwl_mld *mld,
+				      struct iwl_rx_packet *pkt)
+{
+	struct iwl_nan_cluster_notif *notif = (void *)pkt->data;
+
+	IWL_DEBUG_INFO(mld,
+		       "NAN: cluster event: cluster_id=0x%x, flags=0x%x\n",
+		       le16_to_cpu(notif->cluster_id), notif->flags);
+}
+
+void iwl_mld_handle_nan_dw_end_notif(struct iwl_mld *mld,
+				     struct iwl_rx_packet *pkt)
+{
+	struct iwl_nan_dw_end_notif *notif = (void *)pkt->data;
+	struct iwl_mld_vif *mld_vif = mld->nan_device_vif ?
+		iwl_mld_vif_from_mac80211(mld->nan_device_vif) :
+		NULL;
+
+	IWL_INFO(mld, "NAN: DW end: band=%u\n", notif->band);
+
+	if (!mld_vif)
+		return;
+
+	if (WARN_ON(mld_vif->aux_sta.sta_id == IWL_INVALID_STA))
+		return;
+
+	IWL_DEBUG_INFO(mld, "NAN: flush queues for aux sta=%u\n",
+		       mld_vif->aux_sta.sta_id);
+
+	iwl_mld_flush_link_sta_txqs(mld, mld_vif->aux_sta.sta_id);
+}
diff --git a/drivers/net/wireless/intel/iwlwifi/mld/nan.h b/drivers/net/wireless/intel/iwlwifi/mld/nan.h
new file mode 100644
index 000000000000..c7b621393655
--- /dev/null
+++ b/drivers/net/wireless/intel/iwlwifi/mld/nan.h
@@ -0,0 +1,18 @@
+/* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
+/*
+ * Copyright (C) 2025 Intel Corporation
+ */
+
+#include <net/cfg80211.h>
+#include <linux/etherdevice.h>
+
+bool iwl_mld_nan_supported(struct iwl_mld *mld);
+int iwl_mld_start_nan(struct ieee80211_hw *hw,
+		      struct ieee80211_vif *vif,
+		      struct cfg80211_nan_conf *conf);
+int iwl_mld_stop_nan(struct ieee80211_hw *hw,
+		     struct ieee80211_vif *vif);
+void iwl_mld_handle_nan_cluster_notif(struct iwl_mld *mld,
+				      struct iwl_rx_packet *pkt);
+void iwl_mld_handle_nan_dw_end_notif(struct iwl_mld *mld,
+				     struct iwl_rx_packet *pkt);
diff --git a/drivers/net/wireless/intel/iwlwifi/mld/notif.c b/drivers/net/wireless/intel/iwlwifi/mld/notif.c
index 4cf3920b005f..eedb4818c647 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/notif.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/notif.c
@@ -344,6 +344,8 @@ CMD_VERSIONS(time_sync_confirm_notif,
 	     CMD_VER_ENTRY(1, iwl_time_msmt_cfm_notify))
 CMD_VERSIONS(ftm_resp_notif, CMD_VER_ENTRY(10, iwl_tof_range_rsp_ntfy))
 CMD_VERSIONS(beacon_filter_notif, CMD_VER_ENTRY(2, iwl_beacon_filter_notif))
+CMD_VERSIONS(nan_cluster_notif, CMD_VER_ENTRY(1, iwl_nan_cluster_notif))
+CMD_VERSIONS(nan_dw_end_notif, CMD_VER_ENTRY(1, iwl_nan_dw_end_notif))
 
 DEFINE_SIMPLE_CANCELLATION(session_prot, iwl_session_prot_notif, mac_link_id)
 DEFINE_SIMPLE_CANCELLATION(tlc, iwl_tlc_update_notif, sta_id)
@@ -459,6 +461,10 @@ const struct iwl_rx_handler iwl_mld_rx_handlers[] = {
 			   beacon_filter_notif)
 	RX_HANDLER_OF_FTM_REQ(LOCATION_GROUP, TOF_RANGE_RESPONSE_NOTIF,
 			      ftm_resp_notif)
+	RX_HANDLER_NO_OBJECT(MAC_CONF_GROUP, NAN_JOINED_CLUSTER_NOTIF,
+			     nan_cluster_notif, RX_HANDLER_ASYNC)
+	RX_HANDLER_NO_OBJECT(MAC_CONF_GROUP, NAN_DW_END_NOTIF,
+			     nan_dw_end_notif, RX_HANDLER_ASYNC)
 };
 EXPORT_SYMBOL_IF_IWLWIFI_KUNIT(iwl_mld_rx_handlers);
 
diff --git a/drivers/net/wireless/intel/iwlwifi/mld/sta.c b/drivers/net/wireless/intel/iwlwifi/mld/sta.c
index 61ecc33116cf..6056a306f7cb 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/sta.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/sta.c
@@ -1163,7 +1163,8 @@ void iwl_mld_remove_aux_sta(struct iwl_mld *mld,
 	struct iwl_mld_vif *mld_vif = iwl_mld_vif_from_mac80211(vif);
 
 	if (WARN_ON(vif->type != NL80211_IFTYPE_P2P_DEVICE &&
-		    vif->type != NL80211_IFTYPE_STATION))
+		    vif->type != NL80211_IFTYPE_STATION &&
+		    vif->type != NL80211_IFTYPE_NAN))
 		return;
 
 	iwl_mld_remove_internal_sta(mld, &mld_vif->aux_sta, false,
diff --git a/drivers/net/wireless/intel/iwlwifi/mld/tx.c b/drivers/net/wireless/intel/iwlwifi/mld/tx.c
index 3b4b575aadaa..9af4d73e3444 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/tx.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/tx.c
@@ -666,6 +666,12 @@ iwl_mld_get_tx_queue_id(struct iwl_mld *mld, struct ieee80211_txq *txq,
 		}
 
 		WARN_ON(!ieee80211_is_mgmt(fc));
+		return mld_vif->aux_sta.queue_id;
+	case NL80211_IFTYPE_NAN:
+		mld_vif = iwl_mld_vif_from_mac80211(info->control.vif);
+
+		WARN_ON(!ieee80211_is_mgmt(fc));
+
 		return mld_vif->aux_sta.queue_id;
 	default:
 		WARN_ONCE(1, "Unsupported vif type\n");
-- 
2.34.1


