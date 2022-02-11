Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51A504B1CBD
	for <lists+linux-wireless@lfdr.de>; Fri, 11 Feb 2022 03:56:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344026AbiBKCzM (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 10 Feb 2022 21:55:12 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:36636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244263AbiBKCzL (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 10 Feb 2022 21:55:11 -0500
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AF135F4F
        for <linux-wireless@vger.kernel.org>; Thu, 10 Feb 2022 18:55:07 -0800 (PST)
X-UUID: 2be48035695e4f7c89990aa0179393f4-20220211
X-UUID: 2be48035695e4f7c89990aa0179393f4-20220211
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw01.mediatek.com
        (envelope-from <deren.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 211369550; Fri, 11 Feb 2022 10:55:03 +0800
Received: from mtkexhb02.mediatek.inc (172.21.101.103) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3;
 Fri, 11 Feb 2022 10:55:02 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by mtkexhb02.mediatek.inc
 (172.21.101.103) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Fri, 11 Feb
 2022 10:55:01 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 11 Feb 2022 10:55:01 +0800
From:   Deren Wu <Deren.Wu@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>,
        Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
CC:     Sean Wang <sean.wang@mediatek.com>,
        Soul Huang <Soul.Huang@mediatek.com>,
        YN Chen <YN.Chen@mediatek.com>,
        Leon Yen <Leon.Yen@mediatek.com>,
        "Eric-SY Chang" <Eric-SY.Chang@mediatek.com>,
        Deren Wu <Deren.Wu@mediatek.com>, KM Lin <km.lin@mediatek.com>,
        Robin Chiu <robin.chiu@mediatek.com>,
        CH Yeh <ch.yeh@mediatek.com>, Posh Sun <posh.sun@mediatek.com>,
        Eric Liang <Eric.Liang@mediatek.com>,
        Stella Chang <Stella.Chang@mediatek.com>,
        "Evelyn Tsai" <evelyn.tsai@mediatek.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        "Shayne Chen" <shayne.chen@mediatek.com>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        linux-mediatek <linux-mediatek@lists.infradead.org>,
        Deren Wu <deren.wu@mediatek.com>
Subject: [PATCH] mt76: mt7615: fix compiler warning on frame size
Date:   Fri, 11 Feb 2022 10:54:55 +0800
Message-ID: <c7c87a448a159a9836b6ac848eb92f6a367daf1a.1644547407.git.deren.wu@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-MTK:  N
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,MAY_BE_FORGED,
        SPF_HELO_NONE,T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR,UNPARSEABLE_RELAY
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Deren Wu <deren.wu@mediatek.com>

The following error is see from the compiler:

  mt7615/debugfs.c: In function ‘mt7615_ext_mac_addr_read’:
  mt7615/debugfs.c:465:1: warning: the frame size of 1072 bytes is
    larger than 1024 bytes [-Wframe-larger-than=]

The issue is due to allocating a buffer as string storage.

Fix by converting to a dynamical allocation of the buffer.

Reviewed-by: Ryder Lee <ryder.lee@mediatek.com>
Signed-off-by: Deren Wu <deren.wu@mediatek.com>
---
 .../net/wireless/mediatek/mt76/mt7615/debugfs.c    | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/debugfs.c b/drivers/net/wireless/mediatek/mt76/mt7615/debugfs.c
index ca7efca1543f..250faa870db2 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/debugfs.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/debugfs.c
@@ -443,11 +443,16 @@ mt7615_ext_mac_addr_read(struct file *file, char __user *userbuf,
 			 size_t count, loff_t *ppos)
 {
 	struct mt7615_dev *dev = file->private_data;
-	char buf[32 * ((ETH_ALEN * 3) + 4) + 1];
+	char *buf;
+	static u32 len = 32 * ((ETH_ALEN * 3) + 4) + 1;
 	u8 addr[ETH_ALEN];
 	int ofs = 0;
 	int i;
 
+	buf = kzalloc(len, GFP_KERNEL);
+	if (!buf)
+		return -ENOMEM;
+
 	for (i = 0; i < 32; i++) {
 		if (!(dev->muar_mask & BIT(i)))
 			continue;
@@ -458,10 +463,13 @@ mt7615_ext_mac_addr_read(struct file *file, char __user *userbuf,
 		put_unaligned_le32(mt76_rr(dev, MT_WF_RMAC_MAR0), addr);
 		put_unaligned_le16((mt76_rr(dev, MT_WF_RMAC_MAR1) &
 				    MT_WF_RMAC_MAR1_ADDR), addr + 4);
-		ofs += snprintf(buf + ofs, sizeof(buf) - ofs, "%d=%pM\n", i, addr);
+		ofs += snprintf(buf + ofs, len - ofs, "%d=%pM\n", i, addr);
 	}
 
-	return simple_read_from_buffer(userbuf, count, ppos, buf, ofs);
+	ofs = simple_read_from_buffer(userbuf, count, ppos, buf, ofs);
+
+	kfree(buf);
+	return ofs;
 }
 
 static ssize_t
-- 
2.18.0

