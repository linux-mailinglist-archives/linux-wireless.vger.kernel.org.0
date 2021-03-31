Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C58934FC5C
	for <lists+linux-wireless@lfdr.de>; Wed, 31 Mar 2021 11:16:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234647AbhCaJPg (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 31 Mar 2021 05:15:36 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:43764 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S234501AbhCaJPD (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 31 Mar 2021 05:15:03 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=kveik.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94)
        (envelope-from <luca@coelho.fi>)
        id 1lRWwE-00087q-Nh; Wed, 31 Mar 2021 12:15:00 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Wed, 31 Mar 2021 12:14:47 +0300
Message-Id: <iwlwifi.20210331121101.69af388d0dce.I8cfddf9e6837bf394b00390181b4b774ded19acd@changeid>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20210331091452.543321-1-luca@coelho.fi>
References: <20210331091452.543321-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.5-pre1 (2020-06-20) on
        farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.5-pre1
Subject: [PATCH 07/12] iwlwifi: mvm: enable PPAG in China
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Miri Korenblit <miriam.rachel.korenblit@intel.com>

Add support for ppag in China by reading revision 2 of the ppag table
from ACPI, and passing the data to the FW.
This is needed to enable OEMs to control ppag enablement
in China.

Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/fw/acpi.c  |  9 +--
 drivers/net/wireless/intel/iwlwifi/fw/acpi.h  |  4 +-
 .../net/wireless/intel/iwlwifi/fw/api/power.h | 22 +++---
 drivers/net/wireless/intel/iwlwifi/mvm/fw.c   | 76 ++++++++++++-------
 4 files changed, 65 insertions(+), 46 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/acpi.c b/drivers/net/wireless/intel/iwlwifi/fw/acpi.c
index 82a4f7e8ba54..56c4d05c9cc2 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/acpi.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/acpi.c
@@ -181,14 +181,13 @@ union acpi_object *iwl_acpi_get_wifi_pkg(struct device *dev,
 	/*
 	 * We need at least two packages, one for the revision and one
 	 * for the data itself.  Also check that the revision is valid
-	 * (i.e. it is an integer smaller than 2, as we currently support only
-	 * 2 revisions).
+	 * (i.e. it is an integer (each caller has to check by itself
+	 * if the returned revision is supported)).
 	 */
 	if (data->type != ACPI_TYPE_PACKAGE ||
 	    data->package.count < 2 ||
-	    data->package.elements[0].type != ACPI_TYPE_INTEGER ||
-	    data->package.elements[0].integer.value > 1) {
-		IWL_DEBUG_DEV_RADIO(dev, "Unsupported packages structure\n");
+	    data->package.elements[0].type != ACPI_TYPE_INTEGER) {
+		IWL_DEBUG_DEV_RADIO(dev, "Invalid packages structure\n");
 		return ERR_PTR(-EINVAL);
 	}
 
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/acpi.h b/drivers/net/wireless/intel/iwlwifi/fw/acpi.h
index 030c50082568..f8ea588e4fbb 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/acpi.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/acpi.h
@@ -53,8 +53,8 @@
 
 #define ACPI_WGDS_TABLE_SIZE		3
 
-#define ACPI_PPAG_WIFI_DATA_SIZE	((IWL_NUM_CHAIN_LIMITS * \
-					  IWL_NUM_SUB_BANDS) + 2)
+#define ACPI_PPAG_WIFI_DATA_SIZE_V1	((IWL_NUM_CHAIN_LIMITS * \
+					  IWL_NUM_SUB_BANDS_V1) + 2)
 #define ACPI_PPAG_WIFI_DATA_SIZE_V2	((IWL_NUM_CHAIN_LIMITS * \
 					  IWL_NUM_SUB_BANDS_V2) + 2)
 
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/power.h b/drivers/net/wireless/intel/iwlwifi/fw/api/power.h
index 798417182d54..86445385f072 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/power.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/power.h
@@ -274,7 +274,7 @@ enum iwl_dev_tx_power_cmd_mode {
 #define IWL_NUM_CHAIN_TABLES	1
 #define IWL_NUM_CHAIN_TABLES_V2	2
 #define IWL_NUM_CHAIN_LIMITS	2
-#define IWL_NUM_SUB_BANDS	5
+#define IWL_NUM_SUB_BANDS_V1	5
 #define IWL_NUM_SUB_BANDS_V2	11
 
 /**
@@ -300,7 +300,7 @@ struct iwl_dev_tx_power_common {
  * @per_chain: per chain restrictions
  */
 struct iwl_dev_tx_power_cmd_v3 {
-	__le16 per_chain[IWL_NUM_CHAIN_TABLES][IWL_NUM_CHAIN_LIMITS][IWL_NUM_SUB_BANDS];
+	__le16 per_chain[IWL_NUM_CHAIN_TABLES][IWL_NUM_CHAIN_LIMITS][IWL_NUM_SUB_BANDS_V1];
 } __packed; /* TX_REDUCED_POWER_API_S_VER_3 */
 
 #define IWL_DEV_MAX_TX_POWER 0x7FFF
@@ -313,7 +313,7 @@ struct iwl_dev_tx_power_cmd_v3 {
  * @reserved: reserved (padding)
  */
 struct iwl_dev_tx_power_cmd_v4 {
-	__le16 per_chain[IWL_NUM_CHAIN_TABLES][IWL_NUM_CHAIN_LIMITS][IWL_NUM_SUB_BANDS];
+	__le16 per_chain[IWL_NUM_CHAIN_TABLES][IWL_NUM_CHAIN_LIMITS][IWL_NUM_SUB_BANDS_V1];
 	u8 enable_ack_reduction;
 	u8 reserved[3];
 } __packed; /* TX_REDUCED_POWER_API_S_VER_4 */
@@ -332,7 +332,7 @@ struct iwl_dev_tx_power_cmd_v4 {
  *	BIOS values. relevant if setMode is IWL_TX_POWER_MODE_SET_SAR_TIMER
  */
 struct iwl_dev_tx_power_cmd_v5 {
-	__le16 per_chain[IWL_NUM_CHAIN_TABLES][IWL_NUM_CHAIN_LIMITS][IWL_NUM_SUB_BANDS];
+	__le16 per_chain[IWL_NUM_CHAIN_TABLES][IWL_NUM_CHAIN_LIMITS][IWL_NUM_SUB_BANDS_V1];
 	u8 enable_ack_reduction;
 	u8 per_chain_restriction_changed;
 	u8 reserved[2];
@@ -454,21 +454,23 @@ struct iwl_geo_tx_power_profiles_resp {
 
 /**
  * union iwl_ppag_table_cmd - union for all versions of PPAG command
- * @v1: version 1, table revision = 0
- * @v2: version 2, table revision = 1
+ * @v1: version 1
+ * @v2: version 2
  *
- * @enabled: 1 if PPAG is enabled, 0 otherwise
+ * @flags: bit 0 - indicates enablement of PPAG for ETSI
+ *         bit 1 - indicates enablement of PPAG for CHINA BIOS
+ *         bit 1 can be used only in v3 (identical to v2)
  * @gain: table of antenna gain values per chain and sub-band
  * @reserved: reserved
  */
 union iwl_ppag_table_cmd {
 	struct {
-		__le32 enabled;
-		s8 gain[IWL_NUM_CHAIN_LIMITS][IWL_NUM_SUB_BANDS];
+		__le32 flags;
+		s8 gain[IWL_NUM_CHAIN_LIMITS][IWL_NUM_SUB_BANDS_V1];
 		s8 reserved[2];
 	} v1;
 	struct {
-		__le32 enabled;
+		__le32 flags;
 		s8 gain[IWL_NUM_CHAIN_LIMITS][IWL_NUM_SUB_BANDS_V2];
 		s8 reserved[2];
 	} v2;
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
index 5ee64f7f3c85..4f297edd8e18 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
@@ -29,6 +29,9 @@
 
 #define UCODE_VALID_OK	cpu_to_le32(0x1)
 
+#define IWL_PPAG_MASK 3
+#define IWL_PPAG_ETSI_MASK BIT(0)
+
 struct iwl_mvm_alive_data {
 	bool valid;
 	u32 scd_base_addr;
@@ -773,16 +776,16 @@ int iwl_mvm_sar_select_profile(struct iwl_mvm *mvm, int prof_a, int prof_b)
 	} else if (fw_has_api(&mvm->fw->ucode_capa,
 			      IWL_UCODE_TLV_API_REDUCE_TX_POWER)) {
 		len = sizeof(cmd.v5);
-		n_subbands = IWL_NUM_SUB_BANDS;
+		n_subbands = IWL_NUM_SUB_BANDS_V1;
 		per_chain = cmd.v5.per_chain[0][0];
 	} else if (fw_has_capa(&mvm->fw->ucode_capa,
 			       IWL_UCODE_TLV_CAPA_TX_POWER_ACK)) {
 		len = sizeof(cmd.v4);
-		n_subbands = IWL_NUM_SUB_BANDS;
+		n_subbands = IWL_NUM_SUB_BANDS_V1;
 		per_chain = cmd.v4.per_chain[0][0];
 	} else {
 		len = sizeof(cmd.v3);
-		n_subbands = IWL_NUM_SUB_BANDS;
+		n_subbands = IWL_NUM_SUB_BANDS_V1;
 		per_chain = cmd.v3.per_chain[0][0];
 	}
 
@@ -909,46 +912,50 @@ static int iwl_mvm_sar_geo_init(struct iwl_mvm *mvm)
 
 static int iwl_mvm_get_ppag_table(struct iwl_mvm *mvm)
 {
-	union acpi_object *wifi_pkg, *data, *enabled;
+	union acpi_object *wifi_pkg, *data, *flags;
 	int i, j, ret, tbl_rev, num_sub_bands;
 	int idx = 2;
 	s8 *gain;
 
 	/*
-	 * The 'enabled' field is the same in v1 and v2 so we can just
+	 * The 'flags' field is the same in v1 and in v2 so we can just
 	 * use v1 to access it.
 	 */
-	mvm->fwrt.ppag_table.v1.enabled = cpu_to_le32(0);
+	mvm->fwrt.ppag_table.v1.flags = cpu_to_le32(0);
+
 	data = iwl_acpi_get_object(mvm->dev, ACPI_PPAG_METHOD);
 	if (IS_ERR(data))
 		return PTR_ERR(data);
 
-	/* try to read ppag table revision 1 */
+	/* try to read ppag table rev 2 or 1 (both have the same data size) */
 	wifi_pkg = iwl_acpi_get_wifi_pkg(mvm->dev, data,
 					 ACPI_PPAG_WIFI_DATA_SIZE_V2, &tbl_rev);
 	if (!IS_ERR(wifi_pkg)) {
-		if (tbl_rev != 1) {
+		if (tbl_rev == 1 || tbl_rev == 2) {
+			num_sub_bands = IWL_NUM_SUB_BANDS_V2;
+			gain = mvm->fwrt.ppag_table.v2.gain[0];
+			mvm->fwrt.ppag_ver = tbl_rev;
+			IWL_DEBUG_RADIO(mvm,
+					"Reading PPAG table v2 (tbl_rev=%d)\n",
+					tbl_rev);
+			goto read_table;
+		} else {
 			ret = -EINVAL;
 			goto out_free;
 		}
-		num_sub_bands = IWL_NUM_SUB_BANDS_V2;
-		gain = mvm->fwrt.ppag_table.v2.gain[0];
-		mvm->fwrt.ppag_ver = 2;
-		IWL_DEBUG_RADIO(mvm, "Reading PPAG table v2 (tbl_rev=1)\n");
-		goto read_table;
 	}
 
 	/* try to read ppag table revision 0 */
 	wifi_pkg = iwl_acpi_get_wifi_pkg(mvm->dev, data,
-					 ACPI_PPAG_WIFI_DATA_SIZE, &tbl_rev);
+					 ACPI_PPAG_WIFI_DATA_SIZE_V1, &tbl_rev);
 	if (!IS_ERR(wifi_pkg)) {
 		if (tbl_rev != 0) {
 			ret = -EINVAL;
 			goto out_free;
 		}
-		num_sub_bands = IWL_NUM_SUB_BANDS;
+		num_sub_bands = IWL_NUM_SUB_BANDS_V1;
 		gain = mvm->fwrt.ppag_table.v1.gain[0];
-		mvm->fwrt.ppag_ver = 1;
+		mvm->fwrt.ppag_ver = 0;
 		IWL_DEBUG_RADIO(mvm, "Reading PPAG table v1 (tbl_rev=0)\n");
 		goto read_table;
 	}
@@ -956,15 +963,17 @@ static int iwl_mvm_get_ppag_table(struct iwl_mvm *mvm)
 	goto out_free;
 
 read_table:
-	enabled = &wifi_pkg->package.elements[1];
-	if (enabled->type != ACPI_TYPE_INTEGER ||
-	    (enabled->integer.value != 0 && enabled->integer.value != 1)) {
+	flags = &wifi_pkg->package.elements[1];
+
+	if (flags->type != ACPI_TYPE_INTEGER) {
 		ret = -EINVAL;
 		goto out_free;
 	}
 
-	mvm->fwrt.ppag_table.v1.enabled = cpu_to_le32(enabled->integer.value);
-	if (!mvm->fwrt.ppag_table.v1.enabled) {
+	mvm->fwrt.ppag_table.v1.flags = cpu_to_le32(flags->integer.value &
+						    IWL_PPAG_MASK);
+
+	if (!mvm->fwrt.ppag_table.v1.flags) {
 		ret = 0;
 		goto out_free;
 	}
@@ -992,12 +1001,13 @@ static int iwl_mvm_get_ppag_table(struct iwl_mvm *mvm)
 			    (j != 0 &&
 			     (gain[i * num_sub_bands + j] > ACPI_PPAG_MAX_HB ||
 			      gain[i * num_sub_bands + j] < ACPI_PPAG_MIN_HB))) {
-				mvm->fwrt.ppag_table.v1.enabled = cpu_to_le32(0);
+				mvm->fwrt.ppag_table.v1.flags = cpu_to_le32(0);
 				ret = -EINVAL;
 				goto out_free;
 			}
 		}
 	}
+
 	ret = 0;
 out_free:
 	kfree(data);
@@ -1015,7 +1025,7 @@ int iwl_mvm_ppag_send_cmd(struct iwl_mvm *mvm)
 				"PPAG capability not supported by FW, command not sent.\n");
 		return 0;
 	}
-	if (!mvm->fwrt.ppag_table.v1.enabled) {
+	if (!mvm->fwrt.ppag_table.v1.flags) {
 		IWL_DEBUG_RADIO(mvm, "PPAG not enabled, command not sent.\n");
 		return 0;
 	}
@@ -1024,20 +1034,28 @@ int iwl_mvm_ppag_send_cmd(struct iwl_mvm *mvm)
 					PER_PLATFORM_ANT_GAIN_CMD,
 					IWL_FW_CMD_VER_UNKNOWN);
 	if (cmd_ver == 1) {
-		num_sub_bands = IWL_NUM_SUB_BANDS;
+		num_sub_bands = IWL_NUM_SUB_BANDS_V1;
 		gain = mvm->fwrt.ppag_table.v1.gain[0];
 		cmd_size = sizeof(mvm->fwrt.ppag_table.v1);
-		if (mvm->fwrt.ppag_ver == 2) {
+		if (mvm->fwrt.ppag_ver == 1 || mvm->fwrt.ppag_ver == 2) {
 			IWL_DEBUG_RADIO(mvm,
-					"PPAG table is v2 but FW supports v1, sending truncated table\n");
+					"PPAG table rev is %d but FW supports v1, sending truncated table\n",
+					mvm->fwrt.ppag_ver);
+			mvm->fwrt.ppag_table.v1.flags &=
+				cpu_to_le32(IWL_PPAG_ETSI_MASK);
 		}
-	} else if (cmd_ver == 2) {
+	} else if (cmd_ver == 2 || cmd_ver == 3) {
 		num_sub_bands = IWL_NUM_SUB_BANDS_V2;
 		gain = mvm->fwrt.ppag_table.v2.gain[0];
 		cmd_size = sizeof(mvm->fwrt.ppag_table.v2);
-		if (mvm->fwrt.ppag_ver == 1) {
+		if (mvm->fwrt.ppag_ver == 0) {
 			IWL_DEBUG_RADIO(mvm,
 					"PPAG table is v1 but FW supports v2, sending padded table\n");
+		} else if (cmd_ver == 2 && mvm->fwrt.ppag_ver == 2) {
+			IWL_DEBUG_RADIO(mvm,
+					"PPAG table is v3 but FW supports v2, sending partial bitmap.\n");
+			mvm->fwrt.ppag_table.v1.flags &=
+				cpu_to_le32(IWL_PPAG_ETSI_MASK);
 		}
 	} else {
 		IWL_DEBUG_RADIO(mvm, "Unsupported PPAG command version\n");
@@ -1102,7 +1120,7 @@ static int iwl_mvm_ppag_init(struct iwl_mvm *mvm)
 		IWL_DEBUG_RADIO(mvm,
 				"System vendor '%s' is not in the approved list, disabling PPAG.\n",
 				dmi_get_system_info(DMI_SYS_VENDOR));
-		mvm->fwrt.ppag_table.v1.enabled = cpu_to_le32(0);
+		mvm->fwrt.ppag_table.v1.flags = cpu_to_le32(0);
 		return 0;
 	}
 
-- 
2.31.0

