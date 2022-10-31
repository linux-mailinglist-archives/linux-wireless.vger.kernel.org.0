Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B200D613B7B
	for <lists+linux-wireless@lfdr.de>; Mon, 31 Oct 2022 17:40:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231915AbiJaQk2 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 31 Oct 2022 12:40:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231912AbiJaQk0 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 31 Oct 2022 12:40:26 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB4BB2DC6
        for <linux-wireless@vger.kernel.org>; Mon, 31 Oct 2022 09:40:20 -0700 (PDT)
X-UUID: fbaa81e44f4845b487b617a1452d1d02-20221101
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=mLEes6JhlpKSfYiTYgnjO3nzfxNcrWSPX/riGgw6u94=;
        b=Hqb/JrHVJmZ5EDI8pKcaXFLWbv3n7bq+EHFGmrIiKEl/N38JvnVodufMOhtU9hhwwyDxWclSCRKih3MKLGRjVaF0CUrK3JM2sOHP/6C7BHw1c00D2xJMey5tNud0NqIm4Zanm9VGJLJY3JUVzounrnjP8yLDD7uqLLcu5muncQU=;
X-CID-UNFAMILIAR: 1
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.12,REQID:f21f476c-3643-4681-bb0f-58ff9e8c19ec,IP:0,U
        RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:100,FILE:0,BULK:0,RULE:Release_Ham,ACTI
        ON:release,TS:95
X-CID-INFO: VERSION:1.1.12,REQID:f21f476c-3643-4681-bb0f-58ff9e8c19ec,IP:0,URL
        :0,TC:0,Content:-5,EDM:0,RT:0,SF:100,FILE:0,BULK:0,RULE:Spam_GS981B3D,ACTI
        ON:quarantine,TS:95
X-CID-META: VersionHash:62cd327,CLOUDID:06ef2390-1a78-4832-bd08-74b1519dcfbf,B
        ulkID:221101004015RV5CKTML,BulkQuantity:0,Recheck:0,SF:28|16|19|48,TC:nil,
        Content:0,EDM:-3,IP:nil,URL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: fbaa81e44f4845b487b617a1452d1d02-20221101
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw02.mediatek.com
        (envelope-from <shayne.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1516549315; Tue, 01 Nov 2022 00:40:13 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Tue, 1 Nov 2022 00:40:12 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Tue, 1 Nov 2022 00:40:12 +0800
From:   Shayne Chen <shayne.chen@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>
CC:     linux-wireless <linux-wireless@vger.kernel.org>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Evelyn Tsai <evelyn.tsai@mediatek.com>,
        Bo Jiao <Bo.Jiao@mediatek.com>,
        linux-mediatek <linux-mediatek@lists.infradead.org>,
        Shayne Chen <shayne.chen@mediatek.com>
Subject: [PATCH 09/10] wifi: mt76: connac: introduce helper for mt7996 chipset
Date:   Tue, 1 Nov 2022 00:39:59 +0800
Message-ID: <20221031164000.17063-10-shayne.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20221031164000.17063-1-shayne.chen@mediatek.com>
References: <20221031164000.17063-1-shayne.chen@mediatek.com>
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

Introduce is_mt7996() helper for new chipset.
This is a preliminary patch to support mt7996 driver.

Signed-off-by: Shayne Chen <shayne.chen@mediatek.com>
---
 drivers/net/wireless/mediatek/mt76/mt76_connac.h     | 5 +++++
 drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c | 3 ++-
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac.h b/drivers/net/wireless/mediatek/mt76/mt76_connac.h
index 0915eb579539..8ba883b03e50 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac.h
@@ -187,6 +187,11 @@ static inline bool is_mt7986(struct mt76_dev *dev)
 	return mt76_chip(dev) == 0x7986;
 }
 
+static inline bool is_mt7996(struct mt76_dev *dev)
+{
+	return mt76_chip(dev) == 0x7990;
+}
+
 static inline bool is_mt7622(struct mt76_dev *dev)
 {
 	if (!IS_ENABLED(CONFIG_MT7622_WMAC))
diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
index 9bba18d24c71..aa8e7f7e9b50 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
@@ -65,7 +65,8 @@ int mt76_connac_mcu_init_download(struct mt76_dev *dev, u32 addr, u32 len,
 	int cmd;
 
 	if ((!is_connac_v1(dev) && addr == MCU_PATCH_ADDRESS) ||
-	    (is_mt7921(dev) && addr == 0x900000))
+	    (is_mt7921(dev) && addr == 0x900000) ||
+	    (is_mt7996(dev) && addr == 0x900000))
 		cmd = MCU_CMD(PATCH_START_REQ);
 	else
 		cmd = MCU_CMD(TARGET_ADDRESS_LEN_REQ);
-- 
2.25.1

