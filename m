Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 787A12667E0
	for <lists+linux-wireless@lfdr.de>; Fri, 11 Sep 2020 19:54:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726060AbgIKRyp (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 11 Sep 2020 13:54:45 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:50256 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725867AbgIKRyk (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 11 Sep 2020 13:54:40 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <luca@coelho.fi>)
        id 1kGn6N-0028eU-7K; Fri, 11 Sep 2020 20:44:47 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Fri, 11 Sep 2020 20:44:35 +0300
Message-Id: <iwlwifi.20200911204056.816130ee75e0.I727a217be7c967a97960b197a816fc053d10c48a@changeid>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200911174439.163225-1-luca@coelho.fi>
References: <20200911174439.163225-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.4
Subject: [PATCH 07/11] iwlwifi: acpi: evaluate dsm to disable 5.8GHz channels
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Gil Adam <gil.adam@intel.com>

Evaluate the appropriate DSM from ACPI to set ETSI SRD 5.8GHz
channels to passive or disabled, default behaviour is enabled.
Add enums and refactor evaluation of DSM functions for better
readablity and more informative debug prints.

Signed-off-by: Gil Adam <gil.adam@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/fw/acpi.h | 14 ++++
 drivers/net/wireless/intel/iwlwifi/mvm/fw.c  | 81 ++++++++++++++++----
 2 files changed, 79 insertions(+), 16 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/acpi.h b/drivers/net/wireless/intel/iwlwifi/fw/acpi.h
index 0ada9eddb8b1..bff0260012ec 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/acpi.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/acpi.h
@@ -133,6 +133,20 @@ enum iwl_dsm_funcs_rev_0 {
 	DSM_FUNC_ENABLE_INDONESIA_5G2 = 2,
 };
 
+enum iwl_dsm_values_srd {
+	DSM_VALUE_SRD_ACTIVE,
+	DSM_VALUE_SRD_PASSIVE,
+	DSM_VALUE_SRD_DISABLE,
+	DSM_VALUE_SRD_MAX
+};
+
+enum iwl_dsm_values_indonesia {
+	DSM_VALUE_INDONESIA_DISABLE,
+	DSM_VALUE_INDONESIA_ENABLE,
+	DSM_VALUE_INDONESIA_RESERVED,
+	DSM_VALUE_INDONESIA_MAX
+};
+
 #ifdef CONFIG_ACPI
 
 struct iwl_fw_runtime;
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
index 95a613537047..4467359aaa20 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
@@ -989,41 +989,90 @@ static void iwl_mvm_tas_init(struct iwl_mvm *mvm)
 		IWL_DEBUG_RADIO(mvm, "failed to send TAS_CONFIG (%d)\n", ret);
 }
 
