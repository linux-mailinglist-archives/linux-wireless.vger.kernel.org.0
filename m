Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 033331AEAB5
	for <lists+linux-wireless@lfdr.de>; Sat, 18 Apr 2020 10:09:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726049AbgDRIJV (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 18 Apr 2020 04:09:21 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:56740 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725856AbgDRIJS (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 18 Apr 2020 04:09:18 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <luca@coelho.fi>)
        id 1jPiXK-000L3r-8F; Sat, 18 Apr 2020 11:09:14 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Sat, 18 Apr 2020 11:08:46 +0300
Message-Id: <iwlwifi.20200418110539.818a06457888.Ib4f55280cd14d7edab37f2992b381c9b6ca4cd7a@changeid>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200418080857.2232093-1-luca@coelho.fi>
References: <20200418080857.2232093-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.4
Subject: [PATCH 01/12] iwlwifi: pcie: move iwl_pcie_ctxt_info_alloc_dma() to user
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

There's no need for this to be an inline in the header file,
only the context-info.c file ever uses it. Move it there.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 .../net/wireless/intel/iwlwifi/pcie/ctxt-info.c  | 15 +++++++++++++++
 .../net/wireless/intel/iwlwifi/pcie/internal.h   | 16 ----------------
 2 files changed, 15 insertions(+), 16 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/ctxt-info.c b/drivers/net/wireless/intel/iwlwifi/pcie/ctxt-info.c
index acd01d86f101..b65405009d02 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/ctxt-info.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/ctxt-info.c
@@ -93,6 +93,21 @@ static void *iwl_pcie_ctxt_info_dma_alloc_coherent(struct iwl_trans *trans,
 	return _iwl_pcie_ctxt_info_dma_alloc_coherent(trans, size, phys, 0);
 }
 
+static int iwl_pcie_ctxt_info_alloc_dma(struct iwl_trans *trans,
+					const struct fw_desc *sec,
+					struct iwl_dram_data *dram)
+{
+	dram->block = iwl_pcie_ctxt_info_dma_alloc_coherent(trans, sec->len,
+							    &dram->physical);
+	if (!dram->block)
+		return -ENOMEM;
+
+	dram->size = sec->len;
+	memcpy(dram->block, sec->data, sec->len);
+
+	return 0;
+}
+
 void iwl_pcie_ctxt_info_free_paging(struct iwl_trans *trans)
 {
 	struct iwl_self_init_dram *dram = &trans->init_dram;
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/internal.h b/drivers/net/wireless/intel/iwlwifi/pcie/internal.h
index 595e6873d56e..abe649af689c 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/internal.h
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/internal.h
@@ -792,22 +792,6 @@ static inline int iwl_pcie_get_num_sections(const struct fw_img *fw,
 	return i;
 }
 
-static inline int iwl_pcie_ctxt_info_alloc_dma(struct iwl_trans *trans,
-					       const struct fw_desc *sec,
-					       struct iwl_dram_data *dram)
-{
-	dram->block = dma_alloc_coherent(trans->dev, sec->len,
-					 &dram->physical,
-					 GFP_KERNEL);
-	if (!dram->block)
-		return -ENOMEM;
-
-	dram->size = sec->len;
-	memcpy(dram->block, sec->data, sec->len);
-
-	return 0;
-}
-
 static inline void iwl_pcie_ctxt_info_free_fw_img(struct iwl_trans *trans)
 {
 	struct iwl_self_init_dram *dram = &trans->init_dram;
-- 
2.25.1

