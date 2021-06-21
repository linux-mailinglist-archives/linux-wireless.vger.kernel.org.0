Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA56F3AE444
	for <lists+linux-wireless@lfdr.de>; Mon, 21 Jun 2021 09:37:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230061AbhFUHkJ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 21 Jun 2021 03:40:09 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:48442 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S230075AbhFUHkI (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 21 Jun 2021 03:40:08 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=kveik.lan)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94)
        (envelope-from <luca@coelho.fi>)
        id 1lvEVD-001aFa-Uz; Mon, 21 Jun 2021 10:37:53 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     luca@coelho.fi, linux-wireless@vger.kernel.org
Date:   Mon, 21 Jun 2021 10:37:38 +0300
Message-Id: <iwlwifi.20210621103449.4179f7191531.I3d5ed6b2b39fcd42863a679e21bda23a6c14253e@changeid>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210621073740.1105911-1-luca@coelho.fi>
References: <20210621073740.1105911-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.5-pre1 (2020-06-20) on
        farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.5-pre1
Subject: [PATCH 7/9] iwlwifi: add 9560 killer device
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: ybaruch <yaara.baruch@intel.com>

add new killer devices configurations.

Signed-off-by: ybaruch <yaara.baruch@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/cfg/9000.c   | 6 +++++-
 drivers/net/wireless/intel/iwlwifi/iwl-config.h | 2 ++
 drivers/net/wireless/intel/iwlwifi/pcie/drv.c   | 2 ++
 3 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/cfg/9000.c b/drivers/net/wireless/intel/iwlwifi/cfg/9000.c
index df1297358379..871533beff30 100644
--- a/drivers/net/wireless/intel/iwlwifi/cfg/9000.c
+++ b/drivers/net/wireless/intel/iwlwifi/cfg/9000.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
 /*
  * Copyright (C) 2015-2017 Intel Deutschland GmbH
- * Copyright (C) 2018-2020 Intel Corporation
+ * Copyright (C) 2018-2021 Intel Corporation
  */
 #include <linux/module.h>
 #include <linux/stringify.h>
@@ -171,8 +171,12 @@ const char iwl9260_killer_1550_name[] =
 	"Killer (R) Wireless-AC 1550 Wireless Network Adapter (9260NGW) 160MHz";
 const char iwl9560_killer_1550i_name[] =
 	"Killer (R) Wireless-AC 1550i Wireless Network Adapter (9560NGW)";
+const char iwl9560_killer_1550i_160_name[] =
+	"Killer(R) Wireless-AC 1550i Wireless Network Adapter (9560NGW) 160MHz";
 const char iwl9560_killer_1550s_name[] =
 	"Killer (R) Wireless-AC 1550s Wireless Network Adapter (9560NGW)";
+const char iwl9560_killer_1550s_160_name[] =
+	"Killer(R) Wireless-AC 1550s Wireless Network Adapter (9560D2W) 160MHz";
 
 const struct iwl_cfg iwl9260_2ac_cfg = {
 	.fw_name_pre = IWL9260_FW_PRE,
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-config.h b/drivers/net/wireless/intel/iwlwifi/iwl-config.h
index 3e4c6a809595..bf6ee56d4d96 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-config.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-config.h
@@ -506,6 +506,8 @@ extern const char iwl_ax201_killer_1650s_name[];
 extern const char iwl_ax201_killer_1650i_name[];
 extern const char iwl_ax210_killer_1675w_name[];
 extern const char iwl_ax210_killer_1675x_name[];
+extern const char iwl9560_killer_1550i_160_name[];
+extern const char iwl9560_killer_1550s_160_name[];
 extern const char iwl_ax211_name[];
 extern const char iwl_ax221_name[];
 extern const char iwl_ax231_name[];
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
index d7106a51e8bf..863c10e602d5 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
@@ -532,6 +532,8 @@ static const struct iwl_dev_info iwl_dev_info_table[] = {
 	IWL_DEV_INFO(0x31DC, 0x1552, iwl9560_2ac_cfg_soc, iwl9560_killer_1550i_name),
 	IWL_DEV_INFO(0xA370, 0x1551, iwl9560_2ac_cfg_soc, iwl9560_killer_1550s_name),
 	IWL_DEV_INFO(0xA370, 0x1552, iwl9560_2ac_cfg_soc, iwl9560_killer_1550i_name),
+	IWL_DEV_INFO(0x51F0, 0x1552, iwl9560_2ac_cfg_soc, iwl9560_killer_1550s_160_name),
+	IWL_DEV_INFO(0x51F0, 0x1551, iwl9560_2ac_cfg_soc, iwl9560_killer_1550i_160_name),
 
 	IWL_DEV_INFO(0x271C, 0x0214, iwl9260_2ac_cfg, iwl9260_1_name),
 
-- 
2.32.0

