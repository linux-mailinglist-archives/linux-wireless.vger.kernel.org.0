Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9443C1B7A7F
	for <lists+linux-wireless@lfdr.de>; Fri, 24 Apr 2020 17:48:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728706AbgDXPse (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 24 Apr 2020 11:48:34 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:57896 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728455AbgDXPsd (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 24 Apr 2020 11:48:33 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <luca@coelho.fi>)
        id 1jS0Z4-000OY2-3x; Fri, 24 Apr 2020 18:48:30 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Fri, 24 Apr 2020 18:48:10 +0300
Message-Id: <iwlwifi.20200424182644.6e566897ce0a.I8395a50c1c39522e542366064bff33a33009ce7b@changeid>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200424154818.2657602-1-luca@coelho.fi>
References: <20200424154818.2657602-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.4
Subject: [PATCH 04/12] iwlwifi: remove antenna_coupling module parameter
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Emmanuel Grumbach <emmanuel.grumbach@intel.com>

This module parameter should not be mangled by users.
This relates to a very old driver and I doubt people can
really check the antenna coupling in a way that would make
the BT Coexistence work better with a real value.
Drop it.

Signed-off-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/dvm/dev.h       |  3 +--
 drivers/net/wireless/intel/iwlwifi/dvm/main.c      |  9 +--------
 drivers/net/wireless/intel/iwlwifi/dvm/rs.c        | 11 +----------
 drivers/net/wireless/intel/iwlwifi/iwl-drv.c       | 11 ++---------
 drivers/net/wireless/intel/iwlwifi/iwl-modparams.h |  8 ++------
 5 files changed, 7 insertions(+), 35 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/dvm/dev.h b/drivers/net/wireless/intel/iwlwifi/dvm/dev.h
index 8d8380026180..4bd792c06ff6 100644
--- a/drivers/net/wireless/intel/iwlwifi/dvm/dev.h
+++ b/drivers/net/wireless/intel/iwlwifi/dvm/dev.h
@@ -1,7 +1,7 @@
 /* SPDX-License-Identifier: GPL-2.0-only */
 /******************************************************************************
  *
- * Copyright(c) 2003 - 2014 Intel Corporation. All rights reserved.
+ * Copyright(c) 2003 - 2014, 2020 Intel Corporation. All rights reserved.
  *
  * Contact Information:
  *  Intel Linux Wireless <linuxwifi@intel.com>
@@ -810,7 +810,6 @@ struct iwl_priv {
 	u8 bt_traffic_load, last_bt_traffic_load;
 	bool bt_ch_announce;
 	bool bt_full_concurrent;
-	bool bt_ant_couple_ok;
 	__le32 kill_ack_mask;
 	__le32 kill_cts_mask;
 	__le16 bt_valid;
diff --git a/drivers/net/wireless/intel/iwlwifi/dvm/main.c b/drivers/net/wireless/intel/iwlwifi/dvm/main.c
index 598ee7315558..99822744122f 100644
--- a/drivers/net/wireless/intel/iwlwifi/dvm/main.c
+++ b/drivers/net/wireless/intel/iwlwifi/dvm/main.c
@@ -1,9 +1,8 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /******************************************************************************
  *
- * Copyright(c) 2003 - 2014 Intel Corporation. All rights reserved.
+ * Copyright(c) 2003 - 2014, 2018 - 2020  Intel Corporation. All rights reserved.
  * Copyright(c) 2015 Intel Deutschland GmbH
- * Copyright (C) 2018 - 2019 Intel Corporation
  *
  * Portions of this file are derived from the ipw3945 project, as well
  * as portions of the ieee80211 subsystem header files.
@@ -1370,12 +1369,6 @@ static struct iwl_op_mode *iwl_op_mode_dvm_start(struct iwl_trans *trans,
 
 	IWL_DEBUG_INFO(priv, "*** LOAD DRIVER ***\n");
 
-	/* is antenna coupling more than 35dB ? */
-	priv->bt_ant_couple_ok =
-		(iwlwifi_mod_params.antenna_coupling >
-			IWL_BT_ANTENNA_COUPLING_THRESHOLD) ?
-			true : false;
-
 	/* bt channel inhibition enabled*/
 	priv->bt_ch_announce = true;
 	IWL_DEBUG_INFO(priv, "BT channel inhibition is %s\n",
diff --git a/drivers/net/wireless/intel/iwlwifi/dvm/rs.c b/drivers/net/wireless/intel/iwlwifi/dvm/rs.c
index 226165db7dfd..7e49e1068407 100644
--- a/drivers/net/wireless/intel/iwlwifi/dvm/rs.c
+++ b/drivers/net/wireless/intel/iwlwifi/dvm/rs.c
@@ -2,6 +2,7 @@
 /******************************************************************************
  *
  * Copyright(c) 2005 - 2014 Intel Corporation. All rights reserved.
+ * Copyright (C) 2019 - 2020 Intel Corporation
  *
  * Contact Information:
  *  Intel Linux Wireless <linuxwifi@intel.com>
@@ -846,16 +847,6 @@ static void rs_bt_update_lq(struct iwl_priv *priv, struct iwl_rxon_context *ctx,
 	struct iwl_scale_tbl_info *tbl;
 	bool full_concurrent = priv->bt_full_concurrent;
 
-	if (priv->bt_ant_couple_ok) {
-		/*
-		 * Is there a need to switch between
-		 * full concurrency and 3-wire?
-		 */
-		if (priv->bt_ci_compliance)
-			full_concurrent = true;
-		else
-			full_concurrent = false;
-	}
 	if ((priv->bt_traffic_load != priv->last_bt_traffic_load) ||
 	    (priv->bt_full_concurrent != full_concurrent)) {
 		priv->bt_full_concurrent = full_concurrent;
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-drv.c b/drivers/net/wireless/intel/iwlwifi/iwl-drv.c
index 9ff12c207f25..68dc1f046064 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-drv.c
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-drv.c
@@ -5,10 +5,9 @@
  *
  * GPL LICENSE SUMMARY
  *
- * Copyright(c) 2007 - 2014 Intel Corporation. All rights reserved.
+ * Copyright(c) 2007 - 2014, 2018 - 2020  Intel Corporation. All rights reserved.
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
- * Copyright(c) 2005 - 2014 Intel Corporation. All rights reserved.
+ * Copyright(c) 2005 - 2014, 2018 - 2020 Intel Corporation. All rights reserved.
  * Copyright(c) 2013 - 2015 Intel Mobile Communications GmbH
  * Copyright(c) 2016 - 2017 Intel Deutschland GmbH
- * Copyright(c) 2018 - 2019 Intel Corporation
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
@@ -1824,11 +1822,6 @@ MODULE_PARM_DESC(amsdu_size,
 module_param_named(fw_restart, iwlwifi_mod_params.fw_restart, bool, 0444);
 MODULE_PARM_DESC(fw_restart, "restart firmware in case of error (default true)");
 
-module_param_named(antenna_coupling, iwlwifi_mod_params.antenna_coupling,
-		   int, 0444);
-MODULE_PARM_DESC(antenna_coupling,
-		 "specify antenna coupling in dB (default: 0 dB)");
-
 module_param_named(nvm_file, iwlwifi_mod_params.nvm_file, charp, 0444);
 MODULE_PARM_DESC(nvm_file, "NVM file name");
 
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-modparams.h b/drivers/net/wireless/intel/iwlwifi/iwl-modparams.h
index b094cc1e9be0..e8ce3a300857 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-modparams.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-modparams.h
@@ -5,8 +5,7 @@
  *
  * GPL LICENSE SUMMARY
  *
- * Copyright(c) 2007 - 2014 Intel Corporation. All rights reserved.
- * Copyright(c) 2018 - 2019 Intel Corporation
+ * Copyright(c) 2007 - 2014, 2018 - 2020 Intel Corporation. All rights reserved.
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of version 2 of the GNU General Public License as
@@ -26,8 +25,7 @@
  *
  * BSD LICENSE
  *
- * Copyright(c) 2005 - 2014 Intel Corporation. All rights reserved.
- * Copyright(c) 2018 - 2019 Intel Corporation
+ * Copyright(c) 2005 - 2014, 2018 - 2020 Intel Corporation. All rights reserved.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
@@ -111,7 +109,6 @@ enum iwl_uapsd_disable {
  * @power_save: enable power save, default = false
  * @power_level: power level, default = 1
  * @debug_level: levels are IWL_DL_*
- * @antenna_coupling: antenna coupling in dB, default = 0
  * @nvm_file: specifies a external NVM file
  * @uapsd_disable: disable U-APSD, see &enum iwl_uapsd_disable, default =
  *	IWL_DISABLE_UAPSD_BSS | IWL_DISABLE_UAPSD_P2P_CLIENT
@@ -131,7 +128,6 @@ struct iwl_mod_params {
 #ifdef CONFIG_IWLWIFI_DEBUG
 	u32 debug_level;
 #endif
-	int antenna_coupling;
 	char *nvm_file;
 	u32 uapsd_disable;
 	bool disable_11ac;
-- 
2.26.2

