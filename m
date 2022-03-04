Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 427DC4CD342
	for <lists+linux-wireless@lfdr.de>; Fri,  4 Mar 2022 12:21:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239110AbiCDLWZ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 4 Mar 2022 06:22:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235765AbiCDLWY (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 4 Mar 2022 06:22:24 -0500
Received: from farmhouse.coelho.fi (paleale.coelho.fi [176.9.41.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28C5B137754
        for <linux-wireless@vger.kernel.org>; Fri,  4 Mar 2022 03:21:37 -0800 (PST)
Received: from 91-156-4-241.elisa-laajakaista.fi ([91.156.4.241] helo=kveik.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.95)
        (envelope-from <luca@coelho.fi>)
        id 1nQ604-000QSW-Tj;
        Fri, 04 Mar 2022 13:21:35 +0200
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@kernel.org
Cc:     luca@coelho.fi, linux-wireless@vger.kernel.org
Date:   Fri,  4 Mar 2022 13:21:18 +0200
Message-Id: <iwlwifi.20220304131517.55c2f014f5ee.Iceb632f620de959800f979e212f0dc20240f9d38@changeid>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220304112129.219513-1-luca@coelho.fi>
References: <20220304112129.219513-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,KHOP_HELO_FCRDNS,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
Subject: [PATCH 02/13] iwlwifi: mvm: add a flag to reduce power command.
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Ayala Barazani <ayala.barazani@intel.com>

Add a flags bitfield in REDUCED_TX_POWER_CMD, and
send it as is to FW.

Signed-off-by: Ayala Barazani <ayala.barazani@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/fw/acpi.c  |  8 +++---
 drivers/net/wireless/intel/iwlwifi/fw/acpi.h  |  3 +++
 .../net/wireless/intel/iwlwifi/fw/api/power.h | 27 +++++++++++++++++--
 .../net/wireless/intel/iwlwifi/fw/runtime.h   |  3 ++-
 drivers/net/wireless/intel/iwlwifi/mvm/fw.c   |  8 ++++--
 .../net/wireless/intel/iwlwifi/mvm/mac80211.c |  4 ++-
 6 files changed, 44 insertions(+), 9 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/acpi.c b/drivers/net/wireless/intel/iwlwifi/fw/acpi.c
index 0e9e61508ae5..4441f92c004f 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/acpi.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/acpi.c
@@ -537,8 +537,8 @@ IWL_EXPORT_SYMBOL(iwl_sar_select_profile);
 int iwl_sar_get_wrds_table(struct iwl_fw_runtime *fwrt)
 {
 	union acpi_object *wifi_pkg, *table, *data;
-	bool enabled;
 	int ret, tbl_rev;
+	u32 flags;
 	u8 num_chains, num_sub_bands;
 
 	data = iwl_acpi_get_object(fwrt->dev, ACPI_WRDS_METHOD);
@@ -604,7 +604,8 @@ int iwl_sar_get_wrds_table(struct iwl_fw_runtime *fwrt)
 
 	IWL_DEBUG_RADIO(fwrt, "Reading WRDS tbl_rev=%d\n", tbl_rev);
 
-	enabled = !!(wifi_pkg->package.elements[1].integer.value);
+	flags = wifi_pkg->package.elements[1].integer.value;
+	fwrt->reduced_power_flags = flags >> IWL_REDUCE_POWER_FLAGS_POS;
 
 	/* position of the actual table */
 	table = &wifi_pkg->package.elements[2];
@@ -612,7 +613,8 @@ int iwl_sar_get_wrds_table(struct iwl_fw_runtime *fwrt)
 	/* The profile from WRDS is officially profile 1, but goes
 	 * into sar_profiles[0] (because we don't have a profile 0).
 	 */
-	ret = iwl_sar_set_profile(table, &fwrt->sar_profiles[0], enabled,
+	ret = iwl_sar_set_profile(table, &fwrt->sar_profiles[0],
+				  flags & IWL_SAR_ENABLE_MSK,
 				  num_chains, num_sub_bands);
 out_free:
 	kfree(data);
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/acpi.h b/drivers/net/wireless/intel/iwlwifi/fw/acpi.h
index 466c95c21aa9..089dd9002528 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/acpi.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/acpi.h
@@ -92,6 +92,9 @@
 #define ACPI_PPAG_MIN_HB -16
 #define ACPI_PPAG_MAX_HB 40
 
+#define IWL_SAR_ENABLE_MSK		BIT(0)
+#define IWL_REDUCE_POWER_FLAGS_POS	1
+
 /*
  * The profile for revision 2 is a superset of revision 1, which is in
  * turn a superset of revision 0.  So we can store all revisions
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/power.h b/drivers/net/wireless/intel/iwlwifi/fw/api/power.h
index 81318208f2f6..f92cac1da764 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/power.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/power.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
 /*
- * Copyright (C) 2012-2014, 2018-2021 Intel Corporation
+ * Copyright (C) 2012-2014, 2018-2022 Intel Corporation
  * Copyright (C) 2013-2014 Intel Mobile Communications GmbH
  * Copyright (C) 2015-2017 Intel Deutschland GmbH
  */
@@ -340,7 +340,7 @@ struct iwl_dev_tx_power_cmd_v5 {
 } __packed; /* TX_REDUCED_POWER_API_S_VER_5 */
 
 /**
- * struct iwl_dev_tx_power_cmd_v5 - TX power reduction command version 5
+ * struct iwl_dev_tx_power_cmd_v6 - TX power reduction command version 6
  * @per_chain: per chain restrictions
  * @enable_ack_reduction: enable or disable close range ack TX power
  *	reduction.
@@ -360,6 +360,28 @@ struct iwl_dev_tx_power_cmd_v6 {
 	__le32 timer_period;
 } __packed; /* TX_REDUCED_POWER_API_S_VER_6 */
 
+/**
+ * struct iwl_dev_tx_power_cmd_v7 - TX power reduction command version 7
+ * @per_chain: per chain restrictions
+ * @enable_ack_reduction: enable or disable close range ack TX power
+ *	reduction.
+ * @per_chain_restriction_changed: is per_chain_restriction has changed
+ *	from last command. used if set_mode is
+ *	IWL_TX_POWER_MODE_SET_SAR_TIMER.
+ *	note: if not changed, the command is used for keep alive only.
+ * @reserved: reserved (padding)
+ * @timer_period: timer in milliseconds. if expires FW will change to default
+ *	BIOS values. relevant if setMode is IWL_TX_POWER_MODE_SET_SAR_TIMER
+ * @flags: reduce power flags.
+ */
+struct iwl_dev_tx_power_cmd_v7 {
+	__le16 per_chain[IWL_NUM_CHAIN_TABLES_V2][IWL_NUM_CHAIN_LIMITS][IWL_NUM_SUB_BANDS_V2];
+	u8 enable_ack_reduction;
+	u8 per_chain_restriction_changed;
+	u8 reserved[2];
+	__le32 timer_period;
+	__le32 flags;
+} __packed; /* TX_REDUCED_POWER_API_S_VER_7 */
 /**
  * struct iwl_dev_tx_power_cmd - TX power reduction command (multiversion)
  * @common: common part of the command
@@ -375,6 +397,7 @@ struct iwl_dev_tx_power_cmd {
 		struct iwl_dev_tx_power_cmd_v4 v4;
 		struct iwl_dev_tx_power_cmd_v5 v5;
 		struct iwl_dev_tx_power_cmd_v6 v6;
+		struct iwl_dev_tx_power_cmd_v7 v7;
 	};
 };
 
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/runtime.h b/drivers/net/wireless/intel/iwlwifi/fw/runtime.h
index afc822cab674..d3cb1ae68a96 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/runtime.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/runtime.h
@@ -1,7 +1,7 @@
 /* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
 /*
  * Copyright (C) 2017 Intel Deutschland GmbH
- * Copyright (C) 2018-2020 Intel Corporation
+ * Copyright (C) 2018-2022 Intel Corporation
  */
 #ifndef __iwl_fw_runtime_h__
 #define __iwl_fw_runtime_h__
@@ -163,6 +163,7 @@ struct iwl_fw_runtime {
 	u32 ppag_ver;
 	struct iwl_sar_offset_mapping_cmd sgom_table;
 	bool sgom_enabled;
+	u8 reduced_power_flags;
 #endif
 };
 
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
index 8537e1ea27d6..a178b83ee8a2 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
@@ -806,8 +806,12 @@ int iwl_mvm_sar_select_profile(struct iwl_mvm *mvm, int prof_a, int prof_b)
 	u32 n_subbands;
 	u8 cmd_ver = iwl_fw_lookup_cmd_ver(mvm->fw, cmd_id,
 					   IWL_FW_CMD_VER_UNKNOWN);
-
-	if (cmd_ver == 6) {
+	if (cmd_ver == 7) {
+		len = sizeof(cmd.v7);
+		n_subbands = IWL_NUM_SUB_BANDS_V2;
+		per_chain = cmd.v7.per_chain[0][0];
+		cmd.v7.flags = cpu_to_le32(mvm->fwrt.reduced_power_flags);
+	} else if (cmd_ver == 6) {
 		len = sizeof(cmd.v6);
 		n_subbands = IWL_NUM_SUB_BANDS_V2;
 		per_chain = cmd.v6.per_chain[0][0];
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
index 6a9d9ce0007a..2ce09e58e74c 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
@@ -1336,7 +1336,9 @@ static int iwl_mvm_set_tx_power(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
 	if (tx_power == IWL_DEFAULT_MAX_TX_POWER)
 		cmd.common.pwr_restriction = cpu_to_le16(IWL_DEV_MAX_TX_POWER);
 
-	if (cmd_ver == 6)
+	if (cmd_ver == 7)
+		len = sizeof(cmd.v7);
+	else if (cmd_ver == 6)
 		len = sizeof(cmd.v6);
 	else if (fw_has_api(&mvm->fw->ucode_capa,
 			    IWL_UCODE_TLV_API_REDUCE_TX_POWER))
-- 
2.35.1

