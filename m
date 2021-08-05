Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74B9A3E13C9
	for <lists+linux-wireless@lfdr.de>; Thu,  5 Aug 2021 13:22:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241031AbhHELW3 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 5 Aug 2021 07:22:29 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:51340 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S240992AbhHELW2 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 5 Aug 2021 07:22:28 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=kveik.lan)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94)
        (envelope-from <luca@coelho.fi>)
        id 1mBbRw-00243p-9n; Thu, 05 Aug 2021 14:22:10 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     luca@coelho.fi, linux-wireless@vger.kernel.org
Date:   Thu,  5 Aug 2021 14:21:56 +0300
Message-Id: <iwlwifi.20210805141826.ce3b60f0b426.I3643bf00e714aae930880cc7d6cf390b142eaccb@changeid>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210805112158.460799-1-luca@coelho.fi>
References: <20210805112158.460799-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.5-pre1 (2020-06-20) on
        farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.5-pre1
Subject: [PATCH 10/12] iwlwifi: mvm: Read the PPAG and SAR tables at INIT stage
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Miri Korenblit <miriam.rachel.korenblit@intel.com>

We used to read the PPAG, WRDS, EWRD, WGDS tables from ACPI
in the load stage only. This prevented vendor commands from
being executed before bringing the interface up. Move reading those tables
to INIT stage.

Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/fw/acpi.c |  16 +--
 drivers/net/wireless/intel/iwlwifi/fw/acpi.h |   2 +-
 drivers/net/wireless/intel/iwlwifi/mvm/fw.c  | 105 +++++++++++--------
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h |   1 +
 drivers/net/wireless/intel/iwlwifi/mvm/ops.c |   2 +
 5 files changed, 69 insertions(+), 57 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/acpi.c b/drivers/net/wireless/intel/iwlwifi/fw/acpi.c
