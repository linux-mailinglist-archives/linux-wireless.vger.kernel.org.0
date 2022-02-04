Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B20D74A97B0
	for <lists+linux-wireless@lfdr.de>; Fri,  4 Feb 2022 11:25:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358270AbiBDKZW (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 4 Feb 2022 05:25:22 -0500
Received: from paleale.coelho.fi ([176.9.41.70]:37962 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1357692AbiBDKZV (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 4 Feb 2022 05:25:21 -0500
Received: from 91-156-4-210.elisa-laajakaista.fi ([91.156.4.210] helo=kveik.lan)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.95)
        (envelope-from <luca@coelho.fi>)
        id 1nFvmJ-0005zM-Em;
        Fri, 04 Feb 2022 12:25:20 +0200
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@kernel.org
Cc:     luca@coelho.fi, linux-wireless@vger.kernel.org
Date:   Fri,  4 Feb 2022 12:25:04 +0200
Message-Id: <iwlwifi.20220204122220.bef461a04110.I90c8885550fa54eb0aaa4363d322f50e301175a6@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220204102511.606112-1-luca@coelho.fi>
References: <20220204102511.606112-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.6
Subject: [PATCH 05/12] iwlwifi: pcie: adjust to Bz completion descriptor
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

The Bz devices got a new completion descriptor again since
we only ever really used 4 out of 32 bytes anyway. Adjust
the code to deal with that. Note that the intention was to
reduce the size, but the hardware was implemented wrongly.

While at it, do some cleanups and remove the union to simplify
the code, clean up iwl_pcie_free_bd_size() to no longer need
an argument and add iwl_pcie_used_bd_size() with the logic to
selct completion descriptor size.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 .../wireless/intel/iwlwifi/pcie/internal.h    | 20 +++++--
 drivers/net/wireless/intel/iwlwifi/pcie/rx.c  | 56 ++++++++++++-------
 2 files changed, 51 insertions(+), 25 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/internal.h b/drivers/net/wireless/intel/iwlwifi/pcie/internal.h
index 3cddc3e6db53..f7e4f868363d 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/internal.h
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/internal.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
 /*
- * Copyright (C) 2003-2015, 2018-2021 Intel Corporation
+ * Copyright (C) 2003-2015, 2018-2022 Intel Corporation
  * Copyright (C) 2013-2015 Intel Mobile Communications GmbH
  * Copyright (C) 2016-2017 Intel Deutschland GmbH
  */
@@ -103,6 +103,18 @@ struct iwl_rx_completion_desc {
 	u8 reserved2[25];
 } __packed;
 
+/**
+ * struct iwl_rx_completion_desc_bz - Bz completion descriptor
+ * @rbid: unique tag of the received buffer
+ * @flags: flags (0: fragmented, all others: reserved)
+ * @reserved: reserved
+ */
+struct iwl_rx_completion_desc_bz {
+	__le16 rbid;
+	u8 flags;
+	u8 reserved[1];
+} __packed;
+
 /**
  * struct iwl_rxq - Rx queue
  * @id: queue index
@@ -133,11 +145,7 @@ struct iwl_rxq {
 	int id;
 	void *bd;
 	dma_addr_t bd_dma;
-	union {
-		void *used_bd;
-		__le32 *bd_32;
-		struct iwl_rx_completion_desc *cd;
-	};
+	void *used_bd;
 	dma_addr_t used_bd_dma;
 	u32 read;
 	u32 write;
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/rx.c b/drivers/net/wireless/intel/iwlwifi/pcie/rx.c
index e4016c97d5ab..331c1a059183 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/rx.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/rx.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
 /*
- * Copyright (C) 2003-2014, 2018-2021 Intel Corporation
+ * Copyright (C) 2003-2014, 2018-2022 Intel Corporation
  * Copyright (C) 2013-2015 Intel Mobile Communications GmbH
  * Copyright (C) 2016-2017 Intel Deutschland GmbH
  */
@@ -652,23 +652,30 @@ void iwl_pcie_rx_allocator_work(struct work_struct *data)
 	iwl_pcie_rx_allocator(trans_pcie->trans);
 }
 
-static int iwl_pcie_free_bd_size(struct iwl_trans *trans, bool use_rx_td)
+static int iwl_pcie_free_bd_size(struct iwl_trans *trans)
 {
-	struct iwl_rx_transfer_desc *rx_td;
+	if (trans->trans_cfg->device_family >= IWL_DEVICE_FAMILY_AX210)
+		return sizeof(struct iwl_rx_transfer_desc);
 
-	if (use_rx_td)
-		return sizeof(*rx_td);
-	else
-		return trans->trans_cfg->mq_rx_supported ? sizeof(__le64) :
-			sizeof(__le32);
+	return trans->trans_cfg->mq_rx_supported ?
+			sizeof(__le64) : sizeof(__le32);
+}
+
+static int iwl_pcie_used_bd_size(struct iwl_trans *trans)
+{
+	if (trans->trans_cfg->device_family >= IWL_DEVICE_FAMILY_BZ)
+		return sizeof(struct iwl_rx_completion_desc_bz);
+
+	if (trans->trans_cfg->device_family >= IWL_DEVICE_FAMILY_AX210)
+		return sizeof(struct iwl_rx_completion_desc);
+
+	return sizeof(__le32);
 }
 
 static void iwl_pcie_free_rxq_dma(struct iwl_trans *trans,
 				  struct iwl_rxq *rxq)
 {
-	bool use_rx_td = (trans->trans_cfg->device_family >=
-			  IWL_DEVICE_FAMILY_AX210);
-	int free_size = iwl_pcie_free_bd_size(trans, use_rx_td);
+	int free_size = iwl_pcie_free_bd_size(trans);
 
 	if (rxq->bd)
 		dma_free_coherent(trans->dev,
@@ -682,8 +689,8 @@ static void iwl_pcie_free_rxq_dma(struct iwl_trans *trans,
 
 	if (rxq->used_bd)
 		dma_free_coherent(trans->dev,
-				  (use_rx_td ? sizeof(*rxq->cd) :
-				   sizeof(__le32)) * rxq->queue_size,
+				  iwl_pcie_used_bd_size(trans) *
+					rxq->queue_size,
 				  rxq->used_bd, rxq->used_bd_dma);
 	rxq->used_bd_dma = 0;
 	rxq->used_bd = NULL;
@@ -707,7 +714,7 @@ static int iwl_pcie_alloc_rxq_dma(struct iwl_trans *trans,
 	else
 		rxq->queue_size = RX_QUEUE_SIZE;
 
-	free_size = iwl_pcie_free_bd_size(trans, use_rx_td);
+	free_size = iwl_pcie_free_bd_size(trans);
 
 	/*
 	 * Allocate the circular buffer of Read Buffer Descriptors
@@ -720,7 +727,8 @@ static int iwl_pcie_alloc_rxq_dma(struct iwl_trans *trans,
 
 	if (trans->trans_cfg->mq_rx_supported) {
 		rxq->used_bd = dma_alloc_coherent(dev,
-						  (use_rx_td ? sizeof(*rxq->cd) : sizeof(__le32)) * rxq->queue_size,
+						  iwl_pcie_used_bd_size(trans) *
+							rxq->queue_size,
 						  &rxq->used_bd_dma,
 						  GFP_KERNEL);
 		if (!rxq->used_bd)
@@ -1417,6 +1425,7 @@ static struct iwl_rx_mem_buffer *iwl_pcie_get_rxb(struct iwl_trans *trans,
 	u16 vid;
 
 	BUILD_BUG_ON(sizeof(struct iwl_rx_completion_desc) != 32);
+	BUILD_BUG_ON(sizeof(struct iwl_rx_completion_desc_bz) != 4);
 
 	if (!trans->trans_cfg->mq_rx_supported) {
 		rxb = rxq->queue[i];
@@ -1424,11 +1433,20 @@ static struct iwl_rx_mem_buffer *iwl_pcie_get_rxb(struct iwl_trans *trans,
 		return rxb;
 	}
 
-	if (trans->trans_cfg->device_family >= IWL_DEVICE_FAMILY_AX210) {
-		vid = le16_to_cpu(rxq->cd[i].rbid);
-		*join = rxq->cd[i].flags & IWL_RX_CD_FLAGS_FRAGMENTED;
+	if (trans->trans_cfg->device_family >= IWL_DEVICE_FAMILY_BZ) {
+		struct iwl_rx_completion_desc_bz *cd = rxq->used_bd;
+
+		vid = le16_to_cpu(cd[i].rbid);
+		*join = cd[i].flags & IWL_RX_CD_FLAGS_FRAGMENTED;
+	} else if (trans->trans_cfg->device_family >= IWL_DEVICE_FAMILY_AX210) {
+		struct iwl_rx_completion_desc *cd = rxq->used_bd;
+
+		vid = le16_to_cpu(cd[i].rbid);
+		*join = cd[i].flags & IWL_RX_CD_FLAGS_FRAGMENTED;
 	} else {
-		vid = le32_to_cpu(rxq->bd_32[i]) & 0x0FFF; /* 12-bit VID */
+		__le32 *cd = rxq->used_bd;
+
+		vid = le32_to_cpu(cd[i]) & 0x0FFF; /* 12-bit VID */
 	}
 
 	if (!vid || vid > RX_POOL_SIZE(trans_pcie->num_rx_bufs))
-- 
2.34.1

