Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CB2B573355
	for <lists+linux-wireless@lfdr.de>; Wed, 13 Jul 2022 11:46:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235167AbiGMJp6 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 13 Jul 2022 05:45:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235475AbiGMJpS (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 13 Jul 2022 05:45:18 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D964EEEAB6
        for <linux-wireless@vger.kernel.org>; Wed, 13 Jul 2022 02:45:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Content-Type:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=bT1K6YY0aA2IpoK5rNAWiCqjbgMeBiHBbZvdREPMskI=;
        t=1657705514; x=1658915114; b=nyF07YV8j2FPm/gJGbTlMKutKpY9Aw4uK9bqEK/2UWbgPdO
        sK1OByc6NeEEM839aB5HYxfxAcz/0Q+8Pqm/jVJhFkIYtjLR+2Y/KETLr7FeogJGT9OA3YBfx1RwQ
        5G6YEOWvmmnLQSC8LIV1qAY7eZYMKE8BRSnHmQberhcfE1q2acA5XneY+fO4tui0i4GdbdA0DqVB9
        g5qKGHbUyx+lBFYS6M/YFtvpBXcJmewZDpXMvTuO8QR5eQLviR9NNunxWOzYdB4h5WtGDUIH8jsYf
        HHgbBuOdoZ/1TfLTg3rktBGRHtBO8Xnj8Wio02KHEXFft7NSY9PpqlZAx/LOW4cQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.95)
        (envelope-from <johannes@sipsolutions.net>)
        id 1oBYvg-00EgvB-Tq;
        Wed, 13 Jul 2022 11:45:13 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 29/76] wifi: mac80211: change QoS settings API to take link into account
Date:   Wed, 13 Jul 2022 11:44:15 +0200
Message-Id: <20220713114425.493e14fb1d48.Ie7d71a8435781fe40a8c2f56ff93e7cca7346548@changeid>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220713094502.163926-1-johannes@sipsolutions.net>
References: <20220713094502.163926-1-johannes@sipsolutions.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

Take the link into account in the QoS settings (EDCA parameters)
APIs.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 drivers/net/wireless/ath/ath10k/mac.c         |  3 +-
 drivers/net/wireless/ath/ath11k/mac.c         |  3 +-
 drivers/net/wireless/ath/ath5k/mac80211-ops.c |  3 +-
 drivers/net/wireless/ath/ath9k/htc_drv_main.c |  3 +-
 drivers/net/wireless/ath/ath9k/main.c         |  3 +-
 drivers/net/wireless/ath/carl9170/main.c      |  3 +-
 drivers/net/wireless/broadcom/b43/main.c      |  3 +-
 .../net/wireless/broadcom/b43legacy/main.c    |  3 +-
 .../broadcom/brcm80211/brcmsmac/mac80211_if.c |  3 +-
 drivers/net/wireless/intel/iwlegacy/common.c  |  3 +-
 drivers/net/wireless/intel/iwlegacy/common.h  |  3 +-
 .../net/wireless/intel/iwlwifi/dvm/mac80211.c |  5 +-
 .../net/wireless/intel/iwlwifi/mvm/mac80211.c |  3 +-
 drivers/net/wireless/intersil/p54/main.c      |  3 +-
 drivers/net/wireless/mac80211_hwsim.c         |  8 +--
 drivers/net/wireless/marvell/mwl8k.c          |  5 +-
 .../net/wireless/mediatek/mt76/mt7603/main.c  |  3 +-
 .../net/wireless/mediatek/mt76/mt7615/main.c  |  3 +-
 drivers/net/wireless/mediatek/mt76/mt76x02.h  |  3 +-
 .../net/wireless/mediatek/mt76/mt76x02_util.c |  3 +-
 .../net/wireless/mediatek/mt76/mt7915/main.c  |  3 +-
 .../net/wireless/mediatek/mt76/mt7921/main.c  |  3 +-
 .../net/wireless/mediatek/mt7601u/mt7601u.h   |  3 +-
 drivers/net/wireless/mediatek/mt7601u/tx.c    |  3 +-
 .../net/wireless/ralink/rt2x00/rt2400pci.c    |  5 +-
 .../net/wireless/ralink/rt2x00/rt2800lib.c    |  5 +-
 .../net/wireless/ralink/rt2x00/rt2800lib.h    |  3 +-
 drivers/net/wireless/ralink/rt2x00/rt2x00.h   |  3 +-
 .../net/wireless/ralink/rt2x00/rt2x00mac.c    |  3 +-
 drivers/net/wireless/ralink/rt2x00/rt61pci.c  |  5 +-
 drivers/net/wireless/ralink/rt2x00/rt73usb.c  |  5 +-
 .../wireless/realtek/rtl818x/rtl8180/dev.c    |  3 +-
 .../wireless/realtek/rtl818x/rtl8187/dev.c    |  3 +-
 .../wireless/realtek/rtl8xxxu/rtl8xxxu_core.c |  3 +-
 drivers/net/wireless/realtek/rtlwifi/core.c   |  3 +-
 drivers/net/wireless/realtek/rtw88/mac80211.c |  3 +-
 drivers/net/wireless/realtek/rtw89/mac80211.c |  3 +-
 drivers/net/wireless/rsi/rsi_91x_mac80211.c   |  3 +-
 drivers/net/wireless/silabs/wfx/sta.c         |  3 +-
 drivers/net/wireless/silabs/wfx/sta.h         |  3 +-
 drivers/net/wireless/st/cw1200/sta.c          |  3 +-
 drivers/net/wireless/st/cw1200/sta.h          |  3 +-
 drivers/net/wireless/ti/wl1251/main.c         |  3 +-
 drivers/net/wireless/ti/wlcore/main.c         |  3 +-
 include/net/mac80211.h                        |  3 +-
 net/mac80211/cfg.c                            |  7 ++-
 net/mac80211/driver-ops.c                     |  8 ++-
 net/mac80211/driver-ops.h                     |  2 +-
 net/mac80211/ibss.c                           |  2 +-
 net/mac80211/ieee80211_i.h                    |  5 +-
 net/mac80211/iface.c                          |  2 +-
 net/mac80211/mlme.c                           | 55 ++++++++++---------
 net/mac80211/tdls.c                           |  2 +-
 net/mac80211/trace.h                          |  9 ++-
 net/mac80211/util.c                           | 18 +++---
 55 files changed, 158 insertions(+), 104 deletions(-)

