Return-Path: <linux-wireless+bounces-17-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 80CDA7F6907
	for <lists+linux-wireless@lfdr.de>; Thu, 23 Nov 2023 23:28:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3039C28186E
	for <lists+linux-wireless@lfdr.de>; Thu, 23 Nov 2023 22:28:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 321AD4E60E;
	Thu, 23 Nov 2023 22:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="agsZp9AB"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:242:246e::2])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5B53D71
	for <linux-wireless@vger.kernel.org>; Thu, 23 Nov 2023 14:28:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=KsHGOHAVU4zUy3gG9VAtD78Twki72dGPrHZpJTFv4Tc=;
	t=1700778481; x=1701988081; b=agsZp9ABufsuaQhspQtswcO5DG9/+tu+/ImTtCfQj6GIbPz
	U6DXQVgpLxi8u45lJ+ynS3lCwNZ36Us3NPx5nUFTf5DAIphv/Jl33m3PItQ9i3D2VEb+hgQqu/0sD
	DbRigEqQ+tqPa+9VDfR9uYiiFNM75/aJBCoAHNy7tJBHOK4xjz8myNCg6JfKNhxdoG0OJppm1d/aV
	Znm4sXQ1ClSXya8Y75eUZCksgwupWxDYLfRfGTGXI/jezYu/TOIOUyh5Xr45vn1cQxYbqWhUD4LaX
	utOAAaCCE+hqOmLc6Rq1PcwzfM8QoV60k7BfXczedH+5yigskm0qBdxbOVg0uVPQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1r6IAw-00000001Y53-3CpF;
	Thu, 23 Nov 2023 23:27:59 +0100
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [RFC PATCH v2 09/13] wifi: mac80211: simplify non-chanctx drivers
Date: Thu, 23 Nov 2023 23:14:46 +0100
Message-ID: <20231123231436.ce4c2648b190.I60d093b2fc81ca1853925a4d0ac3a2337d5baa5b@changeid>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231123221436.143254-14-johannes@sipsolutions.net>
References: <20231123221436.143254-14-johannes@sipsolutions.net>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

There are still surprisingly many non-chanctx drivers, but in
mac80211 that code is a bit awkward. Simplify this by having
those drivers assign 'emulated' ops, so that the mac80211 code
can be more unified between non-chanctx/chanctx drivers. This
cuts the number of places caring about it by about 15, which
are scattered across - now they're fewer and no longer in the
channel context handling.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
v2:
 - handle drivers that NULL out their chanctx ops (thanks PK!)
v3:
 - force reconfig in scan, at least hwsim depends on that to
   collect survey data
---
 drivers/net/wireless/admtek/adm8211.c         |   4 +
 drivers/net/wireless/ath/ar5523/ar5523.c      |   4 +
 drivers/net/wireless/ath/ath5k/mac80211-ops.c |   4 +
 drivers/net/wireless/ath/ath9k/htc_drv_main.c |   4 +
 drivers/net/wireless/ath/ath9k/main.c         |   4 +
 drivers/net/wireless/ath/carl9170/main.c      |   4 +
 drivers/net/wireless/ath/wcn36xx/main.c       |   4 +
 drivers/net/wireless/atmel/at76c50x-usb.c     |   4 +
 drivers/net/wireless/broadcom/b43/main.c      |   4 +
 .../net/wireless/broadcom/b43legacy/main.c    |   4 +
 .../broadcom/brcm80211/brcmsmac/mac80211_if.c |   4 +
 .../net/wireless/intel/iwlegacy/3945-mac.c    |   4 +
 .../net/wireless/intel/iwlegacy/4965-mac.c    |   4 +
 .../net/wireless/intel/iwlwifi/dvm/mac80211.c |   4 +
 drivers/net/wireless/intersil/p54/main.c      |   4 +
 .../net/wireless/marvell/libertas_tf/main.c   |   4 +
 drivers/net/wireless/marvell/mwl8k.c          |   4 +
 .../net/wireless/mediatek/mt76/mt7603/main.c  |   4 +
 .../net/wireless/mediatek/mt76/mt76x0/pci.c   |   4 +
 .../net/wireless/mediatek/mt76/mt76x0/usb.c   |   4 +
 .../wireless/mediatek/mt76/mt76x2/pci_main.c  |   4 +
 .../wireless/mediatek/mt76/mt76x2/usb_main.c  |   4 +
 .../net/wireless/mediatek/mt76/mt792x_core.c  |   7 +-
 .../net/wireless/mediatek/mt76/mt7996/main.c  |   4 +
 drivers/net/wireless/mediatek/mt7601u/main.c  |   4 +
 drivers/net/wireless/purelifi/plfxlc/mac.c    |   4 +
 .../net/wireless/ralink/rt2x00/rt2400pci.c    |   4 +
 .../net/wireless/ralink/rt2x00/rt2500pci.c    |   4 +
 .../net/wireless/ralink/rt2x00/rt2500usb.c    |   4 +
 .../net/wireless/ralink/rt2x00/rt2800pci.c    |   4 +
 .../net/wireless/ralink/rt2x00/rt2800soc.c    |   4 +
 .../net/wireless/ralink/rt2x00/rt2800usb.c    |   4 +
 drivers/net/wireless/ralink/rt2x00/rt61pci.c  |   4 +
 drivers/net/wireless/ralink/rt2x00/rt73usb.c  |   4 +
 .../wireless/realtek/rtl818x/rtl8180/dev.c    |   4 +
 .../wireless/realtek/rtl818x/rtl8187/dev.c    |   4 +
 .../wireless/realtek/rtl8xxxu/rtl8xxxu_core.c |   4 +
 drivers/net/wireless/realtek/rtlwifi/core.c   |   4 +
 drivers/net/wireless/realtek/rtw88/mac80211.c |   4 +
 drivers/net/wireless/realtek/rtw89/core.c     |   7 +-
 drivers/net/wireless/rsi/rsi_91x_mac80211.c   |   4 +
 drivers/net/wireless/st/cw1200/main.c         |   4 +
 drivers/net/wireless/ti/wl1251/main.c         |   4 +
 drivers/net/wireless/virtual/mac80211_hwsim.c |   4 +
 drivers/net/wireless/zydas/zd1211rw/zd_mac.c  |   4 +
 drivers/staging/vt6655/device_main.c          |   4 +
 drivers/staging/vt6656/main_usb.c             |   4 +
 include/net/mac80211.h                        |  13 ++
 net/mac80211/cfg.c                            |  42 ++--
 net/mac80211/chan.c                           | 111 ++--------
 net/mac80211/ieee80211_i.h                    |   9 +-
 net/mac80211/iface.c                          |   6 +-
 net/mac80211/main.c                           | 205 +++++++++++++++---
 net/mac80211/mlme.c                           |   3 +-
 net/mac80211/offchannel.c                     |  21 +-
 net/mac80211/scan.c                           |  18 +-
 net/mac80211/tx.c                             |   2 -
 net/mac80211/util.c                           |  19 +-
 58 files changed, 438 insertions(+), 205 deletions(-)

