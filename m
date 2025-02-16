Return-Path: <linux-wireless+bounces-18998-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4587BA3738E
	for <lists+linux-wireless@lfdr.de>; Sun, 16 Feb 2025 10:45:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1FB007A14CD
	for <lists+linux-wireless@lfdr.de>; Sun, 16 Feb 2025 09:44:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7B36290F;
	Sun, 16 Feb 2025 09:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ASz09UnU"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1544192D77
	for <linux-wireless@vger.kernel.org>; Sun, 16 Feb 2025 09:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739699054; cv=none; b=kmpQrlNmBxwtv7kKDs+5WEb0qkiCK87AgrNgqp49dIxf57ZLu8Z8yXuEaPHwN5VhQX57Gsl6xJwkyqiY0vkJCfqtGol11uAzWCK2beFH1xgjyAYXEYmJi3G0Co5XgnoEecPFIQQM6jItVrlaaykjiJ5K8CocyimkPGsz+LIG9pg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739699054; c=relaxed/simple;
	bh=JvUUpUzOi084KcwiO/ppvTxwvaMkgkgekqvypewdOjE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DAux+Pi6GtxhxEnCbOTVmwO+UGQVj0sAxNw/H68G46cRtNdJiA34cFDw7TjLWK6L2v+oFLAhyDVfaXelwLBZBluGepjszYPW95tTHNq/Mfd50YRooGK5TDFwip4/OeW9HP4KA9xAp1MxCbMlgEBEYZZrtd0l/QOCF7EXdF3Libg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ASz09UnU; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739699053; x=1771235053;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=JvUUpUzOi084KcwiO/ppvTxwvaMkgkgekqvypewdOjE=;
  b=ASz09UnUlhxPhfZj8rKLD/nX7I8d1m3a9Fk/CfwdJ7Tr/1hjpE+XtogO
   Owt66LhGq+HMn8jeuyjU8JrTEk5BgJhvYceSUCz9pG07zH784mGOFTPhD
   uzh+o1gRjFbM46ABkjIE82K2kYjIJ0oUimA/H2PsVMopvmq8blkL3b7j7
   AIZJyDkBUWYoYNhsY5TgAPe6oFYhPTAHzLBuMMs1bq52VYxcEYzn+96qz
   7gpCZYPVJnnZ0/uFjAlof4eZDWfY/CNXyC3Kr2Z4Jiw+5YIIOOKO1QCAq
   fQqogMl8KtSmsNCL8sMN8YwlKeVKv8CFPqjPiDBnwIY3Klx4cs6q5JKqS
   A==;
X-CSE-ConnectionGUID: hJ75fYPTRJeV6HgJd7DPaw==
X-CSE-MsgGUID: eyiFziwATtKXPf2gH20PLg==
X-IronPort-AV: E=McAfee;i="6700,10204,11346"; a="40323414"
X-IronPort-AV: E=Sophos;i="6.13,290,1732608000"; 
   d="scan'208";a="40323414"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2025 01:44:13 -0800
X-CSE-ConnectionGUID: F9H0Yd35R9mGC7M50exszw==
X-CSE-MsgGUID: RrwpizomTdyNoiKmpsAQKA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="118785263"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2025 01:44:12 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org
Subject: [PATCH 29/42] wifi: iwlwifi: mld: add file stats.h/c
Date: Sun, 16 Feb 2025 11:43:08 +0200
Message-Id: <20250216111648.4e84933ba588.Ib5add72720d10058151bd067dc88761c07e2dce2@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250216094321.537988-1-miriam.rachel.korenblit@intel.com>
References: <20250216094321.537988-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

these files are handling statistics

Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 .../net/wireless/intel/iwlwifi/mld/stats.c    | 510 ++++++++++++++++++
 .../net/wireless/intel/iwlwifi/mld/stats.h    |  22 +
 2 files changed, 532 insertions(+)
 create mode 100644 drivers/net/wireless/intel/iwlwifi/mld/stats.c
 create mode 100644 drivers/net/wireless/intel/iwlwifi/mld/stats.h

