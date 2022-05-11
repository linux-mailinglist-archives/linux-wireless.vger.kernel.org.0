Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15458524084
	for <lists+linux-wireless@lfdr.de>; Thu, 12 May 2022 01:06:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348993AbiEKXGr (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 11 May 2022 19:06:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346495AbiEKXGq (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 11 May 2022 19:06:46 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 631AA5839C
        for <linux-wireless@vger.kernel.org>; Wed, 11 May 2022 16:06:45 -0700 (PDT)
X-UUID: 1115d125ad0a4ee3b6168e1df6d7a9ec-20220512
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.4,REQID:608cf369-65f1-468d-895c-d53c14a6965b,OB:0,LO
        B:0,IP:0,URL:5,TC:0,Content:-20,EDM:0,RT:0,SF:100,FILE:0,RULE:Release_Ham,
        ACTION:release,TS:85
X-CID-INFO: VERSION:1.1.4,REQID:608cf369-65f1-468d-895c-d53c14a6965b,OB:0,LOB:
        0,IP:0,URL:5,TC:0,Content:-20,EDM:0,RT:0,SF:100,FILE:0,RULE:Spam_GS981B3D,
        ACTION:quarantine,TS:85
X-CID-META: VersionHash:faefae9,CLOUDID:10ab78b3-56b5-4c9e-8d83-0070b288eb6a,C
        OID:18dd51732351,Recheck:0,SF:28|16|19|48,TC:nil,Content:0,EDM:-3,File:nil
        ,QS:0,BEC:nil
X-UUID: 1115d125ad0a4ee3b6168e1df6d7a9ec-20220512
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw02.mediatek.com
        (envelope-from <sean.wang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 172880938; Thu, 12 May 2022 07:06:39 +0800
Received: from mtkmbs07n1.mediatek.inc (172.21.101.16) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3;
 Thu, 12 May 2022 07:06:38 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 12 May 2022 07:06:37 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.3 via Frontend Transport; Thu, 12 May 2022 07:06:37 +0800
From:   <sean.wang@mediatek.com>
To:     <nbd@nbd.name>, <lorenzo.bianconi@redhat.com>
CC:     <sean.wang@mediatek.com>, <Soul.Huang@mediatek.com>,
        <YN.Chen@mediatek.com>, <Leon.Yen@mediatek.com>,
        <Eric-SY.Chang@mediatek.com>, <Deren.Wu@mediatek.com>,
        <km.lin@mediatek.com>, <jenhao.yang@mediatek.com>,
        <robin.chiu@mediatek.com>, <Eddie.Chen@mediatek.com>,
        <ch.yeh@mediatek.com>, <posh.sun@mediatek.com>,
        <ted.huang@mediatek.com>, <Eric.Liang@mediatek.com>,
        <Stella.Chang@mediatek.com>, <Tom.Chou@mediatek.com>,
        <steve.lee@mediatek.com>, <jsiuda@google.com>,
        <frankgor@google.com>, <jemele@google.com>,
        <abhishekpandit@google.com>, <shawnku@google.com>,
        <linux-wireless@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        Lorenzo Bianconi <lorenzo@kernel.org>
Subject: [PATCH v2 1/2] mt76: add gfp to mt76_mcu_msg_alloc signature
Date:   Thu, 12 May 2022 07:06:35 +0800
Message-ID: <51d96f159ec37c2610d3c444177508ffc7781e2c.1652310294.git.objelf@gmail.com>
X-Mailer: git-send-email 1.7.9.5
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Lorenzo Bianconi <lorenzo@kernel.org>

Introduce __mt76_mcu_msg_alloc utility routine in order to specify gfp
flags for mcu message allocation.

Acked-by: Sean Wang <sean.wang@mediatek.com>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
v2: new created
---
 drivers/net/wireless/mediatek/mt76/mcu.c  | 8 ++++----
 drivers/net/wireless/mediatek/mt76/mt76.h | 9 ++++++++-
 2 files changed, 12 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mcu.c b/drivers/net/wireless/mediatek/mt76/mcu.c
index 3f94c37251df..914ee278e6e2 100644
--- a/drivers/net/wireless/mediatek/mt76/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mcu.c
@@ -6,14 +6,14 @@
 #include "mt76.h"
 
 struct sk_buff *
-mt76_mcu_msg_alloc(struct mt76_dev *dev, const void *data,
-		   int data_len)
+__mt76_mcu_msg_alloc(struct mt76_dev *dev, const void *data,
+		     int data_len, gfp_t gfp)
 {
 	const struct mt76_mcu_ops *ops = dev->mcu_ops;
 	int length = ops->headroom + data_len + ops->tailroom;
 	struct sk_buff *skb;
 
-	skb = alloc_skb(length, GFP_KERNEL);
+	skb = alloc_skb(length, gfp);
 	if (!skb)
 		return NULL;
 
@@ -25,7 +25,7 @@ mt76_mcu_msg_alloc(struct mt76_dev *dev, const void *data,
 
 	return skb;
 }
-EXPORT_SYMBOL_GPL(mt76_mcu_msg_alloc);
+EXPORT_SYMBOL_GPL(__mt76_mcu_msg_alloc);
 
 struct sk_buff *mt76_mcu_get_response(struct mt76_dev *dev,
 				      unsigned long expires)
diff --git a/drivers/net/wireless/mediatek/mt76/mt76.h b/drivers/net/wireless/mediatek/mt76/mt76.h
index dc0f1b0aa34a..4e8997c45c1b 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76.h
@@ -1345,8 +1345,15 @@ int mt76s_rd_rp(struct mt76_dev *dev, u32 base,
 		struct mt76_reg_pair *data, int len);
 
 struct sk_buff *
+__mt76_mcu_msg_alloc(struct mt76_dev *dev, const void *data,
+		     int data_len, gfp_t gfp);
+static inline struct sk_buff *
 mt76_mcu_msg_alloc(struct mt76_dev *dev, const void *data,
-		   int data_len);
+		   int data_len)
+{
+	return __mt76_mcu_msg_alloc(dev, data, data_len, GFP_KERNEL);
+}
+
 void mt76_mcu_rx_event(struct mt76_dev *dev, struct sk_buff *skb);
 struct sk_buff *mt76_mcu_get_response(struct mt76_dev *dev,
 				      unsigned long expires);
-- 
2.25.1

