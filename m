Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52BCF6C0F08
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Mar 2023 11:36:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230420AbjCTKgR (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 20 Mar 2023 06:36:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230416AbjCTKft (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 20 Mar 2023 06:35:49 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E66F24107
        for <linux-wireless@vger.kernel.org>; Mon, 20 Mar 2023 03:35:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679308512; x=1710844512;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=uejpTah0umCMbxEsmw5tImImPxBKpxokSQgUmdOl6/E=;
  b=OSd1xw/4UyiphXrxpiwUMoXtha61LGwaX9nKyoYoMGqpueCI07b5gTdh
   vjLCx6t7QgOuk2D/WHXAf1TGR+39K83/O/tJT7584MidlnyDRyc4p3AuJ
   DFN+vj651iFyShDOCAXm9kAsAxSPZq1HTMRcIBLYtjAzf+1xrFs5VnhCz
   hszwSpDSyQSXL7QuVH6wsZhIoa6q8C+bQuXQWoOhXLaumjfJwbgKh0Dqe
   5JVZQEkctZM2dg/ewQ/wEdObHgp2/yqZEGZWVQcuHxa0/AAsU3i0FIZaI
   0IdBP8l2Pd6idkbqnf/bUU/YGE8Frfzzz7S6j6zOy2g23Z0fM85z0R9Nk
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10654"; a="326997946"
X-IronPort-AV: E=Sophos;i="5.98,274,1673942400"; 
   d="scan'208";a="326997946"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2023 03:34:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10654"; a="713523695"
X-IronPort-AV: E=Sophos;i="5.98,274,1673942400"; 
   d="scan'208";a="713523695"
Received: from ranikhou-mobl3.ger.corp.intel.com (HELO ggreenma-mobl2.intel.com) ([10.251.179.26])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2023 03:34:05 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Miri Korenblit <miriam.rachel.korenblit@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 14/18] wifi: iwlwifi: mvm: remove not needed initializations
Date:   Mon, 20 Mar 2023 12:33:15 +0200
Message-Id: <20230320122330.c0b4d1e986a5.I6959bf1aca74c865e3c1edbf711f5fe8fb8c0c9f@changeid>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230320103319.1309442-1-gregory.greenman@intel.com>
References: <20230320103319.1309442-1-gregory.greenman@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Miri Korenblit <miriam.rachel.korenblit@intel.com>

In iwl_mvm_add_sta() we're initializing the new allocated mvm_sta.
We are setting some fields to zero even though it was allocated with
kzalloc, for the case of HW restart. But in such a case we will never
get to this initializations due to the goto statement that we have in
this case. Remove these initializations.

Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/sta.c | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/sta.c b/drivers/net/wireless/intel/iwlwifi/mvm/sta.c
index a40182e87f55..c22ba1ea42f6 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/sta.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/sta.c
@@ -1702,20 +1702,12 @@ int iwl_mvm_add_sta(struct iwl_mvm *mvm,
 		mvm_sta->max_agg_bufsize = LINK_QUAL_AGG_FRAME_LIMIT_DEF;
 	else
 		mvm_sta->max_agg_bufsize = LINK_QUAL_AGG_FRAME_LIMIT_GEN2_DEF;
-	mvm_sta->tx_protection = 0;
 	mvm_sta->tt_tx_protection = false;
 	mvm_sta->sta_type = sta->tdls ? IWL_STA_TDLS_LINK : IWL_STA_LINK;
 
-	/* HW restart, don't assume the memory has been zeroed */
 	mvm_sta->tid_disable_agg = 0xffff; /* No aggs at first */
-	mvm_sta->tfd_queue_msk = 0;
 
-	/* for HW restart - reset everything but the sequence number */
 	for (i = 0; i <= IWL_MAX_TID_COUNT; i++) {
-		u16 seq = mvm_sta->tid_data[i].seq_number;
-		memset(&mvm_sta->tid_data[i], 0, sizeof(mvm_sta->tid_data[i]));
-		mvm_sta->tid_data[i].seq_number = seq;
-
 		/*
 		 * Mark all queues for this STA as unallocated and defer TX
 		 * frames until the queue is allocated
@@ -1732,8 +1724,6 @@ int iwl_mvm_add_sta(struct iwl_mvm *mvm,
 		atomic_set(&mvmtxq->tx_request, 0);
 	}
 
-	mvm_sta->agg_tids = 0;
-
 	if (iwl_mvm_has_new_rx_api(mvm) &&
 	    !test_bit(IWL_MVM_STATUS_IN_HW_RESTART, &mvm->status)) {
 		int q;
-- 
2.38.1

