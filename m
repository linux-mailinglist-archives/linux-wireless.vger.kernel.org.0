Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2399835B9E2
	for <lists+linux-wireless@lfdr.de>; Mon, 12 Apr 2021 07:40:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230082AbhDLFk5 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 12 Apr 2021 01:40:57 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:55386 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S229448AbhDLFk4 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 12 Apr 2021 01:40:56 -0400
X-UUID: e7fab72f9f4e40188f4890a67e492898-20210412
X-UUID: e7fab72f9f4e40188f4890a67e492898-20210412
Received: from mtkmrs01.mediatek.inc [(172.21.131.159)] by mailgw02.mediatek.com
        (envelope-from <shayne.chen@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 90478055; Mon, 12 Apr 2021 13:40:35 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs06n1.mediatek.inc (172.21.101.129) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 12 Apr 2021 13:40:34 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 12 Apr 2021 13:40:33 +0800
From:   Shayne Chen <shayne.chen@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>
CC:     linux-wireless <linux-wireless@vger.kernel.org>,
        Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Evelyn Tsai <evelyn.tsai@mediatek.com>,
        linux-mediatek <linux-mediatek@lists.infradead.org>,
        Shayne Chen <shayne.chen@mediatek.com>
Subject: [PATCH 2/3] mt76: mt7915: rework mt7915_tm_set_tx_len()
Date:   Mon, 12 Apr 2021 13:39:53 +0800
Message-ID: <20210412053954.23544-2-shayne.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20210412053954.23544-1-shayne.chen@mediatek.com>
References: <20210412053954.23544-1-shayne.chen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Rework mt7915_tm_set_tx_len() with mt76_testmode_alloc_skb() to support
larger packet based on a longer tx_time.

Signed-off-by: Shayne Chen <shayne.chen@mediatek.com>
---
 .../wireless/mediatek/mt76/mt7915/testmode.c  | 22 +++++--------------
 1 file changed, 5 insertions(+), 17 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/testmode.c b/drivers/net/wireless/mediatek/mt76/mt7915/testmode.c
index bd798df..f9d81e3 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/testmode.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/testmode.c
@@ -257,13 +257,13 @@ mt7915_tm_set_tx_len(struct mt7915_phy *phy, u32 tx_time)
 {
 	struct mt76_phy *mphy = phy->mt76;
 	struct mt76_testmode_data *td = &mphy->test;
-	struct sk_buff *old = td->tx_skb, *new;
 	struct ieee80211_supported_band *sband;
 	struct rate_info rate = {};
 	u16 flags = 0, tx_len;
 	u32 bitrate;
+	int ret;
 
-	if (!tx_time || !old)
+	if (!tx_time)
 		return 0;
 
 	rate.mcs = td->tx_rate_idx;
@@ -323,21 +323,9 @@ mt7915_tm_set_tx_len(struct mt7915_phy *phy, u32 tx_time)
 	bitrate = cfg80211_calculate_bitrate(&rate);
 	tx_len = bitrate * tx_time / 10 / 8;
 
-	if (tx_len < sizeof(struct ieee80211_hdr))
-		tx_len = sizeof(struct ieee80211_hdr);
-	else if (tx_len > IEEE80211_MAX_FRAME_LEN)
-		tx_len = IEEE80211_MAX_FRAME_LEN;
-
-	new = alloc_skb(tx_len, GFP_KERNEL);
-	if (!new)
-		return -ENOMEM;
-
-	skb_copy_header(new, old);
-	__skb_put_zero(new, tx_len);
-	memcpy(new->data, old->data, sizeof(struct ieee80211_hdr));
-
-	dev_kfree_skb(old);
-	td->tx_skb = new;
+	ret = mt76_testmode_alloc_skb(phy->mt76, tx_len);
+	if (ret)
+		return ret;
 
 	return 0;
 }
-- 
2.18.0

