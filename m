Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6FB8F90D79
	for <lists+linux-wireless@lfdr.de>; Sat, 17 Aug 2019 08:52:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726215AbfHQGwf (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 17 Aug 2019 02:52:35 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:36358 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725945AbfHQGwe (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 17 Aug 2019 02:52:34 -0400
Received: from [91.156.6.193] (helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.92)
        (envelope-from <luca@coelho.fi>)
        id 1hysZg-0006XT-Ri; Sat, 17 Aug 2019 09:52:29 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Sat, 17 Aug 2019 09:51:59 +0300
Message-Id: <20190817065200.9701-22-luca@coelho.fi>
X-Mailer: git-send-email 2.23.0.rc1
In-Reply-To: <20190817065200.9701-1-luca@coelho.fi>
References: <20190817065200.9701-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.2
Subject: [PATCH 21/22] iwlwifi: trans: remove suspending flag
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Emmanuel Grumbach <emmanuel.grumbach@intel.com>

This is set but never read.

Signed-off-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/iwl-trans.h |  1 -
 drivers/net/wireless/intel/iwlwifi/pcie/drv.c  | 14 --------------
 2 files changed, 15 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-trans.h b/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
index 20251f5e6f41..942662eaf523 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
@@ -841,7 +841,6 @@ struct iwl_trans {
 
 	enum iwl_plat_pm_mode system_pm_mode;
 	enum iwl_plat_pm_mode runtime_pm_mode;
-	bool suspending;
 
 	/* pointer to trans specific struct */
 	/*Ensure that this pointer will always be aligned to sizeof pointer */
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
index de711c1160d3..407abc835012 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
@@ -1293,12 +1293,6 @@ static int iwl_pci_system_prepare(struct device *device)
 
 	IWL_DEBUG_RPM(trans, "preparing for system suspend\n");
 
-	/* This is called before entering system suspend and before
-	 * the runtime resume is called.  Set the suspending flag to
-	 * prevent the wakelock from being taken.
-	 */
-	trans->suspending = true;
-
 	/* Wake the device up from runtime suspend before going to
 	 * platform suspend.  This is needed because we don't know
 	 * whether wowlan any is set and, if it's not, mac80211 will
@@ -1315,14 +1309,6 @@ static void iwl_pci_system_complete(struct device *device)
 	struct iwl_trans *trans = pci_get_drvdata(pdev);
 
 	IWL_DEBUG_RPM(trans, "completing system suspend\n");
-
-	/* This is called as a counterpart to the prepare op.  It is
-	 * called either when suspending fails or when suspend
-	 * completed successfully.  Now there's no risk of grabbing
-	 * the wakelock anymore, so we can release the suspending
-	 * flag.
-	 */
-	trans->suspending = false;
 }
 #endif /* CONFIG_IWLWIFI_PCIE_RTPM */
 
-- 
2.23.0.rc1

