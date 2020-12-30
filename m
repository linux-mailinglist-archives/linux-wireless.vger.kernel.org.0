Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9EEF42E7BC7
	for <lists+linux-wireless@lfdr.de>; Wed, 30 Dec 2020 19:07:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726636AbgL3SHZ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 30 Dec 2020 13:07:25 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:33552 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726499AbgL3SHZ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 30 Dec 2020 13:07:25 -0500
X-UUID: 8f0889616a364d028d60e3ba79527544-20201231
X-UUID: 8f0889616a364d028d60e3ba79527544-20201231
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw01.mediatek.com
        (envelope-from <sean.wang@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 284475603; Thu, 31 Dec 2020 02:06:34 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs08n2.mediatek.inc (172.21.101.56) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 31 Dec 2020 02:06:32 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 31 Dec 2020 02:06:32 +0800
From:   <sean.wang@mediatek.com>
To:     <nbd@nbd.name>, <lorenzo.bianconi@redhat.com>
CC:     <sean.wang@mediatek.com>, <Soul.Huang@mediatek.com>,
        <YN.Chen@mediatek.com>, <robin.chiu@mediatek.com>,
        <ch.yeh@mediatek.com>, <posh.sun@mediatek.com>,
        <Eric.Liang@mediatek.com>, <ryder.lee@mediatek.com>,
        <linux-wireless@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        Lorenzo Bianconi <lorenzo@kernel.org>
Subject: [PATCH -next v4 12/13] mt76: mt7921: introduce beacon_loss mcu event
Date:   Thu, 31 Dec 2020 02:06:23 +0800
Message-ID: <4d75d071a77b2b72bb15751d2ebeb976c10fb0d5.1609347310.git.objelf@gmail.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <cover.1609347310.git.objelf@gmail.com>
References: <cover.1609347310.git.objelf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: EE4371DEF2D16316E0CB0D83846B82A0B3495C25C423D8439F181976683DFD8F2000:8
X-MTK:  N
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Sean Wang <sean.wang@mediatek.com>

If device has enabled beacon hw filter rx beacons are not reported to
the host. Introduce beacon_loss mcu event to trigger mac80211 mlme
connection state machine in this configuration.
IEEE80211_VIF_BEACON_FILTER has not set in vif flags since hw beacon
filter is not enabled yet

Co-developed-by: Lorenzo Bianconi <lorenzo@kernel.org>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
Co-developed-by: Soul Huang <Soul.Huang@mediatek.com>
Signed-off-by: Soul Huang <Soul.Huang@mediatek.com>
Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 .../net/wireless/mediatek/mt76/mt7921/mcu.c   | 35 +++++++++++++++++++
 .../net/wireless/mediatek/mt76/mt7921/mcu.h   |  6 ++++
 2 files changed, 41 insertions(+)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c
index 11550be87402..003424a82ca2 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c
@@ -543,6 +543,40 @@ mt7921_mcu_scan_event(struct mt7921_dev *dev, struct sk_buff *skb)
 				     MT7921_HW_SCAN_TIMEOUT);
 }
 
+static void
+mt7921_mcu_beacon_loss_iter(void *priv, u8 *mac, struct ieee80211_vif *vif)
+{
+	struct mt7921_vif *mvif = (struct mt7921_vif *)vif->drv_priv;
+	struct mt7921_beacon_loss_event *event = priv;
+
+	if (mvif->idx != event->bss_idx)
+		return;
+
+	if (!(vif->driver_flags & IEEE80211_VIF_BEACON_FILTER))
+		return;
+
+	ieee80211_beacon_loss(vif);
+}
+
+static void
+mt7921_mcu_beacon_loss_event(struct mt7921_dev *dev, struct sk_buff *skb)
+{
+	struct mt7921_beacon_loss_event *event;
+	struct mt76_phy *mphy;
+	u8 band_idx = 0; /* DBDC support */
+
+	skb_pull(skb, sizeof(struct mt7921_mcu_rxd));
+	event = (struct mt7921_beacon_loss_event *)skb->data;
+	if (band_idx && dev->mt76.phy2)
+		mphy = dev->mt76.phy2;
+	else
+		mphy = &dev->mt76.phy;
+
+	ieee80211_iterate_active_interfaces_atomic(mphy->hw,
+					IEEE80211_IFACE_ITER_RESUME_ALL,
+					mt7921_mcu_beacon_loss_iter, event);
+}
+
 static void
 mt7921_mcu_bss_event(struct mt7921_dev *dev, struct sk_buff *skb)
 {
@@ -593,6 +627,7 @@ mt7921_mcu_rx_unsolicited_event(struct mt7921_dev *dev, struct sk_buff *skb)
 
 	switch (rxd->eid) {
 	case MCU_EVENT_BSS_BEACON_LOSS:
+		mt7921_mcu_beacon_loss_event(dev, skb);
 		break;
 	case MCU_EVENT_SCHED_SCAN_DONE:
 	case MCU_EVENT_SCAN_DONE:
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mcu.h b/drivers/net/wireless/mediatek/mt76/mt7921/mcu.h
index 6894b44ff62d..d6cb062619db 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mcu.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mcu.h
@@ -783,6 +783,12 @@ struct mt7921_bss_qos_tlv {
 	u8 pad[3];
 } __packed;
 
+struct mt7921_beacon_loss_event {
+	u8 bss_idx;
+	u8 reason;
+	u8 pad[2];
+} __packed;
+
 struct mt7921_mcu_scan_ssid {
 	__le32 ssid_len;
 	u8 ssid[IEEE80211_MAX_SSID_LEN];
-- 
2.25.1

