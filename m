Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD7C53E4E4A
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Aug 2021 23:13:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234080AbhHIVOK (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 9 Aug 2021 17:14:10 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:46936 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S229516AbhHIVOJ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 9 Aug 2021 17:14:09 -0400
X-UUID: f979d803fb0c4455bb0e271c7fecbbff-20210810
X-UUID: f979d803fb0c4455bb0e271c7fecbbff-20210810
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw02.mediatek.com
        (envelope-from <sean.wang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1741321336; Tue, 10 Aug 2021 05:13:45 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 10 Aug 2021 05:13:44 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 10 Aug 2021 05:13:44 +0800
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
        <linux-mediatek@lists.infradead.org>
Subject: [PATCH] mt76: fix determining multicast frame in sta mode
Date:   Tue, 10 Aug 2021 05:13:43 +0800
Message-ID: <fbc5d3da47b6a5e99ae255560279268f580e7b22.1628543190.git.objelf@gmail.com>
X-Mailer: git-send-email 1.7.9.5
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Sean Wang <sean.wang@mediatek.com>

We should use hdr->addr3 as the destination address to determine the frame
is multicast frame or not when the device is running in sta mode.

We can simply use ieee80211_get_DA for ap mode and sta mode both cases.

Signed-off-by: Sean Wang <sean.wang@mediatek.com>
Tested-by: Joshua Emele <jemele@chromium.org>
Tested-by: YN Chen <YN.Chen@mediatek.com>
---
v1: patch is generated on the top of mt76 with the additional patches
    [1/2] mt76: mt7915: send EAPOL frames at lowest rate
    [2/2] mt76: mt7921: send EAPOL frames at lowest rate
    [v2] mt76: add support for setting mcast rate
---
 drivers/net/wireless/mediatek/mt76/mt7603/mac.c | 2 +-
 drivers/net/wireless/mediatek/mt76/mt7615/mac.c | 2 +-
 drivers/net/wireless/mediatek/mt76/mt7915/mac.c | 2 +-
 drivers/net/wireless/mediatek/mt76/mt7921/mac.c | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7603/mac.c b/drivers/net/wireless/mediatek/mt76/mt7603/mac.c
index 3972c56136a2..be5f68485337 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7603/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7603/mac.c
@@ -965,7 +965,7 @@ mt7603_mac_write_txwi(struct mt7603_dev *dev, __le32 *txwi,
 	val = FIELD_PREP(MT_TXD2_FRAME_TYPE, frame_type) |
 	      FIELD_PREP(MT_TXD2_SUB_TYPE, frame_subtype) |
 	      FIELD_PREP(MT_TXD2_MULTICAST,
-			 is_multicast_ether_addr(hdr->addr1));
+			 is_multicast_ether_addr(ieee80211_get_DA(hdr)));
 	txwi[2] = cpu_to_le32(val);
 
 	if (!(info->flags & IEEE80211_TX_CTL_AMPDU))
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mac.c b/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
index 5455231f5188..756b7c283a57 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
@@ -617,7 +617,7 @@ int mt7615_mac_write_txwi(struct mt7615_dev *dev, __le32 *txwi,
 	struct ieee80211_tx_info *info = IEEE80211_SKB_CB(skb);
 	struct ieee80211_tx_rate *rate = &info->control.rates[0];
 	bool ext_phy = info->hw_queue & MT_TX_HW_QUEUE_EXT_PHY;
-	bool multicast = is_multicast_ether_addr(hdr->addr1);
+	bool multicast = is_multicast_ether_addr(ieee80211_get_DA(hdr));
 	struct ieee80211_vif *vif = info->control.vif;
 	bool is_mmio = mt76_is_mmio(&dev->mt76);
 	u32 val, sz_txd = is_mmio ? MT_TXD_SIZE : MT_USB_TXD_SIZE;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
index 975e81e09a70..8b9dd77968fa 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
@@ -918,7 +918,7 @@ mt7915_mac_write_txwi_80211(struct mt7915_dev *dev, __le32 *txwi,
 	u8 fc_type, fc_stype;
 	u32 val;
 
-	*mcast = is_multicast_ether_addr(hdr->addr1);
+	*mcast = is_multicast_ether_addr(ieee80211_get_DA(hdr));
 
 	if (ieee80211_is_action(fc) &&
 	    mgmt->u.action.category == WLAN_CATEGORY_BACK &&
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mac.c b/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
index 7c95189cf8cf..755a8777e47e 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
@@ -663,7 +663,7 @@ mt7921_mac_write_txwi_80211(struct mt7921_dev *dev, __le32 *txwi,
 	struct ieee80211_hdr *hdr = (struct ieee80211_hdr *)skb->data;
 	struct ieee80211_mgmt *mgmt = (struct ieee80211_mgmt *)skb->data;
 	struct ieee80211_tx_info *info = IEEE80211_SKB_CB(skb);
-	bool multicast = is_multicast_ether_addr(hdr->addr1);
+	bool multicast = is_multicast_ether_addr(ieee80211_get_DA(hdr));
 	u8 tid = skb->priority & IEEE80211_QOS_CTL_TID_MASK;
 	__le16 fc = hdr->frame_control;
 	u8 fc_type, fc_stype;
-- 
2.25.1

