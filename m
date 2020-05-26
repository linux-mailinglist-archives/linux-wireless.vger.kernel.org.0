Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E949F1AEAB8
	for <lists+linux-wireless@lfdr.de>; Sat, 18 Apr 2020 10:09:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726067AbgDRIJX (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 18 Apr 2020 04:09:23 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:56788 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726054AbgDRIJW (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 18 Apr 2020 04:09:22 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <luca@coelho.fi>)
        id 1jPiXQ-000L3r-2L; Sat, 18 Apr 2020 11:09:20 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Sat, 18 Apr 2020 11:08:54 +0300
Message-Id: <iwlwifi.20200418110539.24276ae2ad61.I8831a538f75893d5cee47b4a81f4b9b7fd0e8bea@changeid>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200418080857.2232093-1-luca@coelho.fi>
References: <20200418080857.2232093-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.4
Subject: [PATCH 09/12] iwlwifi: mvm: tell firmware about required LTR delay
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

Some (integrated) devices need a longer LTR delay than the firmware
would typically apply, tell it about that.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/cfg/22000.c  |  2 ++
 drivers/net/wireless/intel/iwlwifi/fw/api/soc.h | 12 ++++++++----
 drivers/net/wireless/intel/iwlwifi/iwl-config.h | 17 ++++++++++++-----
 drivers/net/wireless/intel/iwlwifi/mvm/fw.c     | 14 ++++++++++++++
 4 files changed, 36 insertions(+), 9 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/cfg/22000.c b/drivers/net/wireless/intel/iwlwifi/cfg/22000.c
index 35fa89d28fef..1f30d8fdf35d 100644
--- a/drivers/net/wireless/intel/iwlwifi/cfg/22000.c
+++ b/drivers/net/wireless/intel/iwlwifi/cfg/22000.c
@@ -243,6 +243,7 @@ const struct iwl_cfg_trans_params iwl_qu_trans_cfg = {
 	.base_params = &iwl_22000_base_params,
 	.integrated = true,
 	.xtal_latency = 5000,
+	.ltr_delay = IWL_CFG_TRANS_LTR_DELAY_200US,
 };
 
 const struct iwl_cfg_trans_params iwl_qu_long_latency_trans_cfg = {
@@ -255,6 +256,7 @@ const struct iwl_cfg_trans_params iwl_qu_long_latency_trans_cfg = {
 	.integrated = true,
 	.xtal_latency = 12000,
 	.low_latency_xtal = true,
+	.ltr_delay = IWL_CFG_TRANS_LTR_DELAY_2500US,
 };
 
 const struct iwl_cfg_trans_params iwl_qnj_trans_cfg = {
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/soc.h b/drivers/net/wireless/intel/iwlwifi/fw/api/soc.h
index aadca78e9846..0c6d7b3e1324 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/soc.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/soc.h
@@ -5,10 +5,9 @@
  *
  * GPL LICENSE SUMMARY
  *
- * Copyright(c) 2012 - 2014 Intel Corporation. All rights reserved.
  * Copyright(c) 2013 - 2015 Intel Mobile Communications GmbH
  * Copyright(c) 2016 - 2017 Intel Deutschland GmbH
- * Copyright(c) 2019        Intel Deutschland GmbH
+ * Copyright(c) 2012 - 2014, 2019 - 2020 Intel Corporation
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of version 2 of the GNU General Public License as
@@ -28,10 +27,9 @@
  *
  * BSD LICENSE
  *
- * Copyright(c) 2012 - 2014 Intel Corporation. All rights reserved.
  * Copyright(c) 2013 - 2015 Intel Mobile Communications GmbH
  * Copyright(c) 2016 - 2017 Intel Deutschland GmbH
- * Copyright(c) 2019        Intel Deutschland GmbH
+ * Copyright(c) 2012 - 2014, 2019 - 2020 Intel Corporation
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
@@ -68,6 +66,12 @@
 #define SOC_CONFIG_CMD_FLAGS_DISCRETE		BIT(0)
 #define SOC_CONFIG_CMD_FLAGS_LOW_LATENCY	BIT(1)
 
+#define SOC_FLAGS_LTR_APPLY_DELAY_MASK		0xc
+#define SOC_FLAGS_LTR_APPLY_DELAY_NONE		0
+#define SOC_FLAGS_LTR_APPLY_DELAY_200		1
+#define SOC_FLAGS_LTR_APPLY_DELAY_2500		2
+#define SOC_FLAGS_LTR_APPLY_DELAY_1820		3
+
 /**
  * struct iwl_soc_configuration_cmd - Set device stabilization latency
  *
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-config.h b/drivers/net/wireless/intel/iwlwifi/iwl-config.h
index 3ed8ead8a9bb..9b31fcc37ace 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-config.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-config.h
@@ -5,9 +5,8 @@
  *
  * GPL LICENSE SUMMARY
  *
- * Copyright(c) 2007 - 2014 Intel Corporation. All rights reserved.
  * Copyright (C) 2016 - 2017 Intel Deutschland GmbH
- * Copyright(c) 2018 - 2019 Intel Corporation
+ * Copyright(c) 2007 - 2014, 2018 - 2020 Intel Corporation
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of version 2 of the GNU General Public License as
@@ -27,9 +26,8 @@
  *
  * BSD LICENSE
  *
- * Copyright(c) 2005 - 2014 Intel Corporation. All rights reserved.
  * Copyright (C) 2016 - 2017 Intel Deutschland GmbH
- * Copyright(c) 2018 - 2019 Intel Corporation
+ * Copyright(c) 2005 - 2014, 2018 - 2020 Intel Corporation
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
@@ -284,6 +282,13 @@ struct iwl_pwr_tx_backoff {
 	u32 backoff;
 };
 
+enum iwl_cfg_trans_ltr_delay {
+	IWL_CFG_TRANS_LTR_DELAY_NONE	= 0,
+	IWL_CFG_TRANS_LTR_DELAY_200US	= 1,
+	IWL_CFG_TRANS_LTR_DELAY_2500US	= 2,
+	IWL_CFG_TRANS_LTR_DELAY_1820US	= 3,
+};
+
 /**
  * struct iwl_cfg_trans - information needed to start the trans
  *
@@ -304,6 +309,7 @@ struct iwl_pwr_tx_backoff {
  * @mq_rx_supported: multi-queue rx support
  * @integrated: discrete or integrated
  * @low_latency_xtal: use the low latency xtal if supported
+ * @ltr_delay: LTR delay parameter, &enum iwl_cfg_trans_ltr_delay.
  */
 struct iwl_cfg_trans_params {
 	const struct iwl_base_params *base_params;
@@ -317,7 +323,8 @@ struct iwl_cfg_trans_params {
 	    mq_rx_supported:1,
 	    integrated:1,
 	    low_latency_xtal:1,
-	    bisr_workaround:1;
+	    bisr_workaround:1,
+	    ltr_delay:2;
 };
 
 /**
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
index bf3eaadfb343..d6598339c55c 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
@@ -102,6 +102,20 @@ static int iwl_set_soc_latency(struct iwl_mvm *mvm)
 	if (!mvm->trans->trans_cfg->integrated)
 		cmd.flags = cpu_to_le32(SOC_CONFIG_CMD_FLAGS_DISCRETE);
 
+	BUILD_BUG_ON(IWL_CFG_TRANS_LTR_DELAY_NONE !=
+		     SOC_FLAGS_LTR_APPLY_DELAY_NONE);
+	BUILD_BUG_ON(IWL_CFG_TRANS_LTR_DELAY_200US !=
+		     SOC_FLAGS_LTR_APPLY_DELAY_200);
+	BUILD_BUG_ON(IWL_CFG_TRANS_LTR_DELAY_2500US !=
+		     SOC_FLAGS_LTR_APPLY_DELAY_2500);
+	BUILD_BUG_ON(IWL_CFG_TRANS_LTR_DELAY_1820US !=
+		     SOC_FLAGS_LTR_APPLY_DELAY_1820);
+
+	if (mvm->trans->trans_cfg->ltr_delay != IWL_CFG_TRANS_LTR_DELAY_NONE &&
+	    !WARN_ON(!mvm->trans->trans_cfg->integrated))
+		cmd.flags |= le32_encode_bits(mvm->trans->trans_cfg->ltr_delay,
+					      SOC_FLAGS_LTR_APPLY_DELAY_MASK);
+
 	if (iwl_fw_lookup_cmd_ver(mvm->fw, IWL_ALWAYS_LONG_GROUP,
 				  SCAN_REQ_UMAC) >= 2 &&
 	    mvm->trans->trans_cfg->low_latency_xtal)
-- 
2.25.1

