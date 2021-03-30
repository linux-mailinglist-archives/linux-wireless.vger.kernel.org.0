Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 430BA34E902
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Mar 2021 15:26:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232163AbhC3NZp (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 30 Mar 2021 09:25:45 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:43600 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S232016AbhC3NZH (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 30 Mar 2021 09:25:07 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=kveik.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94)
        (envelope-from <luca@coelho.fi>)
        id 1lREMg-0007fg-LY; Tue, 30 Mar 2021 16:25:04 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Tue, 30 Mar 2021 16:24:51 +0300
Message-Id: <iwlwifi.20210330162204.d196fc6ffb23.Idc1ce3ce9fed9178beee7e5409bc669f79b06a0d@changeid>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20210330132500.468321-1-luca@coelho.fi>
References: <20210330132500.468321-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.5-pre1 (2020-06-20) on
        farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.5-pre1
Subject: [PATCH 03/12] iwlwifi: pcie: normally grab NIC access for inflight-hcmd
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

We currently have a special, separate, code path to acquire NIC
access for the in-flight host-command workaround on 7000 series
hardware. However, the normal code path here has grown a number
of additional workarounds/semantics over time, such as reprobing
the device if things fail.

Rather than try to replicate any of this logic, call the normal
grab_nic_access logic for the workaround.

This changes the spinlock to _bh, but that's OK since it's just
redundant, we already have soft-IRQs disabled when we get here,
and so didn't (have to) do it again. Since it's only for commands
there's however no point in making the code more complex just to
not use _bh here.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/pcie/tx.c | 33 +++++++-------------
 1 file changed, 11 insertions(+), 22 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/tx.c b/drivers/net/wireless/intel/iwlwifi/pcie/tx.c
index ac200e6e941e..4ea353734665 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/tx.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/tx.c
@@ -629,7 +629,6 @@ static int iwl_pcie_set_cmd_in_flight(struct iwl_trans *trans,
 				      const struct iwl_host_cmd *cmd)
 {
 	struct iwl_trans_pcie *trans_pcie = IWL_TRANS_GET_PCIE_TRANS(trans);
-	int ret = 0;
 
 	/* Make sure the NIC is still alive in the bus */
 	if (test_bit(STATUS_TRANS_DEAD, &trans->status))
@@ -638,34 +637,24 @@ static int iwl_pcie_set_cmd_in_flight(struct iwl_trans *trans,
 	if (!trans->trans_cfg->base_params->apmg_wake_up_wa)
 		return 0;
 
-	spin_lock(&trans_pcie->reg_lock);
 	/*
 	 * wake up the NIC to make sure that the firmware will see the host
 	 * command - we will let the NIC sleep once all the host commands
 	 * returned. This needs to be done only on NICs that have
 	 * apmg_wake_up_wa set (see above.)
 	 */
-	if (!trans_pcie->cmd_hold_nic_awake) {
-		__iwl_trans_pcie_set_bit(trans, CSR_GP_CNTRL,
-					 CSR_GP_CNTRL_REG_FLAG_MAC_ACCESS_REQ);
-
-		ret = iwl_poll_bit(trans, CSR_GP_CNTRL,
-				   CSR_GP_CNTRL_REG_VAL_MAC_ACCESS_EN,
-				   (CSR_GP_CNTRL_REG_FLAG_MAC_CLOCK_READY |
-				    CSR_GP_CNTRL_REG_FLAG_GOING_TO_SLEEP),
-				   15000);
-		if (ret < 0) {
-			__iwl_trans_pcie_clear_bit(trans, CSR_GP_CNTRL,
-					CSR_GP_CNTRL_REG_FLAG_MAC_ACCESS_REQ);
-			IWL_ERR(trans, "Failed to wake NIC for hcmd\n");
-			ret = -EIO;
-		} else {
-			trans_pcie->cmd_hold_nic_awake = true;
-		}
-	}
-	spin_unlock(&trans_pcie->reg_lock);
+	if (!iwl_trans_grab_nic_access(trans))
+		return -EIO;
 
-	return ret;
+	/*
+	 * In iwl_trans_grab_nic_access(), we've acquired the reg_lock.
+	 * There, we also returned immediately if cmd_hold_nic_awake is
+	 * already true, so it's OK to unconditionally set it to true.
+	 */
+	trans_pcie->cmd_hold_nic_awake = true;
+	spin_unlock_bh(&trans_pcie->reg_lock);
+
+	return 0;
 }
 
 /*
-- 
2.31.0

