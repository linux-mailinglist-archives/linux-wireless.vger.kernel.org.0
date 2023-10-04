Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF7667B7C4C
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Oct 2023 11:37:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242031AbjJDJhO (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 4 Oct 2023 05:37:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242032AbjJDJhJ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 4 Oct 2023 05:37:09 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0BDBBF
        for <linux-wireless@vger.kernel.org>; Wed,  4 Oct 2023 02:37:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696412225; x=1727948225;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=+Z3TAHE7nrAyTBwRJb09FWXq8eP2JOqPGEx52J2If3g=;
  b=IhgaLWzeNrvsxZbq/8p1bemgmybYyJk8DL3mOAKRXZOEznBhk9hHKRnS
   DKRXVWuPlyeCcldwd+XdaD7p30rEseZMZ0N34lrvt8KYMRui+Xsv7tW8Z
   145U1gPuLkMH21NP+KvKhXc1p9ze6A1kFydLUXRAf8AC7MkqW2nXw0Gl7
   eCPPwdTOSTX9dC6jwtvYGLlQj8Csv/55bzaqN+tW0mHiey+cxK9gCS3ho
   U0dMiVfNyJ0pXn4Hf3yp1skZOSV4bNvUOMipoorGnFMeRliYxSXNOo65M
   L/YSuoHj6A4Fe9dr9QJZ9tp2Qj4OGTWt7FEcJYcRWAIV74n4+4BmGXi3j
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10852"; a="449611787"
X-IronPort-AV: E=Sophos;i="6.03,199,1694761200"; 
   d="scan'208";a="449611787"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Oct 2023 02:37:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10852"; a="1082415172"
X-IronPort-AV: E=Sophos;i="6.03,199,1694761200"; 
   d="scan'208";a="1082415172"
Received: from oferweis-mobl.ger.corp.intel.com (HELO ggreenma-mobl2.intel.com) ([10.214.222.21])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Oct 2023 02:37:01 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org, Ilan Peer <ilan.peer@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 08/15] wifi: iwlwifi: mvm: Add basic link selection logic
Date:   Wed,  4 Oct 2023 12:36:27 +0300
Message-Id: <20231004123422.0c7b89ab29c2.I6600bd16551d75e2bf520d8d0add525568a9f85f@changeid>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20231004093634.131303-1-gregory.greenman@intel.com>
References: <20231004093634.131303-1-gregory.greenman@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Ilan Peer <ilan.peer@intel.com>

Add simple logic that would allow using EMLSR in case
there are multiple valid links:

- In case the connection establishment has just been
  completed try to find a valid link pair for EMLSR
  functionality where one of the links in the pair is
  the current active link.
- In case the valid links changed after connection
  was already established, try to find a valid link pair
  for EMLSR functionality, in case the EMSLR is not active
  yet.

If a valid link pair is found call mac80211 to asynchronously
set the new link pair, otherwise continue using the current active
links.

Signed-off-by: Ilan Peer <ilan.peer@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 .../wireless/intel/iwlwifi/mvm/constants.h    |   1 +
 .../net/wireless/intel/iwlwifi/mvm/mac80211.c |   7 +
 .../wireless/intel/iwlwifi/mvm/mld-mac80211.c | 123 ++++++++++++++++++
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h  |   2 +
 4 files changed, 133 insertions(+)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/constants.h b/drivers/net/wireless/intel/iwlwifi/mvm/constants.h
index 59df2bf6327c..c832068b5718 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/constants.h
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/constants.h
@@ -119,5 +119,6 @@
 #define IWL_MVM_DISABLE_AP_FILS			false
 #define IWL_MVM_6GHZ_PASSIVE_SCAN_TIMEOUT       3000 /* in seconds */
 #define IWL_MVM_6GHZ_PASSIVE_SCAN_ASSOC_TIMEOUT 60   /* in seconds */
