Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8DEBB94AEB
	for <lists+linux-wireless@lfdr.de>; Mon, 19 Aug 2019 18:51:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728017AbfHSQvB (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 19 Aug 2019 12:51:01 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:37144 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727920AbfHSQvB (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 19 Aug 2019 12:51:01 -0400
Received: from [91.156.6.193] (helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.92)
        (envelope-from <luca@coelho.fi>)
        id 1hzkrW-0007zi-Gt; Mon, 19 Aug 2019 19:50:31 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Mon, 19 Aug 2019 19:50:07 +0300
Message-Id: <20190819165007.10181-23-luca@coelho.fi>
X-Mailer: git-send-email 2.23.0.rc1
In-Reply-To: <20190819165007.10181-1-luca@coelho.fi>
References: <20190819165007.10181-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.2
Subject: [PATCH v3 22/22] iwlwifi: remove the code under IWLWIFI_PCIE_RTPM
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Emmanuel Grumbach <emmanuel.grumbach@intel.com>

This flag should never be set unless integration work with the
platform is done.  We don't support any platforms officially and don't
plan to do so in the near future, so we can remove this option
entirely in order to avoid having it enabled by mistake.

This has been marked with "depends on EXPERT", so there shouldn't be
many systems running with it set.  And, if there are systems, they
should not be using this flag.

Signed-off-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/Kconfig    | 14 ----
 drivers/net/wireless/intel/iwlwifi/pcie/drv.c | 71 -------------------
 .../net/wireless/intel/iwlwifi/pcie/trans.c   |  4 --
 3 files changed, 89 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/Kconfig b/drivers/net/wireless/intel/iwlwifi/Kconfig
index 235349a33a3c..7dbc0d38bb3b 100644
--- a/drivers/net/wireless/intel/iwlwifi/Kconfig
+++ b/drivers/net/wireless/intel/iwlwifi/Kconfig
@@ -92,20 +92,6 @@ config IWLWIFI_BCAST_FILTERING
 	  If unsure, don't enable this option, as some programs might
 	  expect incoming broadcasts for their normal operations.
 
-config IWLWIFI_PCIE_RTPM
-       bool "Enable runtime power management mode for PCIe devices"
-       depends on IWLMVM && PM && EXPERT
-       help
-         Say Y here to enable runtime power management for PCIe
-         devices.  If enabled, the device will go into low power mode
-         when idle for a short period of time, allowing for improved
-         power saving during runtime. Note that this feature requires
-         a tight integration with the platform. It is not recommended
-         to enable this feature without proper validation with the
-         specific target platform.
-
-	 If unsure, say N.
-
 menu "Debugging Options"
 
 config IWLWIFI_DEBUG
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
index 407abc835012..2a34f074d72c 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
@@ -1248,80 +1248,9 @@ int iwl_pci_fw_exit_d0i3(struct iwl_trans *trans)
 	return ret;
 }
 
-#ifdef CONFIG_IWLWIFI_PCIE_RTPM
-static int iwl_pci_runtime_suspend(struct device *device)
-{
-	struct pci_dev *pdev = to_pci_dev(device);
-	struct iwl_trans *trans = pci_get_drvdata(pdev);
-	int ret;
-
-	IWL_DEBUG_RPM(trans, "entering runtime suspend\n");
-
-	if (test_bit(STATUS_DEVICE_ENABLED, &trans->status)) {
-		ret = iwl_pci_fw_enter_d0i3(trans);
-		if (ret < 0)
-			return ret;
-	}
-
-	trans->system_pm_mode = IWL_PLAT_PM_MODE_D0I3;
-
-	iwl_trans_d3_suspend(trans, false, false);
-
-	return 0;
-}
-
-static int iwl_pci_runtime_resume(struct device *device)
-{
-	struct pci_dev *pdev = to_pci_dev(device);
-	struct iwl_trans *trans = pci_get_drvdata(pdev);
-	enum iwl_d3_status d3_status;
-
-	IWL_DEBUG_RPM(trans, "exiting runtime suspend (resume)\n");
-
-	iwl_trans_d3_resume(trans, &d3_status, false, false);
-
-	if (test_bit(STATUS_DEVICE_ENABLED, &trans->status))
-		return iwl_pci_fw_exit_d0i3(trans);
-
-	return 0;
-}
-
-static int iwl_pci_system_prepare(struct device *device)
-{
-	struct pci_dev *pdev = to_pci_dev(device);
-	struct iwl_trans *trans = pci_get_drvdata(pdev);
-
-	IWL_DEBUG_RPM(trans, "preparing for system suspend\n");
-
-	/* Wake the device up from runtime suspend before going to
-	 * platform suspend.  This is needed because we don't know
-	 * whether wowlan any is set and, if it's not, mac80211 will
-	 * disconnect (in which case, we can't be in D0i3).
-	 */
-	pm_runtime_resume(device);
-
-	return 0;
-}
-
-static void iwl_pci_system_complete(struct device *device)
-{
-	struct pci_dev *pdev = to_pci_dev(device);
-	struct iwl_trans *trans = pci_get_drvdata(pdev);
-
-	IWL_DEBUG_RPM(trans, "completing system suspend\n");
-}
-#endif /* CONFIG_IWLWIFI_PCIE_RTPM */
-
 static const struct dev_pm_ops iwl_dev_pm_ops = {
 	SET_SYSTEM_SLEEP_PM_OPS(iwl_pci_suspend,
 				iwl_pci_resume)
-#ifdef CONFIG_IWLWIFI_PCIE_RTPM
-	SET_RUNTIME_PM_OPS(iwl_pci_runtime_suspend,
-			   iwl_pci_runtime_resume,
-			   NULL)
-	.prepare = iwl_pci_system_prepare,
-	.complete = iwl_pci_system_complete,
-#endif /* CONFIG_IWLWIFI_PCIE_RTPM */
 };
 
 #define IWL_PM_OPS	(&iwl_dev_pm_ops)
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/trans.c b/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
index a6deb61a3ab4..a423c5c6605e 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
@@ -3658,11 +3658,7 @@ struct iwl_trans *iwl_trans_pcie_alloc(struct pci_dev *pdev,
 						   WQ_HIGHPRI | WQ_UNBOUND, 1);
 	INIT_WORK(&trans_pcie->rba.rx_alloc, iwl_pcie_rx_allocator_work);
 
-#ifdef CONFIG_IWLWIFI_PCIE_RTPM
-	trans->runtime_pm_mode = IWL_PLAT_PM_MODE_D0I3;
-#else
 	trans->runtime_pm_mode = IWL_PLAT_PM_MODE_DISABLED;
-#endif /* CONFIG_IWLWIFI_PCIE_RTPM */
 
 #ifdef CONFIG_IWLWIFI_DEBUGFS
 	trans_pcie->fw_mon_data.state = IWL_FW_MON_DBGFS_STATE_CLOSED;
-- 
2.23.0.rc1

