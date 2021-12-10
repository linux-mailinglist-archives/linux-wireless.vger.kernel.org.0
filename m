Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7734246FD79
	for <lists+linux-wireless@lfdr.de>; Fri, 10 Dec 2021 10:12:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239102AbhLJJQ3 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 10 Dec 2021 04:16:29 -0500
Received: from paleale.coelho.fi ([176.9.41.70]:50884 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S239100AbhLJJQ2 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 10 Dec 2021 04:16:28 -0500
Received: from 91-156-5-105.elisa-laajakaista.fi ([91.156.5.105] helo=kveik.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <luca@coelho.fi>)
        id 1mvbxU-001FED-D2; Fri, 10 Dec 2021 11:12:53 +0200
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@kernel.org
Cc:     luca@coelho.fi, linux-wireless@vger.kernel.org
Date:   Fri, 10 Dec 2021 11:12:37 +0200
Message-Id: <iwlwifi.20211210110539.b58a02f27512.Idbfbc430776a7abda0eb086215fb64f2c9307ac0@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211210091245.289008-1-luca@coelho.fi>
References: <20211210091245.289008-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.6
Subject: [PATCH 02/10] iwlwifi: dump CSR scratch from outer function
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

We shouldn't dump this twice if we have two TCMs, and it really
doesn't belong to the TCM dump anyway, so move this out.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/fw/dump.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/dump.c b/drivers/net/wireless/intel/iwlwifi/fw/dump.c
index 81acb7df73d7..b0f9a2cb2a93 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/dump.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/dump.c
@@ -292,13 +292,6 @@ static void iwl_fwrt_dump_tcm_error_log(struct iwl_fw_runtime *fwrt)
 	for (i = 0; i < ARRAY_SIZE(table.sw_status); i++)
 		IWL_ERR(fwrt, "0x%08X | tcm SW status[%d]\n",
 			table.sw_status[i], i);
-
-	if (trans->trans_cfg->device_family >= IWL_DEVICE_FAMILY_BZ) {
-		u32 scratch = iwl_read32(trans, CSR_FUNC_SCRATCH);
-
-		IWL_ERR(fwrt, "Function Scratch status:\n");
-		IWL_ERR(fwrt, "0x%08X | Func Scratch\n", scratch);
-	}
 }
 
 static void iwl_fwrt_dump_iml_error_log(struct iwl_fw_runtime *fwrt)
@@ -385,5 +378,12 @@ void iwl_fwrt_dump_error_logs(struct iwl_fw_runtime *fwrt)
 	iwl_fwrt_dump_tcm_error_log(fwrt);
 	iwl_fwrt_dump_iml_error_log(fwrt);
 	iwl_fwrt_dump_fseq_regs(fwrt);
+
+	if (fwrt->trans->trans_cfg->device_family >= IWL_DEVICE_FAMILY_BZ) {
+		u32 scratch = iwl_read32(fwrt->trans, CSR_FUNC_SCRATCH);
+
+		IWL_ERR(fwrt, "Function Scratch status:\n");
+		IWL_ERR(fwrt, "0x%08X | Func Scratch\n", scratch);
+	}
 }
 IWL_EXPORT_SYMBOL(iwl_fwrt_dump_error_logs);
-- 
2.34.1

