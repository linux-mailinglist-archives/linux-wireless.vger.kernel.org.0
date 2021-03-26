Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D91934A597
	for <lists+linux-wireless@lfdr.de>; Fri, 26 Mar 2021 11:31:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230141AbhCZKbQ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 26 Mar 2021 06:31:16 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:43322 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S230108AbhCZKam (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 26 Mar 2021 06:30:42 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=kveik.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94)
        (envelope-from <luca@coelho.fi>)
        id 1lPjjj-0003EY-TD; Fri, 26 Mar 2021 12:30:41 +0200
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Fri, 26 Mar 2021 12:30:33 +0200
Message-Id: <20210326103035.206088-6-luca@coelho.fi>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20210326103035.206088-1-luca@coelho.fi>
References: <20210326103035.206088-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.5-pre1 (2020-06-20) on
        farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.5-pre1
Subject: [PATCH for v5.12 5/7] iwlwifi: pcie: add support for So-F devices
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Luca Coelho <luciano.coelho@intel.com>

We have a new type of device that has a different MAC ID, but is
otherwise identical to So devices.  Add rules to match this new ID
accordingly.

Change-Id: I2b6ef794c2073a18779dd40fb53f8c942d1ab42d
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 .../net/wireless/intel/iwlwifi/iwl-config.h   |  1 +
 drivers/net/wireless/intel/iwlwifi/pcie/drv.c | 26 ++++++++++++++++++-
 2 files changed, 26 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-config.h b/drivers/net/wireless/intel/iwlwifi/iwl-config.h
index 75f99ff7f908..c4f5da76f1c0 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-config.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-config.h
@@ -414,6 +414,7 @@ struct iwl_cfg {
 #define IWL_CFG_MAC_TYPE_QNJ		0x36
 #define IWL_CFG_MAC_TYPE_SO		0x37
 #define IWL_CFG_MAC_TYPE_SNJ		0x42
+#define IWL_CFG_MAC_TYPE_SOF		0x43
 #define IWL_CFG_MAC_TYPE_MA		0x44
 
 #define IWL_CFG_RF_TYPE_TH		0x105
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
index 4e2219b46db2..558a0b2ef0fc 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
@@ -1041,7 +1041,31 @@ static const struct iwl_dev_info iwl_dev_info_table[] = {
 		      IWL_CFG_MAC_TYPE_SO, IWL_CFG_ANY,
 		      IWL_CFG_RF_TYPE_HR2, IWL_CFG_ANY,
 		      IWL_CFG_160, IWL_CFG_ANY, IWL_CFG_NO_CDB,
-		      iwl_cfg_so_a0_hr_a0, iwl_ax201_name)
+		      iwl_cfg_so_a0_hr_a0, iwl_ax201_name),
+
+/* So-F with Hr */
+	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
+		      IWL_CFG_MAC_TYPE_SOF, IWL_CFG_ANY,
+		      IWL_CFG_RF_TYPE_HR2, IWL_CFG_ANY,
+		      IWL_CFG_NO_160, IWL_CFG_ANY, IWL_CFG_NO_CDB,
+		      iwl_cfg_so_a0_hr_a0, iwl_ax203_name),
+	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
+		      IWL_CFG_MAC_TYPE_SOF, IWL_CFG_ANY,
+		      IWL_CFG_RF_TYPE_HR1, IWL_CFG_ANY,
+		      IWL_CFG_160, IWL_CFG_ANY, IWL_CFG_NO_CDB,
+		      iwl_cfg_so_a0_hr_a0, iwl_ax101_name),
+	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
+		      IWL_CFG_MAC_TYPE_SOF, IWL_CFG_ANY,
+		      IWL_CFG_RF_TYPE_HR2, IWL_CFG_ANY,
+		      IWL_CFG_160, IWL_CFG_ANY, IWL_CFG_NO_CDB,
+		      iwl_cfg_so_a0_hr_a0, iwl_ax201_name),
+
+/* So-F with Gf */
+	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
+		      IWL_CFG_MAC_TYPE_SOF, IWL_CFG_ANY,
+		      IWL_CFG_RF_TYPE_GF, IWL_CFG_ANY,
+		      IWL_CFG_160, IWL_CFG_ANY, IWL_CFG_NO_CDB,
+		      iwlax211_2ax_cfg_so_gf_a0, iwl_ax211_name),
 
 #endif /* CONFIG_IWLMVM */
 };
-- 
2.31.0

