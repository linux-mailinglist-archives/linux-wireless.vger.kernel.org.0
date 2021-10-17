Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC4D0430958
	for <lists+linux-wireless@lfdr.de>; Sun, 17 Oct 2021 15:26:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343713AbhJQN20 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 17 Oct 2021 09:28:26 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:53888 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1343710AbhJQN2Z (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 17 Oct 2021 09:28:25 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=kveik.lan)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <luca@coelho.fi>)
        id 1mc6B3-000YdS-MP; Sun, 17 Oct 2021 16:26:14 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     luca@coelho.fi, linux-wireless@vger.kernel.org
Date:   Sun, 17 Oct 2021 16:26:01 +0300
Message-Id: <iwlwifi.20211017162352.cb04580b8521.I7129d4ba3dc689af839761d5807a10f99718893e@changeid>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211017132604.480251-1-luca@coelho.fi>
References: <20211017132604.480251-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.6
Subject: [PATCH 09/12] iwlwifi: remove redundant iwl_finish_nic_init() argument
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

We don't need this argument, since in all cases where the
function is called, trans->trans_cfg is already set (it's
in fact set during allocation). Remove it to avoid any
confusion about it.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/fw/dump.c         | 2 +-
 drivers/net/wireless/intel/iwlwifi/iwl-eeprom-read.c | 4 ++--
 drivers/net/wireless/intel/iwlwifi/iwl-io.c          | 4 ++--
 drivers/net/wireless/intel/iwlwifi/iwl-io.h          | 5 ++---
 drivers/net/wireless/intel/iwlwifi/pcie/trans-gen2.c | 2 +-
 drivers/net/wireless/intel/iwlwifi/pcie/trans.c      | 8 ++++----
 6 files changed, 12 insertions(+), 13 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/dump.c b/drivers/net/wireless/intel/iwlwifi/fw/dump.c
index a1842205e86a..d5a2c318759d 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/dump.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/dump.c
@@ -214,7 +214,7 @@ static void iwl_fwrt_dump_lmac_error_log(struct iwl_fw_runtime *fwrt, u8 lmac_nu
 		/* reset the device */
 		iwl_trans_sw_reset(trans);
 
-		err = iwl_finish_nic_init(trans, trans->trans_cfg);
+		err = iwl_finish_nic_init(trans);
 		if (err)
 			return;
 	}
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-eeprom-read.c b/drivers/net/wireless/intel/iwlwifi/iwl-eeprom-read.c
index dbab2f10d750..b9e86bf972e5 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-eeprom-read.c
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-eeprom-read.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
 /*
- * Copyright (C) 2005-2014, 2018-2019 Intel Corporation
+ * Copyright (C) 2005-2014, 2018-2019, 2021 Intel Corporation
  */
 #include <linux/types.h>
 #include <linux/slab.h>
@@ -139,7 +139,7 @@ static int iwl_init_otp_access(struct iwl_trans *trans)
 {
 	int ret;
 
-	ret = iwl_finish_nic_init(trans, trans->trans_cfg);
+	ret = iwl_finish_nic_init(trans);
 	if (ret)
 		return ret;
 
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-io.c b/drivers/net/wireless/intel/iwlwifi/iwl-io.c
index 2517c4ae07ab..6e96ee5bc261 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-io.c
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-io.c
@@ -398,9 +398,9 @@ int iwl_dump_fh(struct iwl_trans *trans, char **buf)
 	return 0;
 }
 
-int iwl_finish_nic_init(struct iwl_trans *trans,
-			const struct iwl_cfg_trans_params *cfg_trans)
+int iwl_finish_nic_init(struct iwl_trans *trans)
 {
+	const struct iwl_cfg_trans_params *cfg_trans = trans->trans_cfg;
 	u32 poll_ready;
 	int err;
 
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-io.h b/drivers/net/wireless/intel/iwlwifi/iwl-io.h
index 3c21c0e081f8..37b3bd62897e 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-io.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-io.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
 /*
- * Copyright (C) 2018-2020 Intel Corporation
+ * Copyright (C) 2018-2021 Intel Corporation
  */
 #ifndef __iwl_io_h__
 #define __iwl_io_h__
@@ -52,8 +52,7 @@ void iwl_set_bits_mask_prph(struct iwl_trans *trans, u32 ofs,
 void iwl_clear_bits_prph(struct iwl_trans *trans, u32 ofs, u32 mask);
 void iwl_force_nmi(struct iwl_trans *trans);
 
-int iwl_finish_nic_init(struct iwl_trans *trans,
-			const struct iwl_cfg_trans_params *cfg_trans);
+int iwl_finish_nic_init(struct iwl_trans *trans);
 
 /* Error handling */
 int iwl_dump_fh(struct iwl_trans *trans, char **buf);
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/trans-gen2.c b/drivers/net/wireless/intel/iwlwifi/pcie/trans-gen2.c
index 9983660c9079..a3ce487f1930 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/trans-gen2.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/trans-gen2.c
@@ -47,7 +47,7 @@ int iwl_pcie_gen2_apm_init(struct iwl_trans *trans)
 
 	iwl_pcie_apm_config(trans);
 
-	ret = iwl_finish_nic_init(trans, trans->trans_cfg);
+	ret = iwl_finish_nic_init(trans);
 	if (ret)
 		return ret;
 
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/trans.c b/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
index 12a402be2e06..262795368bfe 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
@@ -311,7 +311,7 @@ static int iwl_pcie_apm_init(struct iwl_trans *trans)
 	if (trans->trans_cfg->base_params->pll_cfg)
 		iwl_set_bit(trans, CSR_ANA_PLL_CFG, CSR50_ANA_PLL_CFG_VAL);
 
-	ret = iwl_finish_nic_init(trans, trans->trans_cfg);
+	ret = iwl_finish_nic_init(trans);
 	if (ret)
 		return ret;
 
@@ -383,7 +383,7 @@ static void iwl_pcie_apm_lp_xtal_enable(struct iwl_trans *trans)
 
 	iwl_trans_pcie_sw_reset(trans);
 
-	ret = iwl_finish_nic_init(trans, trans->trans_cfg);
+	ret = iwl_finish_nic_init(trans);
 	if (WARN_ON(ret)) {
 		/* Release XTAL ON request */
 		__iwl_trans_pcie_clear_bit(trans, CSR_GP_CNTRL,
@@ -1511,7 +1511,7 @@ static int iwl_trans_pcie_d3_resume(struct iwl_trans *trans,
 	iwl_set_bit(trans, CSR_GP_CNTRL,
 		    CSR_GP_CNTRL_REG_FLAG_MAC_ACCESS_REQ);
 
-	ret = iwl_finish_nic_init(trans, trans->trans_cfg);
+	ret = iwl_finish_nic_init(trans);
 	if (ret)
 		return ret;
 
@@ -1744,7 +1744,7 @@ static int iwl_pcie_gen2_force_power_gating(struct iwl_trans *trans)
 {
 	int ret;
 
-	ret = iwl_finish_nic_init(trans, trans->trans_cfg);
+	ret = iwl_finish_nic_init(trans);
 	if (ret < 0)
 		return ret;
 
-- 
2.33.0

