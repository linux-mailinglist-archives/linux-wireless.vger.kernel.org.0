Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6901D3BCDB0
	for <lists+linux-wireless@lfdr.de>; Tue,  6 Jul 2021 13:21:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233837AbhGFLWs (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 6 Jul 2021 07:22:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:55498 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233411AbhGFLUy (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 6 Jul 2021 07:20:54 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id EC40A61C43;
        Tue,  6 Jul 2021 11:17:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625570255;
        bh=IVksoe3Tgd8OMjyg+NmC5JQaVrxrvAgCWWo0M5unzU4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=K8vSRwZh7H3MdXbUzYguNvQxnNpaOOrmZWempf1Zue7hGs0WkGxZzvP93zVP/lKT+
         1muV8ZXYkXlnj3OZdDc6zqLydCRgR/rilRdlFLJx69NkcKvtvrWb3kOrbJCbT0ZhU2
         FaOFY8qoSfPac8r5AUTRU+aIMDfH0ycMueiyU+MkW3Jn6DhHG4P7AS4/cDZBKkVQi1
         u0YkNBw3EwX0WYgOJ4APd1BsDudaJgT7BXPsYar/8qViXsrSgHmTCuSlbqc326dX42
         NVVdtPBe50tu76SGMq0tL+v88usCerULsA/pUPf0ov/W9i9ZVYdGcnVVWfnDPT2kBM
         rSYtfcm29tJsg==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Johannes Berg <johannes.berg@intel.com>,
        Luca Coelho <luciano.coelho@intel.com>,
        Sasha Levin <sashal@kernel.org>,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 5.13 153/189] iwlwifi: pcie: free IML DMA memory allocation
Date:   Tue,  6 Jul 2021 07:13:33 -0400
Message-Id: <20210706111409.2058071-153-sashal@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210706111409.2058071-1-sashal@kernel.org>
References: <20210706111409.2058071-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

[ Upstream commit 310f60f53a86eba680d9bc20a371e13b06a5f903 ]

In the case of gen3 devices with image loader (IML) support,
we were leaking the IML DMA allocation and never freeing it.
Fix that.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
Link: https://lore.kernel.org/r/iwlwifi.20210618105614.07e117dbedb7.I7bb9ebbe0617656986c2a598ea5e827b533bd3b9@changeid
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../wireless/intel/iwlwifi/pcie/ctxt-info-gen3.c  | 15 ++++++++++-----
 .../net/wireless/intel/iwlwifi/pcie/internal.h    |  3 +++
 2 files changed, 13 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/ctxt-info-gen3.c b/drivers/net/wireless/intel/iwlwifi/pcie/ctxt-info-gen3.c
index cecc32e7dbe8..2dbc51daa2f8 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/ctxt-info-gen3.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/ctxt-info-gen3.c
@@ -79,7 +79,6 @@ int iwl_pcie_ctxt_info_gen3_init(struct iwl_trans *trans,
 	struct iwl_prph_scratch *prph_scratch;
 	struct iwl_prph_scratch_ctrl_cfg *prph_sc_ctrl;
 	struct iwl_prph_info *prph_info;
-	void *iml_img;
 	u32 control_flags = 0;
 	int ret;
 	int cmdq_size = max_t(u32, IWL_CMD_QUEUE_SIZE,
@@ -187,14 +186,15 @@ int iwl_pcie_ctxt_info_gen3_init(struct iwl_trans *trans,
 	trans_pcie->prph_scratch = prph_scratch;
 
 	/* Allocate IML */
-	iml_img = dma_alloc_coherent(trans->dev, trans->iml_len,
-				     &trans_pcie->iml_dma_addr, GFP_KERNEL);
-	if (!iml_img) {
+	trans_pcie->iml = dma_alloc_coherent(trans->dev, trans->iml_len,
+					     &trans_pcie->iml_dma_addr,
+					     GFP_KERNEL);
+	if (!trans_pcie->iml) {
 		ret = -ENOMEM;
 		goto err_free_ctxt_info;
 	}
 
-	memcpy(iml_img, trans->iml, trans->iml_len);
+	memcpy(trans_pcie->iml, trans->iml, trans->iml_len);
 
 	iwl_enable_fw_load_int_ctx_info(trans);
 
@@ -243,6 +243,11 @@ void iwl_pcie_ctxt_info_gen3_free(struct iwl_trans *trans)
 	trans_pcie->ctxt_info_dma_addr = 0;
 	trans_pcie->ctxt_info_gen3 = NULL;
 
+	dma_free_coherent(trans->dev, trans->iml_len, trans_pcie->iml,
+			  trans_pcie->iml_dma_addr);
+	trans_pcie->iml_dma_addr = 0;
+	trans_pcie->iml = NULL;
+
 	iwl_pcie_ctxt_info_free_fw_img(trans);
 
 	dma_free_coherent(trans->dev, sizeof(*trans_pcie->prph_scratch),
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/internal.h b/drivers/net/wireless/intel/iwlwifi/pcie/internal.h
index 76a512cd2e5c..3f7cfbf707fd 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/internal.h
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/internal.h
@@ -279,6 +279,8 @@ struct cont_rec {
  *	Context information addresses will be taken from here.
  *	This is driver's local copy for keeping track of size and
  *	count for allocating and freeing the memory.
+ * @iml: image loader image virtual address
+ * @iml_dma_addr: image loader image DMA address
  * @trans: pointer to the generic transport area
  * @scd_base_addr: scheduler sram base address in SRAM
  * @kw: keep warm address
@@ -329,6 +331,7 @@ struct iwl_trans_pcie {
 	};
 	struct iwl_prph_info *prph_info;
 	struct iwl_prph_scratch *prph_scratch;
+	void *iml;
 	dma_addr_t ctxt_info_dma_addr;
 	dma_addr_t prph_info_dma_addr;
 	dma_addr_t prph_scratch_dma_addr;
-- 
2.30.2

