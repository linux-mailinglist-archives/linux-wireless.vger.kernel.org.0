Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F7CC2876DF
	for <lists+linux-wireless@lfdr.de>; Thu,  8 Oct 2020 17:13:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730944AbgJHPNB (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 8 Oct 2020 11:13:01 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:54602 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730940AbgJHPNB (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 8 Oct 2020 11:13:01 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <luca@coelho.fi>)
        id 1kQXbG-002QxQ-GS; Thu, 08 Oct 2020 18:12:58 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Thu,  8 Oct 2020 18:12:44 +0300
Message-Id: <iwlwifi.20201008181047.73605b6e0548.Id0ec98333277ff9e017e3938ae413b34acc68947@changeid>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201008151250.332346-1-luca@coelho.fi>
References: <20201008151250.332346-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.4
Subject: [PATCH 07/13] iwlwifi: fix sar geo table initialization
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Naftali Goldstein <naftali.goldstein@intel.com>

When adding support for version 3 of the GEO_TX_POWER_LIMIT command,
the table argument of iwl_sar_geo_init was changed from a pointer a 1d
array of now-removed iwl_per_chain_offset_group_v1 to a pointer to a 2d
array of iwl_per_chain_offset (iwl_per_chain_offset_group_v1 was a
struct containing 2 copies of iwl_per_chain_offset).

So even for version 2 where the second dimension is of length 2, which
means that the underlying memory layout of the array didn't change, this
requires a small change in the way we loop over it, and this was missed.

Additionally, for the case of version 3 where the second dimension is now
3, in order to fill the first two elements of each row correctly (lb and
hb), iwl_sar_geo_init must get the true number of bands supported.
But because we don't yet store any values for the 3rd (uhb) band, skip
that band.

Signed-off-by: Naftali Goldstein <naftali.goldstein@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/fw/acpi.c | 20 ++++++++----
 drivers/net/wireless/intel/iwlwifi/fw/acpi.h |  1 -
 drivers/net/wireless/intel/iwlwifi/mvm/fw.c  | 33 +++++++++++++-------
 3 files changed, 36 insertions(+), 18 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/acpi.c b/drivers/net/wireless/intel/iwlwifi/fw/acpi.c
index e93656e461ea..3e5a35e26ad3 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/acpi.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/acpi.c
@@ -662,17 +662,25 @@ int iwl_sar_geo_init(struct iwl_fw_runtime *fwrt,
 	}
 
 	for (i = 0; i < ACPI_NUM_GEO_PROFILES; i++) {
-		struct iwl_per_chain_offset *chain =
-			(struct iwl_per_chain_offset *)&table[i];
-
 		for (j = 0; j < n_bands; j++) {
+			struct iwl_per_chain_offset *chain =
+				&table[i * n_bands + j];
 			u8 *value;
 
+			if (j * ACPI_GEO_PER_CHAIN_SIZE >=
+			    ARRAY_SIZE(fwrt->geo_profiles[0].values))
+				/*
+				 * Currently we only store lb an hb values, and
+				 * don't have any special ones for uhb. So leave
+				 * those empty for the time being
+				 */
+				break;
+
 			value = &fwrt->geo_profiles[i].values[j *
 				ACPI_GEO_PER_CHAIN_SIZE];
-			chain[j].max_tx_power = cpu_to_le16(value[0]);
-			chain[j].chain_a = value[1];
-			chain[j].chain_b = value[2];
+			chain->max_tx_power = cpu_to_le16(value[0]);
+			chain->chain_a = value[1];
+			chain->chain_b = value[2];
 			IWL_DEBUG_RADIO(fwrt,
 					"SAR geographic profile[%d] Band[%d]: chain A = %d chain B = %d max_tx_power = %d\n",
 					i, j, value[1], value[2], value[0]);
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/acpi.h b/drivers/net/wireless/intel/iwlwifi/fw/acpi.h
index 71ef8647d7b5..bddf8a44e163 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/acpi.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/acpi.h
@@ -105,7 +105,6 @@
 #define APCI_WTAS_BLACK_LIST_MAX	16
 #define ACPI_WTAS_WIFI_DATA_SIZE	(3 + APCI_WTAS_BLACK_LIST_MAX)
 
-#define ACPI_WGDS_NUM_BANDS		2
 #define ACPI_WGDS_TABLE_SIZE		3
 
 #define ACPI_PPAG_WIFI_DATA_SIZE	((IWL_NUM_CHAIN_LIMITS * \
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
index 80b52010d47b..9bce25a15df6 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
@@ -923,36 +923,47 @@ static int iwl_mvm_sar_geo_init(struct iwl_mvm *mvm)
 {
 	union iwl_geo_tx_power_profiles_cmd cmd;
 	u16 len;
+	u32 n_bands;
 	int ret;
 	u8 cmd_ver = iwl_fw_lookup_cmd_ver(mvm->fw, PHY_OPS_GROUP,
 					   GEO_TX_POWER_LIMIT,
 					   IWL_FW_CMD_VER_UNKNOWN);
 
-	/* the table is also at the same position both in v1 and v2 */
-	ret = iwl_sar_geo_init(&mvm->fwrt, &cmd.v1.table[0][0],
-			       ACPI_WGDS_NUM_BANDS);
-
-	/*
-	 * It is a valid scenario to not support SAR, or miss wgds table,
-	 * but in that case there is no need to send the command.
-	 */
-	if (ret)
-		return 0;
-
+	BUILD_BUG_ON(offsetof(struct iwl_geo_tx_power_profiles_cmd_v1, ops) !=
+		     offsetof(struct iwl_geo_tx_power_profiles_cmd_v2, ops) ||
+		     offsetof(struct iwl_geo_tx_power_profiles_cmd_v2, ops) !=
+		     offsetof(struct iwl_geo_tx_power_profiles_cmd_v3, ops));
 	/* the ops field is at the same spot for all versions, so set in v1 */
 	cmd.v1.ops = cpu_to_le32(IWL_PER_CHAIN_OFFSET_SET_TABLES);
 
 	if (cmd_ver == 3) {
 		len = sizeof(cmd.v3);
+		n_bands = ARRAY_SIZE(cmd.v3.table[0]);
 		cmd.v3.table_revision = cpu_to_le32(mvm->fwrt.geo_rev);
 	} else if (fw_has_api(&mvm->fwrt.fw->ucode_capa,
 			      IWL_UCODE_TLV_API_SAR_TABLE_VER)) {
 		len = sizeof(cmd.v2);
+		n_bands = ARRAY_SIZE(cmd.v2.table[0]);
 		cmd.v2.table_revision = cpu_to_le32(mvm->fwrt.geo_rev);
 	} else {
 		len = sizeof(cmd.v1);
+		n_bands = ARRAY_SIZE(cmd.v1.table[0]);
 	}
 
+	BUILD_BUG_ON(offsetof(struct iwl_geo_tx_power_profiles_cmd_v1, table) !=
+		     offsetof(struct iwl_geo_tx_power_profiles_cmd_v2, table) ||
+		     offsetof(struct iwl_geo_tx_power_profiles_cmd_v2, table) !=
+		     offsetof(struct iwl_geo_tx_power_profiles_cmd_v3, table));
+	/* the table is at the same position for all versions, so set use v1 */
+	ret = iwl_sar_geo_init(&mvm->fwrt, &cmd.v1.table[0][0], n_bands);
+
+	/*
+	 * It is a valid scenario to not support SAR, or miss wgds table,
+	 * but in that case there is no need to send the command.
+	 */
+	if (ret)
+		return 0;
+
 	return iwl_mvm_send_cmd_pdu(mvm,
 				    WIDE_ID(PHY_OPS_GROUP, GEO_TX_POWER_LIMIT),
 				    0, len, &cmd);
-- 
2.28.0

