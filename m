Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BAA8B9744B
	for <lists+linux-wireless@lfdr.de>; Wed, 21 Aug 2019 10:00:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726617AbfHUIAc (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 21 Aug 2019 04:00:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:39136 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726217AbfHUIAb (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 21 Aug 2019 04:00:31 -0400
Received: from localhost.localdomain (unknown [151.66.62.27])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7FA7722CF7;
        Wed, 21 Aug 2019 08:00:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566374431;
        bh=arjp3jTV0fA1QHLhxyotl75Uv9QFKtiq173hYVtvjAM=;
        h=From:To:Cc:Subject:Date:From;
        b=INOvMkoCCysMGyi3+u6IAIPJ/DGbLJbgzWPz+FRD2hEnHsElvzJO+Vu4vFVWE3tGm
         0uH5cu9q1NYWipQbyRpN8D7bHeYXubTxzPnjZ5punqxHs/vDLlOLYwrHkpwqS+lyht
         Kuhxe1D+Dlrk9QrJT6H1EsilYqA7ZnfibIa6jHC4=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, linux-wireless@vger.kernel.org,
        sgruszka@redhat.com, ryder.lee@mediatek.com, royluo@google.com
Subject: [PATCH] mt76: add default implementation for mt76_sw_scan/mt76_sw_scan_complete
Date:   Wed, 21 Aug 2019 10:00:19 +0200
Message-Id: <b7a77887e505ead4d0856c0e9d0b62c2bdfbcd44.1566374214.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Introduce a default implementation for mt76_sw_scan and
mt76_sw_scan_complete in mt76 module and remove duplicated code
since most of the drivers share the same implementation

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mac80211.c | 17 +++++++++++++++
 drivers/net/wireless/mediatek/mt76/mt76.h     |  4 ++++
 .../net/wireless/mediatek/mt76/mt7603/main.c  | 21 ++-----------------
 .../net/wireless/mediatek/mt76/mt7615/main.c  | 21 ++-----------------
 .../net/wireless/mediatek/mt76/mt76x0/pci.c   |  2 +-
 .../net/wireless/mediatek/mt76/mt76x0/usb.c   |  2 +-
 drivers/net/wireless/mediatek/mt76/mt76x02.h  |  2 --
 .../net/wireless/mediatek/mt76/mt76x02_util.c |  9 --------
 .../wireless/mediatek/mt76/mt76x2/pci_main.c  |  2 +-
 .../wireless/mediatek/mt76/mt76x2/usb_main.c  |  2 +-
 10 files changed, 29 insertions(+), 53 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mac80211.c b/drivers/net/wireless/mediatek/mt76/mac80211.c
index ba67b0a55390..532d8576f7ae 100644
--- a/drivers/net/wireless/mediatek/mt76/mac80211.c
+++ b/drivers/net/wireless/mediatek/mt76/mac80211.c
@@ -870,3 +870,20 @@ int mt76_get_rate(struct mt76_dev *dev,
 	return 0;
 }
 EXPORT_SYMBOL_GPL(mt76_get_rate);
+
+void mt76_sw_scan(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
+		  const u8 *mac)
+{
+	struct mt76_dev *dev = hw->priv;
+
+	set_bit(MT76_SCANNING, &dev->state);
+}
+EXPORT_SYMBOL_GPL(mt76_sw_scan);
+
+void mt76_sw_scan_complete(struct ieee80211_hw *hw, struct ieee80211_vif *vif)
+{
+	struct mt76_dev *dev = hw->priv;
+
+	clear_bit(MT76_SCANNING, &dev->state);
+}
+EXPORT_SYMBOL_GPL(mt76_sw_scan_complete);
diff --git a/drivers/net/wireless/mediatek/mt76/mt76.h b/drivers/net/wireless/mediatek/mt76/mt76.h
index 0668ddb1ccbd..16884ba88af5 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76.h
@@ -765,6 +765,10 @@ void mt76_insert_ccmp_hdr(struct sk_buff *skb, u8 key_id);
 int mt76_get_rate(struct mt76_dev *dev,
 		  struct ieee80211_supported_band *sband,
 		  int idx, bool cck);
+void mt76_sw_scan(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
+		  const u8 *mac);
+void mt76_sw_scan_complete(struct ieee80211_hw *hw,
+			   struct ieee80211_vif *vif);
 
 /* internal */
 void mt76_tx_free(struct mt76_dev *dev);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7603/main.c b/drivers/net/wireless/mediatek/mt76/mt7603/main.c
index 7adf2f8cd2b0..e35c1e4da7ea 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7603/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7603/main.c
@@ -536,23 +536,6 @@ mt7603_conf_tx(struct ieee80211_hw *hw, struct ieee80211_vif *vif, u16 queue,
 	return 0;
 }
 
-static void
-mt7603_sw_scan(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
-	       const u8 *mac)
-{
-	struct mt7603_dev *dev = hw->priv;
-
-	set_bit(MT76_SCANNING, &dev->mt76.state);
-}
-
-static void
-mt7603_sw_scan_complete(struct ieee80211_hw *hw, struct ieee80211_vif *vif)
-{
-	struct mt7603_dev *dev = hw->priv;
-
-	clear_bit(MT76_SCANNING, &dev->mt76.state);
-}
-
 static void
 mt7603_flush(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 	     u32 queues, bool drop)
@@ -683,8 +666,8 @@ const struct ieee80211_ops mt7603_ops = {
 	.sta_state = mt76_sta_state,
 	.set_key = mt7603_set_key,
 	.conf_tx = mt7603_conf_tx,
-	.sw_scan_start = mt7603_sw_scan,
-	.sw_scan_complete = mt7603_sw_scan_complete,
+	.sw_scan_start = mt76_sw_scan,
+	.sw_scan_complete = mt76_sw_scan_complete,
 	.flush = mt7603_flush,
 	.ampdu_action = mt7603_ampdu_action,
 	.get_txpower = mt76_get_txpower,
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/main.c b/drivers/net/wireless/mediatek/mt76/mt7615/main.c
index 0b833c7a21d4..e2a84f717051 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/main.c
@@ -490,23 +490,6 @@ mt7615_ampdu_action(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 	return 0;
 }
 
-static void
-mt7615_sw_scan(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
-	       const u8 *mac)
-{
-	struct mt7615_dev *dev = hw->priv;
-
-	set_bit(MT76_SCANNING, &dev->mt76.state);
-}
-
-static void
-mt7615_sw_scan_complete(struct ieee80211_hw *hw, struct ieee80211_vif *vif)
-{
-	struct mt7615_dev *dev = hw->priv;
-
-	clear_bit(MT76_SCANNING, &dev->mt76.state);
-}
-
 const struct ieee80211_ops mt7615_ops = {
 	.tx = mt7615_tx,
 	.start = mt7615_start,
@@ -523,8 +506,8 @@ const struct ieee80211_ops mt7615_ops = {
 	.set_rts_threshold = mt7615_set_rts_threshold,
 	.wake_tx_queue = mt76_wake_tx_queue,
 	.sta_rate_tbl_update = mt7615_sta_rate_tbl_update,
-	.sw_scan_start = mt7615_sw_scan,
-	.sw_scan_complete = mt7615_sw_scan_complete,
+	.sw_scan_start = mt76_sw_scan,
+	.sw_scan_complete = mt76_sw_scan_complete,
 	.release_buffered_frames = mt76_release_buffered_frames,
 	.get_txpower = mt76_get_txpower,
 	.channel_switch_beacon = mt7615_channel_switch_beacon,
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x0/pci.c b/drivers/net/wireless/mediatek/mt76/mt76x0/pci.c
index b2ff1fd20162..f84a7df296ea 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x0/pci.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x0/pci.c
@@ -69,7 +69,7 @@ static const struct ieee80211_ops mt76x0e_ops = {
 	.sta_state = mt76_sta_state,
 	.set_key = mt76x02_set_key,
 	.conf_tx = mt76x02_conf_tx,
-	.sw_scan_start = mt76x02_sw_scan,
+	.sw_scan_start = mt76_sw_scan,
 	.sw_scan_complete = mt76x02_sw_scan_complete,
 	.ampdu_action = mt76x02_ampdu_action,
 	.sta_rate_tbl_update = mt76x02_sta_rate_tbl_update,
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x0/usb.c b/drivers/net/wireless/mediatek/mt76/mt76x0/usb.c
index a06930bfd75d..c3379db88a1f 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x0/usb.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x0/usb.c
@@ -128,7 +128,7 @@ static const struct ieee80211_ops mt76x0u_ops = {
 	.sta_state = mt76_sta_state,
 	.set_key = mt76x02_set_key,
 	.conf_tx = mt76x02_conf_tx,
-	.sw_scan_start = mt76x02_sw_scan,
+	.sw_scan_start = mt76_sw_scan,
 	.sw_scan_complete = mt76x02_sw_scan_complete,
 	.ampdu_action = mt76x02_ampdu_action,
 	.sta_rate_tbl_update = mt76x02_sta_rate_tbl_update,
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x02.h b/drivers/net/wireless/mediatek/mt76/mt76x02.h
index fb7008562ebf..5d0591b43c36 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x02.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76x02.h
@@ -177,8 +177,6 @@ int mt76x02_tx_prepare_skb(struct mt76_dev *mdev, void *txwi,
 			   enum mt76_txq_id qid, struct mt76_wcid *wcid,
 			   struct ieee80211_sta *sta,
 			   struct mt76_tx_info *tx_info);
-void mt76x02_sw_scan(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
-		     const u8 *mac);
 void mt76x02_sw_scan_complete(struct ieee80211_hw *hw,
 			      struct ieee80211_vif *vif);
 void mt76x02_sta_ps(struct mt76_dev *dev, struct ieee80211_sta *sta, bool ps);
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x02_util.c b/drivers/net/wireless/mediatek/mt76/mt76x02_util.c
index 81d98030fc7a..dbd9d99225ff 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x02_util.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x02_util.c
@@ -603,15 +603,6 @@ void mt76x02_remove_hdr_pad(struct sk_buff *skb, int len)
 }
 EXPORT_SYMBOL_GPL(mt76x02_remove_hdr_pad);
 
-void mt76x02_sw_scan(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
-		     const u8 *mac)
-{
-	struct mt76x02_dev *dev = hw->priv;
-
-	set_bit(MT76_SCANNING, &dev->mt76.state);
-}
-EXPORT_SYMBOL_GPL(mt76x02_sw_scan);
-
 void mt76x02_sw_scan_complete(struct ieee80211_hw *hw,
 			      struct ieee80211_vif *vif)
 {
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x2/pci_main.c b/drivers/net/wireless/mediatek/mt76/mt76x2/pci_main.c
index 3921d965a106..4971685aafe8 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x2/pci_main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x2/pci_main.c
@@ -165,7 +165,7 @@ const struct ieee80211_ops mt76x2_ops = {
 	.sta_state = mt76_sta_state,
 	.set_key = mt76x02_set_key,
 	.conf_tx = mt76x02_conf_tx,
-	.sw_scan_start = mt76x02_sw_scan,
+	.sw_scan_start = mt76_sw_scan,
 	.sw_scan_complete = mt76x02_sw_scan_complete,
 	.flush = mt76x2_flush,
 	.ampdu_action = mt76x02_ampdu_action,
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x2/usb_main.c b/drivers/net/wireless/mediatek/mt76/mt76x2/usb_main.c
index 1b692fba5a89..eb73cb856c81 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x2/usb_main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x2/usb_main.c
@@ -114,7 +114,7 @@ const struct ieee80211_ops mt76x2u_ops = {
 	.bss_info_changed = mt76x02_bss_info_changed,
 	.configure_filter = mt76x02_configure_filter,
 	.conf_tx = mt76x02_conf_tx,
-	.sw_scan_start = mt76x02_sw_scan,
+	.sw_scan_start = mt76_sw_scan,
 	.sw_scan_complete = mt76x02_sw_scan_complete,
 	.sta_rate_tbl_update = mt76x02_sta_rate_tbl_update,
 	.get_txpower = mt76_get_txpower,
-- 
2.21.0

