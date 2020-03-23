Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1906418F594
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Mar 2020 14:19:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728493AbgCWNTm (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 23 Mar 2020 09:19:42 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:43422 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728454AbgCWNTl (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 23 Mar 2020 09:19:41 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <luca@coelho.fi>)
        id 1jGMzT-00023f-FS; Mon, 23 Mar 2020 15:19:39 +0200
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Mon, 23 Mar 2020 15:19:18 +0200
Message-Id: <iwlwifi.20200323151304.2ea1544bbf7c.I17ac1802f00bd80006930b922a9fc21df60e3c16@changeid>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200323131925.208376-1-luca@coelho.fi>
References: <20200323131925.208376-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.4
Subject: [PATCH 07/14] iwlwifi: remove redundant iwl9560_2ac_cfg struct
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Luca Coelho <luciano.coelho@intel.com>

The iwl9560_2ac_cfg struct is used for PNJ devices and the
configuration is the same as iwl9260_2ac_cfg, so we can remove the
former to avoid redundancy.

Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/cfg/9000.c |  5 -----
 drivers/net/wireless/intel/iwlwifi/pcie/drv.c | 12 ++++++------
 2 files changed, 6 insertions(+), 11 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/cfg/9000.c b/drivers/net/wireless/intel/iwlwifi/cfg/9000.c
index d02936a8e11d..cb2604b01a99 100644
--- a/drivers/net/wireless/intel/iwlwifi/cfg/9000.c
+++ b/drivers/net/wireless/intel/iwlwifi/cfg/9000.c
@@ -200,11 +200,6 @@ const char iwl9560_killer_1550i_name[] =
 const char iwl9560_killer_1550s_name[] =
 	"Killer (R) Wireless-AC 1550s Wireless Network Adapter (9560NGW)";
 
-const struct iwl_cfg iwl9560_2ac_cfg = {
-	.fw_name_pre = IWL9260_FW_PRE,
-	IWL_DEVICE_9000,
-};
-
 const struct iwl_cfg iwl9560_2ac_cfg_soc = {
 	.fw_name_pre = IWL9000_FW_PRE,
 	IWL_DEVICE_9000,
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
index 5413e80f86bb..5f10dba12c8c 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
@@ -885,28 +885,28 @@ static const struct iwl_dev_info iwl_dev_info_table[] = {
 	_IWL_DEV_INFO(0x2526, IWL_CFG_ANY,
 		      IWL_CFG_MAC_TYPE_PNJ, IWL_CFG_RF_TYPE_JF1, IWL_CFG_RF_ID_JF1,
 		      IWL_CFG_160, IWL_CFG_CORES_BT,
-		      iwl9560_2ac_cfg, iwl9461_160_name),
+		      iwl9260_2ac_cfg, iwl9461_160_name),
 	_IWL_DEV_INFO(0x2526, IWL_CFG_ANY,
 		      IWL_CFG_MAC_TYPE_PNJ, IWL_CFG_RF_TYPE_JF1, IWL_CFG_RF_ID_JF1,
 		      IWL_CFG_NO_160, IWL_CFG_CORES_BT,
-		      iwl9560_2ac_cfg, iwl9461_name),
+		      iwl9260_2ac_cfg, iwl9461_name),
 	_IWL_DEV_INFO(0x2526, IWL_CFG_ANY,
 		      IWL_CFG_MAC_TYPE_PNJ, IWL_CFG_RF_TYPE_JF1, IWL_CFG_RF_ID_JF1_DIV,
 		      IWL_CFG_160, IWL_CFG_CORES_BT,
-		      iwl9560_2ac_cfg, iwl9462_160_name),
+		      iwl9260_2ac_cfg, iwl9462_160_name),
 	_IWL_DEV_INFO(0x2526, IWL_CFG_ANY,
 		      IWL_CFG_MAC_TYPE_PNJ, IWL_CFG_RF_TYPE_JF1, IWL_CFG_RF_ID_JF1_DIV,
 		      IWL_CFG_NO_160, IWL_CFG_CORES_BT,
-		      iwl9560_2ac_cfg, iwl9462_name),
+		      iwl9260_2ac_cfg, iwl9462_name),
 
 	_IWL_DEV_INFO(0x2526, IWL_CFG_ANY,
 		      IWL_CFG_MAC_TYPE_PNJ, IWL_CFG_RF_TYPE_JF2, IWL_CFG_RF_ID_JF,
 		      IWL_CFG_160, IWL_CFG_CORES_BT,
-		      iwl9560_2ac_cfg, iwl9560_160_name),
+		      iwl9260_2ac_cfg, iwl9560_160_name),
 	_IWL_DEV_INFO(0x2526, IWL_CFG_ANY,
 		      IWL_CFG_MAC_TYPE_PNJ, IWL_CFG_RF_TYPE_JF2, IWL_CFG_RF_ID_JF,
 		      IWL_CFG_NO_160, IWL_CFG_CORES_BT,
-		      iwl9560_2ac_cfg, iwl9560_name),
+		      iwl9260_2ac_cfg, iwl9560_name),
 
 	_IWL_DEV_INFO(0x2526, IWL_CFG_ANY,
 		      IWL_CFG_MAC_TYPE_TH, IWL_CFG_RF_TYPE_TH, IWL_CFG_ANY,
-- 
2.25.1

