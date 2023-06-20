Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AC247368B8
	for <lists+linux-wireless@lfdr.de>; Tue, 20 Jun 2023 12:04:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231186AbjFTKE4 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 20 Jun 2023 06:04:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231953AbjFTKEf (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 20 Jun 2023 06:04:35 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2296610FF
        for <linux-wireless@vger.kernel.org>; Tue, 20 Jun 2023 03:04:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687255474; x=1718791474;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=DL+8CEgKcvxbC1PTD4QdZy2kHB3WVzTy4MOt3AAfNHY=;
  b=BhQz7JrK2D0gfuFJ1nShhJR2oJNkDx0KVQfA/C8j44lwypEhksjzkXAH
   jxBQ/8qlXc37wb4iLqfekZTnRv6M0IA+AMfGLJe9I0efnnfnkSwZWPGNy
   eD4s1JVkEZqaTBSKdzvzFpySO+vy8v1JUletsIYMhgLAMDs+OiHfZ+k7L
   sMxuVwrcMQrsCGcC8aJhPtkHU5jgvccsO8EaSkSzSBuwn8s+OI4VTLcrk
   7VJSwwJNbSpM3zeeBFqXEepdnGO7SkxDcvnNNTLeWzpYv9lOE+YjL4iD7
   /MGXTQeUKrydVbnt08F8pdd/K/pMWL8tqYzdKYVzGHZDRan9t96A8Blbw
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10746"; a="359819553"
X-IronPort-AV: E=Sophos;i="6.00,256,1681196400"; 
   d="scan'208";a="359819553"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2023 03:04:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10746"; a="838143089"
X-IronPort-AV: E=Sophos;i="6.00,256,1681196400"; 
   d="scan'208";a="838143089"
Received: from rafist-mobl.ger.corp.intel.com (HELO ggreenma-mobl2.intel.com) ([10.214.208.68])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2023 03:04:28 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 05/19] wifi: iwlwifi: mvm: make iwl_mvm_set_fw_mu_edca_params mld aware
Date:   Tue, 20 Jun 2023 13:03:51 +0300
Message-Id: <20230620125813.8762a90e8857.Ic5b8e96140a449fd1ed7008907d67fc36fe98506@changeid>
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

From: Emmanuel Grumbach <emmanuel.grumbach@intel.com>

We need to work on the right link there.

Signed-off-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/link.c     |  2 +-
 drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c | 10 +++++-----
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h      |  2 +-
 3 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/link.c b/drivers/net/wireless/intel/iwlwifi/mvm/link.c
index 5fdebb911f7b..ace82e2c5bd9 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/link.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/link.c
@@ -188,7 +188,7 @@ int iwl_mvm_link_changed(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
 
 	/* TODO  how to set ndp_fdbk_buff_th_exp? */
 
-	if (iwl_mvm_set_fw_mu_edca_params(mvm, mvmvif,
+	if (iwl_mvm_set_fw_mu_edca_params(mvm, mvmvif->link[link_id],
 					  &cmd.trig_based_txf[0])) {
 		flags |= LINK_FLG_MU_EDCA_CW;
 		flags_mask |= LINK_FLG_MU_EDCA_CW;
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
index 4c0a9cc9ff7c..ebe4163837a0 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
@@ -2240,7 +2240,7 @@ int iwl_mvm_set_sta_pkt_ext(struct iwl_mvm *mvm,
  * is enabled or not
  */
 bool iwl_mvm_set_fw_mu_edca_params(struct iwl_mvm *mvm,
-				   struct iwl_mvm_vif *mvmvif,
+				   const struct iwl_mvm_vif_link_info *link_info,
 				   struct iwl_he_backoff_conf *trig_based_txf)
 {
 	int i;
@@ -2248,11 +2248,11 @@ bool iwl_mvm_set_fw_mu_edca_params(struct iwl_mvm *mvm,
 	bool mu_edca_enabled = true;
 
 	for (i = 0; i < IEEE80211_NUM_ACS; i++) {
-		struct ieee80211_he_mu_edca_param_ac_rec *mu_edca =
-			&mvmvif->deflink.queue_params[i].mu_edca_param_rec;
+		const struct ieee80211_he_mu_edca_param_ac_rec *mu_edca =
+			&link_info->queue_params[i].mu_edca_param_rec;
 		u8 ac = iwl_mvm_mac80211_ac_to_ucode_ac(i);
 
-		if (!mvmvif->deflink.queue_params[i].mu_edca) {
+		if (!link_info->queue_params[i].mu_edca) {
 			mu_edca_enabled = false;
 			break;
 		}
@@ -2398,7 +2398,7 @@ static void iwl_mvm_cfg_he_sta(struct iwl_mvm *mvm,
 
 	rcu_read_unlock();
 
-	if (iwl_mvm_set_fw_mu_edca_params(mvm, mvmvif,
+	if (iwl_mvm_set_fw_mu_edca_params(mvm, &mvmvif->deflink,
 					  &sta_ctxt_cmd.trig_based_txf[0]))
 		flags |= STA_CTXT_HE_MU_EDCA_CW;
 
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
index 11de81b58515..b575ce2f7146 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
@@ -1804,7 +1804,7 @@ void iwl_mvm_set_fw_qos_params(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
 			       struct ieee80211_bss_conf *link_conf,
 			       struct iwl_ac_qos *ac, __le32 *qos_flags);
 bool iwl_mvm_set_fw_mu_edca_params(struct iwl_mvm *mvm,
-				   struct iwl_mvm_vif *mvmvif,
+				   const struct iwl_mvm_vif_link_info *link_info,
 				   struct iwl_he_backoff_conf *trig_based_txf);
 void iwl_mvm_set_fw_dtim_tbtt(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
 			      struct ieee80211_bss_conf *link_conf,
-- 
2.38.1

