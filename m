Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F0D835B2DA
	for <lists+linux-wireless@lfdr.de>; Sun, 11 Apr 2021 11:47:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235352AbhDKJqy (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 11 Apr 2021 05:46:54 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:44426 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S235267AbhDKJqv (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 11 Apr 2021 05:46:51 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=kveik.lan)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94)
        (envelope-from <luca@coelho.fi>)
        id 1lVWfo-000Jkq-IL; Sun, 11 Apr 2021 12:46:34 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     luca@coelho.fi, linux-wireless@vger.kernel.org
Date:   Sun, 11 Apr 2021 12:46:20 +0300
Message-Id: <iwlwifi.20210411124417.280f268ae679.Iad455b6c91e427c9f74963bbd3eb0ce743aaac53@changeid>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20210411094630.431873-1-luca@coelho.fi>
References: <20210411094630.431873-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.5-pre1 (2020-06-20) on
        farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.5-pre1
Subject: [PATCH 02/12] iwlwifi: remove remaining software checksum code
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

After the removal of the software checksum code for the
A-MSDU path that we had for testing, the csum_skb variable
stuck around. Remove it.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/pcie/tx.c  | 11 +++--------
 drivers/net/wireless/intel/iwlwifi/queue/tx.c | 11 +++--------
 2 files changed, 6 insertions(+), 16 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/tx.c b/drivers/net/wireless/intel/iwlwifi/pcie/tx.c
index 4ea353734665..1aa04e078eec 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/tx.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/tx.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
 /*
- * Copyright (C) 2003-2014, 2018-2020 Intel Corporation
+ * Copyright (C) 2003-2014, 2018-2021 Intel Corporation
  * Copyright (C) 2013-2015 Intel Mobile Communications GmbH
  * Copyright (C) 2016-2017 Intel Deutschland GmbH
  */
@@ -1349,7 +1349,6 @@ static int iwl_fill_data_tbs_amsdu(struct iwl_trans *trans, struct sk_buff *skb,
 		/* this is the data left for this subframe */
 		unsigned int data_left =
 			min_t(unsigned int, mss, total_len);
-		struct sk_buff *csum_skb = NULL;
 		unsigned int hdr_tb_len;
 		dma_addr_t hdr_tb_phys;
 		u8 *subf_hdrs_start = hdr_page->pos;
@@ -1380,10 +1379,8 @@ static int iwl_fill_data_tbs_amsdu(struct iwl_trans *trans, struct sk_buff *skb,
 		hdr_tb_len = hdr_page->pos - start_hdr;
 		hdr_tb_phys = dma_map_single(trans->dev, start_hdr,
 					     hdr_tb_len, DMA_TO_DEVICE);
-		if (unlikely(dma_mapping_error(trans->dev, hdr_tb_phys))) {
-			dev_kfree_skb(csum_skb);
+		if (unlikely(dma_mapping_error(trans->dev, hdr_tb_phys)))
 			return -EINVAL;
-		}
 		iwl_pcie_txq_build_tfd(trans, txq, hdr_tb_phys,
 				       hdr_tb_len, false);
 		trace_iwlwifi_dev_tx_tb(trans->dev, skb, start_hdr,
@@ -1402,10 +1399,8 @@ static int iwl_fill_data_tbs_amsdu(struct iwl_trans *trans, struct sk_buff *skb,
 
 			tb_phys = dma_map_single(trans->dev, tso.data,
 						 size, DMA_TO_DEVICE);
-			if (unlikely(dma_mapping_error(trans->dev, tb_phys))) {
-				dev_kfree_skb(csum_skb);
+			if (unlikely(dma_mapping_error(trans->dev, tb_phys)))
 				return -EINVAL;
-			}
 
 			iwl_pcie_txq_build_tfd(trans, txq, tb_phys,
 					       size, false);
diff --git a/drivers/net/wireless/intel/iwlwifi/queue/tx.c b/drivers/net/wireless/intel/iwlwifi/queue/tx.c
index 833f43d1ca7a..494f9dbf92d6 100644
--- a/drivers/net/wireless/intel/iwlwifi/queue/tx.c
+++ b/drivers/net/wireless/intel/iwlwifi/queue/tx.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
 /*
- * Copyright (C) 2020 Intel Corporation
+ * Copyright (C) 2020-2021 Intel Corporation
  */
 #include <net/tso.h>
 #include <linux/tcp.h>
@@ -399,7 +399,6 @@ static int iwl_txq_gen2_build_amsdu(struct iwl_trans *trans,
 	while (total_len) {
 		/* this is the data left for this subframe */
 		unsigned int data_left = min_t(unsigned int, mss, total_len);
-		struct sk_buff *csum_skb = NULL;
 		unsigned int tb_len;
 		dma_addr_t tb_phys;
 		u8 *subf_hdrs_start = hdr_page->pos;
@@ -430,10 +429,8 @@ static int iwl_txq_gen2_build_amsdu(struct iwl_trans *trans,
 		tb_len = hdr_page->pos - start_hdr;
 		tb_phys = dma_map_single(trans->dev, start_hdr,
 					 tb_len, DMA_TO_DEVICE);
-		if (unlikely(dma_mapping_error(trans->dev, tb_phys))) {
-			dev_kfree_skb(csum_skb);
+		if (unlikely(dma_mapping_error(trans->dev, tb_phys)))
 			goto out_err;
-		}
 		/*
 		 * No need for _with_wa, this is from the TSO page and
 		 * we leave some space at the end of it so can't hit
@@ -458,10 +455,8 @@ static int iwl_txq_gen2_build_amsdu(struct iwl_trans *trans,
 			ret = iwl_txq_gen2_set_tb_with_wa(trans, skb, tfd,
 							  tb_phys, tso.data,
 							  tb_len, NULL);
-			if (ret) {
-				dev_kfree_skb(csum_skb);
+			if (ret)
 				goto out_err;
-			}
 
 			data_left -= tb_len;
 			tso_build_data(skb, &tso, tb_len);
-- 
2.31.0

