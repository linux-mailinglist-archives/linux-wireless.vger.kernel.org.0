Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2091937925C
	for <lists+linux-wireless@lfdr.de>; Mon, 10 May 2021 17:18:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235224AbhEJPTA (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 10 May 2021 11:19:00 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:58505 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S240785AbhEJPQu (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 10 May 2021 11:16:50 -0400
X-UUID: 54c13996d2734fc5b53fdf81cfbba77e-20210510
X-UUID: 54c13996d2734fc5b53fdf81cfbba77e-20210510
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw01.mediatek.com
        (envelope-from <sean.wang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 2021363846; Mon, 10 May 2021 23:15:01 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs06n1.mediatek.inc (172.21.101.129) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 10 May 2021 23:15:00 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 10 May 2021 23:14:59 +0800
From:   <sean.wang@mediatek.com>
To:     <nbd@nbd.name>, <lorenzo.bianconi@redhat.com>
CC:     <sean.wang@mediatek.com>, <Soul.Huang@mediatek.com>,
        <YN.Chen@mediatek.com>, <Leon.Yen@mediatek.com>,
        <Eric-SY.Chang@mediatek.com>, <Deren.Wu@mediatek.com>,
        <km.lin@mediatek.com>, <robin.chiu@mediatek.com>,
        <ch.yeh@mediatek.com>, <posh.sun@mediatek.com>,
        <Eric.Liang@mediatek.com>, <Stella.Chang@mediatek.com>,
        <jemele@google.com>, <yenlinlai@google.com>,
        <linux-wireless@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        Deren Wu <deren.wu@mediatek.com>,
        YN Chen <yn.chen@mediatek.com>
Subject: [PATCH 9/9] mt76: mt7921: add back connection monitor support
Date:   Mon, 10 May 2021 23:14:57 +0800
Message-ID: <1620659697-12048-9-git-send-email-sean.wang@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1620659697-12048-1-git-send-email-sean.wang@mediatek.com>
References: <1620659697-12048-1-git-send-email-sean.wang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Sean Wang <sean.wang@mediatek.com>

Hw beacon cmd to the mt7921 firmware doesn't only filter out the beacon,
but also performs its own connection monitoring, including periodic
keep-alives to the AP and probing the AP on beacon loss. Will indicate
the host with the event when the firmware detects the connection is lost.

Fixes: 1d8efc741df8 ("mt76: mt7921: introduce Runtime PM support")
Reviewed-by: Lorenzo Bianconi <lorenzo@kernel.org>
Signed-off-by: Deren Wu <deren.wu@mediatek.com>
Signed-off-by: YN Chen <yn.chen@mediatek.com>
Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 .../net/wireless/mediatek/mt76/mt7921/init.c  |  4 +++
 .../net/wireless/mediatek/mt76/mt7921/mcu.c   | 32 +++++++++++++------
 2 files changed, 27 insertions(+), 9 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/init.c b/drivers/net/wireless/mediatek/mt76/mt7921/init.c
index cd68721314fa..cbb1d432a591 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/init.c
@@ -73,6 +73,7 @@ static void
 mt7921_init_wiphy(struct ieee80211_hw *hw)
 {
 	struct mt7921_phy *phy = mt7921_hw_phy(hw);
+	struct mt7921_dev *dev = phy->dev;
 	struct wiphy *wiphy = hw->wiphy;
 
 	hw->queues = 4;
@@ -112,6 +113,9 @@ mt7921_init_wiphy(struct ieee80211_hw *hw)
 	ieee80211_hw_set(hw, SUPPORTS_PS);
 	ieee80211_hw_set(hw, SUPPORTS_DYNAMIC_PS);
 
+	if (dev->pm.enable)
+		ieee80211_hw_set(hw, CONNECTION_MONITOR);
+
 	hw->max_tx_fragments = 4;
 }
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c
index 67dc4b4cc094..7c68182cad55 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c
@@ -450,22 +450,33 @@ mt7921_mcu_scan_event(struct mt7921_dev *dev, struct sk_buff *skb)
 }
 
 static void
-mt7921_mcu_beacon_loss_event(struct mt7921_dev *dev, struct sk_buff *skb)
+mt7921_mcu_connection_loss_iter(void *priv, u8 *mac,
+				struct ieee80211_vif *vif)
+{
+	struct mt76_vif *mvif = (struct mt76_vif *)vif->drv_priv;
+	struct mt76_connac_beacon_loss_event *event = priv;
+
+	if (mvif->idx != event->bss_idx)
+		return;
+
+	if (!(vif->driver_flags & IEEE80211_VIF_BEACON_FILTER))
+		return;
+
+	ieee80211_connection_loss(vif);
+}
+
+static void
+mt7921_mcu_connection_loss_event(struct mt7921_dev *dev, struct sk_buff *skb)
 {
 	struct mt76_connac_beacon_loss_event *event;
-	struct mt76_phy *mphy;
-	u8 band_idx = 0; /* DBDC support */
+	struct mt76_phy *mphy = &dev->mt76.phy;
 
 	skb_pull(skb, sizeof(struct mt7921_mcu_rxd));
 	event = (struct mt76_connac_beacon_loss_event *)skb->data;
-	if (band_idx && dev->mt76.phy2)
-		mphy = dev->mt76.phy2;
-	else
-		mphy = &dev->mt76.phy;
 
 	ieee80211_iterate_active_interfaces_atomic(mphy->hw,
 					IEEE80211_IFACE_ITER_RESUME_ALL,
-					mt76_connac_mcu_beacon_loss_iter, event);
+					mt7921_mcu_connection_loss_iter, event);
 }
 
 static void
@@ -530,7 +541,7 @@ mt7921_mcu_rx_unsolicited_event(struct mt7921_dev *dev, struct sk_buff *skb)
 
 	switch (rxd->eid) {
 	case MCU_EVENT_BSS_BEACON_LOSS:
-		mt7921_mcu_beacon_loss_event(dev, skb);
+		mt7921_mcu_connection_loss_event(dev, skb);
 		break;
 	case MCU_EVENT_SCHED_SCAN_DONE:
 	case MCU_EVENT_SCAN_DONE:
@@ -1368,6 +1379,7 @@ mt7921_pm_interface_iter(void *priv, u8 *mac, struct ieee80211_vif *vif)
 {
 	struct mt7921_phy *phy = priv;
 	struct mt7921_dev *dev = phy->dev;
+	struct ieee80211_hw *hw = mt76_hw(dev);
 	int ret;
 
 	if (dev->pm.enable)
@@ -1380,9 +1392,11 @@ mt7921_pm_interface_iter(void *priv, u8 *mac, struct ieee80211_vif *vif)
 
 	if (dev->pm.enable) {
 		vif->driver_flags |= IEEE80211_VIF_BEACON_FILTER;
+		ieee80211_hw_set(hw, CONNECTION_MONITOR);
 		mt76_set(dev, MT_WF_RFCR(0), MT_WF_RFCR_DROP_OTHER_BEACON);
 	} else {
 		vif->driver_flags &= ~IEEE80211_VIF_BEACON_FILTER;
+		__clear_bit(IEEE80211_HW_CONNECTION_MONITOR, hw->flags);
 		mt76_clear(dev, MT_WF_RFCR(0), MT_WF_RFCR_DROP_OTHER_BEACON);
 	}
 }
-- 
2.25.1

