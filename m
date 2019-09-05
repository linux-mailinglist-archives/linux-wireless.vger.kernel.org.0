Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2D083AADD1
	for <lists+linux-wireless@lfdr.de>; Thu,  5 Sep 2019 23:28:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390401AbfIEV2K (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 5 Sep 2019 17:28:10 -0400
Received: from mail2.candelatech.com ([208.74.158.173]:46472 "EHLO
        mail3.candelatech.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731418AbfIEV2K (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 5 Sep 2019 17:28:10 -0400
Received: from ben-dt4.candelatech.com (50-251-239-81-static.hfc.comcastbusiness.net [50.251.239.81])
        by mail3.candelatech.com (Postfix) with ESMTP id 2E06F104B;
        Thu,  5 Sep 2019 14:28:09 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com 2E06F104B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
        s=default; t=1567718889;
        bh=EcktJhL6buZelYaXXG9yD0fyM04AbSJ3PJjtfjzlFN8=;
        h=From:To:Cc:Subject:Date:From;
        b=EnM2xtjkC1Kx/geG72jOe1WCItxxmt7HqfKVjPALHkzvnpINw2Qo0iV62NITbahJr
         68nhFhoQGpIa2JoeNhNhX/BgGTV2woYIK0YNMfFCICOeepNjgDU8Hfm8RxLurwCLTR
         WE/PNceykxdCprO+JMcDj1WkRlfdnniVy2MdkPg0=
From:   greearb@candelatech.com
To:     linux-wireless@vger.kernel.org
Cc:     Ben Greear <greearb@candelatech.com>
Subject: [PATCH] iwl-mvm:  Report tx/rx antennas.
Date:   Thu,  5 Sep 2019 14:28:01 -0700
Message-Id: <20190905212801.13404-1-greearb@candelatech.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Ben Greear <greearb@candelatech.com>

This makes it easier for user-space to know how many antennas the
radio has.  Seems to work with the AX200 radio, at least.

Signed-off-by: Ben Greear <greearb@candelatech.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
index 964c7baabede..f90b003f154a 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
@@ -440,10 +440,19 @@ const static struct wiphy_iftype_ext_capab he_iftypes_ext_capa[] = {
 	},
 };
 
+static int iwl_mvm_op_get_antenna(struct ieee80211_hw *hw, u32 *tx_ant, u32 *rx_ant)
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
 	int num_mac, ret, i;
+	u32 tx_ant, rx_ant;
 	static const u32 mvm_ciphers[] = {
 		WLAN_CIPHER_SUITE_WEP40,
 		WLAN_CIPHER_SUITE_WEP104,
@@ -813,6 +822,10 @@ int iwl_mvm_mac_setup_register(struct iwl_mvm *mvm)
 		wiphy_ext_feature_set(hw->wiphy,
 				      NL80211_EXT_FEATURE_MU_MIMO_AIR_SNIFFER);
 
+	iwl_mvm_op_get_antenna(hw, &tx_ant, &rx_ant);
+	hw->wiphy->available_antennas_tx = tx_ant;
+	hw->wiphy->available_antennas_rx = rx_ant;
+
 	ret = ieee80211_register_hw(mvm->hw);
 	if (ret) {
 		iwl_mvm_leds_exit(mvm);
@@ -5167,6 +5180,7 @@ const struct ieee80211_ops iwl_mvm_hw_ops = {
 	.tx = iwl_mvm_mac_tx,
 	.wake_tx_queue = iwl_mvm_mac_wake_tx_queue,
 	.ampdu_action = iwl_mvm_mac_ampdu_action,
+	.get_antenna = iwl_mvm_op_get_antenna,
 	.start = iwl_mvm_mac_start,
 	.reconfig_complete = iwl_mvm_mac_reconfig_complete,
 	.stop = iwl_mvm_mac_stop,
-- 
2.20.1

