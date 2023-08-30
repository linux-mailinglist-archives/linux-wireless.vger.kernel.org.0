Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 158EF78D9A3
	for <lists+linux-wireless@lfdr.de>; Wed, 30 Aug 2023 20:34:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236093AbjH3Sdl (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 30 Aug 2023 14:33:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242444AbjH3IcF (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 30 Aug 2023 04:32:05 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 915E01A4
        for <linux-wireless@vger.kernel.org>; Wed, 30 Aug 2023 01:32:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693384323; x=1724920323;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=GOpM+oMaquWKBdNTlkmF3Xe3rbLNLt5Lg5HfVoQmskE=;
  b=Q0iH4pDdoOYcj/MapS5zvUh7B69z8bGgM3xEigjO6x3ETTzJyZme0zVT
   KaVnoPI3zN5CEcdWCj+tCnkkuvyFKyZ5s6buqjQcaUpzBDht92xCx/tfF
   kLweWmd40CPwdYRC/AXgw85VRJKy6KXPoH4hYTaUWWceIsOlrrHWgXzXw
   /WA5dsy19+QuqgBF/QX6JB4MfRxhkkJhKUfs04X2hNDDXNQNqsYpLtehu
   uUOb2Ef2M4CETslIca7gbliKAuAk4bxOxFpjDRBLg0sxRvVYyTcDh1hpj
   vvmgzvg3Q2ootl0HdYZZN23r5WaBzK0abYXI+4p8baKdCzPidn5EDh1oX
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10817"; a="461959105"
X-IronPort-AV: E=Sophos;i="6.02,213,1688454000"; 
   d="scan'208";a="461959105"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2023 01:32:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10817"; a="829152557"
X-IronPort-AV: E=Sophos;i="6.02,213,1688454000"; 
   d="scan'208";a="829152557"
Received: from oweil1-mobl3.ger.corp.intel.com (HELO ggreenma-mobl2.intel.com) ([10.214.210.69])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2023 01:31:58 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Johannes Berg <johannes.berg@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 15/16] wifi: iwlwifi: pcie: fix RB status reading
Date:   Wed, 30 Aug 2023 11:31:03 +0300
Message-Id: <20230830112059.7be2a3fff6f4.I94f11dee314a4f7c1941d2d223936b1fa8aa9ee4@changeid>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230830083104.546619-1-gregory.greenman@intel.com>
References: <20230830083104.546619-1-gregory.greenman@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

On newer hardware, a queue's RB status / write pointer
can be bigger than 4095 (0xFFF), so we cannot mask the
value by 0xFFF unconditionally. Since anyway that's
only necessary on older hardware, move the masking to
the helper function and apply it only for older HW.
This also moves the endian conversion in to handle it
more easily.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/pcie/internal.h |  8 ++++----
 drivers/net/wireless/intel/iwlwifi/pcie/rx.c       |  2 +-
 drivers/net/wireless/intel/iwlwifi/pcie/trans.c    | 12 ++++--------
 3 files changed, 9 insertions(+), 13 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/internal.h b/drivers/net/wireless/intel/iwlwifi/pcie/internal.h
index e4b0c4543424..56def20374f3 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/internal.h
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/internal.h
@@ -192,17 +192,17 @@ struct iwl_rb_allocator {
  * @trans: transport pointer (for configuration)
  * @rxq: the rxq to get the rb stts from
  */
-static inline __le16 iwl_get_closed_rb_stts(struct iwl_trans *trans,
-					    struct iwl_rxq *rxq)
+static inline u16 iwl_get_closed_rb_stts(struct iwl_trans *trans,
+					 struct iwl_rxq *rxq)
 {
 	if (trans->trans_cfg->device_family >= IWL_DEVICE_FAMILY_AX210) {
 		__le16 *rb_stts = rxq->rb_stts;
 
-		return READ_ONCE(*rb_stts);
+		return le16_to_cpu(READ_ONCE(*rb_stts));
 	} else {
 		struct iwl_rb_status *rb_stts = rxq->rb_stts;
 
-		return READ_ONCE(rb_stts->closed_rb_num);
+		return le16_to_cpu(READ_ONCE(rb_stts->closed_rb_num)) & 0xFFF;
 	}
 }
 
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/rx.c b/drivers/net/wireless/intel/iwlwifi/pcie/rx.c
index 4614acee9f7b..607c180d1eb3 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/rx.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/rx.c
@@ -1510,7 +1510,7 @@ static int iwl_pcie_rx_handle(struct iwl_trans *trans, int queue, int budget)
 	spin_lock(&rxq->lock);
 	/* uCode's read index (stored in shared DRAM) indicates the last Rx
 	 * buffer that the driver may process (last buffer filled by ucode). */
-	r = le16_to_cpu(iwl_get_closed_rb_stts(trans, rxq)) & 0x0FFF;
+	r = iwl_get_closed_rb_stts(trans, rxq);
 	i = rxq->read;
 
 	/* W/A 9000 device step A0 wrap-around bug */
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/trans.c b/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
index 198933f853c5..a9e00a2cd9ba 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
@@ -2712,11 +2712,9 @@ static ssize_t iwl_dbgfs_rx_queue_read(struct file *file,
 		pos += scnprintf(buf + pos, bufsz - pos, "\tfree_count: %u\n",
 				 rxq->free_count);
 		if (rxq->rb_stts) {
-			u32 r =	__le16_to_cpu(iwl_get_closed_rb_stts(trans,
-								     rxq));
+			u32 r =	iwl_get_closed_rb_stts(trans, rxq);
 			pos += scnprintf(buf + pos, bufsz - pos,
-					 "\tclosed_rb_num: %u\n",
-					 r & 0x0FFF);
+					 "\tclosed_rb_num: %u\n", r);
 		} else {
 			pos += scnprintf(buf + pos, bufsz - pos,
 					 "\tclosed_rb_num: Not Allocated\n");
@@ -3089,7 +3087,7 @@ static u32 iwl_trans_pcie_dump_rbs(struct iwl_trans *trans,
 
 	spin_lock(&rxq->lock);
 
-	r = le16_to_cpu(iwl_get_closed_rb_stts(trans, rxq)) & 0x0FFF;
+	r = iwl_get_closed_rb_stts(trans, rxq);
 
 	for (i = rxq->read, j = 0;
 	     i != r && j < allocated_rb_nums;
@@ -3385,9 +3383,7 @@ iwl_trans_pcie_dump_data(struct iwl_trans *trans,
 		/* Dump RBs is supported only for pre-9000 devices (1 queue) */
 		struct iwl_rxq *rxq = &trans_pcie->rxq[0];
 		/* RBs */
-		num_rbs =
-			le16_to_cpu(iwl_get_closed_rb_stts(trans, rxq))
-			& 0x0FFF;
+		num_rbs = iwl_get_closed_rb_stts(trans, rxq);
 		num_rbs = (num_rbs - rxq->read) & RX_QUEUE_MASK;
 		len += num_rbs * (sizeof(*data) +
 				  sizeof(struct iwl_fw_error_dump_rb) +
-- 
2.38.1

