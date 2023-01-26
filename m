Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41FC567D895
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Jan 2023 23:37:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231587AbjAZWgq (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 26 Jan 2023 17:36:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233190AbjAZWgj (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 26 Jan 2023 17:36:39 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0407E45F5E
        for <linux-wireless@vger.kernel.org>; Thu, 26 Jan 2023 14:36:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674772596; x=1706308596;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=+wuwzZwxt2/Uo5xSbErkP284kKy7ZajlCKoPDKzlv9o=;
  b=adRkN3SJ5WdnpX9pwqJFpt+7zAHYIXcsQg7sQJu8JztGYcetW6gbTRcE
   kic80aewhagHUTWIR6YZsG/vWkVYVE5Q9kZx1NFDjsoJxfuIHIyCWeQS5
   grJfxWTR0bDemuBghWTFPixHzKXdQvGKiNsAz7FrErmgpDYz+ONgirxLs
   L3/7FD+S3W6gU1k0fQ2l9zmjS4hXYqFtQXXwTaFa4R6NeIJE4Df2ATDI6
   r+QHvjcgMo7YoOEVXmipDosFEVZDt91OfJnxB59BwMR2xGxR2yLe2xzv3
   JQkgOdrCLy3+HNHbWcPOy2/oAmGnUAuSY8LQ2nPt6kfffiS7PspX3BH99
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10602"; a="329098650"
X-IronPort-AV: E=Sophos;i="5.97,249,1669104000"; 
   d="scan'208";a="329098650"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2023 14:29:14 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10602"; a="612986248"
X-IronPort-AV: E=Sophos;i="5.97,249,1669104000"; 
   d="scan'208";a="612986248"
Received: from razgilad-mobl7.ger.corp.intel.com (HELO ggreenma-mobl2.lan) ([10.214.211.193])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2023 14:29:12 -0800
From:   gregory.greenman@intel.com
To:     kvalo@kernel.org, johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 05/12] wifi: iwlwifi: mvm: always send nullfunc frames on MGMT queue
Date:   Fri, 27 Jan 2023 00:28:14 +0200
Message-Id: <20230127002430.a05bf77c9e29.I06262424878232b46fecd58743c889e4c3216bbf@changeid>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230126222821.305122-1-gregory.greenman@intel.com>
References: <20230126222821.305122-1-gregory.greenman@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Gregory Greenman <gregory.greenman@intel.com>

Non-QOS nullfunc frames should be sent on MGMT queue similarly to
the QOS nullfunc frames. It means that the corresponding TID should
remain IWL_MAX_TID_COUNT. Make the condition more strict, so the TID
won't be changed to IWL_TID_NON_QOS.

Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/tx.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/tx.c b/drivers/net/wireless/intel/iwlwifi/mvm/tx.c
index 765ee16c77b5..0a82a8f619a7 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/tx.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/tx.c
@@ -1108,8 +1108,8 @@ static int iwl_mvm_tx_mpdu(struct iwl_mvm *mvm, struct sk_buff *skb,
 	spin_lock(&mvmsta->lock);
 
 	/* nullfunc frames should go to the MGMT queue regardless of QOS,
-	 * the condition of !ieee80211_is_qos_nullfunc(fc) keeps the default
-	 * assignment of MGMT TID
+	 * the conditions of !ieee80211_is_qos_nullfunc(fc) and
+	 * !ieee80211_is_data_qos(fc) keep the default assignment of MGMT TID
 	 */
 	if (ieee80211_is_data_qos(fc) && !ieee80211_is_qos_nullfunc(fc)) {
 		tid = ieee80211_get_tid(hdr);
@@ -1134,7 +1134,8 @@ static int iwl_mvm_tx_mpdu(struct iwl_mvm *mvm, struct sk_buff *skb,
 			/* update the tx_cmd hdr as it was already copied */
 			tx_cmd->hdr->seq_ctrl = hdr->seq_ctrl;
 		}
-	} else if (ieee80211_is_data(fc) && !ieee80211_is_data_qos(fc)) {
+	} else if (ieee80211_is_data(fc) && !ieee80211_is_data_qos(fc) &&
+		   !ieee80211_is_nullfunc(fc)) {
 		tid = IWL_TID_NON_QOS;
 	}
 
-- 
2.38.1

