Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86EC364E698
	for <lists+linux-wireless@lfdr.de>; Fri, 16 Dec 2022 05:06:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229596AbiLPEF7 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 15 Dec 2022 23:05:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229763AbiLPEF6 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 15 Dec 2022 23:05:58 -0500
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED81B5F9C
        for <linux-wireless@vger.kernel.org>; Thu, 15 Dec 2022 20:05:55 -0800 (PST)
X-UUID: 0535dc8d9db8461cacc015c4664cbdf6-20221216
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=CEFy1qbPMKhRCzNmvFm4G8Rvipph7pcm6woE+Ng3Gf0=;
        b=FTyHs8qJ0L0xP7BicEkCTXawX6AWSMhgHsapZ90AWpEhxRJav7eveI7uedhgoxhV5MsxZuoeGo7Thuu+VGC6gIGMIG7qYvDdwcMRvSwViC9hE06DwIeFUuOnw2e/1tvOpqQpTkmD1jajU6hEe8Zb+O4rWibO9z7KhsK5QzwThUU=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.14,REQID:ad6b5048-96de-4edd-bf1a-62d566b183b7,IP:0,U
        RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:-5
X-CID-META: VersionHash:dcaaed0,CLOUDID:d7936735-a6a3-44f7-8aad-08fee1939a08,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: 0535dc8d9db8461cacc015c4664cbdf6-20221216
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw02.mediatek.com
        (envelope-from <shayne.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1433196057; Fri, 16 Dec 2022 12:05:48 +0800
Received: from mtkmbs13n2.mediatek.inc (172.21.101.108) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Fri, 16 Dec 2022 12:05:47 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs13n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Fri, 16 Dec 2022 12:05:47 +0800
From:   Shayne Chen <shayne.chen@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>
CC:     linux-wireless <linux-wireless@vger.kernel.org>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Evelyn Tsai <evelyn.tsai@mediatek.com>,
        linux-mediatek <linux-mediatek@lists.infradead.org>,
        Shayne Chen <shayne.chen@mediatek.com>
Subject: [PATCH v2] wifi: mt76: mt7915: add chip id condition in mt7915_check_eeprom()
Date:   Fri, 16 Dec 2022 12:05:31 +0800
Message-ID: <20221216040531.3736-1-shayne.chen@mediatek.com>
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
v2:
  - use switch case and add a macro to convert return value
---
 drivers/net/wireless/mediatek/mt76/mt7915/eeprom.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/eeprom.c b/drivers/net/wireless/mediatek/mt76/mt7915/eeprom.c
index 24efa280dd86..a79628933948 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/eeprom.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/eeprom.c
@@ -33,11 +33,14 @@ static int mt7915_check_eeprom(struct mt7915_dev *dev)
 	u8 *eeprom = dev->mt76.eeprom.data;
 	u16 val = get_unaligned_le16(eeprom);
 
+#define CHECK_EEPROM_ERR(match)	(match ? 0 : -EINVAL)
 	switch (val) {
 	case 0x7915:
+		return CHECK_EEPROM_ERR(is_mt7915(&dev->mt76));
 	case 0x7916:
+		return CHECK_EEPROM_ERR(is_mt7916(&dev->mt76));
 	case 0x7986:
-		return 0;
+		return CHECK_EEPROM_ERR(is_mt7986(&dev->mt76));
 	default:
 		return -EINVAL;
 	}
-- 
2.25.1

