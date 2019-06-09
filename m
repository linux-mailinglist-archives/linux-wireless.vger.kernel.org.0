Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 52E7A3A468
	for <lists+linux-wireless@lfdr.de>; Sun,  9 Jun 2019 11:09:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727949AbfFIJJ3 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 9 Jun 2019 05:09:29 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:27831 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726686AbfFIJJ3 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 9 Jun 2019 05:09:29 -0400
X-UUID: a0186053efee4110bba9dd38feabe007-20190609
X-UUID: a0186053efee4110bba9dd38feabe007-20190609
Received: from mtkcas09.mediatek.inc [(172.21.101.178)] by mailgw02.mediatek.com
        (envelope-from <ryder.lee@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 1120937258; Sun, 09 Jun 2019 17:09:14 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs06n2.mediatek.inc (172.21.101.130) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Sun, 9 Jun 2019 17:09:12 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Sun, 9 Jun 2019 17:09:12 +0800
From:   Ryder Lee <ryder.lee@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>,
        Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
CC:     Roy Luo <royluo@google.com>, YF Luo <yf.luo@mediatek.com>,
        Yiwei Chung <yiwei.chung@mediatek.com>,
        Sean Wang <sean.wang@mediatek.com>,
        Chih-Min Chen <chih-min.Chen@mediatek.com>,
        <linux-wireless@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Ryder Lee <ryder.lee@mediatek.com>
Subject: [PATCH] mt76: mt7615: add support for per-chain signal strength reporting
Date:   Sun, 9 Jun 2019 17:09:09 +0800
Message-ID: <3912a2863e858f3623ced61737836e42c7b19149.1560071167.git.ryder.lee@mediatek.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: DB8247693516C4362ADACC260C0932459B29918DD6EF956B1C4C564524ED25A62000:8
X-MTK:  N
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Fill in RX status->chain_signal to avoid empty value.

Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
---
 .../net/wireless/mediatek/mt76/mt7615/mac.c   | 30 ++++++++++++++++++-
 .../net/wireless/mediatek/mt76/mt7615/mac.h   |  5 ++++
 2 files changed, 34 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mac.c b/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
index b60d42b5923d..9ee83ea11b8c
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
@@ -13,6 +13,11 @@
 #include "../dma.h"
 #include "mac.h"
 
+static inline s8 to_rssi(u32 field, u32 rxv)
+{
+	return (FIELD_GET(field, rxv) - 220) / 2;
+}
+
 static struct mt76_wcid *mt7615_rx_get_wcid(struct mt7615_dev *dev,
 					    u8 idx, bool unicast)
 {
@@ -120,6 +125,7 @@ int mt7615_mac_fill_rx(struct mt7615_dev *dev, struct sk_buff *skb)
 	if (rxd0 & MT_RXD0_NORMAL_GROUP_3) {
 		u32 rxdg0 = le32_to_cpu(rxd[0]);
 		u32 rxdg1 = le32_to_cpu(rxd[1]);
+		u32 rxdg3 = le32_to_cpu(rxd[3]);
 		u8 stbc = FIELD_GET(MT_RXV1_HT_STBC, rxdg0);
 		bool cck = false;
 
@@ -169,7 +175,29 @@ int mt7615_mac_fill_rx(struct mt7615_dev *dev, struct sk_buff *skb)
 
 		status->enc_flags |= RX_ENC_FLAG_STBC_MASK * stbc;
 
-		/* TODO: RSSI */
+		status->chains = dev->mt76.antenna_mask;
+		status->chain_signal[0] = to_rssi(MT_RXV4_RCPI0, rxdg3);
+		status->signal = status->chain_signal[0];
+
+		switch (status->chains) {
+		case 0x3:
+			status->chain_signal[1] = to_rssi(MT_RXV4_RCPI1, rxdg3);
+			status->signal = max(status->signal,
+					     status->chain_signal[1]);
+			break;
+		case 0x7:
+			status->chain_signal[2] = to_rssi(MT_RXV4_RCPI2, rxdg3);
+			status->signal = max(status->signal,
+					     status->chain_signal[2]);
+			break;
+		case 0xf:
+			status->chain_signal[3] = to_rssi(MT_RXV4_RCPI3, rxdg3);
+			status->signal = max(status->signal,
+					     status->chain_signal[3]);
+			break;
+		default:
+			break;
+		}
 		rxd += 6;
 		if ((u8 *)rxd - skb->data >= skb->len)
 			return -EINVAL;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mac.h b/drivers/net/wireless/mediatek/mt76/mt7615/mac.h
index 18ad4b8a3807..b00ce8db58e9
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mac.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mac.h
@@ -98,6 +98,11 @@ enum rx_pkt_type {
 #define MT_RXV2_GROUP_ID		GENMASK(26, 21)
 #define MT_RXV2_LENGTH			GENMASK(20, 0)
 
+#define MT_RXV4_RCPI3			GENMASK(31, 24)
+#define MT_RXV4_RCPI2			GENMASK(23, 16)
+#define MT_RXV4_RCPI1			GENMASK(15, 8)
+#define MT_RXV4_RCPI0			GENMASK(7, 0)
+
 enum tx_header_format {
 	MT_HDR_FORMAT_802_3,
 	MT_HDR_FORMAT_CMD,
-- 
2.18.0

