Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 177203E32EC
	for <lists+linux-wireless@lfdr.de>; Sat,  7 Aug 2021 05:14:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230308AbhHGDOv (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 6 Aug 2021 23:14:51 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:34150 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S230183AbhHGDOs (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 6 Aug 2021 23:14:48 -0400
X-UUID: 8291359a2da742aab063655dabb49011-20210807
X-UUID: 8291359a2da742aab063655dabb49011-20210807
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw02.mediatek.com
        (envelope-from <ryder.lee@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1331583519; Sat, 07 Aug 2021 11:14:29 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs05n2.mediatek.inc (172.21.101.140) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Sat, 7 Aug 2021 11:14:28 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Sat, 7 Aug 2021 11:14:28 +0800
From:   Ryder Lee <ryder.lee@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>
CC:     Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        Evelyn Tsai <evelyn.tsai@mediatek.com>,
        <linux-wireless@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        Ryder Lee <ryder.lee@mediatek.com>
Subject: [PATCH 3/4] mt76: mt7915: add HE-LTF into fixed rate command
Date:   Sat, 7 Aug 2021 11:14:23 +0800
Message-ID: <c3fd9c4ea692f28e2eb78073fd8da7753199ba60.1628301616.git.ryder.lee@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <77372f644903053e09d671325c0cd44cf75e14ac.1628301615.git.ryder.lee@mediatek.com>
References: <77372f644903053e09d671325c0cd44cf75e14ac.1628301615.git.ryder.lee@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Add HE-LTF control.

Signed-off-by: Shayne Chen <shayne.chen@mediatek.com>
Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
---
 drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c |  4 +++-
 drivers/net/wireless/mediatek/mt76/mt7915/mcu.c     | 13 +++++++------
 drivers/net/wireless/mediatek/mt76/mt7915/mcu.h     |  1 +
 3 files changed, 11 insertions(+), 7 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c b/drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c
index 1a48b09d0cb7..d9d18f662039 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c
@@ -365,12 +365,14 @@ int mt7915_init_debugfs(struct mt7915_dev *dev)
 #ifdef CONFIG_MAC80211_DEBUGFS
 /** per-station debugfs **/
 
-/* usage: <tx mode> <ldpc> <stbc> <bw> <gi> <nss> <mcs> */
 static int mt7915_sta_fixed_rate_set(void *data, u64 rate)
 {
 	struct ieee80211_sta *sta = data;
 	struct mt7915_sta *msta = (struct mt7915_sta *)sta->drv_priv;
 
+	/* usage: <he ltf> <tx mode> <ldpc> <stbc> <bw> <gi> <nss> <mcs>
+	 * <tx mode>: see enum mt76_phy_type
+	 */
 	return mt7915_mcu_set_fixed_rate(msta->vif->phy->dev, sta, rate);
 }
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
index 8ece8bf907cc..59731c1831ea 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
@@ -2312,10 +2312,9 @@ int mt7915_mcu_set_fixed_rate(struct mt7915_dev *dev,
 	if (!rate) {
 		ra->field = cpu_to_le32(RATE_PARAM_AUTO);
 		goto out;
-	} else {
-		ra->field = cpu_to_le32(RATE_PARAM_FIXED);
 	}
 
+	ra->field = cpu_to_le32(RATE_PARAM_FIXED);
 	ra->phy.type = FIELD_GET(RATE_CFG_PHY_TYPE, rate);
 	ra->phy.bw = FIELD_GET(RATE_CFG_BW, rate);
 	ra->phy.nss = FIELD_GET(RATE_CFG_NSS, rate);
@@ -2328,10 +2327,12 @@ int mt7915_mcu_set_fixed_rate(struct mt7915_dev *dev,
 		ra->phy.ldpc = FIELD_GET(RATE_CFG_LDPC, rate) * 7;
 
 	/* HT/VHT - SGI: 1, LGI: 0; HE - SGI: 0, MGI: 1, LGI: 2 */
-	if (ra->phy.type > MT_PHY_TYPE_VHT)
-		ra->phy.sgi = ra->phy.mcs * 85;
-	else
-		ra->phy.sgi = ra->phy.mcs * 15;
+	if (ra->phy.type > MT_PHY_TYPE_VHT) {
+		ra->phy.he_ltf = FIELD_GET(RATE_CFG_HE_LTF, rate) * 85;
+		ra->phy.sgi = FIELD_GET(RATE_CFG_GI, rate) * 85;
+	} else {
+		ra->phy.sgi = FIELD_GET(RATE_CFG_GI, rate) * 15;
+	}
 
 out:
 	return mt76_mcu_skb_send_msg(&dev->mt76, skb,
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.h b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.h
index d109548994cf..2b47cdf0fd17 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.h
@@ -945,6 +945,7 @@ struct sta_rec_ra_fixed {
 #define RATE_CFG_STBC			GENMASK(19, 16)
 #define RATE_CFG_LDPC			GENMASK(23, 20)
 #define RATE_CFG_PHY_TYPE		GENMASK(27, 24)
+#define RATE_CFG_HE_LTF			GENMASK(31, 28)
 
 struct sta_rec_bf {
 	__le16 tag;
-- 
2.29.2

