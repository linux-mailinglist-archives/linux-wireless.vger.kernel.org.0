Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 871EB539E88
	for <lists+linux-wireless@lfdr.de>; Wed,  1 Jun 2022 09:40:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344646AbiFAHkR (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 1 Jun 2022 03:40:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350240AbiFAHkI (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 1 Jun 2022 03:40:08 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 874349344E
        for <linux-wireless@vger.kernel.org>; Wed,  1 Jun 2022 00:40:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Content-Type:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=iIVmfqCUArcjJ5tQallpm6kpcwp0hs6oUts3LN3VOLk=;
        t=1654069204; x=1655278804; b=WJ+cjT3UDgbyreR+u3QK2lt+vZFP7lfNk8Cgo630qxpplN7
        sPBttN5iBpKhP/Zoci9d2++C7knb+F6hCTTQpR59e9deyy8nwK60/sUiE86TjJdI7UwC7Qi5OwFcd
        GOzs/5D0zgcG3PSYdu3eMrYRhjbXcOkwmBwxWPhoGdLzoyG8REgG5Rey9hrThWFG4dbSVCIO3Gu5U
        xvv2kgqkCSFFSletKAF/v3eSYfrbK2SQCePD+tjocxHI5ukZ2EWXptf+Q67uJkVhrACcvrVQ1FLZJ
        PTHJLYXAidFmUDmmeisO6sMuJ8bnpGtfNdW0zyYwhMEFeTypgtlDJHI/O4beYZxA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.95)
        (envelope-from <johannes@sipsolutions.net>)
        id 1nwIxV-00AJPK-74;
        Wed, 01 Jun 2022 09:40:01 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 01/15] mac80211: split bss_info_changed method
Date:   Wed,  1 Jun 2022 09:39:44 +0200
Message-Id: <20220601093922.347d47c279fe.I15937cfe8405999084f164ddf57390f8b8d2bc61@changeid>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220601073958.8345-1-johannes@sipsolutions.net>
References: <20220601073958.8345-1-johannes@sipsolutions.net>
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

Split the bss_info_changed method to vif_cfg_changed and
link_info_changed, with the latter getting a link ID.
Also change the 'changed' parameter to u64 already, we
know we need that.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 drivers/net/wireless/admtek/adm8211.c         |   2 +-
 drivers/net/wireless/ath/ar5523/ar5523.c      |   2 +-
 drivers/net/wireless/ath/ath10k/mac.c         |   2 +-
 drivers/net/wireless/ath/ath11k/mac.c         |   2 +-
 drivers/net/wireless/ath/ath5k/mac80211-ops.c |   2 +-
 drivers/net/wireless/ath/ath9k/htc_drv_main.c |   2 +-
 drivers/net/wireless/ath/ath9k/main.c         |   2 +-
 drivers/net/wireless/ath/carl9170/main.c      |   2 +-
 drivers/net/wireless/ath/wcn36xx/main.c       |   6 +-
 drivers/net/wireless/atmel/at76c50x-usb.c     |   2 +-
 drivers/net/wireless/broadcom/b43/main.c      |   4 +-
 .../net/wireless/broadcom/b43legacy/main.c    |   2 +-
 .../broadcom/brcm80211/brcmsmac/mac80211_if.c |   2 +-
 drivers/net/wireless/intel/iwlegacy/common.c  |   7 +-
 drivers/net/wireless/intel/iwlegacy/common.h  |   2 +-
 drivers/net/wireless/intel/iwlwifi/dvm/agn.h  |   2 +-
 drivers/net/wireless/intel/iwlwifi/dvm/rxon.c |   2 +-
 .../net/wireless/intel/iwlwifi/mvm/mac80211.c |   6 +-
 drivers/net/wireless/intersil/p54/main.c      |   2 +-
 drivers/net/wireless/mac80211_hwsim.c         |   6 +-
 .../net/wireless/marvell/libertas_tf/main.c   |   2 +-
 drivers/net/wireless/marvell/mwl8k.c          |   2 +-
 .../net/wireless/mediatek/mt76/mt7603/main.c  |   2 +-
 .../net/wireless/mediatek/mt76/mt7615/main.c  |   2 +-
 drivers/net/wireless/mediatek/mt76/mt76x02.h  |   2 +-
 .../net/wireless/mediatek/mt76/mt76x02_util.c |   2 +-
 .../net/wireless/mediatek/mt76/mt7915/main.c  |   2 +-
 .../net/wireless/mediatek/mt76/mt7921/main.c  |   2 +-
 drivers/net/wireless/mediatek/mt7601u/main.c  |   2 +-
 drivers/net/wireless/purelifi/plfxlc/mac.c    |   5 +-
 drivers/net/wireless/ralink/rt2x00/rt2x00.h   |   2 +-
 .../net/wireless/ralink/rt2x00/rt2x00mac.c    |   2 +-
 .../wireless/realtek/rtl818x/rtl8180/dev.c    |   2 +-
 .../wireless/realtek/rtl818x/rtl8187/dev.c    |   2 +-
 .../wireless/realtek/rtl8xxxu/rtl8xxxu_core.c |   2 +-
 drivers/net/wireless/realtek/rtlwifi/core.c   |   2 +-
 drivers/net/wireless/realtek/rtw88/mac80211.c |   2 +-
 drivers/net/wireless/realtek/rtw89/mac80211.c |   2 +-
 drivers/net/wireless/rsi/rsi_91x_mac80211.c   |   2 +-
 drivers/net/wireless/silabs/wfx/sta.c         |   2 +-
 drivers/net/wireless/silabs/wfx/sta.h         |   2 +-
 drivers/net/wireless/st/cw1200/sta.c          |   4 +-
 drivers/net/wireless/st/cw1200/sta.h          |   2 +-
 drivers/net/wireless/ti/wl1251/main.c         |   2 +-
 drivers/net/wireless/ti/wlcore/main.c         |   2 +-
 drivers/net/wireless/zydas/zd1211rw/zd_mac.c  |   4 +-
 drivers/staging/vt6655/device_main.c          |   2 +-
 drivers/staging/vt6656/main_usb.c             |   2 +-
 include/net/mac80211.h                        |  28 +++-
 net/mac80211/cfg.c                            |  31 ++--
 net/mac80211/chan.c                           |   9 +-
 net/mac80211/driver-ops.h                     |  35 ++++-
 net/mac80211/ibss.c                           |   2 +-
 net/mac80211/ieee80211_i.h                    |   6 +-
 net/mac80211/iface.c                          |   5 +-
 net/mac80211/main.c                           |  80 +++++++++-
 net/mac80211/mesh.c                           |   6 +-
 net/mac80211/mlme.c                           |  16 +-
 net/mac80211/offchannel.c                     |   8 +-
 net/mac80211/sta_info.c                       |   2 +-
 net/mac80211/tdls.c                           |   2 +-
 net/mac80211/trace.h                          | 138 +++++++++++-------
 net/mac80211/util.c                           |   4 +-
 net/mac80211/vht.c                            |   2 +-
 64 files changed, 324 insertions(+), 172 deletions(-)

