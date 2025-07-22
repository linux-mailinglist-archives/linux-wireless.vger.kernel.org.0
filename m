Return-Path: <linux-wireless+bounces-25783-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F5CBB0D070
	for <lists+linux-wireless@lfdr.de>; Tue, 22 Jul 2025 05:42:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E41F61889EE0
	for <lists+linux-wireless@lfdr.de>; Tue, 22 Jul 2025 03:42:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FE7D28A1E6;
	Tue, 22 Jul 2025 03:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IuVgwxgl"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2577EEDE
	for <linux-wireless@vger.kernel.org>; Tue, 22 Jul 2025 03:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753155716; cv=none; b=O9BJCHpS2ZCrYgHbwpUT1raSM5lBzff+SOUEzIhhfHHnQEwQH9sYhv3I1k4zt5PiwQ3aARJiUKdo7SL+RnsbQNqtf6RDYlPKLqJezFWx+7GqfGHsJjNUEgizhoYCuVIshtXCL1r9y5FmSvQSBLZEVvgMGx7wMtP6BKJ9IMFnNrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753155716; c=relaxed/simple;
	bh=ULW4w7E9WUzQF5B0WMXYpif1KnY/Kozf3twLe5XTsxE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=t5rZapfYQjdYvFMriiCIHi4IELIGuIqibQls+F29ZM1wWoeq+QnixMkpol8nA9E7n1dZhqgvHZVygDqxWIfCXMjjGM9DkfFFqrQGVmbOcxzsvL6CG+lYjBppnXnU94zkzbdkQ4lGu0u4zoBuhhXPbisrUvmp74VFSrj2Cvml+Fs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IuVgwxgl; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753155714; x=1784691714;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ULW4w7E9WUzQF5B0WMXYpif1KnY/Kozf3twLe5XTsxE=;
  b=IuVgwxglwKJBf3LRvfnacz6YJy+AKt9uczOVhJjNIeE0l6zGvxc5CoIA
   wC6hx3tNKqUMmL2ZU24HI2C1KX9nXTyJ1p9ycm5QGmUHN6xHuThlmqWzO
   a8hLoCfr7priaraQE9EFkvC2b+EfM58B87gzV6mZCNNROPgGxo4xs+4WA
   kD/NYyxoaqcn5dpCl3vJLtbPjJ0SiEbXH+qmUs6DgCdvWqlRprUfyx/tU
   fTLOzKuHAigBidBer36KV5SOdIw7UjuJirP1Ofs1xNvK0R/MlsCx4hvFe
   TIG24idked/f/pHRo+SER01zEl1Uy6Mk7zX1YGaUmG9ESoK1QNPBFJRU7
   Q==;
X-CSE-ConnectionGUID: dY7ow0XFTw2AhXh0MI91/g==
X-CSE-MsgGUID: KmDVKzBIRe+4jgDTGBgOkw==
X-IronPort-AV: E=McAfee;i="6800,10657,11499"; a="43006155"
X-IronPort-AV: E=Sophos;i="6.16,330,1744095600"; 
   d="scan'208";a="43006155"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2025 20:41:53 -0700
X-CSE-ConnectionGUID: NQHMc/wiRiC7QqGd3E7Vkg==
X-CSE-MsgGUID: ID3IrtPVSZaBDrp1lzTxGQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,330,1744095600"; 
   d="scan'208";a="159338073"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2025 20:41:51 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Benjamin Berg <benjamin.berg@intel.com>
Subject: [PATCH iwlwifi-next 04/15] wifi: iwlwifi: mld: support channel survey collection for ACS scans
Date: Tue, 22 Jul 2025 06:41:14 +0300
Message-Id: <20250722063923.58a3956bb54a.I24a9a0383327c231f36be170968bc7bac801f9f2@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250722034125.1017387-1-miriam.rachel.korenblit@intel.com>
References: <20250722034125.1017387-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Benjamin Berg <benjamin.berg@intel.com>

The firmware is able to collect channel statistics when doing passive
scans. Enable the flag when doing a passive scan on an AP interface and
collect the survey information.

