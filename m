Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AE17A103772
	for <lists+linux-wireless@lfdr.de>; Wed, 20 Nov 2019 11:27:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728653AbfKTK1A (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 20 Nov 2019 05:27:00 -0500
Received: from paleale.coelho.fi ([176.9.41.70]:58522 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727399AbfKTK07 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 20 Nov 2019 05:26:59 -0500
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.92)
        (envelope-from <luca@coelho.fi>)
        id 1iXNCL-0001kS-Rl; Wed, 20 Nov 2019 12:26:58 +0200
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Wed, 20 Nov 2019 12:26:41 +0200
Message-Id: <20191120102650.514376-4-luca@coelho.fi>
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
Subject: [PATCH 03/12] iwlwifi: pcie: make some RX functions static
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

These aren't used outside the rx.c file, so make them static.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/pcie/internal.h | 2 --
 drivers/net/wireless/intel/iwlwifi/pcie/rx.c       | 4 ++--
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/internal.h b/drivers/net/wireless/intel/iwlwifi/pcie/internal.h
index 3da2c7e38ffa..a091690f6c79 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/internal.h
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/internal.h
@@ -646,7 +646,6 @@ void iwl_trans_pcie_free(struct iwl_trans *trans);
 /*****************************************************
 * RX
 ******************************************************/
-int _iwl_pcie_rx_init(struct iwl_trans *trans);
 int iwl_pcie_rx_init(struct iwl_trans *trans);
 int iwl_pcie_gen2_rx_init(struct iwl_trans *trans);
 irqreturn_t iwl_pcie_msix_isr(int irq, void *data);
@@ -660,7 +659,6 @@ void iwl_pcie_rx_init_rxb_lists(struct iwl_rxq *rxq);
 int iwl_pcie_dummy_napi_poll(struct napi_struct *napi, int budget);
 void iwl_pcie_rxq_alloc_rbs(struct iwl_trans *trans, gfp_t priority,
 			    struct iwl_rxq *rxq);
-int iwl_pcie_rx_alloc(struct iwl_trans *trans);
 
 /*****************************************************
 * ICT - interrupt handling
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/rx.c b/drivers/net/wireless/intel/iwlwifi/pcie/rx.c
index 4bba6b8a863c..7f9cc4c84c18 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/rx.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/rx.c
@@ -793,7 +793,7 @@ static int iwl_pcie_alloc_rxq_dma(struct iwl_trans *trans,
 	return -ENOMEM;
 }
 
-int iwl_pcie_rx_alloc(struct iwl_trans *trans)
+static int iwl_pcie_rx_alloc(struct iwl_trans *trans)
 {
 	struct iwl_trans_pcie *trans_pcie = IWL_TRANS_GET_PCIE_TRANS(trans);
 	struct iwl_rb_allocator *rba = &trans_pcie->rba;
@@ -1024,7 +1024,7 @@ int iwl_pcie_dummy_napi_poll(struct napi_struct *napi, int budget)
 	return 0;
 }
 
-int _iwl_pcie_rx_init(struct iwl_trans *trans)
+static int _iwl_pcie_rx_init(struct iwl_trans *trans)
 {
 	struct iwl_trans_pcie *trans_pcie = IWL_TRANS_GET_PCIE_TRANS(trans);
 	struct iwl_rxq *def_rxq;
-- 
2.24.0

