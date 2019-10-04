Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9F8EFCBB64
	for <lists+linux-wireless@lfdr.de>; Fri,  4 Oct 2019 15:14:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388323AbfJDNO1 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 4 Oct 2019 09:14:27 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:46600 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2388332AbfJDNO1 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 4 Oct 2019 09:14:27 -0400
Received: from [91.156.6.193] (helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.92)
        (envelope-from <luca@coelho.fi>)
        id 1iGNPd-0000l2-22; Fri, 04 Oct 2019 16:14:25 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Fri,  4 Oct 2019 16:14:14 +0300
Message-Id: <20191004131414.27372-9-luca@coelho.fi>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191004131414.27372-1-luca@coelho.fi>
References: <20191004131414.27372-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00
        autolearn=ham autolearn_force=no version=3.4.2
Subject: [PATCH 8/8] iwlwifi: pcie: fix memory leaks in iwl_pcie_ctxt_info_gen3_init
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Navid Emamdoost <navid.emamdoost@gmail.com>

In iwl_pcie_ctxt_info_gen3_init there are cases that the allocated dma
memory is leaked in case of error.

DMA memories prph_scratch, prph_info, and ctxt_info_gen3 are allocated
and initialized to be later assigned to trans_pcie. But in any error case
before such assignment the allocated memories should be released.

First of such error cases happens when iwl_pcie_init_fw_sec fails.
Current implementation correctly releases prph_scratch. But in two
sunsequent error cases where dma_alloc_coherent may fail, such
releases are missing.

This commit adds release for prph_scratch when allocation for
prph_info fails, and adds releases for prph_scratch and prph_info when
allocation for ctxt_info_gen3 fails.

Fixes: 2ee824026288 ("iwlwifi: pcie: support context information for 22560 devices")
Signed-off-by: Navid Emamdoost <navid.emamdoost@gmail.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 .../intel/iwlwifi/pcie/ctxt-info-gen3.c       | 36 +++++++++++++------
 1 file changed, 25 insertions(+), 11 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/ctxt-info-gen3.c b/drivers/net/wireless/intel/iwlwifi/pcie/ctxt-info-gen3.c
index 75fa8a6aafee..74980382e64c 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/ctxt-info-gen3.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/ctxt-info-gen3.c
@@ -107,13 +107,9 @@ int iwl_pcie_ctxt_info_gen3_init(struct iwl_trans *trans,
 
 	/* allocate ucode sections in dram and set addresses */
 	ret = iwl_pcie_init_fw_sec(trans, fw, &prph_scratch->dram);
-	if (ret) {
-		dma_free_coherent(trans->dev,
-				  sizeof(*prph_scratch),
-				  prph_scratch,
-				  trans_pcie->prph_scratch_dma_addr);
-		return ret;
-	}
+	if (ret)
+		goto err_free_prph_scratch;
+
 
 	/* Allocate prph information
 	 * currently we don't assign to the prph info anything, but it would get
@@ -121,16 +117,20 @@ int iwl_pcie_ctxt_info_gen3_init(struct iwl_trans *trans,
 	prph_info = dma_alloc_coherent(trans->dev, sizeof(*prph_info),
 				       &trans_pcie->prph_info_dma_addr,
 				       GFP_KERNEL);
-	if (!prph_info)
-		return -ENOMEM;
+	if (!prph_info) {
+		ret = -ENOMEM;
+		goto err_free_prph_scratch;
+	}
 
 	/* Allocate context info */
 	ctxt_info_gen3 = dma_alloc_coherent(trans->dev,
 					    sizeof(*ctxt_info_gen3),
 					    &trans_pcie->ctxt_info_dma_addr,
 					    GFP_KERNEL);
-	if (!ctxt_info_gen3)
-		return -ENOMEM;
+	if (!ctxt_info_gen3) {
+		ret = -ENOMEM;
+		goto err_free_prph_info;
+	}
 
 	ctxt_info_gen3->prph_info_base_addr =
 		cpu_to_le64(trans_pcie->prph_info_dma_addr);
@@ -186,6 +186,20 @@ int iwl_pcie_ctxt_info_gen3_init(struct iwl_trans *trans,
 		iwl_set_bit(trans, CSR_GP_CNTRL, CSR_AUTO_FUNC_INIT);
 
 	return 0;
+
+err_free_prph_info:
+	dma_free_coherent(trans->dev,
+			  sizeof(*prph_info),
+			prph_info,
+			trans_pcie->prph_info_dma_addr);
+
+err_free_prph_scratch:
+	dma_free_coherent(trans->dev,
+			  sizeof(*prph_scratch),
+			prph_scratch,
+			trans_pcie->prph_scratch_dma_addr);
+	return ret;
+
 }
 
 void iwl_pcie_ctxt_info_gen3_free(struct iwl_trans *trans)
-- 
2.23.0

