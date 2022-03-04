Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D190F4CD346
	for <lists+linux-wireless@lfdr.de>; Fri,  4 Mar 2022 12:21:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239344AbiCDLWb (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 4 Mar 2022 06:22:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239322AbiCDLWa (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 4 Mar 2022 06:22:30 -0500
Received: from farmhouse.coelho.fi (paleale.coelho.fi [176.9.41.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB0EE137776
        for <linux-wireless@vger.kernel.org>; Fri,  4 Mar 2022 03:21:43 -0800 (PST)
Received: from 91-156-4-241.elisa-laajakaista.fi ([91.156.4.241] helo=kveik.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.95)
        (envelope-from <luca@coelho.fi>)
        id 1nQ60C-000QSW-Ne;
        Fri, 04 Mar 2022 13:21:42 +0200
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@kernel.org
Cc:     luca@coelho.fi, linux-wireless@vger.kernel.org
Date:   Fri,  4 Mar 2022 13:21:23 +0200
Message-Id: <iwlwifi.20220304131517.5b70e5ba9a41.I502f9b6179b97b163992729edd2b3c5c4ca9e311@changeid>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220304112129.219513-1-luca@coelho.fi>
References: <20220304112129.219513-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,KHOP_HELO_FCRDNS,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
Subject: [PATCH 07/13] iwlwifi: yoyo: dump IMR DRAM only for HW and FW error
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Mukesh Sisodiya <mukesh.sisodiya@intel.com>

Support debug collection of the platform IMR memory region
only for HW and FW error. This region needs to be collected
as the last region.

Signed-off-by: Mukesh Sisodiya <mukesh.sisodiya@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/fw/dbg.c | 25 +++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/dbg.c b/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
index 108392234529..53f0fe77aa10 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
@@ -2430,6 +2430,9 @@ static u32 iwl_dump_ini_trigger(struct iwl_fw_runtime *fwrt,
 	struct iwl_dump_ini_region_data reg_data = {
 		.dump_data = dump_data,
 	};
+	struct iwl_dump_ini_region_data imr_reg_data = {
+		.dump_data = dump_data,
+	};
 	int i;
 	u32 size = 0;
 	u64 regions_mask = le64_to_cpu(trigger->regions_mask) &
@@ -2465,10 +2468,32 @@ static u32 iwl_dump_ini_trigger(struct iwl_fw_runtime *fwrt,
 				 tp_id);
 			continue;
 		}
+		/*
+		 * DRAM_IMR can be collected only for FW/HW error timepoint
+		 * when fw is not alive. In addition, it must be collected
+		 * lastly as it overwrites SRAM that can possibly contain
+		 * debug data which also need to be collected.
+		 */
+		if (reg_type == IWL_FW_INI_REGION_DRAM_IMR) {
+			if (tp_id == IWL_FW_INI_TIME_POINT_FW_ASSERT ||
+			    tp_id == IWL_FW_INI_TIME_POINT_FW_HW_ERROR)
+				imr_reg_data.reg_tlv = fwrt->trans->dbg.active_regions[i];
+			else
+				IWL_INFO(fwrt,
+					 "WRT: trying to collect DRAM_IMR at time point: %d, skipping\n",
+					 tp_id);
+		/* continue to next region */
+			continue;
+		}
+
 
 		size += iwl_dump_ini_mem(fwrt, list, &reg_data,
 					 &iwl_dump_ini_region_ops[reg_type]);
 	}
+	/* collect DRAM_IMR region in the last */
+	if (imr_reg_data.reg_tlv)
+		size += iwl_dump_ini_mem(fwrt, list, &reg_data,
+					 &iwl_dump_ini_region_ops[IWL_FW_INI_REGION_DRAM_IMR]);
 
 	if (size)
 		size += iwl_dump_ini_info(fwrt, trigger, list);
-- 
2.35.1

