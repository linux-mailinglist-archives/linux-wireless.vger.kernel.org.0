Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3C9C3130EF6
	for <lists+linux-wireless@lfdr.de>; Mon,  6 Jan 2020 09:55:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726351AbgAFIzP (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 6 Jan 2020 03:55:15 -0500
Received: from paleale.coelho.fi ([176.9.41.70]:51376 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726275AbgAFIzO (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 6 Jan 2020 03:55:14 -0500
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.92.2)
        (envelope-from <luca@coelho.fi>)
        id 1ioOAK-0007qa-9f; Mon, 06 Jan 2020 10:55:12 +0200
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Mon,  6 Jan 2020 10:54:55 +0200
Message-Id: <20200106085502.363205-6-luca@coelho.fi>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200106085502.363205-1-luca@coelho.fi>
References: <20200106085502.363205-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.2
Subject: [PATCH 05/12] iwlwifi: add new iwlax411 struct for type SoSnj
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Oren Givon <oren.givon@intel.com>

Add new struct for SoSnj and add uhb support for ax411 structs.

Signed-off-by: Oren Givon <oren.givon@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/cfg/22000.c  | 10 ++++++++++
 drivers/net/wireless/intel/iwlwifi/iwl-config.h |  1 +
 2 files changed, 11 insertions(+)

diff --git a/drivers/net/wireless/intel/iwlwifi/cfg/22000.c b/drivers/net/wireless/intel/iwlwifi/cfg/22000.c
index 837c06891f5e..a22a830019c0 100644
--- a/drivers/net/wireless/intel/iwlwifi/cfg/22000.c
+++ b/drivers/net/wireless/intel/iwlwifi/cfg/22000.c
@@ -92,6 +92,7 @@
 #define IWL_22000_SO_A_GF_A_FW_PRE      "iwlwifi-so-a0-gf-a0-"
 #define IWL_22000_TY_A_GF_A_FW_PRE      "iwlwifi-ty-a0-gf-a0-"
 #define IWL_22000_SO_A_GF4_A_FW_PRE     "iwlwifi-so-a0-gf4-a0-"
+#define IWL_22000_SOSNJ_A_GF4_A_FW_PRE  "iwlwifi-SoSnj-a0-gf4-a0-"
 
 #define IWL_22000_HR_MODULE_FIRMWARE(api) \
 	IWL_22000_HR_FW_PRE __stringify(api) ".ucode"
@@ -707,6 +708,15 @@ const struct iwl_cfg iwlax210_2ax_cfg_ty_gf_a0 = {
 const struct iwl_cfg iwlax411_2ax_cfg_so_gf4_a0 = {
 	.name = "Intel(R) Wi-Fi 7 AX411 160MHz",
 	.fw_name_pre = IWL_22000_SO_A_GF4_A_FW_PRE,
+	.uhb_supported = true,
+	IWL_DEVICE_AX210,
+	.num_rbds = IWL_NUM_RBDS_AX210_HE,
+};
+
+const struct iwl_cfg iwlax411_2ax_cfg_sosnj_gf4_a0 = {
+	.name = "Intel(R) Wi-Fi 7 AX411 160MHz",
+	.fw_name_pre = IWL_22000_SOSNJ_A_GF4_A_FW_PRE,
+	.uhb_supported = true,
 	IWL_DEVICE_AX210,
 	.num_rbds = IWL_NUM_RBDS_AX210_HE,
 };
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-config.h b/drivers/net/wireless/intel/iwlwifi/iwl-config.h
index bb91c36c9d8b..bbeb5fc3caad 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-config.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-config.h
@@ -586,6 +586,7 @@ extern const struct iwl_cfg iwlax210_2ax_cfg_so_hr_a0;
 extern const struct iwl_cfg iwlax211_2ax_cfg_so_gf_a0;
 extern const struct iwl_cfg iwlax210_2ax_cfg_ty_gf_a0;
 extern const struct iwl_cfg iwlax411_2ax_cfg_so_gf4_a0;
+extern const struct iwl_cfg iwlax411_2ax_cfg_sosnj_gf4_a0;
 #endif /* CPTCFG_IWLMVM || CPTCFG_IWLFMAC */
 
 #endif /* __IWL_CONFIG_H__ */
-- 
2.24.1

