Return-Path: <linux-wireless+bounces-7206-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 496CB8BC806
	for <lists+linux-wireless@lfdr.de>; Mon,  6 May 2024 09:05:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6B3B5B214A8
	for <lists+linux-wireless@lfdr.de>; Mon,  6 May 2024 07:05:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD59E50263;
	Mon,  6 May 2024 07:05:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BJqK/q6d"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE70F7D06E
	for <linux-wireless@vger.kernel.org>; Mon,  6 May 2024 07:05:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714979102; cv=none; b=rgYBzgkaMyCfRLyTN4PgSeL+HuqB5Zd2PsWAbOIDH9W9+CrZZXCoSk3PmpbVSsM7HbZm8Mf5XECJ46YuO1TIPt9EZXZyAzt8eL2gpbubnaHxBDf4XcatBbp8g3LG2iO9bVEZF7k6N2X6fhlq982hVbkOX/V78/MwOypDg1MIBIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714979102; c=relaxed/simple;
	bh=3U2BZfBTvpua7ZjFzZLVWVoMhsySPr51YqLlIROId6w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=AGdtnLvg2AhEkOahhYTWmrhYkV4kR/mQobjL6zdZF4HvVc0mSL8CoXb4w4rHsH13DSpI9eV+cd9bI2IrPMxbRTMm9DWo8L0WitVZ97mh7UOu/I8M0JhzRDM8JYaC2/PMlFxyjPfIL6GgUXi3vLk3xJxP8+cfd3Ef1Oi8eruHzH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BJqK/q6d; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714979101; x=1746515101;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=3U2BZfBTvpua7ZjFzZLVWVoMhsySPr51YqLlIROId6w=;
  b=BJqK/q6drEyUqDSeDk07m7nPdeSpoqEiEbvqpEUbv4Gv44fM+e2zr/Jc
   qcNkGqGg5+8fY18o4L3OiVRXlcGw2u9XGcz3JDGWdmxP2sCGIUObvKILT
   tNnm8lf2706pStwXQ1KXl9Ui7d1yOKx7+TqJ7laK0WbngueiNPg604IIl
   XGFdzcPNp2AmQpbAndHHt9n61ga+H2luqZkFroOk+KWGycOFYS3n/HXLQ
   JXaElqKbq8OeRnUptX2stzii3hIVmWrLPzxv1RYxHbGFZ8K456Cg9WWg1
   N0o6KVxphi/bAc8tNgk1EtC9IvSWtwjSZrcjZhkGE2VYvy/lS4cLvK/PO
   w==;
X-CSE-ConnectionGUID: oLRPFUGqS5yQkceFs0FUnA==
X-CSE-MsgGUID: W/jnFy2IR1aN+Q/vbbVQvw==
X-IronPort-AV: E=McAfee;i="6600,9927,11064"; a="10638228"
X-IronPort-AV: E=Sophos;i="6.07,257,1708416000"; 
   d="scan'208";a="10638228"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2024 00:04:46 -0700
X-CSE-ConnectionGUID: A+zytjR8Rv60b04YUg4txA==
X-CSE-MsgGUID: bjJq1XjXTlmOhnHZTLko9A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,257,1708416000"; 
   d="scan'208";a="59264935"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2024 00:04:43 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Benjamin Berg <benjamin.berg@intel.com>
Subject: [PATCH 09/15] wifi: iwlwifi: mvm: record and return channel survey information
Date: Mon,  6 May 2024 10:04:13 +0300
Message-Id: <20240506095953.9287591a5999.I54a3f9f6480d3694e67eea1cb4f5853beace2780@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240506070419.1821330-1-miriam.rachel.korenblit@intel.com>
References: <20240506070419.1821330-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Benjamin Berg <benjamin.berg@intel.com>

While doing a passive scan, the firmware will report per-channel survey
information. This information is primarily useful for hostapd when doing
an ACS (Automatic Channel Selection). Collect this information and add
it to the result set when getting the survey information.

