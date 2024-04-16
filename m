Return-Path: <linux-wireless+bounces-6386-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2692C8A6927
	for <lists+linux-wireless@lfdr.de>; Tue, 16 Apr 2024 12:55:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9007C1F21E93
	for <lists+linux-wireless@lfdr.de>; Tue, 16 Apr 2024 10:55:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 121A412839E;
	Tue, 16 Apr 2024 10:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DzfECIw4"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7DC0128807
	for <linux-wireless@vger.kernel.org>; Tue, 16 Apr 2024 10:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713264883; cv=none; b=X3uHwAA+fSFBiSZ5VZn7UhDq0P9MFXeDNsOJuNx1QOBqueYT2qLL0d9fEJEvQmjMDuD0x8ZhBZ38XA9TcHwWoq/1gKD3mAvzfneaVt2BaZRPyE0kqN30S4/JHaMB5NqlAXWi0lGdCScrGGRSJGWaam+AnCukXqzbVJizv0GWDvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713264883; c=relaxed/simple;
	bh=JDkGjh7nSUJV12uBH81Tgi0Nplgpb+Iur0YybFJw9D8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FLZiPy6snUdNEOlQfiXJvNmagXDw+XyiqEhmDyQhchUchBKroOdTsjr9P/HupohZtKbynhyyPZUzLObkU76EWPwqKyxX2G8OzyCjd4iAgz5663SFBbyXBOWQjMJlBU10HUZsIaWEGx8X+iz4wkOHWDiB235eDMF0ZTJ+Hp7YC0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DzfECIw4; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713264881; x=1744800881;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=JDkGjh7nSUJV12uBH81Tgi0Nplgpb+Iur0YybFJw9D8=;
  b=DzfECIw4+RDFVj4e+2yPCeeDvEHbd+/ne3dlsMg4aMMkhJNIimYOKd0c
   MaD6qvU6cKYZv1l3Q4Drmn1FEba62SR9Pax8yzknugzGYA0MYgqthOykn
   82zSrPrUJUKRs53oDcAx9VATL4o70JTEQT9tNJFprW2sl5zsj//zXMKS8
   9m7F67c9y2hk4emwsjQ/u3ZEyEy9gKVz1Xq0jecM6Hrf71cGPEEYSYgeZ
   /HyZMoIYH2rzgdJf7VjMo9/cs7rf7SN1pXCkayE83Wp++8DOpYZ2/v6J0
   qST+Wog6LPKwejtrhBIVqtJfpEkf6uhNYnOksPPHG+iqkv2+H6nuwzmiX
   g==;
X-CSE-ConnectionGUID: wvRWqzxHQDOBR0+01++CSQ==
X-CSE-MsgGUID: rang6/dFTPudsErDjfbqYg==
X-IronPort-AV: E=McAfee;i="6600,9927,11045"; a="8556052"
X-IronPort-AV: E=Sophos;i="6.07,205,1708416000"; 
   d="scan'208";a="8556052"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2024 03:54:41 -0700
X-CSE-ConnectionGUID: LNBeOP7iQGCegTT5dZ37Lw==
X-CSE-MsgGUID: opRcLmqHQOamcyFX0bAp/g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,205,1708416000"; 
   d="scan'208";a="26872513"
Received: from unknown (HELO WEIS0040.iil.intel.com) ([10.12.217.108])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2024 03:54:35 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 08/16] wifi: iwlwifi: mvm: Implement new link selection algorithm
Date: Tue, 16 Apr 2024 13:54:03 +0300
Message-Id: <20240416134215.309fb1b3fe44.I5baf0c293c89a5a28bd1a6386bf9ca6d2bf61ab8@changeid>
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

Replaces the current logic with a new algorithm based on the link
grading introduced in a previous patch.

The new selection algorithm will be invoked upon successful scan to ensure
it has the necessary updated data it needs.

This update delegates the selection logic as the primary link
determiner in EMLSR mode, storing it in mvmvif to avoid repeated
calculations, as the result may vary.

Additionally, includes tests for iwl_mvm_valid_link_pair to validate
link pairs for EMLSR.

Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Reviewed-by: Johannes Berg <johannes.berg@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/coex.c |  14 +-
 drivers/net/wireless/intel/iwlwifi/mvm/d3.c   |  27 +-
 drivers/net/wireless/intel/iwlwifi/mvm/link.c | 266 +++++++++---------
 .../net/wireless/intel/iwlwifi/mvm/mac80211.c |   9 +-
 .../wireless/intel/iwlwifi/mvm/mld-mac80211.c |  37 ++-
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h  |  33 ++-
 drivers/net/wireless/intel/iwlwifi/mvm/ops.c  |   3 +-
 drivers/net/wireless/intel/iwlwifi/mvm/scan.c |  22 +-
 .../wireless/intel/iwlwifi/mvm/tests/links.c  |  74 +++++
 9 files changed, 298 insertions(+), 187 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/coex.c b/drivers/net/wireless/intel/iwlwifi/mvm/coex.c
