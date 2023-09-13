Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EC4E79E75B
	for <lists+linux-wireless@lfdr.de>; Wed, 13 Sep 2023 13:58:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240601AbjIML6I (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 13 Sep 2023 07:58:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240593AbjIML6I (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 13 Sep 2023 07:58:08 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F2531996
        for <linux-wireless@vger.kernel.org>; Wed, 13 Sep 2023 04:58:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694606284; x=1726142284;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Lzq9PVHTONYhnw7+7V8tJjBPV9UOoghgpopZa8EKSbM=;
  b=cEYaL3WuzsVmdbDfYHyOOJFPmn4WiiKVTZ1mkB4zpEdbKcKqfPS9Qewb
   Z+a7+cTH3cqho70RlAIw+5qfgU2ZopOoPNrmtIGoHjVM1xfVJjX3xyVvU
   mhzExf4fJXsvZVhNNlXlvztpO6ja0dtoUNFHqwySOrPu13wF7u4l2pYFt
   mPNdtAuzlaGwlGLZFBV75Frk8/6r9ej7/fxKv2878WoN0B0UirPyXLZKA
   r9ZZ7lQ0/QnUi4Coky7TsxWdf/l4VGdU4d4g2PHS0A/8ppZvPBIJyI5HB
   8UEwHD/CtWPULtRTgC4OuQ0wEKLDIq27zESI9b6p1+HTXisFG7yv+Kb+A
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10831"; a="368903068"
X-IronPort-AV: E=Sophos;i="6.02,143,1688454000"; 
   d="scan'208";a="368903068"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2023 04:57:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10831"; a="737470961"
X-IronPort-AV: E=Sophos;i="6.02,143,1688454000"; 
   d="scan'208";a="737470961"
Received: from ggreenma-mobl2.jer.intel.com ([10.13.17.40])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2023 04:57:27 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Miri Korenblit <miriam.rachel.korenblit@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 09/15] wifi: iwlwifi: Use FW rate for non-data frames
Date:   Wed, 13 Sep 2023 14:56:45 +0300
Message-Id: <20230913145231.6c7e59620ee0.I6eaed3ccdd6dd62b9e664facc484081fc5275843@changeid>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230913115651.190558-1-gregory.greenman@intel.com>
References: <20230913115651.190558-1-gregory.greenman@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Miri Korenblit <miriam.rachel.korenblit@intel.com>

Currently we are setting the rate in the tx cmd for
mgmt frames (e.g. during connection establishment).
This was problematic when sending mgmt frames in eSR mode,
as we don't know what link this frame will be sent on
(This is decided by the FW), so we don't know what is the
lowest rate.
Fix this by not setting the rate in tx cmd and rely
on FW to choose the right one.
Set rate only for injected frames with fixed rate,
or when no sta is given.
Also set for important frames (EAPOL etc.) the High Priority flag.

Fixes: 055b22e770dd ("iwlwifi: mvm: Set Tx rate and flags when there is not station")
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/tx.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/tx.c b/drivers/net/wireless/intel/iwlwifi/mvm/tx.c
index 36d70d589aed..6e2e52936761 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/tx.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/tx.c
@@ -536,16 +536,20 @@ iwl_mvm_set_tx_params(struct iwl_mvm *mvm, struct sk_buff *skb,
 			flags |= IWL_TX_FLAGS_ENCRYPT_DIS;
 
 		/*
-		 * For data packets rate info comes from the fw. Only
-		 * set rate/antenna during connection establishment or in case
-		 * no station is given.
+		 * For data and mgmt packets rate info comes from the fw. Only
+		 * set rate/antenna for injected frames with fixed rate, or
+		 * when no sta is given.
 		 */
-		if (!sta || !ieee80211_is_data(hdr->frame_control) ||
-		    mvmsta->sta_state < IEEE80211_STA_AUTHORIZED) {
+		if (unlikely(!sta ||
+			     info->control.flags & IEEE80211_TX_CTRL_RATE_INJECT)) {
 			flags |= IWL_TX_FLAGS_CMD_RATE;
 			rate_n_flags =
 				iwl_mvm_get_tx_rate_n_flags(mvm, info, sta,
 							    hdr->frame_control);
+		} else if (!ieee80211_is_data(hdr->frame_control) ||
+			   mvmsta->sta_state < IEEE80211_STA_AUTHORIZED) {
+			/* These are important frames */
+			flags |= IWL_TX_FLAGS_HIGH_PRI;
 		}
 
 		if (mvm->trans->trans_cfg->device_family >=
-- 
2.38.1

