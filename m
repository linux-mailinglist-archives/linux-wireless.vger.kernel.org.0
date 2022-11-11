Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31DD6625479
	for <lists+linux-wireless@lfdr.de>; Fri, 11 Nov 2022 08:36:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233033AbiKKHg2 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 11 Nov 2022 02:36:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230198AbiKKHg0 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 11 Nov 2022 02:36:26 -0500
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B152BC14
        for <linux-wireless@vger.kernel.org>; Thu, 10 Nov 2022 23:36:21 -0800 (PST)
X-UUID: 411b14f236ca4e89a47293c71972efb6-20221111
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=TL1DUTNfvzaTDC5V59A/ZBBk1n7wWZR3gc8cGOLQ5D4=;
        b=euRNAwOzB8yEiRwTM3nZe5E2XO7WcRKyHzROM78uNIVY6350LfBM4lGJkAmyAf5mAfb7VynW/HN+ck/t1+J3GsCtlTX8SHQg44wo77xXeWYixeiMthS6qsSuvlskJZn/4AyC033v6RKd8edur/HyGbK1Dd43d0UKEcsknUoR4dc=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.13,REQID:cfd32e8c-432a-4ea1-80e7-59d78b194fa0,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:d12e911,CLOUDID:37fdfe85-088c-4756-8f76-577be701e693,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: 411b14f236ca4e89a47293c71972efb6-20221111
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw01.mediatek.com
        (envelope-from <evelyn.tsai@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1711142073; Fri, 11 Nov 2022 15:36:17 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 mtkmbs13n2.mediatek.inc (172.21.101.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Fri, 11 Nov 2022 15:36:16 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Fri, 11 Nov 2022 15:36:16 +0800
From:   Evelyn Tsai <evelyn.tsai@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>
CC:     Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        Ryder Lee <ryder.Lee@mediatek.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        Evelyn Tsai <evelyn.tsai@mediatek.com>,
        <linux-wireless@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        Peter Chiu <chui-hao.chiu@mediatek.com>
Subject: [PATCH] wifi: mt76: connac: update nss calculation in txs
Date:   Fri, 11 Nov 2022 15:36:15 +0800
Message-ID: <20221111073615.25666-1-evelyn.tsai@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        T_SPF_TEMPERROR,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Co-developed-by: Peter Chiu <chui-hao.chiu@mediatek.com>
Signed-off-by: Peter Chiu <chui-hao.chiu@mediatek.com>
Signed-off-by: Evelyn Tsai <evelyn.tsai@mediatek.com>
---
 drivers/net/wireless/mediatek/mt76/mt76_connac_mac.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac_mac.c b/drivers/net/wireless/mediatek/mt76/mt76_connac_mac.c
index 8b7ec64abc95..fd60123fb284 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac_mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac_mac.c
@@ -567,7 +567,7 @@ bool mt76_connac2_mac_fill_txs(struct mt76_dev *dev, struct mt76_wcid *wcid,
 	struct mt76_phy *mphy;
 	struct rate_info rate = {};
 	bool cck = false;
-	u32 txrate, txs, mode;
+	u32 txrate, txs, mode, stbc;
 
 	txs = le32_to_cpu(txs_data[0]);
 
@@ -587,6 +587,10 @@ bool mt76_connac2_mac_fill_txs(struct mt76_dev *dev, struct mt76_wcid *wcid,
 
 	rate.mcs = FIELD_GET(MT_TX_RATE_IDX, txrate);
 	rate.nss = FIELD_GET(MT_TX_RATE_NSS, txrate) + 1;
+	stbc = FIELD_GET(MT_TX_RATE_STBC, txrate);
+
+	if (stbc && rate.nss > 1)
+		rate.nss >>= 1;
 
 	if (rate.nss - 1 < ARRAY_SIZE(stats->tx_nss))
 		stats->tx_nss[rate.nss - 1]++;
-- 
2.18.0

