Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 203F8430987
	for <lists+linux-wireless@lfdr.de>; Sun, 17 Oct 2021 16:00:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343812AbhJQOCP (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 17 Oct 2021 10:02:15 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:53946 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1343777AbhJQOCK (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 17 Oct 2021 10:02:10 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=kveik.lan)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <luca@coelho.fi>)
        id 1mc6hi-000Yi6-K9; Sun, 17 Oct 2021 16:59:59 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     luca@coelho.fi, linux-wireless@vger.kernel.org
Date:   Sun, 17 Oct 2021 16:59:47 +0300
Message-Id: <iwlwifi.20211017165728.9a3d01b8c4e9.I9720afa0a6ea72f94ed4a3f3cf88294174ab905b@changeid>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211017135954.504836-1-luca@coelho.fi>
References: <20211017135954.504836-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.6
Subject: [PATCH 03/10] iwlwifi: add new killer devices to the driver
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Yaara Baruch <yaara.baruch@intel.com>

Add 1550, 1675 and 1690 killer devices to the driver.

Signed-off-by: Yaara Baruch <yaara.baruch@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 .../net/wireless/intel/iwlwifi/cfg/22000.c    |  8 ++++++++
 .../net/wireless/intel/iwlwifi/iwl-config.h   |  4 ++++
 drivers/net/wireless/intel/iwlwifi/pcie/drv.c | 20 +++++++++++++++++++
 3 files changed, 32 insertions(+)

diff --git a/drivers/net/wireless/intel/iwlwifi/cfg/22000.c b/drivers/net/wireless/intel/iwlwifi/cfg/22000.c
index d8231cc821ae..64861406b2f3 100644
--- a/drivers/net/wireless/intel/iwlwifi/cfg/22000.c
+++ b/drivers/net/wireless/intel/iwlwifi/cfg/22000.c
@@ -469,6 +469,14 @@ const char iwl_ax210_killer_1675w_name[] =
 	"Killer(R) Wi-Fi 6E AX1675w 160MHz Wireless Network Adapter (210D2W)";
 const char iwl_ax210_killer_1675x_name[] =
 	"Killer(R) Wi-Fi 6E AX1675x 160MHz Wireless Network Adapter (210NGW)";
