Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA5112876C4
	for <lists+linux-wireless@lfdr.de>; Thu,  8 Oct 2020 17:10:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730892AbgJHPJ6 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 8 Oct 2020 11:09:58 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:54448 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730831AbgJHPJ5 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 8 Oct 2020 11:09:57 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <luca@coelho.fi>)
        id 1kQXYH-002Qut-Hu; Thu, 08 Oct 2020 18:09:54 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Thu,  8 Oct 2020 18:09:37 +0300
Message-Id: <iwlwifi.20201008180656.863ab470babc.I393223392f36436663c4e66add03fefe77b74e60@changeid>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201008150949.331882-1-luca@coelho.fi>
References: <20201008150949.331882-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.4
Subject: [PATCH 01/13] iwlwifi: mvm: get number of stations from TLV
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Nathan Errera <nathan.errera@intel.com>

FW is changing the max number of supported stations. To adapt to the
change we get the max number from the TLV and act according to the new
number.

Signed-off-by: Nathan Errera <nathan.errera@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/fw/api/mac.h   |  2 +-
 drivers/net/wireless/intel/iwlwifi/fw/api/stats.h | 10 ++++------
 drivers/net/wireless/intel/iwlwifi/fw/file.h      |  3 +++
 drivers/net/wireless/intel/iwlwifi/fw/img.h       |  1 +
 drivers/net/wireless/intel/iwlwifi/iwl-drv.c      | 15 +++++++++++++++
 drivers/net/wireless/intel/iwlwifi/mvm/debugfs.c  |  4 ++--
 drivers/net/wireless/intel/iwlwifi/mvm/fw.c       |  4 ++--
 drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c |  2 +-
 drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c |  8 ++++----
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h      |  6 +++---
 drivers/net/wireless/intel/iwlwifi/mvm/ops.c      |  7 ++++---
 drivers/net/wireless/intel/iwlwifi/mvm/rx.c       |  4 ++--
 drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c     |  2 +-
 drivers/net/wireless/intel/iwlwifi/mvm/sta.c      |  8 ++++----
 drivers/net/wireless/intel/iwlwifi/mvm/sta.h      |  2 +-
 drivers/net/wireless/intel/iwlwifi/mvm/tdls.c     | 12 ++++++------
 drivers/net/wireless/intel/iwlwifi/mvm/tt.c       |  2 +-
 drivers/net/wireless/intel/iwlwifi/mvm/tx.c       |  2 +-
 18 files changed, 56 insertions(+), 38 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/mac.h b/drivers/net/wireless/intel/iwlwifi/fw/api/mac.h
index afc3eccfa718..260f9978a6ef 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/mac.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/mac.h
@@ -70,7 +70,7 @@
 #define NUM_MAC_INDEX		(NUM_MAC_INDEX_DRIVER + 1)
 #define NUM_MAC_INDEX_CDB	(NUM_MAC_INDEX_DRIVER + 2)
 
