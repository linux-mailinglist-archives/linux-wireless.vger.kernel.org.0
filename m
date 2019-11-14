Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 00161FC998
	for <lists+linux-wireless@lfdr.de>; Thu, 14 Nov 2019 16:12:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726528AbfKNPMW (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 14 Nov 2019 10:12:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:50006 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726444AbfKNPMW (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 14 Nov 2019 10:12:22 -0500
Received: from localhost.localdomain.com (unknown [77.139.212.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CF51C206DC;
        Thu, 14 Nov 2019 15:12:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573744341;
        bh=3Hc/8pRTRQ5zFvjaF9cSqGQlvRs9ChJ45uCvan7bnOY=;
        h=From:To:Cc:Subject:Date:From;
        b=U+ie80mlXuCG2MoQ2PlJ3pTDa8PQexCwxsn5C3PDeyI/OMIsCmn5kKEmKrN4uqUzV
         XVFaPuXo9PmhZyCdh+IFyTKEJXmWj06ZD/q4CNFz1VII4pajtv8R03Dq+93adrNhSn
         fSCgdancjh0AhP2W6h5XIfcWeApRZ9qZ437DatgI=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com
Subject: [PATCH] mt76: move mt76_get_antenna in mt76_core module
Date:   Thu, 14 Nov 2019 17:12:07 +0200
Message-Id: <af30d94a66ebadec557b2d148f6468918cea4a04.1573742879.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Move mt76_get_antenna in mac80211.c in order to be reused by all
drivers. Initialize .get_antenna function pointer for mt76x0, mt7603,
mt7615 and mt76x2u drivers

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mac80211.c     | 13 +++++++++++++
 drivers/net/wireless/mediatek/mt76/mt76.h         |  1 +
 drivers/net/wireless/mediatek/mt76/mt7603/main.c  |  1 +
 drivers/net/wireless/mediatek/mt76/mt7615/main.c  |  1 +
 drivers/net/wireless/mediatek/mt76/mt76x0/pci.c   |  1 +
 drivers/net/wireless/mediatek/mt76/mt76x0/usb.c   |  1 +
 .../net/wireless/mediatek/mt76/mt76x2/pci_main.c  | 15 +--------------
 .../net/wireless/mediatek/mt76/mt76x2/usb_main.c  |  1 +
 8 files changed, 20 insertions(+), 14 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mac80211.c b/drivers/net/wireless/mediatek/mt76/mac80211.c
index 2003223ff329..61049ce5c996 100644
--- a/drivers/net/wireless/mediatek/mt76/mac80211.c
+++ b/drivers/net/wireless/mediatek/mt76/mac80211.c
@@ -1036,3 +1036,16 @@ void mt76_sw_scan_complete(struct ieee80211_hw *hw, struct ieee80211_vif *vif)
 	clear_bit(MT76_SCANNING, &dev->state);
 }
 EXPORT_SYMBOL_GPL(mt76_sw_scan_complete);
+
+int mt76_get_antenna(struct ieee80211_hw *hw, u32 *tx_ant, u32 *rx_ant)
+{
+	struct mt76_dev *dev = hw->priv;
+
+	mutex_lock(&dev->mutex);
+	*tx_ant = dev->antenna_mask;
+	*rx_ant = dev->antenna_mask;
+	mutex_unlock(&dev->mutex);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(mt76_get_antenna);
diff --git a/drivers/net/wireless/mediatek/mt76/mt76.h b/drivers/net/wireless/mediatek/mt76/mt76.h
index d22d673e3c5d..4116ad7928da 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76.h
@@ -763,6 +763,7 @@ int mt76_get_txpower(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 void mt76_csa_check(struct mt76_dev *dev);
 void mt76_csa_finish(struct mt76_dev *dev);
 
+int mt76_get_antenna(struct ieee80211_hw *hw, u32 *tx_ant, u32 *rx_ant);
 int mt76_set_tim(struct ieee80211_hw *hw, struct ieee80211_sta *sta, bool set);
 void mt76_insert_ccmp_hdr(struct sk_buff *skb, u8 key_id);
 int mt76_get_rate(struct mt76_dev *dev,
diff --git a/drivers/net/wireless/mediatek/mt76/mt7603/main.c b/drivers/net/wireless/mediatek/mt76/mt7603/main.c
index a68bfbccd83f..6a6bc37b898f 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7603/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7603/main.c
@@ -686,6 +686,7 @@ const struct ieee80211_ops mt7603_ops = {
 	.set_coverage_class = mt7603_set_coverage_class,
 	.set_tim = mt76_set_tim,
 	.get_survey = mt76_get_survey,
+	.get_antenna = mt76_get_antenna,
 };
 
 MODULE_LICENSE("Dual BSD/GPL");
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/main.c b/drivers/net/wireless/mediatek/mt76/mt7615/main.c
index 0a3cdc7ae5c4..78bbed7a4645 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/main.c
@@ -542,4 +542,5 @@ const struct ieee80211_ops mt7615_ops = {
 	.get_txpower = mt76_get_txpower,
 	.channel_switch_beacon = mt7615_channel_switch_beacon,
 	.get_survey = mt76_get_survey,
+	.get_antenna = mt76_get_antenna,
 };
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x0/pci.c b/drivers/net/wireless/mediatek/mt76/mt76x0/pci.c
index 9621e7b16eaf..dd562e37994f 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x0/pci.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x0/pci.c
@@ -94,6 +94,7 @@ static const struct ieee80211_ops mt76x0e_ops = {
 	.release_buffered_frames = mt76_release_buffered_frames,
 	.set_coverage_class = mt76x02_set_coverage_class,
 	.set_rts_threshold = mt76x02_set_rts_threshold,
+	.get_antenna = mt76_get_antenna,
 };
 
 static int mt76x0e_register_device(struct mt76x02_dev *dev)
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x0/usb.c b/drivers/net/wireless/mediatek/mt76/mt76x0/usb.c
index a8ab8df075c3..65ba9fc6ea0b 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x0/usb.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x0/usb.c
@@ -138,6 +138,7 @@ static const struct ieee80211_ops mt76x0u_ops = {
 	.get_survey = mt76_get_survey,
 	.set_tim = mt76_set_tim,
 	.release_buffered_frames = mt76_release_buffered_frames,
+	.get_antenna = mt76_get_antenna,
 };
 
 static int mt76x0u_init_hardware(struct mt76x02_dev *dev, bool reset)
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x2/pci_main.c b/drivers/net/wireless/mediatek/mt76/mt76x2/pci_main.c
index 1387f3172d7f..cfe8905ce73f 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x2/pci_main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x2/pci_main.c
@@ -135,19 +135,6 @@ static int mt76x2_set_antenna(struct ieee80211_hw *hw, u32 tx_ant,
 	return 0;
 }
 
-static int mt76x2_get_antenna(struct ieee80211_hw *hw, u32 *tx_ant,
-			      u32 *rx_ant)
-{
-	struct mt76x02_dev *dev = hw->priv;
-
-	mutex_lock(&dev->mt76.mutex);
-	*tx_ant = dev->mt76.antenna_mask;
-	*rx_ant = dev->mt76.antenna_mask;
-	mutex_unlock(&dev->mt76.mutex);
-
-	return 0;
-}
-
 const struct ieee80211_ops mt76x2_ops = {
 	.tx = mt76x02_tx,
 	.start = mt76x2_start,
@@ -172,7 +159,7 @@ const struct ieee80211_ops mt76x2_ops = {
 	.get_survey = mt76_get_survey,
 	.set_tim = mt76_set_tim,
 	.set_antenna = mt76x2_set_antenna,
-	.get_antenna = mt76x2_get_antenna,
+	.get_antenna = mt76_get_antenna,
 	.set_rts_threshold = mt76x02_set_rts_threshold,
 };
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x2/usb_main.c b/drivers/net/wireless/mediatek/mt76/mt76x2/usb_main.c
index a76a40dcd261..9e97204841f5 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x2/usb_main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x2/usb_main.c
@@ -119,4 +119,5 @@ const struct ieee80211_ops mt76x2u_ops = {
 	.get_survey = mt76_get_survey,
 	.set_tim = mt76_set_tim,
 	.release_buffered_frames = mt76_release_buffered_frames,
+	.get_antenna = mt76_get_antenna,
 };
-- 
2.21.0

