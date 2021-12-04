Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A7D7468463
	for <lists+linux-wireless@lfdr.de>; Sat,  4 Dec 2021 12:11:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384778AbhLDLOc (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 4 Dec 2021 06:14:32 -0500
Received: from paleale.coelho.fi ([176.9.41.70]:50420 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1384765AbhLDLOa (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 4 Dec 2021 06:14:30 -0500
Received: from 91-156-5-105.elisa-laajakaista.fi ([91.156.5.105] helo=kveik.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <luca@coelho.fi>)
        id 1mtSwZ-0017RD-G3; Sat, 04 Dec 2021 13:11:03 +0200
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     luca@coelho.fi, linux-wireless@vger.kernel.org
Date:   Sat,  4 Dec 2021 13:10:51 +0200
Message-Id: <iwlwifi.20211204130722.4e992a115f14.Icacedcc06f33e5457f650290e7deea22bf1ca12d@changeid>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211204111053.852455-1-luca@coelho.fi>
References: <20211204111053.852455-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.6
Subject: [PATCH 10/12] iwlwifi: swap 1650i and 1650s killer struct names
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Yaara Baruch <yaara.baruch@intel.com>

The names of the killer 1650i and 1650s devices weren't aligned.
This patch swap the names in the structs.

Signed-off-by: Yaara Baruch <yaara.baruch@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/cfg/22000.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/cfg/22000.c b/drivers/net/wireless/intel/iwlwifi/cfg/22000.c
index 0467c1e9eeb3..2a2f236a7de5 100644
--- a/drivers/net/wireless/intel/iwlwifi/cfg/22000.c
+++ b/drivers/net/wireless/intel/iwlwifi/cfg/22000.c
@@ -629,7 +629,7 @@ const struct iwl_cfg iwl_ax200_cfg_cc = {
 };
 
 const struct iwl_cfg killer1650s_2ax_cfg_qu_b0_hr_b0 = {
-	.name = "Killer(R) Wi-Fi 6 AX1650i 160MHz Wireless Network Adapter (201NGW)",
+	.name = "Killer(R) Wi-Fi 6 AX1650s 160MHz Wireless Network Adapter (201NGW)",
 	.fw_name_pre = IWL_QU_B_HR_B_FW_PRE,
 	IWL_DEVICE_22500,
 	/*
@@ -642,7 +642,7 @@ const struct iwl_cfg killer1650s_2ax_cfg_qu_b0_hr_b0 = {
 };
 
 const struct iwl_cfg killer1650i_2ax_cfg_qu_b0_hr_b0 = {
-	.name = "Killer(R) Wi-Fi 6 AX1650s 160MHz Wireless Network Adapter (201D2W)",
+	.name = "Killer(R) Wi-Fi 6 AX1650i 160MHz Wireless Network Adapter (201D2W)",
 	.fw_name_pre = IWL_QU_B_HR_B_FW_PRE,
 	IWL_DEVICE_22500,
 	/*
@@ -655,7 +655,7 @@ const struct iwl_cfg killer1650i_2ax_cfg_qu_b0_hr_b0 = {
 };
 
 const struct iwl_cfg killer1650s_2ax_cfg_qu_c0_hr_b0 = {
-	.name = "Killer(R) Wi-Fi 6 AX1650i 160MHz Wireless Network Adapter (201NGW)",
+	.name = "Killer(R) Wi-Fi 6 AX1650s 160MHz Wireless Network Adapter (201NGW)",
 	.fw_name_pre = IWL_QU_C_HR_B_FW_PRE,
 	IWL_DEVICE_22500,
 	/*
@@ -668,7 +668,7 @@ const struct iwl_cfg killer1650s_2ax_cfg_qu_c0_hr_b0 = {
 };
 
 const struct iwl_cfg killer1650i_2ax_cfg_qu_c0_hr_b0 = {
-	.name = "Killer(R) Wi-Fi 6 AX1650s 160MHz Wireless Network Adapter (201D2W)",
+	.name = "Killer(R) Wi-Fi 6 AX1650i 160MHz Wireless Network Adapter (201D2W)",
 	.fw_name_pre = IWL_QU_C_HR_B_FW_PRE,
 	IWL_DEVICE_22500,
 	/*
-- 
2.33.1

