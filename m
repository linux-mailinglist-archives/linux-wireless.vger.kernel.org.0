Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CEF323132A6
	for <lists+linux-wireless@lfdr.de>; Mon,  8 Feb 2021 13:45:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232504AbhBHMoO (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 8 Feb 2021 07:44:14 -0500
Received: from paleale.coelho.fi ([176.9.41.70]:44404 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S232430AbhBHMmF (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 8 Feb 2021 07:42:05 -0500
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <luca@coelho.fi>)
        id 1l95qM-0047MN-Ea; Mon, 08 Feb 2021 14:40:42 +0200
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Mon,  8 Feb 2021 14:40:32 +0200
Message-Id: <iwlwifi.20210208143712.9d0bf6426109.I630379c504644700322f57b259383ae0af8d1975@changeid>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210208124034.1933780-1-luca@coelho.fi>
References: <20210208124034.1933780-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.4
Subject: [PATCH 10/12] iwlwifi: pcie: NULLify pointers after free
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Emmanuel Grumbach <emmanuel.grumbach@intel.com>

Remember that those pointers have been freed by setting them
to NULL. Otherwise, we'd keep rxq pointing to random memory
which would prevent us from trying to re-allocate the Rx
resources if we call rx_alloc again.

Also, propagate the allocation failure to the caller of
iwl_pcie_nic_init so that we won't go further in the
start flow.

Signed-off-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/pcie/rx.c    | 3 +++
 drivers/net/wireless/intel/iwlwifi/pcie/trans.c | 8 ++++++--
 2 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/rx.c b/drivers/net/wireless/intel/iwlwifi/pcie/rx.c
index 407809c7e958..664481ca58c9 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/rx.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/rx.c
@@ -834,8 +834,11 @@ static int iwl_pcie_rx_alloc(struct iwl_trans *trans)
 		trans_pcie->base_rb_stts_dma = 0;
 	}
 	kfree(trans_pcie->rx_pool);
+	trans_pcie->rx_pool = NULL;
 	kfree(trans_pcie->global_table);
+	trans_pcie->global_table = NULL;
 	kfree(trans_pcie->rxq);
+	trans_pcie->rxq = NULL;
 
 	return ret;
 }
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/trans.c b/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
index 54888df3d7f8..88915406eb1e 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
@@ -523,11 +523,15 @@ static int iwl_pcie_nic_init(struct iwl_trans *trans)
 	iwl_op_mode_nic_config(trans->op_mode);
 
 	/* Allocate the RX queue, or reset if it is already allocated */
-	iwl_pcie_rx_init(trans);
+	ret = iwl_pcie_rx_init(trans);
+	if (ret)
+		return ret;
 
 	/* Allocate or reset and init all Tx and Command queues */
-	if (iwl_pcie_tx_init(trans))
+	if (iwl_pcie_tx_init(trans)) {
+		iwl_pcie_rx_free(trans);
 		return -ENOMEM;
+	}
 
 	if (trans->trans_cfg->base_params->shadow_reg_enable) {
 		/* enable shadow regs in HW */
-- 
2.30.0

