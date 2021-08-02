Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 235E23DDFB1
	for <lists+linux-wireless@lfdr.de>; Mon,  2 Aug 2021 20:59:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230095AbhHBS7N (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 2 Aug 2021 14:59:13 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:51012 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S229899AbhHBS7N (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 2 Aug 2021 14:59:13 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=kveik.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94)
        (envelope-from <luca@coelho.fi>)
        id 1mAd9Q-001ySl-Sq; Mon, 02 Aug 2021 21:59:02 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     luca@coelho.fi, linux-wireless@vger.kernel.org
Date:   Mon,  2 Aug 2021 21:58:49 +0300
Message-Id: <iwlwifi.20210802215208.46b86c8074b2.I94d58b8e622ca87658dc05b05483fb954d526eab@changeid>
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
Subject: [PATCH 03/10] iwlwifi: give Bz devices their own name
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

The real name isn't determined yet, but give them a new
name that isn't clashing with older devices.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/cfg/22000.c  | 1 +
 drivers/net/wireless/intel/iwlwifi/iwl-config.h | 1 +
 drivers/net/wireless/intel/iwlwifi/pcie/drv.c   | 8 ++++----
 3 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/cfg/22000.c b/drivers/net/wireless/intel/iwlwifi/cfg/22000.c
index fb0ad4e19cc4..a3ff7001e1c3 100644
--- a/drivers/net/wireless/intel/iwlwifi/cfg/22000.c
+++ b/drivers/net/wireless/intel/iwlwifi/cfg/22000.c
@@ -417,6 +417,7 @@ const char iwl_ax211_name[] = "Intel(R) Wi-Fi 6E AX211 160MHz";
 const char iwl_ax221_name[] = "Intel(R) Wi-Fi 6E AX221 160MHz";
 const char iwl_ax231_name[] = "Intel(R) Wi-Fi 6E AX231 160MHz";
 const char iwl_ax411_name[] = "Intel(R) Wi-Fi 6E AX411 160MHz";
+const char iwl_bz_name[] = "Intel(R) TBD Bz device";
 
 const char iwl_ax200_killer_1650w_name[] =
 	"Killer(R) Wi-Fi 6 AX1650w 160MHz Wireless Network Adapter (200D2W)";
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-config.h b/drivers/net/wireless/intel/iwlwifi/iwl-config.h
index 999c6a4ab60e..82e49ead3a44 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-config.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-config.h
@@ -513,6 +513,7 @@ extern const char iwl_ax211_name[];
 extern const char iwl_ax221_name[];
 extern const char iwl_ax231_name[];
 extern const char iwl_ax411_name[];
+extern const char iwl_bz_name[];
 #if IS_ENABLED(CONFIG_IWLDVM)
 extern const struct iwl_cfg iwl5300_agn_cfg;
 extern const struct iwl_cfg iwl5100_agn_cfg;
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
index 16baee3d52ae..c42b72c64020 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
@@ -1093,22 +1093,22 @@ static const struct iwl_dev_info iwl_dev_info_table[] = {
 		      IWL_CFG_MAC_TYPE_BZ, IWL_CFG_ANY,
 		      IWL_CFG_RF_TYPE_HR2, IWL_CFG_ANY,
 		      IWL_CFG_ANY, IWL_CFG_ANY, IWL_CFG_NO_CDB,
-		      iwl_cfg_bz_a0_hr_b0, iwl_ax201_name),
+		      iwl_cfg_bz_a0_hr_b0, iwl_bz_name),
 	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
 		      IWL_CFG_MAC_TYPE_BZ, IWL_CFG_ANY,
 		      IWL_CFG_RF_TYPE_GF, IWL_CFG_ANY,
 		      IWL_CFG_ANY, IWL_CFG_ANY, IWL_CFG_NO_CDB,
-		      iwl_cfg_bz_a0_gf_a0, iwl_ax211_name),
+		      iwl_cfg_bz_a0_gf_a0, iwl_bz_name),
 	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
 		      IWL_CFG_MAC_TYPE_BZ, IWL_CFG_ANY,
 		      IWL_CFG_RF_TYPE_GF, IWL_CFG_ANY,
 		      IWL_CFG_ANY, IWL_CFG_ANY, IWL_CFG_CDB,
-		      iwl_cfg_bz_a0_gf4_a0, iwl_ax211_name),
+		      iwl_cfg_bz_a0_gf4_a0, iwl_bz_name),
 	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
 		      IWL_CFG_MAC_TYPE_BZ, IWL_CFG_ANY,
 		      IWL_CFG_RF_TYPE_MR, IWL_CFG_ANY,
 		      IWL_CFG_ANY, IWL_CFG_ANY, IWL_CFG_NO_CDB,
-		      iwl_cfg_bz_a0_mr_a0, iwl_ax211_name),
+		      iwl_cfg_bz_a0_mr_a0, iwl_bz_name),
 
 /* So with GF */
 	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
-- 
2.32.0

