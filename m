Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9B394A3582
	for <lists+linux-wireless@lfdr.de>; Sun, 30 Jan 2022 10:53:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354546AbiA3JxQ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 30 Jan 2022 04:53:16 -0500
Received: from paleale.coelho.fi ([176.9.41.70]:37908 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1354538AbiA3JxP (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 30 Jan 2022 04:53:15 -0500
Received: from 91-156-4-210.elisa-laajakaista.fi ([91.156.4.210] helo=kveik.lan)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.95)
        (envelope-from <luca@coelho.fi>)
        id 1nE6tU-0003JO-Nb;
        Sun, 30 Jan 2022 11:53:13 +0200
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@kernel.org
Cc:     luca@coelho.fi, linux-wireless@vger.kernel.org
Date:   Sun, 30 Jan 2022 11:53:01 +0200
Message-Id: <iwlwifi.20220130115024.9f2c282a3104.If6b868c96c0d089579ca72fd270387de81359d5b@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220130095306.790573-1-luca@coelho.fi>
References: <20220130095306.790573-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.6
Subject: [PATCH 07/12] iwlwifi: dbg-tlv: clean up iwl_dbg_tlv_update_drams()
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

This function puts a fairly large structure unnecessarily
on the stack, and also has a few other very strange things,
clean it up a bit.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 .../net/wireless/intel/iwlwifi/iwl-dbg-tlv.c  | 29 ++++++++++++-------
 1 file changed, 18 insertions(+), 11 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-dbg-tlv.c b/drivers/net/wireless/intel/iwlwifi/iwl-dbg-tlv.c
index 9346cf92322e..5a60aab662d6 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-dbg-tlv.c
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-dbg-tlv.c
@@ -769,33 +769,40 @@ static int iwl_dbg_tlv_update_dram(struct iwl_fw_runtime *fwrt,
 
 static void iwl_dbg_tlv_update_drams(struct iwl_fw_runtime *fwrt)
 {
-	int ret, i, dram_alloc = 0;
-	struct iwl_dram_info dram_info;
+	int ret, i;
+	bool dram_alloc = false;
 	struct iwl_dram_data *frags =
 		&fwrt->trans->dbg.fw_mon_ini[IWL_FW_INI_ALLOCATION_ID_DBGC1].frags[0];
+	struct iwl_dram_info *dram_info;
+
+	if (!frags || !frags->block)
+		return;
+
+	dram_info = frags->block;
 
 	if (!fw_has_capa(&fwrt->fw->ucode_capa,
 			 IWL_UCODE_TLV_CAPA_DRAM_FRAG_SUPPORT))
 		return;
 
-	dram_info.first_word = cpu_to_le32(DRAM_INFO_FIRST_MAGIC_WORD);
-	dram_info.second_word = cpu_to_le32(DRAM_INFO_SECOND_MAGIC_WORD);
+	dram_info->first_word = cpu_to_le32(DRAM_INFO_FIRST_MAGIC_WORD);
+	dram_info->second_word = cpu_to_le32(DRAM_INFO_SECOND_MAGIC_WORD);
 
 	for (i = IWL_FW_INI_ALLOCATION_ID_DBGC1;
 	     i <= IWL_FW_INI_ALLOCATION_ID_DBGC3; i++) {
-		ret = iwl_dbg_tlv_update_dram(fwrt, i, &dram_info);
+		ret = iwl_dbg_tlv_update_dram(fwrt, i, dram_info);
 		if (!ret)
-			dram_alloc++;
+			dram_alloc = true;
 		else
 			IWL_WARN(fwrt,
 				 "WRT: Failed to set DRAM buffer for alloc id %d, ret=%d\n",
 				 i, ret);
 	}
-	if (dram_alloc) {
-		memcpy(frags->block, &dram_info, sizeof(dram_info));
-		IWL_DEBUG_FW(fwrt, "block data after  %016x\n",
-			     *((int *)fwrt->trans->dbg.fw_mon_ini[1].frags[0].block));
-	}
+
+	if (dram_alloc)
+		IWL_DEBUG_FW(fwrt, "block data after  %08x\n",
+			     dram_info->first_word);
+	else
+		memset(frags->block, 0, sizeof(*dram_info));
 }
 
 static void iwl_dbg_tlv_send_hcmds(struct iwl_fw_runtime *fwrt,
-- 
2.34.1

