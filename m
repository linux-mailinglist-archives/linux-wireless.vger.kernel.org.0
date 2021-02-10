Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A0033169E0
	for <lists+linux-wireless@lfdr.de>; Wed, 10 Feb 2021 16:16:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231817AbhBJPQL (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 10 Feb 2021 10:16:11 -0500
Received: from paleale.coelho.fi ([176.9.41.70]:45250 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S231626AbhBJPQH (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 10 Feb 2021 10:16:07 -0500
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <luca@coelho.fi>)
        id 1l9rD4-0049kS-H9; Wed, 10 Feb 2021 17:15:18 +0200
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Wed, 10 Feb 2021 17:15:06 +0200
Message-Id: <iwlwifi.20210210171218.a92ee491863d.I047923aa3598fbf4fb6fce2cdff75a4969fedd76@changeid>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210210151514.416221-1-luca@coelho.fi>
References: <20210210151514.416221-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.4
Subject: [PATCH 04/12] iwlwifi: mvm: simplify iwl_mvm_dbgfs_register
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Emmanuel Grumbach <emmanuel.grumbach@intel.com>

No need to pass the dbgfs_dir just to assign it to mvm.
Assign to mvm and then call iwl_mvm_dbgfs_register.

This is a preparation towards the addition of a delayed
op_mode_start flow.
This will allow to split the op_mode_start flow.
Registration to debugfs must happen after we register to
mac80211 and the registration to mac80211 will soon be
delayed in certain cases. In order not to have to remember
the debugfs_dir in a separate variable, just set it into
the mvm structure so that it can be usable later.

Declare mvm->debugfs_dir in the iwl_mvm structure even when
IWLWIFI_DEBUGFS isn't enabled to simplify the source code.

Signed-off-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 .../net/wireless/intel/iwlwifi/mvm/debugfs.c  | 25 +++++++++----------
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h  | 11 +++++---
 drivers/net/wireless/intel/iwlwifi/mvm/ops.c  |  3 ++-
 3 files changed, 21 insertions(+), 18 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/debugfs.c b/drivers/net/wireless/intel/iwlwifi/mvm/debugfs.c
index 90143b16e665..130760572262 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/debugfs.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/debugfs.c
@@ -2037,26 +2037,24 @@ void iwl_mvm_sta_add_debugfs(struct ieee80211_hw *hw,
 	MVM_DEBUGFS_ADD_STA_FILE(amsdu_len, dir, 0600);
 }
 
-void iwl_mvm_dbgfs_register(struct iwl_mvm *mvm, struct dentry *dbgfs_dir)
+void iwl_mvm_dbgfs_register(struct iwl_mvm *mvm)
 {
 	struct dentry *bcast_dir __maybe_unused;
 	char buf[100];
 
 	spin_lock_init(&mvm->drv_stats_lock);
 
-	mvm->debugfs_dir = dbgfs_dir;
-
 	MVM_DEBUGFS_ADD_FILE(tx_flush, mvm->debugfs_dir, 0200);
 	MVM_DEBUGFS_ADD_FILE(sta_drain, mvm->debugfs_dir, 0200);
 	MVM_DEBUGFS_ADD_FILE(sram, mvm->debugfs_dir, 0600);
 	MVM_DEBUGFS_ADD_FILE(set_nic_temperature, mvm->debugfs_dir, 0600);
-	MVM_DEBUGFS_ADD_FILE(nic_temp, dbgfs_dir, 0400);
-	MVM_DEBUGFS_ADD_FILE(ctdp_budget, dbgfs_dir, 0400);
-	MVM_DEBUGFS_ADD_FILE(stop_ctdp, dbgfs_dir, 0200);
-	MVM_DEBUGFS_ADD_FILE(force_ctkill, dbgfs_dir, 0200);
-	MVM_DEBUGFS_ADD_FILE(stations, dbgfs_dir, 0400);
-	MVM_DEBUGFS_ADD_FILE(bt_notif, dbgfs_dir, 0400);
-	MVM_DEBUGFS_ADD_FILE(bt_cmd, dbgfs_dir, 0400);
+	MVM_DEBUGFS_ADD_FILE(nic_temp, mvm->debugfs_dir, 0400);
+	MVM_DEBUGFS_ADD_FILE(ctdp_budget, mvm->debugfs_dir, 0400);
+	MVM_DEBUGFS_ADD_FILE(stop_ctdp, mvm->debugfs_dir, 0200);
+	MVM_DEBUGFS_ADD_FILE(force_ctkill, mvm->debugfs_dir, 0200);
+	MVM_DEBUGFS_ADD_FILE(stations, mvm->debugfs_dir, 0400);
+	MVM_DEBUGFS_ADD_FILE(bt_notif, mvm->debugfs_dir, 0400);
+	MVM_DEBUGFS_ADD_FILE(bt_cmd, mvm->debugfs_dir, 0400);
 	MVM_DEBUGFS_ADD_FILE(disable_power_off, mvm->debugfs_dir, 0600);
 	MVM_DEBUGFS_ADD_FILE(fw_ver, mvm->debugfs_dir, 0400);
 	MVM_DEBUGFS_ADD_FILE(fw_rx_stats, mvm->debugfs_dir, 0400);
@@ -2079,7 +2077,7 @@ void iwl_mvm_dbgfs_register(struct iwl_mvm *mvm, struct dentry *dbgfs_dir)
 	if (mvm->fw->phy_integration_ver)
 		MVM_DEBUGFS_ADD_FILE(phy_integration_ver, mvm->debugfs_dir, 0400);
 #ifdef CONFIG_ACPI
-	MVM_DEBUGFS_ADD_FILE(sar_geo_profile, dbgfs_dir, 0400);
+	MVM_DEBUGFS_ADD_FILE(sar_geo_profile, mvm->debugfs_dir, 0400);
 #endif
 	MVM_DEBUGFS_ADD_FILE(he_sniffer_params, mvm->debugfs_dir, 0600);
 
@@ -2131,12 +2129,13 @@ void iwl_mvm_dbgfs_register(struct iwl_mvm *mvm, struct dentry *dbgfs_dir)
 	debugfs_create_blob("nvm_reg", S_IRUSR,
 			    mvm->debugfs_dir, &mvm->nvm_reg_blob);
 
-	debugfs_create_file("mem", 0600, dbgfs_dir, mvm, &iwl_dbgfs_mem_ops);
+	debugfs_create_file("mem", 0600, mvm->debugfs_dir, mvm,
+			    &iwl_dbgfs_mem_ops);
 
 	/*
 	 * Create a symlink with mac80211. It will be removed when mac80211
 	 * exists (before the opmode exists which removes the target.)
 	 */
-	snprintf(buf, 100, "../../%pd2", dbgfs_dir->d_parent);
+	snprintf(buf, 100, "../../%pd2", mvm->debugfs_dir->d_parent);
 	debugfs_create_symlink("iwlwifi", mvm->hw->wiphy->debugfsdir, buf);
 }
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
index 8bc1d8dea432..0a963d01b825 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
@@ -893,8 +893,12 @@ struct iwl_mvm {
 	/* last smart fifo state that was successfully sent to firmware */
 	enum iwl_sf_state sf_state;
 
-#ifdef CONFIG_IWLWIFI_DEBUGFS
+	/*
+	 * Leave this pointer outside the ifdef below so that it can be
+	 * assigned without ifdef in the source code.
+	 */
 	struct dentry *debugfs_dir;
+#ifdef CONFIG_IWLWIFI_DEBUGFS
 	u32 dbgfs_sram_offset, dbgfs_sram_len;
 	u32 dbgfs_prph_reg_addr;
 	bool disable_power_off;
@@ -1700,12 +1704,11 @@ void iwl_mvm_rx_umac_scan_iter_complete_notif(struct iwl_mvm *mvm,
 
 /* MVM debugfs */
 #ifdef CONFIG_IWLWIFI_DEBUGFS
-void iwl_mvm_dbgfs_register(struct iwl_mvm *mvm, struct dentry *dbgfs_dir);
+void iwl_mvm_dbgfs_register(struct iwl_mvm *mvm);
 void iwl_mvm_vif_dbgfs_register(struct iwl_mvm *mvm, struct ieee80211_vif *vif);
 void iwl_mvm_vif_dbgfs_clean(struct iwl_mvm *mvm, struct ieee80211_vif *vif);
 #else
-static inline void iwl_mvm_dbgfs_register(struct iwl_mvm *mvm,
-					  struct dentry *dbgfs_dir)
+static inline void iwl_mvm_dbgfs_register(struct iwl_mvm *mvm)
 {
 }
 static inline void
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/ops.c b/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
index 573c4548e441..a690f3a67d7c 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
@@ -907,7 +907,8 @@ iwl_op_mode_mvm_start(struct iwl_trans *trans, const struct iwl_cfg *cfg,
 		goto out_thermal_exit;
 	mvm->hw_registered = true;
 
-	iwl_mvm_dbgfs_register(mvm, dbgfs_dir);
+	mvm->debugfs_dir = dbgfs_dir;
+	iwl_mvm_dbgfs_register(mvm);
 
 	return op_mode;
 
-- 
2.30.0