diff --git a/drivers/net/wireless/intel/iwlwifi/mld/stats.c b/drivers/net/wireless/intel/iwlwifi/mld/stats.c
new file mode 100644
index 000000000000..a307c74c7371
--- /dev/null
+++ b/drivers/net/wireless/intel/iwlwifi/mld/stats.c
@@ -0,0 +1,510 @@
+// SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
+/*
+ * Copyright (C) 2024-2025 Intel Corporation
+ */
+
+#include "mld.h"
+#include "stats.h"
+#include "sta.h"
+#include "mlo.h"
+#include "hcmd.h"
+#include "iface.h"
+#include "mlo.h"
+#include "scan.h"
+#include "phy.h"
+#include "fw/api/stats.h"
+
+static int iwl_mld_send_fw_stats_cmd(struct iwl_mld *mld, u32 cfg_mask,
+				     u32 cfg_time, u32 type_mask)
+{
+	u32 cmd_id = WIDE_ID(SYSTEM_GROUP, SYSTEM_STATISTICS_CMD);
+	struct iwl_system_statistics_cmd stats_cmd = {
+		.cfg_mask = cpu_to_le32(cfg_mask),
+		.config_time_sec = cpu_to_le32(cfg_time),
+		.type_id_mask = cpu_to_le32(type_mask),
+	};
+
+	return iwl_mld_send_cmd_pdu(mld, cmd_id, &stats_cmd);
+}
+
+int iwl_mld_clear_stats_in_fw(struct iwl_mld *mld)
+{
+	u32 cfg_mask = IWL_STATS_CFG_FLG_ON_DEMAND_NTFY_MSK;
+	u32 type_mask = IWL_STATS_NTFY_TYPE_ID_OPER |
+			IWL_STATS_NTFY_TYPE_ID_OPER_PART1;
+
+	return iwl_mld_send_fw_stats_cmd(mld, cfg_mask, 0, type_mask);
+}
+
+static void
+iwl_mld_fill_stats_from_oper_notif(struct iwl_mld *mld,
+				   struct iwl_rx_packet *pkt,
+				   u8 fw_sta_id, struct station_info *sinfo)
+{
+	const struct iwl_system_statistics_notif_oper *notif =
+		(void *)&pkt->data;
+	const struct iwl_stats_ntfy_per_sta *per_sta =
+		&notif->per_sta[fw_sta_id];
+	struct ieee80211_link_sta *link_sta;
+	struct iwl_mld_link_sta *mld_link_sta;
+
+	/* 0 isn't a valid value, but FW might send 0.
+	 * In that case, set the latest non-zero value we stored
+	 */
+	rcu_read_lock();
+
+	link_sta = rcu_dereference(mld->fw_id_to_link_sta[fw_sta_id]);
+	if (IS_ERR_OR_NULL(link_sta))
+		goto unlock;
+
+	mld_link_sta = iwl_mld_link_sta_from_mac80211(link_sta);
+	if (WARN_ON(!mld_link_sta))
+		goto unlock;
+
+	if (per_sta->average_energy)
+		mld_link_sta->signal_avg =
+			-(s8)le32_to_cpu(per_sta->average_energy);
+
+	sinfo->signal_avg = mld_link_sta->signal_avg;
+	sinfo->filled |= BIT_ULL(NL80211_STA_INFO_SIGNAL_AVG);
+
+unlock:
+	rcu_read_unlock();
+}
+
+struct iwl_mld_stats_data {
+	u8 fw_sta_id;
+	struct station_info *sinfo;
+	struct iwl_mld *mld;
+};
+
+static bool iwl_mld_wait_stats_handler(struct iwl_notif_wait_data *notif_data,
+				       struct iwl_rx_packet *pkt, void *data)
+{
+	struct iwl_mld_stats_data *stats_data = data;
+	u16 cmd = WIDE_ID(pkt->hdr.group_id, pkt->hdr.cmd);
+
+	switch (cmd) {
+	case WIDE_ID(STATISTICS_GROUP, STATISTICS_OPER_NOTIF):
+		iwl_mld_fill_stats_from_oper_notif(stats_data->mld, pkt,
+						   stats_data->fw_sta_id,
+						   stats_data->sinfo);
+		break;
+	case WIDE_ID(STATISTICS_GROUP, STATISTICS_OPER_PART1_NOTIF):
+		break;
+	case WIDE_ID(SYSTEM_GROUP, SYSTEM_STATISTICS_END_NOTIF):
+		return true;
+	}
+
+	return false;
+}
+
+static int
+iwl_mld_fw_stats_to_mac80211(struct iwl_mld *mld, struct iwl_mld_sta *mld_sta,
+			     struct station_info *sinfo)
+{
+	u32 cfg_mask = IWL_STATS_CFG_FLG_ON_DEMAND_NTFY_MSK |
+		       IWL_STATS_CFG_FLG_RESET_MSK;
+	u32 type_mask = IWL_STATS_NTFY_TYPE_ID_OPER |
+			IWL_STATS_NTFY_TYPE_ID_OPER_PART1;
+	static const u16 notifications[] = {
+		WIDE_ID(STATISTICS_GROUP, STATISTICS_OPER_NOTIF),
+		WIDE_ID(STATISTICS_GROUP, STATISTICS_OPER_PART1_NOTIF),
+		WIDE_ID(SYSTEM_GROUP, SYSTEM_STATISTICS_END_NOTIF),
+	};
+	struct iwl_mld_stats_data wait_stats_data = {
+		/* We don't support drv_sta_statistics in EMLSR */
+		.fw_sta_id = mld_sta->deflink.fw_id,
+		.sinfo = sinfo,
+		.mld = mld,
+	};
+	struct iwl_notification_wait stats_wait;
+	int ret;
+
+	iwl_init_notification_wait(&mld->notif_wait, &stats_wait,
+				   notifications, ARRAY_SIZE(notifications),
+				   iwl_mld_wait_stats_handler,
+				   &wait_stats_data);
+
+	ret = iwl_mld_send_fw_stats_cmd(mld, cfg_mask, 0, type_mask);
+	if (ret) {
+		iwl_remove_notification(&mld->notif_wait, &stats_wait);
+		return ret;
+	}
+
+	/* Wait 500ms for OPERATIONAL, PART1, and END notifications,
+	 * which should be sufficient for the firmware to gather data
+	 * from all LMACs and send notifications to the host.
+	 */
+	ret = iwl_wait_notification(&mld->notif_wait, &stats_wait, HZ / 2);
+	if (ret)
+		return ret;
+
+	/* When periodic statistics are sent, FW will clear its statistics DB.
+	 * If the statistics request here happens shortly afterwards,
+	 * the response will contain data collected over a short time
+	 * interval. The response we got here shouldn't be processed by
+	 * the general statistics processing because it's incomplete.
+	 * So, we delete it from the list so it won't be processed.
+	 */
+	iwl_mld_delete_handlers(mld, notifications, ARRAY_SIZE(notifications));
+
+	return 0;
+}
+
+#define PERIODIC_STATS_SECONDS 5
+
+int iwl_mld_request_periodic_fw_stats(struct iwl_mld *mld, bool enable)
+{
+	u32 cfg_mask = enable ? 0 : IWL_STATS_CFG_FLG_DISABLE_NTFY_MSK;
+	u32 type_mask = enable ? (IWL_STATS_NTFY_TYPE_ID_OPER |
+				  IWL_STATS_NTFY_TYPE_ID_OPER_PART1) : 0;
+	u32 cfg_time = enable ? PERIODIC_STATS_SECONDS : 0;
+
+	return iwl_mld_send_fw_stats_cmd(mld, cfg_mask, cfg_time, type_mask);
+}
+
+static void iwl_mld_sta_stats_fill_txrate(struct iwl_mld_sta *mld_sta,
+					  struct station_info *sinfo)
+{
+	struct rate_info *rinfo = &sinfo->txrate;
+	u32 rate_n_flags = mld_sta->deflink.last_rate_n_flags;
+	u32 format = rate_n_flags & RATE_MCS_MOD_TYPE_MSK;
+	u32 gi_ltf;
+
+	sinfo->filled |= BIT_ULL(NL80211_STA_INFO_TX_BITRATE);
+
+	switch (rate_n_flags & RATE_MCS_CHAN_WIDTH_MSK) {
+	case RATE_MCS_CHAN_WIDTH_20:
+		rinfo->bw = RATE_INFO_BW_20;
+		break;
+	case RATE_MCS_CHAN_WIDTH_40:
+		rinfo->bw = RATE_INFO_BW_40;
+		break;
+	case RATE_MCS_CHAN_WIDTH_80:
+		rinfo->bw = RATE_INFO_BW_80;
+		break;
+	case RATE_MCS_CHAN_WIDTH_160:
+		rinfo->bw = RATE_INFO_BW_160;
+		break;
+	case RATE_MCS_CHAN_WIDTH_320:
+		rinfo->bw = RATE_INFO_BW_320;
+		break;
+	}
+
+	if (format == RATE_MCS_CCK_MSK || format == RATE_MCS_LEGACY_OFDM_MSK) {
+		int rate = u32_get_bits(rate_n_flags, RATE_LEGACY_RATE_MSK);
+
+		/* add the offset needed to get to the legacy ofdm indices */
+		if (format == RATE_MCS_LEGACY_OFDM_MSK)
+			rate += IWL_FIRST_OFDM_RATE;
+
+		switch (rate) {
+		case IWL_RATE_1M_INDEX:
+			rinfo->legacy = 10;
+			break;
+		case IWL_RATE_2M_INDEX:
+			rinfo->legacy = 20;
+			break;
+		case IWL_RATE_5M_INDEX:
+			rinfo->legacy = 55;
+			break;
+		case IWL_RATE_11M_INDEX:
+			rinfo->legacy = 110;
+			break;
+		case IWL_RATE_6M_INDEX:
+			rinfo->legacy = 60;
+			break;
+		case IWL_RATE_9M_INDEX:
+			rinfo->legacy = 90;
+			break;
+		case IWL_RATE_12M_INDEX:
+			rinfo->legacy = 120;
+			break;
+		case IWL_RATE_18M_INDEX:
+			rinfo->legacy = 180;
+			break;
+		case IWL_RATE_24M_INDEX:
+			rinfo->legacy = 240;
+			break;
+		case IWL_RATE_36M_INDEX:
+			rinfo->legacy = 360;
+			break;
+		case IWL_RATE_48M_INDEX:
+			rinfo->legacy = 480;
+			break;
+		case IWL_RATE_54M_INDEX:
+			rinfo->legacy = 540;
+		}
+		return;
+	}
+
+	rinfo->nss = u32_get_bits(rate_n_flags, RATE_MCS_NSS_MSK) + 1;
+
+	if (format == RATE_MCS_HT_MSK)
+		rinfo->mcs = RATE_HT_MCS_INDEX(rate_n_flags);
+	else
+		rinfo->mcs = u32_get_bits(rate_n_flags, RATE_MCS_CODE_MSK);
+
+	if (rate_n_flags & RATE_MCS_SGI_MSK)
+		rinfo->flags |= RATE_INFO_FLAGS_SHORT_GI;
+
+	switch (format) {
+	case RATE_MCS_EHT_MSK:
+		rinfo->flags |= RATE_INFO_FLAGS_EHT_MCS;
+		break;
+	case RATE_MCS_HE_MSK:
+		gi_ltf = u32_get_bits(rate_n_flags, RATE_MCS_HE_GI_LTF_MSK);
+
+		rinfo->flags |= RATE_INFO_FLAGS_HE_MCS;
+
+		if (rate_n_flags & RATE_MCS_HE_106T_MSK) {
+			rinfo->bw = RATE_INFO_BW_HE_RU;
+			rinfo->he_ru_alloc = NL80211_RATE_INFO_HE_RU_ALLOC_106;
+		}
+
+		switch (rate_n_flags & RATE_MCS_HE_TYPE_MSK) {
+		case RATE_MCS_HE_TYPE_SU:
+		case RATE_MCS_HE_TYPE_EXT_SU:
+			if (gi_ltf == 0 || gi_ltf == 1)
+				rinfo->he_gi = NL80211_RATE_INFO_HE_GI_0_8;
+			else if (gi_ltf == 2)
+				rinfo->he_gi = NL80211_RATE_INFO_HE_GI_1_6;
+			else if (gi_ltf == 3)
+				rinfo->he_gi = NL80211_RATE_INFO_HE_GI_3_2;
+			else
+				rinfo->he_gi = NL80211_RATE_INFO_HE_GI_0_8;
+			break;
+		case RATE_MCS_HE_TYPE_MU:
+			if (gi_ltf == 0 || gi_ltf == 1)
+				rinfo->he_gi = NL80211_RATE_INFO_HE_GI_0_8;
+			else if (gi_ltf == 2)
+				rinfo->he_gi = NL80211_RATE_INFO_HE_GI_1_6;
+			else
+				rinfo->he_gi = NL80211_RATE_INFO_HE_GI_3_2;
+			break;
+		case RATE_MCS_HE_TYPE_TRIG:
+			if (gi_ltf == 0 || gi_ltf == 1)
+				rinfo->he_gi = NL80211_RATE_INFO_HE_GI_1_6;
+			else
+				rinfo->he_gi = NL80211_RATE_INFO_HE_GI_3_2;
+			break;
+		}
+
+		if (rate_n_flags & RATE_HE_DUAL_CARRIER_MODE_MSK)
+			rinfo->he_dcm = 1;
+		break;
+	case RATE_MCS_HT_MSK:
+		rinfo->flags |= RATE_INFO_FLAGS_MCS;
+		break;
+	case RATE_MCS_VHT_MSK:
+		rinfo->flags |= RATE_INFO_FLAGS_VHT_MCS;
+		break;
+	}
+}
+
+void iwl_mld_mac80211_sta_statistics(struct ieee80211_hw *hw,
+				     struct ieee80211_vif *vif,
+				     struct ieee80211_sta *sta,
+				     struct station_info *sinfo)
+{
+	struct iwl_mld_sta *mld_sta = iwl_mld_sta_from_mac80211(sta);
+
+	/* This API is not EMLSR ready, so we cannot provide complete
+	 * information if EMLSR is active
+	 */
+	if (hweight16(vif->active_links) > 1)
+		return;
+
+	if (iwl_mld_fw_stats_to_mac80211(mld_sta->mld, mld_sta, sinfo))
+		return;
+
+	iwl_mld_sta_stats_fill_txrate(mld_sta, sinfo);
+
+	/* TODO: NL80211_STA_INFO_BEACON_RX */
+
+	/* TODO: NL80211_STA_INFO_BEACON_SIGNAL_AVG */
+}
+
+#define IWL_MLD_TRAFFIC_LOAD_MEDIUM_THRESH	10 /* percentage */
+#define IWL_MLD_TRAFFIC_LOAD_HIGH_THRESH	50 /* percentage */
+#define IWL_MLD_TRAFFIC_LOAD_MIN_WINDOW_USEC	(500 * 1000)
+
+static u8 iwl_mld_stats_load_percentage(u32 last_ts_usec, u32 curr_ts_usec,
+					u32 total_airtime_usec)
+{
+	u32 elapsed_usec = curr_ts_usec - last_ts_usec;
+
+	if (elapsed_usec < IWL_MLD_TRAFFIC_LOAD_MIN_WINDOW_USEC)
+		return 0;
+
+	return (100 * total_airtime_usec / elapsed_usec);
+}
+
+static void iwl_mld_stats_recalc_traffic_load(struct iwl_mld *mld,
+					      u32 total_airtime_usec,
+					      u32 curr_ts_usec)
+{
+	u32 last_ts_usec = mld->scan.traffic_load.last_stats_ts_usec;
+	u8 load_prec;
+
+	/* Skip the calculation as this is the first notification received */
+	if (!last_ts_usec)
+		goto out;
+
+	load_prec = iwl_mld_stats_load_percentage(last_ts_usec, curr_ts_usec,
+						  total_airtime_usec);
+
+	if (load_prec > IWL_MLD_TRAFFIC_LOAD_HIGH_THRESH)
+		mld->scan.traffic_load.status = IWL_MLD_TRAFFIC_HIGH;
+	else if (load_prec > IWL_MLD_TRAFFIC_LOAD_MEDIUM_THRESH)
+		mld->scan.traffic_load.status = IWL_MLD_TRAFFIC_MEDIUM;
+	else
+		mld->scan.traffic_load.status = IWL_MLD_TRAFFIC_LOW;
+
+out:
+	mld->scan.traffic_load.last_stats_ts_usec = curr_ts_usec;
+}
+
+static void iwl_mld_update_link_sig(struct ieee80211_vif *vif, int sig,
+				    struct ieee80211_bss_conf *bss_conf)
+{
+	struct iwl_mld *mld = iwl_mld_vif_from_mac80211(vif)->mld;
+	int exit_emlsr_thresh;
+
+	if (sig == 0) {
+		IWL_DEBUG_RX(mld, "RSSI is 0 - skip signal based decision\n");
+		return;
+	}
+
+	/* TODO: task=statistics handle CQM notifications */
+
+	if (!iwl_mld_vif_has_emlsr_cap(vif))
+		return;
+
+	/* Handle inactive EMLSR, check whether to switch links */
+	if (!iwl_mld_emlsr_active(vif)) {
+		if (sig < IWL_MLD_LOW_RSSI_MLO_SCAN_THRESH)
+			iwl_mld_trigger_link_selection(mld, vif);
+		return;
+	}
+
+	/* We are in EMLSR, check if we need to exit */
+	exit_emlsr_thresh =
+		iwl_mld_get_emlsr_rssi_thresh(mld, &bss_conf->chanreq.oper,
+					      true);
+
+	if (sig < exit_emlsr_thresh)
+		iwl_mld_exit_emlsr(mld, vif, IWL_MLD_EMLSR_EXIT_LOW_RSSI,
+				   iwl_mld_get_other_link(vif,
+							  bss_conf->link_id));
+}
+
+static void
+iwl_mld_process_per_link_stats(struct iwl_mld *mld,
+			       const struct iwl_stats_ntfy_per_link *per_link,
+			       u32 curr_ts_usec)
+{
+	u32 total_airtime_usec = 0;
+
+	for (u32 fw_id = 0;
+	     fw_id < ARRAY_SIZE(mld->fw_id_to_bss_conf);
+	     fw_id++) {
+		const struct iwl_stats_ntfy_per_link *link_stats;
+		struct ieee80211_bss_conf *bss_conf;
+		int sig;
+
+		bss_conf = wiphy_dereference(mld->wiphy,
+					     mld->fw_id_to_bss_conf[fw_id]);
+		if (!bss_conf || bss_conf->vif->type != NL80211_IFTYPE_STATION)
+			continue;
+
+		link_stats = &per_link[fw_id];
+
+		total_airtime_usec += le32_to_cpu(link_stats->air_time);
+
+		sig = -le32_to_cpu(link_stats->beacon_filter_average_energy);
+		iwl_mld_update_link_sig(bss_conf->vif, sig, bss_conf);
+
+		/* TODO: parse more fields here (task=statistics)*/
+	}
+
+	iwl_mld_stats_recalc_traffic_load(mld, total_airtime_usec,
+					  curr_ts_usec);
+}
+
+static void
+iwl_mld_process_per_sta_stats(struct iwl_mld *mld,
+			      const struct iwl_stats_ntfy_per_sta *per_sta)
+{
+	for (int i = 0; i < mld->fw->ucode_capa.num_stations; i++) {
+		struct ieee80211_link_sta *link_sta =
+			wiphy_dereference(mld->wiphy,
+					  mld->fw_id_to_link_sta[i]);
+		struct iwl_mld_link_sta *mld_link_sta;
+		s8 avg_energy =
+			-(s8)le32_to_cpu(per_sta[i].average_energy);
+
+		if (IS_ERR_OR_NULL(link_sta) || !avg_energy)
+			continue;
+
+		mld_link_sta = iwl_mld_link_sta_from_mac80211(link_sta);
+		if (WARN_ON(!mld_link_sta))
+			continue;
+
+		mld_link_sta->signal_avg = avg_energy;
+	}
+}
+
+static void iwl_mld_fill_chanctx_stats(struct ieee80211_hw *hw,
+				       struct ieee80211_chanctx_conf *ctx,
+				       void *data)
+{
+	struct iwl_mld_phy *phy = iwl_mld_phy_from_mac80211(ctx);
+	const struct iwl_stats_ntfy_per_phy *per_phy = data;
+
+	if (WARN_ON(phy->fw_id >= IWL_STATS_MAX_PHY_OPERATIONAL))
+		return;
+
+	phy->channel_load_by_us =
+		le32_to_cpu(per_phy[phy->fw_id].channel_load_by_us);
+
+	/* TODO: channel load not by us (task=statistics) */
+}
+
+static void
+iwl_mld_process_per_phy_stats(struct iwl_mld *mld,
+			      const struct iwl_stats_ntfy_per_phy *per_phy)
+{
+	ieee80211_iter_chan_contexts_mtx(mld->hw,
+					 iwl_mld_fill_chanctx_stats,
+					 (void *)(uintptr_t)per_phy);
+
+	/* channel_load_by_us may have been updated, so recheck */
+	iwl_mld_emlsr_check_chan_load(mld);
+}
+
+void iwl_mld_handle_stats_oper_notif(struct iwl_mld *mld,
+				     struct iwl_rx_packet *pkt)
+{
+	const struct iwl_system_statistics_notif_oper *stats =
+		(void *)&pkt->data;
+	u32 curr_ts_usec = le32_to_cpu(stats->time_stamp);
+
+	BUILD_BUG_ON(ARRAY_SIZE(stats->per_sta) != IWL_STATION_COUNT_MAX);
+	BUILD_BUG_ON(ARRAY_SIZE(stats->per_link) <
+		     ARRAY_SIZE(mld->fw_id_to_bss_conf));
+
+	iwl_mld_process_per_link_stats(mld, stats->per_link, curr_ts_usec);
+	iwl_mld_process_per_sta_stats(mld, stats->per_sta);
+	iwl_mld_process_per_phy_stats(mld, stats->per_phy);
+
+	iwl_mld_check_omi_bw_reduction(mld);
+}
+
+void iwl_mld_handle_stats_oper_part1_notif(struct iwl_mld *mld,
+					   struct iwl_rx_packet *pkt)
+{
+	/* TODO */
+}
+
diff --git a/drivers/net/wireless/intel/iwlwifi/mld/stats.h b/drivers/net/wireless/intel/iwlwifi/mld/stats.h
new file mode 100644
index 000000000000..de434e66d555
--- /dev/null
+++ b/drivers/net/wireless/intel/iwlwifi/mld/stats.h
@@ -0,0 +1,22 @@
+/* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
+/*
+ * Copyright (C) 2024 Intel Corporation
+ */
+#ifndef __iwl_mld_stats_h__
+#define __iwl_mld_stats_h__
+
+int iwl_mld_request_periodic_fw_stats(struct iwl_mld *mld, bool enable);
+
+void iwl_mld_mac80211_sta_statistics(struct ieee80211_hw *hw,
+				     struct ieee80211_vif *vif,
+				     struct ieee80211_sta *sta,
+				     struct station_info *sinfo);
+
+void iwl_mld_handle_stats_oper_notif(struct iwl_mld *mld,
+				     struct iwl_rx_packet *pkt);
+void iwl_mld_handle_stats_oper_part1_notif(struct iwl_mld *mld,
+					   struct iwl_rx_packet *pkt);
+
+int iwl_mld_clear_stats_in_fw(struct iwl_mld *mld);
+
+#endif /* __iwl_mld_stats_h__ */
-- 
2.34.1