index f31752bcd2a2..54f086d9457f 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/coex.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/coex.c
@@ -282,7 +282,7 @@ static void iwl_mvm_bt_coex_enable_esr(struct iwl_mvm *mvm,
 static bool
 iwl_mvm_bt_coex_calculate_esr_mode(struct iwl_mvm *mvm,
 				   struct ieee80211_vif *vif,
-				   int link_id, int primary_link)
+				   int link_id)
 {
 	struct iwl_mvm_vif *mvmvif = iwl_mvm_vif_from_mac80211(vif);
 	struct iwl_mvm_vif_link_info *link_info = mvmvif->link[link_id];
@@ -298,7 +298,7 @@ iwl_mvm_bt_coex_calculate_esr_mode(struct iwl_mvm *mvm,
 		return true;
 
 	 /* If LB link is the primary one we should always disable eSR */
-	if (link_id == primary_link)
+	if (link_id == iwl_mvm_get_primary_link(vif))
 		return false;
 
 	/* The feature is not supported */
@@ -340,17 +340,13 @@ void iwl_mvm_bt_coex_update_link_esr(struct iwl_mvm *mvm,
 				     struct ieee80211_vif *vif,
 				     int link_id)
 {
-	unsigned long usable_links = ieee80211_vif_usable_links(vif);
-	int primary_link = iwl_mvm_mld_get_primary_link(mvm, vif,
-							usable_links);
 	bool enable;
 
-	/* Not assoc, not MLD vif or only one usable link */
-	if (primary_link < 0)
+	if (!ieee80211_vif_is_mld(vif) ||
+	    !iwl_mvm_vif_from_mac80211(vif)->authorized)
 		return;
 
-	enable = iwl_mvm_bt_coex_calculate_esr_mode(mvm, vif, link_id,
-						    primary_link);
+	enable = iwl_mvm_bt_coex_calculate_esr_mode(mvm, vif, link_id);
 
 	iwl_mvm_bt_coex_enable_esr(mvm, vif, enable);
 }
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/d3.c b/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
index 886a8074d81f..6763863f4354 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
@@ -1261,31 +1261,22 @@ static int __iwl_mvm_suspend(struct ieee80211_hw *hw,
 	if (IS_ERR_OR_NULL(vif))
 		return 1;
 
-	if (hweight16(vif->active_links) > 1) {
+	mutex_lock(&mvm->mutex);
+
+	primary_link = iwl_mvm_get_primary_link(vif);
+	if (ieee80211_vif_is_mld(vif) && vif->cfg.assoc &&
+	    mvmvif->esr_active) {
 		/*
-		 * Select the 'best' link.
-		 * May need to revisit, it seems better to not optimize
-		 * for throughput but rather range, reliability and
-		 * power here - and select 2.4 GHz ...
+		 * Select the 'best' link. May need to revisit, it seems
+		 * better to not optimize for throughput but rather
+		 * range, reliability and power here - and select
+		 * 2.4 GHz ...
 		 */
-		primary_link = iwl_mvm_mld_get_primary_link(mvm, vif,
-							    vif->active_links);
-
-		if (WARN_ONCE(primary_link < 0, "no primary link in 0x%x\n",
-			      vif->active_links))
-			primary_link = __ffs(vif->active_links);
-
 		ret = ieee80211_set_active_links(vif, BIT(primary_link));
 		if (ret)
 			return ret;
-	} else if (vif->active_links) {
-		primary_link = __ffs(vif->active_links);
-	} else {
-		primary_link = 0;
 	}
 
-	mutex_lock(&mvm->mutex);
-
 	set_bit(IWL_MVM_STATUS_IN_D3, &mvm->status);
 
 	synchronize_net();
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/link.c b/drivers/net/wireless/intel/iwlwifi/mvm/link.c
index 034bac658aad..710c8802a3c6 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/link.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/link.c
@@ -401,20 +401,24 @@ iwl_mvm_get_puncturing_factor(const struct ieee80211_bss_conf *link_conf)
 }
 
 static unsigned int
-iwl_mvm_get_chan_load_factor(struct ieee80211_bss_conf *link_conf)
+iwl_mvm_get_chan_load(struct ieee80211_bss_conf *link_conf)
 {
 	struct iwl_mvm_vif_link_info *mvm_link =
 		iwl_mvm_vif_from_mac80211(link_conf->vif)->link[link_conf->link_id];
-	const struct element *bss_load_elem =
-		ieee80211_bss_get_elem(link_conf->bss, WLAN_EID_QBSS_LOAD);
+	const struct element *bss_load_elem;
 	const struct ieee80211_bss_load_elem *bss_load;
 	enum nl80211_band band = link_conf->chanreq.oper.chan->band;
 	unsigned int chan_load;
 	u32 chan_load_by_us;
 
+	rcu_read_lock();
+	bss_load_elem = ieee80211_bss_get_elem(link_conf->bss,
+					       WLAN_EID_QBSS_LOAD);
+
 	/* If there isn't BSS Load element, take the defaults */
 	if (!bss_load_elem ||
 	    bss_load_elem->datalen != sizeof(*bss_load)) {
+		rcu_read_unlock();
 		switch (band) {
 		case NL80211_BAND_2GHZ:
 			chan_load = DEFAULT_CHAN_LOAD_LB;
@@ -430,20 +434,21 @@ iwl_mvm_get_chan_load_factor(struct ieee80211_bss_conf *link_conf)
 			break;
 		}
 		/* The defaults are given in percentage */
-		return SCALE_FACTOR - NORMALIZE_PERCENT_TO_255(chan_load);
+		return NORMALIZE_PERCENT_TO_255(chan_load);
 	}
 
 	bss_load = (const void *)bss_load_elem->data;
 	/* Channel util is in range 0-255 */
 	chan_load = bss_load->channel_util;
+	rcu_read_unlock();
 
 	if (!mvm_link || !mvm_link->active)
-		goto done;
+		return chan_load;
 
 	if (WARN_ONCE(!mvm_link->phy_ctxt,
 		      "Active link (%u) without phy ctxt assigned!\n",
 		      link_conf->link_id))
-		goto done;
+		return chan_load;
 
 	/* channel load by us is given in percentage */
 	chan_load_by_us =
@@ -452,11 +457,18 @@ iwl_mvm_get_chan_load_factor(struct ieee80211_bss_conf *link_conf)
 	/* Use only values that firmware sends that can possibly be valid */
 	if (chan_load_by_us <= chan_load)
 		chan_load -= chan_load_by_us;
-done:
-	return  SCALE_FACTOR - chan_load;
+
+	return chan_load;
+}
+
+static unsigned int
+iwl_mvm_get_chan_load_factor(struct ieee80211_bss_conf *link_conf)
+{
+	return SCALE_FACTOR - iwl_mvm_get_chan_load(link_conf);
 }
 
 /* This function calculates the grade of a link. Returns 0 in error case */
+VISIBLE_IF_IWLWIFI_KUNIT
 unsigned int iwl_mvm_get_link_grade(struct ieee80211_bss_conf *link_conf)
 {
 	enum nl80211_band band;
@@ -484,6 +496,10 @@ unsigned int iwl_mvm_get_link_grade(struct ieee80211_bss_conf *link_conf)
 
 	rssi_idx = band == NL80211_BAND_2GHZ ? 0 : 1;
 
+	/* No valid RSSI - take the lowest grade */
+	if (!link_rssi)
+		link_rssi = rssi_to_grade_map[0].rssi[rssi_idx];
+
 	/* Get grade based on RSSI */
 	for (i = 0; i < ARRAY_SIZE(rssi_to_grade_map); i++) {
 		const struct iwl_mvm_rssi_to_grade *line =
@@ -502,83 +518,40 @@ unsigned int iwl_mvm_get_link_grade(struct ieee80211_bss_conf *link_conf)
 }
 EXPORT_SYMBOL_IF_IWLWIFI_KUNIT(iwl_mvm_get_link_grade);
 
-/*
- * This function receives a subset of the usable links bitmap and
- * returns the primary link id, and -1 if such link doesn't exist
- * (e.g. non-MLO connection) or wasn't found.
- */
-int iwl_mvm_mld_get_primary_link(struct iwl_mvm *mvm,
-				 struct ieee80211_vif *vif,
-				 unsigned long usable_links)
-{
-	struct iwl_mvm_link_sel_data data[IEEE80211_MLD_MAX_NUM_LINKS];
-	u8 link_id, n_data = 0;
-
-	if (!ieee80211_vif_is_mld(vif) || !vif->cfg.assoc)
-		return -1;
-
-	for_each_set_bit(link_id, &usable_links, IEEE80211_MLD_MAX_NUM_LINKS) {
-		struct ieee80211_bss_conf *link_conf =
-			link_conf_dereference_protected(vif, link_id);
-
-		if (WARN_ON_ONCE(!link_conf))
-			continue;
-
-		data[n_data].link_id = link_id;
-		data[n_data].band = link_conf->chanreq.oper.chan->band;
-		data[n_data].width = link_conf->chanreq.oper.width;
-		data[n_data].active = true;
-		n_data++;
-	}
-
-	if (n_data <= 1)
-		return -1;
-
-	/* The logic should be modified to handle more than 2 links */
-	WARN_ON_ONCE(n_data > 2);
-
-	/* Primary link is the link with the wider bandwidth or higher band */
-	if (data[0].width > data[1].width)
-		return data[0].link_id;
-	if (data[0].width < data[1].width)
-		return data[1].link_id;
-	if (data[0].band >= data[1].band)
-		return data[0].link_id;
-
-	return data[1].link_id;
-}
-
 u8 iwl_mvm_set_link_selection_data(struct ieee80211_vif *vif,
 				   struct iwl_mvm_link_sel_data *data,
-				   unsigned long usable_links)
+				   unsigned long usable_links,
+				   u8 *best_link_idx)
 {
 	u8 n_data = 0;
+	u16 max_grade = 0;
 	unsigned long link_id;
 
-	rcu_read_lock();
-
 	for_each_set_bit(link_id, &usable_links, IEEE80211_MLD_MAX_NUM_LINKS) {
 		struct ieee80211_bss_conf *link_conf =
-			rcu_dereference(vif->link_conf[link_id]);
+			link_conf_dereference_protected(vif, link_id);
 
 		if (WARN_ON_ONCE(!link_conf))
 			continue;
 
 		data[n_data].link_id = link_id;
 		data[n_data].band = link_conf->chanreq.oper.chan->band;
-		data[n_data].width = link_conf->chanreq.oper.width;
-		data[n_data].active = vif->active_links & BIT(link_id);
+		data[n_data].grade = iwl_mvm_get_link_grade(link_conf);
+
+		if (data[n_data].grade > max_grade) {
+			max_grade = data[n_data].grade;
+			*best_link_idx = n_data;
+		}
 		n_data++;
 	}
 
-	rcu_read_unlock();
-
 	return n_data;
 }
 
+VISIBLE_IF_IWLWIFI_KUNIT
 bool iwl_mvm_mld_valid_link_pair(struct ieee80211_vif *vif,
-				 struct iwl_mvm_link_sel_data *a,
-				 struct iwl_mvm_link_sel_data *b)
+				 const struct iwl_mvm_link_sel_data *a,
+				 const struct iwl_mvm_link_sel_data *b)
 {
 	struct iwl_mvm_vif *mvmvif = iwl_mvm_vif_from_mac80211(vif);
 
@@ -591,15 +564,58 @@ bool iwl_mvm_mld_valid_link_pair(struct ieee80211_vif *vif,
 
 	return true;
 }
+EXPORT_SYMBOL_IF_IWLWIFI_KUNIT(iwl_mvm_mld_valid_link_pair);
+
+/*
+ * Returns the combined eSR grade of two given links.
+ * Returns 0 if eSR is not allowed with these 2 links.
+ */
+static
+unsigned int iwl_mvm_get_esr_grade(struct ieee80211_vif *vif,
+				   const struct iwl_mvm_link_sel_data *a,
+				   const struct iwl_mvm_link_sel_data *b,
+				   u8 *primary_id)
+{
+	struct ieee80211_bss_conf *primary_conf;
+	struct wiphy *wiphy = ieee80211_vif_to_wdev(vif)->wiphy;
+	unsigned int primary_load;
+
+	lockdep_assert_wiphy(wiphy);
+
+	/* a is always primary, b is always secondary */
+	if (b->grade > a->grade)
+		swap(a, b);
+
+	*primary_id = a->link_id;
+
+	if (!iwl_mvm_mld_valid_link_pair(vif, a, b))
+		return 0;
+
+	primary_conf = wiphy_dereference(wiphy, vif->link_conf[*primary_id]);
+
+	if (WARN_ON_ONCE(!primary_conf))
+		return 0;
+
+	primary_load = iwl_mvm_get_chan_load(primary_conf);
+
+	return a->grade +
+		((b->grade * primary_load) / SCALE_FACTOR);
+}
 
-void iwl_mvm_mld_select_links(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
-			      bool valid_links_changed)
+void iwl_mvm_select_links(struct iwl_mvm *mvm, struct ieee80211_vif *vif)
 {
 	struct iwl_mvm_link_sel_data data[IEEE80211_MLD_MAX_NUM_LINKS];
-	unsigned long usable_links = ieee80211_vif_usable_links(vif);
+	struct iwl_mvm_link_sel_data *best_link;
+	struct iwl_mvm_vif *mvmvif = iwl_mvm_vif_from_mac80211(vif);
 	u32 max_active_links = iwl_mvm_max_active_links(mvm, vif);
-	u16 new_active_links;
-	u8 n_data, i, j;
+	u16 usable_links = ieee80211_vif_usable_links(vif);
+	u8 best, primary_link, best_in_pair, n_data;
+	u16 max_esr_grade = 0, new_active_links;
+
+	lockdep_assert_wiphy(mvm->hw->wiphy);
+
+	if (!mvmvif->authorized || !ieee80211_vif_is_mld(vif))
+		return;
 
 	if (!IWL_MVM_AUTO_EML_ENABLE)
 		return;
@@ -609,79 +625,69 @@ void iwl_mvm_mld_select_links(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
 	 */
 	WARN_ON_ONCE(max_active_links > 2);
 
-	/* if only a single active link is supported, assume that the one
-	 * selected by higher layer for connection establishment is the best.
-	 */
-	if (max_active_links == 1 && !valid_links_changed)
-		return;
+	n_data = iwl_mvm_set_link_selection_data(vif, data, usable_links,
+						 &best);
 
-	/* If we are already using the maximal number of active links, don't do
-	 * any change. This can later be optimized to pick a 'better' link pair.
-	 */
-	if (hweight16(vif->active_links) == max_active_links)
+	if (WARN(!n_data, "Couldn't find a valid grade for any link!\n"))
 		return;
 
-	if (!iwl_mvm_esr_allowed_on_vif(mvm, vif))
-		return;
+	best_link = &data[best];
+	primary_link = best_link->link_id;
+	new_active_links = BIT(best_link->link_id);
 
-	n_data = iwl_mvm_set_link_selection_data(vif, data, usable_links);
+	/* eSR is not supported/allowed, or only one usable link */
+	if (max_active_links == 1 || !iwl_mvm_esr_allowed_on_vif(mvm, vif) ||
+	    n_data == 1)
+		goto set_active;
 
-	/* this is expected to be the current active link */
-	if (n_data == 1)
-		return;
+	for (u8 a = 0; a < n_data; a++)
+		for (u8 b = a + 1; b < n_data; b++) {
+			u16 esr_grade = iwl_mvm_get_esr_grade(vif, &data[a],
+							      &data[b],
+							      &best_in_pair);
 
-	new_active_links = 0;
+			if (esr_grade <= max_esr_grade)
+				continue;
 
-	/* Assume that after association only a single link is active, thus,
-	 * select only the 2nd link
-	 */
-	if (!valid_links_changed) {
-		for (i = 0; i < n_data; i++) {
-			if (data[i].active)
-				break;
+			max_esr_grade = esr_grade;
+			primary_link = best_in_pair;
+			new_active_links = BIT(data[a].link_id) |
+					   BIT(data[b].link_id);
 		}
 
-		if (WARN_ON_ONCE(i == n_data))
-			return;
+	/* No valid pair was found, go with the best link */
+	if (hweight16(new_active_links) <= 1)
+		goto set_active;
 
-		for (j = 0; j < n_data; j++) {
-			if (i == j)
-				continue;
+	/* prefer single link over marginal eSR improvement */
+	if (best_link->grade * 110 / 100 >= max_esr_grade) {
+		primary_link = best_link->link_id;
+		new_active_links = BIT(best_link->link_id);
+	}
+set_active:
+	IWL_DEBUG_INFO(mvm, "Link selection result: 0x%x. Primary = %d\n",
+		       new_active_links, primary_link);
+	ieee80211_set_active_links_async(vif, new_active_links);
+	mvmvif->link_selection_res = new_active_links;
+	mvmvif->link_selection_primary = primary_link;
+}
 
-			if (iwl_mvm_mld_valid_link_pair(vif, &data[i],
-							&data[j]))
-				break;
-		}
+u8 iwl_mvm_get_primary_link(struct ieee80211_vif *vif)
+{
+	struct iwl_mvm_vif *mvmvif = iwl_mvm_vif_from_mac80211(vif);
 
-		if (j != n_data)
-			new_active_links = BIT(data[i].link_id) |
-				BIT(data[j].link_id);
-	} else {
-		/* Try to find a valid link pair for EMLSR operation. If a pair
-		 * is not found continue using the current active link.
-		 */
-		for (i = 0; i < n_data; i++) {
-			for (j = 0; j < n_data; j++) {
-				if (i == j)
-					continue;
-
-				if (iwl_mvm_mld_valid_link_pair(vif, &data[i],
-								&data[j]))
-					break;
-			}
-
-			/* found a valid pair for EMLSR, use it */
-			if (j != n_data) {
-				new_active_links = BIT(data[i].link_id) |
-					BIT(data[j].link_id);
-				break;
-			}
-		}
-	}
+	lockdep_assert_held(&mvmvif->mvm->mutex);
 
-	if (!new_active_links)
-		return;
+	if (!ieee80211_vif_is_mld(vif))
+		return 0;
+
+	/* In AP mode, there is no primary link */
+	if (vif->type == NL80211_IFTYPE_AP)
+		return __ffs(vif->active_links);
+
+	if (mvmvif->esr_active &&
+	    !WARN_ON(!(BIT(mvmvif->primary_link) & vif->active_links)))
+		return mvmvif->primary_link;
 
-	if (vif->active_links != new_active_links)
-		ieee80211_set_active_links_async(vif, new_active_links);
+	return __ffs(vif->active_links);
 }
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
index 0791dac086e1..a9bcf235cde9 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
@@ -1350,6 +1350,7 @@ void iwl_mvm_mac_stop(struct ieee80211_hw *hw)
 	iwl_mvm_scan_stop(mvm, IWL_MVM_SCAN_INT_MLO, false);
 	mutex_unlock(&mvm->mutex);
 
+	wiphy_work_flush(mvm->hw->wiphy, &mvm->async_handlers_wiphy_wk);
 	flush_work(&mvm->async_handlers_wk);
 	flush_work(&mvm->add_stream_wk);
 
@@ -3883,6 +3884,9 @@ iwl_mvm_sta_state_assoc_to_authorized(struct iwl_mvm *mvm,
 		WARN_ON(iwl_mvm_enable_beacon_filter(mvm, vif));
 
 		mvmvif->authorized = 1;
+		mvmvif->link_selection_res = 0;
+		mvmvif->link_selection_primary =
+			vif->active_links ? __ffs(vif->active_links) : 0;
 
 		callbacks->mac_ctxt_changed(mvm, vif, false);
 		iwl_mvm_mei_host_associated(mvm, vif, mvm_sta);
@@ -3891,11 +3895,11 @@ iwl_mvm_sta_state_assoc_to_authorized(struct iwl_mvm *mvm,
 		iwl_mvm_bt_coex_update_vif_esr(mvm, vif);
 
 		/* when client is authorized (AP station marked as such),
-		 * try to enable more links
+		 * try to enable the best link(s).
 		 */
 		if (vif->type == NL80211_IFTYPE_STATION &&
 		    !test_bit(IWL_MVM_STATUS_IN_HW_RESTART, &mvm->status))
-			iwl_mvm_mld_select_links(mvm, vif, false);
+			iwl_mvm_select_links(mvm, vif);
 	}
 
 	mvm_sta->authorized = true;
@@ -3939,6 +3943,7 @@ iwl_mvm_sta_state_authorized_to_assoc(struct iwl_mvm *mvm,
 		 * time.
 		 */
 		mvmvif->authorized = 0;
+		mvmvif->link_selection_res = 0;
 
 		/* disable beacon filtering */
 		iwl_mvm_disable_beacon_filter(mvm, vif);
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c
index 095c00711b44..105ac43e4cd7 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c
@@ -232,6 +232,12 @@ static int iwl_mvm_esr_mode_active(struct iwl_mvm *mvm,
 		link->phy_ctxt->rlc_disabled = true;
 	}
 
+	if (vif->active_links == mvmvif->link_selection_res &&
+	    !WARN_ON(!(vif->active_links & BIT(mvmvif->link_selection_primary))))
+		mvmvif->primary_link = mvmvif->link_selection_primary;
+	else
+		mvmvif->primary_link = __ffs(vif->active_links);
+
 	return ret;
 }
 
@@ -689,9 +695,6 @@ iwl_mvm_mld_link_info_changed_station(struct iwl_mvm *mvm,
 	if (ret)
 		IWL_ERR(mvm, "failed to update MAC %pM\n", vif->addr);
 
-	if (changes & BSS_CHANGED_MLD_VALID_LINKS)
-		iwl_mvm_mld_select_links(mvm, vif, true);
-
 	memcpy(mvmvif->link[link_conf->link_id]->bssid, link_conf->bssid,
 	       ETH_ALEN);
 
@@ -1112,6 +1115,14 @@ iwl_mvm_mld_change_vif_links(struct ieee80211_hw *hw,
 	if (new_links == 0) {
 		mvmvif->link[0] = &mvmvif->deflink;
 		err = iwl_mvm_add_link(mvm, vif, &vif->bss_conf);
+		if (err == 0)
+			mvmvif->primary_link = 0;
+	} else if (!(new_links & BIT(mvmvif->primary_link))) {
+		/*
+		 * Ensure we always have a valid primary_link, the real
+		 * decision happens later when PHY is activated.
+		 */
+		mvmvif->primary_link = BIT(__ffs(new_links));
 	}
 
 out_err:
@@ -1144,27 +1155,22 @@ void iwl_mvm_recalc_esr(struct iwl_mvm *mvm, struct ieee80211_vif *vif)
 {
 	struct iwl_mvm_vif *mvmvif = iwl_mvm_vif_from_mac80211(vif);
 	bool enable = !mvmvif->esr_disable_reason;
-	int link_id;
+	u16 new_active_links;
 
 	/* Nothing to do */
 	if (mvmvif->esr_active == enable)
 		return;
 
-	if (enable) {
-		/* Try to re-enable eSR */
-		iwl_mvm_mld_select_links(mvm, vif, false);
+	/* The next link selection will enter eSR if possible */
+	if (enable)
 		return;
-	}
 
 	/*
 	 * Find the primary link, as we want to switch to it and drop the
 	 * secondary one.
 	 */
-	link_id = iwl_mvm_mld_get_primary_link(mvm, vif, vif->active_links);
-	WARN_ON(link_id < 0);
-
-	ieee80211_set_active_links_async(vif,
-					 vif->active_links & BIT(link_id));
+	new_active_links = BIT(iwl_mvm_get_primary_link(vif));
+	ieee80211_set_active_links_async(vif, new_active_links);
 }
 
 bool iwl_mvm_esr_allowed_on_vif(struct iwl_mvm *mvm,
@@ -1200,12 +1206,13 @@ static bool iwl_mvm_can_enter_esr(struct iwl_mvm *mvm,
 				  unsigned long desired_links)
 {
 	struct iwl_mvm_link_sel_data data[IEEE80211_MLD_MAX_NUM_LINKS];
-	u8 n_data;
+	u8 best_link, n_data;
 
 	if (!iwl_mvm_esr_allowed_on_vif(mvm, vif))
 		return false;
 
-	n_data = iwl_mvm_set_link_selection_data(vif, data, desired_links);
+	n_data = iwl_mvm_set_link_selection_data(vif, data, desired_links,
+						 &best_link);
 
 	if (n_data != 2)
 		return false;
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
index dd9bead2d7fc..4755747822b6 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
@@ -388,6 +388,12 @@ enum iwl_mvm_esr_disable_reason {
  * @esr_active: indicates eSR mode is active
  * @esr_disable_reason: a bitmap of enum iwl_mvm_esr_disable_reason
  * @pm_enabled: indicates powersave is enabled
+ * @link_selection_res: bitmap of active links as it was decided in the last
+ *	link selection. Valid only for a MLO vif after assoc. 0 if there wasn't
+ *	any link selection yet.
+ * @link_selection_primary: primary link selected by link selection
+ * @primary_link: primary link in eSR. Valid only for an associated MLD vif,
+ *	and in eSR mode. Valid only for a STA.
  */
 struct iwl_mvm_vif {
 	struct iwl_mvm *mvm;
@@ -478,6 +484,9 @@ struct iwl_mvm_vif {
 		struct ieee80211_key_conf __rcu *keys[2];
 	} bcn_prot;
 
+	u16 link_selection_res;
+	u8 link_selection_primary;
+	u8 primary_link;
 	struct iwl_mvm_vif_link_info deflink;
 	struct iwl_mvm_vif_link_info *link[IEEE80211_MLD_MAX_NUM_LINKS];
 };
@@ -1944,24 +1953,27 @@ int iwl_mvm_remove_link(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
 int iwl_mvm_disable_link(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
 			 struct ieee80211_bss_conf *link_conf);
 
-void iwl_mvm_mld_select_links(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
-			      bool valid_links_changed);
-int iwl_mvm_mld_get_primary_link(struct iwl_mvm *mvm,
-				 struct ieee80211_vif *vif,
-				 unsigned long usable_links);
+void iwl_mvm_select_links(struct iwl_mvm *mvm, struct ieee80211_vif *vif);
+u8 iwl_mvm_get_primary_link(struct ieee80211_vif *vif);
+
+#if IS_ENABLED(CONFIG_IWLWIFI_KUNIT_TESTS)
+unsigned int iwl_mvm_get_link_grade(struct ieee80211_bss_conf *link_conf);
+#endif
+
 struct iwl_mvm_link_sel_data {
 	u8 link_id;
 	enum nl80211_band band;
-	enum nl80211_chan_width width;
-	bool active;
+	u16 grade;
 };
 
 u8 iwl_mvm_set_link_selection_data(struct ieee80211_vif *vif,
 				   struct iwl_mvm_link_sel_data *data,
-				   unsigned long usable_links);
+				   unsigned long usable_links,
+				   u8 *best_link_idx);
 bool iwl_mvm_mld_valid_link_pair(struct ieee80211_vif *vif,
-				 struct iwl_mvm_link_sel_data *a,
-				 struct iwl_mvm_link_sel_data *b);
+				 const struct iwl_mvm_link_sel_data *a,
+				 const struct iwl_mvm_link_sel_data *b);
+
 /* AP and IBSS */
 bool iwl_mvm_start_ap_ibss_common(struct ieee80211_hw *hw,
 				  struct ieee80211_vif *vif, int *ret);
@@ -2461,7 +2473,6 @@ u32 iwl_mvm_get_sec_flags(struct iwl_mvm *mvm,
 			  struct ieee80211_vif *vif,
 			  struct ieee80211_sta *sta,
 			  struct ieee80211_key_conf *keyconf);
-unsigned int iwl_mvm_get_link_grade(struct ieee80211_bss_conf *link_conf);
 
 bool iwl_rfi_supported(struct iwl_mvm *mvm);
 int iwl_rfi_send_config_cmd(struct iwl_mvm *mvm,
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/ops.c b/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
index 5cdad4dfa699..7b70248c6090 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
@@ -365,7 +365,8 @@ static const struct iwl_rx_handlers iwl_mvm_rx_handlers[] = {
 			   iwl_mvm_rx_scan_match_found,
 			   RX_HANDLER_SYNC),
 	RX_HANDLER(SCAN_COMPLETE_UMAC, iwl_mvm_rx_umac_scan_complete_notif,
-		   RX_HANDLER_ASYNC_LOCKED, struct iwl_umac_scan_complete),
+		   RX_HANDLER_ASYNC_LOCKED_WIPHY,
+		   struct iwl_umac_scan_complete),
 	RX_HANDLER(SCAN_ITERATION_COMPLETE_UMAC,
 		   iwl_mvm_rx_umac_scan_iter_complete_notif, RX_HANDLER_SYNC,
 		   struct iwl_umac_scan_iter_complete_notif),
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/scan.c b/drivers/net/wireless/intel/iwlwifi/mvm/scan.c
index 2f55de11cd52..8ef4b12eb156 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/scan.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/scan.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
 /*
- * Copyright (C) 2012-2014, 2018-2023 Intel Corporation
+ * Copyright (C) 2012-2014, 2018-2024 Intel Corporation
  * Copyright (C) 2013-2015 Intel Mobile Communications GmbH
  * Copyright (C) 2016-2017 Intel Deutschland GmbH
  */
@@ -3180,6 +3180,23 @@ int iwl_mvm_sched_scan_start(struct iwl_mvm *mvm,
 	return ret;
 }
 
+static void iwl_mvm_find_link_selection_vif(void *_data, u8 *mac,
+					    struct ieee80211_vif *vif)
+{
+	struct iwl_mvm_vif *mvmvif = iwl_mvm_vif_from_mac80211(vif);
+
+	if (ieee80211_vif_is_mld(vif) && mvmvif->authorized)
+		iwl_mvm_select_links(mvmvif->mvm, vif);
+}
+
+static void iwl_mvm_post_scan_link_selection(struct iwl_mvm *mvm)
+{
+	ieee80211_iterate_active_interfaces(mvm->hw,
+					    IEEE80211_IFACE_ITER_NORMAL,
+					    iwl_mvm_find_link_selection_vif,
+					    NULL);
+}
+
 void iwl_mvm_rx_umac_scan_complete_notif(struct iwl_mvm *mvm,
 					 struct iwl_rx_cmd_buffer *rxb)
 {
@@ -3239,6 +3256,9 @@ void iwl_mvm_rx_umac_scan_complete_notif(struct iwl_mvm *mvm,
 		mvm->last_ebs_successful = false;
 
 	mvm->scan_uid_status[uid] = 0;
+
+	if (notif->status == IWL_SCAN_OFFLOAD_COMPLETED)
+		iwl_mvm_post_scan_link_selection(mvm);
 }
 
 void iwl_mvm_rx_umac_scan_iter_complete_notif(struct iwl_mvm *mvm,
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/tests/links.c b/drivers/net/wireless/intel/iwlwifi/mvm/tests/links.c
index 321d18de1ca3..17ca85465468 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/tests/links.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/tests/links.c
@@ -208,3 +208,77 @@ static struct kunit_suite link_grading = {
 };
 
 kunit_test_suite(link_grading);
+
+static const struct valid_link_pair_case {
+	const char *desc;
+	u32 esr_disable_reason;
+	enum nl80211_band band_a;
+	enum nl80211_band band_b;
+	bool valid;
+} valid_link_pair_cases[] = {
+	{
+		.desc = "HB + UHB, valid.",
+		.band_a = NL80211_BAND_5GHZ,
+		.band_b = NL80211_BAND_6GHZ,
+		.valid = true,
+	},
+	{
+		.desc = "LB + HB, no BT.",
+		.band_a = NL80211_BAND_2GHZ,
+		.band_b = NL80211_BAND_5GHZ,
+		.valid = true,
+	},
+	{
+		.desc = "LB + HB, with BT.",
+		.esr_disable_reason = 0x1,
+		.band_a = NL80211_BAND_2GHZ,
+		.band_b = NL80211_BAND_5GHZ,
+		.valid = false,
+	},
+	{
+		.desc = "Same band",
+		.band_a = NL80211_BAND_2GHZ,
+		.band_b = NL80211_BAND_2GHZ,
+		.valid = false,
+	},
+};
+
+KUNIT_ARRAY_PARAM_DESC(valid_link_pair, valid_link_pair_cases, desc)
+
+static void test_valid_link_pair(struct kunit *test)
+{
+	const struct valid_link_pair_case *params = test->param_value;
+	size_t vif_size = sizeof(struct ieee80211_vif) +
+		sizeof(struct iwl_mvm_vif);
+	struct ieee80211_vif *vif = kunit_kzalloc(test, vif_size, GFP_KERNEL);
+	struct iwl_mvm_link_sel_data link_a = {
+		.band = params->band_a,
+	};
+	struct iwl_mvm_link_sel_data link_b = {
+		.band = params->band_b,
+	};
+	bool result;
+
+	KUNIT_ASSERT_NOT_NULL(test, vif);
+
+	iwl_mvm_vif_from_mac80211(vif)->esr_disable_reason =
+		params->esr_disable_reason;
+
+	result = iwl_mvm_mld_valid_link_pair(vif, &link_a, &link_b);
+
+	KUNIT_EXPECT_EQ(test, result, params->valid);
+
+	kunit_kfree(test, vif);
+}
+
+static struct kunit_case valid_link_pair_test_cases[] = {
+	KUNIT_CASE_PARAM(test_valid_link_pair, valid_link_pair_gen_params),
+	{},
+};
+
+static struct kunit_suite valid_link_pair = {
+	.name = "iwlmvm-valid-link-pair",
+	.test_cases = valid_link_pair_test_cases,
+};
+
+kunit_test_suite(valid_link_pair);
-- 
2.34.1


