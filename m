Return-Path: <linux-wireless+bounces-6384-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EAFA08A6925
	for <lists+linux-wireless@lfdr.de>; Tue, 16 Apr 2024 12:55:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4F811B2311B
	for <lists+linux-wireless@lfdr.de>; Tue, 16 Apr 2024 10:55:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBB0D129A66;
	Tue, 16 Apr 2024 10:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bwvyFFmT"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D68D8129E66
	for <linux-wireless@vger.kernel.org>; Tue, 16 Apr 2024 10:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713264876; cv=none; b=PJJI1qErJ43IiCOkeV/gMVKuqEp+EtsoZCchSksNnB7SgFQHxqOktRCC5tIs3XDr6PCrzD0KILJftEH/amENOJjxdjAo4FcZqViuXL0ZMbAH2UMIE4XiTT7+7ABHm2cmIsPeKu8HAxxmOOdtOQb557zd82dAQlHMTWkqitX7iTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713264876; c=relaxed/simple;
	bh=zA+wOvB21ooZNJziPZHG3Pi8xTzCSEEp9Rgw+qjQH/U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GTog+fjk3Eb8FOWWnI04ELehFqeg/t2NwSscPBNi7nG50LOAhvhMaSf+nv6jjsPukdc+0gXl+Fva7Glro6eHFq+vqZ+/GvbrCdbiKwll7ZqItuEBdTArC9RF4df6tFaWZ07vDg48R1mkHTK/SsO0RT1l7d09bqB4B3SWrZObzQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bwvyFFmT; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713264875; x=1744800875;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=zA+wOvB21ooZNJziPZHG3Pi8xTzCSEEp9Rgw+qjQH/U=;
  b=bwvyFFmTdqU1i5yClQ0K3dVAAvt7hYgr6hUsw9dn9a7oIQSBhvGnDG7t
   ZTqIrxYxOm5GELwc97FzAVOBmUkWOBq+GnWsEHFwcJXuDnve9Yc4T0Srf
   4aV+zdp8GdIR2w/hjdoT8f7oN5+f5qYHXi30xseLePuB75Ddh6w2Lax2l
   CmEtKqAhOdeH8n6fyVwHOg+saAjOAgfkkpoD+tgAJiHfk2R9OINWoDYRn
   LxFnsTjVmRfGlsBACYzfJTtSsq2CpUQFcsFs9cHz+ahxsVE1VRqg0gWx6
   rdNO5H0VCSpOV1H0HEWT50VxYygEgG/XOVjuAMCh89NyEqIsD9hVX3/Ju
   g==;
X-CSE-ConnectionGUID: WZAfOeQwQFKnuYWRWeVPoQ==
X-CSE-MsgGUID: xYsakgGPTEyZDhe38W3kQQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11045"; a="8556045"
X-IronPort-AV: E=Sophos;i="6.07,205,1708416000"; 
   d="scan'208";a="8556045"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2024 03:54:34 -0700
X-CSE-ConnectionGUID: jlxm7pOdQyymz12xYGqKPQ==
X-CSE-MsgGUID: Of9gyCnbTAmfdHR5+MM1uA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,205,1708416000"; 
   d="scan'208";a="26872499"
Received: from unknown (HELO WEIS0040.iil.intel.com) ([10.12.217.108])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2024 03:54:33 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 07/16] wifi: iwlwifi: mvm: move EMLSR/links code
Date: Tue, 16 Apr 2024 13:54:02 +0300
Message-Id: <20240416134215.e7c368256fa0.I6b15805a7c8a75d1814f1a829601daf4d3788731@changeid>
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

The functions that are link related, so they should be in link.c and
not in mld-mac80211.c. Move them.
Also move the different prototypes to the right place in mvm.h

Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Reviewed-by: Johannes Berg <johannes.berg@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/link.c | 184 ++++++++++++++
 .../wireless/intel/iwlwifi/mvm/mld-mac80211.c | 240 ++----------------
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h  |  26 +-
 3 files changed, 228 insertions(+), 222 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/link.c b/drivers/net/wireless/intel/iwlwifi/mvm/link.c
