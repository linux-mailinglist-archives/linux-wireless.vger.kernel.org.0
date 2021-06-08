Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34F6E39EF1B
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Jun 2021 08:56:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230345AbhFHG6R (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 8 Jun 2021 02:58:17 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:60347 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S230197AbhFHG6R (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 8 Jun 2021 02:58:17 -0400
X-UUID: 3415d1186e6047789abffe5f28d307e7-20210608
X-UUID: 3415d1186e6047789abffe5f28d307e7-20210608
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw01.mediatek.com
        (envelope-from <shayne.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1005538866; Tue, 08 Jun 2021 14:56:20 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs06n2.mediatek.inc (172.21.101.130) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 8 Jun 2021 14:56:19 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 8 Jun 2021 14:56:19 +0800
From:   Shayne Chen <shayne.chen@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>
CC:     linux-wireless <linux-wireless@vger.kernel.org>,
        Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Evelyn Tsai <evelyn.tsai@mediatek.com>,
        linux-mediatek <linux-mediatek@lists.infradead.org>,
        Shayne Chen <shayne.chen@mediatek.com>
Subject: [PATCH 2/2] mt76: mt7915: fix rx fcs error count in testmode
Date:   Tue, 8 Jun 2021 14:55:58 +0800
Message-ID: <20210608065558.8117-2-shayne.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20210608065558.8117-1-shayne.chen@mediatek.com>
References: <20210608065558.8117-1-shayne.chen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

FCS error packets are filtered by default and won't be reported to
driver, so that RX fcs error and PER in testmode always show zero.
Fix this issue by reading fcs error count from hw counter.

We did't fix this issue by disabling fcs error rx filter since it may
let HW suffer some SER errors.

Fixes: 5d8a83f09941 ("mt76: mt7915: implement testmode rx support")
Signed-off-by: Shayne Chen <shayne.chen@mediatek.com>
---
 .../wireless/mediatek/mt76/mt7915/testmode.c  | 21 +++++++++++++++++--
 1 file changed, 19 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/testmode.c b/drivers/net/wireless/mediatek/mt76/mt7915/testmode.c
index f9d81e3..b220b33 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/testmode.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/testmode.c
@@ -464,10 +464,17 @@ mt7915_tm_set_tx_frames(struct mt7915_phy *phy, bool en)
 static void
 mt7915_tm_set_rx_frames(struct mt7915_phy *phy, bool en)
 {
-	if (en)
+	mt7915_tm_set_trx(phy, TM_MAC_RX_RXV, false);
+
+	if (en) {
+		struct mt7915_dev *dev = phy->dev;
+
 		mt7915_tm_update_channel(phy);
 
-	mt7915_tm_set_trx(phy, TM_MAC_RX_RXV, en);
+		/* read-clear */
+		mt76_rr(dev, MT_MIB_SDR3(phy != &dev->phy));
+		mt7915_tm_set_trx(phy, TM_MAC_RX_RXV, en);
+	}
 }
 
 static int
@@ -690,7 +697,11 @@ static int
 mt7915_tm_dump_stats(struct mt76_phy *mphy, struct sk_buff *msg)
 {
 	struct mt7915_phy *phy = mphy->priv;
+	struct mt7915_dev *dev = phy->dev;
+	bool ext_phy = phy != &dev->phy;
+	enum mt76_rxq_id q;
 	void *rx, *rssi;
+	u16 fcs_err;
 	int i;
 
 	rx = nla_nest_start(msg, MT76_TM_STATS_ATTR_LAST_RX);
@@ -735,6 +746,12 @@ mt7915_tm_dump_stats(struct mt76_phy *mphy, struct sk_buff *msg)
 
 	nla_nest_end(msg, rx);
 
+	fcs_err = mt76_get_field(dev, MT_MIB_SDR3(ext_phy),
+				 MT_MIB_SDR3_FCS_ERR_MASK);
+	q = ext_phy ? MT_RXQ_EXT : MT_RXQ_MAIN;
+	mphy->test.rx_stats.packets[q] += fcs_err;
+	mphy->test.rx_stats.fcs_error[q] += fcs_err;
+
 	return 0;
 }
 
-- 
2.18.0

