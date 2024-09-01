Return-Path: <linux-wireless+bounces-12293-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 178919674F0
	for <lists+linux-wireless@lfdr.de>; Sun,  1 Sep 2024 06:18:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 59FF0B21AC1
	for <lists+linux-wireless@lfdr.de>; Sun,  1 Sep 2024 04:18:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 124353BBC0;
	Sun,  1 Sep 2024 04:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aIeCZJqM"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14EB1381BD
	for <linux-wireless@vger.kernel.org>; Sun,  1 Sep 2024 04:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725164294; cv=none; b=WAcaksqpZ39ZbWFFP4LNz+rpGJVS64Z18DPAak5fvAGjMIsZX7NtAvbnSAlnMijQS6Bc2ehRbiZHW6hjfXHjiGDab8CjyndxzEoDVUA8oY3T3L5vhX0H728cH+UaAuJOzkfR8WLX3nnAOBuOpj+QmP+jmQ3OHmlTmFPpe+tYeP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725164294; c=relaxed/simple;
	bh=fOfQzoNk+R3DcJVryV0aj2/xp2vlB7u2Lm9Ynu+DxqY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hjvd6KpOBA8zPrmjqa0LwR+oklzQMiPXYPBDXA4lhS7QyicUPlmZjWfy13Dzo5qRXYWTntqca71Nr5peOFQSg87qU0L+l2hQ1F/u7xBAobli3RAvoXR4wpH6N8y3HQ7VrgVcWquA1i5ST23YSwkWEdXxfasPiEmHtos+Jbi0Vmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aIeCZJqM; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725164292; x=1756700292;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=fOfQzoNk+R3DcJVryV0aj2/xp2vlB7u2Lm9Ynu+DxqY=;
  b=aIeCZJqMt5hvaBdJKk1F5DW+A8NiIlVuYyCRKSqc+PxEoQl7WaWWxvBm
   5L3VSpEfCszyhbYi5F0rgfwJtOmhdDTlNv0QSNXbHS6jmLD0Z2bzESBas
   1KCMrIKYtaeuPBremqqb88ITk9FeHJ8xMnVF3jID0QBvokH0J1MDcimd0
   KN2f/THPpOAYu92yj+LFaoAmXairc7lmOjhKKJDP0kZZneTAFi1+gv/SG
   DtOZhR6B78H/rfb6bNc6sgxl07vJCj+EZ65OdCZOP4YX2d/7ZGsSfRHcL
   4fmoifRLKPbwT8R3AhnjNpclebBzyza9mH4bNVmYcsHF+T8HzIPRYrRyj
   g==;
X-CSE-ConnectionGUID: xuRlqFELRfO5dN5SirK5MQ==
X-CSE-MsgGUID: JjVeLaCEQjCL1cMPtM5IlQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11181"; a="27559519"
X-IronPort-AV: E=Sophos;i="6.10,193,1719903600"; 
   d="scan'208";a="27559519"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2024 21:18:12 -0700
X-CSE-ConnectionGUID: nCC6JPaLQmiQm7DhCxw8yQ==
X-CSE-MsgGUID: lhIQK249QvGIz8C0cnb8dQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,193,1719903600"; 
   d="scan'208";a="64276308"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2024 21:18:10 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Subject: [PATCH 3/8] wifi: iwlwifi: s/IWL_MVM_STATION_COUNT_MAX/IWL_STATION_COUNT_MAX
Date: Sun,  1 Sep 2024 07:17:52 +0300
Message-Id: <20240901071542.5d71a0a2b56c.I7e0fe636d914852963e7a2f5e6037d0c3e367145@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240901041757.917200-1-miriam.rachel.korenblit@intel.com>
References: <20240901041757.917200-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

