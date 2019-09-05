Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 047ADAA3F5
	for <lists+linux-wireless@lfdr.de>; Thu,  5 Sep 2019 15:12:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388352AbfIENMy (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 5 Sep 2019 09:12:54 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:40934 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1731633AbfIENMy (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 5 Sep 2019 09:12:54 -0400
Received: from [91.156.6.193] (helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.92)
        (envelope-from <luca@coelho.fi>)
        id 1i5rZD-0005yI-Dr; Thu, 05 Sep 2019 16:12:51 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Thu,  5 Sep 2019 16:12:29 +0300
Message-Id: <20190905131241.23487-7-luca@coelho.fi>
X-Mailer: git-send-email 2.23.0.rc1
In-Reply-To: <20190905131241.23487-1-luca@coelho.fi>
References: <20190905131241.23487-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.2
Subject: [PATCH v2 06/18] iwlwifi: remove runtime_pm_mode
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Emmanuel Grumbach <emmanuel.grumbach@intel.com>

This is always set to IWL_PLAT_PM_MODE_DISABLED

Signed-off-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 .../net/wireless/intel/iwlwifi/iwl-trans.h    | 33 +++----------------
 drivers/net/wireless/intel/iwlwifi/pcie/drv.c | 28 ----------------
 .../net/wireless/intel/iwlwifi/pcie/trans.c   |  9 -----
 3 files changed, 5 insertions(+), 65 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-trans.h b/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
index 034c935b5579..b50290a724ff 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
@@ -630,9 +630,6 @@ enum iwl_trans_state {
 /**
  * DOC: Platform power management
  *
- * There are two types of platform power management: system-wide
- * (WoWLAN) and runtime.
- *
  * In system-wide power management the entire platform goes into a low
  * power state (e.g. idle or suspend to RAM) at the same time and the
  * device is configured as a wakeup source for the entire platform.
@@ -641,48 +638,32 @@ enum iwl_trans_state {
  * put the platform in low power mode).  The device's behavior in this
  * mode is dictated by the wake-on-WLAN configuration.
  *
- * In runtime power management, only the devices which are themselves
- * idle enter a low power state.  This is done at runtime, which means
- * that the entire system is still running normally.  This mode is
- * usually triggered automatically by the device driver and requires
- * the ability to enter and exit the low power modes in a very short
- * time, so there is not much impact in usability.
- *
  * The terms used for the device's behavior are as follows:
  *
  *	- D0: the device is fully powered and the host is awake;
  *	- D3: the device is in low power mode and only reacts to
  *		specific events (e.g. magic-packet received or scan
  *		results found);
- *	- D0I3: the device is in low power mode and reacts to any
- *		activity (e.g. RX);
  *
  * These terms reflect the power modes in the firmware and are not to
- * be confused with the physical device power state.  The NIC can be
- * in D0I3 mode even if, for instance, the PCI device is in D3 state.
+ * be confused with the physical device power state.
  */
 
 /**
  * enum iwl_plat_pm_mode - platform power management mode
  *
  * This enumeration describes the device's platform power management
- * behavior when in idle mode (i.e. runtime power management) or when
- * in system-wide suspend (i.e WoWLAN).
+ * behavior when in system-wide suspend (i.e WoWLAN).
  *
  * @IWL_PLAT_PM_MODE_DISABLED: power management is disabled for this
- *	device.  At runtime, this means that nothing happens and the
- *	device always remains in active.  In system-wide suspend mode,
- *	it means that the all connections will be closed automatically
- *	by mac80211 before the platform is suspended.
+ *	device.  In system-wide suspend mode, it means that the all
+ *	connections will be closed automatically by mac80211 before
+ *	the platform is suspended.
  * @IWL_PLAT_PM_MODE_D3: the device goes into D3 mode (i.e. WoWLAN).
- *	For runtime power management, this mode is not officially
- *	supported.
- * @IWL_PLAT_PM_MODE_D0I3: the device goes into D0I3 mode.
  */
 enum iwl_plat_pm_mode {
 	IWL_PLAT_PM_MODE_DISABLED,
 	IWL_PLAT_PM_MODE_D3,
-	IWL_PLAT_PM_MODE_D0I3,
 };
 
 /* Max time to wait for trans to become idle/non-idle on d0i3
@@ -795,9 +776,6 @@ struct iwl_trans_debug {
  * @system_pm_mode: the system-wide power management mode in use.
  *	This mode is set dynamically, depending on the WoWLAN values
  *	configured from the userspace at runtime.
- * @runtime_pm_mode: the runtime power management mode in use.  This
- *	mode is set during the initialization phase and is not
- *	supposed to change during runtime.
  */
 struct iwl_trans {
 	const struct iwl_trans_ops *ops;
@@ -842,7 +820,6 @@ struct iwl_trans {
 	struct iwl_self_init_dram init_dram;
 
 	enum iwl_plat_pm_mode system_pm_mode;
-	enum iwl_plat_pm_mode runtime_pm_mode;
 
 	/* pointer to trans specific struct */
 	/*Ensure that this pointer will always be aligned to sizeof pointer */
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
index 2a34f074d72c..10c9167d78fa 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
@@ -1076,25 +1076,6 @@ static int iwl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	/* register transport layer debugfs here */
 	iwl_trans_pcie_dbgfs_register(iwl_trans);
 
-	/* if RTPM is in use, enable it in our device */
-	if (iwl_trans->runtime_pm_mode != IWL_PLAT_PM_MODE_DISABLED) {
-		/* We explicitly set the device to active here to
-		 * clear contingent errors.
-		 */
-		pm_runtime_set_active(&pdev->dev);
-
-		pm_runtime_set_autosuspend_delay(&pdev->dev,
-					 iwlwifi_mod_params.d0i3_timeout);
-		pm_runtime_use_autosuspend(&pdev->dev);
-
-		/* We are not supposed to call pm_runtime_allow() by
-		 * ourselves, but let userspace enable runtime PM via
-		 * sysfs.  However, since we don't enable this from
-		 * userspace yet, we need to allow/forbid() ourselves.
-		*/
-		pm_runtime_allow(&pdev->dev);
-	}
-
 	/* The PCI device starts with a reference taken and we are
 	 * supposed to release it here.  But to simplify the
 	 * interaction with the opmode, we don't do it now, but let
@@ -1112,15 +1093,6 @@ static void iwl_pci_remove(struct pci_dev *pdev)
 {
 	struct iwl_trans *trans = pci_get_drvdata(pdev);
 
-	/* if RTPM was in use, restore it to the state before probe */
-	if (trans->runtime_pm_mode != IWL_PLAT_PM_MODE_DISABLED) {
-		/* We should not call forbid here, but we do for now.
-		 * Check the comment to pm_runtime_allow() in
-		 * iwl_pci_probe().
-		 */
-		pm_runtime_forbid(trans->dev);
-	}
-
 	iwl_drv_stop(trans->drv);
 
 	iwl_trans_pcie_free(trans);
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/trans.c b/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
index 3a4be2ff3d42..8eaacf423d33 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
@@ -3312,18 +3312,11 @@ static struct iwl_trans_dump_data
 #ifdef CONFIG_PM_SLEEP
 static int iwl_trans_pcie_suspend(struct iwl_trans *trans)
 {
-	if (trans->runtime_pm_mode == IWL_PLAT_PM_MODE_D0I3 &&
-	    (trans->system_pm_mode == IWL_PLAT_PM_MODE_D0I3))
-		return iwl_pci_fw_enter_d0i3(trans);
-
 	return 0;
 }
 
 static void iwl_trans_pcie_resume(struct iwl_trans *trans)
 {
-	if (trans->runtime_pm_mode == IWL_PLAT_PM_MODE_D0I3 &&
-	    (trans->system_pm_mode == IWL_PLAT_PM_MODE_D0I3))
-		iwl_pci_fw_exit_d0i3(trans);
 }
 #endif /* CONFIG_PM_SLEEP */
 
@@ -3660,8 +3653,6 @@ struct iwl_trans *iwl_trans_pcie_alloc(struct pci_dev *pdev,
 						   WQ_HIGHPRI | WQ_UNBOUND, 1);
 	INIT_WORK(&trans_pcie->rba.rx_alloc, iwl_pcie_rx_allocator_work);
 
-	trans->runtime_pm_mode = IWL_PLAT_PM_MODE_DISABLED;
-
 #ifdef CONFIG_IWLWIFI_DEBUGFS
 	trans_pcie->fw_mon_data.state = IWL_FW_MON_DBGFS_STATE_CLOSED;
 	mutex_init(&trans_pcie->fw_mon_data.mutex);
-- 
2.23.0.rc1