+const char iwl_ax211_killer_1675s_name[] =
+	"Killer(R) Wi-Fi 6E AX1675s 160MHz Wireless Network Adapter (211NGW)";
+const char iwl_ax211_killer_1675i_name[] =
+	"Killer(R) Wi-Fi 6E AX1675i 160MHz Wireless Network Adapter (211NGW)";
+const char iwl_ax411_killer_1690s_name[] =
+	"Killer(R) Wi-Fi 6E AX1690s 160MHz Wireless Network Adapter (411D2W)";
+const char iwl_ax411_killer_1690i_name[] =
+	"Killer(R) Wi-Fi 6E AX1690i 160MHz Wireless Network Adapter (411NGW)";
 
 const struct iwl_cfg iwl_qu_b0_hr1_b0 = {
 	.fw_name_pre = IWL_QU_B_HR_B_FW_PRE,
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-config.h b/drivers/net/wireless/intel/iwlwifi/iwl-config.h
index 03b71c36f841..814c98c8bfe0 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-config.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-config.h
@@ -510,6 +510,10 @@ extern const char iwl_ax210_killer_1675w_name[];
 extern const char iwl_ax210_killer_1675x_name[];
 extern const char iwl9560_killer_1550i_160_name[];
 extern const char iwl9560_killer_1550s_160_name[];
+extern const char iwl_ax211_killer_1675s_name[];
+extern const char iwl_ax211_killer_1675i_name[];
+extern const char iwl_ax411_killer_1690s_name[];
+extern const char iwl_ax411_killer_1690i_name[];
 extern const char iwl_ax211_name[];
 extern const char iwl_ax221_name[];
 extern const char iwl_ax231_name[];
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
index 340e2568d3e7..677c2249b13f 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
@@ -532,10 +532,20 @@ static const struct iwl_dev_info iwl_dev_info_table[] = {
 	IWL_DEV_INFO(0x31DC, 0x1552, iwl9560_2ac_cfg_soc, iwl9560_killer_1550i_name),
 	IWL_DEV_INFO(0xA370, 0x1551, iwl9560_2ac_cfg_soc, iwl9560_killer_1550s_name),
 	IWL_DEV_INFO(0xA370, 0x1552, iwl9560_2ac_cfg_soc, iwl9560_killer_1550i_name),
+	IWL_DEV_INFO(0x54F0, 0x1551, iwl9560_2ac_cfg_soc, iwl9560_killer_1550s_160_name),
+	IWL_DEV_INFO(0x54F0, 0x1552, iwl9560_2ac_cfg_soc, iwl9560_killer_1550i_name),
 	IWL_DEV_INFO(0x51F0, 0x1552, iwl9560_2ac_cfg_soc, iwl9560_killer_1550s_160_name),
 	IWL_DEV_INFO(0x51F0, 0x1551, iwl9560_2ac_cfg_soc, iwl9560_killer_1550i_160_name),
+	IWL_DEV_INFO(0x51F0, 0x1691, iwlax411_2ax_cfg_so_gf4_a0, iwl_ax411_killer_1690s_name),
+	IWL_DEV_INFO(0x51F0, 0x1692, iwlax411_2ax_cfg_so_gf4_a0, iwl_ax411_killer_1690i_name),
+	IWL_DEV_INFO(0x54F0, 0x1691, iwlax411_2ax_cfg_so_gf4_a0, iwl_ax411_killer_1690s_name),
+	IWL_DEV_INFO(0x54F0, 0x1692, iwlax411_2ax_cfg_so_gf4_a0, iwl_ax411_killer_1690i_name),
+	IWL_DEV_INFO(0x7A70, 0x1691, iwlax411_2ax_cfg_so_gf4_a0, iwl_ax411_killer_1690s_name),
+	IWL_DEV_INFO(0x7A70, 0x1692, iwlax411_2ax_cfg_so_gf4_a0, iwl_ax411_killer_1690i_name),
 
 	IWL_DEV_INFO(0x271C, 0x0214, iwl9260_2ac_cfg, iwl9260_1_name),
+	IWL_DEV_INFO(0x7E40, 0x1691, iwl_cfg_ma_a0_gf4_a0, iwl_ax411_killer_1690s_name),
+	IWL_DEV_INFO(0x7E40, 0x1692, iwl_cfg_ma_a0_gf4_a0, iwl_ax411_killer_1690i_name),
 
 /* AX200 */
 	IWL_DEV_INFO(0x2723, 0x1653, iwl_ax200_cfg_cc, iwl_ax200_killer_1650w_name),
@@ -639,6 +649,12 @@ static const struct iwl_dev_info iwl_dev_info_table[] = {
 	IWL_DEV_INFO(0x7AF0, 0x0510, iwlax211_2ax_cfg_so_gf_a0, NULL),
 	IWL_DEV_INFO(0x7AF0, 0x0A10, iwlax211_2ax_cfg_so_gf_a0, NULL),
 
+	/* So with JF */
+	IWL_DEV_INFO(0x7A70, 0x1551, iwl9560_2ac_cfg_soc, iwl9560_killer_1550s_160_name),
+	IWL_DEV_INFO(0x7A70, 0x1552, iwl9560_2ac_cfg_soc, iwl9560_killer_1550i_160_name),
+	IWL_DEV_INFO(0x7AF0, 0x1551, iwl9560_2ac_cfg_soc, iwl9560_killer_1550s_160_name),
+	IWL_DEV_INFO(0x7AF0, 0x1552, iwl9560_2ac_cfg_soc, iwl9560_killer_1550i_160_name),
+
 	/* SnJ with HR */
 	IWL_DEV_INFO(0x2725, 0x00B0, iwlax411_2ax_cfg_sosnj_gf4_a0, NULL),
 	IWL_DEV_INFO(0x2726, 0x0090, iwlax211_cfg_snj_gf_a0, NULL),
@@ -648,6 +664,10 @@ static const struct iwl_dev_info iwl_dev_info_table[] = {
 	IWL_DEV_INFO(0x2726, 0x0510, iwlax211_cfg_snj_gf_a0, NULL),
 	IWL_DEV_INFO(0x2726, 0x1651, iwl_cfg_snj_hr_b0, iwl_ax201_killer_1650s_name),
 	IWL_DEV_INFO(0x2726, 0x1652, iwl_cfg_snj_hr_b0, iwl_ax201_killer_1650i_name),
+	IWL_DEV_INFO(0x2726, 0x1671, iwlax211_cfg_snj_gf_a0, iwl_ax211_killer_1675s_name),
+	IWL_DEV_INFO(0x2726, 0x1672, iwlax211_cfg_snj_gf_a0, iwl_ax211_killer_1675i_name),
+	IWL_DEV_INFO(0x2726, 0x1691, iwlax411_2ax_cfg_sosnj_gf4_a0, iwl_ax411_killer_1690s_name),
+	IWL_DEV_INFO(0x2726, 0x1692, iwlax411_2ax_cfg_sosnj_gf4_a0, iwl_ax411_killer_1690i_name),
 
 	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
 		      IWL_CFG_MAC_TYPE_PU, IWL_CFG_ANY,
-- 
2.33.0

