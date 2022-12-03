Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8523B6413F7
	for <lists+linux-wireless@lfdr.de>; Sat,  3 Dec 2022 04:22:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229991AbiLCDWn (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 2 Dec 2022 22:22:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229706AbiLCDWk (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 2 Dec 2022 22:22:40 -0500
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF1F1F77
        for <linux-wireless@vger.kernel.org>; Fri,  2 Dec 2022 19:22:35 -0800 (PST)
X-UUID: 3353c64176454ae08f09474457701c00-20221203
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=PNWSJ4pI2IkcKyFFE7f5GycSoRpgFBoM3xfG53SHE8M=;
        b=UKzcy7ydkLpu4gn2P83SY895TKu+Cr5GUo4xqJTQAz1klYut+SrWjg1yzKlii1oDANQ6a6+X1y4ze6Q6IdRv5cDOITp9eMbF6ljT+uMcGY6Fi9EEmMjit1fAYSPdc36xXQIKjMvh07aynDEqvJMabEj/bl+26jZDju+DhJ3vSUc=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.14,REQID:b07f776e-0be1-4f9d-a23f-b7e6d17a552c,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:dcaaed0,CLOUDID:af4d6e6c-41fe-47b6-8eb4-ec192dedaf7d,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: 3353c64176454ae08f09474457701c00-20221203
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw01.mediatek.com
        (envelope-from <ryder.lee@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1109948359; Sat, 03 Dec 2022 11:22:27 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Sat, 3 Dec 2022 11:22:26 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Sat, 3 Dec 2022 11:22:26 +0800
From:   Ryder Lee <ryder.lee@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>, <linux-wireless@vger.kernel.org>
CC:     Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        Evelyn Tsai <evelyn.tsai@mediatek.com>,
        <linux-mediatek@lists.infradead.org>,
        Ryder Lee <ryder.lee@mediatek.com>
Subject: [PATCH 2/4] wifi: mt76: mt7996: fix insecure data handling of mt7996_mcu_ie_countdown()
Date:   Sat, 3 Dec 2022 11:22:23 +0800
Message-ID: <e8b579782304fcb92b462abb8874ae4d309aa6aa.1670037462.git.ryder.lee@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <ce05914d5a4d73cea21ef2c359f3a5bb7c61a86e.1670037462.git.ryder.lee@mediatek.com>
References: <ce05914d5a4d73cea21ef2c359f3a5bb7c61a86e.1670037462.git.ryder.lee@mediatek.com>
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

Coverity message:
using tainted "hdr->band" variable as an index into an array "(*dev).mt76.phys".

Reported-by: coverity-bot <keescook+coverity-bot@chromium.org>
Addresses-Coverity-ID: 1527797 ("Insecure data handling")
Fixes: 98686cd21624 ("wifi: mt76: mt7996: add driver for MediaTek Wi-Fi 7 (802.11be) devices")
Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
---
 drivers/net/wireless/mediatek/mt76/mt7996/mcu.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
index 04e1d10bbd21..a90b7ca2df63 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
@@ -412,6 +412,9 @@ mt7996_mcu_ie_countdown(struct mt7996_dev *dev, struct sk_buff *skb)
 	struct header *hdr = (struct header *)data;
 	struct tlv *tlv = (struct tlv *)(data + 4);
 
+	if (hdr->band >= ARRAY_SIZE(dev->mt76.phys))
+		return;
+
 	if (hdr->band && dev->mt76.phys[hdr->band])
 		mphy = dev->mt76.phys[hdr->band];
 
-- 
2.18.0

