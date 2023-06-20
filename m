Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74B247368C5
	for <lists+linux-wireless@lfdr.de>; Tue, 20 Jun 2023 12:05:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231912AbjFTKFO (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 20 Jun 2023 06:05:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232116AbjFTKEx (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 20 Jun 2023 06:04:53 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70CD81A1
        for <linux-wireless@vger.kernel.org>; Tue, 20 Jun 2023 03:04:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687255492; x=1718791492;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=rwPVNIzkNbPx8ywXi448Z1QQq1iQKysFEHgfZgS1zJQ=;
  b=ApTxI5OgCRRlta/NHvhWsib8AQdOjilP0CGfMw9YtRhFWk1EYQ1CeGfI
   slKxFQMp4E5bcYvDS18GblQ5T2wxZzQ4Me9fALhYPugIfvpB26FYEwkLd
   M9fCnUL7O9XFlf6qUG6d2X7NAjR8pE93ehM3WGWfSnr4rHn1v1OSGrBiw
   TCnYqhU9jX1DRyktLvS47lN1HthwKtVqLYR6hqraZCi0FSyyNnZkCME8z
   +9kOFIDZ2T3juBJc2gRLdMawetOHYw6WIuuCpTiyM6kagx0M+EwRhUbuT
   UvRbXvYJfjXzSmI9AV2D7xg07XeEqQa8NkQywx1MyHRceTrJnb39TMRly
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10746"; a="359819644"
X-IronPort-AV: E=Sophos;i="6.00,256,1681196400"; 
   d="scan'208";a="359819644"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2023 03:04:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10746"; a="838143560"
X-IronPort-AV: E=Sophos;i="6.00,256,1681196400"; 
   d="scan'208";a="838143560"
Received: from rafist-mobl.ger.corp.intel.com (HELO ggreenma-mobl2.intel.com) ([10.214.208.68])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2023 03:04:50 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Johannes Berg <johannes.berg@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 14/19] wifi: iwlwifi: mvm: support new flush_sta method
Date:   Tue, 20 Jun 2023 13:04:00 +0300
Message-Id: <20230620125813.a1f8ec20b727.I48594b708b41aa55dc2b8c3d346b4412ad3a5ba3@changeid>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230620100405.45117-1-gregory.greenman@intel.com>
References: <20230620100405.45117-1-gregory.greenman@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

For iwlwifi this is simple to implement, and on newer hardware
it's an improvement since we have per-station queues.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 .../net/wireless/intel/iwlwifi/mvm/mac80211.c | 25 +++++++++++++++++++
 .../wireless/intel/iwlwifi/mvm/mld-mac80211.c |  1 +
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h  |  2 ++
 3 files changed, 28 insertions(+)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
index ebe4163837a0..f083ebda1e83 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
@@ -5652,6 +5652,30 @@ void iwl_mvm_mac_flush(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 		iwl_trans_wait_tx_queues_empty(mvm->trans, msk);
 }
 
+void iwl_mvm_mac_flush_sta(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
+			   struct ieee80211_sta *sta)
+{
+	struct iwl_mvm *mvm = IWL_MAC80211_GET_MVM(hw);
+	int i;
+
+	mutex_lock(&mvm->mutex);
+	for (i = 0; i < mvm->fw->ucode_capa.num_stations; i++) {
+		struct iwl_mvm_sta *mvmsta;
+		struct ieee80211_sta *tmp;
+
+		tmp = rcu_dereference_protected(mvm->fw_id_to_mac_id[i],
+						lockdep_is_held(&mvm->mutex));
+		if (tmp != sta)
+			continue;
+
+		mvmsta = iwl_mvm_sta_from_mac80211(sta);
+
+		if (iwl_mvm_flush_sta(mvm, mvmsta, false))
+			IWL_ERR(mvm, "flush request fail\n");
+	}
+	mutex_unlock(&mvm->mutex);
+}
+
 int iwl_mvm_mac_get_survey(struct ieee80211_hw *hw, int idx,
 			   struct survey_info *survey)
 {
@@ -6204,6 +6228,7 @@ const struct ieee80211_ops iwl_mvm_hw_ops = {
 	.mgd_complete_tx = iwl_mvm_mac_mgd_complete_tx,
 	.mgd_protect_tdls_discover = iwl_mvm_mac_mgd_protect_tdls_discover,
 	.flush = iwl_mvm_mac_flush,
+	.flush_sta = iwl_mvm_mac_flush_sta,
 	.sched_scan_start = iwl_mvm_mac_sched_scan_start,
 	.sched_scan_stop = iwl_mvm_mac_sched_scan_stop,
 	.set_key = iwl_mvm_mac_set_key,
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c
index 636ad2b76428..8b6c641772ee 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c
@@ -1149,6 +1149,7 @@ const struct ieee80211_ops iwl_mvm_mld_hw_ops = {
 	.mgd_complete_tx = iwl_mvm_mac_mgd_complete_tx,
 	.mgd_protect_tdls_discover = iwl_mvm_mac_mgd_protect_tdls_discover,
 	.flush = iwl_mvm_mac_flush,
+	.flush_sta = iwl_mvm_mac_flush_sta,
 	.sched_scan_start = iwl_mvm_mac_sched_scan_start,
 	.sched_scan_stop = iwl_mvm_mac_sched_scan_stop,
 	.set_key = iwl_mvm_mac_set_key,
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
index b575ce2f7146..b83df0631279 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
@@ -2659,6 +2659,8 @@ void iwl_mvm_mac_mgd_complete_tx(struct ieee80211_hw *hw,
 				 struct ieee80211_prep_tx_info *info);
 void iwl_mvm_mac_flush(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 		       u32 queues, bool drop);
+void iwl_mvm_mac_flush_sta(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
+			   struct ieee80211_sta *sta);
 int iwl_mvm_mac_sched_scan_start(struct ieee80211_hw *hw,
 				 struct ieee80211_vif *vif,
 				 struct cfg80211_sched_scan_request *req,
-- 
2.38.1

