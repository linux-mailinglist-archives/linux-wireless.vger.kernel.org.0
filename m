Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB2E958954C
	for <lists+linux-wireless@lfdr.de>; Thu,  4 Aug 2022 02:26:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236977AbiHDA0s (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 3 Aug 2022 20:26:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229881AbiHDA0q (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 3 Aug 2022 20:26:46 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C057C2654A
        for <linux-wireless@vger.kernel.org>; Wed,  3 Aug 2022 17:26:39 -0700 (PDT)
X-UUID: bbcfc82f14f54649a47ff3bc5fd003e2-20220804
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=S+iLJb80EvDWimTLjqOD1nOSy2+QSwLo1DqVRfZhONc=;
        b=Tr/eHgux8sWn1Qmdpdu2/dcEbSJhekwG4ttPClJ6HYH1y01ghdj0S4K4TOf07ebGV1Rz+naRYgxEm0AZUvrQQd5iWOGRTuVsQLFXrIxiTUdxojR1L25XNPMQlJ5HllbA7wHGlu82DLq/ICvsqLCiKLsVtrQzId2xaDdQcyyGFp8=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.8,REQID:d2496d40-2e7d-43c7-b783-b09c0da80938,OB:0,LO
        B:0,IP:0,URL:5,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,RULE:Release_Ham,ACTI
        ON:release,TS:5
X-CID-META: VersionHash:0f94e32,CLOUDID:61f728d1-841b-4e95-ad42-8f86e18f54fc,C
        OID:IGNORED,Recheck:0,SF:nil,TC:nil,Content:0,EDM:-3,IP:nil,URL:1,File:nil
        ,QS:nil,BEC:nil,COL:0
X-UUID: bbcfc82f14f54649a47ff3bc5fd003e2-20220804
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by mailgw02.mediatek.com
        (envelope-from <sean.wang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1400052859; Thu, 04 Aug 2022 08:26:34 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.792.3;
 Thu, 4 Aug 2022 08:26:33 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Thu, 4 Aug 2022 08:26:33 +0800
From:   <sean.wang@mediatek.com>
To:     <nbd@nbd.name>, <lorenzo.bianconi@redhat.com>
CC:     <sean.wang@mediatek.com>, <Soul.Huang@mediatek.com>,
        <YN.Chen@mediatek.com>, <Leon.Yen@mediatek.com>,
        <Eric-SY.Chang@mediatek.com>, <Deren.Wu@mediatek.com>,
        <km.lin@mediatek.com>, <jenhao.yang@mediatek.com>,
        <robin.chiu@mediatek.com>, <Eddie.Chen@mediatek.com>,
        <ch.yeh@mediatek.com>, <posh.sun@mediatek.com>,
        <ted.huang@mediatek.com>, <Stella.Chang@mediatek.com>,
        <Tom.Chou@mediatek.com>, <steve.lee@mediatek.com>,
        <jsiuda@google.com>, <frankgor@google.com>, <kuabhs@google.com>,
        <druth@google.com>, <abhishekpandit@google.com>,
        <shawnku@google.com>, <linux-wireless@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>
Subject: [PATCH] mt76: mt7921: apply the previous MCU timeout
Date:   Thu, 4 Aug 2022 08:26:31 +0800
Message-ID: <b0dfe8afc5cf88ab9a6d54c88fba4a29631c125a.1659571732.git.objelf@gmail.com>
X-Mailer: git-send-email 1.7.9.5
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

From: Sean Wang <sean.wang@mediatek.com>

Apply back the previous MCU timeout that can trigger the chip reset to
recover the fatal error in time.

Fixes: 8fcd1fb7cbd5 ("mt76: move mt76_connac2_mcu_fill_message in
 mt76_connac module")
Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
 b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
index 0afcadce87fc..da8223c515eb 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
@@ -3050,7 +3050,10 @@ int mt76_connac2_mcu_fill_message(struct mt76_dev
 *dev, struct sk_buff *skb,
 	u8 seq;
 
 	/* TODO: make dynamic based on msg type */
-	dev->mcu.timeout = 20 * HZ;
+	if (is_mt7921(dev))
+		dev->mcu.timeout = 3 * HZ;
+	else
+		dev->mcu.timeout = 20 * HZ;
 
 	seq = ++dev->mcu.msg_seq & 0xf;
 	if (!seq)
-- 
2.25.1

