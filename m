Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F2373013FB
	for <lists+linux-wireless@lfdr.de>; Sat, 23 Jan 2021 09:37:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726931AbhAWIhV (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 23 Jan 2021 03:37:21 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:54837 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726913AbhAWIhN (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 23 Jan 2021 03:37:13 -0500
X-UUID: 48beb95f5b324c459a837a4aac08739e-20210123
X-UUID: 48beb95f5b324c459a837a4aac08739e-20210123
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw01.mediatek.com
        (envelope-from <sean.wang@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 832853991; Sat, 23 Jan 2021 16:35:22 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs08n1.mediatek.inc (172.21.101.55) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Sat, 23 Jan 2021 16:35:16 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Sat, 23 Jan 2021 16:35:16 +0800
From:   <sean.wang@mediatek.com>
To:     <nbd@nbd.name>, <lorenzo.bianconi@redhat.com>
CC:     <sean.wang@mediatek.com>, <Soul.Huang@mediatek.com>,
        <YN.Chen@mediatek.com>, <robin.chiu@mediatek.com>,
        <ch.yeh@mediatek.com>, <posh.sun@mediatek.com>,
        <Eric.Liang@mediatek.com>, <ryder.lee@mediatek.com>,
        <linux-wireless@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        Lorenzo Bianconi <lorenzo@kernel.org>
Subject: [PATCH -next v7 12/22] mt76: mt7921: introduce beacon_loss mcu event
Date:   Sat, 23 Jan 2021 16:35:03 +0800
Message-ID: <485042b4c1c2cce9bf0b0c2fc2c75766d644cd0b.1611389300.git.objelf@gmail.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <cover.1611389300.git.objelf@gmail.com>
References: <cover.1611389300.git.objelf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
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
index 768456c7aa7f..02fde1c63ecf 100644
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
+	if (mvif->mt76.idx != event->bss_idx)
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
index de3a9aabec04..bf2e643cd870 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mcu.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mcu.h
@@ -784,6 +784,12 @@ struct mt7921_bss_qos_tlv {
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