diff --git a/drivers/net/wireless/ath/ath10k/mac.c b/drivers/net/wireless/ath/ath10k/mac.c
index b18f32261d15..ac54396418c9 100644
--- a/drivers/net/wireless/ath/ath10k/mac.c
+++ b/drivers/net/wireless/ath/ath10k/mac.c
@@ -7814,7 +7814,8 @@ static int ath10k_conf_tx_uapsd(struct ath10k *ar, struct ieee80211_vif *vif,
 }
 
 static int ath10k_conf_tx(struct ieee80211_hw *hw,
-			  struct ieee80211_vif *vif, u16 ac,
+			  struct ieee80211_vif *vif,
+			  unsigned int link_id, u16 ac,
 			  const struct ieee80211_tx_queue_params *params)
 {
 	struct ath10k *ar = hw->priv;
diff --git a/drivers/net/wireless/ath/ath11k/mac.c b/drivers/net/wireless/ath/ath11k/mac.c
index 1cf1e1f18dba..ec7b3a3629f3 100644
--- a/drivers/net/wireless/ath/ath11k/mac.c
+++ b/drivers/net/wireless/ath/ath11k/mac.c
@@ -4822,7 +4822,8 @@ static int ath11k_conf_tx_uapsd(struct ath11k *ar, struct ieee80211_vif *vif,
 }
 
 static int ath11k_mac_op_conf_tx(struct ieee80211_hw *hw,
-				 struct ieee80211_vif *vif, u16 ac,
+				 struct ieee80211_vif *vif,
+				 unsigned int link_id, u16 ac,
 				 const struct ieee80211_tx_queue_params *params)
 {
 	struct ath11k *ar = hw->priv;
diff --git a/drivers/net/wireless/ath/ath5k/mac80211-ops.c b/drivers/net/wireless/ath/ath5k/mac80211-ops.c
index 8da232e81518..acd0e1dafb7f 100644
--- a/drivers/net/wireless/ath/ath5k/mac80211-ops.c
+++ b/drivers/net/wireless/ath/ath5k/mac80211-ops.c
@@ -572,7 +572,8 @@ ath5k_get_stats(struct ieee80211_hw *hw,
 
 
 static int
-ath5k_conf_tx(struct ieee80211_hw *hw, struct ieee80211_vif *vif, u16 queue,
+ath5k_conf_tx(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
+	      unsigned int link_id, u16 queue,
 	      const struct ieee80211_tx_queue_params *params)
 {
 	struct ath5k_hw *ah = hw->priv;
diff --git a/drivers/net/wireless/ath/ath9k/htc_drv_main.c b/drivers/net/wireless/ath/ath9k/htc_drv_main.c
index 14d713e03872..61875c45366b 100644
--- a/drivers/net/wireless/ath/ath9k/htc_drv_main.c
+++ b/drivers/net/wireless/ath/ath9k/htc_drv_main.c
@@ -1369,7 +1369,8 @@ static void ath9k_htc_sta_rc_update(struct ieee80211_hw *hw,
 }
 
 static int ath9k_htc_conf_tx(struct ieee80211_hw *hw,
-			     struct ieee80211_vif *vif, u16 queue,
+			     struct ieee80211_vif *vif,
+			     unsigned int link_id, u16 queue,
 			     const struct ieee80211_tx_queue_params *params)
 {
 	struct ath9k_htc_priv *priv = hw->priv;
diff --git a/drivers/net/wireless/ath/ath9k/main.c b/drivers/net/wireless/ath/ath9k/main.c
index c3d5d9795424..d2c20c332c7a 100644
--- a/drivers/net/wireless/ath/ath9k/main.c
+++ b/drivers/net/wireless/ath/ath9k/main.c
@@ -1712,7 +1712,8 @@ static void ath9k_sta_notify(struct ieee80211_hw *hw,
 }
 
 static int ath9k_conf_tx(struct ieee80211_hw *hw,
-			 struct ieee80211_vif *vif, u16 queue,
+			 struct ieee80211_vif *vif,
+			 unsigned int link_id, u16 queue,
 			 const struct ieee80211_tx_queue_params *params)
 {
 	struct ath_softc *sc = hw->priv;
diff --git a/drivers/net/wireless/ath/carl9170/main.c b/drivers/net/wireless/ath/carl9170/main.c
index 3d881028bd00..1540e9827f48 100644
--- a/drivers/net/wireless/ath/carl9170/main.c
+++ b/drivers/net/wireless/ath/carl9170/main.c
@@ -1365,7 +1365,8 @@ static int carl9170_op_sta_remove(struct ieee80211_hw *hw,
 }
 
 static int carl9170_op_conf_tx(struct ieee80211_hw *hw,
-			       struct ieee80211_vif *vif, u16 queue,
+			       struct ieee80211_vif *vif,
+			       unsigned int link_id, u16 queue,
 			       const struct ieee80211_tx_queue_params *param)
 {
 	struct ar9170 *ar = hw->priv;
diff --git a/drivers/net/wireless/broadcom/b43/main.c b/drivers/net/wireless/broadcom/b43/main.c
index 6b4188066f0b..008ee1f98af4 100644
--- a/drivers/net/wireless/broadcom/b43/main.c
+++ b/drivers/net/wireless/broadcom/b43/main.c
@@ -3783,7 +3783,8 @@ static void b43_qos_init(struct b43_wldev *dev)
 }
 
 static int b43_op_conf_tx(struct ieee80211_hw *hw,
-			  struct ieee80211_vif *vif, u16 _queue,
+			  struct ieee80211_vif *vif,
+			  unsigned int link_id, u16 _queue,
 			  const struct ieee80211_tx_queue_params *params)
 {
 	struct b43_wl *wl = hw_to_b43_wl(hw);
diff --git a/drivers/net/wireless/broadcom/b43legacy/main.c b/drivers/net/wireless/broadcom/b43legacy/main.c
index 532013184389..cbc21c7c3138 100644
--- a/drivers/net/wireless/broadcom/b43legacy/main.c
+++ b/drivers/net/wireless/broadcom/b43legacy/main.c
@@ -2505,7 +2505,8 @@ static void b43legacy_op_tx(struct ieee80211_hw *hw,
 }
 
 static int b43legacy_op_conf_tx(struct ieee80211_hw *hw,
-				struct ieee80211_vif *vif, u16 queue,
+				struct ieee80211_vif *vif,
+				unsigned int link_id, u16 queue,
 				const struct ieee80211_tx_queue_params *params)
 {
 	return 0;
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmsmac/mac80211_if.c b/drivers/net/wireless/broadcom/brcm80211/brcmsmac/mac80211_if.c
index 61d7404aded4..a4034d44609b 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmsmac/mac80211_if.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmsmac/mac80211_if.c
@@ -787,7 +787,8 @@ static void brcms_ops_sw_scan_complete(struct ieee80211_hw *hw,
 }
 
 static int
-brcms_ops_conf_tx(struct ieee80211_hw *hw, struct ieee80211_vif *vif, u16 queue,
+brcms_ops_conf_tx(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
+		  unsigned int link_id, u16 queue,
 		  const struct ieee80211_tx_queue_params *params)
 {
 	struct brcms_info *wl = hw->priv;
diff --git a/drivers/net/wireless/intel/iwlegacy/common.c b/drivers/net/wireless/intel/iwlegacy/common.c
index 6f007e63f0c2..9aa3359a9adc 100644
--- a/drivers/net/wireless/intel/iwlegacy/common.c
+++ b/drivers/net/wireless/intel/iwlegacy/common.c
@@ -4480,7 +4480,8 @@ il_clear_isr_stats(struct il_priv *il)
 }
 
 int
-il_mac_conf_tx(struct ieee80211_hw *hw, struct ieee80211_vif *vif, u16 queue,
+il_mac_conf_tx(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
+	       unsigned int link_id, u16 queue,
 	       const struct ieee80211_tx_queue_params *params)
 {
 	struct il_priv *il = hw->priv;
diff --git a/drivers/net/wireless/intel/iwlegacy/common.h b/drivers/net/wireless/intel/iwlegacy/common.h
index d1383b4f0f05..69687fcf963f 100644
--- a/drivers/net/wireless/intel/iwlegacy/common.h
+++ b/drivers/net/wireless/intel/iwlegacy/common.h
@@ -1683,7 +1683,8 @@ struct il_cfg {
  ***************************/
 
 int il_mac_conf_tx(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
-		   u16 queue, const struct ieee80211_tx_queue_params *params);
+		   unsigned int link_id, u16 queue,
+		   const struct ieee80211_tx_queue_params *params);
 int il_mac_tx_last_beacon(struct ieee80211_hw *hw);
 
 void il_set_rxon_hwcrypto(struct il_priv *il, int hw_decrypt);
diff --git a/drivers/net/wireless/intel/iwlwifi/dvm/mac80211.c b/drivers/net/wireless/intel/iwlwifi/dvm/mac80211.c
index e8bd4f0e3d2d..f4070fddc8c7 100644
--- a/drivers/net/wireless/intel/iwlwifi/dvm/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/dvm/mac80211.c
@@ -2,7 +2,7 @@
 /******************************************************************************
  *
  * Copyright(c) 2003 - 2014 Intel Corporation. All rights reserved.
- * Copyright (C) 2018 - 2019 Intel Corporation
+ * Copyright (C) 2018 - 2019, 2022 Intel Corporation
  *
  * Portions of this file are derived from the ipw3945 project, as well
  * as portions of the ieee80211 subsystem header files.
@@ -1153,7 +1153,8 @@ static int iwlagn_mac_set_tim(struct ieee80211_hw *hw,
 }
 
 static int iwlagn_mac_conf_tx(struct ieee80211_hw *hw,
-			      struct ieee80211_vif *vif, u16 queue,
+			      struct ieee80211_vif *vif,
+			      unsigned int link_id, u16 queue,
 			      const struct ieee80211_tx_queue_params *params)
 {
 	struct iwl_priv *priv = IWL_MAC80211_GET_DVM(hw);
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
index eaffc3163bd1..3de558f286a1 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
@@ -3349,7 +3349,8 @@ static void iwl_mvm_sta_rc_update(struct ieee80211_hw *hw,
 }
 
 static int iwl_mvm_mac_conf_tx(struct ieee80211_hw *hw,
-			       struct ieee80211_vif *vif, u16 ac,
+			       struct ieee80211_vif *vif,
+			       unsigned int link_id, u16 ac,
 			       const struct ieee80211_tx_queue_params *params)
 {
 	struct iwl_mvm *mvm = IWL_MAC80211_GET_MVM(hw);
diff --git a/drivers/net/wireless/intersil/p54/main.c b/drivers/net/wireless/intersil/p54/main.c
index 115be1f3f33d..0f76d43fda33 100644
--- a/drivers/net/wireless/intersil/p54/main.c
+++ b/drivers/net/wireless/intersil/p54/main.c
@@ -404,7 +404,8 @@ static void p54_configure_filter(struct ieee80211_hw *dev,
 }
 
 static int p54_conf_tx(struct ieee80211_hw *dev,
-		       struct ieee80211_vif *vif, u16 queue,
+		       struct ieee80211_vif *vif,
+		       unsigned int link_id, u16 queue,
 		       const struct ieee80211_tx_queue_params *params)
 {
 	struct p54_common *priv = dev->priv;
diff --git a/drivers/net/wireless/mac80211_hwsim.c b/drivers/net/wireless/mac80211_hwsim.c
index 835422c3a1b2..5243508bbfab 100644
--- a/drivers/net/wireless/mac80211_hwsim.c
+++ b/drivers/net/wireless/mac80211_hwsim.c
@@ -2340,10 +2340,10 @@ static int mac80211_hwsim_set_tim(struct ieee80211_hw *hw,
 	return 0;
 }
 
-static int mac80211_hwsim_conf_tx(
-	struct ieee80211_hw *hw,
-	struct ieee80211_vif *vif, u16 queue,
-	const struct ieee80211_tx_queue_params *params)
+static int mac80211_hwsim_conf_tx(struct ieee80211_hw *hw,
+				  struct ieee80211_vif *vif,
+				  unsigned int link_id, u16 queue,
+				  const struct ieee80211_tx_queue_params *params)
 {
 	wiphy_dbg(hw->wiphy,
 		  "%s (queue=%d txop=%d cw_min=%d cw_max=%d aifs=%d)\n",
diff --git a/drivers/net/wireless/marvell/mwl8k.c b/drivers/net/wireless/marvell/mwl8k.c
index 293bec9bb8dd..c1bf8998109c 100644
--- a/drivers/net/wireless/marvell/mwl8k.c
+++ b/drivers/net/wireless/marvell/mwl8k.c
@@ -5365,7 +5365,8 @@ static int mwl8k_sta_add(struct ieee80211_hw *hw,
 }
 
 static int mwl8k_conf_tx(struct ieee80211_hw *hw,
-			 struct ieee80211_vif *vif, u16 queue,
+			 struct ieee80211_vif *vif,
+			 unsigned int link_id, u16 queue,
 			 const struct ieee80211_tx_queue_params *params)
 {
 	struct mwl8k_priv *priv = hw->priv;
@@ -6050,7 +6051,7 @@ static int mwl8k_reload_firmware(struct ieee80211_hw *hw, char *fw_image)
 		goto fail;
 
 	for (i = 0; i < MWL8K_TX_WMM_QUEUES; i++) {
-		rc = mwl8k_conf_tx(hw, NULL, i, &priv->wmm_params[i]);
+		rc = mwl8k_conf_tx(hw, NULL, 0, i, &priv->wmm_params[i]);
 		if (rc)
 			goto fail;
 	}
diff --git a/drivers/net/wireless/mediatek/mt76/mt7603/main.c b/drivers/net/wireless/mediatek/mt76/mt7603/main.c
index 088c0a4cf774..051715ed90dd 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7603/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7603/main.c
@@ -527,7 +527,8 @@ mt7603_set_key(struct ieee80211_hw *hw, enum set_key_cmd cmd,
 }
 
 static int
-mt7603_conf_tx(struct ieee80211_hw *hw, struct ieee80211_vif *vif, u16 queue,
+mt7603_conf_tx(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
+	       unsigned int link_id, u16 queue,
 	       const struct ieee80211_tx_queue_params *params)
 {
 	struct mt7603_dev *dev = hw->priv;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/main.c b/drivers/net/wireless/mediatek/mt76/mt7615/main.c
index 277c22a4d049..bf1696eb568a 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/main.c
@@ -494,7 +494,8 @@ static int mt7615_config(struct ieee80211_hw *hw, u32 changed)
 }
 
 static int
-mt7615_conf_tx(struct ieee80211_hw *hw, struct ieee80211_vif *vif, u16 queue,
+mt7615_conf_tx(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
+	       unsigned int link_id, u16 queue,
 	       const struct ieee80211_tx_queue_params *params)
 {
 	struct mt76_vif *mvif = (struct mt76_vif *)vif->drv_priv;
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x02.h b/drivers/net/wireless/mediatek/mt76/mt76x02.h
index 74ad418f5a70..50eaeff11af3 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x02.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76x02.h
@@ -156,7 +156,8 @@ int mt76x02_set_key(struct ieee80211_hw *hw, enum set_key_cmd cmd,
 		    struct ieee80211_vif *vif, struct ieee80211_sta *sta,
 		    struct ieee80211_key_conf *key);
 int mt76x02_conf_tx(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
-		    u16 queue, const struct ieee80211_tx_queue_params *params);
+		    unsigned int link_id, u16 queue,
+		    const struct ieee80211_tx_queue_params *params);
 void mt76x02_sta_rate_tbl_update(struct ieee80211_hw *hw,
 				 struct ieee80211_vif *vif,
 				 struct ieee80211_sta *sta);
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x02_util.c b/drivers/net/wireless/mediatek/mt76/mt76x02_util.c
index a0e2d042751b..604ddcc21123 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x02_util.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x02_util.c
@@ -487,7 +487,8 @@ int mt76x02_set_key(struct ieee80211_hw *hw, enum set_key_cmd cmd,
 EXPORT_SYMBOL_GPL(mt76x02_set_key);
 
 int mt76x02_conf_tx(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
-		    u16 queue, const struct ieee80211_tx_queue_params *params)
+		    unsigned int link_id, u16 queue,
+		    const struct ieee80211_tx_queue_params *params)
 {
 	struct mt76x02_dev *dev = hw->priv;
 	u8 cw_min = 5, cw_max = 10, qid;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/main.c b/drivers/net/wireless/mediatek/mt76/mt7915/main.c
index fbeac9aa2af6..25323a155a88 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/main.c
@@ -478,7 +478,8 @@ static int mt7915_config(struct ieee80211_hw *hw, u32 changed)
 }
 
 static int
-mt7915_conf_tx(struct ieee80211_hw *hw, struct ieee80211_vif *vif, u16 queue,
+mt7915_conf_tx(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
+	       unsigned int link_id, u16 queue,
 	       const struct ieee80211_tx_queue_params *params)
 {
 	struct mt7915_vif *mvif = (struct mt7915_vif *)vif->drv_priv;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/main.c b/drivers/net/wireless/mediatek/mt76/mt7921/main.c
index 63583605d1cd..1d0daa0c90be 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/main.c
@@ -567,7 +567,8 @@ static int mt7921_config(struct ieee80211_hw *hw, u32 changed)
 }
 
 static int
-mt7921_conf_tx(struct ieee80211_hw *hw, struct ieee80211_vif *vif, u16 queue,
+mt7921_conf_tx(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
+	       unsigned int link_id, u16 queue,
 	       const struct ieee80211_tx_queue_params *params)
 {
 	struct mt7921_vif *mvif = (struct mt7921_vif *)vif->drv_priv;
diff --git a/drivers/net/wireless/mediatek/mt7601u/mt7601u.h b/drivers/net/wireless/mediatek/mt7601u/mt7601u.h
index a122f1dd38f6..118d43707853 100644
--- a/drivers/net/wireless/mediatek/mt7601u/mt7601u.h
+++ b/drivers/net/wireless/mediatek/mt7601u/mt7601u.h
@@ -368,7 +368,8 @@ void mt7601u_mac_set_ampdu_factor(struct mt7601u_dev *dev);
 void mt7601u_tx(struct ieee80211_hw *hw, struct ieee80211_tx_control *control,
 		struct sk_buff *skb);
 int mt7601u_conf_tx(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
-		    u16 queue, const struct ieee80211_tx_queue_params *params);
+		    unsigned int link_id, u16 queue,
+		    const struct ieee80211_tx_queue_params *params);
 void mt7601u_tx_status(struct mt7601u_dev *dev, struct sk_buff *skb);
 void mt7601u_tx_stat(struct work_struct *work);
 
diff --git a/drivers/net/wireless/mediatek/mt7601u/tx.c b/drivers/net/wireless/mediatek/mt7601u/tx.c
index f1fa0442a57f..51d977ffc52f 100644
--- a/drivers/net/wireless/mediatek/mt7601u/tx.c
+++ b/drivers/net/wireless/mediatek/mt7601u/tx.c
@@ -258,7 +258,8 @@ void mt7601u_tx_stat(struct work_struct *work)
 }
 
 int mt7601u_conf_tx(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
-		    u16 queue, const struct ieee80211_tx_queue_params *params)
+		    unsigned int link_id, u16 queue,
+		    const struct ieee80211_tx_queue_params *params)
 {
 	struct mt7601u_dev *dev = hw->priv;
 	u8 cw_min = 5, cw_max = 10, hw_q = q2hwq(queue);
diff --git a/drivers/net/wireless/ralink/rt2x00/rt2400pci.c b/drivers/net/wireless/ralink/rt2x00/rt2400pci.c
index dec6ffdf07c4..273c5eac3362 100644
--- a/drivers/net/wireless/ralink/rt2x00/rt2400pci.c
+++ b/drivers/net/wireless/ralink/rt2x00/rt2400pci.c
@@ -1654,7 +1654,8 @@ static int rt2400pci_probe_hw(struct rt2x00_dev *rt2x00dev)
  * IEEE80211 stack callback functions.
  */
 static int rt2400pci_conf_tx(struct ieee80211_hw *hw,
-			     struct ieee80211_vif *vif, u16 queue,
+			     struct ieee80211_vif *vif,
+			     unsigned int link_id, u16 queue,
 			     const struct ieee80211_tx_queue_params *params)
 {
 	struct rt2x00_dev *rt2x00dev = hw->priv;
@@ -1667,7 +1668,7 @@ static int rt2400pci_conf_tx(struct ieee80211_hw *hw,
 	if (queue != 0)
 		return -EINVAL;
 
-	if (rt2x00mac_conf_tx(hw, vif, queue, params))
+	if (rt2x00mac_conf_tx(hw, vif, link_id, queue, params))
 		return -EINVAL;
 
 	/*
diff --git a/drivers/net/wireless/ralink/rt2x00/rt2800lib.c b/drivers/net/wireless/ralink/rt2x00/rt2800lib.c
index cbdaf7992f98..18102fbe36d6 100644
--- a/drivers/net/wireless/ralink/rt2x00/rt2800lib.c
+++ b/drivers/net/wireless/ralink/rt2x00/rt2800lib.c
@@ -10395,7 +10395,8 @@ int rt2800_set_rts_threshold(struct ieee80211_hw *hw, u32 value)
 EXPORT_SYMBOL_GPL(rt2800_set_rts_threshold);
 
 int rt2800_conf_tx(struct ieee80211_hw *hw,
-		   struct ieee80211_vif *vif, u16 queue_idx,
+		   struct ieee80211_vif *vif,
+		   unsigned int link_id, u16 queue_idx,
 		   const struct ieee80211_tx_queue_params *params)
 {
 	struct rt2x00_dev *rt2x00dev = hw->priv;
@@ -10411,7 +10412,7 @@ int rt2800_conf_tx(struct ieee80211_hw *hw,
 	 * we are free to update the registers based on the value
 	 * in the queue parameter.
 	 */
-	retval = rt2x00mac_conf_tx(hw, vif, queue_idx, params);
+	retval = rt2x00mac_conf_tx(hw, vif, link_id, queue_idx, params);
 	if (retval)
 		return retval;
 
diff --git a/drivers/net/wireless/ralink/rt2x00/rt2800lib.h b/drivers/net/wireless/ralink/rt2x00/rt2800lib.h
index 1139405c0ebb..e1761f467b94 100644
--- a/drivers/net/wireless/ralink/rt2x00/rt2800lib.h
+++ b/drivers/net/wireless/ralink/rt2x00/rt2800lib.h
@@ -245,7 +245,8 @@ void rt2800_get_key_seq(struct ieee80211_hw *hw,
 			struct ieee80211_key_seq *seq);
 int rt2800_set_rts_threshold(struct ieee80211_hw *hw, u32 value);
 int rt2800_conf_tx(struct ieee80211_hw *hw,
-		   struct ieee80211_vif *vif, u16 queue_idx,
+		   struct ieee80211_vif *vif,
+		   unsigned int link_id, u16 queue_idx,
 		   const struct ieee80211_tx_queue_params *params);
 u64 rt2800_get_tsf(struct ieee80211_hw *hw, struct ieee80211_vif *vif);
 int rt2800_ampdu_action(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
diff --git a/drivers/net/wireless/ralink/rt2x00/rt2x00.h b/drivers/net/wireless/ralink/rt2x00/rt2x00.h
index 918e0477bb7d..f7ef2ca38794 100644
--- a/drivers/net/wireless/ralink/rt2x00/rt2x00.h
+++ b/drivers/net/wireless/ralink/rt2x00/rt2x00.h
@@ -1481,7 +1481,8 @@ void rt2x00mac_bss_info_changed(struct ieee80211_hw *hw,
 				struct ieee80211_bss_conf *bss_conf,
 				u64 changes);
 int rt2x00mac_conf_tx(struct ieee80211_hw *hw,
-		      struct ieee80211_vif *vif, u16 queue,
+		      struct ieee80211_vif *vif,
+		      unsigned int link_id, u16 queue,
 		      const struct ieee80211_tx_queue_params *params);
 void rt2x00mac_rfkill_poll(struct ieee80211_hw *hw);
 void rt2x00mac_flush(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
diff --git a/drivers/net/wireless/ralink/rt2x00/rt2x00mac.c b/drivers/net/wireless/ralink/rt2x00/rt2x00mac.c
index 6205d22765c7..c0ab2e6a29ad 100644
--- a/drivers/net/wireless/ralink/rt2x00/rt2x00mac.c
+++ b/drivers/net/wireless/ralink/rt2x00/rt2x00mac.c
@@ -665,7 +665,8 @@ void rt2x00mac_bss_info_changed(struct ieee80211_hw *hw,
 EXPORT_SYMBOL_GPL(rt2x00mac_bss_info_changed);
 
 int rt2x00mac_conf_tx(struct ieee80211_hw *hw,
-		      struct ieee80211_vif *vif, u16 queue_idx,
+		      struct ieee80211_vif *vif,
+		      unsigned int link_id, u16 queue_idx,
 		      const struct ieee80211_tx_queue_params *params)
 {
 	struct rt2x00_dev *rt2x00dev = hw->priv;
diff --git a/drivers/net/wireless/ralink/rt2x00/rt61pci.c b/drivers/net/wireless/ralink/rt2x00/rt61pci.c
index 82cfc2aadc2b..d92f9eb07dc9 100644
--- a/drivers/net/wireless/ralink/rt2x00/rt61pci.c
+++ b/drivers/net/wireless/ralink/rt2x00/rt61pci.c
@@ -2799,7 +2799,8 @@ static int rt61pci_probe_hw(struct rt2x00_dev *rt2x00dev)
  * IEEE80211 stack callback functions.
  */
 static int rt61pci_conf_tx(struct ieee80211_hw *hw,
-			   struct ieee80211_vif *vif, u16 queue_idx,
+			   struct ieee80211_vif *vif,
+			   unsigned int link_id, u16 queue_idx,
 			   const struct ieee80211_tx_queue_params *params)
 {
 	struct rt2x00_dev *rt2x00dev = hw->priv;
@@ -2815,7 +2816,7 @@ static int rt61pci_conf_tx(struct ieee80211_hw *hw,
 	 * we are free to update the registers based on the value
 	 * in the queue parameter.
 	 */
-	retval = rt2x00mac_conf_tx(hw, vif, queue_idx, params);
+	retval = rt2x00mac_conf_tx(hw, vif, link_id, queue_idx, params);
 	if (retval)
 		return retval;
 
diff --git a/drivers/net/wireless/ralink/rt2x00/rt73usb.c b/drivers/net/wireless/ralink/rt2x00/rt73usb.c
index 5ff2c740c3ea..e3269fd7c59e 100644
--- a/drivers/net/wireless/ralink/rt2x00/rt73usb.c
+++ b/drivers/net/wireless/ralink/rt2x00/rt73usb.c
@@ -2218,7 +2218,8 @@ static int rt73usb_probe_hw(struct rt2x00_dev *rt2x00dev)
  * IEEE80211 stack callback functions.
  */
 static int rt73usb_conf_tx(struct ieee80211_hw *hw,
-			   struct ieee80211_vif *vif, u16 queue_idx,
+			   struct ieee80211_vif *vif,
+			   unsigned int link_id, u16 queue_idx,
 			   const struct ieee80211_tx_queue_params *params)
 {
 	struct rt2x00_dev *rt2x00dev = hw->priv;
@@ -2234,7 +2235,7 @@ static int rt73usb_conf_tx(struct ieee80211_hw *hw,
 	 * we are free to update the registers based on the value
 	 * in the queue parameter.
 	 */
-	retval = rt2x00mac_conf_tx(hw, vif, queue_idx, params);
+	retval = rt2x00mac_conf_tx(hw, vif, link_id, queue_idx, params);
 	if (retval)
 		return retval;
 
diff --git a/drivers/net/wireless/realtek/rtl818x/rtl8180/dev.c b/drivers/net/wireless/realtek/rtl818x/rtl8180/dev.c
index f66cc9083972..cdfe08078c57 100644
--- a/drivers/net/wireless/realtek/rtl818x/rtl8180/dev.c
+++ b/drivers/net/wireless/realtek/rtl818x/rtl8180/dev.c
@@ -1424,7 +1424,8 @@ static void rtl8187se_conf_ac_parm(struct ieee80211_hw *dev, u8 queue)
 }
 
 static int rtl8180_conf_tx(struct ieee80211_hw *dev,
-			    struct ieee80211_vif *vif, u16 queue,
+			    struct ieee80211_vif *vif,
+			    unsigned int link_id, u16 queue,
 			    const struct ieee80211_tx_queue_params *params)
 {
 	struct rtl8180_priv *priv = dev->priv;
diff --git a/drivers/net/wireless/realtek/rtl818x/rtl8187/dev.c b/drivers/net/wireless/realtek/rtl818x/rtl8187/dev.c
index edc84f9dc984..c0f6e9c6d03e 100644
--- a/drivers/net/wireless/realtek/rtl818x/rtl8187/dev.c
+++ b/drivers/net/wireless/realtek/rtl818x/rtl8187/dev.c
@@ -1338,7 +1338,8 @@ static void rtl8187_configure_filter(struct ieee80211_hw *dev,
 }
 
 static int rtl8187_conf_tx(struct ieee80211_hw *dev,
-			   struct ieee80211_vif *vif, u16 queue,
+			   struct ieee80211_vif *vif,
+			   unsigned int link_id, u16 queue,
 			   const struct ieee80211_tx_queue_params *params)
 {
 	struct rtl8187_priv *priv = dev->priv;
diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
index 65c4cb1e030c..33a1d9143038 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
+++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
@@ -5957,7 +5957,8 @@ static int rtl8xxxu_config(struct ieee80211_hw *hw, u32 changed)
 }
 
 static int rtl8xxxu_conf_tx(struct ieee80211_hw *hw,
-			    struct ieee80211_vif *vif, u16 queue,
+			    struct ieee80211_vif *vif,
+			    unsigned int link_id, u16 queue,
 			    const struct ieee80211_tx_queue_params *param)
 {
 	struct rtl8xxxu_priv *priv = hw->priv;
diff --git a/drivers/net/wireless/realtek/rtlwifi/core.c b/drivers/net/wireless/realtek/rtlwifi/core.c
index 8537cc6d7a89..519b2643f9f4 100644
--- a/drivers/net/wireless/realtek/rtlwifi/core.c
+++ b/drivers/net/wireless/realtek/rtlwifi/core.c
@@ -982,7 +982,8 @@ static int _rtl_get_hal_qnum(u16 queue)
  *for rtl819x  BE = 0, BK = 1, VI = 2, VO = 3
  */
 static int rtl_op_conf_tx(struct ieee80211_hw *hw,
-			  struct ieee80211_vif *vif, u16 queue,
+			  struct ieee80211_vif *vif,
+			  unsigned int link_id, u16 queue,
 			  const struct ieee80211_tx_queue_params *param)
 {
 	struct rtl_priv *rtlpriv = rtl_priv(hw);
diff --git a/drivers/net/wireless/realtek/rtw88/mac80211.c b/drivers/net/wireless/realtek/rtw88/mac80211.c
index ba60ca7ecdbf..bb7291665d37 100644
--- a/drivers/net/wireless/realtek/rtw88/mac80211.c
+++ b/drivers/net/wireless/realtek/rtw88/mac80211.c
@@ -443,7 +443,8 @@ static int rtw_ops_start_ap(struct ieee80211_hw *hw,
 }
 
 static int rtw_ops_conf_tx(struct ieee80211_hw *hw,
-			   struct ieee80211_vif *vif, u16 ac,
+			   struct ieee80211_vif *vif,
+			   unsigned int link_id, u16 ac,
 			   const struct ieee80211_tx_queue_params *params)
 {
 	struct rtw_dev *rtwdev = hw->priv;
diff --git a/drivers/net/wireless/realtek/rtw89/mac80211.c b/drivers/net/wireless/realtek/rtw89/mac80211.c
index 20fb4c550010..f40569c8575c 100644
--- a/drivers/net/wireless/realtek/rtw89/mac80211.c
+++ b/drivers/net/wireless/realtek/rtw89/mac80211.c
@@ -427,7 +427,8 @@ static int rtw89_ops_set_tim(struct ieee80211_hw *hw, struct ieee80211_sta *sta,
 }
 
 static int rtw89_ops_conf_tx(struct ieee80211_hw *hw,
-			     struct ieee80211_vif *vif, u16 ac,
+			     struct ieee80211_vif *vif,
+			     unsigned int link_id, u16 ac,
 			     const struct ieee80211_tx_queue_params *params)
 {
 	struct rtw89_dev *rtwdev = hw->priv;
diff --git a/drivers/net/wireless/rsi/rsi_91x_mac80211.c b/drivers/net/wireless/rsi/rsi_91x_mac80211.c
index 1dff3d263382..bf39c4bda26f 100644
--- a/drivers/net/wireless/rsi/rsi_91x_mac80211.c
+++ b/drivers/net/wireless/rsi/rsi_91x_mac80211.c
@@ -895,7 +895,8 @@ static void rsi_mac80211_conf_filter(struct ieee80211_hw *hw,
  * Return: 0 on success, negative error code on failure.
  */
 static int rsi_mac80211_conf_tx(struct ieee80211_hw *hw,
-				struct ieee80211_vif *vif, u16 queue,
+				struct ieee80211_vif *vif,
+				unsigned int link_id, u16 queue,
 				const struct ieee80211_tx_queue_params *params)
 {
 	struct rsi_hw *adapter = hw->priv;
diff --git a/drivers/net/wireless/silabs/wfx/sta.c b/drivers/net/wireless/silabs/wfx/sta.c
index 47fd887ce6fe..89402afe4fe6 100644
--- a/drivers/net/wireless/silabs/wfx/sta.c
+++ b/drivers/net/wireless/silabs/wfx/sta.c
@@ -216,7 +216,8 @@ int wfx_update_pm(struct wfx_vif *wvif)
 }
 
 int wfx_conf_tx(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
-		u16 queue, const struct ieee80211_tx_queue_params *params)
+		unsigned int link_id, u16 queue,
+		const struct ieee80211_tx_queue_params *params)
 {
 	struct wfx_dev *wdev = hw->priv;
 	struct wfx_vif *wvif = (struct wfx_vif *)vif->drv_priv;
diff --git a/drivers/net/wireless/silabs/wfx/sta.h b/drivers/net/wireless/silabs/wfx/sta.h
index 93ea992de1d7..6558c5698cc8 100644
--- a/drivers/net/wireless/silabs/wfx/sta.h
+++ b/drivers/net/wireless/silabs/wfx/sta.h
@@ -36,7 +36,8 @@ void wfx_stop_ap(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 int wfx_join_ibss(struct ieee80211_hw *hw, struct ieee80211_vif *vif);
 void wfx_leave_ibss(struct ieee80211_hw *hw, struct ieee80211_vif *vif);
 int wfx_conf_tx(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
-		u16 queue, const struct ieee80211_tx_queue_params *params);
+		unsigned int link_id, u16 queue,
+		const struct ieee80211_tx_queue_params *params);
 void wfx_bss_info_changed(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 			  struct ieee80211_bss_conf *info, u64 changed);
 int wfx_sta_add(struct ieee80211_hw *hw, struct ieee80211_vif *vif, struct ieee80211_sta *sta);
diff --git a/drivers/net/wireless/st/cw1200/sta.c b/drivers/net/wireless/st/cw1200/sta.c
index a3f6942df0c1..26d3614519b1 100644
--- a/drivers/net/wireless/st/cw1200/sta.c
+++ b/drivers/net/wireless/st/cw1200/sta.c
@@ -606,7 +606,8 @@ void cw1200_configure_filter(struct ieee80211_hw *dev,
 }
 
 int cw1200_conf_tx(struct ieee80211_hw *dev, struct ieee80211_vif *vif,
-		   u16 queue, const struct ieee80211_tx_queue_params *params)
+		   unsigned int link_id, u16 queue,
+		   const struct ieee80211_tx_queue_params *params)
 {
 	struct cw1200_common *priv = dev->priv;
 	int ret = 0;
diff --git a/drivers/net/wireless/st/cw1200/sta.h b/drivers/net/wireless/st/cw1200/sta.h
index 05e3ab7ccef1..a49f187c7049 100644
--- a/drivers/net/wireless/st/cw1200/sta.h
+++ b/drivers/net/wireless/st/cw1200/sta.h
@@ -28,7 +28,8 @@ void cw1200_configure_filter(struct ieee80211_hw *dev,
 			     unsigned int *total_flags,
 			     u64 multicast);
 int cw1200_conf_tx(struct ieee80211_hw *dev, struct ieee80211_vif *vif,
-		   u16 queue, const struct ieee80211_tx_queue_params *params);
+		   unsigned int link_id, u16 queue,
+		   const struct ieee80211_tx_queue_params *params);
 int cw1200_get_stats(struct ieee80211_hw *dev,
 		     struct ieee80211_low_level_stats *stats);
 int cw1200_set_key(struct ieee80211_hw *dev, enum set_key_cmd cmd,
diff --git a/drivers/net/wireless/ti/wl1251/main.c b/drivers/net/wireless/ti/wl1251/main.c
index d76558964420..9144ef5538a8 100644
--- a/drivers/net/wireless/ti/wl1251/main.c
+++ b/drivers/net/wireless/ti/wl1251/main.c
@@ -1282,7 +1282,8 @@ static struct ieee80211_channel wl1251_channels[] = {
 };
 
 static int wl1251_op_conf_tx(struct ieee80211_hw *hw,
-			     struct ieee80211_vif *vif, u16 queue,
+			     struct ieee80211_vif *vif,
+			     unsigned int link_id, u16 queue,
 			     const struct ieee80211_tx_queue_params *params)
 {
 	enum wl1251_acx_ps_scheme ps_scheme;
diff --git a/drivers/net/wireless/ti/wlcore/main.c b/drivers/net/wireless/ti/wlcore/main.c
index d1200080f165..1edec9f3c0d8 100644
--- a/drivers/net/wireless/ti/wlcore/main.c
+++ b/drivers/net/wireless/ti/wlcore/main.c
@@ -4864,7 +4864,8 @@ wlcore_op_switch_vif_chanctx(struct ieee80211_hw *hw,
 }
 
 static int wl1271_op_conf_tx(struct ieee80211_hw *hw,
-			     struct ieee80211_vif *vif, u16 queue,
+			     struct ieee80211_vif *vif,
+			     unsigned int link_id, u16 queue,
 			     const struct ieee80211_tx_queue_params *params)
 {
 	struct wl1271 *wl = hw->priv;
diff --git a/include/net/mac80211.h b/include/net/mac80211.h
index 210b49c6cd50..c4ed5afba380 100644
--- a/include/net/mac80211.h
+++ b/include/net/mac80211.h
@@ -4174,7 +4174,8 @@ struct ieee80211_ops {
 			       struct ieee80211_sta *sta,
 			       struct station_info *sinfo);
 	int (*conf_tx)(struct ieee80211_hw *hw,
-		       struct ieee80211_vif *vif, u16 ac,
+		       struct ieee80211_vif *vif,
+		       unsigned int link_id, u16 ac,
 		       const struct ieee80211_tx_queue_params *params);
 	u64 (*get_tsf)(struct ieee80211_hw *hw, struct ieee80211_vif *vif);
 	void (*set_tsf)(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index a4e511766008..8a37f1402328 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -2570,6 +2570,7 @@ static int ieee80211_set_txq_params(struct wiphy *wiphy,
 {
 	struct ieee80211_local *local = wiphy_priv(wiphy);
 	struct ieee80211_sub_if_data *sdata = IEEE80211_DEV_TO_SUB_IF(dev);
+	struct ieee80211_link_data *link = &sdata->deflink;
 	struct ieee80211_tx_queue_params p;
 
 	if (!local->ops->conf_tx)
@@ -2592,15 +2593,15 @@ static int ieee80211_set_txq_params(struct wiphy *wiphy,
 
 	ieee80211_regulatory_limit_wmm_params(sdata, &p, params->ac);
 
-	sdata->tx_conf[params->ac] = p;
-	if (drv_conf_tx(local, sdata, params->ac, &p)) {
+	link->tx_conf[params->ac] = p;
+	if (drv_conf_tx(local, link, params->ac, &p)) {
 		wiphy_debug(local->hw.wiphy,
 			    "failed to set TX queue parameters for AC %d\n",
 			    params->ac);
 		return -EINVAL;
 	}
 
-	ieee80211_link_info_change_notify(sdata, &sdata->deflink,
+	ieee80211_link_info_change_notify(sdata, link,
 					  BSS_CHANGED_QOS);
 
 	return 0;
diff --git a/net/mac80211/driver-ops.c b/net/mac80211/driver-ops.c
index 48322e45e7dd..9b61dc7889c2 100644
--- a/net/mac80211/driver-ops.c
+++ b/net/mac80211/driver-ops.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /*
  * Copyright 2015 Intel Deutschland GmbH
+ * Copyright (C) 2022 Intel Corporation
  */
 #include <net/mac80211.h>
 #include "ieee80211_i.h"
@@ -180,9 +181,10 @@ void drv_sta_rc_update(struct ieee80211_local *local,
 }
 
 int drv_conf_tx(struct ieee80211_local *local,
-		struct ieee80211_sub_if_data *sdata, u16 ac,
+		struct ieee80211_link_data *link, u16 ac,
 		const struct ieee80211_tx_queue_params *params)
 {
+	struct ieee80211_sub_if_data *sdata = link->sdata;
 	int ret = -EOPNOTSUPP;
 
 	might_sleep();
@@ -201,10 +203,10 @@ int drv_conf_tx(struct ieee80211_local *local,
 		return -EINVAL;
 	}
 
-	trace_drv_conf_tx(local, sdata, ac, params);
+	trace_drv_conf_tx(local, sdata, link->link_id, ac, params);
 	if (local->ops->conf_tx)
 		ret = local->ops->conf_tx(&local->hw, &sdata->vif,
-					  ac, params);
+					  link->link_id, ac, params);
 	trace_drv_return_int(local, ret);
 	return ret;
 }
diff --git a/net/mac80211/driver-ops.h b/net/mac80211/driver-ops.h
index ee3ac1a01bb0..eb16a354338c 100644
--- a/net/mac80211/driver-ops.h
+++ b/net/mac80211/driver-ops.h
@@ -590,7 +590,7 @@ static inline void drv_sta_statistics(struct ieee80211_local *local,
 }
 
 int drv_conf_tx(struct ieee80211_local *local,
-		struct ieee80211_sub_if_data *sdata, u16 ac,
+		struct ieee80211_link_data *link, u16 ac,
 		const struct ieee80211_tx_queue_params *params);
 
 u64 drv_get_tsf(struct ieee80211_local *local,
diff --git a/net/mac80211/ibss.c b/net/mac80211/ibss.c
index 561abcf4def9..0a1d51c60530 100644
--- a/net/mac80211/ibss.c
+++ b/net/mac80211/ibss.c
@@ -356,7 +356,7 @@ static void __ieee80211_sta_join_ibss(struct ieee80211_sub_if_data *sdata,
 	else
 		sdata->flags &= ~IEEE80211_SDATA_OPERATING_GMODE;
 
-	ieee80211_set_wmm_default(sdata, true, false);
+	ieee80211_set_wmm_default(&sdata->deflink, true, false);
 
 	sdata->vif.cfg.ibss_joined = true;
 	sdata->vif.cfg.ibss_creator = creator;
diff --git a/net/mac80211/ieee80211_i.h b/net/mac80211/ieee80211_i.h
index 05996df627ea..699dabaa9f0d 100644
--- a/net/mac80211/ieee80211_i.h
+++ b/net/mac80211/ieee80211_i.h
@@ -969,6 +969,8 @@ struct ieee80211_link_data {
 		struct ieee80211_link_data_ap ap;
 	} u;
 
+	struct ieee80211_tx_queue_params tx_conf[IEEE80211_NUM_ACS];
+
 	struct ieee80211_bss_conf *conf;
 };
 
@@ -1012,7 +1014,6 @@ struct ieee80211_sub_if_data {
 	bool control_port_over_nl80211;
 
 	atomic_t num_tx_queued;
-	struct ieee80211_tx_queue_params tx_conf[IEEE80211_NUM_ACS];
 	struct mac80211_qos_map __rcu *qos_map;
 
 	/* used to reconfigure hardware SM PS */
@@ -2101,7 +2102,7 @@ int ieee80211_frame_duration(enum nl80211_band band, size_t len,
 void ieee80211_regulatory_limit_wmm_params(struct ieee80211_sub_if_data *sdata,
 					   struct ieee80211_tx_queue_params *qparam,
 					   int ac);
-void ieee80211_set_wmm_default(struct ieee80211_sub_if_data *sdata,
+void ieee80211_set_wmm_default(struct ieee80211_link_data *link,
 			       bool bss_notify, bool enable_qos);
 void ieee80211_xmit(struct ieee80211_sub_if_data *sdata,
 		    struct sta_info *sta, struct sk_buff *skb);
diff --git a/net/mac80211/iface.c b/net/mac80211/iface.c
index 28fe0735b9a8..4b4a36692c68 100644
--- a/net/mac80211/iface.c
+++ b/net/mac80211/iface.c
@@ -1537,7 +1537,7 @@ int ieee80211_do_open(struct wireless_dev *wdev, bool coming_up)
 		 * doesn't start up with sane defaults.
 		 * Enable QoS for anything but station interfaces.
 		 */
-		ieee80211_set_wmm_default(sdata, true,
+		ieee80211_set_wmm_default(&sdata->deflink, true,
 			sdata->vif.type != NL80211_IFTYPE_STATION);
 	}
 
diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index 7b9211d16193..0992a3ff3a98 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -2017,10 +2017,11 @@ __ieee80211_sta_handle_tspec_ac_params(struct ieee80211_sub_if_data *sdata)
 		switch (tx_tspec->action) {
 		case TX_TSPEC_ACTION_STOP_DOWNGRADE:
 			/* take the original parameters */
-			if (drv_conf_tx(local, sdata, ac, &sdata->tx_conf[ac]))
-				sdata_err(sdata,
-					  "failed to set TX queue parameters for queue %d\n",
-					  ac);
+			if (drv_conf_tx(local, &sdata->deflink, ac,
+					&sdata->deflink.tx_conf[ac]))
+				link_err(&sdata->deflink,
+					 "failed to set TX queue parameters for queue %d\n",
+					 ac);
 			tx_tspec->action = TX_TSPEC_ACTION_NONE;
 			tx_tspec->downgraded = false;
 			ret = true;
@@ -2046,11 +2047,11 @@ __ieee80211_sta_handle_tspec_ac_params(struct ieee80211_sub_if_data *sdata)
 			 */
 			if (non_acm_ac >= IEEE80211_NUM_ACS)
 				non_acm_ac = IEEE80211_AC_BK;
-			if (drv_conf_tx(local, sdata, ac,
-					&sdata->tx_conf[non_acm_ac]))
-				sdata_err(sdata,
-					  "failed to set TX queue parameters for queue %d\n",
-					  ac);
+			if (drv_conf_tx(local, &sdata->deflink, ac,
+					&sdata->deflink.tx_conf[non_acm_ac]))
+				link_err(&sdata->deflink,
+					 "failed to set TX queue parameters for queue %d\n",
+					 ac);
 			tx_tspec->action = TX_TSPEC_ACTION_NONE;
 			ret = true;
 			schedule_delayed_work(&ifmgd->tx_tspec_wk,
@@ -2084,10 +2085,11 @@ static void ieee80211_sta_handle_tspec_ac_params_wk(struct work_struct *work)
 /* MLME */
 static bool
 ieee80211_sta_wmm_params(struct ieee80211_local *local,
-			 struct ieee80211_sub_if_data *sdata,
+			 struct ieee80211_link_data *link,
 			 const u8 *wmm_param, size_t wmm_param_len,
 			 const struct ieee80211_mu_edca_param_set *mu_edca)
 {
+	struct ieee80211_sub_if_data *sdata = link->sdata;
 	struct ieee80211_tx_queue_params params[IEEE80211_NUM_ACS];
 	struct ieee80211_if_managed *ifmgd = &sdata->u.mgd;
 	size_t left;
@@ -2116,11 +2118,11 @@ ieee80211_sta_wmm_params(struct ieee80211_local *local,
 	 * the driver about it.
 	 */
 	mu_edca_count = mu_edca ? mu_edca->mu_qos_info & 0x0f : -1;
-	if (count == sdata->deflink.u.mgd.wmm_last_param_set &&
-	    mu_edca_count == sdata->deflink.u.mgd.mu_edca_last_param_set)
+	if (count == link->u.mgd.wmm_last_param_set &&
+	    mu_edca_count == link->u.mgd.mu_edca_last_param_set)
 		return false;
-	sdata->deflink.u.mgd.wmm_last_param_set = count;
-	sdata->deflink.u.mgd.mu_edca_last_param_set = mu_edca_count;
+	link->u.mgd.wmm_last_param_set = count;
+	link->u.mgd.mu_edca_last_param_set = mu_edca_count;
 
 	pos = wmm_param + 8;
 	left = wmm_param_len - 8;
@@ -2218,16 +2220,16 @@ ieee80211_sta_wmm_params(struct ieee80211_local *local,
 			 params[ac].aifs, params[ac].cw_min, params[ac].cw_max,
 			 params[ac].txop, params[ac].uapsd,
 			 ifmgd->tx_tspec[ac].downgraded);
-		sdata->tx_conf[ac] = params[ac];
+		link->tx_conf[ac] = params[ac];
 		if (!ifmgd->tx_tspec[ac].downgraded &&
-		    drv_conf_tx(local, sdata, ac, &params[ac]))
-			sdata_err(sdata,
-				  "failed to set TX queue parameters for AC %d\n",
-				  ac);
+		    drv_conf_tx(local, link, ac, &params[ac]))
+			link_err(link,
+				 "failed to set TX queue parameters for AC %d\n",
+				 ac);
 	}
 
 	/* enable WMM or activate new settings */
-	sdata->vif.bss_conf.qos = true;
+	link->conf->qos = true;
 	return true;
 }
 
@@ -2507,7 +2509,7 @@ static void ieee80211_set_disassoc(struct ieee80211_sub_if_data *sdata,
 	ieee80211_bss_info_change_notify(sdata, changed);
 
 	/* disassociated - set to defaults now */
-	ieee80211_set_wmm_default(sdata, false, false);
+	ieee80211_set_wmm_default(&sdata->deflink, false, false);
 
 	del_timer_sync(&sdata->u.mgd.conn_mon_timer);
 	del_timer_sync(&sdata->u.mgd.bcn_mon_timer);
@@ -3765,12 +3767,13 @@ static bool ieee80211_assoc_success(struct ieee80211_sub_if_data *sdata,
 	sdata->deflink.u.mgd.mu_edca_last_param_set = -1;
 
 	if (ifmgd->flags & IEEE80211_STA_DISABLE_WMM) {
-		ieee80211_set_wmm_default(sdata, false, false);
-	} else if (!ieee80211_sta_wmm_params(local, sdata, elems->wmm_param,
+		ieee80211_set_wmm_default(&sdata->deflink, false, false);
+	} else if (!ieee80211_sta_wmm_params(local, &sdata->deflink,
+					     elems->wmm_param,
 					     elems->wmm_param_len,
 					     elems->mu_edca_param_set)) {
 		/* still enable QoS since we might have HT/VHT */
-		ieee80211_set_wmm_default(sdata, false, true);
+		ieee80211_set_wmm_default(&sdata->deflink, false, true);
 		/* set the disable-WMM flag in this case to disable
 		 * tracking WMM parameter changes in the beacon if
 		 * the parameters weren't actually valid. Doing so
@@ -3937,7 +3940,7 @@ static void ieee80211_rx_mgmt_assoc_resp(struct ieee80211_sub_if_data *sdata,
 		/* get uapsd queues configuration */
 		uapsd_queues = 0;
 		for (ac = 0; ac < IEEE80211_NUM_ACS; ac++)
-			if (sdata->tx_conf[ac].uapsd)
+			if (sdata->deflink.tx_conf[ac].uapsd)
 				uapsd_queues |= ieee80211_ac_to_qos_mask[ac];
 
 		info.success = 1;
@@ -4362,7 +4365,7 @@ static void ieee80211_rx_mgmt_beacon(struct ieee80211_sub_if_data *sdata,
 					 elems, true);
 
 	if (!(ifmgd->flags & IEEE80211_STA_DISABLE_WMM) &&
-	    ieee80211_sta_wmm_params(local, sdata, elems->wmm_param,
+	    ieee80211_sta_wmm_params(local, &sdata->deflink, elems->wmm_param,
 				     elems->wmm_param_len,
 				     elems->mu_edca_param_set))
 		changed |= BSS_CHANGED_QOS;
diff --git a/net/mac80211/tdls.c b/net/mac80211/tdls.c
index 30f2b340017c..e7bdcdb488e2 100644
--- a/net/mac80211/tdls.c
+++ b/net/mac80211/tdls.c
@@ -293,7 +293,7 @@ static void ieee80211_tdls_add_wmm_param_ie(struct ieee80211_sub_if_data *sdata,
 	 * doesn't support it, as mandated by 802.11-2012 section 10.22.4
 	 */
 	for (i = 0; i < IEEE80211_NUM_ACS; i++) {
-		txq = &sdata->tx_conf[ieee80211_ac_from_wmm(i)];
+		txq = &sdata->deflink.tx_conf[ieee80211_ac_from_wmm(i)];
 		wmm->ac[i].aci_aifsn = ieee80211_wmm_aci_aifsn(txq->aifs,
 							       txq->acm, i);
 		wmm->ac[i].cw = ieee80211_wmm_ecw(txq->cw_min, txq->cw_max);
diff --git a/net/mac80211/trace.h b/net/mac80211/trace.h
index 751f08b47d0c..b6f12ac91849 100644
--- a/net/mac80211/trace.h
+++ b/net/mac80211/trace.h
@@ -1003,13 +1003,15 @@ DEFINE_EVENT(sta_event, drv_sta_rate_tbl_update,
 TRACE_EVENT(drv_conf_tx,
 	TP_PROTO(struct ieee80211_local *local,
 		 struct ieee80211_sub_if_data *sdata,
+		 unsigned int link_id,
 		 u16 ac, const struct ieee80211_tx_queue_params *params),
 
-	TP_ARGS(local, sdata, ac, params),
+	TP_ARGS(local, sdata, link_id, ac, params),
 
 	TP_STRUCT__entry(
 		LOCAL_ENTRY
 		VIF_ENTRY
+		__field(unsigned int, link_id)
 		__field(u16, ac)
 		__field(u16, txop)
 		__field(u16, cw_min)
@@ -1021,6 +1023,7 @@ TRACE_EVENT(drv_conf_tx,
 	TP_fast_assign(
 		LOCAL_ASSIGN;
 		VIF_ASSIGN;
+		__entry->link_id = link_id;
 		__entry->ac = ac;
 		__entry->txop = params->txop;
 		__entry->cw_max = params->cw_max;
@@ -1030,8 +1033,8 @@ TRACE_EVENT(drv_conf_tx,
 	),
 
 	TP_printk(
-		LOCAL_PR_FMT  VIF_PR_FMT  " AC:%d",
-		LOCAL_PR_ARG, VIF_PR_ARG, __entry->ac
+		LOCAL_PR_FMT  VIF_PR_FMT  " link_id: %d, AC:%d",
+		LOCAL_PR_ARG, VIF_PR_ARG, __entry->link_id, __entry->ac
 	)
 );
 
diff --git a/net/mac80211/util.c b/net/mac80211/util.c
index 275310b6fc38..85d08cbe0b51 100644
--- a/net/mac80211/util.c
+++ b/net/mac80211/util.c
@@ -1593,9 +1593,10 @@ void ieee80211_regulatory_limit_wmm_params(struct ieee80211_sub_if_data *sdata,
 	rcu_read_unlock();
 }
 
-void ieee80211_set_wmm_default(struct ieee80211_sub_if_data *sdata,
+void ieee80211_set_wmm_default(struct ieee80211_link_data *link,
 			       bool bss_notify, bool enable_qos)
 {
+	struct ieee80211_sub_if_data *sdata = link->sdata;
 	struct ieee80211_local *local = sdata->local;
 	struct ieee80211_tx_queue_params qparam;
 	struct ieee80211_chanctx_conf *chanctx_conf;
@@ -1613,7 +1614,7 @@ void ieee80211_set_wmm_default(struct ieee80211_sub_if_data *sdata,
 	memset(&qparam, 0, sizeof(qparam));
 
 	rcu_read_lock();
-	chanctx_conf = rcu_dereference(sdata->vif.bss_conf.chanctx_conf);
+	chanctx_conf = rcu_dereference(link->conf->chanctx_conf);
 	use_11b = (chanctx_conf &&
 		   chanctx_conf->def.chan->band == NL80211_BAND_2GHZ) &&
 		 !(sdata->flags & IEEE80211_SDATA_OPERATING_GMODE);
@@ -1690,17 +1691,16 @@ void ieee80211_set_wmm_default(struct ieee80211_sub_if_data *sdata,
 
 		qparam.uapsd = false;
 
-		sdata->tx_conf[ac] = qparam;
-		drv_conf_tx(local, sdata, ac, &qparam);
+		link->tx_conf[ac] = qparam;
+		drv_conf_tx(local, link, ac, &qparam);
 	}
 
 	if (sdata->vif.type != NL80211_IFTYPE_MONITOR &&
 	    sdata->vif.type != NL80211_IFTYPE_P2P_DEVICE &&
 	    sdata->vif.type != NL80211_IFTYPE_NAN) {
-		sdata->vif.bss_conf.qos = enable_qos;
+		link->conf->qos = enable_qos;
 		if (bss_notify)
-			ieee80211_link_info_change_notify(sdata,
-							  &sdata->deflink,
+			ieee80211_link_info_change_notify(sdata, link,
 							  BSS_CHANGED_QOS);
 	}
 }
@@ -2517,8 +2517,8 @@ int ieee80211_reconfig(struct ieee80211_local *local)
 			fallthrough;
 		case NL80211_IFTYPE_AP: /* AP stations are handled later */
 			for (i = 0; i < IEEE80211_NUM_ACS; i++)
-				drv_conf_tx(local, sdata, i,
-					    &sdata->tx_conf[i]);
+				drv_conf_tx(local, &sdata->deflink, i,
+					    &sdata->deflink.tx_conf[i]);
 			break;
 		}
 
-- 
2.36.1

