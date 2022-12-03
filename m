Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27A9E6414C4
	for <lists+linux-wireless@lfdr.de>; Sat,  3 Dec 2022 08:38:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229665AbiLCHiM (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 3 Dec 2022 02:38:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbiLCHiL (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 3 Dec 2022 02:38:11 -0500
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7156F15815
        for <linux-wireless@vger.kernel.org>; Fri,  2 Dec 2022 23:38:03 -0800 (PST)
X-UUID: 5e9ef8983a284c308246157671120e6d-20221203
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=G7PaMZS6/hyIDt9quG3UjPne+lkluujZYa1twV0Y0Dg=;
        b=Qks8/xxEbvJhIVi8jsnTiO69tob6igurHc5hX31nJymR5hcrd0Ho289NZX/nf+R1gzZ+DtLTTLB76XSbWgbl8z9HlJTuOgxLKE8UhttKVLETo8WxkgRYD0Tb7E0lUCuOE1BAdfZCXlRuxWTZJfzK/3Lc/diAg0IIlewy6qYAgss=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.14,REQID:cea4f620-fe09-4d6d-92c4-35e80277b31e,IP:0,U
        RL:0,TC:0,Content:-25,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
        N:release,TS:-25
X-CID-META: VersionHash:dcaaed0,CLOUDID:8641091f-5e1d-4ab5-ab8e-3e04efc02b30,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: 5e9ef8983a284c308246157671120e6d-20221203
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw01.mediatek.com
        (envelope-from <ryder.lee@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1675924302; Sat, 03 Dec 2022 15:37:57 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Sat, 3 Dec 2022 15:37:56 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Sat, 3 Dec 2022 15:37:56 +0800
From:   Ryder Lee <ryder.lee@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>, <linux-wireless@vger.kernel.org>
CC:     Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        Evelyn Tsai <evelyn.tsai@mediatek.com>,
        <linux-mediatek@lists.infradead.org>,
        Ryder Lee <ryder.lee@mediatek.com>
Subject: [PATCH] wifi: mt76: mt7915: split mcu chan_mib array up
Date:   Sat, 3 Dec 2022 15:37:54 +0800
Message-ID: <51130dcbc200962672540cb726dd9841c5ad7fe9.1670049959.git.ryder.lee@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,MAY_BE_FORGED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        T_SPF_TEMPERROR,UNPARSEABLE_RELAY autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

The current flow confuses coverity check that leads to false reporting,
so split the offs[] into two pieces according to chipset revision to
silence coverity tool.

Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
---
 .../net/wireless/mediatek/mt76/mt7915/mcu.c   | 50 ++++++++++---------
 1 file changed, 27 insertions(+), 23 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
index b2652de082ba..ca315af3905b 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
@@ -2974,38 +2974,42 @@ int mt7915_mcu_apply_tx_dpd(struct mt7915_phy *phy)
 
 int mt7915_mcu_get_chan_mib_info(struct mt7915_phy *phy, bool chan_switch)
 {
-	/* strict order */
-	static const u32 offs[] = {
-		MIB_NON_WIFI_TIME,
-		MIB_TX_TIME,
-		MIB_RX_TIME,
-		MIB_OBSS_AIRTIME,
-		MIB_TXOP_INIT_COUNT,
-		/* v2 */
-		MIB_NON_WIFI_TIME_V2,
-		MIB_TX_TIME_V2,
-		MIB_RX_TIME_V2,
-		MIB_OBSS_AIRTIME_V2
-	};
 	struct mt76_channel_state *state = phy->mt76->chan_state;
 	struct mt76_channel_state *state_ts = &phy->state_ts;
 	struct mt7915_dev *dev = phy->dev;
 	struct mt7915_mcu_mib *res, req[5];
 	struct sk_buff *skb;
-	int i, ret, start = 0, ofs = 20;
+	static const u32 *offs;
+	int i, ret, len, offs_cc;
 	u64 cc_tx;
 
-	if (!is_mt7915(&dev->mt76)) {
-		start = 5;
-		ofs = 0;
+	/* strict order */
+	if (is_mt7915(&dev->mt76)) {
+		static const u32 chip_offs[] = {
+			MIB_NON_WIFI_TIME,
+			MIB_TX_TIME,
+			MIB_RX_TIME,
+			MIB_OBSS_AIRTIME,
+			MIB_TXOP_INIT_COUNT,
+		};
+		len = ARRAY_SIZE(chip_offs);
+		offs = chip_offs;
+		offs_cc = 20;
+	} else {
+		static const u32 chip_offs[] = {
+			MIB_NON_WIFI_TIME_V2,
+			MIB_TX_TIME_V2,
+			MIB_RX_TIME_V2,
+			MIB_OBSS_AIRTIME_V2
+		};
+		len = ARRAY_SIZE(chip_offs);
+		offs = chip_offs;
+		offs_cc = 0;
 	}
 
-	for (i = 0; i < 5; i++) {
+	for (i = 0; i < len; i++) {
 		req[i].band = cpu_to_le32(phy->mt76->band_idx);
-		req[i].offs = cpu_to_le32(offs[i + start]);
-
-		if (!is_mt7915(&dev->mt76) && i == 3)
-			break;
+		req[i].offs = cpu_to_le32(offs[i]);
 	}
 
 	ret = mt76_mcu_send_and_get_msg(&dev->mt76, MCU_EXT_CMD(GET_MIB_INFO),
@@ -3013,7 +3017,7 @@ int mt7915_mcu_get_chan_mib_info(struct mt7915_phy *phy, bool chan_switch)
 	if (ret)
 		return ret;
 
-	res = (struct mt7915_mcu_mib *)(skb->data + ofs);
+	res = (struct mt7915_mcu_mib *)(skb->data + offs_cc);
 
 #define __res_u64(s) le64_to_cpu(res[s].data)
 	/* subtract Tx backoff time from Tx duration */
-- 
2.18.0

