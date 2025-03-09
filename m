Return-Path: <linux-wireless+bounces-20088-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 703D7A580AC
	for <lists+linux-wireless@lfdr.de>; Sun,  9 Mar 2025 06:38:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9E31616BFBA
	for <lists+linux-wireless@lfdr.de>; Sun,  9 Mar 2025 05:38:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F28881531D5;
	Sun,  9 Mar 2025 05:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XzbLNuoj"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A4D914AD0D
	for <linux-wireless@vger.kernel.org>; Sun,  9 Mar 2025 05:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741498646; cv=none; b=ak3wqS6BctD2fY+XFG0UKXI+XwbOnikSaFbvHHNrpNuysvk6+iw8b0fMo9+QYlGxmLF+i79LlY1XEpl0G8lTVLHQJWh/rgzmN9IRBbhddkD5UU25sGvJ0P4GCPjwiEAOHnaxfJe1YIvP6JtvHAAVtAFpU0OTH6TpsvO5cgjxJjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741498646; c=relaxed/simple;
	bh=MgcSWvlqTSJCFqt7sKNDMj1UL66ZK5H+l2fI2n5tHi0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SKOzuRZ+kktTCSx1DKFSdZ/SoATl/CdvalZ9t1EJgzFACKsZFyV892QsCS84nyvK7ggZQ3vHHcuE9JuhKkROrijB/JtoYdKxlsiBdnExB4z01bn/w3pik6BEE+qnBGqeT+XXKu5wFpEa/sOxHRzC7mS1iPMYoYnI7cLtulkpwF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XzbLNuoj; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741498645; x=1773034645;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=MgcSWvlqTSJCFqt7sKNDMj1UL66ZK5H+l2fI2n5tHi0=;
  b=XzbLNuoje1+seG9VqULZiTTf74p/6/G+OSKIvCRar6IHyJXjaeBnTXZE
   lewO0CMvyo5GGoMoXcnTvb2N6HLgtvClRiRVz3/+y16LA4S3DdUvlhy8/
   8+3A7h+LOVX3f95SkhKjMLOD534bD302wXK33SYF8t2uNePUiQTjSXhpR
   AT4rhey8yFWk4ba7vEgfXo4A9s7IpGMf35l+4I5XZalnSO45wgA5OHzXO
   DPw2am3ixM1GgnGPi0maYfJ593lwEqGHEN5qxnxDdyo7s2OPD4joivdiQ
   Fwhc6L1qz8rdDuae6kJbl8trbh/wLZ4JgEL5eHu6DDGjJHh20ivkj+fSC
   g==;
X-CSE-ConnectionGUID: eDwEfhikS0CMHd31+JwMZQ==
X-CSE-MsgGUID: 1+c255ZYTMusnKyIxjmYFA==
X-IronPort-AV: E=McAfee;i="6700,10204,11367"; a="41671709"
X-IronPort-AV: E=Sophos;i="6.14,233,1736841600"; 
   d="scan'208";a="41671709"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2025 21:37:25 -0800
X-CSE-ConnectionGUID: CkjbpTopQS2tsna5uTR10Q==
X-CSE-MsgGUID: 3p/LK3RlRiSWDcTclfvJ7Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,233,1736841600"; 
   d="scan'208";a="150470657"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2025 21:37:23 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Ilan Peer <ilan.peer@intel.com>
Subject: [PATCH v2 wireless-next 12/15] wifi: iwlwifi: mld: Correctly configure the A-MSDU max lengths
Date: Sun,  9 Mar 2025 07:36:50 +0200
Message-Id: <20250309073442.afc842633002.I68153b6b0c5d976f2c7525009631f8fa28e9987c@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250309053653.2697525-1-miriam.rachel.korenblit@intel.com>
References: <20250309053653.2697525-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Ilan Peer <ilan.peer@intel.com>

Refactor the setting of the A-MSDU maximal lengths as follows:

- Move the setting of the maximal A-MSDU length in case of HT from TLC
  logic to the station logic as it is not related to TLC.
- As long as the station is not associated, set RC A-MSDU maximal
  lengths to 1, to prevent iwlmld and mac80211 from building A-MSDUs.
- Update the RC and the TID specific A-MSDU maximal lengths based on
  the FW TLC notifications.

Signed-off-by: Ilan Peer <ilan.peer@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mld/sta.c | 24 +++++++++++
 drivers/net/wireless/intel/iwlwifi/mld/tlc.c | 43 ++++++--------------
 2 files changed, 37 insertions(+), 30 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mld/sta.c b/drivers/net/wireless/intel/iwlwifi/mld/sta.c
index 994d4561518b..332a7aecec2d 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/sta.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/sta.c
@@ -606,6 +606,25 @@ iwl_mld_remove_link_sta(struct iwl_mld *mld,
 		kfree_rcu(mld_link_sta, rcu_head);
 }
 
+static void iwl_mld_set_max_amsdu_len(struct iwl_mld *mld,
+				      struct ieee80211_link_sta *link_sta)
+{
+	const struct ieee80211_sta_ht_cap *ht_cap = &link_sta->ht_cap;
+
+	/* For EHT, HE and VHT we can use the value as it was calculated by
+	 * mac80211. For HT, mac80211 doesn't enforce to 4095, so force it
+	 * here
+	 */
+	if (link_sta->eht_cap.has_eht || link_sta->he_cap.has_he ||
+	    link_sta->vht_cap.vht_supported ||
+	    !ht_cap->ht_supported ||
+	    !(ht_cap->cap & IEEE80211_HT_CAP_MAX_AMSDU))
+		return;
+
+	link_sta->agg.max_amsdu_len = IEEE80211_MAX_MPDU_LEN_HT_BA;
+	ieee80211_sta_recalc_aggregates(link_sta->sta);
+}
+
 int iwl_mld_update_all_link_stations(struct iwl_mld *mld,
 				     struct ieee80211_sta *sta)
 {
@@ -618,6 +637,9 @@ int iwl_mld_update_all_link_stations(struct iwl_mld *mld,
 
 		if (ret)
 			return ret;
+
+		if (mld_sta->sta_state == IEEE80211_STA_ASSOC)
+			iwl_mld_set_max_amsdu_len(mld, link_sta);
 	}
 	return 0;
 }