This isn't mvm specific.

Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Reviewed-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/fw/api/mac.h   |  2 +-
 drivers/net/wireless/intel/iwlwifi/fw/api/stats.h | 10 +++++-----
 drivers/net/wireless/intel/iwlwifi/iwl-drv.c      |  4 ++--
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h      |  4 ++--
 drivers/net/wireless/intel/iwlwifi/mvm/ops.c      |  4 ++--
 drivers/net/wireless/intel/iwlwifi/mvm/rx.c       |  8 ++++----
 drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c     |  2 +-
 drivers/net/wireless/intel/iwlwifi/mvm/sta.c      |  2 +-
 drivers/net/wireless/intel/iwlwifi/mvm/sta.h      |  2 +-
 9 files changed, 19 insertions(+), 19 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/mac.h b/drivers/net/wireless/intel/iwlwifi/fw/api/mac.h
index 490215e71e5d..977ca4ac166d 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/mac.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/mac.h
@@ -16,7 +16,7 @@
 #define NUM_MAC_INDEX		(NUM_MAC_INDEX_DRIVER + 1)
 #define NUM_MAC_INDEX_CDB	(NUM_MAC_INDEX_DRIVER + 2)
 
-#define IWL_MVM_STATION_COUNT_MAX	16
+#define IWL_STATION_COUNT_MAX	16
 #define IWL_MVM_INVALID_STA		0xFF
 
 enum iwl_ac {
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/stats.h b/drivers/net/wireless/intel/iwlwifi/fw/api/stats.h
index 659cb40ecfb4..0a9f14fb04be 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/stats.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/stats.h
@@ -327,14 +327,14 @@ struct mvm_statistics_load {
 	__le32 air_time[MAC_INDEX_AUX];
 	__le32 byte_count[MAC_INDEX_AUX];
 	__le32 pkt_count[MAC_INDEX_AUX];
-	u8 avg_energy[IWL_MVM_STATION_COUNT_MAX];
+	u8 avg_energy[IWL_STATION_COUNT_MAX];
 } __packed; /* STATISTICS_RX_MAC_STATION_S_VER_3 */
 
 struct mvm_statistics_load_v1 {
 	__le32 air_time[NUM_MAC_INDEX];
 	__le32 byte_count[NUM_MAC_INDEX];
 	__le32 pkt_count[NUM_MAC_INDEX];
-	u8 avg_energy[IWL_MVM_STATION_COUNT_MAX];
+	u8 avg_energy[IWL_STATION_COUNT_MAX];
 } __packed; /* STATISTICS_RX_MAC_STATION_S_VER_1 */
 
 struct mvm_statistics_rx {
@@ -608,7 +608,7 @@ struct iwl_system_statistics_notif_oper {
 	__le32 time_stamp;
 	struct iwl_stats_ntfy_per_link per_link[IWL_STATS_MAX_FW_LINKS];
 	struct iwl_stats_ntfy_per_phy per_phy[IWL_STATS_MAX_PHY_OPERATIONAL];
-	struct iwl_stats_ntfy_per_sta per_sta[IWL_MVM_STATION_COUNT_MAX];
+	struct iwl_stats_ntfy_per_sta per_sta[IWL_STATION_COUNT_MAX];
 } __packed; /* STATISTICS_FW_NTFY_OPERATIONAL_API_S_VER_3 */
 
 /**
@@ -651,7 +651,7 @@ struct iwl_statistics_operational_ntfy {
 	__le32 flags;
 	struct iwl_stats_ntfy_per_mac per_mac[MAC_INDEX_AUX];
 	struct iwl_stats_ntfy_per_phy per_phy[IWL_STATS_MAX_PHY_OPERATIONAL];
-	struct iwl_stats_ntfy_per_sta per_sta[IWL_MVM_STATION_COUNT_MAX];
+	struct iwl_stats_ntfy_per_sta per_sta[IWL_STATION_COUNT_MAX];
 	__le64 rx_time;
 	__le64 tx_time;
 	__le64 on_time_rf;
@@ -699,7 +699,7 @@ struct iwl_statistics_operational_ntfy_ver_14 {
 	__le64 tx_time;
 	__le64 on_time_rf;
 	__le64 on_time_scan;
-	__le32 average_energy[IWL_MVM_STATION_COUNT_MAX];
+	__le32 average_energy[IWL_STATION_COUNT_MAX];
 	__le32 reserved;
 } __packed; /* STATISTICS_OPERATIONAL_NTFY_API_S_VER_14 */
 
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-drv.c b/drivers/net/wireless/intel/iwlwifi/iwl-drv.c
index aaaabd67f959..2abfc986701f 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-drv.c
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-drv.c
@@ -1205,7 +1205,7 @@ static int iwl_parse_tlv_firmware(struct iwl_drv *drv,
 			if (tlv_len != sizeof(u32))
 				goto invalid_tlv_len;
 			if (le32_to_cpup((const __le32 *)tlv_data) >
-			    IWL_MVM_STATION_COUNT_MAX) {
+			    IWL_STATION_COUNT_MAX) {
 				IWL_ERR(drv,
 					"%d is an invalid number of station\n",
 					le32_to_cpup((const __le32 *)tlv_data));
@@ -1479,7 +1479,7 @@ static void iwl_req_fw_callback(const struct firmware *ucode_raw, void *context)
 	fw->ucode_capa.standard_phy_calibration_size =
 			IWL_DEFAULT_STANDARD_PHY_CALIBRATE_TBL_SIZE;
 	fw->ucode_capa.n_scan_channels = IWL_DEFAULT_SCAN_CHANNELS;
-	fw->ucode_capa.num_stations = IWL_MVM_STATION_COUNT_MAX;
+	fw->ucode_capa.num_stations = IWL_STATION_COUNT_MAX;
 	fw->ucode_capa.num_beacons = 1;
 	/* dump all fw memory areas by default */
 	fw->dbg.dump_mask = 0xffffffff;
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
index 26adf9f9b8c3..ec9b8be12766 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
@@ -1078,8 +1078,8 @@ struct iwl_mvm {
 
 	/* data related to data path */
 	struct iwl_rx_phy_info last_phy_info;
-	struct ieee80211_sta __rcu *fw_id_to_mac_id[IWL_MVM_STATION_COUNT_MAX];
-	struct ieee80211_link_sta __rcu *fw_id_to_link_sta[IWL_MVM_STATION_COUNT_MAX];
+	struct ieee80211_sta __rcu *fw_id_to_mac_id[IWL_STATION_COUNT_MAX];
+	struct ieee80211_link_sta __rcu *fw_id_to_link_sta[IWL_STATION_COUNT_MAX];
 	u8 rx_ba_sessions;
 
 	/* configured by mac80211 */
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/ops.c b/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
index 273767b074b8..d3ab959f497a 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
@@ -1285,12 +1285,12 @@ iwl_op_mode_mvm_start(struct iwl_trans *trans, const struct iwl_cfg *cfg,
 	struct iwl_mvm_csme_conn_info *csme_conn_info __maybe_unused;
 
 	/*
-	 * We use IWL_MVM_STATION_COUNT_MAX to check the validity of the station
+	 * We use IWL_STATION_COUNT_MAX to check the validity of the station
 	 * index all over the driver - check that its value corresponds to the
 	 * array size.
 	 */
 	BUILD_BUG_ON(ARRAY_SIZE(mvm->fw_id_to_mac_id) !=
-		     IWL_MVM_STATION_COUNT_MAX);
+		     IWL_STATION_COUNT_MAX);
 
 	/********************************
 	 * 1. Allocating and configuring HW data
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/rx.c b/drivers/net/wireless/intel/iwlwifi/mvm/rx.c
index 3b5bbece63f6..047c020f8efa 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/rx.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/rx.c
@@ -738,8 +738,8 @@ static void iwl_mvm_stats_energy_iter(void *_data,
 	u8 *energy = _data;
 	u32 sta_id = mvmsta->deflink.sta_id;
 
-	if (WARN_ONCE(sta_id >= IWL_MVM_STATION_COUNT_MAX, "sta_id %d >= %d",
-		      sta_id, IWL_MVM_STATION_COUNT_MAX))
+	if (WARN_ONCE(sta_id >= IWL_STATION_COUNT_MAX, "sta_id %d >= %d",
+		      sta_id, IWL_STATION_COUNT_MAX))
 		return;
 
 	if (energy[sta_id])
@@ -1042,7 +1042,7 @@ static void iwl_mvm_update_esr_mode_tpt(struct iwl_mvm *mvm)
 void iwl_mvm_handle_rx_system_oper_stats(struct iwl_mvm *mvm,
 					 struct iwl_rx_cmd_buffer *rxb)
 {
-	u8 average_energy[IWL_MVM_STATION_COUNT_MAX];
+	u8 average_energy[IWL_STATION_COUNT_MAX];
 	struct iwl_rx_packet *pkt = rxb_addr(rxb);
 	struct iwl_system_statistics_notif_oper *stats;
 	int i;
@@ -1101,7 +1101,7 @@ static void
 iwl_mvm_handle_rx_statistics_tlv(struct iwl_mvm *mvm,
 				 struct iwl_rx_packet *pkt)
 {
-	u8 average_energy[IWL_MVM_STATION_COUNT_MAX];
+	u8 average_energy[IWL_STATION_COUNT_MAX];
 	__le32 air_time[MAC_INDEX_AUX];
 	__le32 rx_bytes[MAC_INDEX_AUX];
 	__le32 flags = 0;
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c b/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c
index 1a210d0c22b3..ae0f2aabddc3 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c
@@ -2542,7 +2542,7 @@ void iwl_mvm_rx_bar_frame_release(struct iwl_mvm *mvm, struct napi_struct *napi,
 		goto out;
 	}
 
-	if (WARN(tid != baid_data->tid || sta_id > IWL_MVM_STATION_COUNT_MAX ||
+	if (WARN(tid != baid_data->tid || sta_id > IWL_STATION_COUNT_MAX ||
 		 !(baid_data->sta_mask & BIT(sta_id)),
 		 "baid 0x%x is mapped to sta_mask:0x%x tid:%d, but BAR release received for sta:%d tid:%d\n",
 		 baid, baid_data->sta_mask, baid_data->tid, sta_id,
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/sta.c b/drivers/net/wireless/intel/iwlwifi/mvm/sta.c
index 74bbeebe69d5..b6c99cd6d9e5 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/sta.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/sta.c
@@ -29,7 +29,7 @@ int iwl_mvm_find_free_sta_id(struct iwl_mvm *mvm, enum nl80211_iftype iftype)
 	int sta_id;
 	u32 reserved_ids = 0;
 
-	BUILD_BUG_ON(IWL_MVM_STATION_COUNT_MAX > 32);
+	BUILD_BUG_ON(IWL_STATION_COUNT_MAX > 32);
 	WARN_ON_ONCE(test_bit(IWL_MVM_STATUS_IN_HW_RESTART, &mvm->status));
 
 	lockdep_assert_held(&mvm->mutex);
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/sta.h b/drivers/net/wireless/intel/iwlwifi/mvm/sta.h
index 193a1edc38d2..4a3799ae7c18 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/sta.h
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/sta.h
@@ -12,7 +12,7 @@
 #include <linux/wait.h>
 
 #include "iwl-trans.h" /* for IWL_MAX_TID_COUNT */
-#include "fw-api.h" /* IWL_MVM_STATION_COUNT_MAX */
+#include "fw-api.h" /* IWL_STATION_COUNT_MAX */
 #include "rs.h"
 
 struct iwl_mvm;
-- 
2.34.1


