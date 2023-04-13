Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9B936E080B
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Apr 2023 09:45:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230081AbjDMHpj (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 13 Apr 2023 03:45:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230097AbjDMHph (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 13 Apr 2023 03:45:37 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8508C9028
        for <linux-wireless@vger.kernel.org>; Thu, 13 Apr 2023 00:45:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681371929; x=1712907929;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Gw54Fz6FWX8n0FKelw1ZfFywQ2+SLe2JfD3OlKvaFc8=;
  b=XUVRUplNPJ52wqNanhYWeProoBewa44X6wI8dCExaFs56SOUrPFosG0d
   +Tvx46mGhBbkGW2izgELjHgg6ZGRP7UAXQ3RhBciplmQWw0tNSc/SpCG0
   +nZtOSt5B94ckodJ3qGy/8J3I12crajjdJvlI9mlSvQ9Bw4Y/SNE/CsVU
   dWZACa/3uP6EapEFILkwOnpFemBnR1519lhq57jindKvIafPhNj38klVb
   ZlxuyewCwvxN3PC8V2ooXDetBAlKD7KWL8/Zjz/aL1nQIWSHzbIzL0Obw
   19HIoZLRN7UUu/0eTbmOR1ohbRjIt9Ty+Fq0LR6BupabcIzmRg/BLEhcq
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10678"; a="323736057"
X-IronPort-AV: E=Sophos;i="5.98,341,1673942400"; 
   d="scan'208";a="323736057"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2023 00:45:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10678"; a="833034770"
X-IronPort-AV: E=Sophos;i="5.98,341,1673942400"; 
   d="scan'208";a="833034770"
Received: from apeled2-mobl.ger.corp.intel.com (HELO ggreenma-mobl2.lan) ([10.251.184.75])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2023 00:45:27 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Johannes Berg <johannes.berg@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 09/15] wifi: iwlwifi: mvm: refactor TX csum mode check
Date:   Thu, 13 Apr 2023 10:44:09 +0300
Message-Id: <20230413102635.ef6246f4b73b.I44820ec095634dd0bba3007465cf25e4ce1c77c6@changeid>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230413074415.1054160-1-gregory.greenman@intel.com>
References: <20230413074415.1054160-1-gregory.greenman@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

There are two modes now, and we have two places checking
that must be in sync. Refactor the logic into a new small
helper function.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c |  5 +----
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h      | 13 +++++++++++++
 drivers/net/wireless/intel/iwlwifi/mvm/tx.c       |  5 +----
 3 files changed, 15 insertions(+), 8 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
index 0ee5169de034..fc15636beec0 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
@@ -6129,10 +6129,7 @@ static bool iwl_mvm_mac_can_aggregate(struct ieee80211_hw *hw,
 {
 	struct iwl_mvm *mvm = IWL_MAC80211_GET_MVM(hw);
 
-	if (mvm->trans->trans_cfg->device_family > IWL_DEVICE_FAMILY_BZ ||
-	    (mvm->trans->trans_cfg->device_family == IWL_DEVICE_FAMILY_BZ &&
-	     !(CSR_HW_REV_TYPE(mvm->trans->hw_rev) == IWL_CFG_MAC_TYPE_GL &&
-	       mvm->trans->hw_rev_step == SILICON_A_STEP)))
+	if (iwl_mvm_has_new_tx_csum(mvm))
 		return iwl_mvm_tx_csum_bz(mvm, head, true) ==
 		       iwl_mvm_tx_csum_bz(mvm, skb, true);
 
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
index e32ce876951f..76ac8a480712 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
@@ -1522,6 +1522,19 @@ static inline bool iwl_mvm_is_ctdp_supported(struct iwl_mvm *mvm)
 			   IWL_UCODE_TLV_CAPA_CTDP_SUPPORT);
 }
 
+static inline bool iwl_mvm_has_new_tx_csum(struct iwl_mvm *mvm)
+{
+	if (mvm->trans->trans_cfg->device_family < IWL_DEVICE_FAMILY_BZ)
+		return false;
+
+	if (mvm->trans->trans_cfg->device_family == IWL_DEVICE_FAMILY_BZ &&
+	    CSR_HW_REV_TYPE(mvm->trans->hw_rev) == IWL_CFG_MAC_TYPE_GL &&
+	    mvm->trans->hw_rev_step <= SILICON_B_STEP)
+		return false;
+
+	return true;
+}
+
 extern const u8 iwl_mvm_ac_to_tx_fifo[];
 extern const u8 iwl_mvm_ac_to_gen2_tx_fifo[];
 
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/tx.c b/drivers/net/wireless/intel/iwlwifi/mvm/tx.c
index b3545c3273e5..51f21cbf7a20 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/tx.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/tx.c
@@ -184,10 +184,7 @@ static u32 iwl_mvm_tx_csum(struct iwl_mvm *mvm, struct sk_buff *skb,
 			   struct ieee80211_tx_info *info,
 			   bool amsdu)
 {
-	if (mvm->trans->trans_cfg->device_family < IWL_DEVICE_FAMILY_BZ ||
-	    (mvm->trans->trans_cfg->device_family == IWL_DEVICE_FAMILY_BZ &&
-	     CSR_HW_REV_TYPE(mvm->trans->hw_rev) == IWL_CFG_MAC_TYPE_GL &&
-	     mvm->trans->hw_rev_step <= SILICON_B_STEP))
+	if (!iwl_mvm_has_new_tx_csum(mvm))
 		return iwl_mvm_tx_csum_pre_bz(mvm, skb, info, amsdu);
 	return iwl_mvm_tx_csum_bz(mvm, skb, amsdu);
 }
-- 
2.38.1

