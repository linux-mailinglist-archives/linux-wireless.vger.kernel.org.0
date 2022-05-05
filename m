Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4F9251BA47
	for <lists+linux-wireless@lfdr.de>; Thu,  5 May 2022 10:26:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232163AbiEEI37 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 5 May 2022 04:29:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346959AbiEEI3v (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 5 May 2022 04:29:51 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CE032D1F8
        for <linux-wireless@vger.kernel.org>; Thu,  5 May 2022 01:26:05 -0700 (PDT)
X-UUID: c4ccf3d257064e8fb8b0f700681bafda-20220505
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.4,REQID:51b0960d-7456-4430-9ab3-d009d5911578,OB:0,LO
        B:0,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,RULE:Release_Ham,ACTI
        ON:release,TS:0
X-CID-META: VersionHash:faefae9,CLOUDID:b4ceaab2-56b5-4c9e-8d83-0070b288eb6a,C
        OID:IGNORED,Recheck:0,SF:nil,TC:nil,Content:0,EDM:-3,File:nil,QS:0,BEC:nil
X-UUID: c4ccf3d257064e8fb8b0f700681bafda-20220505
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw02.mediatek.com
        (envelope-from <chui-hao.chiu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 190243629; Thu, 05 May 2022 16:25:57 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3;
 Thu, 5 May 2022 16:25:56 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 5 May 2022 16:25:56 +0800
From:   Peter Chiu <chui-hao.chiu@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>
CC:     Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        Ryder Lee <ryder.Lee@mediatek.com>,
        Evelyn Tsai <evelyn.tsai@mediatek.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        <linux-wireless@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        Peter Chiu <chui-hao.chiu@mediatek.com>
Subject: [PATCH 1/4] mt76: mt7915: update mt7986 patch in mt7986_wmac_adie_patch_7976()
Date:   Thu, 5 May 2022 16:25:51 +0800
Message-ID: <20220505082554.16656-1-chui-hao.chiu@mediatek.com>
X-Mailer: git-send-email 2.18.0
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

Update mt7976 adie patch for different adie version.

Reviewed-by: Ryder Lee <ryder.lee@mediatek.com>
Reviewed-by: Shayne Chen <shayne.chen@mediatek.com>
Signed-off-by: Peter Chiu <chui-hao.chiu@mediatek.com>
---
 .../net/wireless/mediatek/mt76/mt7915/regs.h  |  1 +
 .../net/wireless/mediatek/mt76/mt7915/soc.c   | 19 +++++++++++++++++--
 2 files changed, 18 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/regs.h b/drivers/net/wireless/mediatek/mt76/mt7915/regs.h
index bac76bc2770f..338dfbee0f93 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/regs.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/regs.h
@@ -797,6 +797,7 @@ enum offs_rev {
 
 /* ADIE */
 #define MT_ADIE_CHIP_ID			0x02c
+#define MT_ADIE_VERSION_MASK		GENMASK(15, 0)
 #define MT_ADIE_CHIP_ID_MASK		GENMASK(31, 16)
 #define MT_ADIE_IDX0			GENMASK(15, 0)
 #define MT_ADIE_IDX1			GENMASK(31, 16)
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/soc.c b/drivers/net/wireless/mediatek/mt76/mt7915/soc.c
index 04e62d569599..c418b5dfda7f 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/soc.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/soc.c
@@ -470,17 +470,32 @@ static int mt7986_wmac_adie_xtal_trim_7976(struct mt7915_dev *dev, u8 adie)
 
 static int mt7986_wmac_adie_patch_7976(struct mt7915_dev *dev, u8 adie)
 {
+	u32 id, version, rg_xo_01, rg_xo_03;
 	int ret;
 
+	ret = mt76_wmac_spi_read(dev, adie, MT_ADIE_CHIP_ID, &id);
+	if (ret)
+		return ret;
+
+	version = FIELD_GET(MT_ADIE_VERSION_MASK, id);
+
 	ret = mt76_wmac_spi_write(dev, adie, MT_ADIE_RG_TOP_THADC, 0x4a563b00);
 	if (ret)
 		return ret;
 
-	ret = mt76_wmac_spi_write(dev, adie, MT_ADIE_RG_XO_01, 0x1d59080f);
+	if (version == 0x8a00 || version == 0x8a10 || version == 0x8b00) {
+		rg_xo_01 = 0x1d59080f;
+		rg_xo_03 = 0x34c00fe0;
+	} else {
+		rg_xo_01 = 0x1959f80f;
+		rg_xo_03 = 0x34d00fe0;
+	}
+
+	ret = mt76_wmac_spi_write(dev, adie, MT_ADIE_RG_XO_01, rg_xo_01);
 	if (ret)
 		return ret;
 
-	return mt76_wmac_spi_write(dev, adie, MT_ADIE_RG_XO_03, 0x34c00fe0);
+	return mt76_wmac_spi_write(dev, adie, MT_ADIE_RG_XO_03, rg_xo_03);
 }
 
 static int
-- 
2.18.0

