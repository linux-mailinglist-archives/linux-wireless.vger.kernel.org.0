Return-Path: <linux-wireless+bounces-6393-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D4508A692E
	for <lists+linux-wireless@lfdr.de>; Tue, 16 Apr 2024 12:55:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AA576B236D4
	for <lists+linux-wireless@lfdr.de>; Tue, 16 Apr 2024 10:55:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C2F8128804;
	Tue, 16 Apr 2024 10:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="g2omgHoJ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 336B5128820
	for <linux-wireless@vger.kernel.org>; Tue, 16 Apr 2024 10:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713264892; cv=none; b=kRAmLn+JuWAqPbDrJZGP4B0VZMzsz++HpplC+OdbY3vQ78goSQjwrwm81vPBs24IJ3YHDs6c9MutXD4W7O15DV7+MVN3gwAJ90QphlAXxejZVlvdgisdnM2bZ7ivQXjeGM/kqos+xrs+niszjncPH+QK6Eg7YnCcqsAGrfiMq5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713264892; c=relaxed/simple;
	bh=PFbgEg1ly0OyRt6qUMAZHuHyjfPTve9ASM1NygA18YE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=g8rXrzmXqT7W/0En/ubD9O+Gbdzk+2q3SuVuDC7lAsccuz4uIQnbThwg5QIv+Sg54a3/ICCCxDa0eijd5Bca+4sT37RIools3IqsgjiGJiytNGVFB7lIs5xSnPxLap+QH7R53vVcYqprM/aqTTj8rLsmM2WATnnJMabY3C8kJxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=g2omgHoJ; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713264891; x=1744800891;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=PFbgEg1ly0OyRt6qUMAZHuHyjfPTve9ASM1NygA18YE=;
  b=g2omgHoJ9trXUhdaXnYhVgJdo6TN4bOm+h+UNAJqOZECn59izBHjdL19
   Y7GHC13kQL6qVvkGzDnH5JZMWRyPSgmK6ys5oO5FuvcUdDwR9552WD/ai
   vfMPBT/BKk2nJrcaOfU3GNGOhexDXNy9eWrLmzKX97aEUm9A15Y8MlXpO
   yUdmPEV7Tea5mmTVsjP8lpl/oi8ZFCE4Um6SIlZKRYm7PmDr4tCZ1BAia
   NIOhmuTUNjCs11qTZM8TXlUDR2cmGQkBb7CE1GIgiUcLRR8HyTjW/nW1+
   RAizKOeUiEZLfc2g41pi2Cly3PltZUJTtkFTKNwk9w3idkmcIp4PeIfp4
   A==;
X-CSE-ConnectionGUID: ONFZMmHoRsKwOaMPU7FJ1Q==
X-CSE-MsgGUID: 3CKSYY0oSzaa/dUnvWholg==
X-IronPort-AV: E=McAfee;i="6600,9927,11045"; a="8556079"
X-IronPort-AV: E=Sophos;i="6.07,205,1708416000"; 
   d="scan'208";a="8556079"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2024 03:54:51 -0700
X-CSE-ConnectionGUID: XHGjcjIrQjybZxub67z0zw==
X-CSE-MsgGUID: cxiiZXGyRSyJKpwDzDZ8yw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,205,1708416000"; 
   d="scan'208";a="26872598"
Received: from unknown (HELO WEIS0040.iil.intel.com) ([10.12.217.108])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2024 03:54:50 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org
Subject: [PATCH 16/16] wifi: iwlwifi: mvm: Don't allow EMLSR when the RSSI is low
Date: Tue, 16 Apr 2024 13:54:11 +0300
Message-Id: <20240416134215.73263c000263.Ieb2b18855a2719b5e18ad2fa8a3e855ca4e23938@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240416105411.706221-1-miriam.rachel.korenblit@intel.com>
References: <20240416105411.706221-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

