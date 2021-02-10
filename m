Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DAAEB3165E1
	for <lists+linux-wireless@lfdr.de>; Wed, 10 Feb 2021 13:01:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231186AbhBJL76 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 10 Feb 2021 06:59:58 -0500
Received: from paleale.coelho.fi ([176.9.41.70]:44982 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S231334AbhBJL5k (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 10 Feb 2021 06:57:40 -0500
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <luca@coelho.fi>)
        id 1l9o6r-0049Ur-Rk; Wed, 10 Feb 2021 13:56:42 +0200
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Wed, 10 Feb 2021 13:56:31 +0200
Message-Id: <iwlwifi.20210210135352.d090e0301023.I7d57f4d7da9a3297734c51cf988199323c76916d@changeid>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210210115637.276676-1-luca@coelho.fi>
References: <20210210115637.276676-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.4
Subject: [PATCH v2 06/12] iwlwifi: mvm: send stored PPAG command instead of local
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Luca Coelho <luciano.coelho@intel.com>

Some change conflicts apparently cause a confusion between a local
variable being used to send the PPAG command and the introduction of a
union for this command.  Most parts of the local command were never
copied from the stored data, so the FW was getting garbage in the
tables instead of getting valid values.

Fix this by completely removing the local and using only the union
that we have stored in fwrt.

Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
Fixes: f2134f66f40e ("iwlwifi: acpi: support ppag table command v2")
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/fw.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
index 57471ab2f5ef..8675a78ff9e9 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
@@ -993,7 +993,6 @@ int iwl_mvm_ppag_send_cmd(struct iwl_mvm *mvm)
 {
 	u8 cmd_ver;
 	int i, j, ret, num_sub_bands, cmd_size;
-	union iwl_ppag_table_cmd ppag_table;
 	s8 *gain;
 
 	if (!fw_has_capa(&mvm->fw->ucode_capa, IWL_UCODE_TLV_CAPA_SET_PPAG)) {
@@ -1006,15 +1005,13 @@ int iwl_mvm_ppag_send_cmd(struct iwl_mvm *mvm)
 		return 0;
 	}
 
-	ppag_table.v1.enabled = mvm->fwrt.ppag_table.v1.enabled;
-
 	cmd_ver = iwl_fw_lookup_cmd_ver(mvm->fw, PHY_OPS_GROUP,
 					PER_PLATFORM_ANT_GAIN_CMD,
 					IWL_FW_CMD_VER_UNKNOWN);
 	if (cmd_ver == 1) {
 		num_sub_bands = IWL_NUM_SUB_BANDS;
 		gain = mvm->fwrt.ppag_table.v1.gain[0];
-		cmd_size = sizeof(ppag_table.v1);
+		cmd_size = sizeof(mvm->fwrt.ppag_table.v1);
 		if (mvm->fwrt.ppag_ver == 2) {
 			IWL_DEBUG_RADIO(mvm,
 					"PPAG table is v2 but FW supports v1, sending truncated table\n");
@@ -1022,7 +1019,7 @@ int iwl_mvm_ppag_send_cmd(struct iwl_mvm *mvm)
 	} else if (cmd_ver == 2) {
 		num_sub_bands = IWL_NUM_SUB_BANDS_V2;
 		gain = mvm->fwrt.ppag_table.v2.gain[0];
-		cmd_size = sizeof(ppag_table.v2);
+		cmd_size = sizeof(mvm->fwrt.ppag_table.v2);
 		if (mvm->fwrt.ppag_ver == 1) {
 			IWL_DEBUG_RADIO(mvm,
 					"PPAG table is v1 but FW supports v2, sending padded table\n");
@@ -1042,7 +1039,7 @@ int iwl_mvm_ppag_send_cmd(struct iwl_mvm *mvm)
 	IWL_DEBUG_RADIO(mvm, "Sending PER_PLATFORM_ANT_GAIN_CMD\n");
 	ret = iwl_mvm_send_cmd_pdu(mvm, WIDE_ID(PHY_OPS_GROUP,
 						PER_PLATFORM_ANT_GAIN_CMD),
-				   0, cmd_size, &ppag_table);
+				   0, cmd_size, &mvm->fwrt.ppag_table);
 	if (ret < 0)
 		IWL_ERR(mvm, "failed to send PER_PLATFORM_ANT_GAIN_CMD (%d)\n",
 			ret);
-- 
2.30.0