@@ -1222,6 +1244,8 @@ int iwl_mld_update_link_stas(struct iwl_mld *mld,
 
 		link = link_conf_dereference_protected(mld_sta->vif,
 						       link_sta->link_id);
+
+		iwl_mld_set_max_amsdu_len(mld, link_sta);
 		iwl_mld_config_tlc_link(mld, vif, link, link_sta);
 
 		sta_mask_added |= BIT(mld_link_sta->fw_id);
diff --git a/drivers/net/wireless/intel/iwlwifi/mld/tlc.c b/drivers/net/wireless/intel/iwlwifi/mld/tlc.c
index 85ec358f1417..f054cc921d9d 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/tlc.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/tlc.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
 /*
- * Copyright (C) 2024 Intel Corporation
+ * Copyright (C) 2024-2025 Intel Corporation
  */
 
 #include <net/mac80211.h>
@@ -467,7 +467,7 @@ static void iwl_mld_send_tlc_cmd(struct iwl_mld *mld,
 						   own_he_cap, own_eht_cap),
 		.chains = iwl_mld_get_fw_chains(mld),
 		.sgi_ch_width_supp = iwl_mld_get_fw_sgi(link_sta),
-		.max_mpdu_len = cpu_to_le16(link_sta->agg.max_rc_amsdu_len),
+		.max_mpdu_len = cpu_to_le16(link_sta->agg.max_amsdu_len),
 	};
 	int fw_sta_id = iwl_mld_fw_sta_id_from_link_sta(mld, link_sta);
 	int ret;
@@ -493,30 +493,6 @@ static void iwl_mld_send_tlc_cmd(struct iwl_mld *mld,
 		IWL_ERR(mld, "Failed to send TLC cmd (%d)\n", ret);
 }
 
-static void iwl_mld_recalc_amsdu_len(struct iwl_mld *mld,
-				     struct ieee80211_link_sta *link_sta)
-{
-	const struct ieee80211_sta_ht_cap *ht_cap = &link_sta->ht_cap;
-
-	/* For EHT, HE and VHT - we can use the value as it was calculated by
-	 * mac80211.
-	 */
-	if (link_sta->eht_cap.has_eht || link_sta->he_cap.has_he ||
-	    link_sta->vht_cap.vht_supported)
-		goto recalc;
-
-	/* But for HT, mac80211 doesn't enforce to 4095, so force it here */
-	if (ht_cap->ht_supported && ht_cap->cap & IEEE80211_HT_CAP_MAX_AMSDU)
-		/* Agg is offloaded, so we need to assume that agg are enabled
-		 * and max mpdu in ampdu is 4095 (spec 802.11-2016 9.3.2.1)
-		 */
-		link_sta->agg.max_amsdu_len = IEEE80211_MAX_MPDU_LEN_HT_BA;
-
-recalc:
-	link_sta->agg.max_rc_amsdu_len = link_sta->agg.max_amsdu_len;
-	ieee80211_sta_recalc_aggregates(link_sta->sta);
-}
-
 int iwl_mld_send_tlc_dhc(struct iwl_mld *mld, u8 sta_id, u32 type, u32 data)
 {
 	struct {
@@ -547,15 +523,22 @@ void iwl_mld_config_tlc_link(struct iwl_mld *mld,
 			     struct ieee80211_bss_conf *link_conf,
 			     struct ieee80211_link_sta *link_sta)
 {
+	struct iwl_mld_sta *mld_sta = iwl_mld_sta_from_mac80211(link_sta->sta);
 	enum nl80211_band band;
 
 	if (WARN_ON_ONCE(!link_conf->chanreq.oper.chan))
 		return;
 
-	band = link_conf->chanreq.oper.chan->band;
-
-	iwl_mld_recalc_amsdu_len(mld, link_sta);
+	/* Before we have information about a station, configure the A-MSDU RC
+	 * limit such that iwlmd and mac80211 would not be allowed to build
+	 * A-MSDUs.
+	 */
+	if (mld_sta->sta_state < IEEE80211_STA_ASSOC) {
+		link_sta->agg.max_rc_amsdu_len = 1;
+		ieee80211_sta_recalc_aggregates(link_sta->sta);
+	}
 
+	band = link_conf->chanreq.oper.chan->band;
 	iwl_mld_send_tlc_cmd(mld, vif, link_sta, band);
 }
 
@@ -706,7 +689,7 @@ void iwl_mld_handle_tlc_notif(struct iwl_mld *mld,
 			link_sta->agg.max_tid_amsdu_len[i] =
 				iwl_mld_get_amsdu_size_of_tid(mld, link_sta, i);
 		else
-			link_sta->agg.max_tid_amsdu_len[i] = 0;
+			link_sta->agg.max_tid_amsdu_len[i] = 1;
 	}
 
 	ieee80211_sta_recalc_aggregates(link_sta->sta);
-- 
2.34.1


