Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B8076DD7AC
	for <lists+linux-wireless@lfdr.de>; Sat, 19 Oct 2019 11:39:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726027AbfJSJjL (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 19 Oct 2019 05:39:11 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:50394 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725812AbfJSJjL (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 19 Oct 2019 05:39:11 -0400
Received: from [91.156.6.193] (helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.92)
        (envelope-from <luca@coelho.fi>)
        id 1iLlCX-0002fy-7P; Sat, 19 Oct 2019 12:39:09 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Sat, 19 Oct 2019 12:38:51 +0300
Message-Id: <20191019123747.7b0596d91b2e.Iff59ce78eebe633cecebadc69ba3d98cc4154888@changeid>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191019093902.29823-1-luca@coelho.fi>
References: <20191019093902.29823-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.2
Subject: [PATCH 01/12] iwlwifi: mvm: fix support for single antenna diversity
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Luca Coelho <luciano.coelho@intel.com>

When the single antenna diversity support was sent upstream, only some
definitions were sent, due to a bad revert.

Fix this by adding the actual code.

Fixes: 5952e0ec3f05 ("iwlwifi: mvm: add support for single antenna diversity")
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/fw.c | 20 ++++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
index 32a5e4e5461f..7afdf0c1b1e9 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
@@ -511,6 +511,18 @@ static int iwl_send_phy_cfg_cmd(struct iwl_mvm *mvm)
 	struct iwl_phy_cfg_cmd phy_cfg_cmd;
 	enum iwl_ucode_type ucode_type = mvm->fwrt.cur_fw_img;
 
+	if (iwl_mvm_has_unified_ucode(mvm) &&
+	    !mvm->trans->cfg->tx_with_siso_diversity) {
+		return 0;
+	} else if (mvm->trans->cfg->tx_with_siso_diversity) {
+		/*
+		 * TODO: currently we don't set the antenna but letting the NIC
+		 * to decide which antenna to use. This should come from BIOS.
+		 */
+		phy_cfg_cmd.phy_cfg =
+			cpu_to_le32(FW_PHY_CFG_CHAIN_SAD_ENABLED);
+	}
+
 	/* Set parameters */
 	phy_cfg_cmd.phy_cfg = cpu_to_le32(iwl_mvm_get_phy_config(mvm));
 
@@ -1327,12 +1339,12 @@ int iwl_mvm_up(struct iwl_mvm *mvm)
 		ret = iwl_send_phy_db_data(mvm->phy_db);
 		if (ret)
 			goto error;
-
-		ret = iwl_send_phy_cfg_cmd(mvm);
-		if (ret)
-			goto error;
 	}
 
+	ret = iwl_send_phy_cfg_cmd(mvm);
+	if (ret)
+		goto error;
+
 	ret = iwl_mvm_send_bt_init_conf(mvm);
 	if (ret)
 		goto error;
-- 
2.23.0