If the RSSI of a link is low enough, don't use it for EMLSR.
If EMLSR is already active and the RSSI of one of the links gets low,
exit EMLSR by deactivating that link.

Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 .../wireless/intel/iwlwifi/mvm/constants.h    |   9 ++
 drivers/net/wireless/intel/iwlwifi/mvm/link.c |  81 ++++++++--
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h  |   9 +-
 drivers/net/wireless/intel/iwlwifi/mvm/rx.c   |  25 +++-
 .../wireless/intel/iwlwifi/mvm/tests/links.c  | 138 ++++++++++++++++--
 5 files changed, 233 insertions(+), 29 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/constants.h b/drivers/net/wireless/intel/iwlwifi/mvm/constants.h
index a79395d8c0f1..d80b21ffbc0a 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/constants.h
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/constants.h
@@ -125,4 +125,13 @@
 #define IWL_MVM_AUTO_EML_ENABLE                 true
 #define IWL_MVM_MISSED_BEACONS_EXIT_ESR_THRESH	7
 
+#define IWL_MVM_HIGH_RSSI_THRESH_20MHZ		-67
+#define IWL_MVM_LOW_RSSI_THRESH_20MHZ		-71
+#define IWL_MVM_HIGH_RSSI_THRESH_40MHZ		-64
+#define IWL_MVM_LOW_RSSI_THRESH_40MHZ		-67
+#define IWL_MVM_HIGH_RSSI_THRESH_80MHZ		-61
+#define IWL_MVM_LOW_RSSI_THRESH_80MHZ		-74
+#define IWL_MVM_HIGH_RSSI_THRESH_160MHZ		-58
+#define IWL_MVM_LOW_RSSI_THRESH_160MHZ		-61
+
 #endif /* __MVM_CONSTANTS_H */
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/link.c b/drivers/net/wireless/intel/iwlwifi/mvm/link.c
index 1171fc831ca8..ae45aa56d01d 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/link.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/link.c
@@ -537,7 +537,8 @@ u8 iwl_mvm_set_link_selection_data(struct ieee80211_vif *vif,
 			continue;
 
 		data[n_data].link_id = link_id;
-		data[n_data].band = link_conf->chanreq.oper.chan->band;
+		data[n_data].chandef = &link_conf->chanreq.oper;
+		data[n_data].signal = link_conf->bss->signal / 100;
 		data[n_data].grade = iwl_mvm_get_link_grade(link_conf);
 
 		if (data[n_data].grade > max_grade) {
@@ -550,21 +551,83 @@ u8 iwl_mvm_set_link_selection_data(struct ieee80211_vif *vif,
 	return n_data;
 }
 
+struct iwl_mvm_bw_to_rssi_threshs {
+	s8 low;
+	s8 high;
+};
+
+#define BW_TO_RSSI_THRESHOLDS(_bw)				\
+	[IWL_PHY_CHANNEL_MODE ## _bw] = {			\
+		.low = IWL_MVM_LOW_RSSI_THRESH_##_bw##MHZ,	\
+		.high = IWL_MVM_HIGH_RSSI_THRESH_##_bw##MHZ	\
+	}
+
+s8 iwl_mvm_get_esr_rssi_thresh(struct iwl_mvm *mvm,
+			       const struct cfg80211_chan_def *chandef,
+			       bool low)
+{
+	const struct iwl_mvm_bw_to_rssi_threshs bw_to_rssi_threshs_map[] = {
+		BW_TO_RSSI_THRESHOLDS(20),
+		BW_TO_RSSI_THRESHOLDS(40),
+		BW_TO_RSSI_THRESHOLDS(80),
+		BW_TO_RSSI_THRESHOLDS(160)
+		/* 320 MHz has the same thresholds as 20 MHz */
+	};
+	const struct iwl_mvm_bw_to_rssi_threshs *threshs;
+	u8 chan_width = iwl_mvm_get_channel_width(chandef);
+
+	if (WARN_ON(chandef->chan->band != NL80211_BAND_2GHZ &&
+		    chandef->chan->band != NL80211_BAND_5GHZ &&
+		    chandef->chan->band != NL80211_BAND_6GHZ))
+		return S8_MAX;
+
+	/* 6 GHz will always use 20 MHz thresholds, regardless of the BW */
+	if (chan_width == IWL_PHY_CHANNEL_MODE320)
+		chan_width = IWL_PHY_CHANNEL_MODE20;
+
+	threshs = &bw_to_rssi_threshs_map[chan_width];
+
+	return low ? threshs->low : threshs->high;
+}
+
+static u32
+iwl_mvm_esr_disallowed_with_link(struct ieee80211_vif *vif,
+				 const struct iwl_mvm_link_sel_data *link)
+{
+	struct iwl_mvm_vif *mvmvif = iwl_mvm_vif_from_mac80211(vif);
+	struct iwl_mvm *mvm = mvmvif->mvm;
+	enum iwl_mvm_esr_state ret = 0;
+	s8 thresh;
+
+	/* BT Coex effects eSR mode only if one of the links is on LB */
+	if (link->chandef->chan->band == NL80211_BAND_2GHZ &&
+	    mvmvif->esr_disable_reason & IWL_MVM_ESR_BLOCKED_COEX)
+		ret |= IWL_MVM_ESR_BLOCKED_COEX;
+	thresh = iwl_mvm_get_esr_rssi_thresh(mvm, link->chandef,
+					     false);
+
+	if (link->signal < thresh)
+		ret |= IWL_MVM_ESR_EXIT_LOW_RSSI;
+
+	if (ret)
+		IWL_DEBUG_INFO(mvm,
+			       "Link %d is not allowed for esr. Reason: 0x%x\n",
+			       link->link_id, ret);
+	return ret;
+}
+
 VISIBLE_IF_IWLWIFI_KUNIT
 bool iwl_mvm_mld_valid_link_pair(struct ieee80211_vif *vif,
 				 const struct iwl_mvm_link_sel_data *a,
 				 const struct iwl_mvm_link_sel_data *b)
 {
-	struct iwl_mvm_vif *mvmvif = iwl_mvm_vif_from_mac80211(vif);
-
-	if (a->band == b->band)
+	/* Per-link considerations */
+	if (iwl_mvm_esr_disallowed_with_link(vif, a) ||
+	    iwl_mvm_esr_disallowed_with_link(vif, b))
 		return false;
 
-	/* BT Coex effects eSR mode only if one of the link is on LB */
-	if (a->band == NL80211_BAND_2GHZ || b->band == NL80211_BAND_2GHZ)
-		return !(mvmvif->esr_disable_reason & IWL_MVM_ESR_BLOCKED_COEX);
-
-	return true;
+	/* Per-combination considerations */
+	return a->chandef->chan->band != b->chandef->chan->band;
 }
 EXPORT_SYMBOL_IF_IWLWIFI_KUNIT(iwl_mvm_mld_valid_link_pair);
 
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
index 2ef346c54d24..421c927ec960 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
@@ -358,12 +358,15 @@ struct iwl_mvm_vif_link_info {
  *	in a loop.
  * @IWL_MVM_ESR_BLOCKED_WOWLAN: WOWLAN is preventing the enablement of EMLSR
  * @IWL_MVM_ESR_EXIT_MISSED_BEACON: exited EMLSR due to missed beacons
+ * @IWL_MVM_ESR_EXIT_LOW_RSSI: link is deactivated/not allowed for EMLSR
+ *	due to low RSSI.
  */
 enum iwl_mvm_esr_state {
 	IWL_MVM_ESR_BLOCKED_COEX	= 0x1,
 	IWL_MVM_ESR_BLOCKED_PREVENTION	= 0x2,
 	IWL_MVM_ESR_BLOCKED_WOWLAN	= 0x4,
 	IWL_MVM_ESR_EXIT_MISSED_BEACON	= 0x10000,
+	IWL_MVM_ESR_EXIT_LOW_RSSI	= 0x20000,
 };
 
 #define IWL_MVM_BLOCK_ESR_REASONS 0xffff
@@ -1998,7 +2001,8 @@ u8 iwl_mvm_get_other_link(struct ieee80211_vif *vif, u8 link_id);
 
 struct iwl_mvm_link_sel_data {
 	u8 link_id;
-	enum nl80211_band band;
+	const struct cfg80211_chan_def *chandef;
+	s32 signal;
 	u16 grade;
 };
 
@@ -2881,5 +2885,8 @@ void iwl_mvm_unblock_esr(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
 void iwl_mvm_exit_esr(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
 		      enum iwl_mvm_esr_state reason,
 		      u8 link_to_keep);
+s8 iwl_mvm_get_esr_rssi_thresh(struct iwl_mvm *mvm,
+			       const struct cfg80211_chan_def *chandef,
+			       bool low);
 
 #endif /* __IWL_MVM_H__ */
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/rx.c b/drivers/net/wireless/intel/iwlwifi/mvm/rx.c
index 4f578f3e7e74..68ec6b8203df 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/rx.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/rx.c
@@ -556,8 +556,8 @@ struct iwl_mvm_stat_data_all_macs {
 	struct iwl_stats_ntfy_per_mac *per_mac;
 };
 
-static void iwl_mvm_update_vif_sig(struct ieee80211_vif *vif, int sig,
-				   struct iwl_mvm_vif_link_info *link_info)
+static void iwl_mvm_update_link_sig(struct ieee80211_vif *vif, int sig,
+				    struct iwl_mvm_vif_link_info *link_info)
 {
 	struct iwl_mvm *mvm = iwl_mvm_vif_from_mac80211(vif)->mvm;
 	struct ieee80211_bss_conf *bss_conf =
@@ -566,6 +566,7 @@ static void iwl_mvm_update_vif_sig(struct ieee80211_vif *vif, int sig,
 	int thold = bss_conf->cqm_rssi_thold;
 	int hyst = bss_conf->cqm_rssi_hyst;
 	int last_event;
+	s8 exit_esr_thresh;
 
 	if (sig == 0) {
 		IWL_DEBUG_RX(mvm, "RSSI is 0 - skip signal based decision\n");
@@ -621,6 +622,20 @@ static void iwl_mvm_update_vif_sig(struct ieee80211_vif *vif, int sig,
 			sig,
 			GFP_KERNEL);
 	}
+
+	/* ESR recalculation */
+	if (!vif->cfg.assoc || !ieee80211_vif_is_mld(vif))
+		return;
+
+	exit_esr_thresh =
+		iwl_mvm_get_esr_rssi_thresh(mvm,
+					    &bss_conf->chanreq.oper,
+					    true);
+
+	if (sig < exit_esr_thresh)
+		iwl_mvm_exit_esr(mvm, vif, IWL_MVM_ESR_EXIT_LOW_RSSI,
+				 iwl_mvm_get_other_link(vif,
+							bss_conf->link_id));
 }
 
 static void iwl_mvm_stat_iterator(void *_data, u8 *mac,
@@ -655,7 +670,7 @@ static void iwl_mvm_stat_iterator(void *_data, u8 *mac,
 			mvmvif->deflink.beacon_stats.num_beacons;
 
 	/* This is used in pre-MLO API so use deflink */
-	iwl_mvm_update_vif_sig(vif, sig, &mvmvif->deflink);
+	iwl_mvm_update_link_sig(vif, sig, &mvmvif->deflink);
 }
 
 static void iwl_mvm_stat_iterator_all_macs(void *_data, u8 *mac,
@@ -690,7 +705,7 @@ static void iwl_mvm_stat_iterator_all_macs(void *_data, u8 *mac,
 	sig = -le32_to_cpu(mac_stats->beacon_filter_average_energy);
 
 	/* This is used in pre-MLO API so use deflink */
-	iwl_mvm_update_vif_sig(vif, sig, &mvmvif->deflink);
+	iwl_mvm_update_link_sig(vif, sig, &mvmvif->deflink);
 }
 
 static inline void
@@ -906,7 +921,7 @@ iwl_mvm_stat_iterator_all_links(struct iwl_mvm *mvm,
 				mvmvif->link[link_id]->beacon_stats.num_beacons;
 
 		sig = -le32_to_cpu(link_stats->beacon_filter_average_energy);
-		iwl_mvm_update_vif_sig(bss_conf->vif, sig, link_info);
+		iwl_mvm_update_link_sig(bss_conf->vif, sig, link_info);
 
 		if (WARN_ONCE(mvmvif->id >= MAC_INDEX_AUX,
 			      "invalid mvmvif id: %d", mvmvif->id))
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/tests/links.c b/drivers/net/wireless/intel/iwlwifi/mvm/tests/links.c
index 17ca85465468..7446e0c168ee 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/tests/links.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/tests/links.c
@@ -22,6 +22,10 @@ static struct ieee80211_channel chan_2ghz = {
 	.band = NL80211_BAND_2GHZ,
 };
 
+static struct cfg80211_chan_def chandef_a = {};
+
+static struct cfg80211_chan_def chandef_b = {};
+
 static struct iwl_mvm_phy_ctxt ctx = {};
 
 static struct iwl_mvm_vif_link_info mvm_link = {
@@ -33,6 +37,8 @@ static struct cfg80211_bss bss = {};
 
 static struct ieee80211_bss_conf link_conf = {.bss = &bss};
 
+static struct iwl_mvm mvm = {};
+
 static const struct link_grading_case {
 	const char *desc;
 	const struct cfg80211_chan_def chandef;
@@ -212,35 +218,119 @@ kunit_test_suite(link_grading);
 static const struct valid_link_pair_case {
 	const char *desc;
 	u32 esr_disable_reason;
-	enum nl80211_band band_a;
-	enum nl80211_band band_b;
+	struct ieee80211_channel *chan_a;
+	struct ieee80211_channel *chan_b;
+	enum nl80211_chan_width cw_a;
+	enum nl80211_chan_width cw_b;
+	s32 sig_a;
+	s32 sig_b;
 	bool valid;
 } valid_link_pair_cases[] = {
 	{
 		.desc = "HB + UHB, valid.",
-		.band_a = NL80211_BAND_5GHZ,
-		.band_b = NL80211_BAND_6GHZ,
+		.chan_a = &chan_5ghz,
+		.chan_b = &chan_6ghz,
 		.valid = true,
 	},
 	{
 		.desc = "LB + HB, no BT.",
-		.band_a = NL80211_BAND_2GHZ,
-		.band_b = NL80211_BAND_5GHZ,
+		.chan_a = &chan_2ghz,
+		.chan_b = &chan_5ghz,
 		.valid = true,
 	},
 	{
 		.desc = "LB + HB, with BT.",
 		.esr_disable_reason = 0x1,
-		.band_a = NL80211_BAND_2GHZ,
-		.band_b = NL80211_BAND_5GHZ,
+		.chan_a = &chan_2ghz,
+		.chan_b = &chan_5ghz,
 		.valid = false,
 	},
 	{
 		.desc = "Same band",
-		.band_a = NL80211_BAND_2GHZ,
-		.band_b = NL80211_BAND_2GHZ,
+		.chan_a = &chan_2ghz,
+		.chan_b = &chan_2ghz,
+		.valid = false,
+	},
+	{
+		.desc = "RSSI: LB, 20 MHz, low",
+		.chan_a = &chan_2ghz,
+		.cw_a = NL80211_CHAN_WIDTH_20,
+		.sig_a = -68,
+		.chan_b = &chan_5ghz,
+		.valid = false,
+	},
+	{
+		.desc = "RSSI: LB, 20 MHz, high",
+		.chan_a = &chan_2ghz,
+		.cw_a = NL80211_CHAN_WIDTH_20,
+		.sig_a = -66,
+		.chan_b = &chan_5ghz,
+		.valid = true,
+	},
+	{
+		.desc = "RSSI: LB, 40 MHz, low",
+		.chan_a = &chan_2ghz,
+		.cw_a = NL80211_CHAN_WIDTH_40,
+		.sig_a = -65,
+		.chan_b = &chan_5ghz,
+		.valid = false,
+	},
+	{
+		.desc = "RSSI: LB, 40 MHz, high",
+		.chan_a = &chan_2ghz,
+		.cw_a = NL80211_CHAN_WIDTH_40,
+		.sig_a = -63,
+		.chan_b = &chan_5ghz,
+		.valid = true,
+	},
+	{
+		.desc = "RSSI: HB, 80 MHz, low",
+		.chan_a = &chan_5ghz,
+		.cw_a = NL80211_CHAN_WIDTH_80,
+		.sig_a = -62,
+		.chan_b = &chan_2ghz,
 		.valid = false,
 	},
+	{
+		.desc = "RSSI: HB, 80 MHz, high",
+		.chan_a = &chan_5ghz,
+		.cw_a = NL80211_CHAN_WIDTH_80,
+		.sig_a = -60,
+		.chan_b = &chan_2ghz,
+		.valid = true,
+	},
+	{
+		.desc = "RSSI: HB, 160 MHz, low",
+		.chan_a = &chan_5ghz,
+		.cw_a = NL80211_CHAN_WIDTH_160,
+		.sig_a = -59,
+		.chan_b = &chan_2ghz,
+		.valid = false,
+	},
+	{
+		.desc = "RSSI: HB, 160 MHz, high",
+		.chan_a = &chan_5ghz,
+		.cw_a = NL80211_CHAN_WIDTH_160,
+		.sig_a = -5,
+		.chan_b = &chan_2ghz,
+		.valid = true,
+	},
+	{
+		.desc = "RSSI: UHB, 320 MHz, low",
+		.chan_a = &chan_6ghz,
+		.cw_a = NL80211_CHAN_WIDTH_320,
+		.sig_a = -68,
+		.chan_b = &chan_6ghz,
+		.valid = false,
+	},
+	{
+		.desc = "RSSI: UHB, 320 MHz, high",
+		.chan_a = &chan_6ghz,
+		.cw_a = NL80211_CHAN_WIDTH_320,
+		.sig_a = -66,
+		.chan_b = &chan_5ghz,
+		.valid = true,
+	},
 };
 
 KUNIT_ARRAY_PARAM_DESC(valid_link_pair, valid_link_pair_cases, desc)
@@ -251,24 +341,44 @@ static void test_valid_link_pair(struct kunit *test)
 	size_t vif_size = sizeof(struct ieee80211_vif) +
 		sizeof(struct iwl_mvm_vif);
 	struct ieee80211_vif *vif = kunit_kzalloc(test, vif_size, GFP_KERNEL);
+	struct iwl_trans *trans = kunit_kzalloc(test, sizeof(struct iwl_trans),
+						GFP_KERNEL);
+	struct iwl_mvm_vif *mvmvif = iwl_mvm_vif_from_mac80211(vif);
 	struct iwl_mvm_link_sel_data link_a = {
-		.band = params->band_a,
+		.chandef = &chandef_a,
+		.link_id = 1,
+		.signal = params->sig_a,
 	};
 	struct iwl_mvm_link_sel_data link_b = {
-		.band = params->band_b,
+		.chandef = &chandef_b,
+		.link_id = 5,
+		.signal = params->sig_b,
 	};
 	bool result;
 
 	KUNIT_ASSERT_NOT_NULL(test, vif);
+	KUNIT_ASSERT_NOT_NULL(test, trans);
+
+	chandef_a.chan = params->chan_a;
+	chandef_b.chan = params->chan_b;
+
+	chandef_a.width = params->cw_a ?: NL80211_CHAN_WIDTH_20;
+	chandef_b.width = params->cw_b ?: NL80211_CHAN_WIDTH_20;
+
+#ifdef CONFIG_IWLWIFI_SUPPORT_DEBUG_OVERRIDES
+	trans->dbg_cfg = default_dbg_config;
+#endif
+	mvm.trans = trans;
 
-	iwl_mvm_vif_from_mac80211(vif)->esr_disable_reason =
-		params->esr_disable_reason;
+	mvmvif->esr_disable_reason = params->esr_disable_reason;
+	mvmvif->mvm = &mvm;
 
 	result = iwl_mvm_mld_valid_link_pair(vif, &link_a, &link_b);
 
 	KUNIT_EXPECT_EQ(test, result, params->valid);
 
 	kunit_kfree(test, vif);
+	kunit_kfree(test, trans);
 }
 
 static struct kunit_case valid_link_pair_test_cases[] = {
-- 
2.34.1