+#define IWL_MVM_AUTO_EML_ENABLE                 true
 
 #endif /* __MVM_CONSTANTS_H */
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
index 56965d6e6499..79ecfbb89c45 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
@@ -3803,6 +3803,13 @@ iwl_mvm_sta_state_assoc_to_authorized(struct iwl_mvm *mvm,
 
 		callbacks->mac_ctxt_changed(mvm, vif, false);
 		iwl_mvm_mei_host_associated(mvm, vif, mvm_sta);
+
+		/* when client is authorized (AP station marked as such),
+		 * try to enable more links
+		 */
+		if (vif->type == NL80211_IFTYPE_STATION &&
+		    !test_bit(IWL_MVM_STATUS_IN_HW_RESTART, &mvm->status))
+			iwl_mvm_mld_select_links(mvm, vif, false);
 	}
 
 	mvm_sta->authorized = true;
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c
index faec7ee17d9a..4d1b6abfeb67 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c
@@ -623,6 +623,126 @@ static int iwl_mvm_mld_mac_sta_state(struct ieee80211_hw *hw,
 					    &callbacks);
 }
 
+struct iwl_mvm_link_sel_data {
+	u8 link_id;
+	enum nl80211_band band;
+	bool active;
+};
+
+static bool iwl_mvm_mld_valid_link_pair(struct iwl_mvm_link_sel_data *a,
+					struct iwl_mvm_link_sel_data *b)
+{
+	return a->band != b->band;
+}
+
+void iwl_mvm_mld_select_links(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
+			      bool valid_links_changed)
+{
+	struct iwl_mvm_link_sel_data data[IEEE80211_MLD_MAX_NUM_LINKS];
+	unsigned long usable_links = ieee80211_vif_usable_links(vif);
+	u32 max_active_links = iwl_mvm_max_active_links(mvm, vif);
+	u16 new_active_links;
+	u8 link_id, n_data = 0, i, j;
+
+	if (!IWL_MVM_AUTO_EML_ENABLE)
+		return;
+
+	if (!ieee80211_vif_is_mld(vif) || usable_links == 1)
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
+		data[n_data].band = link_conf->chandef.chan->band;
+		data[n_data].active = vif->active_links & BIT(link_id);
+		n_data++;
+	}
+
+	rcu_read_unlock();
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
+			if (iwl_mvm_mld_valid_link_pair(&data[i], &data[j]))
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
+				if (iwl_mvm_mld_valid_link_pair(&data[i],
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
+	if (WARN_ON(!new_active_links))
+		return;
+
+	if (vif->active_links != new_active_links)
+		ieee80211_set_active_links_async(vif, new_active_links);
+}
+
 static void
 iwl_mvm_mld_link_info_changed_station(struct iwl_mvm *mvm,
 				      struct ieee80211_vif *vif,
@@ -667,6 +787,9 @@ iwl_mvm_mld_link_info_changed_station(struct iwl_mvm *mvm,
 	if (ret)
 		IWL_ERR(mvm, "failed to update MAC %pM\n", vif->addr);
 
+	if (changes & BSS_CHANGED_MLD_VALID_LINKS)
+		iwl_mvm_mld_select_links(mvm, vif, true);
+
 	memcpy(mvmvif->link[link_conf->link_id]->bssid, link_conf->bssid,
 	       ETH_ALEN);
 
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
index f8b95693bd98..df88c027475c 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
@@ -2764,4 +2764,6 @@ int iwl_mvm_set_hw_timestamp(struct ieee80211_hw *hw,
 int iwl_mvm_update_mu_groups(struct iwl_mvm *mvm, struct ieee80211_vif *vif);
 bool iwl_mvm_enable_fils(struct iwl_mvm *mvm,
 			 struct ieee80211_chanctx_conf *ctx);
+void iwl_mvm_mld_select_links(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
+			      bool valid_links_changed);
 #endif /* __IWL_MVM_H__ */
-- 
2.38.1