index 78f0f2032c59..1802a451c450 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/acpi.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/acpi.c
@@ -416,8 +416,6 @@ static int iwl_sar_set_profile(union acpi_object *table,
 {
 	int i, j, idx = 0;
 
-	profile->enabled = enabled;
-
 	/*
 	 * The table from ACPI is flat, but we store it in a
 	 * structured array.
@@ -435,6 +433,9 @@ static int iwl_sar_set_profile(union acpi_object *table,
 		}
 	}
 
+	/* Only if all values were valid can the profile be enabled */
+	profile->enabled = enabled;
+
 	return 0;
 }
 
@@ -780,20 +781,11 @@ IWL_EXPORT_SYMBOL(iwl_sar_geo_support);
 int iwl_sar_geo_init(struct iwl_fw_runtime *fwrt,
 		     struct iwl_per_chain_offset *table, u32 n_bands)
 {
-	int ret, i, j;
+	int i, j;
 
 	if (!iwl_sar_geo_support(fwrt))
 		return -EOPNOTSUPP;
 
-	ret = iwl_sar_get_wgds_table(fwrt);
-	if (ret < 0) {
-		IWL_DEBUG_RADIO(fwrt,
-				"Geo SAR BIOS table invalid or unavailable. (%d)\n",
-				ret);
-		/* we don't fail if the table is not available */
-		return -ENOENT;
-	}
-
 	for (i = 0; i < ACPI_NUM_GEO_PROFILES; i++) {
 		for (j = 0; j < n_bands; j++) {
 			struct iwl_per_chain_offset *chain =
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/acpi.h b/drivers/net/wireless/intel/iwlwifi/fw/acpi.h
index 030ea3efcc87..a424186af3c8 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/acpi.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/acpi.h
@@ -265,7 +265,7 @@ static inline int iwl_sar_get_ewrd_table(struct iwl_fw_runtime *fwrt)
 
 static inline int iwl_sar_get_wgds_table(struct iwl_fw_runtime *fwrt)
 {
-	return -ENOENT;
+	return 1;
 }
 
 static inline bool iwl_sar_geo_support(struct iwl_fw_runtime *fwrt)
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
index 0b769aac0b02..74404c96063b 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
@@ -1058,16 +1058,7 @@ static const struct dmi_system_id dmi_ppag_approved_list[] = {
 
 static int iwl_mvm_ppag_init(struct iwl_mvm *mvm)
 {
-	int ret;
-
-	ret = iwl_mvm_get_ppag_table(mvm);
-	if (ret < 0) {
-		IWL_DEBUG_RADIO(mvm,
-				"PPAG BIOS table invalid or unavailable. (%d)\n",
-				ret);
-		return 0;
-	}
-
+	/* no need to read the table, done in INIT stage */
 	if (!dmi_check_system(dmi_ppag_approved_list)) {
 		IWL_DEBUG_RADIO(mvm,
 				"System vendor '%s' is not in the approved list, disabling PPAG.\n",
@@ -1192,12 +1183,65 @@ static void iwl_mvm_lari_cfg(struct iwl_mvm *mvm)
 					ret);
 	}
 }
+
+void iwl_mvm_get_acpi_tables(struct iwl_mvm *mvm)
+{
+	int ret;
+
+	/* read PPAG table */
+	ret = iwl_mvm_get_ppag_table(mvm);
+	if (ret < 0) {
+		IWL_DEBUG_RADIO(mvm,
+				"PPAG BIOS table invalid or unavailable. (%d)\n",
+				ret);
+	}
+
+	/* read SAR tables */
+	ret = iwl_sar_get_wrds_table(&mvm->fwrt);
+	if (ret < 0) {
+		IWL_DEBUG_RADIO(mvm,
+				"WRDS SAR BIOS table invalid or unavailable. (%d)\n",
+				ret);
+		/*
+		 * If not available, don't fail and don't bother with EWRD and
+		 * WGDS */
+
+		if (!iwl_sar_get_wgds_table(&mvm->fwrt)) {
+			/*
+			 * If basic SAR is not available, we check for WGDS,
+			 * which should *not* be available either.  If it is
+			 * available, issue an error, because we can't use SAR
+			 * Geo without basic SAR.
+			 */
+			IWL_ERR(mvm, "BIOS contains WGDS but no WRDS\n");
+		}
+
+	} else {
+		ret = iwl_sar_get_ewrd_table(&mvm->fwrt);
+		/* if EWRD is not available, we can still use
+		* WRDS, so don't fail */
+		if (ret < 0)
+			IWL_DEBUG_RADIO(mvm,
+					"EWRD SAR BIOS table invalid or unavailable. (%d)\n",
+					ret);
+
+		/* read geo SAR table */
+		if (iwl_sar_geo_support(&mvm->fwrt)) {
+			ret = iwl_sar_get_wgds_table(&mvm->fwrt);
+			if (ret < 0)
+				IWL_DEBUG_RADIO(mvm,
+						"Geo SAR BIOS table invalid or unavailable. (%d)\n",
+						ret);
+				/* we don't fail if the table is not available */
+		}
+	}
+}
 #else /* CONFIG_ACPI */
 
 inline int iwl_mvm_sar_select_profile(struct iwl_mvm *mvm,
 				      int prof_a, int prof_b)
 {
-	return -ENOENT;
+	return 1;
 }
 
 inline int iwl_mvm_get_sar_geo_profile(struct iwl_mvm *mvm)
@@ -1232,6 +1276,10 @@ static u8 iwl_mvm_eval_dsm_rfi(struct iwl_mvm *mvm)
 {
 	return DSM_VALUE_RFI_DISABLE;
 }
+
+void iwl_mvm_get_acpi_tables(struct iwl_mvm *mvm)
+{
+}
 #endif /* CONFIG_ACPI */
 
 void iwl_mvm_send_recovery_cmd(struct iwl_mvm *mvm, u32 flags)
@@ -1287,27 +1335,6 @@ void iwl_mvm_send_recovery_cmd(struct iwl_mvm *mvm, u32 flags)
 
 static int iwl_mvm_sar_init(struct iwl_mvm *mvm)
 {
-	int ret;
-
-	ret = iwl_sar_get_wrds_table(&mvm->fwrt);
-	if (ret < 0) {
-		IWL_DEBUG_RADIO(mvm,
-				"WRDS SAR BIOS table invalid or unavailable. (%d)\n",
-				ret);
-		/*
-		 * If not available, don't fail and don't bother with EWRD.
-		 * Return 1 to tell that we can't use WGDS either.
-		 */
-		return 1;
-	}
-
-	ret = iwl_sar_get_ewrd_table(&mvm->fwrt);
-	/* if EWRD is not available, we can still use WRDS, so don't fail */
-	if (ret < 0)
-		IWL_DEBUG_RADIO(mvm,
-				"EWRD SAR BIOS table invalid or unavailable. (%d)\n",
-				ret);
-
 	return iwl_mvm_sar_select_profile(mvm, 1, 1);
 }
 
@@ -1543,19 +1570,9 @@ int iwl_mvm_up(struct iwl_mvm *mvm)
 		goto error;
 
 	ret = iwl_mvm_sar_init(mvm);
-	if (ret == 0) {
+	if (ret == 0)
 		ret = iwl_mvm_sar_geo_init(mvm);
-	} else if (ret == -ENOENT && !iwl_sar_get_wgds_table(&mvm->fwrt)) {
-		/*
-		 * If basic SAR is not available, we check for WGDS,
-		 * which should *not* be available either.  If it is
-		 * available, issue an error, because we can't use SAR
-		 * Geo without basic SAR.
-		 */
-		IWL_ERR(mvm, "BIOS contains WGDS but no WRDS\n");
-	}
-
-	if (ret < 0)
+	else if (ret < 0)
 		goto error;
 
 	iwl_mvm_tas_init(mvm);
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
index 82a53cbf4342..f877d86b038e 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
@@ -2043,6 +2043,7 @@ void iwl_mvm_event_frame_timeout_callback(struct iwl_mvm *mvm,
 int iwl_mvm_sar_select_profile(struct iwl_mvm *mvm, int prof_a, int prof_b);
 int iwl_mvm_get_sar_geo_profile(struct iwl_mvm *mvm);
 int iwl_mvm_ppag_send_cmd(struct iwl_mvm *mvm);
+void iwl_mvm_get_acpi_tables(struct iwl_mvm *mvm);
 #ifdef CONFIG_IWLWIFI_DEBUGFS
 void iwl_mvm_sta_add_debugfs(struct ieee80211_hw *hw,
 			     struct ieee80211_vif *vif,
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/ops.c b/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
index f57d2643135b..edff2cd3a30e 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
@@ -771,6 +771,8 @@ iwl_op_mode_mvm_start(struct iwl_trans *trans, const struct iwl_cfg *cfg,
 	iwl_fw_runtime_init(&mvm->fwrt, trans, fw, &iwl_mvm_fwrt_ops, mvm,
 			    dbgfs_dir);
 
+	iwl_mvm_get_acpi_tables(mvm);
+
 	mvm->init_status = 0;
 
 	if (iwl_mvm_has_new_rx_api(mvm)) {
-- 
2.32.0

