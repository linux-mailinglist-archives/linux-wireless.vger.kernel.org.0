Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01B231ADAE3
	for <lists+linux-wireless@lfdr.de>; Fri, 17 Apr 2020 12:22:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729084AbgDQKV7 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 17 Apr 2020 06:21:59 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:56610 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728346AbgDQKV6 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 17 Apr 2020 06:21:58 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <luca@coelho.fi>)
        id 1jPO8B-000Kba-Bo; Fri, 17 Apr 2020 13:21:55 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Fri, 17 Apr 2020 13:21:40 +0300
Message-Id: <iwlwifi.20200417131727.a4858aa0441b.I0e70e4a5493fe6b8db6390f9349ff0e7888ab240@changeid>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200417102142.2173014-1-luca@coelho.fi>
References: <20200417102142.2173014-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.4
Subject: [PATCH 08/10] iwlwifi: pcie: gen2: minor code cleanups in byte table update
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

One line should be indented less, otherwise it looks like it
belongs into the parentheses, which clearly it doesn't; also
some variables can move into their respective if branches.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/pcie/tx-gen2.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/tx-gen2.c b/drivers/net/wireless/intel/iwlwifi/pcie/tx-gen2.c
index 86fc00167817..a30f6b080201 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/tx-gen2.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/tx-gen2.c
@@ -90,9 +90,7 @@ static void iwl_pcie_gen2_update_byte_tbl(struct iwl_trans_pcie *trans_pcie,
 					  struct iwl_txq *txq, u16 byte_cnt,
 					  int num_tbs)
 {
-	struct iwlagn_scd_bc_tbl *scd_bc_tbl = txq->bc_tbl.addr;
 	struct iwl_trans *trans = iwl_trans_pcie_get_trans(trans_pcie);
-	struct iwl_gen3_bc_tbl *scd_bc_tbl_gen3 = txq->bc_tbl.addr;
 	int idx = iwl_pcie_get_cmd_index(txq, txq->write_ptr);
 	u8 filled_tfd_size, num_fetch_chunks;
 	u16 len = byte_cnt;
@@ -102,7 +100,7 @@ static void iwl_pcie_gen2_update_byte_tbl(struct iwl_trans_pcie *trans_pcie,
 		return;
 
 	filled_tfd_size = offsetof(struct iwl_tfh_tfd, tbs) +
-				   num_tbs * sizeof(struct iwl_tfh_tb);
+			  num_tbs * sizeof(struct iwl_tfh_tb);
 	/*
 	 * filled_tfd_size contains the number of filled bytes in the TFD.
 	 * Dividing it by 64 will give the number of chunks to fetch
@@ -114,12 +112,16 @@ static void iwl_pcie_gen2_update_byte_tbl(struct iwl_trans_pcie *trans_pcie,
 	num_fetch_chunks = DIV_ROUND_UP(filled_tfd_size, 64) - 1;
 
 	if (trans->trans_cfg->device_family >= IWL_DEVICE_FAMILY_AX210) {
+		struct iwl_gen3_bc_tbl *scd_bc_tbl_gen3 = txq->bc_tbl.addr;
+
 		/* Starting from AX210, the HW expects bytes */
 		WARN_ON(trans_pcie->bc_table_dword);
 		WARN_ON(len > 0x3FFF);
 		bc_ent = cpu_to_le16(len | (num_fetch_chunks << 14));
 		scd_bc_tbl_gen3->tfd_offset[idx] = bc_ent;
 	} else {
+		struct iwlagn_scd_bc_tbl *scd_bc_tbl = txq->bc_tbl.addr;
+
 		/* Before AX210, the HW expects DW */
 		WARN_ON(!trans_pcie->bc_table_dword);
 		len = DIV_ROUND_UP(len, 4);
-- 
2.25.1

