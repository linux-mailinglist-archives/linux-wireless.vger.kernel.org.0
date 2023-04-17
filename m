Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 772996E42CC
	for <lists+linux-wireless@lfdr.de>; Mon, 17 Apr 2023 10:42:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230464AbjDQImR (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 17 Apr 2023 04:42:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230203AbjDQImM (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 17 Apr 2023 04:42:12 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A79544B2
        for <linux-wireless@vger.kernel.org>; Mon, 17 Apr 2023 01:42:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681720931; x=1713256931;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=wAtCbwu9rYjvn9dNxK8VqCUmOzbqPh8ilOl5fVWohIo=;
  b=YYicXuc4tX1egIvjlM+2x4RwXyqY2g8ER3l3OijbCxl/yWRzQTCv2fxz
   PEx5z23DJ/NpdLS9Mm2dzVRu6LgG24dbMBkAO8az8htTa4djPBQGSsCRa
   edQHrrMTo3N3UtwET7wzJkYR15JnIOdCSoNsT7Qec/erkqubftIzc1Bgf
   jRk5o8/Suo71GQwUV4kNrO11FP2WfsW76tv1a3eIKzPXODvYBkaR+pq9h
   yGsT9bbrIpiIrwhu2tryOMIDNCji3NnxRShGGTUbSprBd3holWfgfP+Di
   dOF93LTz7iSKwBBhveSWsGQC7n0eB1swSagknue8FhVv9QgJvMrUYq4j5
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10682"; a="333634398"
X-IronPort-AV: E=Sophos;i="5.99,203,1677571200"; 
   d="scan'208";a="333634398"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2023 01:42:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10682"; a="693173865"
X-IronPort-AV: E=Sophos;i="5.99,203,1677571200"; 
   d="scan'208";a="693173865"
Received: from odotan1x-mobl.ger.corp.intel.com (HELO ggreenma-mobl2.lan) ([10.214.202.32])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2023 01:42:09 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Johannes Berg <johannes.berg@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 09/15] wifi: iwlwifi: mvm: initialize per-link STA ratescale data
Date:   Mon, 17 Apr 2023 11:41:28 +0300
Message-Id: <20230417113648.441b6a8c60fd.I34f1b3555c25aaa22cc34d1112fc3b6393a20b7c@changeid>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230417084134.1338976-1-gregory.greenman@intel.com>
References: <20230417084134.1338976-1-gregory.greenman@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

When allocating a new link station, initialize the ratescaling
data for it. To do that, refactor the initialization code out
into a new iwl_mvm_rs_add_sta_link() function.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 .../net/wireless/intel/iwlwifi/mvm/mld-sta.c  |  2 ++
 .../net/wireless/intel/iwlwifi/mvm/rs-fw.c    | 35 +++++++++++--------
 drivers/net/wireless/intel/iwlwifi/mvm/rs.h   |  5 +++
 3 files changed, 28 insertions(+), 14 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mld-sta.c b/drivers/net/wireless/intel/iwlwifi/mvm/mld-sta.c
index fe362f621777..0bfdf4462755 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mld-sta.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mld-sta.c
@@ -1126,6 +1126,8 @@ int iwl_mvm_mld_update_sta_links(struct iwl_mvm *mvm,
 			goto err;
 
 		link_sta_added_to_fw |= BIT(link_id);
+
+		iwl_mvm_rs_add_sta_link(mvm, mvm_sta_link);
 	}
 
 	if (sta_mask_added) {
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/rs-fw.c b/drivers/net/wireless/intel/iwlwifi/mvm/rs-fw.c
index 2b52d3aa82ed..9a6e5684b10c 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/rs-fw.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/rs-fw.c
@@ -679,6 +679,26 @@ int rs_fw_tx_protection(struct iwl_mvm *mvm, struct iwl_mvm_sta *mvmsta,
 	return 0;
 }
 
+void iwl_mvm_rs_add_sta_link(struct iwl_mvm *mvm,
+			     struct iwl_mvm_link_sta *link_sta)
+{
+	struct iwl_lq_sta_rs_fw *lq_sta;
+
+	lq_sta = &link_sta->lq_sta.rs_fw;
+
+	lq_sta->pers.drv = mvm;
+	lq_sta->pers.sta_id = link_sta->sta_id;
+	lq_sta->pers.chains = 0;
+	memset(lq_sta->pers.chain_signal, 0,
+	       sizeof(lq_sta->pers.chain_signal));
+	lq_sta->pers.last_rssi = S8_MIN;
+	lq_sta->last_rate_n_flags = 0;
+
+#ifdef CONFIG_MAC80211_DEBUGFS
+	lq_sta->pers.dbg_fixed_rate = 0;
+#endif
+}
+
 void iwl_mvm_rs_add_sta(struct iwl_mvm *mvm, struct iwl_mvm_sta *mvmsta)
 {
 	unsigned int link_id;
@@ -686,25 +706,12 @@ void iwl_mvm_rs_add_sta(struct iwl_mvm *mvm, struct iwl_mvm_sta *mvmsta)
 	IWL_DEBUG_RATE(mvm, "create station rate scale window\n");
 
 	for (link_id = 0; link_id < ARRAY_SIZE(mvmsta->link); link_id++) {
-		struct iwl_lq_sta_rs_fw *lq_sta;
 		struct iwl_mvm_link_sta *link =
 			rcu_dereference_protected(mvmsta->link[link_id],
 						  lockdep_is_held(&mvm->mutex));
 		if (!link)
 			continue;
 
-		lq_sta = &link->lq_sta.rs_fw;
-
-		lq_sta->pers.drv = mvm;
-		lq_sta->pers.sta_id = link->sta_id;
-		lq_sta->pers.chains = 0;
-		memset(lq_sta->pers.chain_signal, 0,
-		       sizeof(lq_sta->pers.chain_signal));
-		lq_sta->pers.last_rssi = S8_MIN;
-		lq_sta->last_rate_n_flags = 0;
-
-#ifdef CONFIG_MAC80211_DEBUGFS
-		lq_sta->pers.dbg_fixed_rate = 0;
-#endif
+		iwl_mvm_rs_add_sta_link(mvm, link);
 	}
 }
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/rs.h b/drivers/net/wireless/intel/iwlwifi/mvm/rs.h
index bbc05c3f13bf..c08271a5e3a9 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/rs.h
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/rs.h
@@ -434,7 +434,12 @@ int iwl_mvm_tx_protection(struct iwl_mvm *mvm, struct iwl_mvm_sta *mvmsta,
 void iwl_mvm_reset_frame_stats(struct iwl_mvm *mvm);
 #endif
 
+struct iwl_mvm_link_sta;
+
 void iwl_mvm_rs_add_sta(struct iwl_mvm *mvm, struct iwl_mvm_sta *mvmsta);
+void iwl_mvm_rs_add_sta_link(struct iwl_mvm *mvm,
+			     struct iwl_mvm_link_sta *link_sta);
+
 void rs_fw_rate_init(struct iwl_mvm *mvm,
 		     struct ieee80211_vif *vif,
 		     struct ieee80211_sta *sta,
-- 
2.38.1

