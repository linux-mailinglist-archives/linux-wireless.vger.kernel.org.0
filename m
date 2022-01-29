Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A60184A2E21
	for <lists+linux-wireless@lfdr.de>; Sat, 29 Jan 2022 12:16:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237554AbiA2LQi (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 29 Jan 2022 06:16:38 -0500
Received: from paleale.coelho.fi ([176.9.41.70]:37890 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S237468AbiA2LQh (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 29 Jan 2022 06:16:37 -0500
Received: from 91-156-4-210.elisa-laajakaista.fi ([91.156.4.210] helo=kveik.lan)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.95)
        (envelope-from <luca@coelho.fi>)
        id 1nDlid-0002ji-3k;
        Sat, 29 Jan 2022 13:16:36 +0200
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@kernel.org
Cc:     luca@coelho.fi, linux-wireless@vger.kernel.org
Date:   Sat, 29 Jan 2022 13:16:21 +0200
Message-Id: <iwlwifi.20220129105618.209f3078bc74.I463530bd2f40daedb39f6d9df987bb7cee209033@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220129111622.678447-1-luca@coelho.fi>
References: <20220129111622.678447-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.6
Subject: [PATCH 11/12] iwlwifi: yoyo: remove DBGI_SRAM address reset writing
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Rotem Saado <rotem.saado@intel.com>

Due to preg protection we cannot write to this register
while FW is running (when FW in Halt it is ok).
since we have some cases that we need to dump this
region while FW is running remove this writing from DRV.
FW will do this writing.

Signed-off-by: Rotem Saado <rotem.saado@intel.com>
Fixes: 89639e06d0f3 ("iwlwifi: yoyo: support for new DBGI_SRAM region")
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/fw/dbg.c   | 2 --
 drivers/net/wireless/intel/iwlwifi/iwl-prph.h | 2 --
 2 files changed, 4 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/dbg.c b/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
index d3e1c89d9be7..6e090f10b8eb 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
@@ -1561,8 +1561,6 @@ iwl_dump_ini_dbgi_sram_iter(struct iwl_fw_runtime *fwrt,
 		return -EBUSY;
 
 	range->range_data_size = reg->dev_addr.size;
-	iwl_write_prph_no_grab(fwrt->trans, DBGI_SRAM_TARGET_ACCESS_CFG,
-			       DBGI_SRAM_TARGET_ACCESS_CFG_RESET_ADDRESS_MSK);
 	for (i = 0; i < (le32_to_cpu(reg->dev_addr.size) / 4); i++) {
 		prph_data = iwl_read_prph_no_grab(fwrt->trans, (i % 2) ?
 					  DBGI_SRAM_TARGET_ACCESS_RDATA_MSB :
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-prph.h b/drivers/net/wireless/intel/iwlwifi/iwl-prph.h
index 186e22c4e6c4..8d37a7e8fa6e 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-prph.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-prph.h
@@ -354,8 +354,6 @@
 #define WFPM_GP2			0xA030B4
 
 /* DBGI SRAM Register details */
-#define DBGI_SRAM_TARGET_ACCESS_CFG			0x00A2E14C
-#define DBGI_SRAM_TARGET_ACCESS_CFG_RESET_ADDRESS_MSK	0x10000
 #define DBGI_SRAM_TARGET_ACCESS_RDATA_LSB		0x00A2E154
 #define DBGI_SRAM_TARGET_ACCESS_RDATA_MSB		0x00A2E158
 #define DBGI_SRAM_FIFO_POINTERS				0x00A2E148
-- 
2.34.1

