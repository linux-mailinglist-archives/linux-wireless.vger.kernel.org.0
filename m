Return-Path: <linux-wireless+bounces-20072-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D55CA57F3A
	for <lists+linux-wireless@lfdr.de>; Sat,  8 Mar 2025 23:02:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 837E0188E3B9
	for <lists+linux-wireless@lfdr.de>; Sat,  8 Mar 2025 22:02:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24A4A2116FF;
	Sat,  8 Mar 2025 22:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LxvKa7M7"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B7B520FA9C
	for <linux-wireless@vger.kernel.org>; Sat,  8 Mar 2025 22:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741471317; cv=none; b=Ilf2LYgzHmhXEJ9XU8hGnWSG5VexKPG24+j3RW0oRJG+1sARfjfPITz7BMiVXrb1rqy8nKu1txKBJcr7dU8wrVzapqcL0uL9ej9SyJPyINyfLktEqSLBpa3zn2Hp7mnhvOh4kt7U+KYRKONvJdOM0pGbAGwL/bgkAs5bL+uvRUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741471317; c=relaxed/simple;
	bh=MgcSWvlqTSJCFqt7sKNDMj1UL66ZK5H+l2fI2n5tHi0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nwDbd/i1qy2VUXlwAX0Dwd1vWn6OPSQC+HtHMd72FsIiXo2eCqcPUys0BJryEbUq9Hf0dTiFeWnnUdLjkGIirekaLKkBhOe1ZT699vGsbeb0OkI/bfqQlZnXLe4JGXd9uf7Mm/gTBTYKOhV4K7c5TqJO6shwATOSDfX5NO10/WA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LxvKa7M7; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741471315; x=1773007315;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=MgcSWvlqTSJCFqt7sKNDMj1UL66ZK5H+l2fI2n5tHi0=;
  b=LxvKa7M7DYkg8YzaRDr6DPtHBQvIep375emMfTrx2dezStHt/uitM0RP
   EoQ0wNbFY43YlZzTLWUZadmQ1PfLt/hoAOdDUrib/D26XgbPxNZC5cES5
   2qbDrpUXhmlWnxveh1nnQ6PSFcH2r37Q2E3s3V3grRwJK1rqVynoEq8sk
   omwIazyB02i3yWPIZhljwLLUtjhcjGO/UGQ3+SDNXgp/W7oJAdjRTMPvN
   PRSg9o0Ccrh4ctViNoAQrEcORDON3R9yP2ya4qtOvOmRIXwkNurq1lUzT
   ohxgnx/tGN/ekyMsNVVSdlzpq5jStH56px2ACqCN42gSlNKSquJpSwCdn
   Q==;
X-CSE-ConnectionGUID: LqIr5vyETSO7LMZkIIBluQ==
X-CSE-MsgGUID: AgdlDj6ET86nRrhp7bFfiw==
X-IronPort-AV: E=McAfee;i="6700,10204,11367"; a="42540668"
X-IronPort-AV: E=Sophos;i="6.14,233,1736841600"; 
   d="scan'208";a="42540668"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2025 14:01:55 -0800
X-CSE-ConnectionGUID: DbqAGEN2TC+9he8m3xoFZg==
X-CSE-MsgGUID: jCA5/5FDThG8onHiaaQ7Ww==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,233,1736841600"; 
   d="scan'208";a="120352163"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2025 14:01:53 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Ilan Peer <ilan.peer@intel.com>
Subject: [PATCH wireless-next 12/15] wifi: iwlwifi: mld: Correctly configure the A-MSDU max lengths
Date: Sun,  9 Mar 2025 00:01:22 +0200
Message-Id: <20250308235203.afc842633002.I68153b6b0c5d976f2c7525009631f8fa28e9987c@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250308220125.2388933-1-miriam.rachel.korenblit@intel.com>
References: <20250308220125.2388933-1-miriam.rachel.korenblit@intel.com>
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


