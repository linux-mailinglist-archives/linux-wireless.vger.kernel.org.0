Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA69A326C25
	for <lists+linux-wireless@lfdr.de>; Sat, 27 Feb 2021 08:42:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229835AbhB0HlR (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 27 Feb 2021 02:41:17 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:58999 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S229864AbhB0HlP (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 27 Feb 2021 02:41:15 -0500
X-UUID: 7d226079d97c4f04be8c1b72a7f35cd2-20210227
X-UUID: 7d226079d97c4f04be8c1b72a7f35cd2-20210227
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw02.mediatek.com
        (envelope-from <ryder.lee@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 929979107; Sat, 27 Feb 2021 15:40:25 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs06n1.mediatek.inc (172.21.101.129) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Sat, 27 Feb 2021 15:40:24 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Sat, 27 Feb 2021 15:40:24 +0800
From:   Ryder Lee <ryder.lee@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>,
        Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
CC:     Shayne Chen <shayne.chen@mediatek.com>,
        <linux-wireless@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        Ryder Lee <ryder.lee@mediatek.com>
Subject: [PATCH 3/5] mt76: mt7915: fix CSA notification for DBDC
Date:   Sat, 27 Feb 2021 15:39:44 +0800
Message-ID: <114e7a30299b95b0de410320eb7077542cc1a65e.1614411256.git.ryder.lee@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <d6f2573790582538e8ba82f87a4c35329692ee32.1614411256.git.ryder.lee@mediatek.com>
References: <d6f2573790582538e8ba82f87a4c35329692ee32.1614411256.git.ryder.lee@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Add CSA notification for second phy.

Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
---
 .../net/wireless/mediatek/mt76/mt7915/mcu.c   | 24 +++++++++++++++----
 .../net/wireless/mediatek/mt76/mt7915/mcu.h   | 11 ++++++++-
 2 files changed, 29 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
index 6c429a2b15c5..4abe32357edc 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
@@ -336,6 +336,22 @@ mt7915_mcu_csa_finish(void *priv, u8 *mac, struct ieee80211_vif *vif)
 		ieee80211_csa_finish(vif);
 }
 
+static void
+mt7915_mcu_rx_csa_notify(struct mt7915_dev *dev, struct sk_buff *skb)
+{
+	struct mt76_phy *mphy = &dev->mt76.phy;
+	struct mt7915_mcu_csa_notify *c;
+
+	c = (struct mt7915_mcu_csa_notify *)skb->data;
+
+	if (c->band_idx && dev->mt76.phy2)
+		mphy = dev->mt76.phy2;
+
+	ieee80211_iterate_active_interfaces_atomic(mphy->hw,
+			IEEE80211_IFACE_ITER_RESUME_ALL,
+			mt7915_mcu_csa_finish, mphy->hw);
+}
+
 static void
 mt7915_mcu_rx_radar_detected(struct mt7915_dev *dev, struct sk_buff *skb)
 {
@@ -344,7 +360,7 @@ mt7915_mcu_rx_radar_detected(struct mt7915_dev *dev, struct sk_buff *skb)
 
 	r = (struct mt7915_mcu_rdd_report *)skb->data;
 
-	if (r->idx && dev->mt76.phy2)
+	if (r->band_idx && dev->mt76.phy2)
 		mphy = dev->mt76.phy2;
 
 	ieee80211_radar_detected(mphy->hw);
@@ -511,9 +527,7 @@ mt7915_mcu_rx_ext_event(struct mt7915_dev *dev, struct sk_buff *skb)
 		mt7915_mcu_rx_radar_detected(dev, skb);
 		break;
 	case MCU_EXT_EVENT_CSA_NOTIFY:
-		ieee80211_iterate_active_interfaces_atomic(dev->mt76.hw,
-				IEEE80211_IFACE_ITER_RESUME_ALL,
-				mt7915_mcu_csa_finish, dev);
+		mt7915_mcu_rx_csa_notify(dev, skb);
 		break;
 	case MCU_EXT_EVENT_RATE_REPORT:
 		mt7915_mcu_tx_rate_report(dev, skb);
@@ -3219,7 +3233,7 @@ int mt7915_mcu_set_chan_info(struct mt7915_phy *phy, int cmd)
 	}
 #endif
 
-	if (dev->mt76.hw->conf.flags & IEEE80211_CONF_OFFCHANNEL)
+	if (phy->mt76->hw->conf.flags & IEEE80211_CONF_OFFCHANNEL)
 		req.switch_reason = CH_SWITCH_SCAN_BYPASS_DPD;
 	else if ((chandef->chan->flags & IEEE80211_CHAN_RADAR) &&
 		 chandef->chan->dfs_state != NL80211_DFS_AVAILABLE)
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.h b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.h
index 2a2f7bf2c94b..4a932140a7c3 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.h
@@ -68,10 +68,19 @@ struct mt7915_mcu_rxd {
 	u8 s2d_index;
 };
 
+struct mt7915_mcu_csa_notify {
+	struct mt7915_mcu_rxd rxd;
+
+	u8 omac_idx;
+	u8 csa_count;
+	u8 band_idx;
+	u8 rsv;
+} __packed;
+
 struct mt7915_mcu_rdd_report {
 	struct mt7915_mcu_rxd rxd;
 
-	u8 idx;
+	u8 band_idx;
 	u8 long_detected;
 	u8 constant_prf_detected;
 	u8 staggered_prf_detected;
-- 
2.18.0

