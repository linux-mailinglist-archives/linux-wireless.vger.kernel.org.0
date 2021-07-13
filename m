Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 089AD3C77B6
	for <lists+linux-wireless@lfdr.de>; Tue, 13 Jul 2021 22:16:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234997AbhGMUTA (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 13 Jul 2021 16:19:00 -0400
Received: from mailgw01.mediatek.com ([60.244.123.138]:51744 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S234933AbhGMUS7 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 13 Jul 2021 16:18:59 -0400
X-UUID: 172f358ae7264a489447f7fd3cb2dfbb-20210714
X-UUID: 172f358ae7264a489447f7fd3cb2dfbb-20210714
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw01.mediatek.com
        (envelope-from <sean.wang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 512587506; Wed, 14 Jul 2021 04:16:06 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs01n1.mediatek.inc (172.21.101.68) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 14 Jul 2021 04:16:04 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 14 Jul 2021 04:16:04 +0800
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
Subject: [PATCH v3 2/4] mt76: add mt76_default_basic_rate more devices can rely on
Date:   Wed, 14 Jul 2021 04:15:59 +0800
Message-ID: <8a86a3483ac686d40861489884c7737d38648905.1626207204.git.objelf@gmail.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <92a8ecfdf198b34f98d5c1489a83adf151657760.1626207204.git.objelf@gmail.com>
References: <92a8ecfdf198b34f98d5c1489a83adf151657760.1626207204.git.objelf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Sean Wang <sean.wang@mediatek.com>

add mt76_default_basic_rate to mt76 core more devices can rely on
to send frames which require the rate in the basic rates.

Suggested-by: Ryder Lee <ryder.lee@mediatek.com>
Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
v3:  created in v3 that is splitted out from the patch
     ("mt76: mt7921: fix mgmt frame using unexpected bitrate") v2
     for more mt76 devices like mt7915 can reuse.
---
 drivers/net/wireless/mediatek/mt76/mac80211.c | 14 ++++++++++++++
 drivers/net/wireless/mediatek/mt76/mt76.h     |  1 +
 2 files changed, 15 insertions(+)

diff --git a/drivers/net/wireless/mediatek/mt76/mac80211.c b/drivers/net/wireless/mediatek/mt76/mac80211.c
index 20b2423efc19..56e80e0fb2c2 100644
--- a/drivers/net/wireless/mediatek/mt76/mac80211.c
+++ b/drivers/net/wireless/mediatek/mt76/mac80211.c
@@ -1336,3 +1336,17 @@ mt76_init_queue(struct mt76_dev *dev, int qid, int idx, int n_desc,
 	return hwq;
 }
 EXPORT_SYMBOL_GPL(mt76_init_queue);
+
+u16 mt76_default_basic_rate(struct mt76_phy *phy, struct ieee80211_vif *vif)
+{
+	int i = ffs(vif->bss_conf.basic_rates) - 1, offset = 0;
+	struct ieee80211_rate *rate;
+
+	if (phy->chandef.chan->band == NL80211_BAND_5GHZ)
+		offset = 4;
+
+	rate = &mt76_rates[offset + i];
+
+	return rate->hw_value;
+}
+EXPORT_SYMBOL_GPL(mt76_default_basic_rate);
diff --git a/drivers/net/wireless/mediatek/mt76/mt76.h b/drivers/net/wireless/mediatek/mt76/mt76.h
index e51ab917296d..d34d77967780 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76.h
@@ -881,6 +881,7 @@ int mt76_get_of_eeprom(struct mt76_dev *dev, void *data, int offset, int len);
 struct mt76_queue *
 mt76_init_queue(struct mt76_dev *dev, int qid, int idx, int n_desc,
 		int ring_base);
+u16 mt76_default_basic_rate(struct mt76_phy *phy, struct ieee80211_vif *vif);
 static inline int mt76_init_tx_queue(struct mt76_phy *phy, int qid, int idx,
 				     int n_desc, int ring_base)
 {
-- 
2.25.1

