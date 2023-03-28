Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDB296CB8FB
	for <lists+linux-wireless@lfdr.de>; Tue, 28 Mar 2023 10:01:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232689AbjC1IAm (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 28 Mar 2023 04:00:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230258AbjC1IA1 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 28 Mar 2023 04:00:27 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02274468C
        for <linux-wireless@vger.kernel.org>; Tue, 28 Mar 2023 01:00:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679990425; x=1711526425;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=zMT+5AIJPsG3R6/o/nJLuoYdjfJZbs6qNIb2N7epzwY=;
  b=PaDMqGfS2LgNZxJii2pvWy2/4Quoc3Rr0Bvp6ItggQf/9ha4BAYyy+1L
   lNWGFCXzdfu6ABfWcDrFlbmlZrnmxyPdKSHggjhQuLmhMP8WLMlhV6Nzt
   hJeEPunar08aZVUtsQhdZ/5/UDv6LyYOCTcFuUKn0EEpnTexml/DlO4CX
   1QJkT5P66A2Dfyr2wvLWCJHpK2P6C4itjhg4c0k1MpDlF4Y9hvLIyC/OO
   t3SZBLFCDCmcoAa7KugwkiR5gS7cszsOvo4YNbCrS267em+kHT3LxPmO2
   iYYQpKpBt5Qo8/FRNHPm6tHgiVDmkkvFLdYzRExdfeyapTv9+VGljGP+g
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10662"; a="328958300"
X-IronPort-AV: E=Sophos;i="5.98,296,1673942400"; 
   d="scan'208";a="328958300"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2023 01:00:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10662"; a="773045343"
X-IronPort-AV: E=Sophos;i="5.98,296,1673942400"; 
   d="scan'208";a="773045343"
Received: from gershonr-mobl.ger.corp.intel.com (HELO ggreenma-mobl2.intel.com) ([10.214.194.136])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2023 01:00:22 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 28/31] wifi: iwlwifi: mvm: update iwl_mvm_tx_reclaim() for MLO
Date:   Tue, 28 Mar 2023 10:59:08 +0300
Message-Id: <20230328104949.c6826d5b5477.Ib56ec6025c0da3a381aaf88e71085ce9b96a9e65@changeid>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230328075911.2370108-1-gregory.greenman@intel.com>
References: <20230328075911.2370108-1-gregory.greenman@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Gregory Greenman <gregory.greenman@intel.com>

vif->bss_conf is used in this function only when TLC is not offloaded,
so not in MLO flow. Simplify the related "if" condition and call
iwl_mvm_hwrate_to_tx_status() only for driver rate scale.

Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/tx.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/tx.c b/drivers/net/wireless/intel/iwlwifi/mvm/tx.c
index 1737f2ad21ad..61a95ee3ef2d 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/tx.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/tx.c
@@ -1976,9 +1976,11 @@ static void iwl_mvm_tx_reclaim(struct iwl_mvm *mvm, int sta_id, int tid,
 	 * possible (i.e. first MPDU in the aggregation wasn't acked)
 	 * Still it's important to update RS about sent vs. acked.
 	 */
-	if (!is_flush && skb_queue_empty(&reclaimed_skbs)) {
+	if (!is_flush && skb_queue_empty(&reclaimed_skbs) &&
+	    !iwl_mvm_has_tlc_offload(mvm)) {
 		struct ieee80211_chanctx_conf *chanctx_conf = NULL;
 
+		/* no TLC offload, so non-MLD mode */
 		if (mvmsta->vif)
 			chanctx_conf =
 				rcu_dereference(mvmsta->vif->bss_conf.chanctx_conf);
@@ -1989,11 +1991,8 @@ static void iwl_mvm_tx_reclaim(struct iwl_mvm *mvm, int sta_id, int tid,
 		tx_info->band = chanctx_conf->def.chan->band;
 		iwl_mvm_hwrate_to_tx_status(mvm->fw, rate, tx_info);
 
-		if (!iwl_mvm_has_tlc_offload(mvm)) {
-			IWL_DEBUG_TX_REPLY(mvm,
-					   "No reclaim. Update rs directly\n");
-			iwl_mvm_rs_tx_status(mvm, sta, tid, tx_info, false);
-		}
+		IWL_DEBUG_TX_REPLY(mvm, "No reclaim. Update rs directly\n");
+		iwl_mvm_rs_tx_status(mvm, sta, tid, tx_info, false);
 	}
 
 out:
-- 
2.38.1

