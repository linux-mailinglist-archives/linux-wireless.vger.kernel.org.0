Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A1938103777
	for <lists+linux-wireless@lfdr.de>; Wed, 20 Nov 2019 11:27:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727952AbfKTK1F (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 20 Nov 2019 05:27:05 -0500
Received: from paleale.coelho.fi ([176.9.41.70]:58570 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728658AbfKTK1C (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 20 Nov 2019 05:27:02 -0500
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.92)
        (envelope-from <luca@coelho.fi>)
        id 1iXNCO-0001kS-WC; Wed, 20 Nov 2019 12:27:01 +0200
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Wed, 20 Nov 2019 12:26:45 +0200
Message-Id: <20191120102650.514376-8-luca@coelho.fi>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191120102650.514376-1-luca@coelho.fi>
References: <20191120102650.514376-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.2
Subject: [PATCH 07/12] iwlwifi: mvm: Report tx/rx antennas
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Ben Greear <greearb@candelatech.com>

This makes it easier for user-space to know how many antennas the
radio has.  Seems to work with the AX200 radio, at least.

Signed-off-by: Ben Greear <greearb@candelatech.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
index 473d56552e26..32dc9d6f0fb6 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
@@ -355,6 +355,15 @@ static const struct wiphy_iftype_ext_capab he_iftypes_ext_capa[] = {
 	},
 };
 
+static int
+iwl_mvm_op_get_antenna(struct ieee80211_hw *hw, u32 *tx_ant, u32 *rx_ant)
+{
+	struct iwl_mvm *mvm = IWL_MAC80211_GET_MVM(hw);
+	*tx_ant = iwl_mvm_get_valid_tx_ant(mvm);
+	*rx_ant = iwl_mvm_get_valid_rx_ant(mvm);
+	return 0;
+}
+
 int iwl_mvm_mac_setup_register(struct iwl_mvm *mvm)
 {
 	struct ieee80211_hw *hw = mvm->hw;
@@ -734,6 +743,9 @@ int iwl_mvm_mac_setup_register(struct iwl_mvm *mvm)
 		wiphy_ext_feature_set(hw->wiphy,
 				      NL80211_EXT_FEATURE_MU_MIMO_AIR_SNIFFER);
 
+	hw->wiphy->available_antennas_tx = iwl_mvm_get_valid_tx_ant(mvm);
+	hw->wiphy->available_antennas_rx = iwl_mvm_get_valid_rx_ant(mvm);
+
 	ret = ieee80211_register_hw(mvm->hw);
 	if (ret) {
 		iwl_mvm_leds_exit(mvm);
@@ -5028,6 +5040,7 @@ const struct ieee80211_ops iwl_mvm_hw_ops = {
 	.tx = iwl_mvm_mac_tx,
 	.wake_tx_queue = iwl_mvm_mac_wake_tx_queue,
 	.ampdu_action = iwl_mvm_mac_ampdu_action,
+	.get_antenna = iwl_mvm_op_get_antenna,
 	.start = iwl_mvm_mac_start,
 	.reconfig_complete = iwl_mvm_mac_reconfig_complete,
 	.stop = iwl_mvm_mac_stop,
-- 
2.24.0

