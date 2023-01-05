Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 851AF65EA26
	for <lists+linux-wireless@lfdr.de>; Thu,  5 Jan 2023 12:47:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232584AbjAELrk (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 5 Jan 2023 06:47:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232489AbjAELrW (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 5 Jan 2023 06:47:22 -0500
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E2E53056F
        for <linux-wireless@vger.kernel.org>; Thu,  5 Jan 2023 03:47:21 -0800 (PST)
X-UUID: 6a51e60585d5418d9337e93a6efb8a69-20230105
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=Dkt3HR/PhYl/HcfNR96k5NZTqAIpZGIMAMABCP3i6Es=;
        b=bSc2oxu9XDaysb7bN7jL+EY0Tr6N8sZdGJ8nztjhoemu/4n31sZ7hhk5zUcnHzHmQDzIzkwtftFc/OYpyb0YucNYrlqwkXkPzuCX71zqoF/SuzjzNpMepz2r+4y5cAdl2tHmy/A9tENImrpRxqIZAnOiUlwA2zswZE82Pq+jODk=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.17,REQID:d5eccc4d-d5fd-4add-8cd4-6b49c5109d46,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:100,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
        N:release,TS:100
X-CID-INFO: VERSION:1.1.17,REQID:d5eccc4d-d5fd-4add-8cd4-6b49c5109d46,IP:0,URL
        :0,TC:0,Content:0,EDM:0,RT:0,SF:100,FILE:0,BULK:0,RULE:Spam_GS981B3D,ACTIO
        N:quarantine,TS:100
X-CID-META: VersionHash:543e81c,CLOUDID:d0165a8b-8530-4eff-9f77-222cf6e2895b,B
        ulkID:230105194716CXV149PD,BulkQuantity:0,Recheck:0,SF:28|17|19|48,TC:nil,
        Content:0,EDM:-3,IP:nil,URL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0
        ,OSA:0
X-CID-BVR: 0
X-UUID: 6a51e60585d5418d9337e93a6efb8a69-20230105
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw01.mediatek.com
        (envelope-from <chui-hao.chiu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 17885007; Thu, 05 Jan 2023 19:47:14 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 mtkmbs13n1.mediatek.inc (172.21.101.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Thu, 5 Jan 2023 19:47:13 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Thu, 5 Jan 2023 19:47:13 +0800
From:   Peter Chiu <chui-hao.chiu@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>
CC:     Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        Ryder Lee <ryder.Lee@mediatek.com>,
        Evelyn Tsai <evelyn.tsai@mediatek.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        <linux-wireless@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        Peter Chiu <chui-hao.chiu@mediatek.com>
Subject: [PATCH 1/2] wifi: mt76: mt7915: set sku initial value to zero
Date:   Thu, 5 Jan 2023 19:47:10 +0800
Message-ID: <20230105114711.31430-1-chui-hao.chiu@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
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

