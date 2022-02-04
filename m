Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0B424A97AD
	for <lists+linux-wireless@lfdr.de>; Fri,  4 Feb 2022 11:25:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354505AbiBDKZS (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 4 Feb 2022 05:25:18 -0500
Received: from paleale.coelho.fi ([176.9.41.70]:37956 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1352436AbiBDKZS (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 4 Feb 2022 05:25:18 -0500
Received: from 91-156-4-210.elisa-laajakaista.fi ([91.156.4.210] helo=kveik.lan)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.95)
        (envelope-from <luca@coelho.fi>)
        id 1nFvmG-0005zM-94;
        Fri, 04 Feb 2022 12:25:17 +0200
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@kernel.org
Cc:     luca@coelho.fi, linux-wireless@vger.kernel.org
Date:   Fri,  4 Feb 2022 12:25:01 +0200
Message-Id: <iwlwifi.20220204122220.44835d181528.I3e78ba29c13bbeada017fcb2a620f3552c1dfa30@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220204102511.606112-1-luca@coelho.fi>
References: <20220204102511.606112-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.6
Subject: [PATCH 02/12] iwlwifi: yoyo: Avoid using dram data if allocation failed
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Mukesh Sisodiya <mukesh.sisodiya@intel.com>

The config set TLV setting depend on dram allocation
and if allocation failed the data used in config set tlv
should not set this.
Adding the check if dram fragment is available or not.

Signed-off-by: Mukesh Sisodiya <mukesh.sisodiya@intel.com>
Fixes: 1a5daead217c ("iwlwifi: yoyo: support for ROM usniffer")
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/iwl-dbg-tlv.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-dbg-tlv.c b/drivers/net/wireless/intel/iwlwifi/iwl-dbg-tlv.c
index 1e884dc31f46..0cda8ac5024f 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-dbg-tlv.c
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-dbg-tlv.c
@@ -875,11 +875,18 @@ static void iwl_dbg_tlv_apply_config(struct iwl_fw_runtime *fwrt,
 		case IWL_FW_INI_CONFIG_SET_TYPE_DBGC_DRAM_ADDR: {
 			struct iwl_dbgc1_info dram_info = {};
 			struct iwl_dram_data *frags = &fwrt->trans->dbg.fw_mon_ini[1].frags[0];
-			__le64 dram_base_addr = cpu_to_le64(frags->physical);
-			__le32 dram_size = cpu_to_le32(frags->size);
-			u64  dram_addr = le64_to_cpu(dram_base_addr);
+			__le64 dram_base_addr;
+			__le32 dram_size;
+			u64 dram_addr;
 			u32 ret;
 
+			if (!frags)
+				break;
+
+			dram_base_addr = cpu_to_le64(frags->physical);
+			dram_size = cpu_to_le32(frags->size);
+			dram_addr = le64_to_cpu(dram_base_addr);
+
 			IWL_DEBUG_FW(fwrt, "WRT: dram_base_addr 0x%016llx, dram_size 0x%x\n",
 				     dram_base_addr, dram_size);
 			IWL_DEBUG_FW(fwrt, "WRT: config_list->addr_offset: %u\n",
-- 
2.34.1

