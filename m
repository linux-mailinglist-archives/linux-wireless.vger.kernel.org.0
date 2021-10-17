Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0C3243094F
	for <lists+linux-wireless@lfdr.de>; Sun, 17 Oct 2021 15:26:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343696AbhJQN2U (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 17 Oct 2021 09:28:20 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:53838 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1343648AbhJQN2S (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 17 Oct 2021 09:28:18 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=kveik.lan)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <luca@coelho.fi>)
        id 1mc6Aw-000YdS-7y; Sun, 17 Oct 2021 16:26:06 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     luca@coelho.fi, linux-wireless@vger.kernel.org
Date:   Sun, 17 Oct 2021 16:25:53 +0300
Message-Id: <iwlwifi.20211017162352.46183bcd6549.Ie05161496810d3f28fb9d1fecb5f8593889ed2c6@changeid>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211017132604.480251-1-luca@coelho.fi>
References: <20211017132604.480251-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.6
Subject: [PATCH 01/12] iwlwifi: BZ Family BUS_MASTER_DISABLE_REQ code duplication
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Roee Goldfiner <roee.h.goldfiner@intel.com>

Remove redundant code which occurs anyway in a later stage and add
msleep(100) which is required after disable request.

Signed-off-by: Roee Goldfiner <roee.h.goldfiner@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 .../net/wireless/intel/iwlwifi/pcie/trans-gen2.c | 16 ++--------------
 drivers/net/wireless/intel/iwlwifi/pcie/trans.c  |  1 +
 2 files changed, 3 insertions(+), 14 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/trans-gen2.c b/drivers/net/wireless/intel/iwlwifi/pcie/trans-gen2.c
index bf0c32a74ca4..1ab8e29294a1 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/trans-gen2.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/trans-gen2.c
@@ -131,21 +131,9 @@ void _iwl_trans_pcie_gen2_stop_device(struct iwl_trans *trans)
 	if (trans_pcie->is_down)
 		return;
 
-	if (trans->state >= IWL_TRANS_FW_STARTED) {
-		if (trans->trans_cfg->device_family >= IWL_DEVICE_FAMILY_BZ) {
-			iwl_set_bit(trans, CSR_GP_CNTRL,
-				    CSR_GP_CNTRL_REG_FLAG_BUS_MASTER_DISABLE_REQ);
-			iwl_poll_bit(trans, CSR_GP_CNTRL,
-				     CSR_GP_CNTRL_REG_FLAG_BUS_MASTER_DISABLE_STATUS,
-				     CSR_GP_CNTRL_REG_FLAG_BUS_MASTER_DISABLE_STATUS,
-				     5000);
-			msleep(100);
-			iwl_set_bit(trans, CSR_GP_CNTRL,
-				    CSR_GP_CNTRL_REG_FLAG_SW_RESET);
-		} else if (trans_pcie->fw_reset_handshake) {
+	if (trans->state >= IWL_TRANS_FW_STARTED)
+		if (trans_pcie->fw_reset_handshake)
 			iwl_trans_pcie_fw_reset_handshake(trans);
-		}
-	}
 
 	trans_pcie->is_down = true;
 
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/trans.c b/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
index 9e462633af55..22393b724e98 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
@@ -458,6 +458,7 @@ void iwl_pcie_apm_stop_master(struct iwl_trans *trans)
 				   CSR_GP_CNTRL_REG_FLAG_BUS_MASTER_DISABLE_STATUS,
 				   CSR_GP_CNTRL_REG_FLAG_BUS_MASTER_DISABLE_STATUS,
 				   100);
+		msleep(100);
 	} else {
 		iwl_set_bit(trans, CSR_RESET, CSR_RESET_REG_FLAG_STOP_MASTER);
 
-- 
2.33.0

