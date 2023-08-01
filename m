Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C00AC76B79B
	for <lists+linux-wireless@lfdr.de>; Tue,  1 Aug 2023 16:34:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234757AbjHAOeT (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 1 Aug 2023 10:34:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234769AbjHAOeL (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 1 Aug 2023 10:34:11 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7A4F1FE5
        for <linux-wireless@vger.kernel.org>; Tue,  1 Aug 2023 07:34:02 -0700 (PDT)
X-UUID: 6fb072fc307811eeb20a276fd37b9834-20230801
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=5Gm3jRkI5Tyulat+xb+vBzoM4ttkjEMWLiEXnAQ5r8Y=;
        b=n5Mqhi5tBRS4dHfSV1JrAs2coNYTmwRopZUNje8ns8y9T+CiejyYVGpNEOqdS3FPKGixzEMSx2cmgCXftxUN78bHfC1WeayTKvAndEEhBunNwqpoKobsUk/4yQNGBgg0jP4bhZ2KXXHYC+bdHWrrIFAb0aeKBom0RzpEt5JEFHg=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.30,REQID:4eb3e1f0-14f1-46f3-9c94-f5deb1e31f65,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:1fcc6f8,CLOUDID:2dfbc5a0-0933-4333-8d4f-6c3c53ebd55b,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:
        NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: 6fb072fc307811eeb20a276fd37b9834-20230801
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by mailgw02.mediatek.com
        (envelope-from <deren.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 962525216; Tue, 01 Aug 2023 22:33:52 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Tue, 1 Aug 2023 22:33:51 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Tue, 1 Aug 2023 22:33:51 +0800
From:   Deren Wu <deren.wu@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>, Lorenzo Bianconi <lorenzo@kernel.org>
CC:     Sean Wang <sean.wang@mediatek.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        linux-mediatek <linux-mediatek@lists.infradead.org>,
        Deren Wu <deren.wu@mediatek.com>
Subject: [PATCH 5/8] wifi: mt76: connac: add eht support for tx power
Date:   Tue, 1 Aug 2023 22:30:29 +0800
Message-ID: <850be4060d309c6a632c98d22197a4306482ee96.1690863143.git.deren.wu@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <cover.1690863143.git.deren.wu@mediatek.com>
References: <cover.1690863143.git.deren.wu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,RDNS_NONE,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Add eht field in struct mt76_power_limits for 802.11be power config.
The function stack size would be too big by eht adding in structure,
we also refactor mt76_connac_mcu_rate_txpower_band() to take dynamic
allocated memory instead.

This is a preliminary patch to support mt7925 driver.

Co-developed-by: Lorenzo Bianconi <lorenzo@kernel.org>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
Signed-off-by: Deren Wu <deren.wu@mediatek.com>
---
 drivers/net/wireless/mediatek/mt76/mt76.h     |  1 +
 .../wireless/mediatek/mt76/mt76_connac_mcu.c  | 26 ++++++++++++-------
 2 files changed, 18 insertions(+), 9 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76.h b/drivers/net/wireless/mediatek/mt76/mt76.h
index 878087257ea7..281f7f8d5266 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76.h
@@ -966,6 +966,7 @@ struct mt76_power_limits {
 	s8 ofdm[8];
 	s8 mcs[4][10];
 	s8 ru[7][12];
+	s8 eht[16][16];
 };
 
 struct mt76_ethtool_worker_info {
diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
index c0f129dd8aef..32512066e3aa 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
@@ -2177,11 +2177,15 @@ mt76_connac_mcu_rate_txpower_band(struct mt76_phy *phy,
 		209, 211, 213, 215, 217, 219, 221,
 		225, 227, 229, 233
 	};
-	int i, n_chan, batch_size, idx = 0, tx_power, last_ch;
+	int i, n_chan, batch_size, idx = 0, tx_power, last_ch, err = 0;
 	struct mt76_connac_sku_tlv sku_tlbv;
-	struct mt76_power_limits limits;
+	struct mt76_power_limits *limits;
 	const u8 *ch_list;
 
+	limits = devm_kmalloc(dev->dev, sizeof(*limits), GFP_KERNEL);
+	if (!limits)
+		return -ENOMEM;
+
 	sku_len = is_mt7921(dev) ? sizeof(sku_tlbv) : sizeof(sku_tlbv) - 92;
 	tx_power = 2 * phy->hw->conf.power_level;
 	if (!tx_power)
@@ -2208,14 +2212,16 @@ mt76_connac_mcu_rate_txpower_band(struct mt76_phy *phy,
 
 	for (i = 0; i < batch_size; i++) {
 		struct mt76_connac_tx_power_limit_tlv tx_power_tlv = {};
-		int j, err, msg_len, num_ch;
+		int j, msg_len, num_ch;
 		struct sk_buff *skb;
 
 		num_ch = i == batch_size - 1 ? n_chan % batch_len : batch_len;
 		msg_len = sizeof(tx_power_tlv) + num_ch * sizeof(sku_tlbv);
 		skb = mt76_mcu_msg_alloc(dev, NULL, msg_len);
-		if (!skb)
-			return -ENOMEM;
+		if (!skb) {
+			err = -ENOMEM;
+			goto out;
+		}
 
 		skb_reserve(skb, sizeof(tx_power_tlv));
 
@@ -2246,14 +2252,14 @@ mt76_connac_mcu_rate_txpower_band(struct mt76_phy *phy,
 							     tx_power);
 			sar_power = mt76_get_sar_power(phy, &chan, reg_power);
 
-			mt76_get_rate_power_limits(phy, &chan, &limits,
+			mt76_get_rate_power_limits(phy, &chan, limits,
 						   sar_power);
 
 			tx_power_tlv.last_msg = ch_list[idx] == last_ch;
 			sku_tlbv.channel = ch_list[idx];
 
 			mt76_connac_mcu_build_sku(dev, sku_tlbv.pwr_limit,
-						  &limits, band);
+						  limits, band);
 			skb_put_data(skb, &sku_tlbv, sku_len);
 		}
 		__skb_push(skb, sizeof(tx_power_tlv));
@@ -2263,10 +2269,12 @@ mt76_connac_mcu_rate_txpower_band(struct mt76_phy *phy,
 					    MCU_CE_CMD(SET_RATE_TX_POWER),
 					    false);
 		if (err < 0)
-			return err;
+			goto out;
 	}
 
-	return 0;
+out:
+	devm_kfree(dev->dev, limits);
+	return err;
 }
 
 int mt76_connac_mcu_set_rate_txpower(struct mt76_phy *phy)
-- 
2.18.0

