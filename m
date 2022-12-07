Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2580F645498
	for <lists+linux-wireless@lfdr.de>; Wed,  7 Dec 2022 08:30:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229605AbiLGHaX (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 7 Dec 2022 02:30:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbiLGHaU (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 7 Dec 2022 02:30:20 -0500
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 417A527B23
        for <linux-wireless@vger.kernel.org>; Tue,  6 Dec 2022 23:30:15 -0800 (PST)
X-UUID: a0630682178d4ba393bdd264a6efd17b-20221207
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=56GrzRTzL4IqyjNFK17cSt2aS1qNNZ9O5Pqe/qVyOYk=;
        b=sEaqE0nY8mpKGEcU4V6AB+VH0R8z9MdUDLRuv4OEiNlSllQS12zJ4Yzx5DR1dxuXdOEpO3ARHfeTJ23V0/ASSoTKZTKSqQmlX6nMlAvUnLc6eLfJX9O42y3aGrDY7pEfcp04Bs2rti6EsEpCL46xBajrvVbM2lQgyN92OGe+h/g=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.14,REQID:c3103057-fc57-4552-a48a-72a2bc8863be,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:dcaaed0,CLOUDID:ba3ce3d1-652d-43fd-a13a-a5dd3c69a43d,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: a0630682178d4ba393bdd264a6efd17b-20221207
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by mailgw01.mediatek.com
        (envelope-from <ryder.lee@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 738552252; Wed, 07 Dec 2022 15:30:10 +0800
Received: from mtkmbs13n2.mediatek.inc (172.21.101.108) by
 mtkmbs13n1.mediatek.inc (172.21.101.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Wed, 7 Dec 2022 15:30:09 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs13n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Wed, 7 Dec 2022 15:30:09 +0800
From:   Ryder Lee <ryder.lee@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>, <linux-wireless@vger.kernel.org>
CC:     Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        Evelyn Tsai <evelyn.tsai@mediatek.com>,
        <linux-mediatek@lists.infradead.org>,
        Ryder Lee <ryder.lee@mediatek.com>
Subject: [PATCH 2/2] wifi: mt76: mt7915: fix unintended sign extension of mt7915_hw_queue_read()
Date:   Wed, 7 Dec 2022 15:30:05 +0800
Message-ID: <1c3c811a6f0a3ad54499729c1020e0504fea6c7d.1670396836.git.ryder.lee@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <a882942479ff8f20189580a69174202b40210682.1670396836.git.ryder.lee@mediatek.com>
References: <a882942479ff8f20189580a69174202b40210682.1670396836.git.ryder.lee@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,UNPARSEABLE_RELAY
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

In the expression "map[i].qid << 24" starts as u8, but is promoted to
"signed int", then sign-extended to type "unsigned long", which is not
intended. Cast to u32 to avoid the sign extension.

Fixes: 776ec4e77aa6 ("mt76: mt7915: rework debugfs queue info")
Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
---
 drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c b/drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c
index a7fdcd1f3d98..5a46813a59ea 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c
@@ -811,7 +811,7 @@ mt7915_hw_queue_read(struct seq_file *s, u32 size,
 		if (val & BIT(map[i].index))
 			continue;
 
-		ctrl = BIT(31) | (map[i].pid << 10) | (map[i].qid << 24);
+		ctrl = BIT(31) | (map[i].pid << 10) | ((u32)map[i].qid << 24);
 		mt76_wr(dev, MT_FL_Q0_CTRL, ctrl);
 
 		head = mt76_get_field(dev, MT_FL_Q2_CTRL,
-- 
2.18.0

