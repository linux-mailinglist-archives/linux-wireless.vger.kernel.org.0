Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED2596E1448
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Apr 2023 20:41:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229835AbjDMSll (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 13 Apr 2023 14:41:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229791AbjDMSlk (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 13 Apr 2023 14:41:40 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EAD56199
        for <linux-wireless@vger.kernel.org>; Thu, 13 Apr 2023 11:41:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681411299; x=1712947299;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=HdYWPxgHKd9L8HjnUEj3mbU80YzILmeCO99FEfVQ1ps=;
  b=Zv1RJSPBoOjig8bKj0d7y5BBPjExyPOeil7oJXeh1rX7QHdKZxeIG+Se
   /7lENWQJxi+wfAxNX0vbtSc7I6Wwd63Nh+fkV6VjGQD5biKdKjhIsGzpa
   is5PIvFE6GMDRHPdESu7NVgzGZIi8a9gXViCjK4eZUUSaT31M0KYu4+dL
   1eM54+HsdrjqRGMyxb+EWdUaq0q09HKc76ZknLXUOkfeXw+bDbgOVYc6H
   QMEYzErAXpiQ3RkGgEh2V5x5y9zyJodD5lRXZDPy0WSP5FdiwzO8lInO2
   XUyjpCOVll74LdDYrNC1yV/lg6M5/gGAewHcyl7s13x/R6LrbXx+4I4uW
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10679"; a="372127015"
X-IronPort-AV: E=Sophos;i="5.99,194,1677571200"; 
   d="scan'208";a="372127015"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2023 11:41:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10679"; a="719984349"
X-IronPort-AV: E=Sophos;i="5.99,194,1677571200"; 
   d="scan'208";a="719984349"
Received: from apeled2-mobl.ger.corp.intel.com (HELO ggreenma-mobl2.lan) ([10.251.184.75])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2023 11:41:03 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Avraham Stern <avraham.stern@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 06/15] wifi: iwlwifi: mvm: make HLTK configuration for PASN station optional
Date:   Thu, 13 Apr 2023 21:40:26 +0300
Message-Id: <20230413213309.a57f7f3b59bd.Ifa88afb51a2516156153ac321d81556e295036c2@changeid>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230413184035.1140892-1-gregory.greenman@intel.com>
References: <20230413184035.1140892-1-gregory.greenman@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Avraham Stern <avraham.stern@intel.com>

When secure LTF is not used, the HLTK is not derived during the PASN
authentication. Make the HLTK optional when adding a PASN station.

Signed-off-by: Avraham Stern <avraham.stern@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 .../intel/iwlwifi/mvm/ftm-initiator.c         | 25 ++++++++++++++++---
 .../intel/iwlwifi/mvm/ftm-responder.c         | 19 +++++++++++---
 2 files changed, 37 insertions(+), 7 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/ftm-initiator.c b/drivers/net/wireless/intel/iwlwifi/mvm/ftm-initiator.c
index 379da4bec5dd..3963a0d4ed04 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/ftm-initiator.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/ftm-initiator.c
@@ -25,6 +25,10 @@ struct iwl_mvm_smooth_entry {
 	u64 host_time;
 };
 
+enum iwl_mvm_pasn_flags {
+	IWL_MVM_PASN_FLAG_HAS_HLTK = BIT(0),
+};
+
 struct iwl_mvm_ftm_pasn_entry {
 	struct list_head list;
 	u8 addr[ETH_ALEN];
@@ -33,6 +37,7 @@ struct iwl_mvm_ftm_pasn_entry {
 	u8 cipher;
 	u8 tx_pn[IEEE80211_CCMP_PN_LEN];
 	u8 rx_pn[IEEE80211_CCMP_PN_LEN];
+	u32 flags;
 };
 
 int iwl_mvm_ftm_add_pasn_sta(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
@@ -79,14 +84,24 @@ int iwl_mvm_ftm_add_pasn_sta(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
 		rcu_read_unlock();
 	}
 
-	if (tk_len != expected_tk_len || hltk_len != sizeof(pasn->hltk)) {
+	if (tk_len != expected_tk_len ||
+	    (hltk_len && hltk_len != sizeof(pasn->hltk))) {
 		IWL_ERR(mvm, "Invalid key length: tk_len=%u hltk_len=%u\n",
 			tk_len, hltk_len);
 		goto out;
 	}
 
+	if (!expected_tk_len && !hltk_len) {
+		IWL_ERR(mvm, "TK and HLTK not set\n");
+		goto out;
+	}
+
 	memcpy(pasn->addr, addr, sizeof(pasn->addr));
-	memcpy(pasn->hltk, hltk, sizeof(pasn->hltk));
+
+	if (hltk_len) {
+		memcpy(pasn->hltk, hltk, sizeof(pasn->hltk));
+		pasn->flags |= IWL_MVM_PASN_FLAG_HAS_HLTK;
+	}
 
 	if (tk && tk_len)
 		memcpy(pasn->tk, tk, sizeof(pasn->tk));
@@ -691,7 +706,11 @@ iwl_mvm_ftm_set_secured_ranging(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
 			continue;
 
 		target->cipher = entry->cipher;
-		memcpy(target->hltk, entry->hltk, sizeof(target->hltk));
+
+		if (entry->flags & IWL_MVM_PASN_FLAG_HAS_HLTK)
+			memcpy(target->hltk, entry->hltk, sizeof(target->hltk));
+		else
+			memset(target->hltk, 0, sizeof(target->hltk));
 
 		if (vif->cfg.assoc &&
 		    !memcmp(vif->bss_conf.bssid, target->bssid,
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/ftm-responder.c b/drivers/net/wireless/intel/iwlwifi/mvm/ftm-responder.c
index c37d793d6a4a..1b6fb73ddfc7 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/ftm-responder.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/ftm-responder.c
@@ -317,6 +317,8 @@ int iwl_mvm_ftm_respoder_add_pasn_sta(struct iwl_mvm *mvm,
 		.addr = addr,
 		.hltk = hltk,
 	};
+	struct iwl_mvm_pasn_hltk_data *hltk_data_ptr = NULL;
+
 	u8 cmd_ver = iwl_fw_lookup_cmd_ver(mvm->fw,
 					   WIDE_ID(LOCATION_GROUP, TOF_RESPONDER_DYN_CONFIG_CMD),
 					   2);
@@ -328,12 +330,21 @@ int iwl_mvm_ftm_respoder_add_pasn_sta(struct iwl_mvm *mvm,
 		return -ENOTSUPP;
 	}
 
-	hltk_data.cipher = iwl_mvm_cipher_to_location_cipher(cipher);
-	if (hltk_data.cipher == IWL_LOCATION_CIPHER_INVALID) {
-		IWL_ERR(mvm, "invalid cipher: %u\n", cipher);
+	if ((!hltk || !hltk_len) && (!tk || !tk_len)) {
+		IWL_ERR(mvm, "TK and HLTK not set\n");
 		return -EINVAL;
 	}
 
+	if (hltk && hltk_len) {
+		hltk_data.cipher = iwl_mvm_cipher_to_location_cipher(cipher);
+		if (hltk_data.cipher == IWL_LOCATION_CIPHER_INVALID) {
+			IWL_ERR(mvm, "invalid cipher: %u\n", cipher);
+			return -EINVAL;
+		}
+
+		hltk_data_ptr = &hltk_data;
+	}
+
 	if (tk && tk_len) {
 		sta = kzalloc(sizeof(*sta), GFP_KERNEL);
 		if (!sta)
@@ -350,7 +361,7 @@ int iwl_mvm_ftm_respoder_add_pasn_sta(struct iwl_mvm *mvm,
 		list_add_tail(&sta->list, &mvm->resp_pasn_list);
 	}
 
-	ret = iwl_mvm_ftm_responder_dyn_cfg_v3(mvm, vif, NULL, &hltk_data);
+	ret = iwl_mvm_ftm_responder_dyn_cfg_v3(mvm, vif, NULL, hltk_data_ptr);
 	if (ret && sta)
 		iwl_mvm_resp_del_pasn_sta(mvm, vif, sta);
 
-- 
2.38.1

