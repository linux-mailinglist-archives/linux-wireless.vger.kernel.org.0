Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD74E47A02B
	for <lists+linux-wireless@lfdr.de>; Sun, 19 Dec 2021 11:18:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235589AbhLSKSb (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 19 Dec 2021 05:18:31 -0500
Received: from paleale.coelho.fi ([176.9.41.70]:51358 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S231185AbhLSKSb (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 19 Dec 2021 05:18:31 -0500
Received: from 91-156-5-105.elisa-laajakaista.fi ([91.156.5.105] helo=kveik.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <luca@coelho.fi>)
        id 1mytGu-001O3b-Rv; Sun, 19 Dec 2021 12:18:29 +0200
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@kernel.org
Cc:     luca@coelho.fi, linux-wireless@vger.kernel.org
Date:   Sun, 19 Dec 2021 12:18:14 +0200
Message-Id: <iwlwifi.20211219121514.abed3b8119c7.I1fdc2c14577523fcffdfe8fb5902c2d8efde7e09@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211219101820.85153-1-luca@coelho.fi>
References: <20211219101820.85153-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.6
Subject: [PATCH 06/12] iwlwifi: don't pass actual WGDS revision number in table_revision
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Luca Coelho <luciano.coelho@intel.com>

The FW API for PER_CHAIN_LIMIT_OFFSET_CMD is misleading.  The element
name is table_rev, but it shouldn't actually contain the table
revision number, but whether we should use the South Korea scheme or
not.

Fix the driver so that we only set this value to either 0 or 1.  It
will only be 1 (meaning South Korea) if the ACPI WGDS table revision
is 1.

Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
Fixes: 664c011b763e ("iwlwifi: acpi: support reading and storing WGDS revision 2")
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 .../net/wireless/intel/iwlwifi/fw/api/power.h  |  8 ++++----
 drivers/net/wireless/intel/iwlwifi/mvm/fw.c    | 18 +++++++++++++-----
 2 files changed, 17 insertions(+), 9 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/power.h b/drivers/net/wireless/intel/iwlwifi/fw/api/power.h
index 631b96cc8ee9..81318208f2f6 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/power.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/power.h
@@ -419,7 +419,7 @@ struct iwl_geo_tx_power_profiles_cmd_v1 {
  * struct iwl_geo_tx_power_profile_cmd_v2 - struct for PER_CHAIN_LIMIT_OFFSET_CMD cmd.
  * @ops: operations, value from &enum iwl_geo_per_chain_offset_operation
  * @table: offset profile per band.
- * @table_revision: BIOS table revision.
+ * @table_revision: 0 for not-South Korea, 1 for South Korea (the name is misleading)
  */
 struct iwl_geo_tx_power_profiles_cmd_v2 {
 	__le32 ops;
@@ -431,7 +431,7 @@ struct iwl_geo_tx_power_profiles_cmd_v2 {
  * struct iwl_geo_tx_power_profile_cmd_v3 - struct for PER_CHAIN_LIMIT_OFFSET_CMD cmd.
  * @ops: operations, value from &enum iwl_geo_per_chain_offset_operation
  * @table: offset profile per band.
- * @table_revision: BIOS table revision.
+ * @table_revision: 0 for not-South Korea, 1 for South Korea (the name is misleading)
  */
 struct iwl_geo_tx_power_profiles_cmd_v3 {
 	__le32 ops;
@@ -443,7 +443,7 @@ struct iwl_geo_tx_power_profiles_cmd_v3 {
  * struct iwl_geo_tx_power_profile_cmd_v4 - struct for PER_CHAIN_LIMIT_OFFSET_CMD cmd.
  * @ops: operations, value from &enum iwl_geo_per_chain_offset_operation
  * @table: offset profile per band.
- * @table_revision: BIOS table revision.
+ * @table_revision: 0 for not-South Korea, 1 for South Korea (the name is misleading)
  */
 struct iwl_geo_tx_power_profiles_cmd_v4 {
 	__le32 ops;
@@ -455,7 +455,7 @@ struct iwl_geo_tx_power_profiles_cmd_v4 {
  * struct iwl_geo_tx_power_profile_cmd_v5 - struct for PER_CHAIN_LIMIT_OFFSET_CMD cmd.
  * @ops: operations, value from &enum iwl_geo_per_chain_offset_operation
  * @table: offset profile per band.
- * @table_revision: BIOS table revision.
+ * @table_revision: 0 for not-South Korea, 1 for South Korea (the name is misleading)
  */
 struct iwl_geo_tx_power_profiles_cmd_v5 {
 	__le32 ops;
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
index 19a18b626069..40f95da0dfe9 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
@@ -866,6 +866,7 @@ static int iwl_mvm_sar_geo_init(struct iwl_mvm *mvm)
 	u16 len;
 	u32 n_bands;
 	u32 n_profiles;
+	u32 sk = 0;
 	int ret;
 	u8 cmd_ver = iwl_fw_lookup_cmd_ver(mvm->fw, PHY_OPS_GROUP,
 					   PER_CHAIN_LIMIT_OFFSET_CMD,
@@ -925,19 +926,26 @@ static int iwl_mvm_sar_geo_init(struct iwl_mvm *mvm)
 	if (ret)
 		return 0;
 
+	/* Only set to South Korea if the table revision is 1 */
+	if (mvm->fwrt.geo_rev == 1)
+		sk = 1;
+
 	/*
-	 * Set the revision on versions that contain it.
+	 * Set the table_revision to South Korea (1) or not (0).  The
+	 * element name is misleading, as it doesn't contain the table
+	 * revision number, but whether the South Korea variation
+	 * should be used.
 	 * This must be done after calling iwl_sar_geo_init().
 	 */
 	if (cmd_ver == 5)
-		cmd.v5.table_revision = cpu_to_le32(mvm->fwrt.geo_rev);
+		cmd.v5.table_revision = cpu_to_le32(sk);
 	else if (cmd_ver == 4)
-		cmd.v4.table_revision = cpu_to_le32(mvm->fwrt.geo_rev);
+		cmd.v4.table_revision = cpu_to_le32(sk);
 	else if (cmd_ver == 3)
-		cmd.v3.table_revision = cpu_to_le32(mvm->fwrt.geo_rev);
+		cmd.v3.table_revision = cpu_to_le32(sk);
 	else if (fw_has_api(&mvm->fwrt.fw->ucode_capa,
 			    IWL_UCODE_TLV_API_SAR_TABLE_VER))
-		cmd.v2.table_revision = cpu_to_le32(mvm->fwrt.geo_rev);
+		cmd.v2.table_revision = cpu_to_le32(sk);
 
 	return iwl_mvm_send_cmd_pdu(mvm,
 				    WIDE_ID(PHY_OPS_GROUP,
-- 
2.34.1