Signed-off-by: Benjamin Berg <benjamin.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 .../net/wireless/intel/iwlwifi/mld/mac80211.c |   1 +
 drivers/net/wireless/intel/iwlwifi/mld/mld.c  |   9 +
 drivers/net/wireless/intel/iwlwifi/mld/mld.h  |   2 +
 .../net/wireless/intel/iwlwifi/mld/notif.c    |   6 +
 drivers/net/wireless/intel/iwlwifi/mld/scan.c | 156 +++++++++++++++++-
 drivers/net/wireless/intel/iwlwifi/mld/scan.h |  37 +++++
 6 files changed, 210 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mld/mac80211.c b/drivers/net/wireless/intel/iwlwifi/mld/mac80211.c
index d929cf2e73fd..c6e61c843f77 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/mac80211.c
@@ -2675,6 +2675,7 @@ const struct ieee80211_ops iwl_mld_hw_ops = {
 	.mgd_complete_tx = iwl_mld_mac_mgd_complete_tx,
 	.sta_state = iwl_mld_mac80211_sta_state,
 	.sta_statistics = iwl_mld_mac80211_sta_statistics,
+	.get_survey = iwl_mld_mac80211_get_survey,
 	.flush = iwl_mld_mac80211_flush,
 	.flush_sta = iwl_mld_mac80211_flush_sta,
 	.ampdu_action = iwl_mld_mac80211_ampdu_action,
diff --git a/drivers/net/wireless/intel/iwlwifi/mld/mld.c b/drivers/net/wireless/intel/iwlwifi/mld/mld.c
index e7cbfb9009af..e78e7a4f39d1 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/mld.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/mld.c
@@ -259,6 +259,13 @@ static const struct iwl_hcmd_names iwl_mld_data_path_names[] = {
 	HCMD_NAME(MU_GROUP_MGMT_NOTIF),
 };
 
+/* Please keep this array *SORTED* by hex value.
+ * Access is done through binary search
+ */
+static const struct iwl_hcmd_names iwl_mld_scan_names[] = {
+	HCMD_NAME(CHANNEL_SURVEY_NOTIF),
+};
+
 /* Please keep this array *SORTED* by hex value.
  * Access is done through binary search
  */
@@ -310,6 +317,7 @@ const struct iwl_hcmd_arr iwl_mld_groups[] = {
 	[SYSTEM_GROUP] = HCMD_ARR(iwl_mld_system_names),
 	[MAC_CONF_GROUP] = HCMD_ARR(iwl_mld_mac_conf_names),
 	[DATA_PATH_GROUP] = HCMD_ARR(iwl_mld_data_path_names),
+	[SCAN_GROUP] = HCMD_ARR(iwl_mld_scan_names),
 	[LOCATION_GROUP] = HCMD_ARR(iwl_mld_location_names),
 	[REGULATORY_AND_NVM_GROUP] = HCMD_ARR(iwl_mld_reg_and_nvm_names),
 	[DEBUG_GROUP] = HCMD_ARR(iwl_mld_debug_names),
@@ -507,6 +515,7 @@ iwl_op_mode_mld_stop(struct iwl_op_mode *op_mode)
 
 	kfree(mld->nvm_data);
 	kfree(mld->scan.cmd);
+	kfree(mld->channel_survey);
 	kfree(mld->error_recovery_buf);
 	kfree(mld->mcast_filter_cmd);
 
diff --git a/drivers/net/wireless/intel/iwlwifi/mld/mld.h b/drivers/net/wireless/intel/iwlwifi/mld/mld.h
index 8bc4749599ca..94dc9da6360d 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/mld.h
+++ b/drivers/net/wireless/intel/iwlwifi/mld/mld.h
@@ -160,6 +160,7 @@
  *	device
  * @addresses: device MAC addresses.
  * @scan: instance of the scan object
+ * @channel_survey: channel survey information collected during scan
  * @wowlan: WoWLAN support data.
  * @debug_max_sleep: maximum sleep time in D3 (for debug purposes)
  * @led: the led device
@@ -253,6 +254,7 @@ struct iwl_mld {
 
 	struct mac_address addresses[IWL_MLD_MAX_ADDRESSES];
 	struct iwl_mld_scan scan;
+	struct iwl_mld_survey *channel_survey;
 #ifdef CONFIG_PM_SLEEP
 	struct wiphy_wowlan_support wowlan;
 	u32 debug_max_sleep;
diff --git a/drivers/net/wireless/intel/iwlwifi/mld/notif.c b/drivers/net/wireless/intel/iwlwifi/mld/notif.c
index 262d8e25e62a..3cb700a9708e 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/notif.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/notif.c
@@ -295,6 +295,8 @@ CMD_VERSIONS(scan_complete_notif,
 	     CMD_VER_ENTRY(1, iwl_umac_scan_complete))
 CMD_VERSIONS(scan_iter_complete_notif,
 	     CMD_VER_ENTRY(2, iwl_umac_scan_iter_complete_notif))
+CMD_VERSIONS(channel_survey_notif,
+	     CMD_VER_ENTRY(1, iwl_umac_scan_channel_survey_notif))
 CMD_VERSIONS(mfuart_notif,
 	     CMD_VER_ENTRY(2, iwl_mfuart_load_notif))
 CMD_VERSIONS(update_mcc,
@@ -415,6 +417,10 @@ const struct iwl_rx_handler iwl_mld_rx_handlers[] = {
 	RX_HANDLER_NO_VAL(LEGACY_GROUP, MATCH_FOUND_NOTIFICATION,
 			  match_found_notif, RX_HANDLER_SYNC)
 
+	RX_HANDLER_NO_OBJECT(SCAN_GROUP, CHANNEL_SURVEY_NOTIF,
+			     channel_survey_notif,
+			     RX_HANDLER_ASYNC)
+
 	RX_HANDLER_NO_OBJECT(STATISTICS_GROUP, STATISTICS_OPER_NOTIF,
 			     stats_oper_notif, RX_HANDLER_ASYNC)
 	RX_HANDLER_NO_OBJECT(STATISTICS_GROUP, STATISTICS_OPER_PART1_NOTIF,
diff --git a/drivers/net/wireless/intel/iwlwifi/mld/scan.c b/drivers/net/wireless/intel/iwlwifi/mld/scan.c
index 479a76a94aa8..62f97a18a16c 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/scan.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/scan.c
@@ -4,6 +4,8 @@
  */
 #include <linux/crc32.h>
 
+#include "iwl-utils.h"
+
 #include "mld.h"
 #include "scan.h"
 #include "hcmd.h"
@@ -482,7 +484,9 @@ iwl_mld_scan_get_cmd_gen_flags(struct iwl_mld *mld,
 static u8
 iwl_mld_scan_get_cmd_gen_flags2(struct iwl_mld *mld,
 				struct iwl_mld_scan_params *params,
-				struct ieee80211_vif *vif, u16 gen_flags)
+				struct ieee80211_vif *vif,
+				enum iwl_mld_scan_status scan_status,
+				u16 gen_flags)
 {
 	u8 flags = 0;
 
@@ -494,6 +498,17 @@ iwl_mld_scan_get_cmd_gen_flags2(struct iwl_mld *mld,
 	if (params->scan_6ghz)
 		flags |= IWL_UMAC_SCAN_GEN_PARAMS_FLAGS2_DONT_TOGGLE_ANT;
 
+	/* For AP interfaces, request survey data for regular scans and if
+	 * it is supported. For non-AP interfaces, EBS will be enabled and
+	 * the results may be missing information for some channels.
+	 */
+	if (scan_status == IWL_MLD_SCAN_REGULAR &&
+	    ieee80211_vif_type_p2p(vif) == NL80211_IFTYPE_AP &&
+	    gen_flags & IWL_UMAC_SCAN_GEN_FLAGS_V2_FORCE_PASSIVE &&
+	    iwl_fw_lookup_notif_ver(mld->fw, SCAN_GROUP,
+				    CHANNEL_SURVEY_NOTIF, 0) >= 1)
+		flags |= IWL_UMAC_SCAN_GEN_FLAGS2_COLLECT_CHANNEL_STATS;
+
 	return flags;
 }
 
@@ -544,6 +559,7 @@ iwl_mld_scan_cmd_set_gen_params(struct iwl_mld *mld,
 	u16 gen_flags = iwl_mld_scan_get_cmd_gen_flags(mld, params, vif,
 						       scan_status);
 	u8 gen_flags2 = iwl_mld_scan_get_cmd_gen_flags2(mld, params, vif,
+							scan_status,
 							gen_flags);
 
 	IWL_DEBUG_SCAN(mld, "General: flags=0x%x, flags2=0x%x\n",
@@ -1752,6 +1768,11 @@ int iwl_mld_regular_scan_start(struct iwl_mld *mld, struct ieee80211_vif *vif,
 			       struct cfg80211_scan_request *req,
 			       struct ieee80211_scan_ies *ies)
 {
+	/* Clear survey data when starting the first part of a regular scan */
+	if (req->first_part && mld->channel_survey)
+		memset(mld->channel_survey->channels, 0,
+		       sizeof(mld->channel_survey->channels[0]) *
+		       mld->channel_survey->n_channels);
 
 	if (vif->type == NL80211_IFTYPE_P2P_DEVICE)
 		iwl_mld_emlsr_block_tmp_non_bss(mld);
@@ -2025,3 +2046,136 @@ int iwl_mld_alloc_scan_cmd(struct iwl_mld *mld)
 
 	return 0;
 }
+
+static int iwl_mld_chanidx_from_phy(struct iwl_mld *mld,
+				    enum nl80211_band band,
+				    u16 phy_chan_num)
+{
+	struct ieee80211_supported_band *sband = mld->wiphy->bands[band];
+
+	if (WARN_ON_ONCE(!sband))
+		return -EINVAL;
+
+	for (int chan_idx = 0; chan_idx < sband->n_channels; chan_idx++) {
+		struct ieee80211_channel *channel = &sband->channels[chan_idx];
+
+		if (channel->hw_value == phy_chan_num)
+			return chan_idx;
+	}
+
+	return -EINVAL;
+}
+
+void iwl_mld_handle_channel_survey_notif(struct iwl_mld *mld,
+					 struct iwl_rx_packet *pkt)
+{
+	const struct iwl_umac_scan_channel_survey_notif *notif =
+		(void *)pkt->data;
+	struct iwl_mld_survey_channel *info;
+	enum nl80211_band band;
+	int chan_idx;
+
+	if (!mld->channel_survey) {
+		size_t n_channels = 0;
+
+		for (band = 0; band < NUM_NL80211_BANDS; band++) {
+			if (!mld->wiphy->bands[band])
+				continue;
+
+			n_channels += mld->wiphy->bands[band]->n_channels;
+		}
+
+		mld->channel_survey = kzalloc(struct_size(mld->channel_survey,
+							  channels, n_channels),
+							  GFP_KERNEL);
+
+		if (!mld->channel_survey)
+			return;
+
+		mld->channel_survey->n_channels = n_channels;
+		n_channels = 0;
+		for (band = 0; band < NUM_NL80211_BANDS; band++) {
+			if (!mld->wiphy->bands[band])
+				continue;
+
+			mld->channel_survey->bands[band] =
+				&mld->channel_survey->channels[n_channels];
+			n_channels += mld->wiphy->bands[band]->n_channels;
+		}
+	}
+
+	band = iwl_mld_phy_band_to_nl80211(le32_to_cpu(notif->band));
+	chan_idx = iwl_mld_chanidx_from_phy(mld, band,
+					    le32_to_cpu(notif->channel));
+	if (WARN_ON_ONCE(chan_idx < 0))
+		return;
+
+	IWL_DEBUG_SCAN(mld, "channel survey received for freq %d\n",
+		       mld->wiphy->bands[band]->channels[chan_idx].center_freq);
+
+	info = &mld->channel_survey->bands[band][chan_idx];
+
+	/* Times are all in ms */
+	info->time = le32_to_cpu(notif->active_time);
+	info->time_busy = le32_to_cpu(notif->busy_time);
+	info->noise =
+		iwl_average_neg_dbm(notif->noise, ARRAY_SIZE(notif->noise));
+}
+
+int iwl_mld_mac80211_get_survey(struct ieee80211_hw *hw, int idx,
+				struct survey_info *survey)
+{
+	struct iwl_mld *mld = IWL_MAC80211_GET_MLD(hw);
+	int curr_idx = 0;
+
+	if (!mld->channel_survey)
+		return -ENOENT;
+
+	/* Iterate bands/channels to find the requested index.
+	 * Logically this returns the entry with index "idx" from a flattened
+	 * survey result array that only contains channels with information.
+	 * The current index into this flattened array is tracked in curr_idx.
+	 */
+	for (enum nl80211_band band = 0; band < NUM_NL80211_BANDS; band++) {
+		struct ieee80211_supported_band *sband =
+			mld->wiphy->bands[band];
+
+		if (!sband)
+			continue;
+
+		for (int per_band_idx = 0;
+		     per_band_idx < sband->n_channels;
+		     per_band_idx++) {
+			struct iwl_mld_survey_channel *info =
+				&mld->channel_survey->bands[band][per_band_idx];
+
+			/* Skip entry entirely, it was not reported/scanned,
+			 * do not increase curr_idx for this entry.
+			 */
+			if (!info->time)
+				continue;
+
+			/* Search did not reach the requested entry yet,
+			 * increment curr_idx and continue.
+			 */
+			if (idx != curr_idx) {
+				curr_idx++;
+				continue;
+			}
+
+			/* Found (the next) channel to report */
+			survey->channel = &sband->channels[per_band_idx];
+			survey->filled = SURVEY_INFO_TIME |
+					 SURVEY_INFO_TIME_BUSY;
+			survey->time = info->time;
+			survey->time_busy = info->time_busy;
+			survey->noise = info->noise;
+			if (survey->noise < 0)
+				survey->filled |= SURVEY_INFO_NOISE_DBM;
+
+			return 0;
+		}
+	}
+
+	return -ENOENT;
+}
diff --git a/drivers/net/wireless/intel/iwlwifi/mld/scan.h b/drivers/net/wireless/intel/iwlwifi/mld/scan.h
index 4044cac3f086..69110f0cfc8e 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/scan.h
+++ b/drivers/net/wireless/intel/iwlwifi/mld/scan.h
@@ -30,6 +30,12 @@ void iwl_mld_handle_match_found_notif(struct iwl_mld *mld,
 void iwl_mld_handle_scan_complete_notif(struct iwl_mld *mld,
 					struct iwl_rx_packet *pkt);
 
+int iwl_mld_mac80211_get_survey(struct ieee80211_hw *hw, int idx,
+				struct survey_info *survey);
+
+void iwl_mld_handle_channel_survey_notif(struct iwl_mld *mld,
+					 struct iwl_rx_packet *pkt);
+
 #define WFA_TPC_IE_LEN 9
 
 static inline int iwl_mld_scan_max_template_size(void)
@@ -133,4 +139,35 @@ struct iwl_mld_scan {
 	u64 last_mlo_scan_time;
 };
 
+/**
+ * struct iwl_mld_survey_channel - per-channel survey information
+ *
+ * Driver version of &struct survey_info with just the data we want to report.
+ *
+ * @time: time in ms the radio was on the channel
+ * @time_busy: time in ms the channel was sensed busy
+ * @noise: channel noise in dBm
+ */
+struct iwl_mld_survey_channel {
+	u32 time;
+	u32 time_busy;
+	s8 noise;
+};
+
+/**
+ * struct iwl_mld_survey - survey information
+ *
+ * Survey information for all available channels.
+ *
+ * @bands: per-band array for per-channel survey data, points into @channels
+ * @n_channels: Number of @channels entries that are allocated
+ * @channels: per-channel information
+ */
+struct iwl_mld_survey {
+	struct iwl_mld_survey_channel *bands[NUM_NL80211_BANDS];
+
+	int n_channels;
+	struct iwl_mld_survey_channel channels[] __counted_by(n_channels);
+};
+
 #endif /* __iwl_mld_scan_h__ */
-- 
2.34.1


