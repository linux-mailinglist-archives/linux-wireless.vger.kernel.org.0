Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 695332F91E6
	for <lists+linux-wireless@lfdr.de>; Sun, 17 Jan 2021 12:13:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728474AbhAQLNx (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 17 Jan 2021 06:13:53 -0500
Received: from paleale.coelho.fi ([176.9.41.70]:40684 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727838AbhAQLNg (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 17 Jan 2021 06:13:36 -0500
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <luca@coelho.fi>)
        id 1l15xI-003sZv-Om; Sun, 17 Jan 2021 13:10:49 +0200
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Sun, 17 Jan 2021 13:10:37 +0200
Message-Id: <iwlwifi.20210117130510.8f8a735f39dd.If5716eaae0df5e6295a2af927bf3ab0ee074f0a0@changeid>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210117111038.1402870-1-luca@coelho.fi>
References: <20210117111038.1402870-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.4
Subject: [PATCH 10/11] iwlwifi: remove TRANS_PM_OPS
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Emmanuel Grumbach <emmanuel.grumbach@intel.com>

Those were needed for a slave bus that is not longer supported.
Remove code that is mainly useless stubs.

Signed-off-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 .../net/wireless/intel/iwlwifi/iwl-trans.h    | 16 --------------
 drivers/net/wireless/intel/iwlwifi/mvm/d3.c   |  7 -------
 .../net/wireless/intel/iwlwifi/pcie/trans.c   | 21 -------------------
 3 files changed, 44 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-trans.h b/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
index eb6430c69e67..ee97e2df3a1d 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
@@ -580,8 +580,6 @@ struct iwl_trans_ops {
 				   unsigned long *flags);
 	void (*set_bits_mask)(struct iwl_trans *trans, u32 reg, u32 mask,
 			      u32 value);
-	int  (*suspend)(struct iwl_trans *trans);
-	void (*resume)(struct iwl_trans *trans);
 
 	struct iwl_trans_dump_data *(*dump_data)(struct iwl_trans *trans,
 						 u32 dump_mask);
@@ -1075,20 +1073,6 @@ static inline int iwl_trans_d3_resume(struct iwl_trans *trans,
 	return trans->ops->d3_resume(trans, status, test, reset);
 }
 
-static inline int iwl_trans_suspend(struct iwl_trans *trans)
-{
-	if (!trans->ops->suspend)
-		return 0;
-
-	return trans->ops->suspend(trans);
-}
-
-static inline void iwl_trans_resume(struct iwl_trans *trans)
-{
-	if (trans->ops->resume)
-		trans->ops->resume(trans);
-}
-
 static inline struct iwl_trans_dump_data *
 iwl_trans_dump_data(struct iwl_trans *trans, u32 dump_mask)
 {
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/d3.c b/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
index c025188fa9bc..550755fb7c2f 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
@@ -1104,16 +1104,11 @@ int iwl_mvm_suspend(struct ieee80211_hw *hw, struct cfg80211_wowlan *wowlan)
 {
 	struct iwl_mvm *mvm = IWL_MAC80211_GET_MVM(hw);
 	struct iwl_trans *trans = mvm->trans;
-	int ret;
 
 	iwl_mvm_pause_tcm(mvm, true);
 
 	iwl_fw_runtime_suspend(&mvm->fwrt);
 
-	ret = iwl_trans_suspend(trans);
-	if (ret)
-		return ret;
-
 	trans->system_pm_mode = IWL_PLAT_PM_MODE_D3;
 
 	return __iwl_mvm_suspend(hw, wowlan, false);
@@ -2171,8 +2166,6 @@ static int __iwl_mvm_resume(struct iwl_mvm *mvm, bool test)
 
 static int iwl_mvm_resume_d3(struct iwl_mvm *mvm)
 {
-	iwl_trans_resume(mvm->trans);
-
 	return __iwl_mvm_resume(mvm, false);
 }
 
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/trans.c b/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
index 44e738e8537e..9fd1e699292c 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
@@ -3308,17 +3308,6 @@ static void iwl_trans_pcie_sync_nmi(struct iwl_trans *trans)
 	iwl_trans_sync_nmi_with_addr(trans, inta_addr, sw_err_bit);
 }
 
-#ifdef CONFIG_PM_SLEEP
-static int iwl_trans_pcie_suspend(struct iwl_trans *trans)
-{
-	return 0;
-}
-
-static void iwl_trans_pcie_resume(struct iwl_trans *trans)
-{
-}
-#endif /* CONFIG_PM_SLEEP */
-
 #define IWL_TRANS_COMMON_OPS						\
 	.op_mode_leave = iwl_trans_pcie_op_mode_leave,			\
 	.write8 = iwl_trans_pcie_write8,				\
@@ -3341,17 +3330,8 @@ static void iwl_trans_pcie_resume(struct iwl_trans *trans)
 	.interrupts = iwl_trans_pci_interrupts,				\
 	.sync_nmi = iwl_trans_pcie_sync_nmi				\
 
-#ifdef CONFIG_PM_SLEEP
-#define IWL_TRANS_PM_OPS						\
-	.suspend = iwl_trans_pcie_suspend,				\
-	.resume = iwl_trans_pcie_resume,
-#else
-#define IWL_TRANS_PM_OPS
-#endif /* CONFIG_PM_SLEEP */
-
 static const struct iwl_trans_ops trans_ops_pcie = {
 	IWL_TRANS_COMMON_OPS,
-	IWL_TRANS_PM_OPS
 	.start_hw = iwl_trans_pcie_start_hw,
 	.fw_alive = iwl_trans_pcie_fw_alive,
 	.start_fw = iwl_trans_pcie_start_fw,
@@ -3378,7 +3358,6 @@ static const struct iwl_trans_ops trans_ops_pcie = {
 
 static const struct iwl_trans_ops trans_ops_pcie_gen2 = {
 	IWL_TRANS_COMMON_OPS,
-	IWL_TRANS_PM_OPS
 	.start_hw = iwl_trans_pcie_start_hw,
 	.fw_alive = iwl_trans_pcie_gen2_fw_alive,
 	.start_fw = iwl_trans_pcie_gen2_start_fw,
-- 
2.29.2

