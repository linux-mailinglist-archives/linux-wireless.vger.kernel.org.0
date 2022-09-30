Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65ADB5F0D35
	for <lists+linux-wireless@lfdr.de>; Fri, 30 Sep 2022 16:15:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231793AbiI3OPT (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 30 Sep 2022 10:15:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231776AbiI3OPR (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 30 Sep 2022 10:15:17 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B89C3AD997
        for <linux-wireless@vger.kernel.org>; Fri, 30 Sep 2022 07:15:08 -0700 (PDT)
X-UUID: 6b2f15dd03e4428a976a5f3cdcdd5790-20220930
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=N0vI1OqZfdfsJZl6IwWDIAz3rwTaNgNrLU6ZaDRJutQ=;
        b=q7uOL9vQCzFY3YaVJtGViPsRo74z0VW2KFaxL5aop9Ls+Mc5OE1TiYxJLV/S1bP6a/fr7hLvHdgqUikQv+DH0wiM6LtYF2Y41xI52Ca1iwwTvP3AnYlRbhc3YaM831+bXalQ7CcjmIARWIjFyOOYvBSM8c9uUCGBYAYqiTXd6ec=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.11,REQID:dfee1097-d4e8-465f-bee5-2bc405feacf0,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:39a5ff1,CLOUDID:3f6bcce4-87f9-4bb0-97b6-34957dc0fbbe,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: 6b2f15dd03e4428a976a5f3cdcdd5790-20220930
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by mailgw01.mediatek.com
        (envelope-from <shayne.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1873167069; Fri, 30 Sep 2022 22:15:03 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Fri, 30 Sep 2022 22:15:02 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Fri, 30 Sep 2022 22:15:02 +0800
From:   Shayne Chen <shayne.chen@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>
CC:     linux-wireless <linux-wireless@vger.kernel.org>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Evelyn Tsai <evelyn.tsai@mediatek.com>,
        linux-mediatek <linux-mediatek@lists.infradead.org>,
        Shayne Chen <shayne.chen@mediatek.com>
Subject: [PATCH] wifi: mt76: mt7915: reserve 8 bits for the index of rf registers
Date:   Fri, 30 Sep 2022 22:14:41 +0800
Message-ID: <20220930141441.16314-1-shayne.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        T_SPF_TEMPERROR,UNPARSEABLE_RELAY,URIBL_CSS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Evelyn Tsai <evelyn.tsai@mediatek.com>

The value of regidx of rf registers is combined with WF selection and
offset. Extend the WF selection field from 4 to 8 bits since the
adie index should also be specified.

Signed-off-by: Evelyn Tsai <evelyn.tsai@mediatek.com>
Signed-off-by: Shayne Chen <shayne.chen@mediatek.com>
---
 drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c | 2 +-
 drivers/net/wireless/mediatek/mt76/mt7915/mcu.c     | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c b/drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c
index 6ef3431cad64..e1d15394a621 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c
@@ -963,7 +963,7 @@ mt7915_twt_stats(struct seq_file *s, void *data)
 }
 
 /* The index of RF registers use the generic regidx, combined with two parts:
- * WF selection [31:28] and offset [27:0].
+ * WF selection [31:24] and offset [23:0].
  */
 static int
 mt7915_rf_regval_get(void *data, u64 *val)
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
index 8d297e4aa7d4..1b9f3da8ae96 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
@@ -3447,8 +3447,8 @@ int mt7915_mcu_rf_regval(struct mt7915_dev *dev, u32 regidx, u32 *val, bool set)
 		__le32 ofs;
 		__le32 data;
 	} __packed req = {
-		.idx = cpu_to_le32(u32_get_bits(regidx, GENMASK(31, 28))),
-		.ofs = cpu_to_le32(u32_get_bits(regidx, GENMASK(27, 0))),
+		.idx = cpu_to_le32(u32_get_bits(regidx, GENMASK(31, 24))),
+		.ofs = cpu_to_le32(u32_get_bits(regidx, GENMASK(23, 0))),
 		.data = set ? cpu_to_le32(*val) : 0,
 	};
 	struct sk_buff *skb;
-- 
2.25.1

