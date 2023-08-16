Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3464277DBD3
	for <lists+linux-wireless@lfdr.de>; Wed, 16 Aug 2023 10:12:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242782AbjHPILn (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 16 Aug 2023 04:11:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242810AbjHPILY (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 16 Aug 2023 04:11:24 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A557109
        for <linux-wireless@vger.kernel.org>; Wed, 16 Aug 2023 01:11:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692173482; x=1723709482;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ytXRl4fBc5KLKfsz+OoHHDhdToAVwwDLYGwh4fZQ4XM=;
  b=BaZgjG4cp7IXGu8XyR8cZLTss/wPq/YtZ3SDHW0EB/Vg5zodp0bgWHQR
   ELf1isuorwzjbq4TbBZXGFo9trx3ualMUzf8yo4gRAhKIXLX0KzM/LkSt
   GQrmoI5raRuysfNQ3yNk44DCGW7zIUOWHteeu/86/64nYyFRK+Ur86owp
   ueJGtG0GNN0NF7UYF9ME7rLYkmhIDWpy0zhAx+uZaymrksDhQ+r5/SQHG
   AcIz2Ic8UzMUQFEg/BilRmMzhJoNA3rT0qOqRFtEaCPQ5pJ+UlMJLz22s
   7iRLSqu0LFYyIl+0YVvBQ0IsQLHaqqYf7r9OZEv6y5YbxSd9dXATT08av
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="357447830"
X-IronPort-AV: E=Sophos;i="6.01,176,1684825200"; 
   d="scan'208";a="357447830"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2023 01:11:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="769098820"
X-IronPort-AV: E=Sophos;i="6.01,176,1684825200"; 
   d="scan'208";a="769098820"
Received: from mamir-mobl.ger.corp.intel.com (HELO ggreenma-mobl2.intel.com) ([10.214.226.187])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2023 01:11:20 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Johannes Berg <johannes.berg@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 06/12] wifi: iwlwifi: pcie: move gen1 TB handling to header
Date:   Wed, 16 Aug 2023 11:10:48 +0300
Message-Id: <20230816104355.52b6f66de219.Ic8403fd098c187fac067977808c0129d96514c91@changeid>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230816081054.245480-1-gregory.greenman@intel.com>
References: <20230816081054.245480-1-gregory.greenman@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

We will need this in another place soon in reclaim and init,
so add this function to the queue header file instead.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/pcie/tx.c  | 18 +-----------------
 drivers/net/wireless/intel/iwlwifi/queue/tx.h | 15 +++++++++++++++
 2 files changed, 16 insertions(+), 17 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/tx.c b/drivers/net/wireless/intel/iwlwifi/pcie/tx.c
index 9ab1b2590dd2..2f39b639c43f 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/tx.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/tx.c
@@ -132,22 +132,6 @@ void iwl_pcie_txq_check_wrptrs(struct iwl_trans *trans)
 	}
 }
 
-static inline void iwl_pcie_tfd_set_tb(struct iwl_trans *trans, void *tfd,
-				       u8 idx, dma_addr_t addr, u16 len)
-{
-	struct iwl_tfd *tfd_fh = (void *)tfd;
-	struct iwl_tfd_tb *tb = &tfd_fh->tbs[idx];
-
-	u16 hi_n_len = len << 4;
-
-	put_unaligned_le32(addr, &tb->lo);
-	hi_n_len |= iwl_get_dma_hi_addr(addr);
-
-	tb->hi_n_len = cpu_to_le16(hi_n_len);
-
-	tfd_fh->num_tbs = idx + 1;
-}
-
 static int iwl_pcie_txq_build_tfd(struct iwl_trans *trans, struct iwl_txq *txq,
 				  dma_addr_t addr, u16 len, bool reset)
 {
@@ -172,7 +156,7 @@ static int iwl_pcie_txq_build_tfd(struct iwl_trans *trans, struct iwl_txq *txq,
 		 "Unaligned address = %llx\n", (unsigned long long)addr))
 		return -EINVAL;
 
-	iwl_pcie_tfd_set_tb(trans, tfd, num_tbs, addr, len);
+	iwl_pcie_gen1_tfd_set_tb(trans, tfd, num_tbs, addr, len);
 
 	return num_tbs;
 }
diff --git a/drivers/net/wireless/intel/iwlwifi/queue/tx.h b/drivers/net/wireless/intel/iwlwifi/queue/tx.h
index 15b3edce56e0..b7d3808588bf 100644
--- a/drivers/net/wireless/intel/iwlwifi/queue/tx.h
+++ b/drivers/net/wireless/intel/iwlwifi/queue/tx.h
@@ -155,6 +155,21 @@ static inline u16 iwl_txq_gen1_tfd_tb_get_len(struct iwl_trans *trans,
 	return le16_to_cpu(tb->hi_n_len) >> 4;
 }
 
+static inline void iwl_pcie_gen1_tfd_set_tb(struct iwl_trans *trans,
+					    struct iwl_tfd *tfd,
+					    u8 idx, dma_addr_t addr, u16 len)
+{
+	struct iwl_tfd_tb *tb = &tfd->tbs[idx];
+	u16 hi_n_len = len << 4;
+
+	put_unaligned_le32(addr, &tb->lo);
+	hi_n_len |= iwl_get_dma_hi_addr(addr);
+
+	tb->hi_n_len = cpu_to_le16(hi_n_len);
+
+	tfd->num_tbs = idx + 1;
+}
+
 void iwl_txq_gen1_tfd_unmap(struct iwl_trans *trans,
 			    struct iwl_cmd_meta *meta,
 			    struct iwl_txq *txq, int index);
-- 
2.38.1

