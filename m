Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDAF9446245
	for <lists+linux-wireless@lfdr.de>; Fri,  5 Nov 2021 11:37:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229740AbhKEKkU (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 5 Nov 2021 06:40:20 -0400
Received: from mailgw01.mediatek.com ([60.244.123.138]:51790 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S229471AbhKEKkT (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 5 Nov 2021 06:40:19 -0400
X-UUID: 139036895c274dec9fb10600b7920767-20211105
X-UUID: 139036895c274dec9fb10600b7920767-20211105
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw01.mediatek.com
        (envelope-from <shayne.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1270331354; Fri, 05 Nov 2021 18:37:36 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Fri, 5 Nov 2021 18:37:35 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs10n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Fri, 5 Nov 2021 18:37:35 +0800
From:   Shayne Chen <shayne.chen@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>
CC:     linux-wireless <linux-wireless@vger.kernel.org>,
        Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        "Evelyn Tsai" <evelyn.tsai@mediatek.com>,
        linux-mediatek <linux-mediatek@lists.infradead.org>,
        Shayne Chen <shayne.chen@mediatek.com>
Subject: [PATCH v2] mt76: mt7915: fix return condition in mt7915_tm_reg_backup_restore()
Date:   Fri, 5 Nov 2021 18:37:26 +0800
Message-ID: <20211105103726.4979-1-shayne.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Fix the issue that some registers not configured properly after
restarting testmode.
(e.g. change state from idle to off, and off to idle)

Signed-off-by: Shayne Chen <shayne.chen@mediatek.com>
---
v2: only need to backup once
---
 .../wireless/mediatek/mt76/mt7915/testmode.c    | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/testmode.c b/drivers/net/wireless/mediatek/mt76/mt7915/testmode.c
index 89aae32..af80c2c 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/testmode.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/testmode.c
@@ -361,16 +361,15 @@ mt7915_tm_reg_backup_restore(struct mt7915_phy *phy)
 		return;
 	}
 
-	if (b)
-		return;
-
-	b = devm_kzalloc(dev->mt76.dev, 4 * n_regs, GFP_KERNEL);
-	if (!b)
-		return;
+	if (!b) {
+		b = devm_kzalloc(dev->mt76.dev, 4 * n_regs, GFP_KERNEL);
+		if (!b)
+			return;
 
-	phy->test.reg_backup = b;
-	for (i = 0; i < n_regs; i++)
-		b[i] = mt76_rr(dev, reg_backup_list[i].band[ext_phy]);
+		phy->test.reg_backup = b;
+		for (i = 0; i < n_regs; i++)
+			b[i] = mt76_rr(dev, reg_backup_list[i].band[ext_phy]);
+	}
 
 	mt76_clear(dev, MT_AGG_PCR0(ext_phy, 0), MT_AGG_PCR0_MM_PROT |
 		   MT_AGG_PCR0_GF_PROT | MT_AGG_PCR0_ERP_PROT |
-- 
2.25.1