index 23660238348b..034bac658aad 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/link.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/link.c
@@ -501,3 +501,187 @@ unsigned int iwl_mvm_get_link_grade(struct ieee80211_bss_conf *link_conf)
 	return grade;
 }
 EXPORT_SYMBOL_IF_IWLWIFI_KUNIT(iwl_mvm_get_link_grade);
+
+/*
+ * This function receives a subset of the usable links bitmap and
+ * returns the primary link id, and -1 if such link doesn't exist
+ * (e.g. non-MLO connection) or wasn't found.
+ */
+int iwl_mvm_mld_get_primary_link(struct iwl_mvm *mvm,
+				 struct ieee80211_vif *vif,
+				 unsigned long usable_links)
+{
+	struct iwl_mvm_link_sel_data data[IEEE80211_MLD_MAX_NUM_LINKS];
+	u8 link_id, n_data = 0;
+
+	if (!ieee80211_vif_is_mld(vif) || !vif->cfg.assoc)
+		return -1;
+
+	for_each_set_bit(link_id, &usable_links, IEEE80211_MLD_MAX_NUM_LINKS) {
+		struct ieee80211_bss_conf *link_conf =
+			link_conf_dereference_protected(vif, link_id);
+
+		if (WARN_ON_ONCE(!link_conf))
+			continue;
+
+		data[n_data].link_id = link_id;
+		data[n_data].band = link_conf->chanreq.oper.chan->band;
+		data[n_data].width = link_conf->chanreq.oper.width;
+		data[n_data].active = true;
+		n_data++;
+	}
+
+	if (n_data <= 1)
+		return -1;
+
+	/* The logic should be modified to handle more than 2 links */
+	WARN_ON_ONCE(n_data > 2);
+
+	/* Primary link is the link with the wider bandwidth or higher band */
+	if (data[0].width > data[1].width)
+		return data[0].link_id;
+	if (data[0].width < data[1].width)
+		return data[1].link_id;
+	if (data[0].band >= data[1].band)
+		return data[0].link_id;
+
+	return data[1].link_id;
+}
+
+u8 iwl_mvm_set_link_selection_data(struct ieee80211_vif *vif,
+				   struct iwl_mvm_link_sel_data *data,
+				   unsigned long usable_links)
+{
+	u8 n_data = 0;
+	unsigned long link_id;
+
+	rcu_read_lock();
+
+	for_each_set_bit(link_id, &usable_links, IEEE80211_MLD_MAX_NUM_LINKS) {
+		struct ieee80211_bss_conf *link_conf =
+			rcu_dereference(vif->link_conf[link_id]);
+
+		if (WARN_ON_ONCE(!link_conf))
+			continue;
+
+		data[n_data].link_id = link_id;
+		data[n_data].band = link_conf->chanreq.oper.chan->band;
+		data[n_data].width = link_conf->chanreq.oper.width;
+		data[n_data].active = vif->active_links & BIT(link_id);
+		n_data++;
+	}
+
+	rcu_read_unlock();
+
+	return n_data;
+}
+
+bool iwl_mvm_mld_valid_link_pair(struct ieee80211_vif *vif,
+				 struct iwl_mvm_link_sel_data *a,
+				 struct iwl_mvm_link_sel_data *b)
+{
+	struct iwl_mvm_vif *mvmvif = iwl_mvm_vif_from_mac80211(vif);
+
+	if (a->band == b->band)
+		return false;
+
+	/* BT Coex effects eSR mode only if one of the link is on LB */
+	if (a->band == NL80211_BAND_2GHZ || b->band == NL80211_BAND_2GHZ)
+		return !(mvmvif->esr_disable_reason & IWL_MVM_ESR_DISABLE_COEX);
+
+	return true;
+}
+
+void iwl_mvm_mld_select_links(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
+			      bool valid_links_changed)
+{
+	struct iwl_mvm_link_sel_data data[IEEE80211_MLD_MAX_NUM_LINKS];
+	unsigned long usable_links = ieee80211_vif_usable_links(vif);
+	u32 max_active_links = iwl_mvm_max_active_links(mvm, vif);
+	u16 new_active_links;
+	u8 n_data, i, j;
+
+	if (!IWL_MVM_AUTO_EML_ENABLE)
+		return;
+
+	/* The logic below is a simple version that doesn't suit more than 2
+	 * links
+	 */
+	WARN_ON_ONCE(max_active_links > 2);
+
+	/* if only a single active link is supported, assume that the one
+	 * selected by higher layer for connection establishment is the best.
+	 */
+	if (max_active_links == 1 && !valid_links_changed)
+		return;
+
+	/* If we are already using the maximal number of active links, don't do
+	 * any change. This can later be optimized to pick a 'better' link pair.
+	 */
+	if (hweight16(vif->active_links) == max_active_links)
+		return;
+
+	if (!iwl_mvm_esr_allowed_on_vif(mvm, vif))
+		return;
+
+	n_data = iwl_mvm_set_link_selection_data(vif, data, usable_links);
+
+	/* this is expected to be the current active link */
+	if (n_data == 1)
+		return;
+
+	new_active_links = 0;
+
+	/* Assume that after association only a single link is active, thus,
+	 * select only the 2nd link
+	 */
+	if (!valid_links_changed) {
+		for (i = 0; i < n_data; i++) {
+			if (data[i].active)
+				break;
+		}
+
+		if (WARN_ON_ONCE(i == n_data))
+			return;
+
+		for (j = 0; j < n_data; j++) {
+			if (i == j)
+				continue;
+
+			if (iwl_mvm_mld_valid_link_pair(vif, &data[i],
+							&data[j]))
+				break;
+		}
+
+		if (j != n_data)
+			new_active_links = BIT(data[i].link_id) |
+				BIT(data[j].link_id);
+	} else {
+		/* Try to find a valid link pair for EMLSR operation. If a pair
+		 * is not found continue using the current active link.
+		 */
+		for (i = 0; i < n_data; i++) {
+			for (j = 0; j < n_data; j++) {
+				if (i == j)
+					continue;
+
+				if (iwl_mvm_mld_valid_link_pair(vif, &data[i],
+								&data[j]))
+					break;
+			}
+
+			/* found a valid pair for EMLSR, use it */
+			if (j != n_data) {
+				new_active_links = BIT(data[i].link_id) |
+					BIT(data[j].link_id);
+				break;
+			}
+		}
+	}
+
+	if (!new_active_links)
+		return;
+
+	if (vif->active_links != new_active_links)
+		ieee80211_set_active_links_async(vif, new_active_links);
+}
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c
index 33440fff762c..095c00711b44 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c
@@ -645,176 +645,6 @@ static int iwl_mvm_mld_mac_sta_state(struct ieee80211_hw *hw,
 					    &callbacks);
 }
 
