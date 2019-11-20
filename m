Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B1F9D103778
	for <lists+linux-wireless@lfdr.de>; Wed, 20 Nov 2019 11:27:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728670AbfKTK1G (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 20 Nov 2019 05:27:06 -0500
Received: from paleale.coelho.fi ([176.9.41.70]:58598 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728667AbfKTK1F (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 20 Nov 2019 05:27:05 -0500
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.92)
        (envelope-from <luca@coelho.fi>)
        id 1iXNCQ-0001kS-Tr; Wed, 20 Nov 2019 12:27:03 +0200
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Wed, 20 Nov 2019 12:26:47 +0200
Message-Id: <20191120102650.514376-10-luca@coelho.fi>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191120102650.514376-1-luca@coelho.fi>
References: <20191120102650.514376-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.2
Subject: [PATCH 09/12] iwlwifi: pcie: trace IOVA for iwlwifi_dev_tx_tb
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

We trace the whole TFD with all TBs when in iwlwifi_dev_tx,
but sometimes we add TBs to it later and then we don't have
any of this data. Trace the I/O virtual address (IOVA) (it
can be the physical address, or as returned by the IOMMU)
here to aid debugging the DMA flows.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 .../intel/iwlwifi/iwl-devtrace-data.h         |  8 +++++---
 .../net/wireless/intel/iwlwifi/pcie/tx-gen2.c | 20 +++++++++----------
 drivers/net/wireless/intel/iwlwifi/pcie/tx.c  | 14 ++++++-------
 3 files changed, 20 insertions(+), 22 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-devtrace-data.h b/drivers/net/wireless/intel/iwlwifi/iwl-devtrace-data.h
index 9e8643618578..1bc6ecc32140 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-devtrace-data.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-devtrace-data.h
@@ -3,7 +3,7 @@
  *
  * Copyright(c) 2009 - 2014 Intel Corporation. All rights reserved.
  * Copyright(c) 2015        Intel Deutschland GmbH
- * Copyright(c) 2018        Intel Corporation
+ * Copyright(c) 2018 - 2019 Intel Corporation
  *
  * Contact Information:
  *  Intel Linux Wireless <linuxwifi@intel.com>
@@ -21,16 +21,18 @@
 
 TRACE_EVENT(iwlwifi_dev_tx_tb,
 	TP_PROTO(const struct device *dev, struct sk_buff *skb,
-		 u8 *data_src, size_t data_len),
-	TP_ARGS(dev, skb, data_src, data_len),
+		 u8 *data_src, dma_addr_t phys, size_t data_len),
+	TP_ARGS(dev, skb, data_src, phys, data_len),
 	TP_STRUCT__entry(
 		DEV_ENTRY
+		__field(u64, phys)
 
 		__dynamic_array(u8, data,
 				iwl_trace_data(skb) ? data_len : 0)
 	),
 	TP_fast_assign(
 		DEV_ASSIGN;
+		__entry->phys = phys;
 		if (iwl_trace_data(skb))
 			memcpy(__get_dynamic_array(data), data_src, data_len);
 	),
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/tx-gen2.c b/drivers/net/wireless/intel/iwlwifi/pcie/tx-gen2.c
index 1ca9a7e48c1a..8ca0250de99e 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/tx-gen2.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/tx-gen2.c
@@ -333,7 +333,8 @@ static int iwl_pcie_gen2_build_amsdu(struct iwl_trans *trans,
 			goto out_err;
 		}
 		iwl_pcie_gen2_set_tb(trans, tfd, tb_phys, tb_len);
-		trace_iwlwifi_dev_tx_tb(trans->dev, skb, start_hdr, tb_len);
+		trace_iwlwifi_dev_tx_tb(trans->dev, skb, start_hdr,
+					tb_phys, tb_len);
 		/* add this subframe's headers' length to the tx_cmd */
 		le16_add_cpu(&tx_cmd->len, hdr_page->pos - subf_hdrs_start);
 
@@ -351,7 +352,7 @@ static int iwl_pcie_gen2_build_amsdu(struct iwl_trans *trans,
 			}
 			iwl_pcie_gen2_set_tb(trans, tfd, tb_phys, tb_len);
 			trace_iwlwifi_dev_tx_tb(trans->dev, skb, tso.data,
-						tb_len);
+						tb_phys, tb_len);
 
 			data_left -= tb_len;
 			tso_build_data(skb, &tso, tb_len);
@@ -441,9 +442,8 @@ static int iwl_pcie_gen2_tx_add_frags(struct iwl_trans *trans,
 			return -ENOMEM;
 		tb_idx = iwl_pcie_gen2_set_tb(trans, tfd, tb_phys,
 					      skb_frag_size(frag));
-		trace_iwlwifi_dev_tx_tb(trans->dev, skb,
-					skb_frag_address(frag),
-					skb_frag_size(frag));
+		trace_iwlwifi_dev_tx_tb(trans->dev, skb, skb_frag_address(frag),
+					tb_phys, skb_frag_size(frag));
 		if (tb_idx < 0)
 			return tb_idx;
 
@@ -509,9 +509,8 @@ iwl_tfh_tfd *iwl_pcie_gen2_build_tx(struct iwl_trans *trans,
 		if (unlikely(dma_mapping_error(trans->dev, tb_phys)))
 			goto out_err;
 		iwl_pcie_gen2_set_tb(trans, tfd, tb_phys, tb2_len);
-		trace_iwlwifi_dev_tx_tb(trans->dev, skb,
-					skb->data + hdr_len,
-					tb2_len);
+		trace_iwlwifi_dev_tx_tb(trans->dev, skb, skb->data + hdr_len,
+					tb_phys, tb2_len);
 	}
 
 	if (iwl_pcie_gen2_tx_add_frags(trans, skb, tfd, out_meta))
@@ -523,9 +522,8 @@ iwl_tfh_tfd *iwl_pcie_gen2_build_tx(struct iwl_trans *trans,
 		if (unlikely(dma_mapping_error(trans->dev, tb_phys)))
 			goto out_err;
 		iwl_pcie_gen2_set_tb(trans, tfd, tb_phys, skb_headlen(frag));
-		trace_iwlwifi_dev_tx_tb(trans->dev, skb,
-					frag->data,
-					skb_headlen(frag));
+		trace_iwlwifi_dev_tx_tb(trans->dev, skb, frag->data,
+					tb_phys, skb_headlen(frag));
 		if (iwl_pcie_gen2_tx_add_frags(trans, frag, tfd, out_meta))
 			goto out_err;
 	}
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/tx.c b/drivers/net/wireless/intel/iwlwifi/pcie/tx.c
index b710b8a25b54..f21f16ab2a97 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/tx.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/tx.c
@@ -2019,9 +2019,8 @@ static int iwl_fill_data_tbs(struct iwl_trans *trans, struct sk_buff *skb,
 						    head_tb_len, DMA_TO_DEVICE);
 		if (unlikely(dma_mapping_error(trans->dev, tb_phys)))
 			return -EINVAL;
-		trace_iwlwifi_dev_tx_tb(trans->dev, skb,
-					skb->data + hdr_len,
-					head_tb_len);
+		trace_iwlwifi_dev_tx_tb(trans->dev, skb, skb->data + hdr_len,
+					tb_phys, head_tb_len);
 		iwl_pcie_txq_build_tfd(trans, txq, tb_phys, head_tb_len, false);
 	}
 
@@ -2039,9 +2038,8 @@ static int iwl_fill_data_tbs(struct iwl_trans *trans, struct sk_buff *skb,
 
 		if (unlikely(dma_mapping_error(trans->dev, tb_phys)))
 			return -EINVAL;
-		trace_iwlwifi_dev_tx_tb(trans->dev, skb,
-					skb_frag_address(frag),
-					skb_frag_size(frag));
+		trace_iwlwifi_dev_tx_tb(trans->dev, skb, skb_frag_address(frag),
+					tb_phys, skb_frag_size(frag));
 		tb_idx = iwl_pcie_txq_build_tfd(trans, txq, tb_phys,
 						skb_frag_size(frag), false);
 		if (tb_idx < 0)
@@ -2222,7 +2220,7 @@ static int iwl_fill_data_tbs_amsdu(struct iwl_trans *trans, struct sk_buff *skb,
 		iwl_pcie_txq_build_tfd(trans, txq, hdr_tb_phys,
 				       hdr_tb_len, false);
 		trace_iwlwifi_dev_tx_tb(trans->dev, skb, start_hdr,
-					hdr_tb_len);
+					hdr_tb_phys, hdr_tb_len);
 		/* add this subframe's headers' length to the tx_cmd */
 		le16_add_cpu(&tx_cmd->len, hdr_page->pos - subf_hdrs_start);
 
@@ -2248,7 +2246,7 @@ static int iwl_fill_data_tbs_amsdu(struct iwl_trans *trans, struct sk_buff *skb,
 			iwl_pcie_txq_build_tfd(trans, txq, tb_phys,
 					       size, false);
 			trace_iwlwifi_dev_tx_tb(trans->dev, skb, tso.data,
-						size);
+						tb_phys, size);
 
 			data_left -= size;
 			tso_build_data(skb, &tso, size);
-- 
2.24.0

