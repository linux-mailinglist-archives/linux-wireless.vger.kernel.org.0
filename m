Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AAD993DDFB8
	for <lists+linux-wireless@lfdr.de>; Mon,  2 Aug 2021 20:59:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231351AbhHBS7T (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 2 Aug 2021 14:59:19 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:51036 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S230506AbhHBS7R (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 2 Aug 2021 14:59:17 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=kveik.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94)
        (envelope-from <luca@coelho.fi>)
        id 1mAd9U-001ySl-Il; Mon, 02 Aug 2021 21:59:06 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     luca@coelho.fi, linux-wireless@vger.kernel.org
Date:   Mon,  2 Aug 2021 21:58:53 +0300
Message-Id: <iwlwifi.20210802215208.df30875c6ff9.I962ed0f2c3358903dc6ba1abb65726ce5acbbd48@changeid>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210802185856.175567-1-luca@coelho.fi>
References: <20210802185856.175567-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.5-pre1 (2020-06-20) on
        farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.5-pre1
Subject: [PATCH 07/10] iwlwifi: pcie: implement Bz reset flow
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

Bz device reset flow changed, now the hardware (instead of
firmware) will reset the PCI bus etc., this can take up to
100ms.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 .../wireless/intel/iwlwifi/pcie/trans-gen2.c   | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/trans-gen2.c b/drivers/net/wireless/intel/iwlwifi/pcie/trans-gen2.c
index fa416b42bd9d..bf0c32a74ca4 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/trans-gen2.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/trans-gen2.c
@@ -131,9 +131,21 @@ void _iwl_trans_pcie_gen2_stop_device(struct iwl_trans *trans)
 	if (trans_pcie->is_down)
 		return;
 
-	if (trans_pcie->fw_reset_handshake &&
-	    trans->state >= IWL_TRANS_FW_STARTED)
-		iwl_trans_pcie_fw_reset_handshake(trans);
+	if (trans->state >= IWL_TRANS_FW_STARTED) {
+		if (trans->trans_cfg->device_family >= IWL_DEVICE_FAMILY_BZ) {
+			iwl_set_bit(trans, CSR_GP_CNTRL,
+				    CSR_GP_CNTRL_REG_FLAG_BUS_MASTER_DISABLE_REQ);
+			iwl_poll_bit(trans, CSR_GP_CNTRL,
+				     CSR_GP_CNTRL_REG_FLAG_BUS_MASTER_DISABLE_STATUS,
+				     CSR_GP_CNTRL_REG_FLAG_BUS_MASTER_DISABLE_STATUS,
+				     5000);
+			msleep(100);
+			iwl_set_bit(trans, CSR_GP_CNTRL,
+				    CSR_GP_CNTRL_REG_FLAG_SW_RESET);
+		} else if (trans_pcie->fw_reset_handshake) {
+			iwl_trans_pcie_fw_reset_handshake(trans);
+		}
+	}
 
 	trans_pcie->is_down = true;
 
-- 
2.32.0

