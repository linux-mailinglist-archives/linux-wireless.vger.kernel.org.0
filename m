Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2F094C8327
	for <lists+linux-wireless@lfdr.de>; Tue,  1 Mar 2022 06:29:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231509AbiCAFaT (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 1 Mar 2022 00:30:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230044AbiCAFaT (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 1 Mar 2022 00:30:19 -0500
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24EF9344C0
        for <linux-wireless@vger.kernel.org>; Mon, 28 Feb 2022 21:29:33 -0800 (PST)
X-UUID: c0df0add839243bb83746a507f8aaccd-20220301
X-UUID: c0df0add839243bb83746a507f8aaccd-20220301
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw02.mediatek.com
        (envelope-from <evelyn.tsai@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1351570571; Tue, 01 Mar 2022 13:29:27 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3;
 Tue, 1 Mar 2022 13:29:26 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 1 Mar 2022 13:29:26 +0800
From:   Evelyn Tsai <evelyn.tsai@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>
CC:     Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        Ryder Lee <ryder.Lee@mediatek.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        <linux-wireless@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        Evelyn Tsai <evelyn.tsai@mediatek.com>,
        Rubio Lu <Rubio-DW.Lu@mediatek.com>
Subject: [PATCH] mt76: mt7915: fix DFS no radar detection event
Date:   Tue, 1 Mar 2022 13:29:10 +0800
Message-ID: <b55fec95a7708491a78027cc9a30ba7faa0dd18b.1646106090.git.evelyn.tsai@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Driver needs to carry region definition when radar detection starts.
Need to remap nl80211 DFS regions to chip region definition.

Signed-off-by: Evelyn Tsai <evelyn.tsai@mediatek.com>
Signed-off-by: Rubio Lu <Rubio-DW.Lu@mediatek.com>
---
 drivers/net/wireless/mediatek/mt76/mt7915/mac.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
index 1da551f0b389..a99079313ac2 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
@@ -2364,10 +2364,23 @@ static void mt7915_dfs_stop_radar_detector(struct mt7915_phy *phy)
 
 static int mt7915_dfs_start_rdd(struct mt7915_dev *dev, int chain)
 {
-	int err;
+	int err, region;
+
+	switch (dev->mt76.region) {
+	case NL80211_DFS_ETSI:
+		region = 0;
+		break;
+	case NL80211_DFS_JP:
+		region = 2;
+		break;
+	case NL80211_DFS_FCC:
+	default:
+		region = 1;
+		break;
+	}
 
 	err = mt76_connac_mcu_rdd_cmd(&dev->mt76, RDD_START, chain,
-				      MT_RX_SEL0, 0);
+				      MT_RX_SEL0, region);
 	if (err < 0)
 		return err;
 
-- 
2.18.0

