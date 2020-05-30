Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B9D61E9441
	for <lists+linux-wireless@lfdr.de>; Sun, 31 May 2020 00:32:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729383AbgE3WcN (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 30 May 2020 18:32:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:50010 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729350AbgE3WcM (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 30 May 2020 18:32:12 -0400
Received: from lore-desk.lan (unknown [151.48.140.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C535A20722;
        Sat, 30 May 2020 22:32:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590877931;
        bh=amUoZL6QKQcO/tVjLKrFIHXDeNoyTu8hrOHcz5ECADk=;
        h=From:To:Cc:Subject:Date:From;
        b=SeH9DGnxGA6GtP+MP7LIOx+AlFBLn0CSnhm0aScBpQ/uaccxN8YalCRSl5JDsAWHW
         kqGUtQGGnfRFBExAaWuBJUakgDiIQJ605pKF4qMXbJcoS3CyktLSkZpuD9sKSVqsvx
         O/MRE/sg/S7UeFha9Ki/cxvegXBK0ElEuv5dGlLA=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com,
        ryder.lee@mediatek.com, sean.wang@mediatek.com
Subject: [PATCH] mt76: mt7615: fix hw queue mapping
Date:   Sun, 31 May 2020 00:32:04 +0200
Message-Id: <9162b8579eb0109f4df1fa87716728a7ef1cdc0e.1590877636.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

mt7622/mt7663 chipsets rely on a fixed reverse queue map order respect
to mac80211 one:
- q(0): IEEE80211_AC_BK
- q(1): IEEE80211_AC_BE
- q(2): IEEE80211_AC_VI
- q(3): IEEE80211_AC_VO

Fixes: cdad4874057d ("mt76: mt7615: add dma and tx queue initialization for MT7622")
Fixes: f40ac0f3d3c0 ("mt76: mt7615: introduce mt7663e support")
Co-developed-by: Sean Wang <sean.wang@mediatek.com>
Signed-off-by: Sean Wang <sean.wang@mediatek.com>
Co-developed-by: Ryder Lee <ryder.lee@mediatek.com> 
Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 .../net/wireless/mediatek/mt76/mt7615/dma.c   |  8 ++---
 .../net/wireless/mediatek/mt76/mt7615/mac.c   |  2 +-
 .../net/wireless/mediatek/mt76/mt7615/mac.h   | 15 ----------
 .../net/wireless/mediatek/mt76/mt7615/main.c  |  1 +
 .../wireless/mediatek/mt76/mt7615/mt7615.h    | 30 +++++++++++++++++++
 drivers/net/wireless/mediatek/mt76/usb.c      | 17 ++++++-----
 6 files changed, 45 insertions(+), 28 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/dma.c b/drivers/net/wireless/mediatek/mt76/mt7615/dma.c
index 5a124610d4af..83fdcf5db3c7 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/dma.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/dma.c
@@ -36,10 +36,10 @@ static int
 mt7622_init_tx_queues_multi(struct mt7615_dev *dev)
 {
 	static const u8 wmm_queue_map[] = {
-		MT7622_TXQ_AC0,
-		MT7622_TXQ_AC1,
-		MT7622_TXQ_AC2,
-		MT7622_TXQ_AC3,
+		[IEEE80211_AC_BK] = MT7622_TXQ_AC0,
+		[IEEE80211_AC_BE] = MT7622_TXQ_AC1,
+		[IEEE80211_AC_VI] = MT7622_TXQ_AC2,
+		[IEEE80211_AC_VO] = MT7622_TXQ_AC3,
 	};
 	int ret;
 	int i;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mac.c b/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
index 9f1c6ca7a665..5990355bc731 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
@@ -528,7 +528,7 @@ int mt7615_mac_write_txwi(struct mt7615_dev *dev, __le32 *txwi,
 
 	if (ieee80211_is_data(fc) || ieee80211_is_bufferable_mmpdu(fc)) {
 		q_idx = wmm_idx * MT7615_MAX_WMM_SETS +
-			skb_get_queue_mapping(skb);
+			mt7615_lmac_mapping(dev, skb_get_queue_mapping(skb));
 		p_fmt = is_usb ? MT_TX_TYPE_SF : MT_TX_TYPE_CT;
 	} else if (beacon) {
 		if (ext_phy)
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mac.h b/drivers/net/wireless/mediatek/mt76/mt7615/mac.h
index f0d4b29a52a2..81608ab656b8 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mac.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mac.h
@@ -124,21 +124,6 @@ enum tx_pkt_type {
 	MT_TX_TYPE_FW,
 };
 
-enum tx_pkt_queue_idx {
-	MT_LMAC_AC00,
-	MT_LMAC_AC01,
-	MT_LMAC_AC02,
-	MT_LMAC_AC03,
-	MT_LMAC_ALTX0 = 0x10,
-	MT_LMAC_BMC0,
-	MT_LMAC_BCN0,
-	MT_LMAC_PSMP0,
-	MT_LMAC_ALTX1,
-	MT_LMAC_BMC1,
-	MT_LMAC_BCN1,
-	MT_LMAC_PSMP1,
-};
-
 enum tx_port_idx {
 	MT_TX_PORT_IDX_LMAC,
 	MT_TX_PORT_IDX_MCU
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/main.c b/drivers/net/wireless/mediatek/mt76/mt7615/main.c
index e5edbbe945bf..6c7aed51bcfd 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/main.c
@@ -397,6 +397,7 @@ mt7615_conf_tx(struct ieee80211_hw *hw, struct ieee80211_vif *vif, u16 queue,
 	struct mt7615_vif *mvif = (struct mt7615_vif *)vif->drv_priv;
 	struct mt7615_dev *dev = mt7615_hw_dev(hw);
 
+	queue = mt7615_lmac_mapping(dev, queue);
 	queue += mvif->wmm_idx * MT7615_MAX_WMM_SETS;
 
 	return mt7615_mcu_set_wmm(dev, queue, params);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h b/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
index 5e79c94e1d55..a9513a456521 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
@@ -282,6 +282,21 @@ struct mt7615_dev {
 	struct list_head wd_head;
 };
 
+enum tx_pkt_queue_idx {
+	MT_LMAC_AC00,
+	MT_LMAC_AC01,
+	MT_LMAC_AC02,
+	MT_LMAC_AC03,
+	MT_LMAC_ALTX0 = 0x10,
+	MT_LMAC_BMC0,
+	MT_LMAC_BCN0,
+	MT_LMAC_PSMP0,
+	MT_LMAC_ALTX1,
+	MT_LMAC_BMC1,
+	MT_LMAC_BCN1,
+	MT_LMAC_PSMP1,
+};
+
 enum {
 	HW_BSSID_0 = 0x0,
 	HW_BSSID_1,
@@ -447,6 +462,21 @@ static inline u16 mt7615_wtbl_size(struct mt7615_dev *dev)
 		return MT7615_WTBL_SIZE;
 }
 
+static inline u8 mt7615_lmac_mapping(struct mt7615_dev *dev, u8 ac)
+{
+	static const u8 lmac_queue_map[] = {
+		[IEEE80211_AC_BK] = MT_LMAC_AC00,
+		[IEEE80211_AC_BE] = MT_LMAC_AC01,
+		[IEEE80211_AC_VI] = MT_LMAC_AC02,
+		[IEEE80211_AC_VO] = MT_LMAC_AC03,
+	};
+
+	if (WARN_ON_ONCE(ac >= ARRAY_SIZE(lmac_queue_map)))
+		return MT_LMAC_AC01; /* BE */
+
+	return lmac_queue_map[ac];
+}
+
 void mt7615_dma_reset(struct mt7615_dev *dev);
 void mt7615_scan_work(struct work_struct *work);
 void mt7615_roc_work(struct work_struct *work);
diff --git a/drivers/net/wireless/mediatek/mt76/usb.c b/drivers/net/wireless/mediatek/mt76/usb.c
index 63919a36281e..0ff3096f7455 100644
--- a/drivers/net/wireless/mediatek/mt76/usb.c
+++ b/drivers/net/wireless/mediatek/mt76/usb.c
@@ -993,17 +993,18 @@ static void mt76u_tx_kick(struct mt76_dev *dev, struct mt76_queue *q)
 static u8 mt76u_ac_to_hwq(struct mt76_dev *dev, u8 ac)
 {
 	if (mt76_chip(dev) == 0x7663) {
-		static const u8 wmm_queue_map[] = {
-			[IEEE80211_AC_VO] = 0,
-			[IEEE80211_AC_VI] = 1,
-			[IEEE80211_AC_BE] = 2,
-			[IEEE80211_AC_BK] = 4,
+		static const u8 lmac_queue_map[] = {
+			/* ac to lmac mapping */
+			[IEEE80211_AC_BK] = 0,
+			[IEEE80211_AC_BE] = 1,
+			[IEEE80211_AC_VI] = 2,
+			[IEEE80211_AC_VO] = 4,
 		};
 
-		if (WARN_ON(ac >= ARRAY_SIZE(wmm_queue_map)))
-			return 2; /* BE */
+		if (WARN_ON(ac >= ARRAY_SIZE(lmac_queue_map)))
+			return 1; /* BE */
 
-		return wmm_queue_map[ac];
+		return lmac_queue_map[ac];
 	}
 
 	return mt76_ac_to_hwq(ac);
-- 
2.26.2

