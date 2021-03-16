Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 117F333CC99
	for <lists+linux-wireless@lfdr.de>; Tue, 16 Mar 2021 05:36:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232072AbhCPEgA (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 16 Mar 2021 00:36:00 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:50050 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S230056AbhCPEf3 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 16 Mar 2021 00:35:29 -0400
X-UUID: 7bfdc8fbf4524239b693094eb0c7c8c1-20210316
X-UUID: 7bfdc8fbf4524239b693094eb0c7c8c1-20210316
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw01.mediatek.com
        (envelope-from <ryder.lee@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1934087708; Tue, 16 Mar 2021 12:35:22 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs08n2.mediatek.inc (172.21.101.56) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 16 Mar 2021 12:35:20 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 16 Mar 2021 12:35:19 +0800
From:   Ryder Lee <ryder.lee@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>,
        Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
CC:     Shayne Chen <shayne.chen@mediatek.com>,
        <linux-wireless@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        Ryder Lee <ryder.lee@mediatek.com>
Subject: [PATCH] mt76: mt7615: fix CSA event format
Date:   Tue, 16 Mar 2021 12:35:15 +0800
Message-ID: <f349fbb1287b723913dc8be95b637310443c6b90.1615854190.git.ryder.lee@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 9C1B20F972B573BBD31E665557CA1402A9924B6BB084AA667F98CEB3C50C85712000:8
X-MTK:  N
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Fix format changes among the firmware versions.

Fixes: f9390c251868 ("mt76: mt7615: fix CSA notification for DBDC")
Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
---
@Felix, please help to fold this, if the previous one hasn't been pulled.
---
 drivers/net/wireless/mediatek/mt76/mt7615/mcu.c | 3 ++-
 drivers/net/wireless/mediatek/mt76/mt7615/mcu.h | 3 +--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
index 44daee41aa6c..4ca0d8d4c536 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
@@ -375,12 +375,13 @@ mt7615_mcu_csa_finish(void *priv, u8 *mac, struct ieee80211_vif *vif)
 static void
 mt7615_mcu_rx_csa_notify(struct mt7615_dev *dev, struct sk_buff *skb)
 {
+	struct mt7615_phy *ext_phy = mt7615_ext_phy(dev);
 	struct mt76_phy *mphy = &dev->mt76.phy;
 	struct mt7615_mcu_csa_notify *c;
 
 	c = (struct mt7615_mcu_csa_notify *)skb->data;
 
-	if (c->band_idx && dev->mt76.phy2)
+	if (ext_phy && ext_phy->omac_mask & BIT_ULL(c->omac_idx))
 		mphy = dev->mt76.phy2;
 
 	ieee80211_iterate_active_interfaces_atomic(mphy->hw,
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.h b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.h
index dbf72b1396c7..98c383e400a1 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.h
@@ -181,8 +181,7 @@ struct mt7615_mcu_csa_notify {
 
 	u8 omac_idx;
 	u8 csa_count;
-	u8 band_idx;
-	u8 rsv;
+	u8 rsv[2];
 } __packed;
 
 struct mt7615_mcu_rdd_report {
-- 
2.18.0

