Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7DB1B35B2E0
	for <lists+linux-wireless@lfdr.de>; Sun, 11 Apr 2021 11:47:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235331AbhDKJra (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 11 Apr 2021 05:47:30 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:44462 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S235365AbhDKJr1 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 11 Apr 2021 05:47:27 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=kveik.lan)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94)
        (envelope-from <luca@coelho.fi>)
        id 1lVWft-000Jkq-M2; Sun, 11 Apr 2021 12:46:39 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     luca@coelho.fi, linux-wireless@vger.kernel.org
Date:   Sun, 11 Apr 2021 12:46:26 +0300
Message-Id: <iwlwifi.20210411124417.9d1b61ef53a5.I60b33d5379cf7c12f1de30fc3fd4cefc38220141@changeid>
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
Subject: [PATCH 08/12] iwlwifi: pcie: merge napi_poll_msix functions
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Mordechay Goodstein <mordechay.goodstein@intel.com>

The only difference between iwl_pcie_napi_poll_msix_shared() and
iwl_pcie_napi_poll_msix() is when we have a shared queue and nothing
in the rx queue.  This case doesn't affect CPU performance, so we can
merge the two functions.

Signed-off-by: Mordechay Goodstein <mordechay.goodstein@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/pcie/rx.c | 43 +++++---------------
 1 file changed, 10 insertions(+), 33 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/rx.c b/drivers/net/wireless/intel/iwlwifi/pcie/rx.c
index 0cbc79949982..e4607f943ac3 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/rx.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/rx.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
 /*
- * Copyright (C) 2003-2014, 2018-2020 Intel Corporation
+ * Copyright (C) 2003-2014, 2018-2021 Intel Corporation
  * Copyright (C) 2013-2015 Intel Mobile Communications GmbH
  * Copyright (C) 2016-2017 Intel Deutschland GmbH
  */
@@ -1046,33 +1046,19 @@ static int iwl_pcie_napi_poll_msix(struct napi_struct *napi, int budget)
 	trans = trans_pcie->trans;
 
 	ret = iwl_pcie_rx_handle(trans, rxq->id, budget);
+	IWL_DEBUG_ISR(trans, "[%d] handled %d, budget %d\n", rxq->id, ret,
+		      budget);
 
 	if (ret < budget) {
-		spin_lock(&trans_pcie->irq_lock);
-		iwl_pcie_clear_irq(trans, rxq->id);
-		spin_unlock(&trans_pcie->irq_lock);
-
-		napi_complete_done(&rxq->napi, ret);
-	}
-
-	return ret;
-}
-
-static int iwl_pcie_napi_poll_msix_shared(struct napi_struct *napi, int budget)
-{
-	struct iwl_rxq *rxq = container_of(napi, struct iwl_rxq, napi);
-	struct iwl_trans_pcie *trans_pcie;
-	struct iwl_trans *trans;
-	int ret;
+		int irq_line = rxq->id;
 
-	trans_pcie = container_of(napi->dev, struct iwl_trans_pcie, napi_dev);
-	trans = trans_pcie->trans;
+		/* FIRST_RSS is shared with line 0 */
+		if (trans_pcie->shared_vec_mask & IWL_SHARED_IRQ_FIRST_RSS &&
+		    rxq->id == 1)
+			irq_line = 0;
 
-	ret = iwl_pcie_rx_handle(trans, rxq->id, budget);
-
-	if (ret < budget) {
 		spin_lock(&trans_pcie->irq_lock);
-		iwl_pcie_clear_irq(trans, 0);
+		iwl_pcie_clear_irq(trans, irq_line);
 		spin_unlock(&trans_pcie->irq_lock);
 
 		napi_complete_done(&rxq->napi, ret);
@@ -1134,18 +1120,9 @@ static int _iwl_pcie_rx_init(struct iwl_trans *trans)
 		if (!rxq->napi.poll) {
 			int (*poll)(struct napi_struct *, int) = iwl_pcie_napi_poll;
 
-			if (trans_pcie->msix_enabled) {
+			if (trans_pcie->msix_enabled)
 				poll = iwl_pcie_napi_poll_msix;
 
-				if (trans_pcie->shared_vec_mask & IWL_SHARED_IRQ_NON_RX &&
-				    i == 0)
-					poll = iwl_pcie_napi_poll_msix_shared;
-
-				if (trans_pcie->shared_vec_mask & IWL_SHARED_IRQ_FIRST_RSS &&
-				    i == 1)
-					poll = iwl_pcie_napi_poll_msix_shared;
-			}
-
 			netif_napi_add(&trans_pcie->napi_dev, &rxq->napi,
 				       poll, NAPI_POLL_WEIGHT);
 			napi_enable(&rxq->napi);
-- 
2.31.0