diff --git a/drivers/net/wireless/admtek/adm8211.c b/drivers/net/wireless/admtek/adm8211.c
index 2db9c948c0fc..6bee16b207d1 100644
--- a/drivers/net/wireless/admtek/adm8211.c
+++ b/drivers/net/wireless/admtek/adm8211.c
@@ -1311,7 +1311,7 @@ static int adm8211_config(struct ieee80211_hw *dev, u32 changed)
 static void adm8211_bss_info_changed(struct ieee80211_hw *dev,
 				     struct ieee80211_vif *vif,
 				     struct ieee80211_bss_conf *conf,
-				     u32 changes)
+				     u64 changes)
 {
 	struct adm8211_priv *priv = dev->priv;
 
diff --git a/drivers/net/wireless/ath/ar5523/ar5523.c b/drivers/net/wireless/ath/ar5523/ar5523.c
index 4cd06a0942d4..6f937d2cc126 100644
--- a/drivers/net/wireless/ath/ar5523/ar5523.c
+++ b/drivers/net/wireless/ath/ar5523/ar5523.c
@@ -1273,7 +1273,7 @@ static int ar5523_write_associd(struct ar5523 *ar, struct ieee80211_vif *vif)
 static void ar5523_bss_info_changed(struct ieee80211_hw *hw,
 				    struct ieee80211_vif *vif,
 				    struct ieee80211_bss_conf *bss,
-				    u32 changed)
+				    u64 changed)
 {
 	struct ar5523 *ar = hw->priv;
 	int error;
diff --git a/drivers/net/wireless/ath/ath10k/mac.c b/drivers/net/wireless/ath/ath10k/mac.c
index 409777a15dcb..bc0135868792 100644
--- a/drivers/net/wireless/ath/ath10k/mac.c
+++ b/drivers/net/wireless/ath/ath10k/mac.c
@@ -6034,7 +6034,7 @@ static void ath10k_recalculate_mgmt_rate(struct ath10k *ar,
 static void ath10k_bss_info_changed(struct ieee80211_hw *hw,
 				    struct ieee80211_vif *vif,
 				    struct ieee80211_bss_conf *info,
-				    u32 changed)
+				    u64 changed)
 {
 	struct ath10k *ar = hw->priv;
 	struct ath10k_vif *arvif = (void *)vif->drv_priv;
diff --git a/drivers/net/wireless/ath/ath11k/mac.c b/drivers/net/wireless/ath/ath11k/mac.c
index 7ec0df2fc107..be102357317b 100644
--- a/drivers/net/wireless/ath/ath11k/mac.c
+++ b/drivers/net/wireless/ath/ath11k/mac.c
@@ -3091,7 +3091,7 @@ static int ath11k_mac_config_obss_pd(struct ath11k *ar,
 static void ath11k_mac_op_bss_info_changed(struct ieee80211_hw *hw,
 					   struct ieee80211_vif *vif,
 					   struct ieee80211_bss_conf *info,
-					   u32 changed)
+					   u64 changed)
 {
 	struct ath11k *ar = hw->priv;
 	struct ath11k_vif *arvif = ath11k_vif_to_arvif(vif);
diff --git a/drivers/net/wireless/ath/ath5k/mac80211-ops.c b/drivers/net/wireless/ath/ath5k/mac80211-ops.c
index 0df0fa1da181..8da232e81518 100644
--- a/drivers/net/wireless/ath/ath5k/mac80211-ops.c
+++ b/drivers/net/wireless/ath/ath5k/mac80211-ops.c
@@ -250,7 +250,7 @@ ath5k_config(struct ieee80211_hw *hw, u32 changed)
 
 static void
 ath5k_bss_info_changed(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
-		       struct ieee80211_bss_conf *bss_conf, u32 changes)
+		       struct ieee80211_bss_conf *bss_conf, u64 changes)
 {
 	struct ath5k_vif *avf = (void *)vif->drv_priv;
 	struct ath5k_hw *ah = hw->priv;
diff --git a/drivers/net/wireless/ath/ath9k/htc_drv_main.c b/drivers/net/wireless/ath/ath9k/htc_drv_main.c
index 3a5ec4da6a38..14d713e03872 100644
--- a/drivers/net/wireless/ath/ath9k/htc_drv_main.c
+++ b/drivers/net/wireless/ath/ath9k/htc_drv_main.c
@@ -1509,7 +1509,7 @@ static void ath9k_htc_choose_set_bssid(struct ath9k_htc_priv *priv)
 static void ath9k_htc_bss_info_changed(struct ieee80211_hw *hw,
 				       struct ieee80211_vif *vif,
 				       struct ieee80211_bss_conf *bss_conf,
-				       u32 changed)
+				       u64 changed)
 {
 	struct ath9k_htc_priv *priv = hw->priv;
 	struct ath_hw *ah = priv->ah;
diff --git a/drivers/net/wireless/ath/ath9k/main.c b/drivers/net/wireless/ath/ath9k/main.c
index 56c2681e5192..729f8ee9644d 100644
--- a/drivers/net/wireless/ath/ath9k/main.c
+++ b/drivers/net/wireless/ath/ath9k/main.c
@@ -1863,7 +1863,7 @@ static int ath9k_set_key(struct ieee80211_hw *hw,
 static void ath9k_bss_info_changed(struct ieee80211_hw *hw,
 				   struct ieee80211_vif *vif,
 				   struct ieee80211_bss_conf *bss_conf,
-				   u32 changed)
+				   u64 changed)
 {
 #define CHECK_ANI				\
 	(BSS_CHANGED_ASSOC |			\
diff --git a/drivers/net/wireless/ath/carl9170/main.c b/drivers/net/wireless/ath/carl9170/main.c
index e28a5f3085c0..3d881028bd00 100644
--- a/drivers/net/wireless/ath/carl9170/main.c
+++ b/drivers/net/wireless/ath/carl9170/main.c
@@ -1032,7 +1032,7 @@ static void carl9170_op_configure_filter(struct ieee80211_hw *hw,
 static void carl9170_op_bss_info_changed(struct ieee80211_hw *hw,
 					 struct ieee80211_vif *vif,
 					 struct ieee80211_bss_conf *bss_conf,
-					 u32 changed)
+					 u64 changed)
 {
 	struct ar9170 *ar = hw->priv;
 	struct ath_common *common = &ar->common;
diff --git a/drivers/net/wireless/ath/wcn36xx/main.c b/drivers/net/wireless/ath/wcn36xx/main.c
index 72ba2e2fc93a..5f5006ac4ba8 100644
--- a/drivers/net/wireless/ath/wcn36xx/main.c
+++ b/drivers/net/wireless/ath/wcn36xx/main.c
@@ -872,7 +872,7 @@ void wcn36xx_set_default_rates_v1(struct wcn36xx_hal_supported_rates_v1 *rates)
 static void wcn36xx_bss_info_changed(struct ieee80211_hw *hw,
 				     struct ieee80211_vif *vif,
 				     struct ieee80211_bss_conf *bss_conf,
-				     u32 changed)
+				     u64 changed)
 {
 	struct wcn36xx *wcn = hw->priv;
 	struct sk_buff *skb = NULL;
@@ -880,8 +880,8 @@ static void wcn36xx_bss_info_changed(struct ieee80211_hw *hw,
 	enum wcn36xx_hal_link_state link_state;
 	struct wcn36xx_vif *vif_priv = wcn36xx_vif_to_priv(vif);
 
-	wcn36xx_dbg(WCN36XX_DBG_MAC, "mac bss info changed vif %p changed 0x%08x\n",
-		    vif, changed);
+	wcn36xx_dbg(WCN36XX_DBG_MAC, "mac bss info changed vif %p changed 0x%llx\n",
+		    vif, (unsigned long long)changed);
 
 	mutex_lock(&wcn->conf_mutex);
 
diff --git a/drivers/net/wireless/atmel/at76c50x-usb.c b/drivers/net/wireless/atmel/at76c50x-usb.c
index 7582761c61e2..24e609c1f523 100644
--- a/drivers/net/wireless/atmel/at76c50x-usb.c
+++ b/drivers/net/wireless/atmel/at76c50x-usb.c
@@ -2033,7 +2033,7 @@ static int at76_config(struct ieee80211_hw *hw, u32 changed)
 static void at76_bss_info_changed(struct ieee80211_hw *hw,
 				  struct ieee80211_vif *vif,
 				  struct ieee80211_bss_conf *conf,
-				  u32 changed)
+				  u64 changed)
 {
 	struct at76_priv *priv = hw->priv;
 
diff --git a/drivers/net/wireless/broadcom/b43/main.c b/drivers/net/wireless/broadcom/b43/main.c
index 17bcec5f3ff7..e3121a9d0579 100644
--- a/drivers/net/wireless/broadcom/b43/main.c
+++ b/drivers/net/wireless/broadcom/b43/main.c
@@ -366,7 +366,7 @@ static int b43_wireless_core_start(struct b43_wldev *dev);
 static void b43_op_bss_info_changed(struct ieee80211_hw *hw,
 				    struct ieee80211_vif *vif,
 				    struct ieee80211_bss_conf *conf,
-				    u32 changed);
+				    u64 changed);
 
 static int b43_ratelimit(struct b43_wl *wl)
 {
@@ -4097,7 +4097,7 @@ static void b43_update_basic_rates(struct b43_wldev *dev, u32 brates)
 static void b43_op_bss_info_changed(struct ieee80211_hw *hw,
 				    struct ieee80211_vif *vif,
 				    struct ieee80211_bss_conf *conf,
-				    u32 changed)
+				    u64 changed)
 {
 	struct b43_wl *wl = hw_to_b43_wl(hw);
 	struct b43_wldev *dev;
diff --git a/drivers/net/wireless/broadcom/b43legacy/main.c b/drivers/net/wireless/broadcom/b43legacy/main.c
index eec3af9c3745..96d5a034c09b 100644
--- a/drivers/net/wireless/broadcom/b43legacy/main.c
+++ b/drivers/net/wireless/broadcom/b43legacy/main.c
@@ -2806,7 +2806,7 @@ static void b43legacy_update_basic_rates(struct b43legacy_wldev *dev, u32 brates
 static void b43legacy_op_bss_info_changed(struct ieee80211_hw *hw,
 				    struct ieee80211_vif *vif,
 				    struct ieee80211_bss_conf *conf,
-				    u32 changed)
+				    u64 changed)
 {
 	struct b43legacy_wl *wl = hw_to_b43legacy_wl(hw);
 	struct b43legacy_wldev *dev;
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmsmac/mac80211_if.c b/drivers/net/wireless/broadcom/brcm80211/brcmsmac/mac80211_if.c
index e6cd638a85d6..fd3c131c622c 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmsmac/mac80211_if.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmsmac/mac80211_if.c
@@ -582,7 +582,7 @@ static int brcms_ops_config(struct ieee80211_hw *hw, u32 changed)
 static void
 brcms_ops_bss_info_changed(struct ieee80211_hw *hw,
 			struct ieee80211_vif *vif,
-			struct ieee80211_bss_conf *info, u32 changed)
+			struct ieee80211_bss_conf *info, u64 changed)
 {
 	struct brcms_info *wl = hw->priv;
 	struct bcma_device *core = wl->wlc->hw->d11core;
diff --git a/drivers/net/wireless/intel/iwlegacy/common.c b/drivers/net/wireless/intel/iwlegacy/common.c
index b01945415be6..6975f0297f03 100644
--- a/drivers/net/wireless/intel/iwlegacy/common.c
+++ b/drivers/net/wireless/intel/iwlegacy/common.c
@@ -5311,13 +5311,13 @@ il_beacon_update(struct ieee80211_hw *hw, struct ieee80211_vif *vif)
 
 void
 il_mac_bss_info_changed(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
-			struct ieee80211_bss_conf *bss_conf, u32 changes)
+			struct ieee80211_bss_conf *bss_conf, u64 changes)
 {
 	struct il_priv *il = hw->priv;
 	int ret;
 
 	mutex_lock(&il->mutex);
-	D_MAC80211("enter: changes 0x%x\n", changes);
+	D_MAC80211("enter: changes 0x%llx\n", (unsigned long long)changes);
 
 	if (!il_is_alive(il)) {
 		D_MAC80211("leave - not alive\n");
@@ -5438,7 +5438,8 @@ il_mac_bss_info_changed(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 	}
 
 	if (changes && il_is_associated(il) && vif->cfg.aid) {
-		D_MAC80211("Changes (%#x) while associated\n", changes);
+		D_MAC80211("Changes (%#llx) while associated\n",
+			   (unsigned long long)changes);
 		ret = il_send_rxon_assoc(il);
 		if (!ret) {
 			/* Sync active_rxon with latest change. */
diff --git a/drivers/net/wireless/intel/iwlegacy/common.h b/drivers/net/wireless/intel/iwlegacy/common.h
index 40877ef1fbf2..d1383b4f0f05 100644
--- a/drivers/net/wireless/intel/iwlegacy/common.h
+++ b/drivers/net/wireless/intel/iwlegacy/common.h
@@ -1947,7 +1947,7 @@ il_get_hw_mode(struct il_priv *il, enum nl80211_band band)
 int il_mac_config(struct ieee80211_hw *hw, u32 changed);
 void il_mac_reset_tsf(struct ieee80211_hw *hw, struct ieee80211_vif *vif);
 void il_mac_bss_info_changed(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
-			     struct ieee80211_bss_conf *bss_conf, u32 changes);
+			     struct ieee80211_bss_conf *bss_conf, u64 changes);
 void il_tx_cmd_protection(struct il_priv *il, struct ieee80211_tx_info *info,
 			  __le16 fc, __le32 *tx_flags);
 
diff --git a/drivers/net/wireless/intel/iwlwifi/dvm/agn.h b/drivers/net/wireless/intel/iwlwifi/dvm/agn.h
index abb8696ba294..411a6f6638b4 100644
--- a/drivers/net/wireless/intel/iwlwifi/dvm/agn.h
+++ b/drivers/net/wireless/intel/iwlwifi/dvm/agn.h
@@ -92,7 +92,7 @@ int iwlagn_mac_config(struct ieee80211_hw *hw, u32 changed);
 void iwlagn_bss_info_changed(struct ieee80211_hw *hw,
 			     struct ieee80211_vif *vif,
 			     struct ieee80211_bss_conf *bss_conf,
-			     u32 changes);
+			     u64 changes);
 void iwlagn_config_ht40(struct ieee80211_conf *conf,
 			struct iwl_rxon_context *ctx);
 void iwl_set_rxon_ht(struct iwl_priv *priv, struct iwl_ht_config *ht_conf);
diff --git a/drivers/net/wireless/intel/iwlwifi/dvm/rxon.c b/drivers/net/wireless/intel/iwlwifi/dvm/rxon.c
index 17a14970edec..45e382fe45a2 100644
--- a/drivers/net/wireless/intel/iwlwifi/dvm/rxon.c
+++ b/drivers/net/wireless/intel/iwlwifi/dvm/rxon.c
@@ -1383,7 +1383,7 @@ static void iwlagn_chain_noise_reset(struct iwl_priv *priv)
 void iwlagn_bss_info_changed(struct ieee80211_hw *hw,
 			     struct ieee80211_vif *vif,
 			     struct ieee80211_bss_conf *bss_conf,
-			     u32 changes)
+			     u64 changes)
 {
 	struct iwl_priv *priv = IWL_MAC80211_GET_DVM(hw);
 	struct iwl_rxon_context *ctx = iwl_rxon_ctx_from_vif(vif);
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
index b5257b4fd000..586208506275 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
@@ -2181,7 +2181,7 @@ static void iwl_mvm_protect_assoc(struct iwl_mvm *mvm,
 static void iwl_mvm_bss_info_changed_station(struct iwl_mvm *mvm,
 					     struct ieee80211_vif *vif,
 					     struct ieee80211_bss_conf *bss_conf,
-					     u32 changes)
+					     u64 changes)
 {
 	struct iwl_mvm_vif *mvmvif = iwl_mvm_vif_from_mac80211(vif);
 	int ret;
@@ -2590,7 +2590,7 @@ static void
 iwl_mvm_bss_info_changed_ap_ibss(struct iwl_mvm *mvm,
 				 struct ieee80211_vif *vif,
 				 struct ieee80211_bss_conf *bss_conf,
-				 u32 changes)
+				 u64 changes)
 {
 	struct iwl_mvm_vif *mvmvif = iwl_mvm_vif_from_mac80211(vif);
 
@@ -2621,7 +2621,7 @@ iwl_mvm_bss_info_changed_ap_ibss(struct iwl_mvm *mvm,
 static void iwl_mvm_bss_info_changed(struct ieee80211_hw *hw,
 				     struct ieee80211_vif *vif,
 				     struct ieee80211_bss_conf *bss_conf,
-				     u32 changes)
+				     u64 changes)
 {
 	struct iwl_mvm *mvm = IWL_MAC80211_GET_MVM(hw);
 
diff --git a/drivers/net/wireless/intersil/p54/main.c b/drivers/net/wireless/intersil/p54/main.c
index a9dfe6a3da0d..cc6769a4fec7 100644
--- a/drivers/net/wireless/intersil/p54/main.c
+++ b/drivers/net/wireless/intersil/p54/main.c
@@ -449,7 +449,7 @@ static int p54_get_stats(struct ieee80211_hw *dev,
 static void p54_bss_info_changed(struct ieee80211_hw *dev,
 				 struct ieee80211_vif *vif,
 				 struct ieee80211_bss_conf *info,
-				 u32 changed)
+				 u64 changed)
 {
 	struct p54_common *priv = dev->priv;
 
diff --git a/drivers/net/wireless/mac80211_hwsim.c b/drivers/net/wireless/mac80211_hwsim.c
index b034d34745ab..1bd96b504956 100644
--- a/drivers/net/wireless/mac80211_hwsim.c
+++ b/drivers/net/wireless/mac80211_hwsim.c
@@ -2101,15 +2101,15 @@ static void mac80211_hwsim_bcn_en_iter(void *data, u8 *mac,
 static void mac80211_hwsim_bss_info_changed(struct ieee80211_hw *hw,
 					    struct ieee80211_vif *vif,
 					    struct ieee80211_bss_conf *info,
-					    u32 changed)
+					    u64 changed)
 {
 	struct hwsim_vif_priv *vp = (void *)vif->drv_priv;
 	struct mac80211_hwsim_data *data = hw->priv;
 
 	hwsim_check_magic(vif);
 
-	wiphy_dbg(hw->wiphy, "%s(changed=0x%x vif->addr=%pM)\n",
-		  __func__, changed, vif->addr);
+	wiphy_dbg(hw->wiphy, "%s(changed=0x%llx vif->addr=%pM)\n",
+		  __func__, (unsigned long long)changed, vif->addr);
 
 	if (changed & BSS_CHANGED_BSSID) {
 		wiphy_dbg(hw->wiphy, "%s: BSSID changed: %pM\n",
diff --git a/drivers/net/wireless/marvell/libertas_tf/main.c b/drivers/net/wireless/marvell/libertas_tf/main.c
index 02a1e1f547d8..21c3e0bdc444 100644
--- a/drivers/net/wireless/marvell/libertas_tf/main.c
+++ b/drivers/net/wireless/marvell/libertas_tf/main.c
@@ -417,7 +417,7 @@ static void lbtf_op_configure_filter(struct ieee80211_hw *hw,
 static void lbtf_op_bss_info_changed(struct ieee80211_hw *hw,
 			struct ieee80211_vif *vif,
 			struct ieee80211_bss_conf *bss_conf,
-			u32 changes)
+			u64 changes)
 {
 	struct lbtf_private *priv = hw->priv;
 	struct sk_buff *beacon;
diff --git a/drivers/net/wireless/marvell/mwl8k.c b/drivers/net/wireless/marvell/mwl8k.c
index 5f1bcfb5e3f6..7eef3a74d124 100644
--- a/drivers/net/wireless/marvell/mwl8k.c
+++ b/drivers/net/wireless/marvell/mwl8k.c
@@ -5163,7 +5163,7 @@ mwl8k_bss_info_changed_ap(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 
 static void
 mwl8k_bss_info_changed(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
-		       struct ieee80211_bss_conf *info, u32 changed)
+		       struct ieee80211_bss_conf *info, u64 changed)
 {
 	if (vif->type == NL80211_IFTYPE_STATION)
 		mwl8k_bss_info_changed_sta(hw, vif, info, changed);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7603/main.c b/drivers/net/wireless/mediatek/mt76/mt7603/main.c
index 1f14ecda1f55..088c0a4cf774 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7603/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7603/main.c
@@ -297,7 +297,7 @@ mt7603_configure_filter(struct ieee80211_hw *hw, unsigned int changed_flags,
 
 static void
 mt7603_bss_info_changed(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
-			struct ieee80211_bss_conf *info, u32 changed)
+			struct ieee80211_bss_conf *info, u64 changed)
 {
 	struct mt7603_dev *dev = hw->priv;
 	struct mt7603_vif *mvif = (struct mt7603_vif *)vif->drv_priv;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/main.c b/drivers/net/wireless/mediatek/mt76/mt7615/main.c
index d992fdea0f32..277c22a4d049 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/main.c
@@ -576,7 +576,7 @@ static void mt7615_configure_filter(struct ieee80211_hw *hw,
 static void mt7615_bss_info_changed(struct ieee80211_hw *hw,
 				    struct ieee80211_vif *vif,
 				    struct ieee80211_bss_conf *info,
-				    u32 changed)
+				    u64 changed)
 {
 	struct mt7615_dev *dev = mt7615_hw_dev(hw);
 	struct mt7615_phy *phy = mt7615_hw_phy(hw);
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x02.h b/drivers/net/wireless/mediatek/mt76/mt76x02.h
index f76fd22ee035..74ad418f5a70 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x02.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76x02.h
@@ -187,7 +187,7 @@ void mt76x02_sw_scan_complete(struct ieee80211_hw *hw,
 void mt76x02_sta_ps(struct mt76_dev *dev, struct ieee80211_sta *sta, bool ps);
 void mt76x02_bss_info_changed(struct ieee80211_hw *hw,
 			      struct ieee80211_vif *vif,
-			      struct ieee80211_bss_conf *info, u32 changed);
+			      struct ieee80211_bss_conf *info, u64 changed);
 void mt76x02_reconfig_complete(struct ieee80211_hw *hw,
 			       enum ieee80211_reconfig_type reconfig_type);
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x02_util.c b/drivers/net/wireless/mediatek/mt76/mt76x02_util.c
index 5bd0a0bae688..a0e2d042751b 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x02_util.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x02_util.c
@@ -636,7 +636,7 @@ EXPORT_SYMBOL_GPL(mt76x02_sta_ps);
 void mt76x02_bss_info_changed(struct ieee80211_hw *hw,
 			      struct ieee80211_vif *vif,
 			      struct ieee80211_bss_conf *info,
-			      u32 changed)
+			      u64 changed)
 {
 	struct mt76x02_vif *mvif = (struct mt76x02_vif *)vif->drv_priv;
 	struct mt76x02_dev *dev = hw->priv;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/main.c b/drivers/net/wireless/mediatek/mt76/mt7915/main.c
index 05327b0b6fc3..fbeac9aa2af6 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/main.c
@@ -573,7 +573,7 @@ mt7915_update_bss_color(struct ieee80211_hw *hw,
 static void mt7915_bss_info_changed(struct ieee80211_hw *hw,
 				    struct ieee80211_vif *vif,
 				    struct ieee80211_bss_conf *info,
-				    u32 changed)
+				    u64 changed)
 {
 	struct mt7915_phy *phy = mt7915_hw_phy(hw);
 	struct mt7915_dev *dev = mt7915_hw_dev(hw);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/main.c b/drivers/net/wireless/mediatek/mt76/mt7921/main.c
index 8532033794bd..63583605d1cd 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/main.c
@@ -637,7 +637,7 @@ static void mt7921_configure_filter(struct ieee80211_hw *hw,
 static void mt7921_bss_info_changed(struct ieee80211_hw *hw,
 				    struct ieee80211_vif *vif,
 				    struct ieee80211_bss_conf *info,
-				    u32 changed)
+				    u64 changed)
 {
 	struct mt7921_phy *phy = mt7921_hw_phy(hw);
 	struct mt7921_dev *dev = mt7921_hw_dev(hw);
diff --git a/drivers/net/wireless/mediatek/mt7601u/main.c b/drivers/net/wireless/mediatek/mt7601u/main.c
index 671d8897ae76..6c9c7a61c5c9 100644
--- a/drivers/net/wireless/mediatek/mt7601u/main.c
+++ b/drivers/net/wireless/mediatek/mt7601u/main.c
@@ -132,7 +132,7 @@ mt76_configure_filter(struct ieee80211_hw *hw, unsigned int changed_flags,
 
 static void
 mt7601u_bss_info_changed(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
-			 struct ieee80211_bss_conf *info, u32 changed)
+			 struct ieee80211_bss_conf *info, u64 changed)
 {
 	struct mt7601u_dev *dev = hw->priv;
 
diff --git a/drivers/net/wireless/purelifi/plfxlc/mac.c b/drivers/net/wireless/purelifi/plfxlc/mac.c
index 90e552532701..b546a963b0a3 100644
--- a/drivers/net/wireless/purelifi/plfxlc/mac.c
+++ b/drivers/net/wireless/purelifi/plfxlc/mac.c
@@ -587,12 +587,13 @@ static void plfxlc_op_configure_filter(struct ieee80211_hw *hw,
 static void plfxlc_op_bss_info_changed(struct ieee80211_hw *hw,
 				       struct ieee80211_vif *vif,
 				       struct ieee80211_bss_conf *bss_conf,
-				       u32 changes)
+				       u64 changes)
 {
 	struct plfxlc_mac *mac = plfxlc_hw_mac(hw);
 	int associated;
 
-	dev_dbg(plfxlc_mac_dev(mac), "changes: %x\n", changes);
+	dev_dbg(plfxlc_mac_dev(mac), "changes: %llx\n",
+		(unsigned long long)changes);
 
 	if (mac->type != NL80211_IFTYPE_ADHOC) { /* for STATION */
 		associated = is_valid_ether_addr(bss_conf->bssid);
diff --git a/drivers/net/wireless/ralink/rt2x00/rt2x00.h b/drivers/net/wireless/ralink/rt2x00/rt2x00.h
index 9f6fc40649be..918e0477bb7d 100644
--- a/drivers/net/wireless/ralink/rt2x00/rt2x00.h
+++ b/drivers/net/wireless/ralink/rt2x00/rt2x00.h
@@ -1479,7 +1479,7 @@ int rt2x00mac_get_stats(struct ieee80211_hw *hw,
 void rt2x00mac_bss_info_changed(struct ieee80211_hw *hw,
 				struct ieee80211_vif *vif,
 				struct ieee80211_bss_conf *bss_conf,
-				u32 changes);
+				u64 changes);
 int rt2x00mac_conf_tx(struct ieee80211_hw *hw,
 		      struct ieee80211_vif *vif, u16 queue,
 		      const struct ieee80211_tx_queue_params *params);
diff --git a/drivers/net/wireless/ralink/rt2x00/rt2x00mac.c b/drivers/net/wireless/ralink/rt2x00/rt2x00mac.c
index 660554a01894..6205d22765c7 100644
--- a/drivers/net/wireless/ralink/rt2x00/rt2x00mac.c
+++ b/drivers/net/wireless/ralink/rt2x00/rt2x00mac.c
@@ -574,7 +574,7 @@ EXPORT_SYMBOL_GPL(rt2x00mac_get_stats);
 void rt2x00mac_bss_info_changed(struct ieee80211_hw *hw,
 				struct ieee80211_vif *vif,
 				struct ieee80211_bss_conf *bss_conf,
-				u32 changes)
+				u64 changes)
 {
 	struct rt2x00_dev *rt2x00dev = hw->priv;
 	struct rt2x00_intf *intf = vif_to_intf(vif);
diff --git a/drivers/net/wireless/realtek/rtl818x/rtl8180/dev.c b/drivers/net/wireless/realtek/rtl818x/rtl8180/dev.c
index 025619cd14e8..10e8fdc31879 100644
--- a/drivers/net/wireless/realtek/rtl818x/rtl8180/dev.c
+++ b/drivers/net/wireless/realtek/rtl818x/rtl8180/dev.c
@@ -1500,7 +1500,7 @@ static void rtl8180_conf_erp(struct ieee80211_hw *dev,
 static void rtl8180_bss_info_changed(struct ieee80211_hw *dev,
 				     struct ieee80211_vif *vif,
 				     struct ieee80211_bss_conf *info,
-				     u32 changed)
+				     u64 changed)
 {
 	struct rtl8180_priv *priv = dev->priv;
 	struct rtl8180_vif *vif_priv;
diff --git a/drivers/net/wireless/realtek/rtl818x/rtl8187/dev.c b/drivers/net/wireless/realtek/rtl818x/rtl8187/dev.c
index eb68b2d3caa1..8ab65c888baf 100644
--- a/drivers/net/wireless/realtek/rtl818x/rtl8187/dev.c
+++ b/drivers/net/wireless/realtek/rtl818x/rtl8187/dev.c
@@ -1251,7 +1251,7 @@ static void rtl8187_conf_erp(struct rtl8187_priv *priv, bool use_short_slot,
 static void rtl8187_bss_info_changed(struct ieee80211_hw *dev,
 				     struct ieee80211_vif *vif,
 				     struct ieee80211_bss_conf *info,
-				     u32 changed)
+				     u64 changed)
 {
 	struct rtl8187_priv *priv = dev->priv;
 	struct rtl8187_vif *vif_priv;
diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
index 0239e12ec8a5..65c4cb1e030c 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
+++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
@@ -4558,7 +4558,7 @@ rtl8xxxu_wireless_mode(struct ieee80211_hw *hw, struct ieee80211_sta *sta)
 
 static void
 rtl8xxxu_bss_info_changed(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
-			  struct ieee80211_bss_conf *bss_conf, u32 changed)
+			  struct ieee80211_bss_conf *bss_conf, u64 changed)
 {
 	struct rtl8xxxu_priv *priv = hw->priv;
 	struct device *dev = &priv->udev->dev;
diff --git a/drivers/net/wireless/realtek/rtlwifi/core.c b/drivers/net/wireless/realtek/rtlwifi/core.c
index 5177eb02740e..2f7fd8888d3a 100644
--- a/drivers/net/wireless/realtek/rtlwifi/core.c
+++ b/drivers/net/wireless/realtek/rtlwifi/core.c
@@ -1040,7 +1040,7 @@ EXPORT_SYMBOL_GPL(rtl_update_beacon_work_callback);
 static void rtl_op_bss_info_changed(struct ieee80211_hw *hw,
 				    struct ieee80211_vif *vif,
 				    struct ieee80211_bss_conf *bss_conf,
-				    u32 changed)
+				    u64 changed)
 {
 	struct rtl_priv *rtlpriv = rtl_priv(hw);
 	struct rtl_hal *rtlhal = rtl_hal(rtlpriv);
diff --git a/drivers/net/wireless/realtek/rtw88/mac80211.c b/drivers/net/wireless/realtek/rtw88/mac80211.c
index 52e2c93d02f0..3ef839035bcf 100644
--- a/drivers/net/wireless/realtek/rtw88/mac80211.c
+++ b/drivers/net/wireless/realtek/rtw88/mac80211.c
@@ -355,7 +355,7 @@ static void rtw_conf_tx(struct rtw_dev *rtwdev,
 static void rtw_ops_bss_info_changed(struct ieee80211_hw *hw,
 				     struct ieee80211_vif *vif,
 				     struct ieee80211_bss_conf *conf,
-				     u32 changed)
+				     u64 changed)
 {
 	struct rtw_dev *rtwdev = hw->priv;
 	struct rtw_vif *rtwvif = (struct rtw_vif *)vif->drv_priv;
diff --git a/drivers/net/wireless/realtek/rtw89/mac80211.c b/drivers/net/wireless/realtek/rtw89/mac80211.c
index 6fc125deba28..4cbd2615c636 100644
--- a/drivers/net/wireless/realtek/rtw89/mac80211.c
+++ b/drivers/net/wireless/realtek/rtw89/mac80211.c
@@ -336,7 +336,7 @@ static void rtw89_station_mode_sta_assoc(struct rtw89_dev *rtwdev,
 static void rtw89_ops_bss_info_changed(struct ieee80211_hw *hw,
 				       struct ieee80211_vif *vif,
 				       struct ieee80211_bss_conf *conf,
-				       u32 changed)
+				       u64 changed)
 {
 	struct rtw89_dev *rtwdev = hw->priv;
 	struct rtw89_vif *rtwvif = (struct rtw89_vif *)vif->drv_priv;
diff --git a/drivers/net/wireless/rsi/rsi_91x_mac80211.c b/drivers/net/wireless/rsi/rsi_91x_mac80211.c
index d4b3834388ab..1dff3d263382 100644
--- a/drivers/net/wireless/rsi/rsi_91x_mac80211.c
+++ b/drivers/net/wireless/rsi/rsi_91x_mac80211.c
@@ -783,7 +783,7 @@ static void rsi_switch_channel(struct rsi_hw *adapter,
 static void rsi_mac80211_bss_info_changed(struct ieee80211_hw *hw,
 					  struct ieee80211_vif *vif,
 					  struct ieee80211_bss_conf *bss_conf,
-					  u32 changed)
+					  u64 changed)
 {
 	struct rsi_hw *adapter = hw->priv;
 	struct rsi_common *common = adapter->priv;
diff --git a/drivers/net/wireless/silabs/wfx/sta.c b/drivers/net/wireless/silabs/wfx/sta.c
index 3fc55c0c0b4d..6fb4ba1282c9 100644
--- a/drivers/net/wireless/silabs/wfx/sta.c
+++ b/drivers/net/wireless/silabs/wfx/sta.c
@@ -506,7 +506,7 @@ static void wfx_enable_beacon(struct wfx_vif *wvif, bool enable)
 }
 
 void wfx_bss_info_changed(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
-			  struct ieee80211_bss_conf *info, u32 changed)
+			  struct ieee80211_bss_conf *info, u64 changed)
 {
 	struct wfx_dev *wdev = hw->priv;
 	struct wfx_vif *wvif = (struct wfx_vif *)vif->drv_priv;
diff --git a/drivers/net/wireless/silabs/wfx/sta.h b/drivers/net/wireless/silabs/wfx/sta.h
index c69b2227e9ac..d9c6bd632b20 100644
--- a/drivers/net/wireless/silabs/wfx/sta.h
+++ b/drivers/net/wireless/silabs/wfx/sta.h
@@ -36,7 +36,7 @@ void wfx_leave_ibss(struct ieee80211_hw *hw, struct ieee80211_vif *vif);
 int wfx_conf_tx(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 		u16 queue, const struct ieee80211_tx_queue_params *params);
 void wfx_bss_info_changed(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
-			  struct ieee80211_bss_conf *info, u32 changed);
+			  struct ieee80211_bss_conf *info, u64 changed);
 int wfx_sta_add(struct ieee80211_hw *hw, struct ieee80211_vif *vif, struct ieee80211_sta *sta);
 int wfx_sta_remove(struct ieee80211_hw *hw, struct ieee80211_vif *vif, struct ieee80211_sta *sta);
 void wfx_sta_notify(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
diff --git a/drivers/net/wireless/st/cw1200/sta.c b/drivers/net/wireless/st/cw1200/sta.c
index 3f48def51ebc..8eaeb39217ee 100644
--- a/drivers/net/wireless/st/cw1200/sta.c
+++ b/drivers/net/wireless/st/cw1200/sta.c
@@ -1796,14 +1796,14 @@ static int cw1200_set_btcoexinfo(struct cw1200_common *priv)
 void cw1200_bss_info_changed(struct ieee80211_hw *dev,
 			     struct ieee80211_vif *vif,
 			     struct ieee80211_bss_conf *info,
-			     u32 changed)
+			     u64 changed)
 {
 	struct cw1200_common *priv = dev->priv;
 	bool do_join = false;
 
 	mutex_lock(&priv->conf_mutex);
 
-	pr_debug("BSS CHANGED:  %08x\n", changed);
+	pr_debug("BSS CHANGED:  %llx\n", (unsigned long long)changed);
 
 	/* TODO: BSS_CHANGED_QOS */
 	/* TODO: BSS_CHANGED_TXPOWER */
diff --git a/drivers/net/wireless/st/cw1200/sta.h b/drivers/net/wireless/st/cw1200/sta.h
index 706dab8e73bf..05e3ab7ccef1 100644
--- a/drivers/net/wireless/st/cw1200/sta.h
+++ b/drivers/net/wireless/st/cw1200/sta.h
@@ -103,7 +103,7 @@ void cw1200_sta_notify(struct ieee80211_hw *dev, struct ieee80211_vif *vif,
 void cw1200_bss_info_changed(struct ieee80211_hw *dev,
 			     struct ieee80211_vif *vif,
 			     struct ieee80211_bss_conf *info,
-			     u32 changed);
+			     u64 changed);
 int cw1200_ampdu_action(struct ieee80211_hw *hw,
 			struct ieee80211_vif *vif,
 			struct ieee80211_ampdu_params *params);
diff --git a/drivers/net/wireless/ti/wl1251/main.c b/drivers/net/wireless/ti/wl1251/main.c
index bdc93c4f54ba..340ab4985fe2 100644
--- a/drivers/net/wireless/ti/wl1251/main.c
+++ b/drivers/net/wireless/ti/wl1251/main.c
@@ -1077,7 +1077,7 @@ static int wl1251_op_set_rts_threshold(struct ieee80211_hw *hw, u32 value)
 static void wl1251_op_bss_info_changed(struct ieee80211_hw *hw,
 				       struct ieee80211_vif *vif,
 				       struct ieee80211_bss_conf *bss_conf,
-				       u32 changed)
+				       u64 changed)
 {
 	struct wl1251 *wl = hw->priv;
 	struct sk_buff *beacon, *skb;
diff --git a/drivers/net/wireless/ti/wlcore/main.c b/drivers/net/wireless/ti/wlcore/main.c
index ad9560bd9512..d365bdce2a10 100644
--- a/drivers/net/wireless/ti/wlcore/main.c
+++ b/drivers/net/wireless/ti/wlcore/main.c
@@ -4580,7 +4580,7 @@ static void wl1271_bss_info_changed_sta(struct wl1271 *wl,
 static void wl1271_op_bss_info_changed(struct ieee80211_hw *hw,
 				       struct ieee80211_vif *vif,
 				       struct ieee80211_bss_conf *bss_conf,
-				       u32 changed)
+				       u64 changed)
 {
 	struct wl1271 *wl = hw->priv;
 	struct wl12xx_vif *wlvif = wl12xx_vif_to_data(vif);
diff --git a/drivers/net/wireless/zydas/zd1211rw/zd_mac.c b/drivers/net/wireless/zydas/zd1211rw/zd_mac.c
index 3ef8533205f9..cd2a4cbcc9d6 100644
--- a/drivers/net/wireless/zydas/zd1211rw/zd_mac.c
+++ b/drivers/net/wireless/zydas/zd1211rw/zd_mac.c
@@ -1278,12 +1278,12 @@ static void set_rts_cts(struct zd_mac *mac, unsigned int short_preamble)
 static void zd_op_bss_info_changed(struct ieee80211_hw *hw,
 				   struct ieee80211_vif *vif,
 				   struct ieee80211_bss_conf *bss_conf,
-				   u32 changes)
+				   u64 changes)
 {
 	struct zd_mac *mac = zd_hw_mac(hw);
 	int associated;
 
-	dev_dbg_f(zd_mac_dev(mac), "changes: %x\n", changes);
+	dev_dbg_f(zd_mac_dev(mac), "changes: %llx\n", (unsigned long long)changes);
 
 	if (mac->type == NL80211_IFTYPE_MESH_POINT ||
 	    mac->type == NL80211_IFTYPE_ADHOC ||
diff --git a/drivers/staging/vt6655/device_main.c b/drivers/staging/vt6655/device_main.c
index 741e1b9d6677..f995c592fd09 100644
--- a/drivers/staging/vt6655/device_main.c
+++ b/drivers/staging/vt6655/device_main.c
@@ -1396,7 +1396,7 @@ static int vnt_config(struct ieee80211_hw *hw, u32 changed)
 
 static void vnt_bss_info_changed(struct ieee80211_hw *hw,
 				 struct ieee80211_vif *vif,
-				 struct ieee80211_bss_conf *conf, u32 changed)
+				 struct ieee80211_bss_conf *conf, u64 changed)
 {
 	struct vnt_private *priv = hw->priv;
 
diff --git a/drivers/staging/vt6656/main_usb.c b/drivers/staging/vt6656/main_usb.c
index 3ab8a7bb9715..897ee0f7fc6b 100644
--- a/drivers/staging/vt6656/main_usb.c
+++ b/drivers/staging/vt6656/main_usb.c
@@ -745,7 +745,7 @@ static int vnt_config(struct ieee80211_hw *hw, u32 changed)
 
 static void vnt_bss_info_changed(struct ieee80211_hw *hw,
 				 struct ieee80211_vif *vif,
-				 struct ieee80211_bss_conf *conf, u32 changed)
+				 struct ieee80211_bss_conf *conf, u64 changed)
 {
 	struct vnt_private *priv = hw->priv;
 
diff --git a/include/net/mac80211.h b/include/net/mac80211.h
index 1520922d21a5..831f14b7ca69 100644
--- a/include/net/mac80211.h
+++ b/include/net/mac80211.h
@@ -273,8 +273,8 @@ struct ieee80211_vif_chanctx_switch {
 /**
  * enum ieee80211_bss_change - BSS change notification flags
  *
- * These flags are used with the bss_info_changed() callback
- * to indicate which BSS parameter changed.
+ * These flags are used with the bss_info_changed(), link_info_changed()
+ * and vif_cfg_changed() callbacks to indicate which parameter(s) changed.
  *
  * @BSS_CHANGED_ASSOC: association status changed (associated/disassociated),
  *	also implies a change in the AID.
@@ -3524,6 +3524,22 @@ struct ieee80211_prep_tx_info {
  *	for association indication. The @changed parameter indicates which
  *	of the bss parameters has changed when a call is made. The callback
  *	can sleep.
+ *	Note: this callback is called if @vif_cfg_changed or @link_info_changed
+ *	are not implemented.
+ *
+ * @vif_cfg_changed: Handler for configuration requests related to interface
+ *	(MLD) parameters from &struct ieee80211_vif_cfg that vary during the
+ *	lifetime of the interface (e.g. assoc status, IP addresses, etc.)
+ *	The @changed parameter indicates which value changed.
+ *	The callback can sleep.
+ *
+ * @link_info_changed: Handler for configuration requests related to link
+ *	parameters from &struct ieee80211_bss_conf that are related to an
+ *	individual link. e.g. legacy/HT/VHT/... rate information.
+ *	The @changed parameter indicates which value changed, and the @link_id
+ *	parameter indicates the link ID. Note that the @link_id will be 0 for
+ *	non-MLO connections.
+ *	The callback can sleep.
  *
  * @prepare_multicast: Prepare for multicast filter configuration.
  *	This callback is optional, and its return value is passed
@@ -4032,7 +4048,13 @@ struct ieee80211_ops {
 	void (*bss_info_changed)(struct ieee80211_hw *hw,
 				 struct ieee80211_vif *vif,
 				 struct ieee80211_bss_conf *info,
-				 u32 changed);
+				 u64 changed);
+	void (*vif_cfg_changed)(struct ieee80211_hw *hw,
+				struct ieee80211_vif *vif,
+				u64 changed);
+	void (*link_info_changed)(struct ieee80211_hw *hw,
+				  struct ieee80211_vif *vif,
+				  u64 link_id, u32 changed);
 
 	int (*start_ap)(struct ieee80211_hw *hw, struct ieee80211_vif *vif);
 	void (*stop_ap)(struct ieee80211_hw *hw, struct ieee80211_vif *vif);
diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index 040a766b8c19..ffd26db89f33 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -39,7 +39,8 @@ static void ieee80211_set_mu_mimo_follow(struct ieee80211_sub_if_data *sdata,
 		memcpy(sdata->vif.bss_conf.mu_group.position,
 		       params->vht_mumimo_groups + WLAN_MEMBERSHIP_LEN,
 		       WLAN_USER_POSITION_LEN);
-		ieee80211_bss_info_change_notify(sdata, BSS_CHANGED_MU_GROUPS);
+		ieee80211_link_info_change_notify(sdata, 0,
+						  BSS_CHANGED_MU_GROUPS);
 		/* don't care about endianness - just check for 0 */
 		memcpy(&membership, params->vht_mumimo_groups,
 		       WLAN_MEMBERSHIP_LEN);
@@ -1337,7 +1338,7 @@ static int ieee80211_change_beacon(struct wiphy *wiphy, struct net_device *dev,
 		err |= BSS_CHANGED_HE_BSS_COLOR;
 	}
 
-	ieee80211_bss_info_change_notify(sdata, err);
+	ieee80211_link_info_change_notify(sdata, 0, err);
 	return 0;
 }
 
@@ -1418,7 +1419,7 @@ static int ieee80211_stop_ap(struct wiphy *wiphy, struct net_device *dev,
 	sdata->beacon_rate_set = false;
 	sdata->vif.cfg.ssid_len = 0;
 	clear_bit(SDATA_STATE_OFFCHANNEL_BEACON_STOPPED, &sdata->state);
-	ieee80211_bss_info_change_notify(sdata, BSS_CHANGED_BEACON_ENABLED);
+	ieee80211_link_info_change_notify(sdata, 0, BSS_CHANGED_BEACON_ENABLED);
 
 	if (sdata->wdev.cac_started) {
 		chandef = sdata->vif.bss_conf.chandef;
@@ -2351,7 +2352,7 @@ static int ieee80211_update_mesh_config(struct wiphy *wiphy,
 	if (_chg_mesh_attr(NL80211_MESHCONF_HT_OPMODE, mask)) {
 		conf->ht_opmode = nconf->ht_opmode;
 		sdata->vif.bss_conf.ht_operation_mode = nconf->ht_opmode;
-		ieee80211_bss_info_change_notify(sdata, BSS_CHANGED_HT);
+		ieee80211_link_info_change_notify(sdata, 0, BSS_CHANGED_HT);
 	}
 	if (_chg_mesh_attr(NL80211_MESHCONF_HWMP_PATH_TO_ROOT_TIMEOUT, mask))
 		conf->dot11MeshHWMPactivePathToRootTimeout =
@@ -2506,7 +2507,7 @@ static int ieee80211_change_bss(struct wiphy *wiphy,
 		changed |= BSS_CHANGED_P2P_PS;
 	}
 
-	ieee80211_bss_info_change_notify(sdata, changed);
+	ieee80211_link_info_change_notify(sdata, 0, changed);
 
 	return 0;
 }
@@ -2547,7 +2548,7 @@ static int ieee80211_set_txq_params(struct wiphy *wiphy,
 		return -EINVAL;
 	}
 
-	ieee80211_bss_info_change_notify(sdata, BSS_CHANGED_QOS);
+	ieee80211_link_info_change_notify(sdata, 0, BSS_CHANGED_QOS);
 
 	return 0;
 }
@@ -2696,7 +2697,7 @@ static int ieee80211_set_mcast_rate(struct wiphy *wiphy, struct net_device *dev,
 	memcpy(sdata->vif.bss_conf.mcast_rate, rate,
 	       sizeof(int) * NUM_NL80211_BANDS);
 
-	ieee80211_bss_info_change_notify(sdata, BSS_CHANGED_MCAST_RATE);
+	ieee80211_link_info_change_notify(sdata, 0, BSS_CHANGED_MCAST_RATE);
 
 	return 0;
 }
@@ -3030,7 +3031,7 @@ static int ieee80211_set_cqm_rssi_config(struct wiphy *wiphy,
 	/* tell the driver upon association, unless already associated */
 	if (sdata->u.mgd.associated &&
 	    sdata->vif.driver_flags & IEEE80211_VIF_SUPPORTS_CQM_RSSI)
-		ieee80211_bss_info_change_notify(sdata, BSS_CHANGED_CQM);
+		ieee80211_link_info_change_notify(sdata, 0, BSS_CHANGED_CQM);
 
 	return 0;
 }
@@ -3055,7 +3056,7 @@ static int ieee80211_set_cqm_rssi_range_config(struct wiphy *wiphy,
 	/* tell the driver upon association, unless already associated */
 	if (sdata->u.mgd.associated &&
 	    sdata->vif.driver_flags & IEEE80211_VIF_SUPPORTS_CQM_RSSI)
-		ieee80211_bss_info_change_notify(sdata, BSS_CHANGED_CQM);
+		ieee80211_link_info_change_notify(sdata, 0, BSS_CHANGED_CQM);
 
 	return 0;
 }
@@ -3393,7 +3394,7 @@ static int __ieee80211_csa_finalize(struct ieee80211_sub_if_data *sdata)
 	if (err)
 		return err;
 
-	ieee80211_bss_info_change_notify(sdata, changed);
+	ieee80211_link_info_change_notify(sdata, 0, changed);
 
 	if (sdata->deflink.csa_block_tx) {
 		ieee80211_wake_vif_queues(local, sdata,
@@ -3681,7 +3682,7 @@ __ieee80211_channel_switch(struct wiphy *wiphy, struct net_device *dev,
 					  params->count, params->block_tx);
 
 	if (changed) {
-		ieee80211_bss_info_change_notify(sdata, changed);
+		ieee80211_link_info_change_notify(sdata, 0, changed);
 		drv_channel_switch_beacon(sdata, &params->chandef);
 	} else {
 		/* if the beacon didn't change, we can finalize immediately */
@@ -3984,7 +3985,7 @@ static int ieee80211_set_ap_chanwidth(struct wiphy *wiphy,
 
 	ret = ieee80211_vif_change_bandwidth(sdata, chandef, &changed);
 	if (ret == 0)
-		ieee80211_bss_info_change_notify(sdata, changed);
+		ieee80211_link_info_change_notify(sdata, 0, changed);
 
 	return ret;
 }
@@ -4393,7 +4394,7 @@ ieee80211_color_change_bss_config_notify(struct ieee80211_sub_if_data *sdata,
 	sdata->vif.bss_conf.he_bss_color.enabled = enable;
 	changed |= BSS_CHANGED_HE_BSS_COLOR;
 
-	ieee80211_bss_info_change_notify(sdata, changed);
+	ieee80211_link_info_change_notify(sdata, 0, changed);
 
 	if (!sdata->vif.bss_conf.nontransmitted && sdata->vif.mbssid_tx_vif) {
 		struct ieee80211_sub_if_data *child;
@@ -4403,8 +4404,8 @@ ieee80211_color_change_bss_config_notify(struct ieee80211_sub_if_data *sdata,
 			if (child != sdata && child->vif.mbssid_tx_vif == &sdata->vif) {
 				child->vif.bss_conf.he_bss_color.color = color;
 				child->vif.bss_conf.he_bss_color.enabled = enable;
-				ieee80211_bss_info_change_notify(child,
-								 BSS_CHANGED_HE_BSS_COLOR);
+				ieee80211_link_info_change_notify(child, 0,
+								  BSS_CHANGED_HE_BSS_COLOR);
 			}
 		}
 		mutex_unlock(&sdata->local->iflist_mtx);
diff --git a/net/mac80211/chan.c b/net/mac80211/chan.c
index 67131ca3f649..5d8b49f20198 100644
--- a/net/mac80211/chan.c
+++ b/net/mac80211/chan.c
@@ -799,8 +799,7 @@ static int ieee80211_assign_vif_chanctx(struct ieee80211_sub_if_data *sdata,
 
 	if (sdata->vif.type != NL80211_IFTYPE_P2P_DEVICE &&
 	    sdata->vif.type != NL80211_IFTYPE_MONITOR)
-		ieee80211_bss_info_change_notify(sdata,
-						 BSS_CHANGED_IDLE);
+		ieee80211_vif_cfg_change_notify(sdata, BSS_CHANGED_IDLE);
 
 	ieee80211_check_fast_xmit_iface(sdata);
 
@@ -1188,7 +1187,7 @@ ieee80211_vif_use_reserved_reassign(struct ieee80211_sub_if_data *sdata)
 	ieee80211_recalc_radar_chanctx(local, new_ctx);
 
 	if (changed)
-		ieee80211_bss_info_change_notify(sdata, changed);
+		ieee80211_link_info_change_notify(sdata, 0, changed);
 
 out:
 	ieee80211_vif_chanctx_reservation_complete(sdata);
@@ -1533,8 +1532,8 @@ static int ieee80211_vif_use_reserved_switch(struct ieee80211_local *local)
 			ieee80211_vif_update_chandef(sdata,
 						     &sdata->deflink.reserved_chandef);
 			if (changed)
-				ieee80211_bss_info_change_notify(sdata,
-								 changed);
+				ieee80211_link_info_change_notify(sdata, 0,
+								  changed);
 
 			ieee80211_recalc_txpower(sdata, false);
 		}
diff --git a/net/mac80211/driver-ops.h b/net/mac80211/driver-ops.h
index fd2882348211..15ab8d00815b 100644
--- a/net/mac80211/driver-ops.h
+++ b/net/mac80211/driver-ops.h
@@ -147,10 +147,27 @@ static inline int drv_config(struct ieee80211_local *local, u32 changed)
 	return ret;
 }
 
-static inline void drv_bss_info_changed(struct ieee80211_local *local,
-					struct ieee80211_sub_if_data *sdata,
-					struct ieee80211_bss_conf *info,
-					u32 changed)
+static inline void drv_vif_cfg_changed(struct ieee80211_local *local,
+				       struct ieee80211_sub_if_data *sdata,
+				       u64 changed)
+{
+	might_sleep();
+
+	if (!check_sdata_in_driver(sdata))
+		return;
+
+	trace_drv_vif_cfg_changed(local, sdata, changed);
+	if (local->ops->vif_cfg_changed)
+		local->ops->vif_cfg_changed(&local->hw, &sdata->vif, changed);
+	else if (local->ops->bss_info_changed)
+		local->ops->bss_info_changed(&local->hw, &sdata->vif,
+					     &sdata->vif.bss_conf, changed);
+	trace_drv_return_void(local);
+}
+
+static inline void drv_link_info_changed(struct ieee80211_local *local,
+					 struct ieee80211_sub_if_data *sdata,
+					 int link_id, u64 changed)
 {
 	might_sleep();
 
@@ -172,9 +189,13 @@ static inline void drv_bss_info_changed(struct ieee80211_local *local,
 	if (!check_sdata_in_driver(sdata))
 		return;
 
-	trace_drv_bss_info_changed(local, sdata, info, changed);
-	if (local->ops->bss_info_changed)
-		local->ops->bss_info_changed(&local->hw, &sdata->vif, info, changed);
+	trace_drv_link_info_changed(local, sdata, link_id, changed);
+	if (local->ops->link_info_changed)
+		local->ops->link_info_changed(&local->hw, &sdata->vif,
+					      link_id, changed);
+	else if (local->ops->bss_info_changed)
+		local->ops->bss_info_changed(&local->hw, &sdata->vif,
+					     &sdata->vif.bss_conf, changed);
 	trace_drv_return_void(local);
 }
 
diff --git a/net/mac80211/ibss.c b/net/mac80211/ibss.c
index 066f7c5adeec..3b68e9f4345b 100644
--- a/net/mac80211/ibss.c
+++ b/net/mac80211/ibss.c
@@ -1851,7 +1851,7 @@ int ieee80211_ibss_join(struct ieee80211_sub_if_data *sdata,
 		| IEEE80211_HT_PARAM_RIFS_MODE;
 
 	changed |= BSS_CHANGED_HT | BSS_CHANGED_MCAST_RATE;
-	ieee80211_bss_info_change_notify(sdata, changed);
+	ieee80211_link_info_change_notify(sdata, 0, changed);
 
 	sdata->deflink.smps_mode = IEEE80211_SMPS_OFF;
 	sdata->deflink.needed_rx_chains = local->rx_chains;
diff --git a/net/mac80211/ieee80211_i.h b/net/mac80211/ieee80211_i.h
index f0a8bb444033..20153957cdee 100644
--- a/net/mac80211/ieee80211_i.h
+++ b/net/mac80211/ieee80211_i.h
@@ -1836,7 +1836,11 @@ u64 ieee80211_calculate_rx_timestamp(struct ieee80211_local *local,
 int ieee80211_hw_config(struct ieee80211_local *local, u32 changed);
 void ieee80211_tx_set_protected(struct ieee80211_tx_data *tx);
 void ieee80211_bss_info_change_notify(struct ieee80211_sub_if_data *sdata,
-				      u32 changed);
+				      u64 changed);
+void ieee80211_vif_cfg_change_notify(struct ieee80211_sub_if_data *sdata,
+				     u64 changed);
+void ieee80211_link_info_change_notify(struct ieee80211_sub_if_data *sdata,
+				       int link_id, u64 changed);
 void ieee80211_configure_filter(struct ieee80211_local *local);
 u32 ieee80211_reset_erp_info(struct ieee80211_sub_if_data *sdata);
 
diff --git a/net/mac80211/iface.c b/net/mac80211/iface.c
index 2ee34d898821..978dfa48e098 100644
--- a/net/mac80211/iface.c
+++ b/net/mac80211/iface.c
@@ -80,7 +80,8 @@ void ieee80211_recalc_txpower(struct ieee80211_sub_if_data *sdata,
 {
 	if (__ieee80211_recalc_txpower(sdata) ||
 	    (update_bss && ieee80211_sdata_running(sdata)))
-		ieee80211_bss_info_change_notify(sdata, BSS_CHANGED_TXPOWER);
+		ieee80211_link_info_change_notify(sdata, 0,
+						  BSS_CHANGED_TXPOWER);
 }
 
 static u32 __ieee80211_idle_off(struct ieee80211_local *local)
@@ -1281,7 +1282,7 @@ int ieee80211_do_open(struct wireless_dev *wdev, bool coming_up)
 		if (sdata->vif.type != NL80211_IFTYPE_P2P_DEVICE &&
 		    sdata->vif.type != NL80211_IFTYPE_NAN)
 			changed |= ieee80211_reset_erp_info(sdata);
-		ieee80211_bss_info_change_notify(sdata, changed);
+		ieee80211_link_info_change_notify(sdata, 0, changed);
 
 		switch (sdata->vif.type) {
 		case NL80211_IFTYPE_STATION:
diff --git a/net/mac80211/main.c b/net/mac80211/main.c
index 0c81ae492df4..6165b90bf0e2 100644
--- a/net/mac80211/main.c
+++ b/net/mac80211/main.c
@@ -199,15 +199,84 @@ int ieee80211_hw_config(struct ieee80211_local *local, u32 changed)
 	return ret;
 }
 
+#define BSS_CHANGED_VIF_CFG_FLAGS (BSS_CHANGED_ASSOC |\
+				   BSS_CHANGED_IDLE |\
+				   BSS_CHANGED_IBSS |\
+				   BSS_CHANGED_ARP_FILTER |\
+				   BSS_CHANGED_SSID)
+
 void ieee80211_bss_info_change_notify(struct ieee80211_sub_if_data *sdata,
-				      u32 changed)
+				      u64 changed)
 {
 	struct ieee80211_local *local = sdata->local;
 
+	might_sleep();
+
 	if (!changed || sdata->vif.type == NL80211_IFTYPE_AP_VLAN)
 		return;
 
-	drv_bss_info_changed(local, sdata, &sdata->vif.bss_conf, changed);
+	if (WARN_ON_ONCE(changed & (BSS_CHANGED_BEACON |
+				    BSS_CHANGED_BEACON_ENABLED) &&
+			 sdata->vif.type != NL80211_IFTYPE_AP &&
+			 sdata->vif.type != NL80211_IFTYPE_ADHOC &&
+			 sdata->vif.type != NL80211_IFTYPE_MESH_POINT &&
+			 sdata->vif.type != NL80211_IFTYPE_OCB))
+		return;
+
+	if (WARN_ON_ONCE(sdata->vif.type == NL80211_IFTYPE_P2P_DEVICE ||
+			 sdata->vif.type == NL80211_IFTYPE_NAN ||
+			 (sdata->vif.type == NL80211_IFTYPE_MONITOR &&
+			  !sdata->vif.bss_conf.mu_mimo_owner &&
+			  !(changed & BSS_CHANGED_TXPOWER))))
+		return;
+
+	if (!check_sdata_in_driver(sdata))
+		return;
+
+	if (changed & BSS_CHANGED_VIF_CFG_FLAGS) {
+		trace_drv_vif_cfg_changed(local, sdata, changed);
+		if (local->ops->vif_cfg_changed)
+			local->ops->vif_cfg_changed(&local->hw, &sdata->vif, changed);
+	}
+
+	if (changed & ~BSS_CHANGED_VIF_CFG_FLAGS) {
+		/* FIXME: should be for each link */
+		trace_drv_link_info_changed(local, sdata, 0, changed);
+		if (local->ops->link_info_changed)
+			local->ops->link_info_changed(&local->hw, &sdata->vif,
+						      0, changed);
+	}
+
+	if (local->ops->bss_info_changed)
+		local->ops->bss_info_changed(&local->hw, &sdata->vif,
+					     &sdata->vif.bss_conf, changed);
+	trace_drv_return_void(local);
+}
+
+void ieee80211_vif_cfg_change_notify(struct ieee80211_sub_if_data *sdata,
+				     u64 changed)
+{
+	struct ieee80211_local *local = sdata->local;
+
+	WARN_ON_ONCE(changed & ~BSS_CHANGED_VIF_CFG_FLAGS);
+
+	if (!changed || sdata->vif.type == NL80211_IFTYPE_AP_VLAN)
+		return;
+
+	drv_vif_cfg_changed(local, sdata, changed);
+}
+
+void ieee80211_link_info_change_notify(struct ieee80211_sub_if_data *sdata,
+				       int link_id, u64 changed)
+{
+	struct ieee80211_local *local = sdata->local;
+
+	WARN_ON_ONCE(changed & BSS_CHANGED_VIF_CFG_FLAGS);
+
+	if (!changed || sdata->vif.type == NL80211_IFTYPE_AP_VLAN)
+		return;
+
+	drv_link_info_changed(local, sdata, link_id, changed);
 }
 
 u32 ieee80211_reset_erp_info(struct ieee80211_sub_if_data *sdata)
@@ -387,8 +456,7 @@ static int ieee80211_ifa_changed(struct notifier_block *nb,
 
 	/* Configure driver only if associated (which also implies it is up) */
 	if (ifmgd->associated)
-		ieee80211_bss_info_change_notify(sdata,
-						 BSS_CHANGED_ARP_FILTER);
+		ieee80211_vif_cfg_change_notify(sdata, BSS_CHANGED_ARP_FILTER);
 
 	sdata_unlock(sdata);
 
@@ -557,6 +625,10 @@ struct ieee80211_hw *ieee80211_alloc_hw_nm(size_t priv_data_len,
 	if (WARN_ON(ops->sta_state && (ops->sta_add || ops->sta_remove)))
 		return NULL;
 
+	if (WARN_ON(!!ops->link_info_changed != !!ops->vif_cfg_changed ||
+		    (ops->link_info_changed && ops->bss_info_changed)))
+		return NULL;
+
 	/* check all or no channel context operations exist */
 	i = !!ops->add_chanctx + !!ops->remove_chanctx +
 	    !!ops->change_chanctx + !!ops->assign_vif_chanctx +
diff --git a/net/mac80211/mesh.c b/net/mac80211/mesh.c
index f60e257cba95..13722a7f2254 100644
--- a/net/mac80211/mesh.c
+++ b/net/mac80211/mesh.c
@@ -1057,7 +1057,7 @@ int ieee80211_start_mesh(struct ieee80211_sub_if_data *sdata)
 	}
 
 	ieee80211_recalc_dtim(local, sdata);
-	ieee80211_bss_info_change_notify(sdata, changed);
+	ieee80211_link_info_change_notify(sdata, 0, changed);
 
 	netif_carrier_on(sdata->dev);
 	return 0;
@@ -1081,7 +1081,7 @@ void ieee80211_stop_mesh(struct ieee80211_sub_if_data *sdata)
 	sdata->vif.bss_conf.enable_beacon = false;
 	sdata->beacon_rate_set = false;
 	clear_bit(SDATA_STATE_OFFCHANNEL_BEACON_STOPPED, &sdata->state);
-	ieee80211_bss_info_change_notify(sdata, BSS_CHANGED_BEACON_ENABLED);
+	ieee80211_link_info_change_notify(sdata, 0, BSS_CHANGED_BEACON_ENABLED);
 
 	/* remove beacon */
 	bcn = rcu_dereference_protected(ifmsh->beacon,
@@ -1581,7 +1581,7 @@ static void mesh_bss_info_changed(struct ieee80211_sub_if_data *sdata)
 		if (ieee80211_mesh_rebuild_beacon(sdata))
 			return;
 
-	ieee80211_bss_info_change_notify(sdata, changed);
+	ieee80211_link_info_change_notify(sdata, 0, changed);
 }
 
 void ieee80211_mesh_work(struct ieee80211_sub_if_data *sdata)
diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index fd1b97e1e990..e172bdfe9b0a 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -1835,7 +1835,7 @@ void ieee80211_recalc_ps_vif(struct ieee80211_sub_if_data *sdata)
 
 	if (sdata->vif.bss_conf.ps != ps_allowed) {
 		sdata->vif.bss_conf.ps = ps_allowed;
-		ieee80211_bss_info_change_notify(sdata, BSS_CHANGED_PS);
+		ieee80211_link_info_change_notify(sdata, 0, BSS_CHANGED_PS);
 	}
 }
 
@@ -2031,7 +2031,7 @@ __ieee80211_sta_handle_tspec_ac_params(struct ieee80211_sub_if_data *sdata)
 void ieee80211_sta_handle_tspec_ac_params(struct ieee80211_sub_if_data *sdata)
 {
 	if (__ieee80211_sta_handle_tspec_ac_params(sdata))
-		ieee80211_bss_info_change_notify(sdata, BSS_CHANGED_QOS);
+		ieee80211_link_info_change_notify(sdata, 0, BSS_CHANGED_QOS);
 }
 
 static void ieee80211_sta_handle_tspec_ac_params_wk(struct work_struct *work)
@@ -2920,7 +2920,7 @@ static void ieee80211_destroy_auth_data(struct ieee80211_sub_if_data *sdata,
 		sta_info_destroy_addr(sdata, auth_data->bss->bssid);
 
 		eth_zero_addr(sdata->deflink.u.mgd.bssid);
-		ieee80211_bss_info_change_notify(sdata, BSS_CHANGED_BSSID);
+		ieee80211_link_info_change_notify(sdata, 0, BSS_CHANGED_BSSID);
 		sdata->u.mgd.flags = 0;
 		mutex_lock(&sdata->local->mtx);
 		ieee80211_vif_release_channel(sdata);
@@ -2949,7 +2949,7 @@ static void ieee80211_destroy_assoc_data(struct ieee80211_sub_if_data *sdata,
 		sta_info_destroy_addr(sdata, assoc_data->bss->bssid);
 
 		eth_zero_addr(sdata->deflink.u.mgd.bssid);
-		ieee80211_bss_info_change_notify(sdata, BSS_CHANGED_BSSID);
+		ieee80211_link_info_change_notify(sdata, 0, BSS_CHANGED_BSSID);
 		sdata->u.mgd.flags = 0;
 		sdata->vif.bss_conf.mu_mimo_owner = false;
 
@@ -4387,7 +4387,7 @@ static void ieee80211_rx_mgmt_beacon(struct ieee80211_sub_if_data *sdata,
 					       elems->pwr_constr_elem,
 					       elems->cisco_dtpc_elem);
 
-	ieee80211_bss_info_change_notify(sdata, changed);
+	ieee80211_link_info_change_notify(sdata, 0, changed);
 free:
 	kfree(elems);
 }
@@ -5697,7 +5697,7 @@ static int ieee80211_prep_connection(struct ieee80211_sub_if_data *sdata,
 		 * tell driver about BSSID, basic rates and timing
 		 * this was set up above, before setting the channel
 		 */
-		ieee80211_bss_info_change_notify(sdata,
+		ieee80211_link_info_change_notify(sdata, 0,
 			BSS_CHANGED_BSSID | BSS_CHANGED_BASIC_RATES |
 			BSS_CHANGED_BEACON_INT);
 
@@ -5865,7 +5865,7 @@ int ieee80211_mgd_auth(struct ieee80211_sub_if_data *sdata,
 
  err_clear:
 	eth_zero_addr(sdata->deflink.u.mgd.bssid);
-	ieee80211_bss_info_change_notify(sdata, BSS_CHANGED_BSSID);
+	ieee80211_link_info_change_notify(sdata, 0, BSS_CHANGED_BSSID);
 	ifmgd->auth_data = NULL;
 	mutex_lock(&sdata->local->mtx);
 	ieee80211_vif_release_channel(sdata);
@@ -6212,7 +6212,7 @@ int ieee80211_mgd_assoc(struct ieee80211_sub_if_data *sdata,
 	return 0;
  err_clear:
 	eth_zero_addr(sdata->deflink.u.mgd.bssid);
-	ieee80211_bss_info_change_notify(sdata, BSS_CHANGED_BSSID);
+	ieee80211_link_info_change_notify(sdata, 0, BSS_CHANGED_BSSID);
 	ifmgd->assoc_data = NULL;
  err_free:
 	kfree(assoc_data);
diff --git a/net/mac80211/offchannel.c b/net/mac80211/offchannel.c
index 6cd3df1eb687..2ed4e2325914 100644
--- a/net/mac80211/offchannel.c
+++ b/net/mac80211/offchannel.c
@@ -118,8 +118,8 @@ void ieee80211_offchannel_stop_vifs(struct ieee80211_local *local)
 			set_bit(SDATA_STATE_OFFCHANNEL_BEACON_STOPPED,
 				&sdata->state);
 			sdata->vif.bss_conf.enable_beacon = false;
-			ieee80211_bss_info_change_notify(
-				sdata, BSS_CHANGED_BEACON_ENABLED);
+			ieee80211_link_info_change_notify(
+				sdata, 0, BSS_CHANGED_BEACON_ENABLED);
 		}
 
 		if (sdata->vif.type == NL80211_IFTYPE_STATION &&
@@ -155,8 +155,8 @@ void ieee80211_offchannel_return(struct ieee80211_local *local)
 		if (test_and_clear_bit(SDATA_STATE_OFFCHANNEL_BEACON_STOPPED,
 				       &sdata->state)) {
 			sdata->vif.bss_conf.enable_beacon = true;
-			ieee80211_bss_info_change_notify(
-				sdata, BSS_CHANGED_BEACON_ENABLED);
+			ieee80211_link_info_change_notify(
+				sdata, 0, BSS_CHANGED_BEACON_ENABLED);
 		}
 	}
 	mutex_unlock(&local->iflist_mtx);
diff --git a/net/mac80211/sta_info.c b/net/mac80211/sta_info.c
index 115efa830673..9a70d846d0dd 100644
--- a/net/mac80211/sta_info.c
+++ b/net/mac80211/sta_info.c
@@ -630,7 +630,7 @@ ieee80211_recalc_p2p_go_ps_allowed(struct ieee80211_sub_if_data *sdata)
 
 	if (allow_p2p_go_ps != sdata->vif.bss_conf.allow_p2p_go_ps) {
 		sdata->vif.bss_conf.allow_p2p_go_ps = allow_p2p_go_ps;
-		ieee80211_bss_info_change_notify(sdata, BSS_CHANGED_P2P_PS);
+		ieee80211_link_info_change_notify(sdata, 0, BSS_CHANGED_P2P_PS);
 	}
 }
 
diff --git a/net/mac80211/tdls.c b/net/mac80211/tdls.c
index 8a2ec9c31240..11a3b950b490 100644
--- a/net/mac80211/tdls.c
+++ b/net/mac80211/tdls.c
@@ -1335,7 +1335,7 @@ iee80211_tdls_recalc_ht_protection(struct ieee80211_sub_if_data *sdata,
 		return;
 
 	sdata->vif.bss_conf.ht_operation_mode = opmode;
-	ieee80211_bss_info_change_notify(sdata, BSS_CHANGED_HT);
+	ieee80211_link_info_change_notify(sdata, 0, BSS_CHANGED_HT);
 }
 
 int ieee80211_tdls_oper(struct wiphy *wiphy, struct net_device *dev,
diff --git a/net/mac80211/trace.h b/net/mac80211/trace.h
index 74ef7e71e1ef..7284f0bf8a99 100644
--- a/net/mac80211/trace.h
+++ b/net/mac80211/trace.h
@@ -390,22 +390,71 @@ TRACE_EVENT(drv_config,
 	)
 );
 
-TRACE_EVENT(drv_bss_info_changed,
+TRACE_EVENT(drv_vif_cfg_changed,
 	TP_PROTO(struct ieee80211_local *local,
 		 struct ieee80211_sub_if_data *sdata,
-		 struct ieee80211_bss_conf *info,
-		 u32 changed),
+		 u64 changed),
 
-	TP_ARGS(local, sdata, info, changed),
+	TP_ARGS(local, sdata, changed),
 
 	TP_STRUCT__entry(
 		LOCAL_ENTRY
 		VIF_ENTRY
-		__field(u32, changed)
+		__field(u64, changed)
 		__field(bool, assoc)
 		__field(bool, ibss_joined)
 		__field(bool, ibss_creator)
 		__field(u16, aid)
+		__dynamic_array(u32, arp_addr_list,
+				sdata->vif.cfg.arp_addr_cnt > IEEE80211_BSS_ARP_ADDR_LIST_LEN ?
+					IEEE80211_BSS_ARP_ADDR_LIST_LEN :
+					sdata->vif.cfg.arp_addr_cnt)
+		__field(int, arp_addr_cnt)
+		__dynamic_array(u8, ssid, sdata->vif.cfg.ssid_len)
+		__field(int, s1g)
+		__field(bool, idle)
+	),
+
+	TP_fast_assign(
+		LOCAL_ASSIGN;
+		VIF_ASSIGN;
+		__entry->changed = changed;
+		__entry->aid = sdata->vif.cfg.aid;
+		__entry->assoc = sdata->vif.cfg.assoc;
+		__entry->ibss_joined = sdata->vif.cfg.ibss_joined;
+		__entry->ibss_creator = sdata->vif.cfg.ibss_creator;
+
+		__entry->arp_addr_cnt = sdata->vif.cfg.arp_addr_cnt;
+		memcpy(__get_dynamic_array(arp_addr_list),
+		       sdata->vif.cfg.arp_addr_list,
+		       sizeof(u32) * (sdata->vif.cfg.arp_addr_cnt > IEEE80211_BSS_ARP_ADDR_LIST_LEN ?
+					IEEE80211_BSS_ARP_ADDR_LIST_LEN :
+					sdata->vif.cfg.arp_addr_cnt));
+		memcpy(__get_dynamic_array(ssid),
+		       sdata->vif.cfg.ssid,
+		       sdata->vif.cfg.ssid_len);
+		__entry->s1g = sdata->vif.cfg.s1g;
+		__entry->idle = sdata->vif.cfg.idle;
+	),
+
+	TP_printk(
+		LOCAL_PR_FMT  VIF_PR_FMT " changed:%#llx",
+		LOCAL_PR_ARG, VIF_PR_ARG, (unsigned long long)__entry->changed
+	)
+);
+
+TRACE_EVENT(drv_link_info_changed,
+	TP_PROTO(struct ieee80211_local *local,
+		 struct ieee80211_sub_if_data *sdata,
+		 int link_id, u64 changed),
+
+	TP_ARGS(local, sdata, link_id, changed),
+
+	TP_STRUCT__entry(
+		LOCAL_ENTRY
+		VIF_ENTRY
+		__field(u64, changed)
+		__field(int, link_id)
 		__field(bool, cts)
 		__field(bool, shortpre)
 		__field(bool, shortslot)
@@ -424,15 +473,8 @@ TRACE_EVENT(drv_bss_info_changed,
 		__field(u32, channel_width)
 		__field(u32, channel_cfreq1)
 		__field(u32, channel_cfreq1_offset)
-		__dynamic_array(u32, arp_addr_list,
-				sdata->vif.cfg.arp_addr_cnt > IEEE80211_BSS_ARP_ADDR_LIST_LEN ?
-					IEEE80211_BSS_ARP_ADDR_LIST_LEN :
-					sdata->vif.cfg.arp_addr_cnt)
-		__field(int, arp_addr_cnt)
 		__field(bool, qos)
-		__field(bool, idle)
 		__field(bool, ps)
-		__dynamic_array(u8, ssid, sdata->vif.cfg.ssid_len)
 		__field(bool, hidden_ssid)
 		__field(int, txpower)
 		__field(u8, p2p_oppps_ctwindow)
@@ -442,49 +484,37 @@ TRACE_EVENT(drv_bss_info_changed,
 		LOCAL_ASSIGN;
 		VIF_ASSIGN;
 		__entry->changed = changed;
-		__entry->aid = sdata->vif.cfg.aid;
-		__entry->assoc = sdata->vif.cfg.assoc;
-		__entry->ibss_joined = sdata->vif.cfg.ibss_joined;
-		__entry->ibss_creator = sdata->vif.cfg.ibss_creator;
-		__entry->shortpre = info->use_short_preamble;
-		__entry->cts = info->use_cts_prot;
-		__entry->shortslot = info->use_short_slot;
-		__entry->enable_beacon = info->enable_beacon;
-		__entry->dtimper = info->dtim_period;
-		__entry->bcnint = info->beacon_int;
-		__entry->assoc_cap = info->assoc_capability;
-		__entry->sync_tsf = info->sync_tsf;
-		__entry->sync_device_ts = info->sync_device_ts;
-		__entry->sync_dtim_count = info->sync_dtim_count;
-		__entry->basic_rates = info->basic_rates;
-		memcpy(__entry->mcast_rate, info->mcast_rate,
+		__entry->link_id = link_id;
+		__entry->shortpre = sdata->vif.bss_conf.use_short_preamble;
+		__entry->cts = sdata->vif.bss_conf.use_cts_prot;
+		__entry->shortslot = sdata->vif.bss_conf.use_short_slot;
+		__entry->enable_beacon = sdata->vif.bss_conf.enable_beacon;
+		__entry->dtimper = sdata->vif.bss_conf.dtim_period;
+		__entry->bcnint = sdata->vif.bss_conf.beacon_int;
+		__entry->assoc_cap = sdata->vif.bss_conf.assoc_capability;
+		__entry->sync_tsf = sdata->vif.bss_conf.sync_tsf;
+		__entry->sync_device_ts = sdata->vif.bss_conf.sync_device_ts;
+		__entry->sync_dtim_count = sdata->vif.bss_conf.sync_dtim_count;
+		__entry->basic_rates = sdata->vif.bss_conf.basic_rates;
+		memcpy(__entry->mcast_rate, sdata->vif.bss_conf.mcast_rate,
 		       sizeof(__entry->mcast_rate));
-		__entry->ht_operation_mode = info->ht_operation_mode;
-		__entry->cqm_rssi_thold = info->cqm_rssi_thold;
-		__entry->cqm_rssi_hyst = info->cqm_rssi_hyst;
-		__entry->channel_width = info->chandef.width;
-		__entry->channel_cfreq1 = info->chandef.center_freq1;
-		__entry->channel_cfreq1_offset = info->chandef.freq1_offset;
-		__entry->arp_addr_cnt = sdata->vif.cfg.arp_addr_cnt;
-		memcpy(__get_dynamic_array(arp_addr_list),
-		       sdata->vif.cfg.arp_addr_list,
-		       sizeof(u32) * (sdata->vif.cfg.arp_addr_cnt > IEEE80211_BSS_ARP_ADDR_LIST_LEN ?
-					IEEE80211_BSS_ARP_ADDR_LIST_LEN :
-					sdata->vif.cfg.arp_addr_cnt));
-		__entry->qos = info->qos;
-		__entry->idle = sdata->vif.cfg.idle;
-		__entry->ps = info->ps;
-		memcpy(__get_dynamic_array(ssid),
-		       sdata->vif.cfg.ssid,
-		       sdata->vif.cfg.ssid_len);
-		__entry->hidden_ssid = info->hidden_ssid;
-		__entry->txpower = info->txpower;
-		__entry->p2p_oppps_ctwindow = info->p2p_noa_attr.oppps_ctwindow;
-	),
-
-	TP_printk(
-		LOCAL_PR_FMT  VIF_PR_FMT " changed:%#x",
-		LOCAL_PR_ARG, VIF_PR_ARG, __entry->changed
+		__entry->ht_operation_mode = sdata->vif.bss_conf.ht_operation_mode;
+		__entry->cqm_rssi_thold = sdata->vif.bss_conf.cqm_rssi_thold;
+		__entry->cqm_rssi_hyst = sdata->vif.bss_conf.cqm_rssi_hyst;
+		__entry->channel_width = sdata->vif.bss_conf.chandef.width;
+		__entry->channel_cfreq1 = sdata->vif.bss_conf.chandef.center_freq1;
+		__entry->channel_cfreq1_offset = sdata->vif.bss_conf.chandef.freq1_offset;
+		__entry->qos = sdata->vif.bss_conf.qos;
+		__entry->ps = sdata->vif.bss_conf.ps;
+		__entry->hidden_ssid = sdata->vif.bss_conf.hidden_ssid;
+		__entry->txpower = sdata->vif.bss_conf.txpower;
+		__entry->p2p_oppps_ctwindow = sdata->vif.bss_conf.p2p_noa_attr.oppps_ctwindow;
+	),
+
+	TP_printk(
+		LOCAL_PR_FMT  VIF_PR_FMT " link_id:%d, changed:%#llx",
+		LOCAL_PR_ARG, VIF_PR_ARG, __entry->link_id,
+		(unsigned long long)__entry->changed
 	)
 );
 
diff --git a/net/mac80211/util.c b/net/mac80211/util.c
index 9cbc09e6d84e..2a279dc3e457 100644
--- a/net/mac80211/util.c
+++ b/net/mac80211/util.c
@@ -1699,8 +1699,8 @@ void ieee80211_set_wmm_default(struct ieee80211_sub_if_data *sdata,
 	    sdata->vif.type != NL80211_IFTYPE_NAN) {
 		sdata->vif.bss_conf.qos = enable_qos;
 		if (bss_notify)
-			ieee80211_bss_info_change_notify(sdata,
-							 BSS_CHANGED_QOS);
+			ieee80211_link_info_change_notify(sdata, 0,
+							  BSS_CHANGED_QOS);
 	}
 }
 
diff --git a/net/mac80211/vht.c b/net/mac80211/vht.c
index ac97584b3a0b..7daca8352deb 100644
--- a/net/mac80211/vht.c
+++ b/net/mac80211/vht.c
@@ -665,7 +665,7 @@ void ieee80211_process_mu_groups(struct ieee80211_sub_if_data *sdata,
 	       mgmt->u.action.u.vht_group_notif.position,
 	       WLAN_USER_POSITION_LEN);
 
-	ieee80211_bss_info_change_notify(sdata, BSS_CHANGED_MU_GROUPS);
+	ieee80211_link_info_change_notify(sdata, 0, BSS_CHANGED_MU_GROUPS);
 }
 
 void ieee80211_update_mu_groups(struct ieee80211_vif *vif,
-- 
2.36.1

