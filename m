Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70EF11AEAB7
	for <lists+linux-wireless@lfdr.de>; Sat, 18 Apr 2020 10:09:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726061AbgDRIJW (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 18 Apr 2020 04:09:22 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:56782 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726036AbgDRIJV (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 18 Apr 2020 04:09:21 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <luca@coelho.fi>)
        id 1jPiXP-000L3r-Cm; Sat, 18 Apr 2020 11:09:19 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Sat, 18 Apr 2020 11:08:53 +0300
Message-Id: <iwlwifi.20200418110539.738dabad8732.I5673eaf8a016b8aa27ab8bab02121108fa723783@changeid>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200418080857.2232093-1-luca@coelho.fi>
References: <20200418080857.2232093-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.4
Subject: [PATCH 08/12] iwlwifi: update few product names in AX family
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Ihab Zhaika <ihab.zhaika@intel.com>

update the product names of few structs in AX family.

Signed-off-by: Ihab Zhaika <ihab.zhaika@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/cfg/22000.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/cfg/22000.c b/drivers/net/wireless/intel/iwlwifi/cfg/22000.c
index 1af4ba2d30cb..35fa89d28fef 100644
--- a/drivers/net/wireless/intel/iwlwifi/cfg/22000.c
+++ b/drivers/net/wireless/intel/iwlwifi/cfg/22000.c
@@ -527,14 +527,14 @@ const struct iwl_cfg iwlax210_2ax_cfg_so_jf_a0 = {
 };
 
 const struct iwl_cfg iwlax210_2ax_cfg_so_hr_a0 = {
-	.name = "Intel(R) Wi-Fi 7 AX210 160MHz",
+	.name = "Intel(R) Wi-Fi 6 AX210 160MHz",
 	.fw_name_pre = IWL_22000_SO_A_HR_B_FW_PRE,
 	IWL_DEVICE_AX210,
 	.num_rbds = IWL_NUM_RBDS_AX210_HE,
 };
 
 const struct iwl_cfg iwlax211_2ax_cfg_so_gf_a0 = {
-	.name = "Intel(R) Wi-Fi 7 AX211 160MHz",
+	.name = "Intel(R) Wi-Fi 6 AX211 160MHz",
 	.fw_name_pre = IWL_22000_SO_A_GF_A_FW_PRE,
 	.uhb_supported = true,
 	IWL_DEVICE_AX210,
@@ -542,7 +542,7 @@ const struct iwl_cfg iwlax211_2ax_cfg_so_gf_a0 = {
 };
 
 const struct iwl_cfg iwlax210_2ax_cfg_ty_gf_a0 = {
-	.name = "Intel(R) Wi-Fi 7 AX210 160MHz",
+	.name = "Intel(R) Wi-Fi 6 AX210 160MHz",
 	.fw_name_pre = IWL_22000_TY_A_GF_A_FW_PRE,
 	.uhb_supported = true,
 	IWL_DEVICE_AX210,
@@ -550,7 +550,7 @@ const struct iwl_cfg iwlax210_2ax_cfg_ty_gf_a0 = {
 };
 
 const struct iwl_cfg iwlax411_2ax_cfg_so_gf4_a0 = {
-	.name = "Intel(R) Wi-Fi 7 AX411 160MHz",
+	.name = "Intel(R) Wi-Fi 6 AX411 160MHz",
 	.fw_name_pre = IWL_22000_SO_A_GF4_A_FW_PRE,
 	.uhb_supported = true,
 	IWL_DEVICE_AX210,
-- 
2.25.1

