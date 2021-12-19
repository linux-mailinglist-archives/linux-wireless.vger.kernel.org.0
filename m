Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC2F447A05D
	for <lists+linux-wireless@lfdr.de>; Sun, 19 Dec 2021 12:28:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235637AbhLSL2q (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 19 Dec 2021 06:28:46 -0500
Received: from paleale.coelho.fi ([176.9.41.70]:51424 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S235618AbhLSL2p (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 19 Dec 2021 06:28:45 -0500
Received: from 91-156-5-105.elisa-laajakaista.fi ([91.156.5.105] helo=kveik.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <luca@coelho.fi>)
        id 1myuMs-001O73-GG; Sun, 19 Dec 2021 13:28:44 +0200
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@kernel.org
Cc:     luca@coelho.fi, linux-wireless@vger.kernel.org
Date:   Sun, 19 Dec 2021 13:28:28 +0200
Message-Id: <iwlwifi.20211219132536.f9d0ba617fe7.I609265c79add6aa59af68cb87f76b39502985125@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211219112836.132859-1-luca@coelho.fi>
References: <20211219112836.132859-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.6
Subject: [PATCH 04/12] iwlwifi: mvm: fix rfi get table vendor command handler
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Miri Korenblit <miriam.rachel.korenblit@intel.com>

In get table handler, skb was freed even on the correct path without
any error and it caused kernel crash further in the flow.

Also, increase the size of the allocated skb.

Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/fw.c | 55 ++++++++++++++-------
 1 file changed, 36 insertions(+), 19 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
index 65c1f9c88e67..f48459da0fcc 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
@@ -32,6 +32,9 @@
 #define IWL_PPAG_MASK 3
 #define IWL_PPAG_ETSI_MASK BIT(0)
 
+#define IWL_TAS_US_MCC 0x5553
+#define IWL_TAS_CANADA_MCC 0x4341
+
 struct iwl_mvm_alive_data {
 	bool valid;
 	u32 scd_base_addr;
@@ -1183,12 +1186,30 @@ static const struct dmi_system_id dmi_tas_approved_list[] = {
 	{}
 };
 
+static bool iwl_mvm_add_to_tas_block_list(__le32 *list, __le32 *le_size, unsigned int mcc)
+{
+	int i;
+	u32 size = le32_to_cpu(*le_size);
+
+	/* Verify that there is room for another country */
+	if (size >= IWL_TAS_BLOCK_LIST_MAX)
+		return false;
+
+	for (i = 0; i < size; i++) {
+		if (list[i] == cpu_to_le32(mcc))
+			return true;
+	}
+
+	list[size++] = cpu_to_le32(mcc);
+	*le_size = cpu_to_le32(size);
+	return true;
+}
+
 static void iwl_mvm_tas_init(struct iwl_mvm *mvm)
 {
 	int ret;
 	struct iwl_tas_config_cmd_v3 cmd = {};
 	int cmd_size;
-	const struct ieee80211_regdomain *regd;
 
 	BUILD_BUG_ON(ARRAY_SIZE(cmd.block_list_array) <
 		     APCI_WTAS_BLACK_LIST_MAX);
@@ -1198,24 +1219,6 @@ static void iwl_mvm_tas_init(struct iwl_mvm *mvm)
 		return;
 	}
 
-	/* Get the MCC from cfg80211 */
-	regd = wiphy_dereference(mvm->hw->wiphy, mvm->hw->wiphy->regd);
-
-	if (!regd) {
-		IWL_DEBUG_RADIO(mvm, "MCC is unavailable\n");
-		return;
-	}
-
-	if ((regd->alpha2[0] == 'U' && regd->alpha2[1] == 'S') ||
-	    (regd->alpha2[0] == 'C' && regd->alpha2[1] == 'A')) {
-		if (!dmi_check_system(dmi_tas_approved_list)) {
-			IWL_DEBUG_RADIO(mvm,
-					"System vendor '%s' is not in the approved list, disabling TAS.\n",
-					dmi_get_system_info(DMI_SYS_VENDOR));
-			return;
-		}
-	}
-
 	ret = iwl_acpi_get_tas(&mvm->fwrt, &cmd);
 	if (ret < 0) {
 		IWL_DEBUG_RADIO(mvm,
@@ -1227,6 +1230,20 @@ static void iwl_mvm_tas_init(struct iwl_mvm *mvm)
 	if (ret == 0)
 		return;
 
+	if (!dmi_check_system(dmi_tas_approved_list)) {
+		IWL_DEBUG_RADIO(mvm,
+				"System vendor '%s' is not in the approved list, disabling TAS in US and Canada.\n",
+				dmi_get_system_info(DMI_SYS_VENDOR));
+		if ((!iwl_mvm_add_to_tas_block_list(cmd.block_list_array,
+						    &cmd.block_list_size, IWL_TAS_US_MCC)) ||
+		    (!iwl_mvm_add_to_tas_block_list(cmd.block_list_array,
+						    &cmd.block_list_size, IWL_TAS_CANADA_MCC))) {
+			IWL_DEBUG_RADIO(mvm,
+					"Unable to add US/Canada to TAS block list, disabling TAS\n");
+			return;
+		}
+	}
+
 	cmd_size = iwl_fw_lookup_cmd_ver(mvm->fw, REGULATORY_AND_NVM_GROUP,
 					 TAS_CONFIG,
 					 IWL_FW_CMD_VER_UNKNOWN) < 3 ?
-- 
2.34.1

