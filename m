Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DE01D30FA9
	for <lists+linux-wireless@lfdr.de>; Fri, 31 May 2019 16:10:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726576AbfEaOKG (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 31 May 2019 10:10:06 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:21176 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726037AbfEaOKG (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 31 May 2019 10:10:06 -0400
X-UUID: be41b96eef4743b3afb8372cf6ec3245-20190531
X-UUID: be41b96eef4743b3afb8372cf6ec3245-20190531
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw02.mediatek.com
        (envelope-from <ryder.lee@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 1679655166; Fri, 31 May 2019 22:10:01 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs06n2.mediatek.inc (172.21.101.130) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Fri, 31 May 2019 22:09:59 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Fri, 31 May 2019 22:09:59 +0800
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
Subject: [PATCH v2 2/2] mt76: mt7615: fix slow performance when enable encryption
Date:   Fri, 31 May 2019 22:09:57 +0800
Message-ID: <ed4cb230af57cb8f3bbe3d1851ce7f8ab7eeb9d5.1559301203.git.ryder.lee@mediatek.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <e459fbc79154da9e0e6e098d2c49a9b17e842f47.1559301203.git.ryder.lee@mediatek.com>
References: <e459fbc79154da9e0e6e098d2c49a9b17e842f47.1559301203.git.ryder.lee@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-TM-SNTS-SMTP: AD9480DA8A1DFA8B30958A0EB9B5D3731966CFCEAE90CCE5F638CB3AA38699AB2000:8
X-MTK:  N
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Fix wrong WCID assignment and add RKV (RX Key of this entry is valid)
flag to check if peer uses the same configuration with previous
handshaking.

If the configuration is mismatch, WTBL indicates a “cipher mismatch”
to stop SEC decryption to prevent the packet from damage.

Suggested-by: YF Luo <yf.luo@mediatek.com>
Suggested-by: Yiwei Chung <yiwei.chung@mediatek.com>
Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
---
Changes since v2 - none
---
 drivers/net/wireless/mediatek/mt76/mt7615/init.c | 15 +++++++++------
 drivers/net/wireless/mediatek/mt76/mt7615/main.c |  2 +-
 drivers/net/wireless/mediatek/mt76/mt7615/mcu.c  |  1 +
 3 files changed, 11 insertions(+), 7 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/init.c b/drivers/net/wireless/mediatek/mt76/mt7615/init.c
index f860af6a42da..b96c753b7532 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/init.c
@@ -62,16 +62,11 @@ static void mt7615_mac_init(struct mt7615_dev *dev)
 		 MT_AGG_ARCR_RATE_DOWN_RATIO_EN |
 		 FIELD_PREP(MT_AGG_ARCR_RATE_DOWN_RATIO, 1) |
 		 FIELD_PREP(MT_AGG_ARCR_RATE_UP_EXTRA_TH, 4)));
-
-	dev->mt76.global_wcid.idx = MT7615_WTBL_RESERVED;
-	dev->mt76.global_wcid.hw_key_idx = -1;
-	rcu_assign_pointer(dev->mt76.wcid[MT7615_WTBL_RESERVED],
-			   &dev->mt76.global_wcid);
 }
 
 static int mt7615_init_hardware(struct mt7615_dev *dev)
 {
-	int ret;
+	int ret, idx;
 
 	mt76_wr(dev, MT_INT_SOURCE_CSR, ~0);
 
@@ -98,6 +93,14 @@ static int mt7615_init_hardware(struct mt7615_dev *dev)
 	mt7615_mcu_ctrl_pm_state(dev, 0);
 	mt7615_mcu_del_wtbl_all(dev);
 
+	/* Beacon and mgmt frames should occupy wcid 0 */
+	idx = mt76_wcid_alloc(dev->mt76.wcid_mask, MT7615_WTBL_STA - 1);
+	if (idx)
+		return -ENOSPC;
+
+	dev->mt76.global_wcid.idx = idx;
+	dev->mt76.global_wcid.hw_key_idx = -1;
+	rcu_assign_pointer(dev->mt76.wcid[idx], &dev->mt76.global_wcid);
 	return 0;
 }
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/main.c b/drivers/net/wireless/mediatek/mt76/mt7615/main.c
index 585e67fa2728..2cdd339453c8 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/main.c
@@ -95,7 +95,7 @@ static int mt7615_add_interface(struct ieee80211_hw *hw,
 
 	dev->vif_mask |= BIT(mvif->idx);
 	dev->omac_mask |= BIT(mvif->omac_idx);
-	idx = MT7615_WTBL_RESERVED - 1 - mvif->idx;
+	idx = MT7615_WTBL_RESERVED - mvif->idx;
 	mvif->sta.wcid.idx = idx;
 	mvif->sta.wcid.hw_key_idx = -1;
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
index 8b8db526cb16..5f38741e7366 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
@@ -882,6 +882,7 @@ int mt7615_mcu_set_wtbl_key(struct mt7615_dev *dev, int wcid,
 		if (cipher == MT_CIPHER_NONE && key)
 			return -EOPNOTSUPP;
 
+		req.key.rkv = 1;
 		req.key.cipher_id = cipher;
 		req.key.key_id = key->keyidx;
 		req.key.key_len = key->keylen;
-- 
2.18.0

