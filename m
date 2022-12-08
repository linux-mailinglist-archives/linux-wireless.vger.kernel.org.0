Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F0CE6473C9
	for <lists+linux-wireless@lfdr.de>; Thu,  8 Dec 2022 17:02:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229769AbiLHQCE (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 8 Dec 2022 11:02:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230099AbiLHQCA (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 8 Dec 2022 11:02:00 -0500
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CC749B2B2
        for <linux-wireless@vger.kernel.org>; Thu,  8 Dec 2022 08:01:59 -0800 (PST)
X-UUID: 3bfcb07e07774fe69ddd84d4ca08b9ef-20221209
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=+76gdjb4ml67Jkqt4RrOnjZf/kZrAJbshFGU/r7BGa0=;
        b=PpvkmZRXeSXSTMf7x0jMxeHBnL8ac7yUvzIs1cOHRNZ9f2Tn285LIbSceWp9PoBDyWjN/b6v+1Q35peSxSIS+snKH5ovp+PwW9At7MT1i5abzypSUjavFDa3H8Jte02ArsY373U0HD3Y1vHaBOXDKMt2JlnkRAv5kzBulIH6yyw=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.14,REQID:541b9653-7d4e-4313-9025-ee13273eac9e,IP:0,U
        RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:-5
X-CID-META: VersionHash:dcaaed0,CLOUDID:b3a10ad2-652d-43fd-a13a-a5dd3c69a43d,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: 3bfcb07e07774fe69ddd84d4ca08b9ef-20221209
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw01.mediatek.com
        (envelope-from <shayne.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1945983699; Fri, 09 Dec 2022 00:01:53 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 mtkmbs13n1.mediatek.inc (172.21.101.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Fri, 9 Dec 2022 00:01:52 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Fri, 9 Dec 2022 00:01:52 +0800
From:   Shayne Chen <shayne.chen@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>
CC:     linux-wireless <linux-wireless@vger.kernel.org>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Evelyn Tsai <evelyn.tsai@mediatek.com>,
        linux-mediatek <linux-mediatek@lists.infradead.org>,
        Shayne Chen <shayne.chen@mediatek.com>
Subject: [PATCH] wifi: mt76: mt7915: add chip id condition in mt7915_check_eeprom()
Date:   Fri, 9 Dec 2022 00:01:37 +0800
Message-ID: <20221208160137.3855-1-shayne.chen@mediatek.com>
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

When flash mode is enabled, and the eeprom data in the flash is not for
the current chipset, it'll still be checked valid, and the default
eeprom bin won't be loaded.
(e.g., mt7915 NIC inserted with mt7916 eeprom data in the flash.)

Fix this kind of case by adding chip id into consideration in
mt7915_check_eeprom().

Reported-by: Cheng-Ji Li <cheng-ji.li@mediatek.com>
Signed-off-by: Shayne Chen <shayne.chen@mediatek.com>
---
 drivers/net/wireless/mediatek/mt76/mt7915/eeprom.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/eeprom.c b/drivers/net/wireless/mediatek/mt76/mt7915/eeprom.c
index 59069fb86414..e21aa03c85b1 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/eeprom.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/eeprom.c
@@ -33,14 +33,12 @@ static int mt7915_check_eeprom(struct mt7915_dev *dev)
 	u8 *eeprom = dev->mt76.eeprom.data;
 	u16 val = get_unaligned_le16(eeprom);
 
-	switch (val) {
-	case 0x7915:
-	case 0x7916:
-	case 0x7986:
+	if ((is_mt7915(&dev->mt76) && val == 0x7915) ||
+	    (is_mt7916(&dev->mt76) && val == 0x7916) ||
+	    (is_mt7986(&dev->mt76) && val == 0x7986))
 		return 0;
-	default:
-		return -EINVAL;
-	}
+
+	return -EINVAL;
 }
 
 static char *mt7915_eeprom_name(struct mt7915_dev *dev)
-- 
2.25.1

