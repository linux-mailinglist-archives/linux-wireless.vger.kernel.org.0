Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 106D9636BDF
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Nov 2022 22:04:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237836AbiKWVE2 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 23 Nov 2022 16:04:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237248AbiKWVER (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 23 Nov 2022 16:04:17 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4322097AB8
        for <linux-wireless@vger.kernel.org>; Wed, 23 Nov 2022 13:04:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669237451; x=1700773451;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ZdJTgjmWHHRVNkK4dmvxGnI1Uwpo4hptlUUrZzcEv64=;
  b=WCl6gC16WVO3Y4FpZPCf2o9FH3O5Oq5HG0k9o2taAOXqhYB4mBzM8Ahs
   klCxNlOIiDF4IUgryL9T77P6T0kilcV1A2Dt9PveXDx6tTKYEsGWkF0cB
   16pSAL24QcslLi7OBgUolnBYmF+eHlFprhYcE/6V/VwitKU3X6yY9RLdG
   Kbd6PL0davl4R/SQkHmKYxUDnLo65m3TKHFw46hBJVJYcYiB8wQa0oOEs
   EJGlf02jy5YvZcsE0dRS+mbPLoqOF0m8OCZUUmFfsx7zgkPOqZWzRjIMB
   qICBY7s3IRpqIet/rq6LlwcCU4MRahF7GcGmEhmIdLWw+RqBsSCWer3Y0
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10540"; a="293864702"
X-IronPort-AV: E=Sophos;i="5.96,187,1665471600"; 
   d="scan'208";a="293864702"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2022 13:04:10 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10540"; a="619761685"
X-IronPort-AV: E=Sophos;i="5.96,187,1665471600"; 
   d="scan'208";a="619761685"
Received: from stopaz-mobl1.ger.corp.intel.com (HELO ggreenma-mobl2.lan) ([10.214.194.175])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2022 13:04:08 -0800
From:   gregory.greenman@intel.com
To:     kvalo@kernel.org, johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Avraham Stern <avraham.stern@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 3/5] wifi: iwlwifi: mvm: trigger PCI re-enumeration in case of PLDR sync
Date:   Wed, 23 Nov 2022 23:02:07 +0200
Message-Id: <20221123225313.9ae77968961e.Ie06e886cef4b5921b65dacb7724db1276bed38cb@changeid>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20221123210209.2941641-1-gregory.greenman@intel.com>
References: <20221123210209.2941641-1-gregory.greenman@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Avraham Stern <avraham.stern@intel.com>

When doing the PLDR flow, the fw goes through a re-read and needs
PCI re-enumeration in order to recover. In this case, skip the mac
start retry and fw dumps as all the fw and registers are invalid
until the PCI re-enumeration.

In addition, print the register that shows the re-read counter
when loading the fw.

Signed-off-by: Avraham Stern <avraham.stern@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/iwl-prph.h |  1 +
 .../net/wireless/intel/iwlwifi/iwl-trans.h    |  1 +
 drivers/net/wireless/intel/iwlwifi/mvm/fw.c   | 12 ++-
 .../net/wireless/intel/iwlwifi/mvm/mac80211.c | 10 +++
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h  |  2 +
 drivers/net/wireless/intel/iwlwifi/mvm/ops.c  |  3 +
 .../net/wireless/intel/iwlwifi/pcie/trans.c   | 85 ++++++++++---------
 7 files changed, 73 insertions(+), 41 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-prph.h b/drivers/net/wireless/intel/iwlwifi/iwl-prph.h