-static bool iwl_mvm_eval_dsm_indonesia_5g2(struct iwl_mvm *mvm)
+static u8 iwl_mvm_eval_dsm_indonesia_5g2(struct iwl_mvm *mvm)
 {
 	int ret = iwl_acpi_get_dsm_u8((&mvm->fwrt)->dev, 0,
 				      DSM_FUNC_ENABLE_INDONESIA_5G2);
 
-	IWL_DEBUG_RADIO(mvm,
-			"Evaluated DSM function ENABLE_INDONESIA_5G2, ret=%d\n",
-			ret);
+	if (ret < 0)
+		IWL_DEBUG_RADIO(mvm,
+				"Failed to evaluate DSM function ENABLE_INDONESIA_5G2, ret=%d\n",
+				ret);
 
-	return ret == 1;
+	else if (ret >= DSM_VALUE_INDONESIA_MAX)
+		IWL_DEBUG_RADIO(mvm,
+				"DSM function ENABLE_INDONESIA_5G2 return invalid value, ret=%d\n",
+				ret);
+
+	else if (ret == DSM_VALUE_INDONESIA_ENABLE) {
+		IWL_DEBUG_RADIO(mvm,
+				"Evaluated DSM function ENABLE_INDONESIA_5G2: Enabling 5g2\n");
+		return DSM_VALUE_INDONESIA_ENABLE;
+	}
+	/* default behaviour is disabled */
+	return DSM_VALUE_INDONESIA_DISABLE;
+}
+
+static u8 iwl_mvm_eval_dsm_disable_srd(struct iwl_mvm *mvm)
+{
+	int ret = iwl_acpi_get_dsm_u8((&mvm->fwrt)->dev, 0,
+				      DSM_FUNC_DISABLE_SRD);
+
+	if (ret < 0)
+		IWL_DEBUG_RADIO(mvm,
+				"Failed to evaluate DSM function DISABLE_SRD, ret=%d\n",
+				ret);
+
+	else if (ret >= DSM_VALUE_SRD_MAX)
+		IWL_DEBUG_RADIO(mvm,
+				"DSM function DISABLE_SRD return invalid value, ret=%d\n",
+				ret);
+
+	else if (ret == DSM_VALUE_SRD_PASSIVE) {
+		IWL_DEBUG_RADIO(mvm,
+				"Evaluated DSM function DISABLE_SRD: setting SRD to passive\n");
+		return DSM_VALUE_SRD_PASSIVE;
+
+	} else if (ret == DSM_VALUE_SRD_DISABLE) {
+		IWL_DEBUG_RADIO(mvm,
+				"Evaluated DSM function DISABLE_SRD: disabling SRD\n");
+		return DSM_VALUE_SRD_DISABLE;
+	}
+	/* default behaviour is active */
+	return DSM_VALUE_SRD_ACTIVE;
 }
 
 static void iwl_mvm_lari_cfg(struct iwl_mvm *mvm)
 {
-	int ret;
+	u8 ret;
+	int cmd_ret;
 	struct iwl_lari_config_change_cmd cmd = {};
 
-	if (iwl_mvm_eval_dsm_indonesia_5g2(mvm))
+	if (iwl_mvm_eval_dsm_indonesia_5g2(mvm) == DSM_VALUE_INDONESIA_ENABLE)
 		cmd.config_bitmap |=
 			cpu_to_le32(LARI_CONFIG_ENABLE_5G2_IN_INDONESIA_MSK);
 
+	ret = iwl_mvm_eval_dsm_disable_srd(mvm);
+	if (ret == DSM_VALUE_SRD_PASSIVE)
+		cmd.config_bitmap |=
+			cpu_to_le32(LARI_CONFIG_CHANGE_ETSI_TO_PASSIVE_MSK);
+
+	else if (ret == DSM_VALUE_SRD_DISABLE)
+		cmd.config_bitmap |=
+			cpu_to_le32(LARI_CONFIG_CHANGE_ETSI_TO_DISABLED_MSK);
+
 	/* apply more config masks here */
 
 	if (cmd.config_bitmap) {
-		IWL_DEBUG_RADIO(mvm,
-				"sending LARI_CONFIG_CHANGE, config_bitmap=0x%x\n",
-				le32_to_cpu(cmd.config_bitmap));
-		ret = iwl_mvm_send_cmd_pdu(mvm,
-					   WIDE_ID(REGULATORY_AND_NVM_GROUP,
-						   LARI_CONFIG_CHANGE),
-					   0, sizeof(cmd), &cmd);
-		if (ret < 0)
+		IWL_DEBUG_RADIO(mvm, "sending LARI_CONFIG_CHANGE\n");
+		cmd_ret = iwl_mvm_send_cmd_pdu(mvm,
+					       WIDE_ID(REGULATORY_AND_NVM_GROUP,
+						       LARI_CONFIG_CHANGE),
+					       0, sizeof(cmd), &cmd);
+		if (cmd_ret < 0)
 			IWL_DEBUG_RADIO(mvm,
 					"Failed to send LARI_CONFIG_CHANGE (%d)\n",
-					ret);
+					cmd_ret);
 	}
 }
 #else /* CONFIG_ACPI */
-- 
2.28.0

