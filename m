Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F62679E755
	for <lists+linux-wireless@lfdr.de>; Wed, 13 Sep 2023 13:57:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240570AbjIML53 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 13 Sep 2023 07:57:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240561AbjIML51 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 13 Sep 2023 07:57:27 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59ABF1996
        for <linux-wireless@vger.kernel.org>; Wed, 13 Sep 2023 04:57:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694606243; x=1726142243;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=aiXmj+uG6HKGop26odIuD1SeEcGV0UbuMzMHwA8FLzU=;
  b=KmpOE9e3c89LLwaCqU2P5vTuwKfOWaiNKHxEaDJsWUZvjbR3IUQUEIvA
   JV/iaEXwfO78iteLTrXy4YiwUdeZzU/tIihPWV7fokohvFFxKrDGlSFXi
   vlh45QE1gu5oV8CkpuMz9Q53voSfwJkoUgwbhdkUwPpV216/h7SfDebVa
   sGZ0oIbkErk62ewXQrZHX/1yk3HW3zoxN7WSxZUCZxZJPRdySY+LXD2Ag
   sNSaEaQZzte/TQB0yM/Ch0HNaLIZ28RXXVsz+CMWzPNIb+01/nRahjTyN
   /Van23KjG2fYMAmzTkoLkJUOHkTaVOCCA4qkmTVYo5ljSKAWybtWlGg5A
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10831"; a="368903033"
X-IronPort-AV: E=Sophos;i="6.02,143,1688454000"; 
   d="scan'208";a="368903033"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2023 04:57:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10831"; a="737470949"
X-IronPort-AV: E=Sophos;i="6.02,143,1688454000"; 
   d="scan'208";a="737470949"
Received: from ggreenma-mobl2.jer.intel.com ([10.13.17.40])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2023 04:57:20 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 06/15] wifi: iwlwifi: mvm: log dropped frames
Date:   Wed, 13 Sep 2023 14:56:42 +0300
Message-Id: <20230913145231.c2f02fecf66f.Ib472f9fd92856c6e5b5a99b68fdca0f694a531e9@changeid>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230913115651.190558-1-gregory.greenman@intel.com>
References: <20230913115651.190558-1-gregory.greenman@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Emmanuel Grumbach <emmanuel.grumbach@intel.com>

When we drop frames we want to have something printed in the logger.
This won't be printed by default of course.

Signed-off-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c b/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c
index f0e0b91880a2..42d69f557e71 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c
@@ -376,8 +376,10 @@ static int iwl_mvm_rx_crypto(struct iwl_mvm *mvm, struct ieee80211_sta *sta,
 	 */
 	if (phy_info & IWL_RX_MPDU_PHY_AMPDU &&
 	    (status & IWL_RX_MPDU_STATUS_SEC_MASK) ==
-	    IWL_RX_MPDU_STATUS_SEC_UNKNOWN && !mvm->monitor_on)
+	    IWL_RX_MPDU_STATUS_SEC_UNKNOWN && !mvm->monitor_on) {
+		IWL_DEBUG_DROP(mvm, "Dropping packets, bad enc status\n");
 		return -1;
+	}
 
 	if (unlikely(ieee80211_is_mgmt(hdr->frame_control) &&
 		     !ieee80211_has_protected(hdr->frame_control)))
@@ -2562,6 +2564,8 @@ void iwl_mvm_rx_mpdu_mq(struct iwl_mvm *mvm, struct napi_struct *napi,
 			iwl_mvm_rx_csum(mvm, sta, skb, pkt);
 
 		if (iwl_mvm_is_dup(sta, queue, rx_status, hdr, desc)) {
+			IWL_DEBUG_DROP(mvm, "Dropping duplicate packet 0x%x\n",
+				       le16_to_cpu(hdr->seq_ctrl));
 			kfree_skb(skb);
 			goto out;
 		}
-- 
2.38.1

