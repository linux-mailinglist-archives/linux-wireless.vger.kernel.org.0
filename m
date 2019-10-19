Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9B50CDD7B0
	for <lists+linux-wireless@lfdr.de>; Sat, 19 Oct 2019 11:39:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726385AbfJSJjO (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 19 Oct 2019 05:39:14 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:50418 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725828AbfJSJjO (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 19 Oct 2019 05:39:14 -0400
Received: from [91.156.6.193] (helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.92)
        (envelope-from <luca@coelho.fi>)
        id 1iLlCa-0002fy-5R; Sat, 19 Oct 2019 12:39:12 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Sat, 19 Oct 2019 12:38:55 +0300
Message-Id: <20191019093902.29823-4-luca@coelho.fi>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191019093902.29823-1-luca@coelho.fi>
References: <20191019093902.29823-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.2
Subject: [PATCH 05/12] iwlwifi: pcie: make iwl_pcie_gen2_update_byte_tbl static
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Emmanuel Grumbach <emmanuel.grumbach@intel.com>

It is called within tx-gen2.c only.

Signed-off-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/pcie/internal.h | 3 ---
 drivers/net/wireless/intel/iwlwifi/pcie/tx-gen2.c  | 6 +++---
 2 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/internal.h b/drivers/net/wireless/intel/iwlwifi/pcie/internal.h
index 1047d48beaa5..fcef2806ebb1 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/internal.h
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/internal.h
@@ -702,9 +702,6 @@ void iwl_trans_pcie_reclaim(struct iwl_trans *trans, int txq_id, int ssn,
 			    struct sk_buff_head *skbs);
 void iwl_trans_pcie_set_q_ptrs(struct iwl_trans *trans, int txq_id, int ptr);
 void iwl_trans_pcie_tx_reset(struct iwl_trans *trans);
-void iwl_pcie_gen2_update_byte_tbl(struct iwl_trans_pcie *trans_pcie,
-				   struct iwl_txq *txq, u16 byte_cnt,
-				   int num_tbs);
 
 static inline u16 iwl_pcie_tfd_tb_get_len(struct iwl_trans *trans, void *_tfd,
 					  u8 idx)
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/tx-gen2.c b/drivers/net/wireless/intel/iwlwifi/pcie/tx-gen2.c
index 8894027429d6..1c69a2ddd7c7 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/tx-gen2.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/tx-gen2.c
@@ -86,9 +86,9 @@ void iwl_pcie_gen2_tx_stop(struct iwl_trans *trans)
 /*
  * iwl_pcie_txq_update_byte_tbl - Set up entry in Tx byte-count array
  */
-void iwl_pcie_gen2_update_byte_tbl(struct iwl_trans_pcie *trans_pcie,
-				   struct iwl_txq *txq, u16 byte_cnt,
-				   int num_tbs)
+static void iwl_pcie_gen2_update_byte_tbl(struct iwl_trans_pcie *trans_pcie,
+					  struct iwl_txq *txq, u16 byte_cnt,
+					  int num_tbs)
 {
 	struct iwlagn_scd_bc_tbl *scd_bc_tbl = txq->bc_tbl.addr;
 	struct iwl_trans *trans = iwl_trans_pcie_get_trans(trans_pcie);
-- 
2.23.0

