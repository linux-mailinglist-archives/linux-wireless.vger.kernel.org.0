Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED5254920C1
	for <lists+linux-wireless@lfdr.de>; Tue, 18 Jan 2022 08:58:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245511AbiARH6v (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 18 Jan 2022 02:58:51 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:39828 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S238767AbiARH6v (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 18 Jan 2022 02:58:51 -0500
X-UUID: e0b731c4d03743e6ae5f4cef3af10eae-20220118
X-UUID: e0b731c4d03743e6ae5f4cef3af10eae-20220118
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw02.mediatek.com
        (envelope-from <ryder.lee@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1200913783; Tue, 18 Jan 2022 15:58:48 +0800
Received: from mtkexhb01.mediatek.inc (172.21.101.102) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 18 Jan 2022 15:58:47 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by mtkexhb01.mediatek.inc
 (172.21.101.102) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 18 Jan
 2022 15:58:46 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 18 Jan 2022 15:58:46 +0800
From:   Ryder Lee <ryder.lee@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>
CC:     Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        Evelyn Tsai <evelyn.tsai@mediatek.com>,
        <linux-wireless@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        "Ryder Lee" <ryder.lee@mediatek.com>
Subject: [PATCH] mt76: mt7915: check band idx for bcc event
Date:   Tue, 18 Jan 2022 15:58:45 +0800
Message-ID: <74293a8c02d0e6ca3460aa30bd374cddec9a0a1e.1642485678.git.ryder.lee@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Add missing band idx check for DBDC cases.

Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
---
This depends on https://patchwork.kernel.org/project/linux-wireless/patch/055b47746ca7756fd8ed14ff197c0c090393369d.1642128031.git.Bo.Jiao@mediatek.com/
---
 .../net/wireless/mediatek/mt76/mt7915/mcu.c   | 20 ++++++++++++++++---
 .../net/wireless/mediatek/mt76/mt7915/mcu.h   |  9 +++++++++
 2 files changed, 26 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
index 43c95bd15170..6c5568d6abde 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
@@ -422,6 +422,22 @@ mt7915_mcu_cca_finish(void *priv, u8 *mac, struct ieee80211_vif *vif)
 	ieee80211_color_change_finish(vif);
 }
 
+static void
+mt7915_mcu_rx_bcc_notify(struct mt7915_dev *dev, struct sk_buff *skb)
+{
+	struct mt76_phy *mphy = &dev->mt76.phy;
+	struct mt7915_mcu_bcc_notify *b;
+
+	b = (struct mt7915_mcu_bcc_notify *)skb->data;
+
+	if ((b->band_idx && !dev->phy.band_idx) && dev->mt76.phy2)
+		mphy = dev->mt76.phy2;
+
+	ieee80211_iterate_active_interfaces_atomic(mphy->hw,
+			IEEE80211_IFACE_ITER_RESUME_ALL,
+			mt7915_mcu_cca_finish, mphy->hw);
+}
+
 static void
 mt7915_mcu_rx_ext_event(struct mt7915_dev *dev, struct sk_buff *skb)
 {
@@ -441,9 +457,7 @@ mt7915_mcu_rx_ext_event(struct mt7915_dev *dev, struct sk_buff *skb)
 		mt7915_mcu_rx_log_message(dev, skb);
 		break;
 	case MCU_EXT_EVENT_BCC_NOTIFY:
-		ieee80211_iterate_active_interfaces_atomic(dev->mt76.hw,
-				IEEE80211_IFACE_ITER_RESUME_ALL,
-				mt7915_mcu_cca_finish, dev);
+		mt7915_mcu_rx_bcc_notify(dev, skb);
 		break;
 	default:
 		break;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.h b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.h
index aa05c6ceebb9..fb558a6945fd 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.h
@@ -79,6 +79,15 @@ struct mt7915_mcu_csa_notify {
 	u8 rsv;
 } __packed;
 
+struct mt7915_mcu_bcc_notify {
+	struct mt7915_mcu_rxd rxd;
+
+	u8 band_idx;
+	u8 omac_idx;
+	u8 cca_count;
+	u8 rsv;
+} __packed;
+
 struct mt7915_mcu_rdd_report {
 	struct mt7915_mcu_rxd rxd;
 
-- 
2.29.2