index 82cf904e0b6d..62ce116d3783 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-prph.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-prph.h
@@ -368,6 +368,7 @@ enum {
 #define CNVR_AUX_MISC_CHIP				0xA2B800
 #define CNVR_SCU_SD_REGS_SD_REG_DIG_DCDC_VTRIM		0xA29890
 #define CNVR_SCU_SD_REGS_SD_REG_ACTIVE_VDIG_MIRROR	0xA29938
+#define CNVI_SCU_SEQ_DATA_DW9				0xA27488
 
 #define PREG_AUX_BUS_WPROT_0		0xA04CC0
 
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-trans.h b/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
index d659ccd065f7..32bd7f19f1d5 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
@@ -1542,5 +1542,6 @@ void iwl_trans_free(struct iwl_trans *trans);
 ******************************************************/
 int __must_check iwl_pci_register_driver(void);
 void iwl_pci_unregister_driver(void);
+void iwl_trans_pcie_remove(struct iwl_trans *trans, bool rescan);
 
 #endif /* __iwl_trans_h__ */
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
index b3101d12a0a1..74354d044db9 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
@@ -364,6 +364,8 @@ static int iwl_mvm_load_ucode_wait_alive(struct iwl_mvm *mvm,
 			 iwl_read_umac_prph(mvm->trans, WFPM_LMAC2_PD_NOTIFICATION));
 		IWL_INFO(mvm, "WFPM_AUTH_KEY_0: 0x%x\n",
 			 iwl_read_umac_prph(mvm->trans, SB_MODIFY_CFG_FLAG));
+		IWL_INFO(mvm, "CNVI_SCU_SEQ_DATA_DW9: 0x%x\n",
+			 iwl_read_prph(mvm->trans, CNVI_SCU_SEQ_DATA_DW9));
 	}
 
 	if (ret) {
@@ -402,7 +404,7 @@ static int iwl_mvm_load_ucode_wait_alive(struct iwl_mvm *mvm,
 						UREG_LMAC2_CURRENT_PC));
 		}
 
-		if (ret == -ETIMEDOUT)
+		if (ret == -ETIMEDOUT && !mvm->pldr_sync)
 			iwl_fw_dbg_error_collect(&mvm->fwrt,
 						 FW_DBG_TRIGGER_ALIVE_TIMEOUT);
 
@@ -1479,18 +1481,22 @@ int iwl_mvm_up(struct iwl_mvm *mvm)
 		return ret;
 
 	sb_cfg = iwl_read_umac_prph(mvm->trans, SB_MODIFY_CFG_FLAG);
-	if (!(sb_cfg & SB_CFG_RESIDES_IN_OTP_MASK) && iwl_mei_pldr_req())
+	mvm->pldr_sync = !(sb_cfg & SB_CFG_RESIDES_IN_OTP_MASK);
+	if (mvm->pldr_sync && iwl_mei_pldr_req())
 		return ret;
 
 	ret = iwl_mvm_load_rt_fw(mvm);
 	if (ret) {
 		IWL_ERR(mvm, "Failed to start RT ucode: %d\n", ret);
-		if (ret != -ERFKILL)
+		if (ret != -ERFKILL && !mvm->pldr_sync)
 			iwl_fw_dbg_error_collect(&mvm->fwrt,
 						 FW_DBG_TRIGGER_DRIVER);
 		goto error;
 	}
 
+	/* FW loaded successfully */
+	mvm->pldr_sync = false;
+
 	iwl_get_shared_mem_conf(&mvm->fwrt);
 
 	ret = iwl_mvm_sf_update(mvm, NULL, false);
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
index 3fba69554f83..5273ade71117 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
@@ -1068,6 +1068,16 @@ static int iwl_mvm_mac_start(struct ieee80211_hw *hw)
 		if (!ret)
 			break;
 
+		/*
+		 * In PLDR sync PCI re-enumeration is needed. no point to retry
+		 * mac start before that.
+		 */
+		if (mvm->pldr_sync) {
+			iwl_mei_alive_notif(false);
+			iwl_trans_pcie_remove(mvm->trans, true);
+			break;
+		}
+
 		IWL_ERR(mvm, "mac start retry %d\n", retry);
 	}
 	clear_bit(IWL_MVM_STATUS_STARTING, &mvm->status);
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
index 962e304fc2b1..ce6b701f3f4c 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
@@ -1105,6 +1105,8 @@ struct iwl_mvm {
 	unsigned long last_reset_or_resume_time_jiffies;
 
 	bool sta_remove_requires_queue_remove;
+
+	bool pldr_sync;
 };
 
 /* Extract MVM priv from op_mode and _hw */
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/ops.c b/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
index 2a4db13c9dcf..e78f5beaa2d0 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
@@ -1888,6 +1888,9 @@ static void iwl_mvm_nic_error(struct iwl_op_mode *op_mode, bool sync)
 {
 	struct iwl_mvm *mvm = IWL_OP_MODE_GET_MVM(op_mode);
 
+	if (mvm->pldr_sync)
+		return;
+
 	if (!test_bit(STATUS_TRANS_DEAD, &mvm->trans->status) &&
 	    !test_and_clear_bit(IWL_MVM_STATUS_SUPPRESS_ERROR_LOG_ONCE,
 				&mvm->status))
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/trans.c b/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
index bd50f52a1aad..0a9af1ad1f20 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
@@ -2052,6 +2052,7 @@ static void iwl_trans_pcie_set_pmi(struct iwl_trans *trans, bool state)
 struct iwl_trans_pcie_removal {
 	struct pci_dev *pdev;
 	struct work_struct work;
+	bool rescan;
 };
 
 static void iwl_trans_pcie_removal_wk(struct work_struct *wk)
@@ -2060,18 +2061,61 @@ static void iwl_trans_pcie_removal_wk(struct work_struct *wk)
 		container_of(wk, struct iwl_trans_pcie_removal, work);
 	struct pci_dev *pdev = removal->pdev;
 	static char *prop[] = {"EVENT=INACCESSIBLE", NULL};
+	struct pci_bus *bus = pdev->bus;
 
 	dev_err(&pdev->dev, "Device gone - attempting removal\n");
 	kobject_uevent_env(&pdev->dev.kobj, KOBJ_CHANGE, prop);
 	pci_lock_rescan_remove();
 	pci_dev_put(pdev);
 	pci_stop_and_remove_bus_device(pdev);
+	if (removal->rescan)
+		pci_rescan_bus(bus->parent);
 	pci_unlock_rescan_remove();
 
 	kfree(removal);
 	module_put(THIS_MODULE);
 }
 
