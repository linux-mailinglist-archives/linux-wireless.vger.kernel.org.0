Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7699360B03
	for <lists+linux-wireless@lfdr.de>; Thu, 15 Apr 2021 15:49:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233234AbhDONtV (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 15 Apr 2021 09:49:21 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:44894 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S230056AbhDONtU (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 15 Apr 2021 09:49:20 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=kveik.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94)
        (envelope-from <luca@coelho.fi>)
        id 1lX2MR-000Mfj-LL; Thu, 15 Apr 2021 16:48:49 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     luca@coelho.fi, jikos@kernel.org, hdegoede@redhat.com,
        johannes@sipsolutions.net, linux-wireless@vger.kernel.org
Date:   Thu, 15 Apr 2021 16:48:46 +0300
Message-Id: <iwlwifi.20210415164821.d0f2edda1651.I75f762e0bed38914d1300ea198b86dd449b4b206@changeid>
X-Mailer: git-send-email 2.31.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.5-pre1 (2020-06-20) on
        farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.5-pre1
Subject: [PATCH for -next] iwlwifi: pcie: don't enable BHs with IRQs disabled
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

After the fix from Jiri that disabled local IRQs instead of
just BHs (necessary to fix an issue with submitting a command
with IRQs already disabled), there was still a situation in
which we could deep in there enable BHs, if the device config
sets the apmg_wake_up_wa configuration, which is true on all
7000 series devices.

To fix that, but not require reverting commit 1ed08f6fb5ae
("iwlwifi: remove flags argument for nic_access"), split up
nic access into a version with BH manipulation to use most
of the time, and without it for this specific case where the
local IRQs are already disabled.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 .../wireless/intel/iwlwifi/pcie/internal.h    |  5 ++++
 .../net/wireless/intel/iwlwifi/pcie/trans.c   | 24 ++++++++++++++++---
 drivers/net/wireless/intel/iwlwifi/pcie/tx.c  |  4 ++--
 3 files changed, 28 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/internal.h b/drivers/net/wireless/intel/iwlwifi/pcie/internal.h
index d9688c7bed07..76a512cd2e5c 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/internal.h
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/internal.h
@@ -447,6 +447,11 @@ struct iwl_trans
 		      const struct iwl_cfg_trans_params *cfg_trans);
 void iwl_trans_pcie_free(struct iwl_trans *trans);
 
+bool __iwl_trans_pcie_grab_nic_access(struct iwl_trans *trans);
+#define _iwl_trans_pcie_grab_nic_access(trans)			\
+	__cond_lock(nic_access_nobh,				\
+		    likely(__iwl_trans_pcie_grab_nic_access(trans)))
+
 /*****************************************************
 * RX
 ******************************************************/
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/trans.c b/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
index 861dbc03d183..239bc177a3e5 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
@@ -1978,12 +1978,16 @@ static void iwl_trans_pcie_removal_wk(struct work_struct *wk)
 	module_put(THIS_MODULE);
 }
 
-static bool iwl_trans_pcie_grab_nic_access(struct iwl_trans *trans)
+/*
+ * This version doesn't disable BHs but rather assumes they're
+ * already disabled.
+ */
+bool __iwl_trans_pcie_grab_nic_access(struct iwl_trans *trans)
 {
 	int ret;
 	struct iwl_trans_pcie *trans_pcie = IWL_TRANS_GET_PCIE_TRANS(trans);
 
-	spin_lock_bh(&trans_pcie->reg_lock);
+	spin_lock(&trans_pcie->reg_lock);
 
 	if (trans_pcie->cmd_hold_nic_awake)
 		goto out;
@@ -2068,7 +2072,7 @@ static bool iwl_trans_pcie_grab_nic_access(struct iwl_trans *trans)
 		}
 
 err:
-		spin_unlock_bh(&trans_pcie->reg_lock);
+		spin_unlock(&trans_pcie->reg_lock);
 		return false;
 	}
 
@@ -2081,6 +2085,20 @@ static bool iwl_trans_pcie_grab_nic_access(struct iwl_trans *trans)
 	return true;
 }
 
+static bool iwl_trans_pcie_grab_nic_access(struct iwl_trans *trans)
+{
+	bool ret;
+
+	local_bh_disable();
+	ret = __iwl_trans_pcie_grab_nic_access(trans);
+	if (ret) {
+		/* keep BHs disabled until iwl_trans_pcie_release_nic_access */
+		return ret;
+	}
+	local_bh_enable();
+	return false;
+}
+
 static void iwl_trans_pcie_release_nic_access(struct iwl_trans *trans)
 {
 	struct iwl_trans_pcie *trans_pcie = IWL_TRANS_GET_PCIE_TRANS(trans);
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/tx.c b/drivers/net/wireless/intel/iwlwifi/pcie/tx.c
index 0346505351f5..4f6c187eed69 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/tx.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/tx.c
@@ -643,7 +643,7 @@ static int iwl_pcie_set_cmd_in_flight(struct iwl_trans *trans,
 	 * returned. This needs to be done only on NICs that have
 	 * apmg_wake_up_wa set (see above.)
 	 */
-	if (!iwl_trans_grab_nic_access(trans))
+	if (!_iwl_trans_pcie_grab_nic_access(trans))
 		return -EIO;
 
 	/*
@@ -652,7 +652,7 @@ static int iwl_pcie_set_cmd_in_flight(struct iwl_trans *trans,
 	 * already true, so it's OK to unconditionally set it to true.
 	 */
 	trans_pcie->cmd_hold_nic_awake = true;
-	spin_unlock_bh(&trans_pcie->reg_lock);
+	spin_unlock(&trans_pcie->reg_lock);
 
 	return 0;
 }
-- 
2.31.0