-#define IWL_MVM_STATION_COUNT		16
+#define IWL_MVM_STATION_COUNT_MAX	16
 #define IWL_MVM_INVALID_STA		0xFF
 
 enum iwl_ac {
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/stats.h b/drivers/net/wireless/intel/iwlwifi/fw/api/stats.h
index 318843138490..35265c4e8c19 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/stats.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/stats.h
@@ -5,10 +5,9 @@
  *
  * GPL LICENSE SUMMARY
  *
- * Copyright(c) 2012 - 2014 Intel Corporation. All rights reserved.
  * Copyright(c) 2013 - 2015 Intel Mobile Communications GmbH
  * Copyright(c) 2016 - 2017 Intel Deutschland GmbH
- * Copyright (C) 2018 Intel Corporation
+ * Copyright(c) 2012 - 2014, 2018, 2020 Intel Corporation
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of version 2 of the GNU General Public License as
@@ -28,9 +27,8 @@
  *
  * BSD LICENSE
  *
- * Copyright(c) 2012 - 2014 Intel Corporation. All rights reserved.
  * Copyright(c) 2013 - 2015 Intel Mobile Communications GmbH
- * Copyright (C) 2018 Intel Corporation
+ * Copyright(c) 2012 - 2014, 2018, 2020 Intel Corporation
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
@@ -383,14 +381,14 @@ struct mvm_statistics_load {
 	__le32 air_time[MAC_INDEX_AUX];
 	__le32 byte_count[MAC_INDEX_AUX];
 	__le32 pkt_count[MAC_INDEX_AUX];
-	u8 avg_energy[IWL_MVM_STATION_COUNT];
+	u8 avg_energy[IWL_MVM_STATION_COUNT_MAX];
 } __packed; /* STATISTICS_RX_MAC_STATION_S_VER_3 */
 
 struct mvm_statistics_load_v1 {
 	__le32 air_time[NUM_MAC_INDEX];
 	__le32 byte_count[NUM_MAC_INDEX];
 	__le32 pkt_count[NUM_MAC_INDEX];
-	u8 avg_energy[IWL_MVM_STATION_COUNT];
+	u8 avg_energy[IWL_MVM_STATION_COUNT_MAX];
 } __packed; /* STATISTICS_RX_MAC_STATION_S_VER_1 */
 
 struct mvm_statistics_rx {
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/file.h b/drivers/net/wireless/intel/iwlwifi/fw/file.h
index 044b9d4ca4d1..1b7be350828d 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/file.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/file.h
@@ -90,6 +90,7 @@ struct iwl_ucode_header {
 };
 
 #define IWL_UCODE_TLV_DEBUG_BASE	0x1000005
+#define IWL_UCODE_TLV_CONST_BASE	0x100
 
 /*
  * new TLV uCode file layout
@@ -147,6 +148,8 @@ enum iwl_ucode_tlv_type {
 	IWL_UCODE_TLV_FW_RECOVERY_INFO	= 57,
 	IWL_UCODE_TLV_FW_FSEQ_VERSION	= 60,
 
+	IWL_UCODE_TLV_FW_NUM_STATIONS		= IWL_UCODE_TLV_CONST_BASE + 0,
+
 	IWL_UCODE_TLV_TYPE_DEBUG_INFO		= IWL_UCODE_TLV_DEBUG_BASE + 0,
 	IWL_UCODE_TLV_TYPE_BUFFER_ALLOCATION	= IWL_UCODE_TLV_DEBUG_BASE + 1,
 	IWL_UCODE_TLV_TYPE_HCMD			= IWL_UCODE_TLV_DEBUG_BASE + 2,
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/img.h b/drivers/net/wireless/intel/iwlwifi/fw/img.h
index 07d72bcf9c46..f836f3a8567b 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/img.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/img.h
@@ -106,6 +106,7 @@ struct iwl_ucode_capabilities {
 	u32 flags;
 	u32 error_log_addr;
 	u32 error_log_size;
+	u32 num_stations;
 	unsigned long _api[BITS_TO_LONGS(NUM_IWL_UCODE_TLV_API)];
 	unsigned long _capa[BITS_TO_LONGS(NUM_IWL_UCODE_TLV_CAPA)];
 
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-drv.c b/drivers/net/wireless/intel/iwlwifi/iwl-drv.c
index 2a9075b1b374..9dcd2e990c9c 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-drv.c
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-drv.c
@@ -76,6 +76,7 @@
 #include "iwl-config.h"
 #include "iwl-modparams.h"
 #include "fw/api/alive.h"
+#include "fw/api/mac.h"
 
 /******************************************************************************
  *
@@ -1127,6 +1128,19 @@ static int iwl_parse_tlv_firmware(struct iwl_drv *drv,
 				 fseq_ver->version);
 			}
 			break;
+		case IWL_UCODE_TLV_FW_NUM_STATIONS:
+			if (tlv_len != sizeof(u32))
+				goto invalid_tlv_len;
+			if (le32_to_cpup((__le32 *)tlv_data) >
+			    IWL_MVM_STATION_COUNT_MAX) {
+				IWL_ERR(drv,
+					"%d is an invalid number of station\n",
+					le32_to_cpup((__le32 *)tlv_data));
+				goto tlv_error;
+			}
+			capa->num_stations =
+				le32_to_cpup((__le32 *)tlv_data);
+			break;
 		case IWL_UCODE_TLV_UMAC_DEBUG_ADDRS: {
 			struct iwl_umac_debug_addrs *dbg_ptrs =
 				(void *)tlv_data;
@@ -1348,6 +1362,7 @@ static void iwl_req_fw_callback(const struct firmware *ucode_raw, void *context)
 	fw->ucode_capa.standard_phy_calibration_size =
 			IWL_DEFAULT_STANDARD_PHY_CALIBRATE_TBL_SIZE;
 	fw->ucode_capa.n_scan_channels = IWL_DEFAULT_SCAN_CHANNELS;
+	fw->ucode_capa.num_stations = IWL_MVM_STATION_COUNT_MAX;
 	/* dump all fw memory areas by default */
 	fw->dbg.dump_mask = 0xffffffff;
 
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/debugfs.c b/drivers/net/wireless/intel/iwlwifi/mvm/debugfs.c
index 8fae7e707374..3395c4675988 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/debugfs.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/debugfs.c
@@ -174,7 +174,7 @@ static ssize_t iwl_dbgfs_sta_drain_write(struct iwl_mvm *mvm, char *buf,
 
 	if (sscanf(buf, "%d %d", &sta_id, &drain) != 2)
 		return -EINVAL;
-	if (sta_id < 0 || sta_id >= IWL_MVM_STATION_COUNT)
+	if (sta_id < 0 || sta_id >= mvm->fw->ucode_capa.num_stations)
 		return -EINVAL;
 	if (drain < 0 || drain > 1)
 		return -EINVAL;
@@ -403,7 +403,7 @@ static ssize_t iwl_dbgfs_stations_read(struct file *file, char __user *user_buf,
 
 	mutex_lock(&mvm->mutex);
 
-	for (i = 0; i < ARRAY_SIZE(mvm->fw_id_to_mac_id); i++) {
+	for (i = 0; i < mvm->fw->ucode_capa.num_stations; i++) {
 		pos += scnprintf(buf + pos, bufsz - pos, "%.2d: ", i);
 		sta = rcu_dereference_protected(mvm->fw_id_to_mac_id[i],
 						lockdep_is_held(&mvm->mutex));
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
index 4ea1032d8263..1c966586c8a8 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
@@ -1400,7 +1400,7 @@ int iwl_mvm_up(struct iwl_mvm *mvm)
 	}
 
 	/* init the fw <-> mac80211 STA mapping */
-	for (i = 0; i < ARRAY_SIZE(mvm->fw_id_to_mac_id); i++)
+	for (i = 0; i < mvm->fw->ucode_capa.num_stations; i++)
 		RCU_INIT_POINTER(mvm->fw_id_to_mac_id[i], NULL);
 
 	mvm->tdls_cs.peer.sta_id = IWL_MVM_INVALID_STA;
@@ -1563,7 +1563,7 @@ int iwl_mvm_load_d3_fw(struct iwl_mvm *mvm)
 		goto error;
 
 	/* init the fw <-> mac80211 STA mapping */
-	for (i = 0; i < ARRAY_SIZE(mvm->fw_id_to_mac_id); i++)
+	for (i = 0; i < mvm->fw->ucode_capa.num_stations; i++)
 		RCU_INIT_POINTER(mvm->fw_id_to_mac_id[i], NULL);
 
 	/* Add auxiliary station for scanning */
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c
index 8c98def8b7f7..afd3e220e893 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c
@@ -663,7 +663,7 @@ static int iwl_mvm_mac_ctxt_cmd_sta(struct iwl_mvm *mvm,
 		 * allow multicast data frames only as long as the station is
 		 * authorized, i.e., GTK keys are already installed (if needed)
 		 */
-		if (ap_sta_id < IWL_MVM_STATION_COUNT) {
+		if (ap_sta_id < mvm->fw->ucode_capa.num_stations) {
 			struct ieee80211_sta *sta;
 
 			rcu_read_lock();
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
index 5c9bde99ce19..d1ba9d11244f 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
@@ -826,7 +826,7 @@ static void iwl_mvm_mac_tx(struct ieee80211_hw *hw,
 			iwl_mvm_vif_from_mac80211(info->control.vif);
 		u8 ap_sta_id = READ_ONCE(mvmvif->ap_sta_id);
 
-		if (ap_sta_id < IWL_MVM_STATION_COUNT) {
+		if (ap_sta_id < mvm->fw->ucode_capa.num_stations) {
 			/* mac80211 holds rcu read lock */
 			sta = rcu_dereference(mvm->fw_id_to_mac_id[ap_sta_id]);
 			if (IS_ERR_OR_NULL(sta))
@@ -2886,7 +2886,7 @@ void iwl_mvm_sta_pm_notif(struct iwl_mvm *mvm, struct iwl_rx_cmd_buffer *rxb)
 	struct iwl_mvm_sta *mvmsta;
 	bool sleeping = (notif->type != IWL_MVM_PM_EVENT_AWAKE);
 
-	if (WARN_ON(notif->sta_id >= ARRAY_SIZE(mvm->fw_id_to_mac_id)))
+	if (WARN_ON(notif->sta_id >= mvm->fw->ucode_capa.num_stations))
 		return;
 
 	rcu_read_lock();
@@ -4686,7 +4686,7 @@ static void iwl_mvm_flush_no_vif(struct iwl_mvm *mvm, u32 queues, bool drop)
 	}
 
 	mutex_lock(&mvm->mutex);
-	for (i = 0; i < ARRAY_SIZE(mvm->fw_id_to_mac_id); i++) {
+	for (i = 0; i < mvm->fw->ucode_capa.num_stations; i++) {
 		struct ieee80211_sta *sta;
 
 		sta = rcu_dereference_protected(mvm->fw_id_to_mac_id[i],
@@ -4728,7 +4728,7 @@ static void iwl_mvm_mac_flush(struct ieee80211_hw *hw,
 	mvmvif = iwl_mvm_vif_from_mac80211(vif);
 
 	/* flush the AP-station and all TDLS peers */
-	for (i = 0; i < ARRAY_SIZE(mvm->fw_id_to_mac_id); i++) {
+	for (i = 0; i < mvm->fw->ucode_capa.num_stations; i++) {
 		sta = rcu_dereference_protected(mvm->fw_id_to_mac_id[i],
 						lockdep_is_held(&mvm->mutex));
 		if (IS_ERR_OR_NULL(sta))
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
index 9187f8a1126d..e54bbf6965f4 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
@@ -888,7 +888,7 @@ struct iwl_mvm {
 
 	/* data related to data path */
 	struct iwl_rx_phy_info last_phy_info;
-	struct ieee80211_sta __rcu *fw_id_to_mac_id[IWL_MVM_STATION_COUNT];
+	struct ieee80211_sta __rcu *fw_id_to_mac_id[IWL_MVM_STATION_COUNT_MAX];
 	u8 rx_ba_sessions;
 
 	/* configured by mac80211 */
@@ -1205,7 +1205,7 @@ iwl_mvm_sta_from_staid_rcu(struct iwl_mvm *mvm, u8 sta_id)
 {
 	struct ieee80211_sta *sta;
 
-	if (sta_id >= ARRAY_SIZE(mvm->fw_id_to_mac_id))
+	if (sta_id >= mvm->fw->ucode_capa.num_stations)
 		return NULL;
 
 	sta = rcu_dereference(mvm->fw_id_to_mac_id[sta_id]);
@@ -1222,7 +1222,7 @@ iwl_mvm_sta_from_staid_protected(struct iwl_mvm *mvm, u8 sta_id)
 {
 	struct ieee80211_sta *sta;
 
-	if (sta_id >= ARRAY_SIZE(mvm->fw_id_to_mac_id))
+	if (sta_id >= mvm->fw->ucode_capa.num_stations)
 		return NULL;
 
 	sta = rcu_dereference_protected(mvm->fw_id_to_mac_id[sta_id],
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/ops.c b/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
index 46fe8a398c27..1e44a176b3d9 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
@@ -617,11 +617,12 @@ iwl_op_mode_mvm_start(struct iwl_trans *trans, const struct iwl_cfg *cfg,
 	enum iwl_amsdu_size rb_size_default;
 
 	/*
-	 * We use IWL_MVM_STATION_COUNT to check the validity of the station
+	 * We use IWL_MVM_STATION_COUNT_MAX to check the validity of the station
 	 * index all over the driver - check that its value corresponds to the
 	 * array size.
 	 */
-	BUILD_BUG_ON(ARRAY_SIZE(mvm->fw_id_to_mac_id) != IWL_MVM_STATION_COUNT);
+	BUILD_BUG_ON(ARRAY_SIZE(mvm->fw_id_to_mac_id) !=
+		     IWL_MVM_STATION_COUNT_MAX);
 
 	/********************************
 	 * 1. Allocating and configuring HW data
@@ -1109,7 +1110,7 @@ static void iwl_mvm_queue_state_change(struct iwl_op_mode *op_mode,
 		mvm->tvqm_info[hw_queue].sta_id :
 		mvm->queue_info[hw_queue].ra_sta_id;
 
-	if (WARN_ON_ONCE(sta_id >= ARRAY_SIZE(mvm->fw_id_to_mac_id)))
+	if (WARN_ON_ONCE(sta_id >= mvm->fw->ucode_capa.num_stations))
 		return;
 
 	rcu_read_lock();
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/rx.c b/drivers/net/wireless/intel/iwlwifi/mvm/rx.c
index 77b8def26edb..fe555986d863 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/rx.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/rx.c
@@ -420,7 +420,7 @@ void iwl_mvm_rx_rx_mpdu(struct iwl_mvm *mvm, struct napi_struct *napi,
 
 		id >>= RX_MDPU_RES_STATUS_STA_ID_SHIFT;
 
-		if (!WARN_ON_ONCE(id >= ARRAY_SIZE(mvm->fw_id_to_mac_id))) {
+		if (!WARN_ON_ONCE(id >= mvm->fw->ucode_capa.num_stations)) {
 			sta = rcu_dereference(mvm->fw_id_to_mac_id[id]);
 			if (IS_ERR(sta))
 				sta = NULL;
@@ -798,7 +798,7 @@ void iwl_mvm_handle_rx_statistics(struct iwl_mvm *mvm,
 	}
 
 	rcu_read_lock();
-	for (i = 0; i < ARRAY_SIZE(mvm->fw_id_to_mac_id); i++) {
+	for (i = 0; i < mvm->fw->ucode_capa.num_stations; i++) {
 		struct iwl_mvm_sta *sta;
 
 		if (!energy[i])
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c b/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c
index ea29aeb86eef..838734fec502 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c
@@ -1773,7 +1773,7 @@ void iwl_mvm_rx_mpdu_mq(struct iwl_mvm *mvm, struct napi_struct *napi,
 	if (desc->status & cpu_to_le32(IWL_RX_MPDU_STATUS_SRC_STA_FOUND)) {
 		u8 id = le32_get_bits(desc->status, IWL_RX_MPDU_STATUS_STA_ID);
 
-		if (!WARN_ON_ONCE(id >= ARRAY_SIZE(mvm->fw_id_to_mac_id))) {
+		if (!WARN_ON_ONCE(id >= mvm->fw->ucode_capa.num_stations)) {
 			sta = rcu_dereference(mvm->fw_id_to_mac_id[id]);
 			if (IS_ERR(sta))
 				sta = NULL;
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/sta.c b/drivers/net/wireless/intel/iwlwifi/mvm/sta.c
index 72c9235c6bd5..2eb5b2c9da13 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/sta.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/sta.c
@@ -85,7 +85,7 @@ static int iwl_mvm_find_free_sta_id(struct iwl_mvm *mvm,
 	int sta_id;
 	u32 reserved_ids = 0;
 
-	BUILD_BUG_ON(IWL_MVM_STATION_COUNT > 32);
+	BUILD_BUG_ON(IWL_MVM_STATION_COUNT_MAX > 32);
 	WARN_ON_ONCE(test_bit(IWL_MVM_STATUS_IN_HW_RESTART, &mvm->status));
 
 	lockdep_assert_held(&mvm->mutex);
@@ -95,7 +95,7 @@ static int iwl_mvm_find_free_sta_id(struct iwl_mvm *mvm,
 		reserved_ids = BIT(0);
 
 	/* Don't take rcu_read_lock() since we are protected by mvm->mutex */
-	for (sta_id = 0; sta_id < ARRAY_SIZE(mvm->fw_id_to_mac_id); sta_id++) {
+	for (sta_id = 0; sta_id < mvm->fw->ucode_capa.num_stations; sta_id++) {
 		if (BIT(sta_id) & reserved_ids)
 			continue;
 
@@ -3760,7 +3760,7 @@ void iwl_mvm_rx_eosp_notif(struct iwl_mvm *mvm,
 	struct ieee80211_sta *sta;
 	u32 sta_id = le32_to_cpu(notif->sta_id);
 
-	if (WARN_ON_ONCE(sta_id >= IWL_MVM_STATION_COUNT))
+	if (WARN_ON_ONCE(sta_id >= mvm->fw->ucode_capa.num_stations))
 		return;
 
 	rcu_read_lock();
@@ -3843,7 +3843,7 @@ void iwl_mvm_modify_all_sta_disable_tx(struct iwl_mvm *mvm,
 	lockdep_assert_held(&mvm->mutex);
 
 	/* Block/unblock all the stations of the given mvmvif */
-	for (i = 0; i < ARRAY_SIZE(mvm->fw_id_to_mac_id); i++) {
+	for (i = 0; i < mvm->fw->ucode_capa.num_stations; i++) {
 		sta = rcu_dereference_protected(mvm->fw_id_to_mac_id[i],
 						lockdep_is_held(&mvm->mutex));
 		if (IS_ERR_OR_NULL(sta))
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/sta.h b/drivers/net/wireless/intel/iwlwifi/mvm/sta.h
index 55dd2fb0a779..7b4120ce208c 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/sta.h
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/sta.h
@@ -70,7 +70,7 @@
 #include <linux/wait.h>
 
 #include "iwl-trans.h" /* for IWL_MAX_TID_COUNT */
-#include "fw-api.h" /* IWL_MVM_STATION_COUNT */
+#include "fw-api.h" /* IWL_MVM_STATION_COUNT_MAX */
 #include "rs.h"
 
 struct iwl_mvm;
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/tdls.c b/drivers/net/wireless/intel/iwlwifi/mvm/tdls.c
index d781777b6b96..2ad959b4ce0a 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/tdls.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/tdls.c
@@ -7,7 +7,7 @@
  *
  * Copyright(c) 2014 Intel Mobile Communications GmbH
  * Copyright(c) 2017 Intel Deutschland GmbH
- * Copyright(C) 2018 - 2019 Intel Corporation
+ * Copyright(C) 2018 - 2020 Intel Corporation
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of version 2 of the GNU General Public License as
@@ -29,7 +29,7 @@
  *
  * Copyright(c) 2014 Intel Mobile Communications GmbH
  * Copyright(c) 2017 Intel Deutschland GmbH
- * Copyright(C) 2018 - 2019 Intel Corporation
+ * Copyright(C) 2018 - 2020 Intel Corporation
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
@@ -77,7 +77,7 @@ void iwl_mvm_teardown_tdls_peers(struct iwl_mvm *mvm)
 
 	lockdep_assert_held(&mvm->mutex);
 
-	for (i = 0; i < ARRAY_SIZE(mvm->fw_id_to_mac_id); i++) {
+	for (i = 0; i < mvm->fw->ucode_capa.num_stations; i++) {
 		sta = rcu_dereference_protected(mvm->fw_id_to_mac_id[i],
 						lockdep_is_held(&mvm->mutex));
 		if (!sta || IS_ERR(sta) || !sta->tdls)
@@ -100,7 +100,7 @@ int iwl_mvm_tdls_sta_count(struct iwl_mvm *mvm, struct ieee80211_vif *vif)
 
 	lockdep_assert_held(&mvm->mutex);
 
-	for (i = 0; i < ARRAY_SIZE(mvm->fw_id_to_mac_id); i++) {
+	for (i = 0; i < mvm->fw->ucode_capa.num_stations; i++) {
 		sta = rcu_dereference_protected(mvm->fw_id_to_mac_id[i],
 						lockdep_is_held(&mvm->mutex));
 		if (!sta || IS_ERR(sta) || !sta->tdls)
@@ -144,7 +144,7 @@ static void iwl_mvm_tdls_config(struct iwl_mvm *mvm, struct ieee80211_vif *vif)
 
 	/* populate TDLS peer data */
 	cnt = 0;
-	for (i = 0; i < ARRAY_SIZE(mvm->fw_id_to_mac_id); i++) {
+	for (i = 0; i < mvm->fw->ucode_capa.num_stations; i++) {
 		sta = rcu_dereference_protected(mvm->fw_id_to_mac_id[i],
 						lockdep_is_held(&mvm->mutex));
 		if (IS_ERR_OR_NULL(sta) || !sta->tdls)
@@ -273,7 +273,7 @@ void iwl_mvm_rx_tdls_notif(struct iwl_mvm *mvm, struct iwl_rx_cmd_buffer *rxb)
 		return;
 	}
 
-	if (WARN_ON(sta_id >= IWL_MVM_STATION_COUNT))
+	if (WARN_ON(sta_id >= mvm->fw->ucode_capa.num_stations))
 		return;
 
 	sta = rcu_dereference_protected(mvm->fw_id_to_mac_id[sta_id],
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/tt.c b/drivers/net/wireless/intel/iwlwifi/mvm/tt.c
index 94e9b6de425e..d5ce0f9d3a85 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/tt.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/tt.c
@@ -399,7 +399,7 @@ static void iwl_mvm_tt_tx_protection(struct iwl_mvm *mvm, bool enable)
 	struct iwl_mvm_sta *mvmsta;
 	int i, err;
 
-	for (i = 0; i < ARRAY_SIZE(mvm->fw_id_to_mac_id); i++) {
+	for (i = 0; i < mvm->fw->ucode_capa.num_stations; i++) {
 		mvmsta = iwl_mvm_sta_from_staid_protected(mvm, i);
 		if (!mvmsta)
 			continue;
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/tx.c b/drivers/net/wireless/intel/iwlwifi/mvm/tx.c
index fb2ffa09b8da..8f347f2256b4 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/tx.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/tx.c
@@ -1774,7 +1774,7 @@ static void iwl_mvm_tx_reclaim(struct iwl_mvm *mvm, int sta_id, int tid,
 	struct sk_buff *skb;
 	int freed;
 
-	if (WARN_ONCE(sta_id >= IWL_MVM_STATION_COUNT ||
+	if (WARN_ONCE(sta_id >= mvm->fw->ucode_capa.num_stations ||
 		      tid > IWL_MAX_TID_COUNT,
 		      "sta_id %d tid %d", sta_id, tid))
 		return;
-- 
2.28.0

