Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCE8347A031
	for <lists+linux-wireless@lfdr.de>; Sun, 19 Dec 2021 11:18:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235598AbhLSKSf (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 19 Dec 2021 05:18:35 -0500
Received: from paleale.coelho.fi ([176.9.41.70]:51380 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S235590AbhLSKSe (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 19 Dec 2021 05:18:34 -0500
Received: from 91-156-5-105.elisa-laajakaista.fi ([91.156.5.105] helo=kveik.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <luca@coelho.fi>)
        id 1mytGy-001O3b-C4; Sun, 19 Dec 2021 12:18:33 +0200
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@kernel.org
Cc:     luca@coelho.fi, linux-wireless@vger.kernel.org
Date:   Sun, 19 Dec 2021 12:18:18 +0200
Message-Id: <iwlwifi.20211219121514.793a509da7bd.Ia176746a28b816b5f788cce9a281139735909e2a@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211219101820.85153-1-luca@coelho.fi>
References: <20211219101820.85153-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.6
Subject: [PATCH 10/12] iwlwifi: mvm: always store the PPAG table as the latest version.
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Miri Korenblit <miriam.rachel.korenblit@intel.com>

In case of a conflict between BIOS version and FW
version of the PPAG table - the values arrive in the FW in the wrong
places. This happens because we're storing the table in different
structures depending on the BIOS version, not on the FW version,
and so the FW doesn't get what it expect to.
Always store the table in a v2 structure (which is a superset
of v1 and v0).

Also store the table in a structured way and in it's own structure,
rather then storing it in the ppag command structure, similarly to
the WRDS, EWRD and WGDS tables.

Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/fw/acpi.h  |  5 ++
 .../net/wireless/intel/iwlwifi/fw/runtime.h   |  3 +-
 drivers/net/wireless/intel/iwlwifi/mvm/fw.c   | 56 +++++++++----------
 3 files changed, 33 insertions(+), 31 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/acpi.h b/drivers/net/wireless/intel/iwlwifi/fw/acpi.h
index ac95d938109e..22b3c665f91a 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/acpi.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/acpi.h
@@ -114,6 +114,11 @@ struct iwl_geo_profile {
 	struct iwl_geo_profile_band bands[ACPI_GEO_NUM_BANDS_REV2];
 };
 
+/* Same thing as with SAR, all revisions fit in revision 2 */
+struct iwl_ppag_chain {
+	s8 subbands[ACPI_SAR_NUM_SUB_BANDS_REV2];
+};
+
 enum iwl_dsm_funcs_rev_0 {
 	DSM_FUNC_QUERY = 0,
 	DSM_FUNC_DISABLE_SRD = 1,
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/runtime.h b/drivers/net/wireless/intel/iwlwifi/fw/runtime.h
index cd895b614ddb..3cb0ddbe3ab2 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/runtime.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/runtime.h
@@ -158,7 +158,8 @@ struct iwl_fw_runtime {
 	u32 geo_rev;
 	u32 geo_num_profiles;
 	bool geo_enabled;
-	union iwl_ppag_table_cmd ppag_table;
+	struct iwl_ppag_chain ppag_chains[IWL_NUM_CHAIN_LIMITS];
+	u32 ppag_flags;
 	u32 ppag_ver;
 	struct iwl_sar_offset_mapping_cmd sgom_table;
 	bool sgom_enabled;
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
index 40f95da0dfe9..65c1f9c88e67 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
@@ -958,13 +958,8 @@ static int iwl_mvm_get_ppag_table(struct iwl_mvm *mvm)
 	union acpi_object *wifi_pkg, *data, *flags;
 	int i, j, ret, tbl_rev, num_sub_bands;
 	int idx = 2;
-	s8 *gain;
 
-	/*
-	 * The 'flags' field is the same in v1 and in v2 so we can just
-	 * use v1 to access it.
-	 */
-	mvm->fwrt.ppag_table.v1.flags = cpu_to_le32(0);
+	mvm->fwrt.ppag_flags = 0;
 
 	data = iwl_acpi_get_object(mvm->dev, ACPI_PPAG_METHOD);
 	if (IS_ERR(data))
@@ -976,8 +971,6 @@ static int iwl_mvm_get_ppag_table(struct iwl_mvm *mvm)
 	if (!IS_ERR(wifi_pkg)) {
 		if (tbl_rev == 1 || tbl_rev == 2) {
 			num_sub_bands = IWL_NUM_SUB_BANDS_V2;
-			gain = mvm->fwrt.ppag_table.v2.gain[0];
-			mvm->fwrt.ppag_ver = tbl_rev;
 			IWL_DEBUG_RADIO(mvm,
 					"Reading PPAG table v2 (tbl_rev=%d)\n",
 					tbl_rev);
@@ -997,8 +990,6 @@ static int iwl_mvm_get_ppag_table(struct iwl_mvm *mvm)
 			goto out_free;
 		}
 		num_sub_bands = IWL_NUM_SUB_BANDS_V1;
-		gain = mvm->fwrt.ppag_table.v1.gain[0];
-		mvm->fwrt.ppag_ver = 0;
 		IWL_DEBUG_RADIO(mvm, "Reading PPAG table v1 (tbl_rev=0)\n");
 		goto read_table;
 	}
@@ -1006,6 +997,7 @@ static int iwl_mvm_get_ppag_table(struct iwl_mvm *mvm)
 	goto out_free;
 
 read_table:
+	mvm->fwrt.ppag_ver = tbl_rev;
 	flags = &wifi_pkg->package.elements[1];
 
 	if (flags->type != ACPI_TYPE_INTEGER) {
@@ -1013,10 +1005,9 @@ static int iwl_mvm_get_ppag_table(struct iwl_mvm *mvm)
 		goto out_free;
 	}
 
-	mvm->fwrt.ppag_table.v1.flags = cpu_to_le32(flags->integer.value &
-						    IWL_PPAG_MASK);
+	mvm->fwrt.ppag_flags = flags->integer.value & IWL_PPAG_MASK;
 
-	if (!mvm->fwrt.ppag_table.v1.flags) {
+	if (!mvm->fwrt.ppag_flags) {
 		ret = 0;
 		goto out_free;
 	}
@@ -1036,15 +1027,15 @@ static int iwl_mvm_get_ppag_table(struct iwl_mvm *mvm)
 				goto out_free;
 			}
 
-			gain[i * num_sub_bands + j] = ent->integer.value;
+			mvm->fwrt.ppag_chains[i].subbands[j] = ent->integer.value;
 
 			if ((j == 0 &&
-			     (gain[i * num_sub_bands + j] > ACPI_PPAG_MAX_LB ||
-			      gain[i * num_sub_bands + j] < ACPI_PPAG_MIN_LB)) ||
+			     (mvm->fwrt.ppag_chains[i].subbands[j] > ACPI_PPAG_MAX_LB ||
+			      mvm->fwrt.ppag_chains[i].subbands[j] < ACPI_PPAG_MIN_LB)) ||
 			    (j != 0 &&
-			     (gain[i * num_sub_bands + j] > ACPI_PPAG_MAX_HB ||
-			      gain[i * num_sub_bands + j] < ACPI_PPAG_MIN_HB))) {
-				mvm->fwrt.ppag_table.v1.flags = cpu_to_le32(0);
+			     (mvm->fwrt.ppag_chains[i].subbands[j] > ACPI_PPAG_MAX_HB ||
+			      mvm->fwrt.ppag_chains[i].subbands[j] < ACPI_PPAG_MIN_HB))) {
+				mvm->fwrt.ppag_flags = 0;
 				ret = -EINVAL;
 				goto out_free;
 			}
@@ -1059,6 +1050,7 @@ static int iwl_mvm_get_ppag_table(struct iwl_mvm *mvm)
 
 int iwl_mvm_ppag_send_cmd(struct iwl_mvm *mvm)
 {
+	union iwl_ppag_table_cmd cmd;
 	u8 cmd_ver;
 	int i, j, ret, num_sub_bands, cmd_size;
 	s8 *gain;
@@ -1068,37 +1060,39 @@ int iwl_mvm_ppag_send_cmd(struct iwl_mvm *mvm)
 				"PPAG capability not supported by FW, command not sent.\n");
 		return 0;
 	}
-	if (!mvm->fwrt.ppag_table.v1.flags) {
+	if (!mvm->fwrt.ppag_flags) {
 		IWL_DEBUG_RADIO(mvm, "PPAG not enabled, command not sent.\n");
 		return 0;
 	}
 
+	/* The 'flags' field is the same in v1 and in v2 so we can just
+	 * use v1 to access it.
+	 */
+	cmd.v1.flags = cpu_to_le32(mvm->fwrt.ppag_flags);
 	cmd_ver = iwl_fw_lookup_cmd_ver(mvm->fw, PHY_OPS_GROUP,
 					PER_PLATFORM_ANT_GAIN_CMD,
 					IWL_FW_CMD_VER_UNKNOWN);
 	if (cmd_ver == 1) {
 		num_sub_bands = IWL_NUM_SUB_BANDS_V1;
-		gain = mvm->fwrt.ppag_table.v1.gain[0];
-		cmd_size = sizeof(mvm->fwrt.ppag_table.v1);
+		gain = cmd.v1.gain[0];
+		cmd_size = sizeof(cmd.v1);
 		if (mvm->fwrt.ppag_ver == 1 || mvm->fwrt.ppag_ver == 2) {
 			IWL_DEBUG_RADIO(mvm,
 					"PPAG table rev is %d but FW supports v1, sending truncated table\n",
 					mvm->fwrt.ppag_ver);
-			mvm->fwrt.ppag_table.v1.flags &=
-				cpu_to_le32(IWL_PPAG_ETSI_MASK);
+			cmd.v1.flags &= cpu_to_le32(IWL_PPAG_ETSI_MASK);
 		}
 	} else if (cmd_ver == 2 || cmd_ver == 3) {
 		num_sub_bands = IWL_NUM_SUB_BANDS_V2;
-		gain = mvm->fwrt.ppag_table.v2.gain[0];
-		cmd_size = sizeof(mvm->fwrt.ppag_table.v2);
+		gain = cmd.v2.gain[0];
+		cmd_size = sizeof(cmd.v2);
 		if (mvm->fwrt.ppag_ver == 0) {
 			IWL_DEBUG_RADIO(mvm,
 					"PPAG table is v1 but FW supports v2, sending padded table\n");
 		} else if (cmd_ver == 2 && mvm->fwrt.ppag_ver == 2) {
 			IWL_DEBUG_RADIO(mvm,
 					"PPAG table is v3 but FW supports v2, sending partial bitmap.\n");
-			mvm->fwrt.ppag_table.v1.flags &=
-				cpu_to_le32(IWL_PPAG_ETSI_MASK);
+			cmd.v1.flags &= cpu_to_le32(IWL_PPAG_ETSI_MASK);
 		}
 	} else {
 		IWL_DEBUG_RADIO(mvm, "Unsupported PPAG command version\n");
@@ -1107,6 +1101,8 @@ int iwl_mvm_ppag_send_cmd(struct iwl_mvm *mvm)
 
 	for (i = 0; i < IWL_NUM_CHAIN_LIMITS; i++) {
 		for (j = 0; j < num_sub_bands; j++) {
+			gain[i * num_sub_bands + j] =
+				mvm->fwrt.ppag_chains[i].subbands[j];
 			IWL_DEBUG_RADIO(mvm,
 					"PPAG table: chain[%d] band[%d]: gain = %d\n",
 					i, j, gain[i * num_sub_bands + j]);
@@ -1115,7 +1111,7 @@ int iwl_mvm_ppag_send_cmd(struct iwl_mvm *mvm)
 	IWL_DEBUG_RADIO(mvm, "Sending PER_PLATFORM_ANT_GAIN_CMD\n");
 	ret = iwl_mvm_send_cmd_pdu(mvm, WIDE_ID(PHY_OPS_GROUP,
 						PER_PLATFORM_ANT_GAIN_CMD),
-				   0, cmd_size, &mvm->fwrt.ppag_table);
+				   0, cmd_size, &cmd);
 	if (ret < 0)
 		IWL_ERR(mvm, "failed to send PER_PLATFORM_ANT_GAIN_CMD (%d)\n",
 			ret);
@@ -1154,7 +1150,7 @@ static int iwl_mvm_ppag_init(struct iwl_mvm *mvm)
 		IWL_DEBUG_RADIO(mvm,
 				"System vendor '%s' is not in the approved list, disabling PPAG.\n",
 				dmi_get_system_info(DMI_SYS_VENDOR));
-		mvm->fwrt.ppag_table.v1.flags = cpu_to_le32(0);
+		mvm->fwrt.ppag_flags = 0;
 		return 0;
 	}
 
-- 
2.34.1