+void iwl_trans_pcie_remove(struct iwl_trans *trans, bool rescan)
+{
+	struct iwl_trans_pcie_removal *removal;
+
+	if (test_bit(STATUS_TRANS_DEAD, &trans->status))
+		return;
+
+	IWL_ERR(trans, "Device gone - scheduling removal!\n");
+
+	/*
+	 * get a module reference to avoid doing this
+	 * while unloading anyway and to avoid
+	 * scheduling a work with code that's being
+	 * removed.
+	 */
+	if (!try_module_get(THIS_MODULE)) {
+		IWL_ERR(trans,
+			"Module is being unloaded - abort\n");
+		return;
+	}
+
+	removal = kzalloc(sizeof(*removal), GFP_ATOMIC);
+	if (!removal) {
+		module_put(THIS_MODULE);
+		return;
+	}
+	/*
+	 * we don't need to clear this flag, because
+	 * the trans will be freed and reallocated.
+	 */
+	set_bit(STATUS_TRANS_DEAD, &trans->status);
+
+	removal->pdev = to_pci_dev(trans->dev);
+	removal->rescan = rescan;
+	INIT_WORK(&removal->work, iwl_trans_pcie_removal_wk);
+	pci_dev_get(removal->pdev);
+	schedule_work(&removal->work);
+}
+EXPORT_SYMBOL(iwl_trans_pcie_remove);
+
 /*
  * This version doesn't disable BHs but rather assumes they're
  * already disabled.
@@ -2131,47 +2175,12 @@ bool __iwl_trans_pcie_grab_nic_access(struct iwl_trans *trans)
 
 		iwl_trans_pcie_dump_regs(trans);
 
-		if (iwlwifi_mod_params.remove_when_gone && cntrl == ~0U) {
-			struct iwl_trans_pcie_removal *removal;
-
-			if (test_bit(STATUS_TRANS_DEAD, &trans->status))
-				goto err;
-
-			IWL_ERR(trans, "Device gone - scheduling removal!\n");
-
-			/*
-			 * get a module reference to avoid doing this
-			 * while unloading anyway and to avoid
-			 * scheduling a work with code that's being
-			 * removed.
-			 */
-			if (!try_module_get(THIS_MODULE)) {
-				IWL_ERR(trans,
-					"Module is being unloaded - abort\n");
-				goto err;
-			}
-
-			removal = kzalloc(sizeof(*removal), GFP_ATOMIC);
-			if (!removal) {
-				module_put(THIS_MODULE);
-				goto err;
-			}
-			/*
-			 * we don't need to clear this flag, because
-			 * the trans will be freed and reallocated.
-			*/
-			set_bit(STATUS_TRANS_DEAD, &trans->status);
-
-			removal->pdev = to_pci_dev(trans->dev);
-			INIT_WORK(&removal->work, iwl_trans_pcie_removal_wk);
-			pci_dev_get(removal->pdev);
-			schedule_work(&removal->work);
-		} else {
+		if (iwlwifi_mod_params.remove_when_gone && cntrl == ~0U)
+			iwl_trans_pcie_remove(trans, false);
+		else
 			iwl_write32(trans, CSR_RESET,
 				    CSR_RESET_REG_FLAG_FORCE_NMI);
-		}
 
-err:
 		spin_unlock(&trans_pcie->reg_lock);
 		return false;
 	}
-- 
2.35.3

