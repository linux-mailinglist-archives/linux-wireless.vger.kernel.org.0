Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6CB865F9A5
	for <lists+linux-wireless@lfdr.de>; Fri,  6 Jan 2023 03:44:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230402AbjAFCo0 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 5 Jan 2023 21:44:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230381AbjAFCoZ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 5 Jan 2023 21:44:25 -0500
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0327765AFB
        for <linux-wireless@vger.kernel.org>; Thu,  5 Jan 2023 18:44:19 -0800 (PST)
X-UUID: b24c6ae5bf18453eb554c247df0fd417-20230106
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=Dkt3HR/PhYl/HcfNR96k5NZTqAIpZGIMAMABCP3i6Es=;
        b=dl5hewIVUvMlYGGtdfVBpo4stMgK8K8V0FLHZCEaZYnXsJnPG5Tlv+XT0WYvzDlFk+ZIiZmh4n/lzLvqQ7/MjWbjJy+UA+ZNTwzgPpI5auE/fWYPLC/hqabB/8wzHBq3OCW6XXKJo6/84UCS+iv605aKiLl1XfWeL3XP3h0sYWg=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.17,REQID:58db3d37-9574-4097-ae9e-f8b223fddeed,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:100,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
        N:release,TS:100
X-CID-INFO: VERSION:1.1.17,REQID:58db3d37-9574-4097-ae9e-f8b223fddeed,IP:0,URL
        :0,TC:0,Content:0,EDM:0,RT:0,SF:100,FILE:0,BULK:0,RULE:Spam_GS981B3D,ACTIO
        N:quarantine,TS:100
X-CID-META: VersionHash:543e81c,CLOUDID:5bad688b-8530-4eff-9f77-222cf6e2895b,B
        ulkID:230105194716CXV149PD,BulkQuantity:6,Recheck:0,SF:28|17|19|48,TC:nil,
        Content:0,EDM:-3,IP:nil,URL:0,File:nil,Bulk:41,QS:nil,BEC:nil,COL:0,OSI:0,
        OSA:0
X-CID-BVR: 0
X-UUID: b24c6ae5bf18453eb554c247df0fd417-20230106
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by mailgw01.mediatek.com
        (envelope-from <chui-hao.chiu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 374256481; Fri, 06 Jan 2023 10:44:13 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Fri, 6 Jan 2023 10:44:13 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Fri, 6 Jan 2023 10:44:13 +0800
From:   Peter Chiu <chui-hao.chiu@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>
CC:     Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        Ryder Lee <ryder.Lee@mediatek.com>,
        Evelyn Tsai <evelyn.tsai@mediatek.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        <linux-wireless@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        Peter Chiu <chui-hao.chiu@mediatek.com>
Subject: [PATCH v2 1/2] wifi: mt76: mt7915: set sku initial value to zero
Date:   Fri, 6 Jan 2023 10:44:11 +0800
Message-ID: <20230106024412.10064-1-chui-hao.chiu@mediatek.com>
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

Set sku initial value before mcu starts to prevent mcu from getting an
invalid value.

Signed-off-by: Peter Chiu <chui-hao.chiu@mediatek.com>
---
 drivers/net/wireless/mediatek/mt76/mt7915/soc.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/soc.c b/drivers/net/wireless/mediatek/mt76/mt7915/soc.c
index 686c9bbd5929..2ac0a0f2859c 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/soc.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/soc.c
@@ -883,6 +883,8 @@ static int mt7986_wmac_wm_enable(struct mt7915_dev *dev, bool enable)
 {
 	u32 cur;
 
+	mt76_wr(dev, MT_CONNINFRA_SKU_DEC_ADDR, 0);
+
 	mt76_rmw_field(dev, MT7986_TOP_WM_RESET,
 		       MT7986_TOP_WM_RESET_MASK, enable);
 	if (!enable)
-- 
2.18.0