diff --git a/drivers/net/wireless/admtek/adm8211.c b/drivers/net/wireless/admtek/adm8211.c
index 2fceea9f6550..e3fd48dd3909 100644
--- a/drivers/net/wireless/admtek/adm8211.c
+++ b/drivers/net/wireless/admtek/adm8211.c
@@ -1759,6 +1759,10 @@ static int adm8211_alloc_rings(struct ieee80211_hw *dev)
 }
 
 static const struct ieee80211_ops adm8211_ops = {
+	.add_chanctx = ieee80211_emulate_add_chanctx,
+	.remove_chanctx = ieee80211_emulate_remove_chanctx,
+	.change_chanctx = ieee80211_emulate_change_chanctx,
+	.switch_vif_chanctx = ieee80211_emulate_switch_vif_chanctx,
 	.tx			= adm8211_tx,
 	.wake_tx_queue		= ieee80211_handle_wake_tx_queue,
 	.start			= adm8211_start,
diff --git a/drivers/net/wireless/ath/ar5523/ar5523.c b/drivers/net/wireless/ath/ar5523/ar5523.c
index 43e0db78d42b..8f45127b4414 100644
--- a/drivers/net/wireless/ath/ar5523/ar5523.c
+++ b/drivers/net/wireless/ath/ar5523/ar5523.c
@@ -1358,6 +1358,10 @@ static void ar5523_configure_filter(struct ieee80211_hw *hw,
 }
 
 static const struct ieee80211_ops ar5523_ops = {
+	.add_chanctx = ieee80211_emulate_add_chanctx,
+	.remove_chanctx = ieee80211_emulate_remove_chanctx,
+	.change_chanctx = ieee80211_emulate_change_chanctx,
+	.switch_vif_chanctx = ieee80211_emulate_switch_vif_chanctx,
 	.start			= ar5523_start,
 	.stop			= ar5523_stop,
 	.tx			= ar5523_tx,
diff --git a/drivers/net/wireless/ath/ath5k/mac80211-ops.c b/drivers/net/wireless/ath/ath5k/mac80211-ops.c
index c630343ca4f9..eea4bda77608 100644
--- a/drivers/net/wireless/ath/ath5k/mac80211-ops.c
+++ b/drivers/net/wireless/ath/ath5k/mac80211-ops.c
@@ -779,6 +779,10 @@ static int ath5k_set_ringparam(struct ieee80211_hw *hw, u32 tx, u32 rx)
 
 
 const struct ieee80211_ops ath5k_hw_ops = {
+	.add_chanctx = ieee80211_emulate_add_chanctx,
+	.remove_chanctx = ieee80211_emulate_remove_chanctx,
+	.change_chanctx = ieee80211_emulate_change_chanctx,
+	.switch_vif_chanctx = ieee80211_emulate_switch_vif_chanctx,
 	.tx			= ath5k_tx,
 	.wake_tx_queue		= ieee80211_handle_wake_tx_queue,
 	.start			= ath5k_start,
diff --git a/drivers/net/wireless/ath/ath9k/htc_drv_main.c b/drivers/net/wireless/ath/ath9k/htc_drv_main.c
index 9a9b5212051a..b389e19381c4 100644
--- a/drivers/net/wireless/ath/ath9k/htc_drv_main.c
+++ b/drivers/net/wireless/ath/ath9k/htc_drv_main.c
@@ -1868,6 +1868,10 @@ static void ath9k_htc_channel_switch_beacon(struct ieee80211_hw *hw,
 }
 
 struct ieee80211_ops ath9k_htc_ops = {
+	.add_chanctx = ieee80211_emulate_add_chanctx,
+	.remove_chanctx = ieee80211_emulate_remove_chanctx,
+	.change_chanctx = ieee80211_emulate_change_chanctx,
+	.switch_vif_chanctx = ieee80211_emulate_switch_vif_chanctx,
 	.tx                 = ath9k_htc_tx,
 	.wake_tx_queue      = ieee80211_handle_wake_tx_queue,
 	.start              = ath9k_htc_start,
diff --git a/drivers/net/wireless/ath/ath9k/main.c b/drivers/net/wireless/ath/ath9k/main.c
index 1494feedb27d..af1ca279e188 100644
--- a/drivers/net/wireless/ath/ath9k/main.c
+++ b/drivers/net/wireless/ath/ath9k/main.c
@@ -2771,6 +2771,10 @@ static int ath9k_get_txpower(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 }
 
 struct ieee80211_ops ath9k_ops = {
+	.add_chanctx = ieee80211_emulate_add_chanctx,
+	.remove_chanctx = ieee80211_emulate_remove_chanctx,
+	.change_chanctx = ieee80211_emulate_change_chanctx,
+	.switch_vif_chanctx = ieee80211_emulate_switch_vif_chanctx,
 	.tx 		    = ath9k_tx,
 	.start 		    = ath9k_start,
 	.stop 		    = ath9k_stop,
diff --git a/drivers/net/wireless/ath/carl9170/main.c b/drivers/net/wireless/ath/carl9170/main.c
index 524327d24964..7e7797bf44b7 100644
--- a/drivers/net/wireless/ath/carl9170/main.c
+++ b/drivers/net/wireless/ath/carl9170/main.c
@@ -1712,6 +1712,10 @@ static bool carl9170_tx_frames_pending(struct ieee80211_hw *hw)
 }
 
 static const struct ieee80211_ops carl9170_ops = {
+	.add_chanctx = ieee80211_emulate_add_chanctx,
+	.remove_chanctx = ieee80211_emulate_remove_chanctx,
+	.change_chanctx = ieee80211_emulate_change_chanctx,
+	.switch_vif_chanctx = ieee80211_emulate_switch_vif_chanctx,
 	.start			= carl9170_op_start,
 	.stop			= carl9170_op_stop,
 	.tx			= carl9170_op_tx,
diff --git a/drivers/net/wireless/ath/wcn36xx/main.c b/drivers/net/wireless/ath/wcn36xx/main.c
index 2bd1163177f0..24a7ec2eaee1 100644
--- a/drivers/net/wireless/ath/wcn36xx/main.c
+++ b/drivers/net/wireless/ath/wcn36xx/main.c
@@ -1347,6 +1347,10 @@ static void wcn36xx_sta_statistics(struct ieee80211_hw *hw, struct ieee80211_vif
 }
 
 static const struct ieee80211_ops wcn36xx_ops = {
+	.add_chanctx = ieee80211_emulate_add_chanctx,
+	.remove_chanctx = ieee80211_emulate_remove_chanctx,
+	.change_chanctx = ieee80211_emulate_change_chanctx,
+	.switch_vif_chanctx = ieee80211_emulate_switch_vif_chanctx,
 	.start			= wcn36xx_start,
 	.stop			= wcn36xx_stop,
 	.add_interface		= wcn36xx_add_interface,
diff --git a/drivers/net/wireless/atmel/at76c50x-usb.c b/drivers/net/wireless/atmel/at76c50x-usb.c
index 447b51cff8f9..0b55a272bfd6 100644
--- a/drivers/net/wireless/atmel/at76c50x-usb.c
+++ b/drivers/net/wireless/atmel/at76c50x-usb.c
@@ -2178,6 +2178,10 @@ static int at76_set_key(struct ieee80211_hw *hw, enum set_key_cmd cmd,
 }
 
 static const struct ieee80211_ops at76_ops = {
+	.add_chanctx = ieee80211_emulate_add_chanctx,
+	.remove_chanctx = ieee80211_emulate_remove_chanctx,
+	.change_chanctx = ieee80211_emulate_change_chanctx,
+	.switch_vif_chanctx = ieee80211_emulate_switch_vif_chanctx,
 	.tx = at76_mac80211_tx,
 	.wake_tx_queue = ieee80211_handle_wake_tx_queue,
 	.add_interface = at76_add_interface,
diff --git a/drivers/net/wireless/broadcom/b43/main.c b/drivers/net/wireless/broadcom/b43/main.c
index 92ca0b2ca286..215106717553 100644
--- a/drivers/net/wireless/broadcom/b43/main.c
+++ b/drivers/net/wireless/broadcom/b43/main.c
@@ -5170,6 +5170,10 @@ static int b43_op_get_survey(struct ieee80211_hw *hw, int idx,
 }
 
 static const struct ieee80211_ops b43_hw_ops = {
+	.add_chanctx = ieee80211_emulate_add_chanctx,
+	.remove_chanctx = ieee80211_emulate_remove_chanctx,
+	.change_chanctx = ieee80211_emulate_change_chanctx,
+	.switch_vif_chanctx = ieee80211_emulate_switch_vif_chanctx,
 	.tx			= b43_op_tx,
 	.wake_tx_queue		= ieee80211_handle_wake_tx_queue,
 	.conf_tx		= b43_op_conf_tx,
diff --git a/drivers/net/wireless/broadcom/b43legacy/main.c b/drivers/net/wireless/broadcom/b43legacy/main.c
index 760136638a95..18eb610f600a 100644
--- a/drivers/net/wireless/broadcom/b43legacy/main.c
+++ b/drivers/net/wireless/broadcom/b43legacy/main.c
@@ -3531,6 +3531,10 @@ static int b43legacy_op_get_survey(struct ieee80211_hw *hw, int idx,
 }
 
 static const struct ieee80211_ops b43legacy_hw_ops = {
+	.add_chanctx = ieee80211_emulate_add_chanctx,
+	.remove_chanctx = ieee80211_emulate_remove_chanctx,
+	.change_chanctx = ieee80211_emulate_change_chanctx,
+	.switch_vif_chanctx = ieee80211_emulate_switch_vif_chanctx,
 	.tx			= b43legacy_op_tx,
 	.wake_tx_queue		= ieee80211_handle_wake_tx_queue,
 	.conf_tx		= b43legacy_op_conf_tx,
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmsmac/mac80211_if.c b/drivers/net/wireless/broadcom/brcm80211/brcmsmac/mac80211_if.c
index 543e93ec49d2..92860dc0a92e 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmsmac/mac80211_if.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmsmac/mac80211_if.c
@@ -959,6 +959,10 @@ static int brcms_ops_beacon_set_tim(struct ieee80211_hw *hw,
 }
 
 static const struct ieee80211_ops brcms_ops = {
+	.add_chanctx = ieee80211_emulate_add_chanctx,
+	.remove_chanctx = ieee80211_emulate_remove_chanctx,
+	.change_chanctx = ieee80211_emulate_change_chanctx,
+	.switch_vif_chanctx = ieee80211_emulate_switch_vif_chanctx,
 	.tx = brcms_ops_tx,
 	.wake_tx_queue = ieee80211_handle_wake_tx_queue,
 	.start = brcms_ops_start,
diff --git a/drivers/net/wireless/intel/iwlegacy/3945-mac.c b/drivers/net/wireless/intel/iwlegacy/3945-mac.c
index 9eaf5ec133f9..075b705a8d7b 100644
--- a/drivers/net/wireless/intel/iwlegacy/3945-mac.c
+++ b/drivers/net/wireless/intel/iwlegacy/3945-mac.c
@@ -3432,6 +3432,10 @@ static const struct attribute_group il3945_attribute_group = {
 };
 
 static struct ieee80211_ops il3945_mac_ops __ro_after_init = {
+	.add_chanctx = ieee80211_emulate_add_chanctx,
+	.remove_chanctx = ieee80211_emulate_remove_chanctx,
+	.change_chanctx = ieee80211_emulate_change_chanctx,
+	.switch_vif_chanctx = ieee80211_emulate_switch_vif_chanctx,
 	.tx = il3945_mac_tx,
 	.wake_tx_queue = ieee80211_handle_wake_tx_queue,
 	.start = il3945_mac_start,
diff --git a/drivers/net/wireless/intel/iwlegacy/4965-mac.c b/drivers/net/wireless/intel/iwlegacy/4965-mac.c
index 70e420df1643..4beb7be6d51d 100644
--- a/drivers/net/wireless/intel/iwlegacy/4965-mac.c
+++ b/drivers/net/wireless/intel/iwlegacy/4965-mac.c
@@ -6301,6 +6301,10 @@ il4965_tx_queue_set_status(struct il_priv *il, struct il_tx_queue *txq,
 }
 
 static const struct ieee80211_ops il4965_mac_ops = {
+	.add_chanctx = ieee80211_emulate_add_chanctx,
+	.remove_chanctx = ieee80211_emulate_remove_chanctx,
+	.change_chanctx = ieee80211_emulate_change_chanctx,
+	.switch_vif_chanctx = ieee80211_emulate_switch_vif_chanctx,
 	.tx = il4965_mac_tx,
 	.wake_tx_queue = ieee80211_handle_wake_tx_queue,
 	.start = il4965_mac_start,
diff --git a/drivers/net/wireless/intel/iwlwifi/dvm/mac80211.c b/drivers/net/wireless/intel/iwlwifi/dvm/mac80211.c
index 5f3d5b15f727..52b008ce53bd 100644
--- a/drivers/net/wireless/intel/iwlwifi/dvm/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/dvm/mac80211.c
@@ -1570,6 +1570,10 @@ static void iwlagn_mac_sta_notify(struct ieee80211_hw *hw,
 }
 
 const struct ieee80211_ops iwlagn_hw_ops = {
+	.add_chanctx = ieee80211_emulate_add_chanctx,
+	.remove_chanctx = ieee80211_emulate_remove_chanctx,
+	.change_chanctx = ieee80211_emulate_change_chanctx,
+	.switch_vif_chanctx = ieee80211_emulate_switch_vif_chanctx,
 	.tx = iwlagn_mac_tx,
 	.wake_tx_queue = ieee80211_handle_wake_tx_queue,
 	.start = iwlagn_mac_start,
diff --git a/drivers/net/wireless/intersil/p54/main.c b/drivers/net/wireless/intersil/p54/main.c
index c6084683aedd..687841b2fa2a 100644
--- a/drivers/net/wireless/intersil/p54/main.c
+++ b/drivers/net/wireless/intersil/p54/main.c
@@ -704,6 +704,10 @@ static void p54_set_coverage_class(struct ieee80211_hw *dev,
 }
 
 static const struct ieee80211_ops p54_ops = {
+	.add_chanctx = ieee80211_emulate_add_chanctx,
+	.remove_chanctx = ieee80211_emulate_remove_chanctx,
+	.change_chanctx = ieee80211_emulate_change_chanctx,
+	.switch_vif_chanctx = ieee80211_emulate_switch_vif_chanctx,
 	.tx			= p54_tx_80211,
 	.wake_tx_queue		= ieee80211_handle_wake_tx_queue,
 	.start			= p54_start,
diff --git a/drivers/net/wireless/marvell/libertas_tf/main.c b/drivers/net/wireless/marvell/libertas_tf/main.c
index 199d33ed3bb9..9cca69fe04d7 100644
--- a/drivers/net/wireless/marvell/libertas_tf/main.c
+++ b/drivers/net/wireless/marvell/libertas_tf/main.c
@@ -473,6 +473,10 @@ static int lbtf_op_get_survey(struct ieee80211_hw *hw, int idx,
 }
 
 static const struct ieee80211_ops lbtf_ops = {
+	.add_chanctx = ieee80211_emulate_add_chanctx,
+	.remove_chanctx = ieee80211_emulate_remove_chanctx,
+	.change_chanctx = ieee80211_emulate_change_chanctx,
+	.switch_vif_chanctx = ieee80211_emulate_switch_vif_chanctx,
 	.tx			= lbtf_op_tx,
 	.wake_tx_queue		= ieee80211_handle_wake_tx_queue,
 	.start			= lbtf_op_start,
diff --git a/drivers/net/wireless/marvell/mwl8k.c b/drivers/net/wireless/marvell/mwl8k.c
index 13bcb123d122..ce8fea76dbb2 100644
--- a/drivers/net/wireless/marvell/mwl8k.c
+++ b/drivers/net/wireless/marvell/mwl8k.c
@@ -5610,6 +5610,10 @@ static void mwl8k_sw_scan_complete(struct ieee80211_hw *hw,
 }
 
 static const struct ieee80211_ops mwl8k_ops = {
+	.add_chanctx = ieee80211_emulate_add_chanctx,
+	.remove_chanctx = ieee80211_emulate_remove_chanctx,
+	.change_chanctx = ieee80211_emulate_change_chanctx,
+	.switch_vif_chanctx = ieee80211_emulate_switch_vif_chanctx,
 	.tx			= mwl8k_tx,
 	.wake_tx_queue		= ieee80211_handle_wake_tx_queue,
 	.start			= mwl8k_start,
diff --git a/drivers/net/wireless/mediatek/mt76/mt7603/main.c b/drivers/net/wireless/mediatek/mt76/mt7603/main.c
index 89d738deea62..8c0440b543c7 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7603/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7603/main.c
@@ -701,6 +701,10 @@ static void mt7603_tx(struct ieee80211_hw *hw,
 }
 
 const struct ieee80211_ops mt7603_ops = {
+	.add_chanctx = ieee80211_emulate_add_chanctx,
+	.remove_chanctx = ieee80211_emulate_remove_chanctx,
+	.change_chanctx = ieee80211_emulate_change_chanctx,
+	.switch_vif_chanctx = ieee80211_emulate_switch_vif_chanctx,
 	.tx = mt7603_tx,
 	.start = mt7603_start,
 	.stop = mt7603_stop,
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x0/pci.c b/drivers/net/wireless/mediatek/mt76/mt76x0/pci.c
index 9277ff38b7a2..d8a8b0d844f1 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x0/pci.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x0/pci.c
@@ -59,6 +59,10 @@ mt76x0e_flush(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 }
 
 static const struct ieee80211_ops mt76x0e_ops = {
+	.add_chanctx = ieee80211_emulate_add_chanctx,
+	.remove_chanctx = ieee80211_emulate_remove_chanctx,
+	.change_chanctx = ieee80211_emulate_change_chanctx,
+	.switch_vif_chanctx = ieee80211_emulate_switch_vif_chanctx,
 	.tx = mt76x02_tx,
 	.start = mt76x0e_start,
 	.stop = mt76x0e_stop,
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x0/usb.c b/drivers/net/wireless/mediatek/mt76/mt76x0/usb.c
index 0422c332354a..22fd3fd65448 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x0/usb.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x0/usb.c
@@ -118,6 +118,10 @@ static int mt76x0u_start(struct ieee80211_hw *hw)
 }
 
 static const struct ieee80211_ops mt76x0u_ops = {
+	.add_chanctx = ieee80211_emulate_add_chanctx,
+	.remove_chanctx = ieee80211_emulate_remove_chanctx,
+	.change_chanctx = ieee80211_emulate_change_chanctx,
+	.switch_vif_chanctx = ieee80211_emulate_switch_vif_chanctx,
 	.tx = mt76x02_tx,
 	.start = mt76x0u_start,
 	.stop = mt76x0u_stop,
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x2/pci_main.c b/drivers/net/wireless/mediatek/mt76/mt76x2/pci_main.c
index b38bb7a2362b..bfc8c69f43fa 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x2/pci_main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x2/pci_main.c
@@ -132,6 +132,10 @@ static int mt76x2_set_antenna(struct ieee80211_hw *hw, u32 tx_ant,
 }
 
 const struct ieee80211_ops mt76x2_ops = {
+	.add_chanctx = ieee80211_emulate_add_chanctx,
+	.remove_chanctx = ieee80211_emulate_remove_chanctx,
+	.change_chanctx = ieee80211_emulate_change_chanctx,
+	.switch_vif_chanctx = ieee80211_emulate_switch_vif_chanctx,
 	.tx = mt76x02_tx,
 	.start = mt76x2_start,
 	.stop = mt76x2_stop,
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x2/usb_main.c b/drivers/net/wireless/mediatek/mt76/mt76x2/usb_main.c
index ac07ed1f63a3..9fe390fdd730 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x2/usb_main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x2/usb_main.c
@@ -103,6 +103,10 @@ mt76x2u_config(struct ieee80211_hw *hw, u32 changed)
 }
 
 const struct ieee80211_ops mt76x2u_ops = {
+	.add_chanctx = ieee80211_emulate_add_chanctx,
+	.remove_chanctx = ieee80211_emulate_remove_chanctx,
+	.change_chanctx = ieee80211_emulate_change_chanctx,
+	.switch_vif_chanctx = ieee80211_emulate_switch_vif_chanctx,
 	.tx = mt76x02_tx,
 	.start = mt76x2u_start,
 	.stop = mt76x2u_stop,
diff --git a/drivers/net/wireless/mediatek/mt76/mt792x_core.c b/drivers/net/wireless/mediatek/mt76/mt792x_core.c
index 502be22dbe36..d2a6cd9b434f 100644
--- a/drivers/net/wireless/mediatek/mt76/mt792x_core.c
+++ b/drivers/net/wireless/mediatek/mt76/mt792x_core.c
@@ -684,9 +684,10 @@ mt792x_get_mac80211_ops(struct device *dev,
 	if (!(*fw_features & MT792x_FW_CAP_CNM)) {
 		ops->remain_on_channel = NULL;
 		ops->cancel_remain_on_channel = NULL;
-		ops->add_chanctx = NULL;
-		ops->remove_chanctx = NULL;
-		ops->change_chanctx = NULL;
+		ops->add_chanctx = ieee80211_emulate_add_chanctx;
+		ops->remove_chanctx = ieee80211_emulate_remove_chanctx;
+		ops->change_chanctx = ieee80211_emulate_change_chanctx;
+		ops->switch_vif_chanctx = ieee80211_emulate_switch_vif_chanctx;
 		ops->assign_vif_chanctx = NULL;
 		ops->unassign_vif_chanctx = NULL;
 		ops->mgd_prepare_tx = NULL;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/main.c b/drivers/net/wireless/mediatek/mt76/mt7996/main.c
index 09c7a28a3d51..138afd1b99ef 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/main.c
@@ -1389,6 +1389,10 @@ mt7996_set_radar_background(struct ieee80211_hw *hw,
 }
 
 const struct ieee80211_ops mt7996_ops = {
+	.add_chanctx = ieee80211_emulate_add_chanctx,
+	.remove_chanctx = ieee80211_emulate_remove_chanctx,
+	.change_chanctx = ieee80211_emulate_change_chanctx,
+	.switch_vif_chanctx = ieee80211_emulate_switch_vif_chanctx,
 	.tx = mt7996_tx,
 	.start = mt7996_start,
 	.stop = mt7996_stop,
diff --git a/drivers/net/wireless/mediatek/mt7601u/main.c b/drivers/net/wireless/mediatek/mt7601u/main.c
index c8d332456a6b..a7330576486b 100644
--- a/drivers/net/wireless/mediatek/mt7601u/main.c
+++ b/drivers/net/wireless/mediatek/mt7601u/main.c
@@ -405,6 +405,10 @@ mt76_sta_rate_tbl_update(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 }
 
 const struct ieee80211_ops mt7601u_ops = {
+	.add_chanctx = ieee80211_emulate_add_chanctx,
+	.remove_chanctx = ieee80211_emulate_remove_chanctx,
+	.change_chanctx = ieee80211_emulate_change_chanctx,
+	.switch_vif_chanctx = ieee80211_emulate_switch_vif_chanctx,
 	.tx = mt7601u_tx,
 	.wake_tx_queue = ieee80211_handle_wake_tx_queue,
 	.start = mt7601u_start,
diff --git a/drivers/net/wireless/purelifi/plfxlc/mac.c b/drivers/net/wireless/purelifi/plfxlc/mac.c
index 506d2f31efb5..7a1b27764f53 100644
--- a/drivers/net/wireless/purelifi/plfxlc/mac.c
+++ b/drivers/net/wireless/purelifi/plfxlc/mac.c
@@ -685,6 +685,10 @@ static int plfxlc_set_rts_threshold(struct ieee80211_hw *hw, u32 value)
 }
 
 static const struct ieee80211_ops plfxlc_ops = {
+	.add_chanctx = ieee80211_emulate_add_chanctx,
+	.remove_chanctx = ieee80211_emulate_remove_chanctx,
+	.change_chanctx = ieee80211_emulate_change_chanctx,
+	.switch_vif_chanctx = ieee80211_emulate_switch_vif_chanctx,
 	.tx = plfxlc_op_tx,
 	.wake_tx_queue = ieee80211_handle_wake_tx_queue,
 	.start = plfxlc_op_start,
diff --git a/drivers/net/wireless/ralink/rt2x00/rt2400pci.c b/drivers/net/wireless/ralink/rt2x00/rt2400pci.c
index 13dd672b825e..42e21e9f303b 100644
--- a/drivers/net/wireless/ralink/rt2x00/rt2400pci.c
+++ b/drivers/net/wireless/ralink/rt2x00/rt2400pci.c
@@ -1705,6 +1705,10 @@ static int rt2400pci_tx_last_beacon(struct ieee80211_hw *hw)
 }
 
 static const struct ieee80211_ops rt2400pci_mac80211_ops = {
+	.add_chanctx = ieee80211_emulate_add_chanctx,
+	.remove_chanctx = ieee80211_emulate_remove_chanctx,
+	.change_chanctx = ieee80211_emulate_change_chanctx,
+	.switch_vif_chanctx = ieee80211_emulate_switch_vif_chanctx,
 	.tx			= rt2x00mac_tx,
 	.wake_tx_queue		= ieee80211_handle_wake_tx_queue,
 	.start			= rt2x00mac_start,
diff --git a/drivers/net/wireless/ralink/rt2x00/rt2500pci.c b/drivers/net/wireless/ralink/rt2x00/rt2500pci.c
index ecddda4c471e..36ddc5a69fa4 100644
--- a/drivers/net/wireless/ralink/rt2x00/rt2500pci.c
+++ b/drivers/net/wireless/ralink/rt2x00/rt2500pci.c
@@ -2003,6 +2003,10 @@ static int rt2500pci_tx_last_beacon(struct ieee80211_hw *hw)
 }
 
 static const struct ieee80211_ops rt2500pci_mac80211_ops = {
+	.add_chanctx = ieee80211_emulate_add_chanctx,
+	.remove_chanctx = ieee80211_emulate_remove_chanctx,
+	.change_chanctx = ieee80211_emulate_change_chanctx,
+	.switch_vif_chanctx = ieee80211_emulate_switch_vif_chanctx,
 	.tx			= rt2x00mac_tx,
 	.wake_tx_queue		= ieee80211_handle_wake_tx_queue,
 	.start			= rt2x00mac_start,
diff --git a/drivers/net/wireless/ralink/rt2x00/rt2500usb.c b/drivers/net/wireless/ralink/rt2x00/rt2500usb.c
index 13fdcff0ad66..09923765e2db 100644
--- a/drivers/net/wireless/ralink/rt2x00/rt2500usb.c
+++ b/drivers/net/wireless/ralink/rt2x00/rt2500usb.c
@@ -1794,6 +1794,10 @@ static int rt2500usb_probe_hw(struct rt2x00_dev *rt2x00dev)
 }
 
 static const struct ieee80211_ops rt2500usb_mac80211_ops = {
+	.add_chanctx = ieee80211_emulate_add_chanctx,
+	.remove_chanctx = ieee80211_emulate_remove_chanctx,
+	.change_chanctx = ieee80211_emulate_change_chanctx,
+	.switch_vif_chanctx = ieee80211_emulate_switch_vif_chanctx,
 	.tx			= rt2x00mac_tx,
 	.wake_tx_queue		= ieee80211_handle_wake_tx_queue,
 	.start			= rt2x00mac_start,
diff --git a/drivers/net/wireless/ralink/rt2x00/rt2800pci.c b/drivers/net/wireless/ralink/rt2x00/rt2800pci.c
index dcb56f708a5f..14c45aba836f 100644
--- a/drivers/net/wireless/ralink/rt2x00/rt2800pci.c
+++ b/drivers/net/wireless/ralink/rt2x00/rt2800pci.c
@@ -287,6 +287,10 @@ static int rt2800pci_read_eeprom(struct rt2x00_dev *rt2x00dev)
 }
 
 static const struct ieee80211_ops rt2800pci_mac80211_ops = {
+	.add_chanctx = ieee80211_emulate_add_chanctx,
+	.remove_chanctx = ieee80211_emulate_remove_chanctx,
+	.change_chanctx = ieee80211_emulate_change_chanctx,
+	.switch_vif_chanctx = ieee80211_emulate_switch_vif_chanctx,
 	.tx			= rt2x00mac_tx,
 	.wake_tx_queue		= ieee80211_handle_wake_tx_queue,
 	.start			= rt2x00mac_start,
diff --git a/drivers/net/wireless/ralink/rt2x00/rt2800soc.c b/drivers/net/wireless/ralink/rt2x00/rt2800soc.c
index 7118d4f9038d..701ba54bf3e5 100644
--- a/drivers/net/wireless/ralink/rt2x00/rt2800soc.c
+++ b/drivers/net/wireless/ralink/rt2x00/rt2800soc.c
@@ -132,6 +132,10 @@ static int rt2800soc_write_firmware(struct rt2x00_dev *rt2x00dev,
 }
 
 static const struct ieee80211_ops rt2800soc_mac80211_ops = {
+	.add_chanctx = ieee80211_emulate_add_chanctx,
+	.remove_chanctx = ieee80211_emulate_remove_chanctx,
+	.change_chanctx = ieee80211_emulate_change_chanctx,
+	.switch_vif_chanctx = ieee80211_emulate_switch_vif_chanctx,
 	.tx			= rt2x00mac_tx,
 	.wake_tx_queue		= ieee80211_handle_wake_tx_queue,
 	.start			= rt2x00mac_start,
diff --git a/drivers/net/wireless/ralink/rt2x00/rt2800usb.c b/drivers/net/wireless/ralink/rt2x00/rt2800usb.c
index b2a8e75a901b..160bef79acdb 100644
--- a/drivers/net/wireless/ralink/rt2x00/rt2800usb.c
+++ b/drivers/net/wireless/ralink/rt2x00/rt2800usb.c
@@ -629,6 +629,10 @@ static int rt2800usb_probe_hw(struct rt2x00_dev *rt2x00dev)
 }
 
 static const struct ieee80211_ops rt2800usb_mac80211_ops = {
+	.add_chanctx = ieee80211_emulate_add_chanctx,
+	.remove_chanctx = ieee80211_emulate_remove_chanctx,
+	.change_chanctx = ieee80211_emulate_change_chanctx,
+	.switch_vif_chanctx = ieee80211_emulate_switch_vif_chanctx,
 	.tx			= rt2x00mac_tx,
 	.wake_tx_queue		= ieee80211_handle_wake_tx_queue,
 	.start			= rt2x00mac_start,
diff --git a/drivers/net/wireless/ralink/rt2x00/rt61pci.c b/drivers/net/wireless/ralink/rt2x00/rt61pci.c
index 483723bf514b..d1cd5694e3c7 100644
--- a/drivers/net/wireless/ralink/rt2x00/rt61pci.c
+++ b/drivers/net/wireless/ralink/rt2x00/rt61pci.c
@@ -2872,6 +2872,10 @@ static u64 rt61pci_get_tsf(struct ieee80211_hw *hw, struct ieee80211_vif *vif)
 }
 
 static const struct ieee80211_ops rt61pci_mac80211_ops = {
+	.add_chanctx = ieee80211_emulate_add_chanctx,
+	.remove_chanctx = ieee80211_emulate_remove_chanctx,
+	.change_chanctx = ieee80211_emulate_change_chanctx,
+	.switch_vif_chanctx = ieee80211_emulate_switch_vif_chanctx,
 	.tx			= rt2x00mac_tx,
 	.wake_tx_queue		= ieee80211_handle_wake_tx_queue,
 	.start			= rt2x00mac_start,
diff --git a/drivers/net/wireless/ralink/rt2x00/rt73usb.c b/drivers/net/wireless/ralink/rt2x00/rt73usb.c
index dfa9d5213898..b79dda952a33 100644
--- a/drivers/net/wireless/ralink/rt2x00/rt73usb.c
+++ b/drivers/net/wireless/ralink/rt2x00/rt73usb.c
@@ -2291,6 +2291,10 @@ static u64 rt73usb_get_tsf(struct ieee80211_hw *hw, struct ieee80211_vif *vif)
 }
 
 static const struct ieee80211_ops rt73usb_mac80211_ops = {
+	.add_chanctx = ieee80211_emulate_add_chanctx,
+	.remove_chanctx = ieee80211_emulate_remove_chanctx,
+	.change_chanctx = ieee80211_emulate_change_chanctx,
+	.switch_vif_chanctx = ieee80211_emulate_switch_vif_chanctx,
 	.tx			= rt2x00mac_tx,
 	.wake_tx_queue		= ieee80211_handle_wake_tx_queue,
 	.start			= rt2x00mac_start,
diff --git a/drivers/net/wireless/realtek/rtl818x/rtl8180/dev.c b/drivers/net/wireless/realtek/rtl818x/rtl8180/dev.c
index f6c25a52b69a..77b6cb7e1f6b 100644
--- a/drivers/net/wireless/realtek/rtl818x/rtl8180/dev.c
+++ b/drivers/net/wireless/realtek/rtl818x/rtl8180/dev.c
@@ -1607,6 +1607,10 @@ static void rtl8180_configure_filter(struct ieee80211_hw *dev,
 }
 
 static const struct ieee80211_ops rtl8180_ops = {
+	.add_chanctx = ieee80211_emulate_add_chanctx,
+	.remove_chanctx = ieee80211_emulate_remove_chanctx,
+	.change_chanctx = ieee80211_emulate_change_chanctx,
+	.switch_vif_chanctx = ieee80211_emulate_switch_vif_chanctx,
 	.tx			= rtl8180_tx,
 	.wake_tx_queue		= ieee80211_handle_wake_tx_queue,
 	.start			= rtl8180_start,
diff --git a/drivers/net/wireless/realtek/rtl818x/rtl8187/dev.c b/drivers/net/wireless/realtek/rtl818x/rtl8187/dev.c
index 04945f905d6d..78d99afa373d 100644
--- a/drivers/net/wireless/realtek/rtl818x/rtl8187/dev.c
+++ b/drivers/net/wireless/realtek/rtl818x/rtl8187/dev.c
@@ -1377,6 +1377,10 @@ static int rtl8187_conf_tx(struct ieee80211_hw *dev,
 
 
 static const struct ieee80211_ops rtl8187_ops = {
+	.add_chanctx = ieee80211_emulate_add_chanctx,
+	.remove_chanctx = ieee80211_emulate_remove_chanctx,
+	.change_chanctx = ieee80211_emulate_change_chanctx,
+	.switch_vif_chanctx = ieee80211_emulate_switch_vif_chanctx,
 	.tx			= rtl8187_tx,
 	.wake_tx_queue		= ieee80211_handle_wake_tx_queue,
 	.start			= rtl8187_start,
diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
index 43ee7592bc6e..f07e4358f16b 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
+++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
@@ -7343,6 +7343,10 @@ static int rtl8xxxu_sta_remove(struct ieee80211_hw *hw,
 }
 
 static const struct ieee80211_ops rtl8xxxu_ops = {
+	.add_chanctx = ieee80211_emulate_add_chanctx,
+	.remove_chanctx = ieee80211_emulate_remove_chanctx,
+	.change_chanctx = ieee80211_emulate_change_chanctx,
+	.switch_vif_chanctx = ieee80211_emulate_switch_vif_chanctx,
 	.tx = rtl8xxxu_tx,
 	.wake_tx_queue = ieee80211_handle_wake_tx_queue,
 	.add_interface = rtl8xxxu_add_interface,
diff --git a/drivers/net/wireless/realtek/rtlwifi/core.c b/drivers/net/wireless/realtek/rtlwifi/core.c
index 69e97647e3d6..2e60a6991ca1 100644
--- a/drivers/net/wireless/realtek/rtlwifi/core.c
+++ b/drivers/net/wireless/realtek/rtlwifi/core.c
@@ -1903,6 +1903,10 @@ void rtl_init_sw_leds(struct ieee80211_hw *hw)
 EXPORT_SYMBOL(rtl_init_sw_leds);
 
 const struct ieee80211_ops rtl_ops = {
+	.add_chanctx = ieee80211_emulate_add_chanctx,
+	.remove_chanctx = ieee80211_emulate_remove_chanctx,
+	.change_chanctx = ieee80211_emulate_change_chanctx,
+	.switch_vif_chanctx = ieee80211_emulate_switch_vif_chanctx,
 	.start = rtl_op_start,
 	.stop = rtl_op_stop,
 	.tx = rtl_op_tx,
diff --git a/drivers/net/wireless/realtek/rtw88/mac80211.c b/drivers/net/wireless/realtek/rtw88/mac80211.c
index d8d68f16014e..7af5bf7fe5b6 100644
--- a/drivers/net/wireless/realtek/rtw88/mac80211.c
+++ b/drivers/net/wireless/realtek/rtw88/mac80211.c
@@ -927,6 +927,10 @@ static void rtw_ops_sta_rc_update(struct ieee80211_hw *hw,
 }
 
 const struct ieee80211_ops rtw_ops = {
+	.add_chanctx = ieee80211_emulate_add_chanctx,
+	.remove_chanctx = ieee80211_emulate_remove_chanctx,
+	.change_chanctx = ieee80211_emulate_change_chanctx,
+	.switch_vif_chanctx = ieee80211_emulate_switch_vif_chanctx,
 	.tx			= rtw_ops_tx,
 	.wake_tx_queue		= rtw_ops_wake_tx_queue,
 	.start			= rtw_ops_start,
diff --git a/drivers/net/wireless/realtek/rtw89/core.c b/drivers/net/wireless/realtek/rtw89/core.c
index 74bf29643823..3e8ef724145f 100644
--- a/drivers/net/wireless/realtek/rtw89/core.c
+++ b/drivers/net/wireless/realtek/rtw89/core.c
@@ -4455,9 +4455,10 @@ struct rtw89_dev *rtw89_alloc_ieee80211_hw(struct device *device,
 		     !RTW89_CHK_FW_FEATURE(BEACON_FILTER, &early_fw);
 
 	if (no_chanctx) {
-		ops->add_chanctx = NULL;
-		ops->remove_chanctx = NULL;
-		ops->change_chanctx = NULL;
+		ops->add_chanctx = ieee80211_emulate_add_chanctx;
+		ops->remove_chanctx = ieee80211_emulate_remove_chanctx;
+		ops->change_chanctx = ieee80211_emulate_change_chanctx;
+		ops->switch_vif_chanctx = ieee80211_emulate_switch_vif_chanctx;
 		ops->assign_vif_chanctx = NULL;
 		ops->unassign_vif_chanctx = NULL;
 		ops->remain_on_channel = NULL;
diff --git a/drivers/net/wireless/rsi/rsi_91x_mac80211.c b/drivers/net/wireless/rsi/rsi_91x_mac80211.c
index 05890536e353..e8aeb4d76c13 100644
--- a/drivers/net/wireless/rsi/rsi_91x_mac80211.c
+++ b/drivers/net/wireless/rsi/rsi_91x_mac80211.c
@@ -1957,6 +1957,10 @@ static int rsi_mac80211_resume(struct ieee80211_hw *hw)
 #endif
 
 static const struct ieee80211_ops mac80211_ops = {
+	.add_chanctx = ieee80211_emulate_add_chanctx,
+	.remove_chanctx = ieee80211_emulate_remove_chanctx,
+	.change_chanctx = ieee80211_emulate_change_chanctx,
+	.switch_vif_chanctx = ieee80211_emulate_switch_vif_chanctx,
 	.tx = rsi_mac80211_tx,
 	.wake_tx_queue = ieee80211_handle_wake_tx_queue,
 	.start = rsi_mac80211_start,
diff --git a/drivers/net/wireless/st/cw1200/main.c b/drivers/net/wireless/st/cw1200/main.c
index 381013e0db63..a54a7b86864f 100644
--- a/drivers/net/wireless/st/cw1200/main.c
+++ b/drivers/net/wireless/st/cw1200/main.c
@@ -203,6 +203,10 @@ static const unsigned long cw1200_ttl[] = {
 };
 
 static const struct ieee80211_ops cw1200_ops = {
+	.add_chanctx = ieee80211_emulate_add_chanctx,
+	.remove_chanctx = ieee80211_emulate_remove_chanctx,
+	.change_chanctx = ieee80211_emulate_change_chanctx,
+	.switch_vif_chanctx = ieee80211_emulate_switch_vif_chanctx,
 	.start			= cw1200_start,
 	.stop			= cw1200_stop,
 	.add_interface		= cw1200_add_interface,
diff --git a/drivers/net/wireless/ti/wl1251/main.c b/drivers/net/wireless/ti/wl1251/main.c
index cd9a41f59f32..0da2d29dd7bd 100644
--- a/drivers/net/wireless/ti/wl1251/main.c
+++ b/drivers/net/wireless/ti/wl1251/main.c
@@ -1351,6 +1351,10 @@ static struct ieee80211_supported_band wl1251_band_2ghz = {
 };
 
 static const struct ieee80211_ops wl1251_ops = {
+	.add_chanctx = ieee80211_emulate_add_chanctx,
+	.remove_chanctx = ieee80211_emulate_remove_chanctx,
+	.change_chanctx = ieee80211_emulate_change_chanctx,
+	.switch_vif_chanctx = ieee80211_emulate_switch_vif_chanctx,
 	.start = wl1251_op_start,
 	.stop = wl1251_op_stop,
 	.add_interface = wl1251_op_add_interface,
diff --git a/drivers/net/wireless/virtual/mac80211_hwsim.c b/drivers/net/wireless/virtual/mac80211_hwsim.c
index 84f417b0d8c6..d1ef61796369 100644
--- a/drivers/net/wireless/virtual/mac80211_hwsim.c
+++ b/drivers/net/wireless/virtual/mac80211_hwsim.c
@@ -3862,6 +3862,10 @@ static const struct ieee80211_ops mac80211_hwsim_ops = {
 	HWSIM_NON_MLO_OPS
 	.sw_scan_start = mac80211_hwsim_sw_scan,
 	.sw_scan_complete = mac80211_hwsim_sw_scan_complete,
+	.add_chanctx = ieee80211_emulate_add_chanctx,
+	.remove_chanctx = ieee80211_emulate_remove_chanctx,
+	.change_chanctx = ieee80211_emulate_change_chanctx,
+	.switch_vif_chanctx = ieee80211_emulate_switch_vif_chanctx,
 };
 
 #define HWSIM_CHANCTX_OPS					\
diff --git a/drivers/net/wireless/zydas/zd1211rw/zd_mac.c b/drivers/net/wireless/zydas/zd1211rw/zd_mac.c
index 5d534e15a844..900c063bd724 100644
--- a/drivers/net/wireless/zydas/zd1211rw/zd_mac.c
+++ b/drivers/net/wireless/zydas/zd1211rw/zd_mac.c
@@ -1343,6 +1343,10 @@ static u64 zd_op_get_tsf(struct ieee80211_hw *hw, struct ieee80211_vif *vif)
 }
 
 static const struct ieee80211_ops zd_ops = {
+	.add_chanctx = ieee80211_emulate_add_chanctx,
+	.remove_chanctx = ieee80211_emulate_remove_chanctx,
+	.change_chanctx = ieee80211_emulate_change_chanctx,
+	.switch_vif_chanctx = ieee80211_emulate_switch_vif_chanctx,
 	.tx			= zd_op_tx,
 	.wake_tx_queue		= ieee80211_handle_wake_tx_queue,
 	.start			= zd_op_start,
diff --git a/drivers/staging/vt6655/device_main.c b/drivers/staging/vt6655/device_main.c
index 45e5eccadb44..f8d87cd87edf 100644
--- a/drivers/staging/vt6655/device_main.c
+++ b/drivers/staging/vt6655/device_main.c
@@ -1684,6 +1684,10 @@ static void vnt_reset_tsf(struct ieee80211_hw *hw, struct ieee80211_vif *vif)
 }
 
 static const struct ieee80211_ops vnt_mac_ops = {
+	.add_chanctx = ieee80211_emulate_add_chanctx,
+	.remove_chanctx = ieee80211_emulate_remove_chanctx,
+	.change_chanctx = ieee80211_emulate_change_chanctx,
+	.switch_vif_chanctx = ieee80211_emulate_switch_vif_chanctx,
 	.tx			= vnt_tx_80211,
 	.wake_tx_queue		= ieee80211_handle_wake_tx_queue,
 	.start			= vnt_start,
diff --git a/drivers/staging/vt6656/main_usb.c b/drivers/staging/vt6656/main_usb.c
index 2abae90f3f52..6c70493d1b01 100644
--- a/drivers/staging/vt6656/main_usb.c
+++ b/drivers/staging/vt6656/main_usb.c
@@ -956,6 +956,10 @@ static void vnt_reset_tsf(struct ieee80211_hw *hw, struct ieee80211_vif *vif)
 }
 
 static const struct ieee80211_ops vnt_mac_ops = {
+	.add_chanctx = ieee80211_emulate_add_chanctx,
+	.remove_chanctx = ieee80211_emulate_remove_chanctx,
+	.change_chanctx = ieee80211_emulate_change_chanctx,
+	.switch_vif_chanctx = ieee80211_emulate_switch_vif_chanctx,
 	.tx			= vnt_tx_80211,
 	.wake_tx_queue		= ieee80211_handle_wake_tx_queue,
 	.start			= vnt_start,
diff --git a/include/net/mac80211.h b/include/net/mac80211.h
index 580781ff9dcf..79e05eec1b91 100644
--- a/include/net/mac80211.h
+++ b/include/net/mac80211.h
@@ -7471,4 +7471,17 @@ int ieee80211_set_active_links(struct ieee80211_vif *vif, u16 active_links);
 void ieee80211_set_active_links_async(struct ieee80211_vif *vif,
 				      u16 active_links);
 
+/* for older drivers - let's not document these ... */
+int ieee80211_emulate_add_chanctx(struct ieee80211_hw *hw,
+				  struct ieee80211_chanctx_conf *ctx);
+void ieee80211_emulate_remove_chanctx(struct ieee80211_hw *hw,
+				      struct ieee80211_chanctx_conf *ctx);
+void ieee80211_emulate_change_chanctx(struct ieee80211_hw *hw,
+				      struct ieee80211_chanctx_conf *ctx,
+				      u32 changed);
+int ieee80211_emulate_switch_vif_chanctx(struct ieee80211_hw *hw,
+					 struct ieee80211_vif_chanctx_switch *vifs,
+					 int n_vifs,
+					 enum ieee80211_chanctx_switch_mode mode);
+
 #endif /* MAC80211_H */
diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index 606b1b2e4123..b21b7086ce95 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -886,33 +886,30 @@ static int ieee80211_set_monitor_channel(struct wiphy *wiphy,
 {
 	struct ieee80211_local *local = wiphy_priv(wiphy);
 	struct ieee80211_sub_if_data *sdata;
-	int ret = 0;
+	int ret;
 
 	lockdep_assert_wiphy(local->hw.wiphy);
 
 	if (cfg80211_chandef_identical(&local->monitor_chandef, chandef))
 		return 0;
 
-	if (local->use_chanctx) {
-		sdata = wiphy_dereference(local->hw.wiphy,
-					  local->monitor_sdata);
-		if (sdata) {
-			ieee80211_link_release_channel(&sdata->deflink);
-			ret = ieee80211_link_use_channel(&sdata->deflink,
-							 chandef,
-							 IEEE80211_CHANCTX_EXCLUSIVE);
-		}
-	} else {
-		if (local->open_count == local->monitors) {
-			local->_oper_chandef = *chandef;
-			ieee80211_hw_config(local, 0);
-		}
-	}
+	sdata = wiphy_dereference(local->hw.wiphy,
+				  local->monitor_sdata);
+	if (!sdata)
+		goto done;
 
-	if (ret == 0)
-		local->monitor_chandef = *chandef;
+	if (cfg80211_chandef_identical(&sdata->vif.bss_conf.chandef, chandef))
+		return 0;
 
-	return ret;
+	ieee80211_link_release_channel(&sdata->deflink);
+	ret = ieee80211_link_use_channel(&sdata->deflink,
+					 chandef,
+					 IEEE80211_CHANCTX_EXCLUSIVE);
+	if (ret)
+		return ret;
+done:
+	local->monitor_chandef = *chandef;
+	return 0;
 }
 
 static int
@@ -3081,7 +3078,7 @@ static int ieee80211_get_tx_power(struct wiphy *wiphy,
 	if (local->ops->get_txpower)
 		return drv_get_txpower(local, sdata, dbm);
 
-	if (!local->use_chanctx)
+	if (local->emulate_chanctx)
 		*dbm = local->hw.conf.power_level;
 	else
 		*dbm = sdata->vif.bss_conf.txpower;
@@ -4209,10 +4206,7 @@ static int ieee80211_cfg_get_channel(struct wiphy *wiphy,
 	} else if (local->open_count > 0 &&
 		   local->open_count == local->monitors &&
 		   sdata->vif.type == NL80211_IFTYPE_MONITOR) {
-		if (local->use_chanctx)
-			*chandef = local->monitor_chandef;
-		else
-			*chandef = local->_oper_chandef;
+		*chandef = local->monitor_chandef;
 		ret = 0;
 	}
 out:
diff --git a/net/mac80211/chan.c b/net/mac80211/chan.c
index eee93f2d47cb..2974fe9ddb74 100644
--- a/net/mac80211/chan.c
+++ b/net/mac80211/chan.c
@@ -514,11 +514,6 @@ static void _ieee80211_change_chanctx(struct ieee80211_local *local,
 		  _ieee80211_recalc_chanctx_min_def(local, ctx, rsvd_for);
 	drv_change_chanctx(local, ctx, changed);
 
-	if (!local->use_chanctx) {
-		local->_oper_chandef = *chandef;
-		ieee80211_hw_config(local, 0);
-	}
-
 	/* check is BW wider */
 	ieee80211_chan_bw_change(local, old_ctx, false);
 }
@@ -667,23 +662,15 @@ static int ieee80211_add_chanctx(struct ieee80211_local *local,
 
 	lockdep_assert_wiphy(local->hw.wiphy);
 
-	if (!local->use_chanctx)
-		local->hw.conf.radar_enabled = ctx->conf.radar_enabled;
-
 	/* turn idle off *before* setting channel -- some drivers need that */
 	changed = ieee80211_idle_off(local);
 	if (changed)
 		ieee80211_hw_config(local, changed);
 
-	if (!local->use_chanctx) {
-		local->_oper_chandef = ctx->conf.def;
-		ieee80211_hw_config(local, IEEE80211_CONF_CHANGE_CHANNEL);
-	} else {
-		err = drv_add_chanctx(local, ctx);
-		if (err) {
-			ieee80211_recalc_idle(local);
-			return err;
-		}
+	err = drv_add_chanctx(local, ctx);
+	if (err) {
+		ieee80211_recalc_idle(local);
+		return err;
 	}
 
 	return 0;
@@ -718,32 +705,7 @@ static void ieee80211_del_chanctx(struct ieee80211_local *local,
 {
 	lockdep_assert_wiphy(local->hw.wiphy);
 
-	if (!local->use_chanctx) {
-		struct cfg80211_chan_def *chandef = &local->_oper_chandef;
-		/* S1G doesn't have 20MHz, so get the correct width for the
-		 * current channel.
-		 */
-		if (chandef->chan->band == NL80211_BAND_S1GHZ)
-			chandef->width =
-				ieee80211_s1g_channel_width(chandef->chan);
-		else
-			chandef->width = NL80211_CHAN_WIDTH_20_NOHT;
-		chandef->center_freq1 = chandef->chan->center_freq;
-		chandef->freq1_offset = chandef->chan->freq_offset;
-		chandef->center_freq2 = 0;
-
-		/* NOTE: Disabling radar is only valid here for
-		 * single channel context. To be sure, check it ...
-		 */
-		WARN_ON(local->hw.conf.radar_enabled &&
-			!list_empty(&local->chanctx_list));
-
-		local->hw.conf.radar_enabled = false;
-
-		ieee80211_hw_config(local, IEEE80211_CONF_CHANGE_CHANNEL);
-	} else {
-		drv_remove_chanctx(local, ctx);
-	}
+	drv_remove_chanctx(local, ctx);
 
 	ieee80211_recalc_idle(local);
 }
@@ -840,11 +802,6 @@ static void ieee80211_recalc_radar_chanctx(struct ieee80211_local *local,
 
 	chanctx->conf.radar_enabled = radar_enabled;
 
-	if (!local->use_chanctx) {
-		local->hw.conf.radar_enabled = chanctx->conf.radar_enabled;
-		ieee80211_hw_config(local, IEEE80211_CONF_CHANGE_CHANNEL);
-	}
-
 	drv_change_chanctx(local, chanctx, IEEE80211_CHANCTX_CHANGE_RADAR);
 }
 
@@ -986,16 +943,6 @@ void ieee80211_recalc_smps_chanctx(struct ieee80211_local *local,
 
 	rcu_read_unlock();
 
-	if (!local->use_chanctx) {
-		if (rx_chains_static > 1)
-			local->smps_mode = IEEE80211_SMPS_OFF;
-		else if (rx_chains_dynamic > 1)
-			local->smps_mode = IEEE80211_SMPS_DYNAMIC;
-		else
-			local->smps_mode = IEEE80211_SMPS_STATIC;
-		ieee80211_hw_config(local, 0);
-	}
-
 	if (rx_chains_static == chanctx->conf.rx_chains_static &&
 	    rx_chains_dynamic == chanctx->conf.rx_chains_dynamic)
 		return;
@@ -1105,7 +1052,7 @@ int ieee80211_link_reserve_chanctx(struct ieee80211_link_data *link,
 	lockdep_assert_wiphy(local->hw.wiphy);
 
 	curr_ctx = ieee80211_link_get_chanctx(link);
-	if (curr_ctx && local->use_chanctx && !local->ops->switch_vif_chanctx)
+	if (curr_ctx && !local->ops->switch_vif_chanctx)
 		return -ENOTSUPP;
 
 	new_ctx = ieee80211_find_reservation_chanctx(local, chandef, mode);
@@ -1403,24 +1350,6 @@ ieee80211_link_has_in_place_reservation(struct ieee80211_link_data *link)
 	return true;
 }
 
-static int ieee80211_chsw_switch_hwconf(struct ieee80211_local *local,
-					struct ieee80211_chanctx *new_ctx)
-{
-	const struct cfg80211_chan_def *chandef;
-
-	lockdep_assert_wiphy(local->hw.wiphy);
-
-	chandef = ieee80211_chanctx_reserved_chandef(local, new_ctx, NULL);
-	if (WARN_ON(!chandef))
-		return -EINVAL;
-
-	local->hw.conf.radar_enabled = new_ctx->conf.radar_enabled;
-	local->_oper_chandef = *chandef;
-	ieee80211_hw_config(local, 0);
-
-	return 0;
-}
-
 static int ieee80211_chsw_switch_vifs(struct ieee80211_local *local,
 				      int n_vifs)
 {
@@ -1509,7 +1438,6 @@ static int ieee80211_chsw_switch_ctxs(struct ieee80211_local *local)
 static int ieee80211_vif_use_reserved_switch(struct ieee80211_local *local)
 {
 	struct ieee80211_chanctx *ctx, *ctx_tmp, *old_ctx;
-	struct ieee80211_chanctx *new_ctx = NULL;
 	int err, n_assigned, n_reserved, n_ready;
 	int n_ctx = 0, n_vifs_switch = 0, n_vifs_assign = 0, n_vifs_ctxless = 0;
 
@@ -1542,9 +1470,6 @@ static int ieee80211_vif_use_reserved_switch(struct ieee80211_local *local)
 			goto err;
 		}
 
-		if (!local->use_chanctx)
-			new_ctx = ctx;
-
 		n_ctx++;
 
 		n_assigned = 0;
@@ -1598,9 +1523,7 @@ static int ieee80211_vif_use_reserved_switch(struct ieee80211_local *local)
 	if (WARN_ON(n_ctx == 0) ||
 	    WARN_ON(n_vifs_switch == 0 &&
 		    n_vifs_assign == 0 &&
-		    n_vifs_ctxless == 0) ||
-	    WARN_ON(n_ctx > 1 && !local->use_chanctx) ||
-	    WARN_ON(!new_ctx && !local->use_chanctx)) {
+		    n_vifs_ctxless == 0)) {
 		err = -EINVAL;
 		goto err;
 	}
@@ -1610,20 +1533,14 @@ static int ieee80211_vif_use_reserved_switch(struct ieee80211_local *local)
 	 * reservations and driver capabilities.
 	 */
 
-	if (local->use_chanctx) {
-		if (n_vifs_switch > 0) {
-			err = ieee80211_chsw_switch_vifs(local, n_vifs_switch);
-			if (err)
-				goto err;
-		}
+	if (n_vifs_switch > 0) {
+		err = ieee80211_chsw_switch_vifs(local, n_vifs_switch);
+		if (err)
+			goto err;
+	}
 
-		if (n_vifs_assign > 0 || n_vifs_ctxless > 0) {
-			err = ieee80211_chsw_switch_ctxs(local);
-			if (err)
-				goto err;
-		}
-	} else {
-		err = ieee80211_chsw_switch_hwconf(local, new_ctx);
+	if (n_vifs_assign > 0 || n_vifs_ctxless > 0) {
+		err = ieee80211_chsw_switch_ctxs(local);
 		if (err)
 			goto err;
 	}
diff --git a/net/mac80211/ieee80211_i.h b/net/mac80211/ieee80211_i.h
index e36822ad58ca..f21d226b3a4a 100644
--- a/net/mac80211/ieee80211_i.h
+++ b/net/mac80211/ieee80211_i.h
@@ -1339,7 +1339,8 @@ struct ieee80211_local {
 
 	bool wiphy_ciphers_allocated;
 
-	bool use_chanctx;
+	struct cfg80211_chan_def dflt_chandef;
+	bool emulate_chanctx;
 
 	/* protects the aggregated multicast list and filter calls */
 	spinlock_t filter_lock;
@@ -1465,8 +1466,6 @@ struct ieee80211_local {
 	enum mac80211_scan_state next_scan_state;
 	struct wiphy_delayed_work scan_work;
 	struct ieee80211_sub_if_data __rcu *scan_sdata;
-	/* For backward compatibility only -- do not use */
-	struct cfg80211_chan_def _oper_chandef;
 
 	/* Temporary remain-on-channel for off-channel operations */
 	struct ieee80211_channel *tmp_channel;
@@ -1540,8 +1539,6 @@ struct ieee80211_local {
 
 	int user_power_level; /* in dBm, for all interfaces */
 
-	enum ieee80211_smps_mode smps_mode;
-
 	struct work_struct restart_work;
 
 #ifdef CONFIG_MAC80211_DEBUGFS
@@ -1811,6 +1808,8 @@ u64 ieee80211_calculate_rx_timestamp(struct ieee80211_local *local,
 				     unsigned int mpdu_len,
 				     unsigned int mpdu_offset);
 int ieee80211_hw_config(struct ieee80211_local *local, u32 changed);
+int ieee80211_hw_conf_chan(struct ieee80211_local *local);
+void ieee80211_hw_conf_init(struct ieee80211_local *local);
 void ieee80211_tx_set_protected(struct ieee80211_tx_data *tx);
 void ieee80211_bss_info_change_notify(struct ieee80211_sub_if_data *sdata,
 				      u64 changed);
diff --git a/net/mac80211/iface.c b/net/mac80211/iface.c
index e4e7c0b38cb6..8475f8665323 100644
--- a/net/mac80211/iface.c
+++ b/net/mac80211/iface.c
@@ -1288,8 +1288,6 @@ int ieee80211_do_open(struct wireless_dev *wdev, bool coming_up)
 		res = drv_start(local);
 		if (res)
 			goto err_del_bss;
-		/* we're brought up, everything changes */
-		hw_reconf_flags = ~0;
 		ieee80211_led_radio(local, true);
 		ieee80211_mod_tpt_led_trig(local,
 					   IEEE80211_TPT_LEDTRIG_FL_RADIO, 0);
@@ -1436,7 +1434,9 @@ int ieee80211_do_open(struct wireless_dev *wdev, bool coming_up)
 	if (coming_up)
 		local->open_count++;
 
-	if (hw_reconf_flags)
+	if (local->open_count == 1)
+		ieee80211_hw_conf_init(local);
+	else if (hw_reconf_flags)
 		ieee80211_hw_config(local, hw_reconf_flags);
 
 	ieee80211_recalc_ps(local);
diff --git a/net/mac80211/main.c b/net/mac80211/main.c
index 48e012ee1ae4..0333e98c37a1 100644
--- a/net/mac80211/main.c
+++ b/net/mac80211/main.c
@@ -93,16 +93,32 @@ static void ieee80211_reconfig_filter(struct wiphy *wiphy,
 	ieee80211_configure_filter(local);
 }
 
-static u32 ieee80211_hw_conf_chan(struct ieee80211_local *local)
+static u32 ieee80211_calc_hw_conf_chan(struct ieee80211_local *local,
+				       struct ieee80211_chanctx_conf *ctx)
 {
 	struct ieee80211_sub_if_data *sdata;
 	struct cfg80211_chan_def chandef = {};
+	struct cfg80211_chan_def *oper = NULL;
+	enum ieee80211_smps_mode smps_mode = IEEE80211_SMPS_STATIC;
 	u32 changed = 0;
 	int power;
 	u32 offchannel_flag;
 
+	if (!local->emulate_chanctx)
+		return 0;
+
 	offchannel_flag = local->hw.conf.flags & IEEE80211_CONF_OFFCHANNEL;
 
+	if (ctx && !WARN_ON(!ctx->def.chan)) {
+		oper = &ctx->def;
+		if (ctx->rx_chains_static > 1)
+			smps_mode = IEEE80211_SMPS_OFF;
+		else if (ctx->rx_chains_dynamic > 1)
+			smps_mode = IEEE80211_SMPS_DYNAMIC;
+		else
+			smps_mode = IEEE80211_SMPS_STATIC;
+	}
+
 	if (local->scan_chandef.chan) {
 		chandef = local->scan_chandef;
 	} else if (local->tmp_channel) {
@@ -110,25 +126,30 @@ static u32 ieee80211_hw_conf_chan(struct ieee80211_local *local)
 		chandef.width = NL80211_CHAN_WIDTH_20_NOHT;
 		chandef.center_freq1 = chandef.chan->center_freq;
 		chandef.freq1_offset = chandef.chan->freq_offset;
-	} else
-		chandef = local->_oper_chandef;
+	} else if (oper) {
+		chandef = *oper;
+	} else {
+		chandef = local->dflt_chandef;
+	}
 
-	WARN(!cfg80211_chandef_valid(&chandef),
-	     "control:%d.%03d MHz width:%d center: %d.%03d/%d MHz",
-	     chandef.chan->center_freq, chandef.chan->freq_offset,
-	     chandef.width, chandef.center_freq1, chandef.freq1_offset,
-	     chandef.center_freq2);
+	if (WARN(!cfg80211_chandef_valid(&chandef),
+		 "control:%d.%03d MHz width:%d center: %d.%03d/%d MHz",
+		 chandef.chan ? chandef.chan->center_freq : -1,
+		 chandef.chan ? chandef.chan->freq_offset : 0,
+		 chandef.width, chandef.center_freq1, chandef.freq1_offset,
+		 chandef.center_freq2))
+		return 0;
 
-	if (!cfg80211_chandef_identical(&chandef, &local->_oper_chandef))
+	if (!oper || !cfg80211_chandef_identical(&chandef, oper))
 		local->hw.conf.flags |= IEEE80211_CONF_OFFCHANNEL;
 	else
 		local->hw.conf.flags &= ~IEEE80211_CONF_OFFCHANNEL;
 
 	offchannel_flag ^= local->hw.conf.flags & IEEE80211_CONF_OFFCHANNEL;
 
-	if (offchannel_flag ||
-	    !cfg80211_chandef_identical(&local->hw.conf.chandef,
-					&local->_oper_chandef)) {
+	/* force it also for scanning, since drivers might config differently */
+	if (offchannel_flag || local->scanning ||
+	    !cfg80211_chandef_identical(&local->hw.conf.chandef, &chandef)) {
 		local->hw.conf.chandef = chandef;
 		changed |= IEEE80211_CONF_CHANGE_CHANNEL;
 	}
@@ -140,8 +161,8 @@ static u32 ieee80211_hw_conf_chan(struct ieee80211_local *local)
 		 * that otherwise STATIC is used.
 		 */
 		local->hw.conf.smps_mode = IEEE80211_SMPS_STATIC;
-	} else if (local->hw.conf.smps_mode != local->smps_mode) {
-		local->hw.conf.smps_mode = local->smps_mode;
+	} else if (local->hw.conf.smps_mode != smps_mode) {
+		local->hw.conf.smps_mode = smps_mode;
 		changed |= IEEE80211_CONF_CHANGE_SMPS;
 	}
 
@@ -173,12 +194,9 @@ int ieee80211_hw_config(struct ieee80211_local *local, u32 changed)
 
 	might_sleep();
 
-	if (!local->use_chanctx)
-		changed |= ieee80211_hw_conf_chan(local);
-	else
-		changed &= ~(IEEE80211_CONF_CHANGE_CHANNEL |
-			     IEEE80211_CONF_CHANGE_POWER |
-			     IEEE80211_CONF_CHANGE_SMPS);
+	WARN_ON(changed & (IEEE80211_CONF_CHANGE_CHANNEL |
+			   IEEE80211_CONF_CHANGE_POWER |
+			   IEEE80211_CONF_CHANGE_SMPS));
 
 	if (changed && local->open_count) {
 		ret = drv_config(local, changed);
@@ -202,6 +220,107 @@ int ieee80211_hw_config(struct ieee80211_local *local, u32 changed)
 	return ret;
 }
 
+/* for scanning, offchannel and chanctx emulation only */
+static int _ieee80211_hw_conf_chan(struct ieee80211_local *local,
+				   struct ieee80211_chanctx_conf *ctx)
+{
+	u32 changed;
+
+	if (!local->open_count)
+		return 0;
+
+	changed = ieee80211_calc_hw_conf_chan(local, ctx);
+	if (!changed)
+		return 0;
+
+	return drv_config(local, changed);
+}
+
+int ieee80211_hw_conf_chan(struct ieee80211_local *local)
+{
+	struct ieee80211_chanctx *ctx;
+
+	ctx = list_first_entry_or_null(&local->chanctx_list,
+				       struct ieee80211_chanctx,
+				       list);
+
+	return _ieee80211_hw_conf_chan(local, ctx ? &ctx->conf : NULL);
+}
+
+void ieee80211_hw_conf_init(struct ieee80211_local *local)
+{
+	u32 changed = ~(IEEE80211_CONF_CHANGE_CHANNEL |
+			IEEE80211_CONF_CHANGE_POWER |
+			IEEE80211_CONF_CHANGE_SMPS);
+
+	if (WARN_ON(!local->open_count))
+		return;
+
+	if (local->emulate_chanctx) {
+		struct ieee80211_chanctx *ctx;
+
+		ctx = list_first_entry_or_null(&local->chanctx_list,
+					       struct ieee80211_chanctx,
+					       list);
+
+		changed |= ieee80211_calc_hw_conf_chan(local,
+						       ctx ? &ctx->conf : NULL);
+	}
+
+	WARN_ON(drv_config(local, changed));
+}
+
+int ieee80211_emulate_add_chanctx(struct ieee80211_hw *hw,
+				  struct ieee80211_chanctx_conf *ctx)
+{
+	struct ieee80211_local *local = hw_to_local(hw);
+
+	local->hw.conf.radar_enabled = ctx->radar_enabled;
+
+	return _ieee80211_hw_conf_chan(local, ctx);
+}
+EXPORT_SYMBOL(ieee80211_emulate_add_chanctx);
+
+void ieee80211_emulate_remove_chanctx(struct ieee80211_hw *hw,
+				      struct ieee80211_chanctx_conf *ctx)
+{
+	struct ieee80211_local *local = hw_to_local(hw);
+
+	local->hw.conf.radar_enabled = false;
+
+	_ieee80211_hw_conf_chan(local, NULL);
+}
+EXPORT_SYMBOL(ieee80211_emulate_remove_chanctx);
+
+void ieee80211_emulate_change_chanctx(struct ieee80211_hw *hw,
+				      struct ieee80211_chanctx_conf *ctx,
+				      u32 changed)
+{
+	struct ieee80211_local *local = hw_to_local(hw);
+
+	local->hw.conf.radar_enabled = ctx->radar_enabled;
+
+	_ieee80211_hw_conf_chan(local, ctx);
+}
+EXPORT_SYMBOL(ieee80211_emulate_change_chanctx);
+
+int ieee80211_emulate_switch_vif_chanctx(struct ieee80211_hw *hw,
+					 struct ieee80211_vif_chanctx_switch *vifs,
+					 int n_vifs,
+					 enum ieee80211_chanctx_switch_mode mode)
+{
+	struct ieee80211_local *local = hw_to_local(hw);
+
+	if (n_vifs <= 0)
+		return -EINVAL;
+
+	local->hw.conf.radar_enabled = vifs[0].new_ctx->radar_enabled;
+	_ieee80211_hw_conf_chan(local, vifs[0].new_ctx);
+
+	return 0;
+}
+EXPORT_SYMBOL(ieee80211_emulate_switch_vif_chanctx);
+
 #define BSS_CHANGED_VIF_CFG_FLAGS (BSS_CHANGED_ASSOC |\
 				   BSS_CHANGED_IDLE |\
 				   BSS_CHANGED_PS |\
@@ -644,7 +763,7 @@ struct ieee80211_hw *ieee80211_alloc_hw_nm(size_t priv_data_len,
 	struct ieee80211_local *local;
 	int priv_size, i;
 	struct wiphy *wiphy;
-	bool use_chanctx;
+	bool emulate_chanctx;
 
 	if (WARN_ON(!ops->tx || !ops->start || !ops->stop || !ops->config ||
 		    !ops->add_interface || !ops->remove_interface ||
@@ -659,12 +778,26 @@ struct ieee80211_hw *ieee80211_alloc_hw_nm(size_t priv_data_len,
 		return NULL;
 
 	/* check all or no channel context operations exist */
-	i = !!ops->add_chanctx + !!ops->remove_chanctx +
-	    !!ops->change_chanctx + !!ops->assign_vif_chanctx +
-	    !!ops->unassign_vif_chanctx;
-	if (WARN_ON(i != 0 && i != 5))
-		return NULL;
-	use_chanctx = i == 5;
+	if (ops->add_chanctx == ieee80211_emulate_add_chanctx &&
+	    ops->remove_chanctx == ieee80211_emulate_remove_chanctx &&
+	    ops->change_chanctx == ieee80211_emulate_change_chanctx) {
+		if (WARN_ON(ops->assign_vif_chanctx ||
+			    ops->unassign_vif_chanctx))
+			return NULL;
+		emulate_chanctx = true;
+	} else {
+		if (WARN_ON(ops->add_chanctx == ieee80211_emulate_add_chanctx ||
+			    ops->remove_chanctx == ieee80211_emulate_remove_chanctx ||
+			    ops->change_chanctx == ieee80211_emulate_change_chanctx))
+			return NULL;
+		if (WARN_ON(!ops->add_chanctx ||
+			    !ops->remove_chanctx ||
+			    !ops->change_chanctx ||
+			    !ops->assign_vif_chanctx ||
+			    !ops->unassign_vif_chanctx))
+			return NULL;
+		emulate_chanctx = false;
+	}
 
 	/* Ensure 32-byte alignment of our private data and hw private data.
 	 * We use the wiphy priv data for both our ieee80211_local and for
@@ -698,7 +831,7 @@ struct ieee80211_hw *ieee80211_alloc_hw_nm(size_t priv_data_len,
 			WIPHY_FLAG_REPORTS_OBSS |
 			WIPHY_FLAG_OFFCHAN_TX;
 
-	if (!use_chanctx || ops->remain_on_channel)
+	if (emulate_chanctx || ops->remain_on_channel)
 		wiphy->flags |= WIPHY_FLAG_HAS_REMAIN_ON_CHANNEL;
 
 	wiphy->features |= NL80211_FEATURE_SK_TX_STATUS |
@@ -752,7 +885,10 @@ struct ieee80211_hw *ieee80211_alloc_hw_nm(size_t priv_data_len,
 	local->hw.priv = (char *)local + ALIGN(sizeof(*local), NETDEV_ALIGN);
 
 	local->ops = ops;
-	local->use_chanctx = use_chanctx;
+	local->emulate_chanctx = emulate_chanctx;
+
+	if (emulate_chanctx)
+		ieee80211_hw_set(&local->hw, CHANCTX_STA_CSA);
 
 	/*
 	 * We need a bit of data queued to build aggregates properly, so
@@ -829,7 +965,6 @@ struct ieee80211_hw *ieee80211_alloc_hw_nm(size_t priv_data_len,
 			ieee80211_dfs_radar_detected_work);
 
 	wiphy_work_init(&local->reconfig_filter, ieee80211_reconfig_filter);
-	local->smps_mode = IEEE80211_SMPS_OFF;
 
 	wiphy_work_init(&local->dynamic_ps_enable_work,
 			ieee80211_dynamic_ps_enable_work);
@@ -980,7 +1115,7 @@ int ieee80211_register_hw(struct ieee80211_hw *hw)
 		 * as much, e.g. monitoring beacons would be hard if we
 		 * might not even know which link is active at which time.
 		 */
-		if (WARN_ON(!local->use_chanctx))
+		if (WARN_ON(local->emulate_chanctx))
 			return -EINVAL;
 
 		if (WARN_ON(!local->ops->link_info_changed))
@@ -1024,7 +1159,7 @@ int ieee80211_register_hw(struct ieee80211_hw *hw)
 		return -EINVAL;
 #endif
 
-	if (!local->use_chanctx) {
+	if (local->emulate_chanctx) {
 		for (i = 0; i < local->hw.wiphy->n_iface_combinations; i++) {
 			const struct ieee80211_iface_combination *comb;
 
@@ -1090,11 +1225,11 @@ int ieee80211_register_hw(struct ieee80211_hw *hw)
 						&sband->channels[i],
 						NL80211_CHAN_NO_HT);
 			/* init channel we're on */
-			if (!local->use_chanctx && !local->_oper_chandef.chan) {
+			local->monitor_chandef = dflt_chandef;
+			if (local->emulate_chanctx) {
+				local->dflt_chandef = dflt_chandef;
 				local->hw.conf.chandef = dflt_chandef;
-				local->_oper_chandef = dflt_chandef;
 			}
-			local->monitor_chandef = dflt_chandef;
 		}
 
 		channels += sband->n_channels;
diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index aa1b07c0548a..5036466bcc22 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -2320,8 +2320,7 @@ ieee80211_sta_process_chanswitch(struct ieee80211_link_data *link,
 
 	chanctx = container_of(conf, struct ieee80211_chanctx, conf);
 
-	if (local->use_chanctx &&
-	    !ieee80211_hw_check(&local->hw, CHANCTX_STA_CSA)) {
+	if (!ieee80211_hw_check(&local->hw, CHANCTX_STA_CSA)) {
 		sdata_info(sdata,
 			   "driver doesn't support chan-switch with channel contexts\n");
 		goto drop_connection;
diff --git a/net/mac80211/offchannel.c b/net/mac80211/offchannel.c
index 6c4080202573..221695d841fd 100644
--- a/net/mac80211/offchannel.c
+++ b/net/mac80211/offchannel.c
@@ -86,7 +86,7 @@ void ieee80211_offchannel_stop_vifs(struct ieee80211_local *local)
 
 	lockdep_assert_wiphy(local->hw.wiphy);
 
-	if (WARN_ON(local->use_chanctx))
+	if (WARN_ON(!local->emulate_chanctx))
 		return;
 
 	/*
@@ -136,7 +136,7 @@ void ieee80211_offchannel_return(struct ieee80211_local *local)
 
 	lockdep_assert_wiphy(local->hw.wiphy);
 
-	if (WARN_ON(local->use_chanctx))
+	if (WARN_ON(!local->emulate_chanctx))
 		return;
 
 	list_for_each_entry(sdata, &local->interfaces, list) {
@@ -351,10 +351,13 @@ static void _ieee80211_start_next_roc(struct ieee80211_local *local)
 		 * 20 MHz channel width) don't stop all the operations but still
 		 * treat it as though the ROC operation started properly, so
 		 * other ROC operations won't interfere with this one.
+		 *
+		 * Note: scan can't run, tmp_channel is what we use, so this
+		 * must be the currently active channel.
 		 */
-		roc->on_channel = roc->chan == local->_oper_chandef.chan &&
-				  local->_oper_chandef.width != NL80211_CHAN_WIDTH_5 &&
-				  local->_oper_chandef.width != NL80211_CHAN_WIDTH_10;
+		roc->on_channel = roc->chan == local->hw.conf.chandef.chan &&
+				  local->hw.conf.chandef.width != NL80211_CHAN_WIDTH_5 &&
+				  local->hw.conf.chandef.width != NL80211_CHAN_WIDTH_10;
 
 		/* start this ROC */
 		ieee80211_recalc_idle(local);
@@ -363,7 +366,7 @@ static void _ieee80211_start_next_roc(struct ieee80211_local *local)
 			ieee80211_offchannel_stop_vifs(local);
 
 			local->tmp_channel = roc->chan;
-			ieee80211_hw_config(local, 0);
+			ieee80211_hw_conf_chan(local);
 		}
 
 		wiphy_delayed_work_queue(local->hw.wiphy, &local->roc_work,
@@ -426,7 +429,7 @@ static void __ieee80211_roc_work(struct ieee80211_local *local)
 		return;
 
 	if (!roc->started) {
-		WARN_ON(local->use_chanctx);
+		WARN_ON(!local->emulate_chanctx);
 		_ieee80211_start_next_roc(local);
 	} else {
 		on_channel = roc->on_channel;
@@ -439,7 +442,7 @@ static void __ieee80211_roc_work(struct ieee80211_local *local)
 			ieee80211_flush_queues(local, NULL, false);
 
 			local->tmp_channel = NULL;
-			ieee80211_hw_config(local, 0);
+			ieee80211_hw_conf_chan(local);
 
 			ieee80211_offchannel_return(local);
 		}
@@ -539,7 +542,7 @@ static int ieee80211_start_roc_work(struct ieee80211_local *local,
 		/* this may work, but is untested */
 		return -EOPNOTSUPP;
 
-	if (local->use_chanctx && !local->ops->remain_on_channel)
+	if (!local->emulate_chanctx && !local->ops->remain_on_channel)
 		return -EOPNOTSUPP;
 
 	roc = kzalloc(sizeof(*roc), GFP_KERNEL);
diff --git a/net/mac80211/scan.c b/net/mac80211/scan.c
index 24fa06105378..15a21bbfe671 100644
--- a/net/mac80211/scan.c
+++ b/net/mac80211/scan.c
@@ -449,7 +449,7 @@ static void __ieee80211_scan_completed(struct ieee80211_hw *hw, bool aborted)
 	}
 
 	/* Set power back to normal operating levels. */
-	ieee80211_hw_config(local, 0);
+	ieee80211_hw_conf_chan(local);
 
 	if (!hw_scan && was_scanning) {
 		ieee80211_configure_filter(local);
@@ -496,7 +496,7 @@ static int ieee80211_start_sw_scan(struct ieee80211_local *local,
 				   struct ieee80211_sub_if_data *sdata)
 {
 	/* Software scan is not supported in multi-channel cases */
-	if (local->use_chanctx)
+	if (!local->emulate_chanctx)
 		return -EOPNOTSUPP;
 
 	/*
@@ -526,7 +526,7 @@ static int ieee80211_start_sw_scan(struct ieee80211_local *local,
 	ieee80211_configure_filter(local);
 
 	/* We need to set power level at maximum rate for scanning. */
-	ieee80211_hw_config(local, 0);
+	ieee80211_hw_conf_chan(local);
 
 	wiphy_delayed_work_queue(local->hw.wiphy, &local->scan_work, 0);
 
@@ -743,7 +743,7 @@ static int __ieee80211_start_scan(struct ieee80211_sub_if_data *sdata,
 	if (hw_scan) {
 		__set_bit(SCAN_HW_SCANNING, &local->scanning);
 	} else if ((req->n_channels == 1) &&
-		   (req->channels[0] == local->_oper_chandef.chan)) {
+		   (req->channels[0] == local->hw.conf.chandef.chan)) {
 		/*
 		 * If we are scanning only on the operating channel
 		 * then we do not need to stop normal activities
@@ -761,7 +761,7 @@ static int __ieee80211_start_scan(struct ieee80211_sub_if_data *sdata,
 		ieee80211_configure_filter(local); /* accept probe-responses */
 
 		/* We need to ensure power level is at max for scanning. */
-		ieee80211_hw_config(local, 0);
+		ieee80211_hw_conf_chan(local);
 
 		if ((req->channels[0]->flags & (IEEE80211_CHAN_NO_IR |
 						IEEE80211_CHAN_RADAR)) ||
@@ -926,13 +926,13 @@ static void ieee80211_scan_state_set_channel(struct ieee80211_local *local,
 	/* If scanning on oper channel, use whatever channel-type
 	 * is currently in use.
 	 */
-	if (chan == local->_oper_chandef.chan)
-		local->scan_chandef = local->_oper_chandef;
+	if (chan == local->hw.conf.chandef.chan)
+		local->scan_chandef = local->hw.conf.chandef;
 	else
 		local->scan_chandef.width = NL80211_CHAN_WIDTH_20_NOHT;
 
 set_channel:
-	if (ieee80211_hw_config(local, IEEE80211_CONF_CHANGE_CHANNEL))
+	if (ieee80211_hw_conf_chan(local))
 		skip = 1;
 
 	/* advance state machine to next channel/band */
@@ -973,7 +973,7 @@ static void ieee80211_scan_state_suspend(struct ieee80211_local *local,
 {
 	/* switch back to the operating channel */
 	local->scan_chandef.chan = NULL;
-	ieee80211_hw_config(local, IEEE80211_CONF_CHANGE_CHANNEL);
+	ieee80211_hw_conf_chan(local);
 
 	/* disable PS */
 	ieee80211_offchannel_return(local);
diff --git a/net/mac80211/tx.c b/net/mac80211/tx.c
index ed4fdf655343..d4d177acb4ab 100644
--- a/net/mac80211/tx.c
+++ b/net/mac80211/tx.c
@@ -2393,8 +2393,6 @@ netdev_tx_t ieee80211_monitor_start_xmit(struct sk_buff *skb,
 
 	if (chanctx_conf)
 		chandef = &chanctx_conf->def;
-	else if (!local->use_chanctx)
-		chandef = &local->_oper_chandef;
 	else
 		goto fail_rcu;
 
diff --git a/net/mac80211/util.c b/net/mac80211/util.c
index f9dab1f5b8af..9cb1bd974e3e 100644
--- a/net/mac80211/util.c
+++ b/net/mac80211/util.c
@@ -2474,9 +2474,6 @@ static void ieee80211_assign_chanctx(struct ieee80211_local *local,
 
 	lockdep_assert_wiphy(local->hw.wiphy);
 
-	if (!local->use_chanctx)
-		return;
-
 	conf = rcu_dereference_protected(link->conf->chanctx_conf,
 					 lockdep_is_held(&local->hw.wiphy->mtx));
 	if (conf) {
@@ -2706,17 +2703,13 @@ int ieee80211_reconfig(struct ieee80211_local *local)
 	}
 
 	/* add channel contexts */
-	if (local->use_chanctx) {
-		list_for_each_entry(ctx, &local->chanctx_list, list)
-			if (ctx->replace_state !=
-			    IEEE80211_CHANCTX_REPLACES_OTHER)
-				WARN_ON(drv_add_chanctx(local, ctx));
+	list_for_each_entry(ctx, &local->chanctx_list, list)
+		if (ctx->replace_state != IEEE80211_CHANCTX_REPLACES_OTHER)
+			WARN_ON(drv_add_chanctx(local, ctx));
 
-		sdata = wiphy_dereference(local->hw.wiphy,
-					  local->monitor_sdata);
-		if (sdata && ieee80211_sdata_running(sdata))
-			ieee80211_assign_chanctx(local, sdata, &sdata->deflink);
-	}
+	sdata = wiphy_dereference(local->hw.wiphy, local->monitor_sdata);
+	if (sdata && ieee80211_sdata_running(sdata))
+		ieee80211_assign_chanctx(local, sdata, &sdata->deflink);
 
 	/* reconfigure hardware */
 	ieee80211_hw_config(local, ~0);
-- 
2.42.0


