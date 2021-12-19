Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBDFB47A065
	for <lists+linux-wireless@lfdr.de>; Sun, 19 Dec 2021 12:28:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235666AbhLSL2y (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 19 Dec 2021 06:28:54 -0500
Received: from paleale.coelho.fi ([176.9.41.70]:51472 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S235650AbhLSL2x (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 19 Dec 2021 06:28:53 -0500
Received: from 91-156-5-105.elisa-laajakaista.fi ([91.156.5.105] helo=kveik.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <luca@coelho.fi>)
        id 1myuN1-001O73-7Y; Sun, 19 Dec 2021 13:28:51 +0200
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@kernel.org
Cc:     luca@coelho.fi, linux-wireless@vger.kernel.org
Date:   Sun, 19 Dec 2021 13:28:36 +0200
Message-Id: <iwlwifi.20211219132536.55527214f8c9.I1748215ccb3fa20a3491a46a49b12e04eb560ac6@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211219112836.132859-1-luca@coelho.fi>
References: <20211219112836.132859-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.6
Subject: [PATCH 12/12] iwlwifi: yoyo: fix issue with new DBGI_SRAM region read.
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Mukesh Sisodiya <mukesh.sisodiya@intel.com>

NIC has been grabbed for reading twice which is leading
to NIC hang. Code correction are done for reading data with
no grab function.

Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/fw/dbg.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/dbg.c b/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
index 35af228be3aa..7ad9cee925da 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
@@ -1564,7 +1564,7 @@ iwl_dump_ini_dbgi_sram_iter(struct iwl_fw_runtime *fwrt,
 	iwl_write_prph_no_grab(fwrt->trans, DBGI_SRAM_TARGET_ACCESS_CFG,
 			       DBGI_SRAM_TARGET_ACCESS_CFG_RESET_ADDRESS_MSK);
 	for (i = 0; i < (le32_to_cpu(reg->dev_addr.size) / 4); i++) {
-		prph_data = iwl_read_prph(fwrt->trans, (i % 2) ?
+		prph_data = iwl_read_prph_no_grab(fwrt->trans, (i % 2) ?
 					  DBGI_SRAM_TARGET_ACCESS_RDATA_MSB :
 					  DBGI_SRAM_TARGET_ACCESS_RDATA_LSB);
 		if (prph_data == 0x5a5a5a5a) {
-- 
2.34.1

