Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8913DDDD66
	for <lists+linux-wireless@lfdr.de>; Sun, 20 Oct 2019 10:56:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726319AbfJTI4I (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 20 Oct 2019 04:56:08 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:50830 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726115AbfJTI4H (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 20 Oct 2019 04:56:07 -0400
Received: from [91.156.6.193] (helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.92)
        (envelope-from <luca@coelho.fi>)
        id 1iM70M-0003LY-7W; Sun, 20 Oct 2019 11:56:02 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Sun, 20 Oct 2019 11:55:44 +0300
Message-Id: <20191020085545.16407-10-luca@coelho.fi>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191020085545.16407-1-luca@coelho.fi>
References: <20191020085545.16407-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.2
Subject: [PATCH 11/12] iwlwifi: 22000: fix some indentation
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

Somehow two tabs snuck into this file where just one should be
used, fix that.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 .../net/wireless/intel/iwlwifi/cfg/22000.c    | 30 +++++++++----------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/cfg/22000.c b/drivers/net/wireless/intel/iwlwifi/cfg/22000.c
index 37bcf157f0bb..8ad771dadae2 100644
--- a/drivers/net/wireless/intel/iwlwifi/cfg/22000.c
+++ b/drivers/net/wireless/intel/iwlwifi/cfg/22000.c
@@ -317,39 +317,39 @@ const struct iwl_cfg iwl_ax101_cfg_quz_hr = {
 };
 
 const struct iwl_cfg iwl_ax201_cfg_quz_hr = {
-		.name = "Intel(R) Wi-Fi 6 AX201 160MHz",
-		.fw_name_pre = IWL_QUZ_A_HR_B_FW_PRE,
-		IWL_DEVICE_22500,
-		/*
+	.name = "Intel(R) Wi-Fi 6 AX201 160MHz",
+	.fw_name_pre = IWL_QUZ_A_HR_B_FW_PRE,
+	IWL_DEVICE_22500,
+	/*
          * This device doesn't support receiving BlockAck with a large bitmap
          * so we need to restrict the size of transmitted aggregation to the
          * HT size; mac80211 would otherwise pick the HE max (256) by default.
          */
-		.max_tx_agg_size = IEEE80211_MAX_AMPDU_BUF_HT,
+	.max_tx_agg_size = IEEE80211_MAX_AMPDU_BUF_HT,
 };
 
 const struct iwl_cfg iwl_ax1650s_cfg_quz_hr = {
-		.name = "Killer(R) Wi-Fi 6 AX1650s 160MHz Wireless Network Adapter (201D2W)",
-		.fw_name_pre = IWL_QUZ_A_HR_B_FW_PRE,
-		IWL_DEVICE_22500,
-		/*
+	.name = "Killer(R) Wi-Fi 6 AX1650s 160MHz Wireless Network Adapter (201D2W)",
+	.fw_name_pre = IWL_QUZ_A_HR_B_FW_PRE,
+	IWL_DEVICE_22500,
+	/*
          * This device doesn't support receiving BlockAck with a large bitmap
          * so we need to restrict the size of transmitted aggregation to the
          * HT size; mac80211 would otherwise pick the HE max (256) by default.
          */
-		.max_tx_agg_size = IEEE80211_MAX_AMPDU_BUF_HT,
+	.max_tx_agg_size = IEEE80211_MAX_AMPDU_BUF_HT,
 };
 
 const struct iwl_cfg iwl_ax1650i_cfg_quz_hr = {
-		.name = "Killer(R) Wi-Fi 6 AX1650i 160MHz Wireless Network Adapter (201NGW)",
-		.fw_name_pre = IWL_QUZ_A_HR_B_FW_PRE,
-		IWL_DEVICE_22500,
-		/*
+	.name = "Killer(R) Wi-Fi 6 AX1650i 160MHz Wireless Network Adapter (201NGW)",
+	.fw_name_pre = IWL_QUZ_A_HR_B_FW_PRE,
+	IWL_DEVICE_22500,
+	/*
          * This device doesn't support receiving BlockAck with a large bitmap
          * so we need to restrict the size of transmitted aggregation to the
          * HT size; mac80211 would otherwise pick the HE max (256) by default.
          */
-		.max_tx_agg_size = IEEE80211_MAX_AMPDU_BUF_HT,
+	.max_tx_agg_size = IEEE80211_MAX_AMPDU_BUF_HT,
 };
 
 const struct iwl_cfg iwl_ax200_cfg_cc = {
-- 
2.23.0

