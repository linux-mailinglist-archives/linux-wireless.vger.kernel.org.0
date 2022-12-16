Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C527F64E5FA
	for <lists+linux-wireless@lfdr.de>; Fri, 16 Dec 2022 03:30:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229780AbiLPCaN (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 15 Dec 2022 21:30:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229547AbiLPCaM (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 15 Dec 2022 21:30:12 -0500
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 208923FBA7
        for <linux-wireless@vger.kernel.org>; Thu, 15 Dec 2022 18:30:06 -0800 (PST)
X-UUID: 8e00e8a18b1a49a08e8cab6c7ecf3be2-20221216
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=23KUXDJdBgZTEKi7SidofKO0o5BuEsUkq/IELsxruIQ=;
        b=qRrxCiWkx3i2ubrhFInjJ2xigOxzFNKhEqfGYYWyK++R2kfMJcmjqaPIz1bEUQfs9jr/1c7jcsNfH2Qc9Ql9tjlFxZD0fGybjySwzlzzgkLfNSoQwlA1lpU4xH8U1dSNXURqBZPjNWhFbzc/iUZLWLoA+LAYBplBwFJb0K3iySA=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.14,REQID:d2aa975e-865f-4022-a879-96f18a9d1a44,IP:0,U
        RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:100,FILE:0,BULK:0,RULE:Release_Ham,ACTI
        ON:release,TS:95
X-CID-INFO: VERSION:1.1.14,REQID:d2aa975e-865f-4022-a879-96f18a9d1a44,IP:0,URL
        :0,TC:0,Content:-5,EDM:0,RT:0,SF:100,FILE:0,BULK:0,RULE:Spam_GS981B3D,ACTI
        ON:quarantine,TS:95
X-CID-META: VersionHash:dcaaed0,CLOUDID:2294c9af-9f02-4d44-9c44-6e4bb4e4f412,B
        ulkID:221216103002DF1F6HBY,BulkQuantity:0,Recheck:0,SF:28|17|19|48,TC:nil,
        Content:0,EDM:-3,IP:nil,URL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: 8e00e8a18b1a49a08e8cab6c7ecf3be2-20221216
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw02.mediatek.com
        (envelope-from <bo.jiao@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 87263650; Fri, 16 Dec 2022 10:30:01 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Fri, 16 Dec 2022 10:30:00 +0800
Received: from mcddlt001.gcn.mediatek.inc (10.19.240.15) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Fri, 16 Dec 2022 10:29:59 +0800
From:   Bo Jiao <bo.jiao@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>
CC:     linux-wireless <linux-wireless@vger.kernel.org>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Sujuan Chen <sujuan.chen@mediatek.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        Evelyn Tsai <evelyn.tsai@mediatek.com>,
        linux-mediatek <linux-mediatek@lists.infradead.org>,
        Bo Jiao <Bo.Jiao@mediatek.com>
Subject: [PATCH] wifi: mt76: fix potential memory leakage
Date:   Fri, 16 Dec 2022 10:29:55 +0800
Message-ID: <c663e984077ae903d8d4d34ed470986c6ccb4757.1671157658.git.Bo.Jiao@mediatek.com>
X-Mailer: git-send-email 2.17.0
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

From: Bo Jiao <Bo.Jiao@mediatek.com>

fix potential memory leakage, recycle rxwi when mt76_dma_add_buf() call fails.

Signed-off-by: Bo Jiao <Bo.Jiao@mediatek.com>
---
 drivers/net/wireless/mediatek/mt76/dma.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/wireless/mediatek/mt76/dma.c b/drivers/net/wireless/mediatek/mt76/dma.c
index fc24b35..9053344 100644
--- a/drivers/net/wireless/mediatek/mt76/dma.c
+++ b/drivers/net/wireless/mediatek/mt76/dma.c
@@ -592,6 +592,7 @@ mt76_dma_rx_fill(struct mt76_dev *dev, struct mt76_queue *q)
 		qbuf.len = len - offset;
 		qbuf.skip_unmap = false;
 		if (mt76_dma_add_buf(dev, q, &qbuf, 1, 0, buf, t) < 0) {
+			mt76_put_rxwi(dev, t);
 			dma_unmap_single(dev->dma_dev, addr, len,
 					 DMA_FROM_DEVICE);
 			skb_free_frag(buf);
-- 
2.18.0

