Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 646451B7A83
	for <lists+linux-wireless@lfdr.de>; Fri, 24 Apr 2020 17:48:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728955AbgDXPsi (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 24 Apr 2020 11:48:38 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:57924 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728711AbgDXPsh (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 24 Apr 2020 11:48:37 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <luca@coelho.fi>)
        id 1jS0Z7-000OY2-Mc; Fri, 24 Apr 2020 18:48:34 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Fri, 24 Apr 2020 18:48:14 +0300
Message-Id: <iwlwifi.20200424182644.b6e4982e62ae.I7f7352f79c40ada2f221bd4b41449a40821e833f@changeid>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200424154818.2657602-1-luca@coelho.fi>
References: <20200424154818.2657602-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.4
Subject: [PATCH 08/12] iwlwifi: mvm: remove iwlmvm's tfd_q_hang_detect module parameter
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Emmanuel Grumbach <emmanuel.grumbach@intel.com>

This should be controlled by the firmware debugging mechanism
and not by a module parameter. This has always been true.
Remove it and assume it is set.

Signed-off-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h   |  8 ++------
 drivers/net/wireless/intel/iwlwifi/mvm/ops.c   | 11 ++---------
 drivers/net/wireless/intel/iwlwifi/mvm/sta.c   | 16 ++++++----------
 drivers/net/wireless/intel/iwlwifi/mvm/utils.c |  9 +++------
 4 files changed, 13 insertions(+), 31 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
index 9e2a0858108c..e2f7f6ec711e 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
@@ -5,10 +5,9 @@
  *
  * GPL LICENSE SUMMARY
  *
- * Copyright(c) 2012 - 2014 Intel Corporation. All rights reserved.
+ * Copyright(c) 2012 - 2014, 2018 - 2020 Intel Corporation. All rights reserved.
  * Copyright(c) 2013 - 2015 Intel Mobile Communications GmbH
  * Copyright(c) 2016 - 2017 Intel Deutschland GmbH
- * Copyright(c) 2018 - 2019 Intel Corporation
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of version 2 of the GNU General Public License as
@@ -28,10 +27,9 @@
  *
  * BSD LICENSE
  *
- * Copyright(c) 2012 - 2014 Intel Corporation. All rights reserved.
+ * Copyright(c) 2012 - 2014, 2018 - 2020 Intel Corporation. All rights reserved.
  * Copyright(c) 2013 - 2015 Intel Mobile Communications GmbH
  * Copyright(c) 2016 - 2017 Intel Deutschland GmbH
- * Copyright(c) 2018 - 2019 Intel Corporation
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
@@ -134,12 +132,10 @@ extern const struct ieee80211_ops iwl_mvm_hw_ops;
  *	We will register to mac80211 to have testmode working. The NIC must not
  *	be up'ed after the INIT fw asserted. This is useful to be able to use
  *	proprietary tools over testmode to debug the INIT fw.
- * @tfd_q_hang_detect: enabled the detection of hung transmit queues
  * @power_scheme: one of enum iwl_power_scheme
  */
 struct iwl_mvm_mod_params {
 	bool init_dbg;
-	bool tfd_q_hang_detect;
 	int power_scheme;
 };
 extern struct iwl_mvm_mod_params iwlmvm_mod_params;
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/ops.c b/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
index d0afc806706d..bde1b9b5face 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
@@ -5,10 +5,9 @@
  *
  * GPL LICENSE SUMMARY
  *
- * Copyright(c) 2012 - 2014 Intel Corporation. All rights reserved.
+ * Copyright(c) 2012 - 2014, 2018 - 2020 Intel Corporation. All rights reserved.
  * Copyright(c) 2013 - 2015 Intel Mobile Communications GmbH
  * Copyright(c) 2016 - 2017 Intel Deutschland GmbH
- * Copyright(c) 2018 - 2019 Intel Corporation
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of version 2 of the GNU General Public License as
@@ -28,10 +27,9 @@
  *
  * BSD LICENSE
  *
- * Copyright(c) 2012 - 2014 Intel Corporation. All rights reserved.
+ * Copyright(c) 2012 - 2014, 2018 - 2020 Intel Corporation. All rights reserved.
  * Copyright(c) 2013 - 2015 Intel Mobile Communications GmbH
  * Copyright(c) 2016 - 2017 Intel Deutschland GmbH
- * Copyright(c) 2018 - 2019 Intel Corporation
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
@@ -94,7 +92,6 @@ static const struct iwl_op_mode_ops iwl_mvm_ops_mq;
 
 struct iwl_mvm_mod_params iwlmvm_mod_params = {
 	.power_scheme = IWL_POWER_SCHEME_BPS,
-	.tfd_q_hang_detect = true
 	/* rest of fields are 0 by default */
 };
 
@@ -104,10 +101,6 @@ MODULE_PARM_DESC(init_dbg,
 module_param_named(power_scheme, iwlmvm_mod_params.power_scheme, int, 0444);
 MODULE_PARM_DESC(power_scheme,
 		 "power management scheme: 1-active, 2-balanced, 3-low power, default: 2");
-module_param_named(tfd_q_hang_detect, iwlmvm_mod_params.tfd_q_hang_detect,
-		   bool, 0444);
-MODULE_PARM_DESC(tfd_q_hang_detect,
-		 "TFD queues hang detection (default: true");
 
 /*
  * module init and exit functions
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/sta.c b/drivers/net/wireless/intel/iwlwifi/mvm/sta.c
index 64ef3f3ba23b..1a210292f56c 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/sta.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/sta.c
@@ -5,10 +5,9 @@
  *
  * GPL LICENSE SUMMARY
  *
- * Copyright(c) 2012 - 2015 Intel Corporation. All rights reserved.
+ * Copyright(c) 2012 - 2015, 2018 - 2020 Intel Corporation. All rights reserved.
  * Copyright(c) 2013 - 2015 Intel Mobile Communications GmbH
  * Copyright(c) 2016 - 2017 Intel Deutschland GmbH
- * Copyright(c) 2018 - 2019 Intel Corporation
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of version 2 of the GNU General Public License as
@@ -28,10 +27,9 @@
  *
  * BSD LICENSE
  *
- * Copyright(c) 2012 - 2015 Intel Corporation. All rights reserved.
+ * Copyright(c) 2012 - 2015, 2018 - 2020 Intel Corporation. All rights reserved.
  * Copyright(c) 2013 - 2015 Intel Mobile Communications GmbH
  * Copyright(c) 2016 - 2017 Intel Deutschland GmbH
- * Copyright(c) 2018 - 2019 Intel Corporation
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
@@ -1960,9 +1958,8 @@ void iwl_mvm_dealloc_int_sta(struct iwl_mvm *mvm, struct iwl_mvm_int_sta *sta)
 static void iwl_mvm_enable_aux_snif_queue(struct iwl_mvm *mvm, u16 queue,
 					  u8 sta_id, u8 fifo)
 {
-	unsigned int wdg_timeout = iwlmvm_mod_params.tfd_q_hang_detect ?
-		mvm->trans->trans_cfg->base_params->wd_timeout :
-		IWL_WATCHDOG_DISABLED;
+	unsigned int wdg_timeout =
+		mvm->trans->trans_cfg->base_params->wd_timeout;
 	struct iwl_trans_txq_scd_cfg cfg = {
 		.fifo = fifo,
 		.sta_id = sta_id,
@@ -1978,9 +1975,8 @@ static void iwl_mvm_enable_aux_snif_queue(struct iwl_mvm *mvm, u16 queue,
 
 static int iwl_mvm_enable_aux_snif_queue_tvqm(struct iwl_mvm *mvm, u8 sta_id)
 {
-	unsigned int wdg_timeout = iwlmvm_mod_params.tfd_q_hang_detect ?
-		mvm->trans->trans_cfg->base_params->wd_timeout :
-		IWL_WATCHDOG_DISABLED;
+	unsigned int wdg_timeout =
+		mvm->trans->trans_cfg->base_params->wd_timeout;
 
 	WARN_ON(!iwl_mvm_has_new_tx_api(mvm));
 
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/utils.c b/drivers/net/wireless/intel/iwlwifi/mvm/utils.c
index 6096276cb0d0..ee8f152e7606 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/utils.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/utils.c
@@ -5,10 +5,9 @@
  *
  * GPL LICENSE SUMMARY
  *
- * Copyright(c) 2012 - 2014 Intel Corporation. All rights reserved.
+ * Copyright(c) 2012 - 2014, 2018 - 2020 Intel Corporation. All rights reserved.
  * Copyright(c) 2013 - 2014 Intel Mobile Communications GmbH
  * Copyright (C) 2015 - 2017 Intel Deutschland GmbH
- * Copyright(c) 2018 Intel Corporation
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of version 2 of the GNU General Public License as
@@ -28,10 +27,9 @@
  *
  * BSD LICENSE
  *
- * Copyright(c) 2012 - 2014 Intel Corporation. All rights reserved.
+ * Copyright(c) 2012 - 2014, 2018 - 2020 Intel Corporation. All rights reserved.
  * Copyright(c) 2013 - 2014 Intel Mobile Communications GmbH
  * Copyright (C) 2015 - 2017 Intel Deutschland GmbH
- * Copyright(c) 2018 Intel Corporation
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
@@ -952,8 +950,7 @@ unsigned int iwl_mvm_get_wd_timeout(struct iwl_mvm *mvm,
 				IWL_UCODE_TLV_CAPA_STA_PM_NOTIF) &&
 		    vif && vif->type == NL80211_IFTYPE_AP)
 			return IWL_WATCHDOG_DISABLED;
-		return iwlmvm_mod_params.tfd_q_hang_detect ?
-			default_timeout : IWL_WATCHDOG_DISABLED;
+		return default_timeout;
 	}
 
 	trigger = iwl_fw_dbg_get_trigger(mvm->fw, FW_DBG_TRIGGER_TXQ_TIMERS);
-- 
2.26.2