-struct iwl_mvm_link_sel_data {
-	u8 link_id;
-	enum nl80211_band band;
-	enum nl80211_chan_width width;
-	bool active;
-};
-
-static bool iwl_mvm_mld_valid_link_pair(struct ieee80211_vif *vif,
-					struct iwl_mvm_link_sel_data *a,
-					struct iwl_mvm_link_sel_data *b)
-{
-	struct iwl_mvm_vif *mvmvif = iwl_mvm_vif_from_mac80211(vif);
-
-	if (a->band == b->band)
-		return false;
-
-	/* BT Coex effects eSR mode only if one of the link is on LB */
-	if (a->band == NL80211_BAND_2GHZ || b->band == NL80211_BAND_2GHZ)
-		return !(mvmvif->esr_disable_reason & IWL_MVM_ESR_DISABLE_COEX);
-
-	return true;
-}
-
-static u8
-iwl_mvm_set_link_selection_data(struct ieee80211_vif *vif,
-				struct iwl_mvm_link_sel_data *data,
-				unsigned long usable_links)
-{
-	u8 n_data = 0;
-	unsigned long link_id;
-
-	rcu_read_lock();
-
-	for_each_set_bit(link_id, &usable_links, IEEE80211_MLD_MAX_NUM_LINKS) {
-		struct ieee80211_bss_conf *link_conf =
-			rcu_dereference(vif->link_conf[link_id]);
-
-		if (WARN_ON_ONCE(!link_conf))
-			continue;
-
-		data[n_data].link_id = link_id;
-		data[n_data].band = link_conf->chanreq.oper.chan->band;
-		data[n_data].width = link_conf->chanreq.oper.width;
-		data[n_data].active = vif->active_links & BIT(link_id);
-		n_data++;
-	}
-
-	rcu_read_unlock();
-
-	return n_data;
-}
-
-static bool iwl_mvm_esr_allowed_on_vif(struct iwl_mvm *mvm,
-				       struct ieee80211_vif *vif)
-{
-	struct iwl_mvm_vif *mvmvif = iwl_mvm_vif_from_mac80211(vif);
-	const struct wiphy_iftype_ext_capab *ext_capa;
-
-	lockdep_assert_held(&mvm->mutex);
-
-	if (!ieee80211_vif_is_mld(vif) || !vif->cfg.assoc ||
-	    hweight16(ieee80211_vif_usable_links(vif)) == 1)
-		return false;
-
-	if (!(vif->cfg.eml_cap & IEEE80211_EML_CAP_EMLSR_SUPP))
-		return false;
-
-	ext_capa = cfg80211_get_iftype_ext_capa(mvm->hw->wiphy,
-						ieee80211_vif_type_p2p(vif));
-	if (!ext_capa ||
-	    !(ext_capa->eml_capabilities & IEEE80211_EML_CAP_EMLSR_SUPP))
-		return false;
-
-	return !(mvmvif->esr_disable_reason & ~IWL_MVM_ESR_DISABLE_COEX);
-}
-
-void iwl_mvm_mld_select_links(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
-			      bool valid_links_changed)
-{
-	struct iwl_mvm_link_sel_data data[IEEE80211_MLD_MAX_NUM_LINKS];
-	unsigned long usable_links = ieee80211_vif_usable_links(vif);
-	u32 max_active_links = iwl_mvm_max_active_links(mvm, vif);
-	u16 new_active_links;
-	u8 n_data, i, j;
-
-	if (!IWL_MVM_AUTO_EML_ENABLE)
-		return;
-
-	/* The logic below is a simple version that doesn't suit more than 2
-	 * links
-	 */
-	WARN_ON_ONCE(max_active_links > 2);
-
-	/* if only a single active link is supported, assume that the one
-	 * selected by higher layer for connection establishment is the best.
-	 */
-	if (max_active_links == 1 && !valid_links_changed)
-		return;
-
-	/* If we are already using the maximal number of active links, don't do
-	 * any change. This can later be optimized to pick a 'better' link pair.
-	 */
-	if (hweight16(vif->active_links) == max_active_links)
-		return;
-
-	if (!iwl_mvm_esr_allowed_on_vif(mvm, vif))
-		return;
-
-	n_data = iwl_mvm_set_link_selection_data(vif, data, usable_links);
-
-	/* this is expected to be the current active link */
-	if (n_data == 1)
-		return;
-
-	new_active_links = 0;
-
-	/* Assume that after association only a single link is active, thus,
-	 * select only the 2nd link
-	 */
-	if (!valid_links_changed) {
-		for (i = 0; i < n_data; i++) {
-			if (data[i].active)
-				break;
-		}
-
-		if (WARN_ON_ONCE(i == n_data))
-			return;
-
-		for (j = 0; j < n_data; j++) {
-			if (i == j)
-				continue;
-
-			if (iwl_mvm_mld_valid_link_pair(vif, &data[i],
-							&data[j]))
-				break;
-		}
-
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
-
-	if (!new_active_links)
-		return;
-
-	if (vif->active_links != new_active_links)
-		ieee80211_set_active_links_async(vif, new_active_links);
-}
-
 static void
 iwl_mvm_mld_link_info_changed_station(struct iwl_mvm *mvm,
 				      struct ieee80211_vif *vif,
@@ -1310,52 +1140,6 @@ iwl_mvm_mld_change_sta_links(struct ieee80211_hw *hw,
 	return ret;
 }
 
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
 void iwl_mvm_recalc_esr(struct iwl_mvm *mvm, struct ieee80211_vif *vif)
 {
 	struct iwl_mvm_vif *mvmvif = iwl_mvm_vif_from_mac80211(vif);
@@ -1383,6 +1167,30 @@ void iwl_mvm_recalc_esr(struct iwl_mvm *mvm, struct ieee80211_vif *vif)
 					 vif->active_links & BIT(link_id));
 }
 
+bool iwl_mvm_esr_allowed_on_vif(struct iwl_mvm *mvm,
+				struct ieee80211_vif *vif)
+{
+	struct iwl_mvm_vif *mvmvif = iwl_mvm_vif_from_mac80211(vif);
+	const struct wiphy_iftype_ext_capab *ext_capa;
+
+	lockdep_assert_held(&mvm->mutex);
+
+	if (!ieee80211_vif_is_mld(vif) || !vif->cfg.assoc ||
+	    hweight16(ieee80211_vif_usable_links(vif)) == 1)
+		return false;
+
+	if (!(vif->cfg.eml_cap & IEEE80211_EML_CAP_EMLSR_SUPP))
+		return false;
+
+	ext_capa = cfg80211_get_iftype_ext_capa(mvm->hw->wiphy,
+						ieee80211_vif_type_p2p(vif));
+	if (!ext_capa ||
+	    !(ext_capa->eml_capabilities & IEEE80211_EML_CAP_EMLSR_SUPP))
+		return false;
+
+	return !(mvmvif->esr_disable_reason & ~IWL_MVM_ESR_DISABLE_COEX);
+}
+
 /*
  * This function receives a bitmap of usable links and check if we can enter
  * eSR on those links.
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
index c887263a2159..dd9bead2d7fc 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
@@ -1944,6 +1944,24 @@ int iwl_mvm_remove_link(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
 int iwl_mvm_disable_link(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
 			 struct ieee80211_bss_conf *link_conf);
 
+void iwl_mvm_mld_select_links(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
+			      bool valid_links_changed);
+int iwl_mvm_mld_get_primary_link(struct iwl_mvm *mvm,
+				 struct ieee80211_vif *vif,
+				 unsigned long usable_links);
+struct iwl_mvm_link_sel_data {
+	u8 link_id;
+	enum nl80211_band band;
+	enum nl80211_chan_width width;
+	bool active;
+};
+
+u8 iwl_mvm_set_link_selection_data(struct ieee80211_vif *vif,
+				   struct iwl_mvm_link_sel_data *data,
+				   unsigned long usable_links);
+bool iwl_mvm_mld_valid_link_pair(struct ieee80211_vif *vif,
+				 struct iwl_mvm_link_sel_data *a,
+				 struct iwl_mvm_link_sel_data *b);
 /* AP and IBSS */
 bool iwl_mvm_start_ap_ibss_common(struct ieee80211_hw *hw,
 				  struct ieee80211_vif *vif, int *ret);
@@ -2785,12 +2803,6 @@ int iwl_mvm_set_hw_timestamp(struct ieee80211_hw *hw,
 int iwl_mvm_update_mu_groups(struct iwl_mvm *mvm, struct ieee80211_vif *vif);
 bool iwl_mvm_enable_fils(struct iwl_mvm *mvm,
 			 struct ieee80211_chanctx_conf *ctx);
-void iwl_mvm_mld_select_links(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
-			      bool valid_links_changed);
-int iwl_mvm_mld_get_primary_link(struct iwl_mvm *mvm,
-				 struct ieee80211_vif *vif,
-				 unsigned long usable_links);
-
 bool iwl_mvm_is_ftm_responder_chanctx(struct iwl_mvm *mvm,
 				      struct ieee80211_chanctx_conf *ctx);
 
@@ -2814,5 +2826,7 @@ int iwl_mvm_roc_add_cmd(struct iwl_mvm *mvm,
 
 /* EMLSR */
 void iwl_mvm_recalc_esr(struct iwl_mvm *mvm, struct ieee80211_vif *vif);
+bool iwl_mvm_esr_allowed_on_vif(struct iwl_mvm *mvm,
+				struct ieee80211_vif *vif);
 
 #endif /* __IWL_MVM_H__ */
-- 
2.34.1


