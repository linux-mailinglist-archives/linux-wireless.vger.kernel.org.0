Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2657F193F51
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Mar 2020 13:55:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728264AbgCZMz0 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 26 Mar 2020 08:55:26 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:44222 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728194AbgCZMzZ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 26 Mar 2020 08:55:25 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <luca@coelho.fi>)
        id 1jHS2d-00040Z-3o; Thu, 26 Mar 2020 14:55:23 +0200
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Thu, 26 Mar 2020 14:55:04 +0200
Message-Id: <iwlwifi.20200326145047.c657ccebe978.I69aad2d4904c4f8bb653c61e8781a2e07780054f@changeid>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200326125510.621842-1-luca@coelho.fi>
References: <20200326125510.621842-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.4
Subject: [PATCH 06/12] iwlwifi: yoyo: don't block dumping internal memory when not in SRAM mode
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: rotem saado <rotem.saado@intel.com>

When we have an assert during D3 we want to dump the internal
buffer memory even if are we working in DRAM debug mode.  We should not
block dumping it.

Signed-off-by: Rotem Saado <rotem.saado@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/fw/dbg.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/dbg.c b/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
index d5dda93c3953..1746a0c472a5 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
@@ -1737,13 +1737,7 @@ iwl_dump_ini_mon_smem_get_size(struct iwl_fw_runtime *fwrt,
 			       struct iwl_dump_ini_region_data *reg_data)
 {
 	struct iwl_fw_ini_region_tlv *reg = (void *)reg_data->reg_tlv->data;
-	struct iwl_fw_ini_allocation_tlv *fw_mon_cfg;
-	u32 alloc_id = le32_to_cpu(reg->internal_buffer.alloc_id), size;
-
-	fw_mon_cfg = &fwrt->trans->dbg.fw_mon_cfg[alloc_id];
-	if (le32_to_cpu(fw_mon_cfg->buf_location) !=
-	    IWL_FW_INI_LOCATION_SRAM_PATH)
-		return 0;
+	u32 size;
 
 	size = le32_to_cpu(reg->internal_buffer.size);
 	if (!size)
-- 
2.25.1