Signed-off-by: Benjamin Berg <benjamin.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 .../net/wireless/intel/iwlwifi/mvm/mac80211.c |  71 +++++-
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h  |  35 +++
 drivers/net/wireless/intel/iwlwifi/mvm/ops.c  |   4 +
 drivers/net/wireless/intel/iwlwifi/mvm/scan.c | 216 +++++++++++++++++-
 .../wireless/intel/iwlwifi/mvm/tests/Makefile |   2 +-
 .../wireless/intel/iwlwifi/mvm/tests/scan.c   | 110 +++++++++
 6 files changed, 430 insertions(+), 8 deletions(-)
 create mode 100644 drivers/net/wireless/intel/iwlwifi/mvm/tests/scan.c

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
index fb49deda3346..486a6b8f3c97 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
@@ -5899,6 +5899,65 @@ void iwl_mvm_mac_flush_sta(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 	mutex_unlock(&mvm->mutex);
 }
 
+static int iwl_mvm_mac_get_acs_survey(struct iwl_mvm *mvm, int idx,
+				      struct survey_info *survey)
+{
+	int chan_idx;
+	enum nl80211_band band;
+	int ret;
+
+	mutex_lock(&mvm->mutex);
+
+	if (!mvm->acs_survey) {
+		ret = -ENOENT;
+		goto out;
+	}
+
+	/* Find and return the next entry that has a non-zero active time */
+	for (band = 0; band < NUM_NL80211_BANDS; band++) {
+		struct ieee80211_supported_band *sband =
+			mvm->hw->wiphy->bands[band];
+
+		if (!sband)
+			continue;
+
+		for (chan_idx = 0; chan_idx < sband->n_channels; chan_idx++) {
+			struct iwl_mvm_acs_survey_channel *info =
+				&mvm->acs_survey->bands[band][chan_idx];
+
+			if (!info->time)
+				continue;
+
+			/* Found (the next) channel to report */
+			survey->channel = &sband->channels[chan_idx];
+			survey->filled = SURVEY_INFO_TIME |
+					 SURVEY_INFO_TIME_BUSY |
+					 SURVEY_INFO_TIME_RX |
+					 SURVEY_INFO_TIME_TX;
+			survey->time = info->time;
+			survey->time_busy = info->time_busy;
+			survey->time_rx = info->time_rx;
+			survey->time_tx = info->time_tx;
+			survey->noise = info->noise;
+			if (survey->noise < 0)
+				survey->filled |= SURVEY_INFO_NOISE_DBM;
+
+			/* Clear time so that channel is only reported once */
+			info->time = 0;
+
+			ret = 0;
+			goto out;
+		}
+	}
+
+	ret = -ENOENT;
+
+out:
+	mutex_unlock(&mvm->mutex);
+
+	return ret;
+}
+
 int iwl_mvm_mac_get_survey(struct ieee80211_hw *hw, int idx,
 			   struct survey_info *survey)
 {
@@ -5911,14 +5970,18 @@ int iwl_mvm_mac_get_survey(struct ieee80211_hw *hw, int idx,
 
 	memset(survey, 0, sizeof(*survey));
 
-	/* only support global statistics right now */
-	if (idx != 0)
-		return -ENOENT;
-
 	if (!fw_has_capa(&mvm->fw->ucode_capa,
 			 IWL_UCODE_TLV_CAPA_RADIO_BEACON_STATS))
 		return -ENOENT;
 
+	/*
+	 * Return the beacon stats at index zero and pass on following indices
+	 * to the function returning the full survey, most likely for ACS
+	 * (Automatic Channel Selection).
+	 */
+	if (idx > 0)
+		return iwl_mvm_mac_get_acs_survey(mvm, idx - 1, survey);
+
 	mutex_lock(&mvm->mutex);
 
 	if (iwl_mvm_firmware_running(mvm)) {
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
index b292276de4ae..b96568f5640c 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
@@ -918,6 +918,35 @@ struct iwl_mei_scan_filter {
 	struct work_struct scan_work;
 };
 
+/**
+ * struct iwl_mvm_acs_survey_channel - per-channel survey information
+ *
+ * Stripped down version of &struct survey_info.
+ *
+ * @time: time in ms the radio was on the channel
+ * @time_busy: time in ms the channel was sensed busy
+ * @time_tx: time in ms spent transmitting data
+ * @time_rx: time in ms spent receiving data
+ * @noise: channel noise in dBm
+ */
+struct iwl_mvm_acs_survey_channel {
+	u32 time;
+	u32 time_busy;
+	u32 time_tx;
+	u32 time_rx;
+	s8 noise;
+};
+
+struct iwl_mvm_acs_survey {
+	struct iwl_mvm_acs_survey_channel *bands[NUM_NL80211_BANDS];
+
+	/* Overall number of channels */
+	int n_channels;
+
+	/* Storage space for per-channel information follows */
+	struct iwl_mvm_acs_survey_channel channels[] __counted_by(n_channels);
+};
+
 struct iwl_mvm {
 	/* for logger access */
 	struct device *dev;
@@ -1287,6 +1316,8 @@ struct iwl_mvm {
 
 	struct iwl_mei_scan_filter mei_scan_filter;
 
+	struct iwl_mvm_acs_survey *acs_survey;
+
 	bool statistics_clear;
 };
 
@@ -2033,6 +2064,8 @@ unsigned int iwl_mvm_get_link_grade(struct ieee80211_bss_conf *link_conf);
 bool iwl_mvm_mld_valid_link_pair(struct ieee80211_vif *vif,
 				 const struct iwl_mvm_link_sel_data *a,
 				 const struct iwl_mvm_link_sel_data *b);
+
+s8 iwl_mvm_average_dbm_values(const struct iwl_umac_scan_channel_survey_notif *notif);
 #endif
 
 /* AP and IBSS */
@@ -2115,6 +2148,8 @@ int iwl_mvm_max_scan_ie_len(struct iwl_mvm *mvm);
 void iwl_mvm_report_scan_aborted(struct iwl_mvm *mvm);
 void iwl_mvm_scan_timeout_wk(struct work_struct *work);
 int iwl_mvm_int_mlo_scan(struct iwl_mvm *mvm, struct ieee80211_vif *vif);
+void iwl_mvm_rx_channel_survey_notif(struct iwl_mvm *mvm,
+				     struct iwl_rx_cmd_buffer *rxb);
 
 /* Scheduled scan */
 void iwl_mvm_rx_lmac_scan_complete_notif(struct iwl_mvm *mvm,
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/ops.c b/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
index c52e69743c80..53283d052e18 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
@@ -473,6 +473,9 @@ static const struct iwl_rx_handlers iwl_mvm_rx_handlers[] = {
 	RX_HANDLER_GRP(MAC_CONF_GROUP, ROC_NOTIF,
 		       iwl_mvm_rx_roc_notif, RX_HANDLER_SYNC,
 		       struct iwl_roc_notif),
+	RX_HANDLER_GRP(SCAN_GROUP, CHANNEL_SURVEY_NOTIF,
+		       iwl_mvm_rx_channel_survey_notif, RX_HANDLER_ASYNC_LOCKED,
+		       struct iwl_umac_scan_channel_survey_notif),
 };
 #undef RX_HANDLER
 #undef RX_HANDLER_GRP
@@ -1582,6 +1585,7 @@ static void iwl_op_mode_mvm_stop(struct iwl_op_mode *op_mode)
 	kfree(mvm->temp_nvm_data);
 	for (i = 0; i < NVM_MAX_NUM_SECTIONS; i++)
 		kfree(mvm->nvm_sections[i].data);
+	kfree(mvm->acs_survey);
 
 	cancel_delayed_work_sync(&mvm->tcm.work);
 
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/scan.c b/drivers/net/wireless/intel/iwlwifi/mvm/scan.c
index 49ec515b5bad..a7ec172eeade 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/scan.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/scan.c
@@ -226,6 +226,14 @@ iwl_mvm_scan_type _iwl_mvm_get_scan_type(struct iwl_mvm *mvm,
 		.global_cnt = 0,
 	};
 
+	/*
+	 * A scanning AP interface probably wants to generate a survey to do
+	 * ACS (automatic channel selection).
+	 * Force a non-fragmented scan in that case.
+	 */
+	if (vif && ieee80211_vif_type_p2p(vif) == NL80211_IFTYPE_AP)
+		return IWL_SCAN_TYPE_WILD;
+
 	ieee80211_iterate_active_interfaces_atomic(mvm->hw,
 						   IEEE80211_IFACE_ITER_NORMAL,
 						   iwl_mvm_scan_iterator,
@@ -852,11 +860,13 @@ static inline bool iwl_mvm_scan_use_ebs(struct iwl_mvm *mvm,
 	 *	4. it's not a p2p find operation.
 	 *	5. we are not in low latency mode,
 	 *	   or if fragmented ebs is supported by the FW
+	 *	6. the VIF is not an AP interface (scan wants survey results)
 	 */
 	return ((capa->flags & IWL_UCODE_TLV_FLAGS_EBS_SUPPORT) &&
 		mvm->last_ebs_successful && IWL_MVM_ENABLE_EBS &&
 		vif->type != NL80211_IFTYPE_P2P_DEVICE &&
-		(!low_latency || iwl_mvm_is_frag_ebs_supported(mvm)));
+		(!low_latency || iwl_mvm_is_frag_ebs_supported(mvm)) &&
+		ieee80211_vif_type_p2p(vif) != NL80211_IFTYPE_AP);
 }
 
 static inline bool iwl_mvm_is_regular_scan(struct iwl_mvm_scan_params *params)
@@ -2124,7 +2134,8 @@ static u16 iwl_mvm_scan_umac_flags_v2(struct iwl_mvm *mvm,
 
 static u8 iwl_mvm_scan_umac_flags2(struct iwl_mvm *mvm,
 				   struct iwl_mvm_scan_params *params,
-				   struct ieee80211_vif *vif, int type)
+				   struct ieee80211_vif *vif, int type,
+				   u16 gen_flags)
 {
 	u8 flags = 0;
 
@@ -2144,6 +2155,13 @@ static u8 iwl_mvm_scan_umac_flags2(struct iwl_mvm *mvm,
 			IWL_UCODE_TLV_CAPA_SCAN_DONT_TOGGLE_ANT))
 		flags |= IWL_UMAC_SCAN_GEN_PARAMS_FLAGS2_DONT_TOGGLE_ANT;
 
+	/* Passive and AP interface -> ACS (automatic channel selection) */
+	if (gen_flags & IWL_UMAC_SCAN_GEN_FLAGS_V2_FORCE_PASSIVE &&
+	    ieee80211_vif_type_p2p(vif) == NL80211_IFTYPE_AP &&
+	    iwl_fw_lookup_notif_ver(mvm->fw, SCAN_GROUP, CHANNEL_SURVEY_NOTIF,
+				    0) >= 1)
+		flags |= IWL_UMAC_SCAN_GEN_FLAGS2_COLLECT_CHANNEL_STATS;
+
 	return flags;
 }
 
@@ -2513,7 +2531,8 @@ static int iwl_mvm_scan_umac_v14_and_above(struct iwl_mvm *mvm,
 	gen_flags = iwl_mvm_scan_umac_flags_v2(mvm, params, vif, type);
 
 	if (version >= 15)
-		gen_flags2 = iwl_mvm_scan_umac_flags2(mvm, params, vif, type);
+		gen_flags2 = iwl_mvm_scan_umac_flags2(mvm, params, vif, type,
+						      gen_flags);
 	else
 		gen_flags2 = 0;
 
@@ -3602,3 +3621,194 @@ int iwl_mvm_int_mlo_scan(struct iwl_mvm *mvm, struct ieee80211_vif *vif)
 
 	return iwl_mvm_int_mlo_scan_start(mvm, vif, channels, n_channels);
 }
+
+static int iwl_mvm_chanidx_from_phy(struct iwl_mvm *mvm,
+				    enum nl80211_band band,
+				    u16 phy_chan_num)
+{
+	struct ieee80211_supported_band *sband = mvm->hw->wiphy->bands[band];
+	int chan_idx;
+
+	if (WARN_ON_ONCE(!sband))
+		return -EINVAL;
+
+	for (chan_idx = 0; chan_idx < sband->n_channels; chan_idx++) {
+		struct ieee80211_channel *channel = &sband->channels[chan_idx];
+
+		if (channel->hw_value == phy_chan_num)
+			return chan_idx;
+	}
+
+	return -EINVAL;
+}
+
+static u32 iwl_mvm_div_by_db(u32 value, u8 db)
+{
+	/*
+	 * 2^32 * 10**(i / 10) for i = [1, 10], skipping 0 and simply stopping
+	 * at 10 dB and looping instead of using a much larger table.
+	 *
+	 * Using 64 bit math is overkill, but means the helper does not require
+	 * a limit on the input range.
+	 */
+	static const u32 db_to_val[] = {
+		0xcb59185e, 0xa1866ba8, 0x804dce7a, 0x65ea59fe, 0x50f44d89,
+		0x404de61f, 0x331426af, 0x2892c18b, 0x203a7e5b, 0x1999999a,
+	};
+
+	while (value && db > 0) {
+		u8 change = min_t(u8, db, ARRAY_SIZE(db_to_val));
+
+		value = (((u64)value) * db_to_val[change - 1]) >> 32;
+
+		db -= change;
+	}
+
+	return value;
+}
+
+VISIBLE_IF_IWLWIFI_KUNIT s8
+iwl_mvm_average_dbm_values(const struct iwl_umac_scan_channel_survey_notif *notif)
+{
+	s8 average_magnitude;
+	u32 average_factor;
+	s8 sum_magnitude = -128;
+	u32 sum_factor = 0;
+	int i, count = 0;
+
+	/*
+	 * To properly average the decibel values (signal values given in dBm)
+	 * we need to do the math in linear space.  Doing a linear average of
+	 * dB (dBm) values is a bit annoying though due to the large range of
+	 * at least -10 to -110 dBm that will not fit into a 32 bit integer.
+	 *
+	 * A 64 bit integer should be sufficient, but then we still have the
+	 * problem that there are no directly usable utility functions
+	 * available.
+	 *
+	 * So, lets not deal with that and instead do much of the calculation
+	 * with a 16.16 fixed point integer along with a base in dBm. 16.16 bit
+	 * gives us plenty of head-room for adding up a few values and even
+	 * doing some math on it. And the tail should be accurate enough too
+	 * (1/2^16 is somewhere around -48 dB, so effectively zero).
+	 *
+	 * i.e. the real value of sum is:
+	 *      sum = sum_factor / 2^16 * 10^(sum_magnitude / 10) mW
+	 *
+	 * However, that does mean we need to be able to bring two values to
+	 * a common base, so we need a helper for that.
+	 *
+	 * Note that this function takes an input with unsigned negative dBm
+	 * values but returns a signed dBm (i.e. a negative value).
+	 */
+
+	for (i = 0; i < ARRAY_SIZE(notif->noise); i++) {
+		s8 val_magnitude;
+		u32 val_factor;
+
+		if (notif->noise[i] == 0xff)
+			continue;
+
+		val_factor = 0x10000;
+		val_magnitude = -notif->noise[i];
+
+		if (val_magnitude <= sum_magnitude) {
+			u8 div_db = sum_magnitude - val_magnitude;
+
+			val_factor = iwl_mvm_div_by_db(val_factor, div_db);
+			val_magnitude = sum_magnitude;
+		} else {
+			u8 div_db = val_magnitude - sum_magnitude;
+
+			sum_factor = iwl_mvm_div_by_db(sum_factor, div_db);
+			sum_magnitude = val_magnitude;
+		}
+
+		sum_factor += val_factor;
+		count++;
+	}
+
+	/* No valid noise measurement, return a very high noise level */
+	if (count == 0)
+		return 0;
+
+	average_magnitude = sum_magnitude;
+	average_factor = sum_factor / count;
+
+	/*
+	 * average_factor will be a number smaller than 1.0 (0x10000) at this
+	 * point. What we need to do now is to adjust average_magnitude so that
+	 * average_factor is between -0.5 dB and 0.5 dB.
+	 *
+	 * Just do -1 dB steps and find the point where
+	 *   -0.5 dB * -i dB = 0x10000 * 10^(-0.5/10) / i dB
+	 *                   = div_by_db(0xe429, i)
+	 * is smaller than average_factor.
+	 */
+	for (i = 0; average_factor < iwl_mvm_div_by_db(0xe429, i); i++) {
+		/* nothing */
+	}
+
+	return average_magnitude - i;
+}
+EXPORT_SYMBOL_IF_IWLWIFI_KUNIT(iwl_mvm_average_dbm_values);
+
+void iwl_mvm_rx_channel_survey_notif(struct iwl_mvm *mvm,
+				     struct iwl_rx_cmd_buffer *rxb)
+{
+	struct iwl_rx_packet *pkt = rxb_addr(rxb);
+	const struct iwl_umac_scan_channel_survey_notif *notif =
+		(void *)pkt->data;
+	struct iwl_mvm_acs_survey_channel *info;
+	enum nl80211_band band;
+	int chan_idx;
+
+	lockdep_assert_held(&mvm->mutex);
+
+	if (!mvm->acs_survey) {
+		size_t n_channels = 0;
+
+		for (band = 0; band < NUM_NL80211_BANDS; band++) {
+			if (!mvm->hw->wiphy->bands[band])
+				continue;
+
+			n_channels += mvm->hw->wiphy->bands[band]->n_channels;
+		}
+
+		mvm->acs_survey = kzalloc(struct_size(mvm->acs_survey,
+						      channels, n_channels),
+					  GFP_KERNEL);
+
+		if (!mvm->acs_survey)
+			return;
+
+		mvm->acs_survey->n_channels = n_channels;
+		n_channels = 0;
+		for (band = 0; band < NUM_NL80211_BANDS; band++) {
+			if (!mvm->hw->wiphy->bands[band])
+				continue;
+
+			mvm->acs_survey->bands[band] =
+				&mvm->acs_survey->channels[n_channels];
+			n_channels += mvm->hw->wiphy->bands[band]->n_channels;
+		}
+	}
+
+	band = iwl_mvm_nl80211_band_from_phy(le32_to_cpu(notif->band));
+	chan_idx = iwl_mvm_chanidx_from_phy(mvm, band,
+					    le32_to_cpu(notif->channel));
+	if (WARN_ON_ONCE(chan_idx < 0))
+		return;
+
+	IWL_DEBUG_SCAN(mvm, "channel survey received for freq %d\n",
+		       mvm->hw->wiphy->bands[band]->channels[chan_idx].center_freq);
+
+	info = &mvm->acs_survey->bands[band][chan_idx];
+
+	/* Times are all in ms */
+	info->time = le32_to_cpu(notif->active_time);
+	info->time_busy = le32_to_cpu(notif->busy_time);
+	info->time_rx = le32_to_cpu(notif->rx_time);
+	info->time_tx = le32_to_cpu(notif->tx_time);
+	info->noise = iwl_mvm_average_dbm_values(notif);
+}
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/tests/Makefile b/drivers/net/wireless/intel/iwlwifi/mvm/tests/Makefile
index b13aebbf7d5e..6bd56a28cffd 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/tests/Makefile
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/tests/Makefile
@@ -1,3 +1,3 @@
-iwlmvm-tests-y += module.o links.o
+iwlmvm-tests-y += module.o links.o scan.o
 
 obj-$(CONFIG_IWLWIFI_KUNIT_TESTS) += iwlmvm-tests.o
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/tests/scan.c b/drivers/net/wireless/intel/iwlwifi/mvm/tests/scan.c
new file mode 100644
index 000000000000..d3b6a57c3ebe
--- /dev/null
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/tests/scan.c
@@ -0,0 +1,110 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * KUnit tests for channel helper functions
+ *
+ * Copyright (C) 2024 Intel Corporation
+ */
+#include <net/mac80211.h>
+#include "../mvm.h"
+#include <kunit/test.h>
+
+MODULE_IMPORT_NS(EXPORTED_FOR_KUNIT_TESTING);
+
+static const struct acs_average_db_case {
+	const char *desc;
+	u8 neg_dbm[22];
+	s8 result;
+} acs_average_db_cases[] = {
+	{
+		.desc = "Smallest possible value, all filled",
+		.neg_dbm = {
+			128, 128, 128, 128, 128, 128, 128, 128, 128, 128,
+			128, 128, 128, 128, 128, 128, 128, 128, 128, 128,
+			128, 128
+		},
+		.result = -128,
+	},
+	{
+		.desc = "Biggest possible value, all filled",
+		.neg_dbm = {
+			0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
+			0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
+			0, 0,
+		},
+		.result = 0,
+	},
+	{
+		.desc = "Smallest possible value, partial filled",
+		.neg_dbm = {
+			128, 128, 128, 128, 128, 128, 128, 128, 128, 128,
+			0xff, 0xff, 0xff, 0xff, 0xff,
+			0xff, 0xff, 0xff, 0xff, 0xff,
+			0xff, 0xff,
+		},
+		.result = -128,
+	},
+	{
+		.desc = "Biggest possible value, partial filled",
+		.neg_dbm = {
+			0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
+			0xff, 0xff, 0xff, 0xff, 0xff,
+			0xff, 0xff, 0xff, 0xff, 0xff,
+			0xff, 0xff,
+		},
+		.result = 0,
+	},
+	{
+		.desc = "Adding -80dBm to -75dBm until it is still rounded to -79dBm",
+		.neg_dbm = {
+			75, 80, 80, 80, 80, 80, 80, 80, 80, 80,
+			80, 80, 80, 80, 80, 80, 80, 0xff, 0xff, 0xff,
+			0xff, 0xff,
+		},
+		.result = -79,
+	},
+	{
+		.desc = "Adding -80dBm to -75dBm until it is just rounded to -80dBm",
+		.neg_dbm = {
+			75, 80, 80, 80, 80, 80, 80, 80, 80, 80,
+			80, 80, 80, 80, 80, 80, 80, 80, 0xff, 0xff,
+			0xff, 0xff,
+		},
+		.result = -80,
+	},
+};
+
+KUNIT_ARRAY_PARAM_DESC(acs_average_db, acs_average_db_cases, desc)
+
+static void test_acs_average_db(struct kunit *test)
+{
+	const struct acs_average_db_case *params = test->param_value;
+	struct iwl_umac_scan_channel_survey_notif notif;
+	int i;
+
+	/* Test the values in the given order */
+	for (i = 0; i < ARRAY_SIZE(params->neg_dbm); i++)
+		notif.noise[i] = params->neg_dbm[i];
+	KUNIT_ASSERT_EQ(test,
+			iwl_mvm_average_dbm_values(&notif),
+			params->result);
+
+	/* Test in reverse order */
+	for (i = 0; i < ARRAY_SIZE(params->neg_dbm); i++)
+		notif.noise[ARRAY_SIZE(params->neg_dbm) - i - 1] =
+			params->neg_dbm[i];
+	KUNIT_ASSERT_EQ(test,
+			iwl_mvm_average_dbm_values(&notif),
+			params->result);
+}
+
+static struct kunit_case acs_average_db_case[] = {
+	KUNIT_CASE_PARAM(test_acs_average_db, acs_average_db_gen_params),
+	{}
+};
+
+static struct kunit_suite acs_average_db = {
+	.name = "iwlmvm-acs-average-db",
+	.test_cases = acs_average_db_case,
+};
+
+kunit_test_suite(acs_average_db);
-- 
2.34.1


