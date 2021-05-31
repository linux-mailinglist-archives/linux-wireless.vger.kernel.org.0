Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3264B39658A
	for <lists+linux-wireless@lfdr.de>; Mon, 31 May 2021 18:38:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231843AbhEaQjh (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 31 May 2021 12:39:37 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:33569 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S231949AbhEaQhE (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 31 May 2021 12:37:04 -0400
X-UUID: 80e9839df25f4914b62f51502a4959a7-20210601
X-UUID: 80e9839df25f4914b62f51502a4959a7-20210601
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw01.mediatek.com
        (envelope-from <deren.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 813919618; Tue, 01 Jun 2021 00:28:36 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs06n2.mediatek.inc (172.21.101.130) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 1 Jun 2021 00:28:35 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 1 Jun 2021 00:28:34 +0800
From:   Deren Wu <Deren.Wu@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>,
        Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
CC:     Sean Wang <sean.wang@mediatek.com>,
        Soul Huang <Soul.Huang@mediatek.com>,
        YN Chen <YN.Chen@mediatek.com>,
        Leon Yen <Leon.Yen@mediatek.com>,
        Eric-SY Chang <Eric-SY.Chang@mediatek.com>,
        Deren Wu <Deren.Wu@mediatek.com>, KM Lin <km.lin@mediatek.com>,
        Robin Chiu <robin.chiu@mediatek.com>,
        CH Yeh <ch.yeh@mediatek.com>, Posh Sun <posh.sun@mediatek.com>,
        Eric Liang <Eric.Liang@mediatek.com>,
        Stella Chang <Stella.Chang@mediatek.com>, <jemele@google.com>,
        <yenlinlai@google.com>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        linux-mediatek <linux-mediatek@lists.infradead.org>,
        Deren Wu <deren.wu@mediatek.com>
Subject: [PATCH] mt76: mt7921: enable random mac address during sched_scan
Date:   Tue, 1 Jun 2021 00:28:31 +0800
Message-ID: <14360a28083d56520a2cabc87841d9dee3d97a01.1622476643.git.deren.wu@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Deren Wu <deren.wu@mediatek.com>

Enable src address randomization during scheduled scanning

Co-developed-by: Lorenzo Bianconi <lorenzo@kernel.org>
Signed-off-by: Deren Wu <deren.wu@mediatek.com>
---
 .../net/wireless/mediatek/mt76/mt76_connac_mcu.c   | 14 ++++++++------
 .../net/wireless/mediatek/mt76/mt76_connac_mcu.h   |  4 +++-
 drivers/net/wireless/mediatek/mt76/mt7921/init.c   |  3 ++-
 3 files changed, 13 insertions(+), 8 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
index 73359defa176..b155e7b8d89d 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
@@ -1515,14 +1515,16 @@ int mt76_connac_mcu_sched_scan_req(struct mt76_phy *phy,
 	req->version = 1;
 	req->seq_num = mvif->scan_seq_num | ext_phy << 7;
 
-	if (is_mt7663(phy->dev) &&
-	    (sreq->flags & NL80211_SCAN_FLAG_RANDOM_ADDR)) {
-		get_random_mask_addr(req->mt7663.random_mac, sreq->mac_addr,
-				     sreq->mac_addr_mask);
+	if (sreq->flags & NL80211_SCAN_FLAG_RANDOM_ADDR) {
+		u8 *addr = is_mt7663(phy->dev) ? req->mt7663.random_mac
+					       : req->mt7921.random_mac;
+
 		req->scan_func = 1;
-	} else if (is_mt7921(phy->dev)) {
-		req->mt7921.bss_idx = mvif->idx;
+		get_random_mask_addr(addr, sreq->mac_addr,
+				     sreq->mac_addr_mask);
 	}
+	if (is_mt7921(phy->dev))
+		req->mt7921.bss_idx = mvif->idx;
 
 	req->ssids_num = sreq->n_ssids;
 	for (i = 0; i < req->ssids_num; i++) {
diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
index d64b8058b744..3076417ead5f 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
@@ -779,7 +779,9 @@ struct mt76_connac_sched_scan_req {
 		} mt7663;
 		struct {
 			u8 bss_idx;
-			u8 pad2[63];
+			u8 pad2[19];
+			u8 random_mac[ETH_ALEN];
+			u8 pad3[38];
 		} mt7921;
 	};
 } __packed;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/init.c b/drivers/net/wireless/mediatek/mt76/mt7921/init.c
index 59da29032645..19ce9ca72542 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/init.c
@@ -76,7 +76,8 @@ mt7921_init_wiphy(struct ieee80211_hw *hw)
 	wiphy->flags |= WIPHY_FLAG_HAS_CHANNEL_SWITCH;
 	wiphy->reg_notifier = mt7921_regd_notifier;
 
-	wiphy->features |= NL80211_FEATURE_SCAN_RANDOM_MAC_ADDR;
+	wiphy->features |= NL80211_FEATURE_SCHED_SCAN_RANDOM_MAC_ADDR |
+			   NL80211_FEATURE_SCAN_RANDOM_MAC_ADDR;
 	wiphy_ext_feature_set(wiphy, NL80211_EXT_FEATURE_SET_SCAN_DWELL);
 
 	ieee80211_hw_set(hw, SINGLE_SCAN_ON_ALL_BANDS);
-- 
2.18.0

