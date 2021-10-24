Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 133874389C5
	for <lists+linux-wireless@lfdr.de>; Sun, 24 Oct 2021 17:20:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231327AbhJXPXJ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 24 Oct 2021 11:23:09 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:58626 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S229564AbhJXPXJ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 24 Oct 2021 11:23:09 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=kveik.lan)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <luca@coelho.fi>)
        id 1mefIk-000czj-C2; Sun, 24 Oct 2021 18:20:47 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     luca@coelho.fi, linux-wireless@vger.kernel.org
Date:   Sun, 24 Oct 2021 18:20:28 +0300
Message-Id: <iwlwifi.20211024181719.2fa34d31383c.I6504005c60882c94e6e58f64cab4e42e6481ce08@changeid>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211024152037.332948-1-luca@coelho.fi>
References: <20211024152037.332948-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.6
Subject: [PATCH 03/12] iwlwifi: mvm: read 6E enablement flags from DSM and pass to FW
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Luca Coelho <luciano.coelho@intel.com>

We need to call a new DSM function and pass the values to the firmware
in order to allow enablement of 6E support by the OEMs via ACPI.

Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/fw/acpi.h |  1 +
 drivers/net/wireless/intel/iwlwifi/mvm/fw.c  | 11 ++++++++++-
 2 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/acpi.h b/drivers/net/wireless/intel/iwlwifi/fw/acpi.h
index a30b95a01144..4aaa8a6b071b 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/acpi.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/acpi.h
@@ -109,6 +109,7 @@ enum iwl_dsm_funcs_rev_0 {
 	DSM_FUNC_QUERY = 0,
 	DSM_FUNC_DISABLE_SRD = 1,
 	DSM_FUNC_ENABLE_INDONESIA_5G2 = 2,
+	DSM_FUNC_ENABLE_6E = 3,
 	DSM_FUNC_11AX_ENABLEMENT = 6,
 	DSM_FUNC_ENABLE_UNII4_CHAN = 7,
 	DSM_FUNC_ACTIVATE_CHANNEL = 8
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
index e64b6468d1a1..6063b2ffe266 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
@@ -1177,7 +1177,6 @@ static void iwl_mvm_lari_cfg(struct iwl_mvm *mvm)
 				   &iwl_guid, &value);
 	if (!ret)
 		cmd.oem_11ax_allow_bitmap = cpu_to_le32(value);
-	/* apply more config masks here */
 
 	ret = iwl_acpi_get_dsm_u32((&mvm->fwrt)->dev, 0,
 				   DSM_FUNC_ENABLE_UNII4_CHAN,
@@ -1191,7 +1190,14 @@ static void iwl_mvm_lari_cfg(struct iwl_mvm *mvm)
 	if (!ret)
 		cmd.chan_state_active_bitmap = cpu_to_le32(value);
 
+	ret = iwl_acpi_get_dsm_u32(mvm->fwrt.dev, 0,
+				   DSM_FUNC_ENABLE_6E,
+				   &iwl_guid, &value);
+	if (!ret)
+		cmd.oem_uhb_allow_bitmap = cpu_to_le32(value);
+
 	if (cmd.config_bitmap ||
+	    cmd.oem_uhb_allow_bitmap ||
 	    cmd.oem_11ax_allow_bitmap ||
 	    cmd.oem_unii4_allow_bitmap ||
 	    cmd.chan_state_active_bitmap) {
@@ -1219,6 +1225,9 @@ static void iwl_mvm_lari_cfg(struct iwl_mvm *mvm)
 				le32_to_cpu(cmd.oem_unii4_allow_bitmap),
 				le32_to_cpu(cmd.chan_state_active_bitmap),
 				cmd_ver);
+		IWL_DEBUG_RADIO(mvm,
+				"sending LARI_CONFIG_CHANGE, oem_uhb_allow_bitmap=0x%x\n",
+				le32_to_cpu(cmd.oem_uhb_allow_bitmap));
 		ret = iwl_mvm_send_cmd_pdu(mvm,
 					   WIDE_ID(REGULATORY_AND_NVM_GROUP,
 						   LARI_CONFIG_CHANGE),
-- 
2.33.0

