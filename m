Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D30A772F9AA
	for <lists+linux-wireless@lfdr.de>; Wed, 14 Jun 2023 11:45:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244227AbjFNJpn (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 14 Jun 2023 05:45:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244262AbjFNJom (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 14 Jun 2023 05:44:42 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C71C41FE1
        for <linux-wireless@vger.kernel.org>; Wed, 14 Jun 2023 02:43:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686735807; x=1718271807;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Xm9a+8D2KBrtYt4PcZm77EmPYpAmmjOMweiyOE8agok=;
  b=Axw9IjI6m+7pDuoE7M7iyAkHB4jNPGlELjLrQoiVZXfBLpl8tUj3hb+g
   zfE2AxDXa3ziOBxsdJA+OowvQuPuFyJ4CLwXFRrTxA0vEaKXj/3MnHApV
   IoYtfz5WLzd0r8R5lZvUxbt7IyxCk8tZ2UUu2gA4iq7dRQ0dV6tEy3WBi
   vh/KOiSlS62OoPRfpegYUEBY8Lbs7lXQsc9/q2iPMBw5xSXyNNS8vGzpb
   ZLKIuCSiBfIhEafi0qgKdAayXsbGHT+V0WXkwsFLgUMjyPuKD4XIDKipo
   NPouxJExJQEx8luODaC0ZMi34Fb0aWM91sjcVprNG4jjGRqfIksd7V1pp
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10740"; a="361049834"
X-IronPort-AV: E=Sophos;i="6.00,242,1681196400"; 
   d="scan'208";a="361049834"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2023 02:42:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10740"; a="711989815"
X-IronPort-AV: E=Sophos;i="6.00,242,1681196400"; 
   d="scan'208";a="711989815"
Received: from basharil-mobl.ger.corp.intel.com (HELO ggreenma-mobl2.lan) ([10.214.203.45])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2023 02:42:04 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Johannes Berg <johannes.berg@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 05/20] wifi: iwlwifi: pull from TXQs with softirqs disabled
Date:   Wed, 14 Jun 2023 12:41:22 +0300
Message-Id: <20230614123446.0feef7fa81db.I4dd62542d955b40dd8f0af34fa4accb9d0d17c7e@changeid>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230614094137.379897-1-gregory.greenman@intel.com>
References: <20230614094137.379897-1-gregory.greenman@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

In mac80211, it's required that we pull from TXQs by calling
ieee80211_tx_dequeue() only with softirqs disabled. However,
in iwl_mvm_queue_state_change() we're often called with them
enabled, e.g. from flush if anything was flushed, triggering
a mac80211 warning.

Fix that by disabling the softirqs across the TX call.

Fixes: cfbc6c4c5b91 ("iwlwifi: mvm: support mac80211 TXQs model")
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/ops.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/ops.c b/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
index 430642576f5d..cc04d7cad715 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
@@ -1740,8 +1740,11 @@ static void iwl_mvm_queue_state_change(struct iwl_op_mode *op_mode,
 		else
 			set_bit(IWL_MVM_TXQ_STATE_STOP_FULL, &mvmtxq->state);
 
-		if (start && mvmsta->sta_state != IEEE80211_STA_NOTEXIST)
+		if (start && mvmsta->sta_state != IEEE80211_STA_NOTEXIST) {
+			local_bh_disable();
 			iwl_mvm_mac_itxq_xmit(mvm->hw, txq);
+			local_bh_enable();
+		}
 	}
 
 out:
-- 
2.38.1

