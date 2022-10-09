Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E9FD5F8C53
	for <lists+linux-wireless@lfdr.de>; Sun,  9 Oct 2022 18:30:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229899AbiJIQa5 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 9 Oct 2022 12:30:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229979AbiJIQa4 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 9 Oct 2022 12:30:56 -0400
Received: from ns2.wdyn.eu (ns2.wdyn.eu [IPv6:2a03:4000:40:5b2::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C3C3C2228C
        for <linux-wireless@vger.kernel.org>; Sun,  9 Oct 2022 09:30:52 -0700 (PDT)
From:   Alexander Wetzel <alexander@wetzel-home.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=wetzel-home.de;
        s=wetzel-home; t=1665333048;
        bh=EkDTzSWST8FEeRs/TGJD05ua4MCzRMasqDvUdgX9wOs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=W6xXmOJ0tOFrzdTX2+6RQm4wZRBXOLTb2c+7uTVHtpswPsz+I5kiT/TcKKALSofA8
         7fXdEZzjY6VTHc9icEiRB5u11q8Q8ThjIiua2oEfSWG9QbYWyy453ML8aaWXRLXpPS
         /1b5XqmVWhoABYOHC1LgB0qhxtUxT+G6Yol/Csyk=
To:     linux-wireless@vger.kernel.org
Cc:     johannes@sipsolutions.net,
        Alexander Wetzel <alexander@wetzel-home.de>
Subject: [PATCH v2 2/3] wifi: mac80211: add wake_tx_queue callback to drivers
Date:   Sun,  9 Oct 2022 18:30:39 +0200
Message-Id: <20221009163040.25637-2-alexander@wetzel-home.de>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221009163040.25637-1-alexander@wetzel-home.de>
References: <20221009163040.25637-1-alexander@wetzel-home.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

mac80211 is fully switching over to the internal TX queue (iTXQ)
implementation. Update all drivers not yet providing the now mandatory
wake_tx_queue() callback.

As an side effect the netdev interfaces of all updated drivers will
switch to the noqueue qdisc.

Signed-off-by: Alexander Wetzel <alexander@wetzel-home.de>
---
 drivers/net/wireless/admtek/adm8211.c                          | 1 +
 drivers/net/wireless/ath/ar5523/ar5523.c                       | 1 +
 drivers/net/wireless/ath/ath11k/mac.c                          | 1 +
 drivers/net/wireless/ath/ath5k/mac80211-ops.c                  | 1 +
 drivers/net/wireless/ath/ath9k/htc_drv_main.c                  | 1 +
 drivers/net/wireless/ath/carl9170/main.c                       | 1 +
 drivers/net/wireless/ath/wcn36xx/main.c                        | 1 +
 drivers/net/wireless/atmel/at76c50x-usb.c                      | 1 +
 drivers/net/wireless/broadcom/b43/main.c                       | 1 +
 drivers/net/wireless/broadcom/b43legacy/main.c                 | 1 +
 drivers/net/wireless/broadcom/brcm80211/brcmsmac/mac80211_if.c | 1 +
 drivers/net/wireless/intel/iwlegacy/3945-mac.c                 | 1 +
 drivers/net/wireless/intel/iwlegacy/4965-mac.c                 | 1 +
 drivers/net/wireless/intel/iwlwifi/dvm/mac80211.c              | 1 +
 drivers/net/wireless/intersil/p54/main.c                       | 1 +
 drivers/net/wireless/mac80211_hwsim.c                          | 1 +
 drivers/net/wireless/marvell/libertas_tf/main.c                | 1 +
 drivers/net/wireless/marvell/mwl8k.c                           | 1 +
 drivers/net/wireless/mediatek/mt7601u/main.c                   | 1 +
 drivers/net/wireless/purelifi/plfxlc/mac.c                     | 1 +
 drivers/net/wireless/ralink/rt2x00/rt2400pci.c                 | 1 +
 drivers/net/wireless/ralink/rt2x00/rt2500pci.c                 | 1 +
 drivers/net/wireless/ralink/rt2x00/rt2500usb.c                 | 1 +
 drivers/net/wireless/ralink/rt2x00/rt2800pci.c                 | 1 +
 drivers/net/wireless/ralink/rt2x00/rt2800soc.c                 | 1 +
 drivers/net/wireless/ralink/rt2x00/rt2800usb.c                 | 1 +
 drivers/net/wireless/ralink/rt2x00/rt61pci.c                   | 1 +
 drivers/net/wireless/ralink/rt2x00/rt73usb.c                   | 1 +
 drivers/net/wireless/realtek/rtl818x/rtl8180/dev.c             | 1 +
 drivers/net/wireless/realtek/rtl818x/rtl8187/dev.c             | 1 +
 drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c          | 1 +
 drivers/net/wireless/realtek/rtlwifi/core.c                    | 1 +
 drivers/net/wireless/realtek/rtw88/mac80211.c                  | 1 +
 drivers/net/wireless/realtek/rtw89/mac80211.c                  | 1 +
 drivers/net/wireless/rsi/rsi_91x_mac80211.c                    | 1 +
 drivers/net/wireless/silabs/wfx/main.c                         | 1 +
 drivers/net/wireless/st/cw1200/main.c                          | 1 +
 drivers/net/wireless/ti/wl1251/main.c                          | 1 +
 drivers/net/wireless/ti/wlcore/main.c                          | 1 +
 drivers/net/wireless/zydas/zd1211rw/zd_mac.c                   | 1 +
 40 files changed, 40 insertions(+)

diff --git a/drivers/net/wireless/admtek/adm8211.c b/drivers/net/wireless/admtek/adm8211.c
index 6bee16b207d1..2fceea9f6550 100644
--- a/drivers/net/wireless/admtek/adm8211.c
+++ b/drivers/net/wireless/admtek/adm8211.c
@@ -1760,6 +1760,7 @@ static int adm8211_alloc_rings(struct ieee80211_hw *dev)
 
 static const struct ieee80211_ops adm8211_ops = {
 	.tx			= adm8211_tx,
+	.wake_tx_queue		= ieee80211_handle_wake_tx_queue,
 	.start			= adm8211_start,
 	.stop			= adm8211_stop,
 	.add_interface		= adm8211_add_interface,
diff --git a/drivers/net/wireless/ath/ar5523/ar5523.c b/drivers/net/wireless/ath/ar5523/ar5523.c
index 6f937d2cc126..a184c09d2f0f 100644
--- a/drivers/net/wireless/ath/ar5523/ar5523.c
+++ b/drivers/net/wireless/ath/ar5523/ar5523.c
@@ -1355,6 +1355,7 @@ static const struct ieee80211_ops ar5523_ops = {
 	.start			= ar5523_start,
 	.stop			= ar5523_stop,
 	.tx			= ar5523_tx,
+	.wake_tx_queue		= ieee80211_handle_wake_tx_queue,
 	.set_rts_threshold	= ar5523_set_rts_threshold,
 	.add_interface		= ar5523_add_interface,
 	.remove_interface	= ar5523_remove_interface,
diff --git a/drivers/net/wireless/ath/ath11k/mac.c b/drivers/net/wireless/ath/ath11k/mac.c
index 84d956ad4093..8094384b8616 100644
--- a/drivers/net/wireless/ath/ath11k/mac.c
+++ b/drivers/net/wireless/ath/ath11k/mac.c
@@ -8538,6 +8538,7 @@ static int ath11k_mac_op_get_txpower(struct ieee80211_hw *hw,
 
 static const struct ieee80211_ops ath11k_ops = {
 	.tx				= ath11k_mac_op_tx,
+	.wake_tx_queue			= ieee80211_handle_wake_tx_queue,
 	.start                          = ath11k_mac_op_start,
 	.stop                           = ath11k_mac_op_stop,
 	.reconfig_complete              = ath11k_mac_op_reconfig_complete,
diff --git a/drivers/net/wireless/ath/ath5k/mac80211-ops.c b/drivers/net/wireless/ath/ath5k/mac80211-ops.c
index ed5d2160a72a..11ed30d6b595 100644
--- a/drivers/net/wireless/ath/ath5k/mac80211-ops.c
+++ b/drivers/net/wireless/ath/ath5k/mac80211-ops.c
@@ -781,6 +781,7 @@ static int ath5k_set_ringparam(struct ieee80211_hw *hw, u32 tx, u32 rx)
 
 const struct ieee80211_ops ath5k_hw_ops = {
 	.tx			= ath5k_tx,
+	.wake_tx_queue		= ieee80211_handle_wake_tx_queue,
 	.start			= ath5k_start,
 	.stop			= ath5k_stop,
 	.add_interface		= ath5k_add_interface,
diff --git a/drivers/net/wireless/ath/ath9k/htc_drv_main.c b/drivers/net/wireless/ath/ath9k/htc_drv_main.c
index 61875c45366b..51766de5ec3b 100644
--- a/drivers/net/wireless/ath/ath9k/htc_drv_main.c
+++ b/drivers/net/wireless/ath/ath9k/htc_drv_main.c
@@ -1870,6 +1870,7 @@ static void ath9k_htc_channel_switch_beacon(struct ieee80211_hw *hw,
 
 struct ieee80211_ops ath9k_htc_ops = {
 	.tx                 = ath9k_htc_tx,
+	.wake_tx_queue      = ieee80211_handle_wake_tx_queue,
 	.start              = ath9k_htc_start,
 	.stop               = ath9k_htc_stop,
 	.add_interface      = ath9k_htc_add_interface,
diff --git a/drivers/net/wireless/ath/carl9170/main.c b/drivers/net/wireless/ath/carl9170/main.c
index 1540e9827f48..524327d24964 100644
--- a/drivers/net/wireless/ath/carl9170/main.c
+++ b/drivers/net/wireless/ath/carl9170/main.c
@@ -1715,6 +1715,7 @@ static const struct ieee80211_ops carl9170_ops = {
 	.start			= carl9170_op_start,
 	.stop			= carl9170_op_stop,
 	.tx			= carl9170_op_tx,
+	.wake_tx_queue		= ieee80211_handle_wake_tx_queue,
 	.flush			= carl9170_op_flush,
 	.add_interface		= carl9170_op_add_interface,
 	.remove_interface	= carl9170_op_remove_interface,
diff --git a/drivers/net/wireless/ath/wcn36xx/main.c b/drivers/net/wireless/ath/wcn36xx/main.c
index 6b8d2889d73f..3b79cc1c7c5b 100644
--- a/drivers/net/wireless/ath/wcn36xx/main.c
+++ b/drivers/net/wireless/ath/wcn36xx/main.c
@@ -1361,6 +1361,7 @@ static const struct ieee80211_ops wcn36xx_ops = {
 	.prepare_multicast	= wcn36xx_prepare_multicast,
 	.configure_filter       = wcn36xx_configure_filter,
 	.tx			= wcn36xx_tx,
+	.wake_tx_queue		= ieee80211_handle_wake_tx_queue,
 	.set_key		= wcn36xx_set_key,
 	.hw_scan		= wcn36xx_hw_scan,
 	.cancel_hw_scan		= wcn36xx_cancel_hw_scan,
diff --git a/drivers/net/wireless/atmel/at76c50x-usb.c b/drivers/net/wireless/atmel/at76c50x-usb.c
index 24e609c1f523..009bca34ece3 100644
--- a/drivers/net/wireless/atmel/at76c50x-usb.c
+++ b/drivers/net/wireless/atmel/at76c50x-usb.c
@@ -2179,6 +2179,7 @@ static int at76_set_key(struct ieee80211_hw *hw, enum set_key_cmd cmd,
 
 static const struct ieee80211_ops at76_ops = {
 	.tx = at76_mac80211_tx,
+	.wake_tx_queue = ieee80211_handle_wake_tx_queue,
 	.add_interface = at76_add_interface,
 	.remove_interface = at76_remove_interface,
 	.config = at76_config,
diff --git a/drivers/net/wireless/broadcom/b43/main.c b/drivers/net/wireless/broadcom/b43/main.c
index b2539a916fd0..298febbdffc0 100644
--- a/drivers/net/wireless/broadcom/b43/main.c
+++ b/drivers/net/wireless/broadcom/b43/main.c
@@ -5171,6 +5171,7 @@ static int b43_op_get_survey(struct ieee80211_hw *hw, int idx,
 
 static const struct ieee80211_ops b43_hw_ops = {
 	.tx			= b43_op_tx,
+	.wake_tx_queue		= ieee80211_handle_wake_tx_queue,
 	.conf_tx		= b43_op_conf_tx,
 	.add_interface		= b43_op_add_interface,
 	.remove_interface	= b43_op_remove_interface,
diff --git a/drivers/net/wireless/broadcom/b43legacy/main.c b/drivers/net/wireless/broadcom/b43legacy/main.c
index 4022c544aefe..760136638a95 100644
--- a/drivers/net/wireless/broadcom/b43legacy/main.c
+++ b/drivers/net/wireless/broadcom/b43legacy/main.c
@@ -3532,6 +3532,7 @@ static int b43legacy_op_get_survey(struct ieee80211_hw *hw, int idx,
 
 static const struct ieee80211_ops b43legacy_hw_ops = {
 	.tx			= b43legacy_op_tx,
+	.wake_tx_queue		= ieee80211_handle_wake_tx_queue,
 	.conf_tx		= b43legacy_op_conf_tx,
 	.add_interface		= b43legacy_op_add_interface,
 	.remove_interface	= b43legacy_op_remove_interface,
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmsmac/mac80211_if.c b/drivers/net/wireless/broadcom/brcm80211/brcmsmac/mac80211_if.c
index a4034d44609b..a8333e6adbda 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmsmac/mac80211_if.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmsmac/mac80211_if.c
@@ -962,6 +962,7 @@ static int brcms_ops_beacon_set_tim(struct ieee80211_hw *hw,
 
 static const struct ieee80211_ops brcms_ops = {
 	.tx = brcms_ops_tx,
+	.wake_tx_queue = ieee80211_handle_wake_tx_queue,
 	.start = brcms_ops_start,
 	.stop = brcms_ops_stop,
 	.add_interface = brcms_ops_add_interface,
diff --git a/drivers/net/wireless/intel/iwlegacy/3945-mac.c b/drivers/net/wireless/intel/iwlegacy/3945-mac.c
index 7352d5b2095f..c4503308f3b0 100644
--- a/drivers/net/wireless/intel/iwlegacy/3945-mac.c
+++ b/drivers/net/wireless/intel/iwlegacy/3945-mac.c
@@ -3435,6 +3435,7 @@ static const struct attribute_group il3945_attribute_group = {
 
 static struct ieee80211_ops il3945_mac_ops __ro_after_init = {
 	.tx = il3945_mac_tx,
+	.wake_tx_queue = ieee80211_handle_wake_tx_queue,
 	.start = il3945_mac_start,
 	.stop = il3945_mac_stop,
 	.add_interface = il_mac_add_interface,
diff --git a/drivers/net/wireless/intel/iwlegacy/4965-mac.c b/drivers/net/wireless/intel/iwlegacy/4965-mac.c
index 943de47170c7..721b4042b4bf 100644
--- a/drivers/net/wireless/intel/iwlegacy/4965-mac.c
+++ b/drivers/net/wireless/intel/iwlegacy/4965-mac.c
@@ -6304,6 +6304,7 @@ il4965_tx_queue_set_status(struct il_priv *il, struct il_tx_queue *txq,
 
 static const struct ieee80211_ops il4965_mac_ops = {
 	.tx = il4965_mac_tx,
+	.wake_tx_queue = ieee80211_handle_wake_tx_queue,
 	.start = il4965_mac_start,
 	.stop = il4965_mac_stop,
 	.add_interface = il_mac_add_interface,
diff --git a/drivers/net/wireless/intel/iwlwifi/dvm/mac80211.c b/drivers/net/wireless/intel/iwlwifi/dvm/mac80211.c
index f4070fddc8c7..b1939ff275b5 100644
--- a/drivers/net/wireless/intel/iwlwifi/dvm/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/dvm/mac80211.c
@@ -1571,6 +1571,7 @@ static void iwlagn_mac_sta_notify(struct ieee80211_hw *hw,
 
 const struct ieee80211_ops iwlagn_hw_ops = {
 	.tx = iwlagn_mac_tx,
+	.wake_tx_queue = ieee80211_handle_wake_tx_queue,
 	.start = iwlagn_mac_start,
 	.stop = iwlagn_mac_stop,
 #ifdef CONFIG_PM_SLEEP
diff --git a/drivers/net/wireless/intersil/p54/main.c b/drivers/net/wireless/intersil/p54/main.c
index e127453ab51a..c6084683aedd 100644
--- a/drivers/net/wireless/intersil/p54/main.c
+++ b/drivers/net/wireless/intersil/p54/main.c
@@ -705,6 +705,7 @@ static void p54_set_coverage_class(struct ieee80211_hw *dev,
 
 static const struct ieee80211_ops p54_ops = {
 	.tx			= p54_tx_80211,
+	.wake_tx_queue		= ieee80211_handle_wake_tx_queue,
 	.start			= p54_start,
 	.stop			= p54_stop,
 	.add_interface		= p54_add_interface,
diff --git a/drivers/net/wireless/mac80211_hwsim.c b/drivers/net/wireless/mac80211_hwsim.c
index df51b5b1f171..19c7fa29ec78 100644
--- a/drivers/net/wireless/mac80211_hwsim.c
+++ b/drivers/net/wireless/mac80211_hwsim.c
@@ -3104,6 +3104,7 @@ static int mac80211_hwsim_change_sta_links(struct ieee80211_hw *hw,
 
 #define HWSIM_COMMON_OPS					\
 	.tx = mac80211_hwsim_tx,				\
+	.wake_tx_queue = ieee80211_handle_wake_tx_queue,	\
 	.start = mac80211_hwsim_start,				\
 	.stop = mac80211_hwsim_stop,				\
 	.add_interface = mac80211_hwsim_add_interface,		\
diff --git a/drivers/net/wireless/marvell/libertas_tf/main.c b/drivers/net/wireless/marvell/libertas_tf/main.c
index 74c4942b9a5a..199d33ed3bb9 100644
--- a/drivers/net/wireless/marvell/libertas_tf/main.c
+++ b/drivers/net/wireless/marvell/libertas_tf/main.c
@@ -474,6 +474,7 @@ static int lbtf_op_get_survey(struct ieee80211_hw *hw, int idx,
 
 static const struct ieee80211_ops lbtf_ops = {
 	.tx			= lbtf_op_tx,
+	.wake_tx_queue		= ieee80211_handle_wake_tx_queue,
 	.start			= lbtf_op_start,
 	.stop			= lbtf_op_stop,
 	.add_interface		= lbtf_op_add_interface,
diff --git a/drivers/net/wireless/marvell/mwl8k.c b/drivers/net/wireless/marvell/mwl8k.c
index 4dc7e2e53b81..13bcb123d122 100644
--- a/drivers/net/wireless/marvell/mwl8k.c
+++ b/drivers/net/wireless/marvell/mwl8k.c
@@ -5611,6 +5611,7 @@ static void mwl8k_sw_scan_complete(struct ieee80211_hw *hw,
 
 static const struct ieee80211_ops mwl8k_ops = {
 	.tx			= mwl8k_tx,
+	.wake_tx_queue		= ieee80211_handle_wake_tx_queue,
 	.start			= mwl8k_start,
 	.stop			= mwl8k_stop,
 	.add_interface		= mwl8k_add_interface,
diff --git a/drivers/net/wireless/mediatek/mt7601u/main.c b/drivers/net/wireless/mediatek/mt7601u/main.c
index 6c9c7a61c5c9..c8d332456a6b 100644
--- a/drivers/net/wireless/mediatek/mt7601u/main.c
+++ b/drivers/net/wireless/mediatek/mt7601u/main.c
@@ -406,6 +406,7 @@ mt76_sta_rate_tbl_update(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 
 const struct ieee80211_ops mt7601u_ops = {
 	.tx = mt7601u_tx,
+	.wake_tx_queue = ieee80211_handle_wake_tx_queue,
 	.start = mt7601u_start,
 	.stop = mt7601u_stop,
 	.add_interface = mt7601u_add_interface,
diff --git a/drivers/net/wireless/purelifi/plfxlc/mac.c b/drivers/net/wireless/purelifi/plfxlc/mac.c
index d3cdffbded69..94ee831b5de3 100644
--- a/drivers/net/wireless/purelifi/plfxlc/mac.c
+++ b/drivers/net/wireless/purelifi/plfxlc/mac.c
@@ -686,6 +686,7 @@ static int plfxlc_set_rts_threshold(struct ieee80211_hw *hw, u32 value)
 
 static const struct ieee80211_ops plfxlc_ops = {
 	.tx = plfxlc_op_tx,
+	.wake_tx_queue = ieee80211_handle_wake_tx_queue,
 	.start = plfxlc_op_start,
 	.stop = plfxlc_op_stop,
 	.add_interface = plfxlc_op_add_interface,
diff --git a/drivers/net/wireless/ralink/rt2x00/rt2400pci.c b/drivers/net/wireless/ralink/rt2x00/rt2400pci.c
index 273c5eac3362..bb5685826c18 100644
--- a/drivers/net/wireless/ralink/rt2x00/rt2400pci.c
+++ b/drivers/net/wireless/ralink/rt2x00/rt2400pci.c
@@ -1706,6 +1706,7 @@ static int rt2400pci_tx_last_beacon(struct ieee80211_hw *hw)
 
 static const struct ieee80211_ops rt2400pci_mac80211_ops = {
 	.tx			= rt2x00mac_tx,
+	.wake_tx_queue		= ieee80211_handle_wake_tx_queue,
 	.start			= rt2x00mac_start,
 	.stop			= rt2x00mac_stop,
 	.add_interface		= rt2x00mac_add_interface,
diff --git a/drivers/net/wireless/ralink/rt2x00/rt2500pci.c b/drivers/net/wireless/ralink/rt2x00/rt2500pci.c
index 8faa0a80e73a..43d2c1931d2b 100644
--- a/drivers/net/wireless/ralink/rt2x00/rt2500pci.c
+++ b/drivers/net/wireless/ralink/rt2x00/rt2500pci.c
@@ -2004,6 +2004,7 @@ static int rt2500pci_tx_last_beacon(struct ieee80211_hw *hw)
 
 static const struct ieee80211_ops rt2500pci_mac80211_ops = {
 	.tx			= rt2x00mac_tx,
+	.wake_tx_queue		= ieee80211_handle_wake_tx_queue,
 	.start			= rt2x00mac_start,
 	.stop			= rt2x00mac_stop,
 	.add_interface		= rt2x00mac_add_interface,
diff --git a/drivers/net/wireless/ralink/rt2x00/rt2500usb.c b/drivers/net/wireless/ralink/rt2x00/rt2500usb.c
index bb5ed6630645..a2696e24ae2b 100644
--- a/drivers/net/wireless/ralink/rt2x00/rt2500usb.c
+++ b/drivers/net/wireless/ralink/rt2x00/rt2500usb.c
@@ -1795,6 +1795,7 @@ static int rt2500usb_probe_hw(struct rt2x00_dev *rt2x00dev)
 
 static const struct ieee80211_ops rt2500usb_mac80211_ops = {
 	.tx			= rt2x00mac_tx,
+	.wake_tx_queue		= ieee80211_handle_wake_tx_queue,
 	.start			= rt2x00mac_start,
 	.stop			= rt2x00mac_stop,
 	.add_interface		= rt2x00mac_add_interface,
diff --git a/drivers/net/wireless/ralink/rt2x00/rt2800pci.c b/drivers/net/wireless/ralink/rt2x00/rt2800pci.c
index 1fde0e767ce3..dcb56f708a5f 100644
--- a/drivers/net/wireless/ralink/rt2x00/rt2800pci.c
+++ b/drivers/net/wireless/ralink/rt2x00/rt2800pci.c
@@ -288,6 +288,7 @@ static int rt2800pci_read_eeprom(struct rt2x00_dev *rt2x00dev)
 
 static const struct ieee80211_ops rt2800pci_mac80211_ops = {
 	.tx			= rt2x00mac_tx,
+	.wake_tx_queue		= ieee80211_handle_wake_tx_queue,
 	.start			= rt2x00mac_start,
 	.stop			= rt2x00mac_stop,
 	.add_interface		= rt2x00mac_add_interface,
diff --git a/drivers/net/wireless/ralink/rt2x00/rt2800soc.c b/drivers/net/wireless/ralink/rt2x00/rt2800soc.c
index bbfe1425c0ee..7118d4f9038d 100644
--- a/drivers/net/wireless/ralink/rt2x00/rt2800soc.c
+++ b/drivers/net/wireless/ralink/rt2x00/rt2800soc.c
@@ -133,6 +133,7 @@ static int rt2800soc_write_firmware(struct rt2x00_dev *rt2x00dev,
 
 static const struct ieee80211_ops rt2800soc_mac80211_ops = {
 	.tx			= rt2x00mac_tx,
+	.wake_tx_queue		= ieee80211_handle_wake_tx_queue,
 	.start			= rt2x00mac_start,
 	.stop			= rt2x00mac_stop,
 	.add_interface		= rt2x00mac_add_interface,
diff --git a/drivers/net/wireless/ralink/rt2x00/rt2800usb.c b/drivers/net/wireless/ralink/rt2x00/rt2800usb.c
index a3ffd1b0c9bc..b2a8e75a901b 100644
--- a/drivers/net/wireless/ralink/rt2x00/rt2800usb.c
+++ b/drivers/net/wireless/ralink/rt2x00/rt2800usb.c
@@ -630,6 +630,7 @@ static int rt2800usb_probe_hw(struct rt2x00_dev *rt2x00dev)
 
 static const struct ieee80211_ops rt2800usb_mac80211_ops = {
 	.tx			= rt2x00mac_tx,
+	.wake_tx_queue		= ieee80211_handle_wake_tx_queue,
 	.start			= rt2x00mac_start,
 	.stop			= rt2x00mac_stop,
 	.add_interface		= rt2x00mac_add_interface,
diff --git a/drivers/net/wireless/ralink/rt2x00/rt61pci.c b/drivers/net/wireless/ralink/rt2x00/rt61pci.c
index d92f9eb07dc9..b1679a8e4610 100644
--- a/drivers/net/wireless/ralink/rt2x00/rt61pci.c
+++ b/drivers/net/wireless/ralink/rt2x00/rt61pci.c
@@ -2873,6 +2873,7 @@ static u64 rt61pci_get_tsf(struct ieee80211_hw *hw, struct ieee80211_vif *vif)
 
 static const struct ieee80211_ops rt61pci_mac80211_ops = {
 	.tx			= rt2x00mac_tx,
+	.wake_tx_queue		= ieee80211_handle_wake_tx_queue,
 	.start			= rt2x00mac_start,
 	.stop			= rt2x00mac_stop,
 	.add_interface		= rt2x00mac_add_interface,
diff --git a/drivers/net/wireless/ralink/rt2x00/rt73usb.c b/drivers/net/wireless/ralink/rt2x00/rt73usb.c
index e3269fd7c59e..e2f4f40cb7ee 100644
--- a/drivers/net/wireless/ralink/rt2x00/rt73usb.c
+++ b/drivers/net/wireless/ralink/rt2x00/rt73usb.c
@@ -2292,6 +2292,7 @@ static u64 rt73usb_get_tsf(struct ieee80211_hw *hw, struct ieee80211_vif *vif)
 
 static const struct ieee80211_ops rt73usb_mac80211_ops = {
 	.tx			= rt2x00mac_tx,
+	.wake_tx_queue		= ieee80211_handle_wake_tx_queue,
 	.start			= rt2x00mac_start,
 	.stop			= rt2x00mac_stop,
 	.add_interface		= rt2x00mac_add_interface,
diff --git a/drivers/net/wireless/realtek/rtl818x/rtl8180/dev.c b/drivers/net/wireless/realtek/rtl818x/rtl8180/dev.c
index cdfe08078c57..f6c25a52b69a 100644
--- a/drivers/net/wireless/realtek/rtl818x/rtl8180/dev.c
+++ b/drivers/net/wireless/realtek/rtl818x/rtl8180/dev.c
@@ -1608,6 +1608,7 @@ static void rtl8180_configure_filter(struct ieee80211_hw *dev,
 
 static const struct ieee80211_ops rtl8180_ops = {
 	.tx			= rtl8180_tx,
+	.wake_tx_queue		= ieee80211_handle_wake_tx_queue,
 	.start			= rtl8180_start,
 	.stop			= rtl8180_stop,
 	.add_interface		= rtl8180_add_interface,
diff --git a/drivers/net/wireless/realtek/rtl818x/rtl8187/dev.c b/drivers/net/wireless/realtek/rtl818x/rtl8187/dev.c
index c0f6e9c6d03e..04945f905d6d 100644
--- a/drivers/net/wireless/realtek/rtl818x/rtl8187/dev.c
+++ b/drivers/net/wireless/realtek/rtl818x/rtl8187/dev.c
@@ -1378,6 +1378,7 @@ static int rtl8187_conf_tx(struct ieee80211_hw *dev,
 
 static const struct ieee80211_ops rtl8187_ops = {
 	.tx			= rtl8187_tx,
+	.wake_tx_queue		= ieee80211_handle_wake_tx_queue,
 	.start			= rtl8187_start,
 	.stop			= rtl8187_stop,
 	.add_interface		= rtl8187_add_interface,
diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
index 71a391bba9e2..9ee1a5bb1195 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
+++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
@@ -6644,6 +6644,7 @@ static void rtl8xxxu_stop(struct ieee80211_hw *hw)
 
 static const struct ieee80211_ops rtl8xxxu_ops = {
 	.tx = rtl8xxxu_tx,
+	.wake_tx_queue = ieee80211_handle_wake_tx_queue,
 	.add_interface = rtl8xxxu_add_interface,
 	.remove_interface = rtl8xxxu_remove_interface,
 	.config = rtl8xxxu_config,
diff --git a/drivers/net/wireless/realtek/rtlwifi/core.c b/drivers/net/wireless/realtek/rtlwifi/core.c
index ca01270944fe..6f10727cdb94 100644
--- a/drivers/net/wireless/realtek/rtlwifi/core.c
+++ b/drivers/net/wireless/realtek/rtlwifi/core.c
@@ -1912,6 +1912,7 @@ const struct ieee80211_ops rtl_ops = {
 	.start = rtl_op_start,
 	.stop = rtl_op_stop,
 	.tx = rtl_op_tx,
+	.wake_tx_queue = ieee80211_handle_wake_tx_queue,
 	.add_interface = rtl_op_add_interface,
 	.remove_interface = rtl_op_remove_interface,
 	.change_interface = rtl_op_change_interface,
diff --git a/drivers/net/wireless/realtek/rtw88/mac80211.c b/drivers/net/wireless/realtek/rtw88/mac80211.c
index 07578ccc4bab..bf917ef20e3b 100644
--- a/drivers/net/wireless/realtek/rtw88/mac80211.c
+++ b/drivers/net/wireless/realtek/rtw88/mac80211.c
@@ -896,6 +896,7 @@ static void rtw_ops_sta_rc_update(struct ieee80211_hw *hw,
 
 const struct ieee80211_ops rtw_ops = {
 	.tx			= rtw_ops_tx,
+	.wake_tx_queue		= ieee80211_handle_wake_tx_queue,
 	.wake_tx_queue		= rtw_ops_wake_tx_queue,
 	.start			= rtw_ops_start,
 	.stop			= rtw_ops_stop,
diff --git a/drivers/net/wireless/realtek/rtw89/mac80211.c b/drivers/net/wireless/realtek/rtw89/mac80211.c
index a296bfa8188f..91674c63b9f9 100644
--- a/drivers/net/wireless/realtek/rtw89/mac80211.c
+++ b/drivers/net/wireless/realtek/rtw89/mac80211.c
@@ -918,6 +918,7 @@ static int rtw89_ops_set_tid_config(struct ieee80211_hw *hw,
 
 const struct ieee80211_ops rtw89_ops = {
 	.tx			= rtw89_ops_tx,
+	.wake_tx_queue		= ieee80211_handle_wake_tx_queue,
 	.wake_tx_queue		= rtw89_ops_wake_tx_queue,
 	.start			= rtw89_ops_start,
 	.stop			= rtw89_ops_stop,
diff --git a/drivers/net/wireless/rsi/rsi_91x_mac80211.c b/drivers/net/wireless/rsi/rsi_91x_mac80211.c
index 2fbec51c8f94..bc1f038d1655 100644
--- a/drivers/net/wireless/rsi/rsi_91x_mac80211.c
+++ b/drivers/net/wireless/rsi/rsi_91x_mac80211.c
@@ -1958,6 +1958,7 @@ static int rsi_mac80211_resume(struct ieee80211_hw *hw)
 
 static const struct ieee80211_ops mac80211_ops = {
 	.tx = rsi_mac80211_tx,
+	.wake_tx_queue = ieee80211_handle_wake_tx_queue,
 	.start = rsi_mac80211_start,
 	.stop = rsi_mac80211_stop,
 	.add_interface = rsi_mac80211_add_interface,
diff --git a/drivers/net/wireless/silabs/wfx/main.c b/drivers/net/wireless/silabs/wfx/main.c
index 84d82ddded56..6b9864e478ac 100644
--- a/drivers/net/wireless/silabs/wfx/main.c
+++ b/drivers/net/wireless/silabs/wfx/main.c
@@ -128,6 +128,7 @@ static const struct ieee80211_ops wfx_ops = {
 	.remove_interface        = wfx_remove_interface,
 	.config                  = wfx_config,
 	.tx                      = wfx_tx,
+	.wake_tx_queue           = ieee80211_handle_wake_tx_queue,
 	.join_ibss               = wfx_join_ibss,
 	.leave_ibss              = wfx_leave_ibss,
 	.conf_tx                 = wfx_conf_tx,
diff --git a/drivers/net/wireless/st/cw1200/main.c b/drivers/net/wireless/st/cw1200/main.c
index 326b1cc1d2bc..381013e0db63 100644
--- a/drivers/net/wireless/st/cw1200/main.c
+++ b/drivers/net/wireless/st/cw1200/main.c
@@ -209,6 +209,7 @@ static const struct ieee80211_ops cw1200_ops = {
 	.remove_interface	= cw1200_remove_interface,
 	.change_interface	= cw1200_change_interface,
 	.tx			= cw1200_tx,
+	.wake_tx_queue		= ieee80211_handle_wake_tx_queue,
 	.hw_scan		= cw1200_hw_scan,
 	.set_tim		= cw1200_set_tim,
 	.sta_notify		= cw1200_sta_notify,
diff --git a/drivers/net/wireless/ti/wl1251/main.c b/drivers/net/wireless/ti/wl1251/main.c
index 289371689a8d..eded284af600 100644
--- a/drivers/net/wireless/ti/wl1251/main.c
+++ b/drivers/net/wireless/ti/wl1251/main.c
@@ -1359,6 +1359,7 @@ static const struct ieee80211_ops wl1251_ops = {
 	.prepare_multicast = wl1251_op_prepare_multicast,
 	.configure_filter = wl1251_op_configure_filter,
 	.tx = wl1251_op_tx,
+	.wake_tx_queue = ieee80211_handle_wake_tx_queue,
 	.set_key = wl1251_op_set_key,
 	.hw_scan = wl1251_op_hw_scan,
 	.bss_info_changed = wl1251_op_bss_info_changed,
diff --git a/drivers/net/wireless/ti/wlcore/main.c b/drivers/net/wireless/ti/wlcore/main.c
index 3e3922d4c788..f1f1b3542b6c 100644
--- a/drivers/net/wireless/ti/wlcore/main.c
+++ b/drivers/net/wireless/ti/wlcore/main.c
@@ -5942,6 +5942,7 @@ static const struct ieee80211_ops wl1271_ops = {
 	.prepare_multicast = wl1271_op_prepare_multicast,
 	.configure_filter = wl1271_op_configure_filter,
 	.tx = wl1271_op_tx,
+	.wake_tx_queue = ieee80211_handle_wake_tx_queue,
 	.set_key = wlcore_op_set_key,
 	.hw_scan = wl1271_op_hw_scan,
 	.cancel_hw_scan = wl1271_op_cancel_hw_scan,
diff --git a/drivers/net/wireless/zydas/zd1211rw/zd_mac.c b/drivers/net/wireless/zydas/zd1211rw/zd_mac.c
index 80b905d49954..5d534e15a844 100644
--- a/drivers/net/wireless/zydas/zd1211rw/zd_mac.c
+++ b/drivers/net/wireless/zydas/zd1211rw/zd_mac.c
@@ -1344,6 +1344,7 @@ static u64 zd_op_get_tsf(struct ieee80211_hw *hw, struct ieee80211_vif *vif)
 
 static const struct ieee80211_ops zd_ops = {
 	.tx			= zd_op_tx,
+	.wake_tx_queue		= ieee80211_handle_wake_tx_queue,
 	.start			= zd_op_start,
 	.stop			= zd_op_stop,
 	.add_interface		= zd_op_add_interface,
-- 
2.37.3

