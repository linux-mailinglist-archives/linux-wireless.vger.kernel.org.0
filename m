Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1B579AA44D
	for <lists+linux-wireless@lfdr.de>; Thu,  5 Sep 2019 15:23:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388862AbfIENXG (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 5 Sep 2019 09:23:06 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:41198 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2388771AbfIENXF (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 5 Sep 2019 09:23:05 -0400
Received: from [91.156.6.193] (helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.92)
        (envelope-from <luca@coelho.fi>)
        id 1i5rik-00062D-Av; Thu, 05 Sep 2019 16:22:42 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Thu,  5 Sep 2019 16:22:13 +0300
Message-Id: <20190905132220.23970-15-luca@coelho.fi>
X-Mailer: git-send-email 2.23.0.rc1
In-Reply-To: <20190905132220.23970-1-luca@coelho.fi>
References: <20190905132220.23970-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.2
Subject: [PATCH v2 14/21] iwlwifi: mvm: add support for single antenna diversity
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Haim Dreyfuss <haim.dreyfuss@intel.com>

There are products which have a single chain with 2 antennas.
In these products, we need to inform the FW that the device has the
single antenna diversity(SAD) feature. In the future, we will read
the active antenna from a BIOS configuration. Currently, we use a
default configuration which means that the FW decides which antenna to use.

Signed-off-by: Haim Dreyfuss <haim.dreyfuss@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/cfg/22000.c  | 1 +
 drivers/net/wireless/intel/iwlwifi/fw/file.h    | 4 ++++
 drivers/net/wireless/intel/iwlwifi/iwl-config.h | 2 ++
 3 files changed, 7 insertions(+)

diff --git a/drivers/net/wireless/intel/iwlwifi/cfg/22000.c b/drivers/net/wireless/intel/iwlwifi/cfg/22000.c
index 4ef28d916fd3..3bd03ddbe22f 100644
--- a/drivers/net/wireless/intel/iwlwifi/cfg/22000.c
+++ b/drivers/net/wireless/intel/iwlwifi/cfg/22000.c
@@ -240,6 +240,7 @@ const struct iwl_cfg iwl_ax101_cfg_qu_hr = {
 	 * HT size; mac80211 would otherwise pick the HE max (256) by default.
 	 */
 	.max_tx_agg_size = IEEE80211_MAX_AMPDU_BUF_HT,
+	.tx_with_siso_diversity = true,
 };
 
 const struct iwl_cfg iwl_ax201_cfg_qu_hr = {
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/file.h b/drivers/net/wireless/intel/iwlwifi/fw/file.h
index 00db39427be7..329b00e90fa4 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/file.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/file.h
@@ -524,6 +524,10 @@ enum iwl_fw_phy_cfg {
 	FW_PHY_CFG_TX_CHAIN = 0xf << FW_PHY_CFG_TX_CHAIN_POS,
 	FW_PHY_CFG_RX_CHAIN_POS = 20,
 	FW_PHY_CFG_RX_CHAIN = 0xf << FW_PHY_CFG_RX_CHAIN_POS,
+	FW_PHY_CFG_CHAIN_SAD_POS = 23,
+	FW_PHY_CFG_CHAIN_SAD_ENABLED = 0x1 << FW_PHY_CFG_CHAIN_SAD_POS,
+	FW_PHY_CFG_CHAIN_SAD_ANT_A = 0x2 << FW_PHY_CFG_CHAIN_SAD_POS,
+	FW_PHY_CFG_CHAIN_SAD_ANT_B = 0x4 << FW_PHY_CFG_CHAIN_SAD_POS,
 	FW_PHY_CFG_SHARED_CLK = BIT(31),
 };
 
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-config.h b/drivers/net/wireless/intel/iwlwifi/iwl-config.h
index 02b65e2580a3..47bd35618573 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-config.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-config.h
@@ -379,6 +379,7 @@ struct iwl_cfg_trans_params {
  * @ht_params: point to ht parameters
  * @led_mode: 0=blinking, 1=On(RF On)/Off(RF Off)
  * @rx_with_siso_diversity: 1x1 device with rx antenna diversity
+ * @tx_with_siso_diversity: 1x1 device with tx antenna diversity
  * @internal_wimax_coex: internal wifi/wimax combo device
  * @high_temp: Is this NIC is designated to be in high temperature.
  * @host_interrupt_operation_mode: device needs host interrupt operation
@@ -441,6 +442,7 @@ struct iwl_cfg {
 	u16 nvm_ver;
 	u16 nvm_calib_ver;
 	u32 rx_with_siso_diversity:1,
+	    tx_with_siso_diversity:1,
 	    bt_shared_single_ant:1,
 	    internal_wimax_coex:1,
 	    host_interrupt_operation_mode:1,
-- 
2.23.0.rc1

