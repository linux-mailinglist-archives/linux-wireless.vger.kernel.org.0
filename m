Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B55573B3ACD
	for <lists+linux-wireless@lfdr.de>; Fri, 25 Jun 2021 04:21:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232966AbhFYCQZ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 24 Jun 2021 22:16:25 -0400
Received: from mailgw01.mediatek.com ([60.244.123.138]:50074 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S232917AbhFYCQY (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 24 Jun 2021 22:16:24 -0400
X-UUID: 920f182bad42481693b4644af74b2946-20210625
X-UUID: 920f182bad42481693b4644af74b2946-20210625
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw01.mediatek.com
        (envelope-from <shayne.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1553465030; Fri, 25 Jun 2021 10:14:02 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs06n1.mediatek.inc (172.21.101.129) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 25 Jun 2021 10:14:01 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 25 Jun 2021 10:14:01 +0800
From:   Shayne Chen <shayne.chen@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>
CC:     linux-wireless <linux-wireless@vger.kernel.org>,
        Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Evelyn Tsai <evelyn.tsai@mediatek.com>,
        linux-mediatek <linux-mediatek@lists.infradead.org>,
        Shayne Chen <shayne.chen@mediatek.com>,
        Bo Jiao <bo.jiao@mediatek.com>
Subject: [PATCH] mt76: mt7915: fix potential overflow of eeprom page index
Date:   Fri, 25 Jun 2021 10:12:21 +0800
Message-ID: <20210625021221.10171-1-shayne.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

If total eeprom size is divisible by per-page size, the i in for loop
will exceed max page index, which happens in our newer chipset.

Fixes: 26f18380e6ca ("mt76: mt7915: add support for flash mode")
Signed-off-by: Bo Jiao <bo.jiao@mediatek.com>
Signed-off-by: Shayne Chen <shayne.chen@mediatek.com>
---
 drivers/net/wireless/mediatek/mt76/mt7915/mcu.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
index c4e3ac2..0509953 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
@@ -3392,20 +3392,20 @@ int mt7915_mcu_set_chan_info(struct mt7915_phy *phy, int cmd)
 
 static int mt7915_mcu_set_eeprom_flash(struct mt7915_dev *dev)
 {
-#define TOTAL_PAGE_MASK		GENMASK(7, 5)
+#define MAX_PAGE_IDX_MASK	GENMASK(7, 5)
 #define PAGE_IDX_MASK		GENMASK(4, 2)
 #define PER_PAGE_SIZE		0x400
 	struct mt7915_mcu_eeprom req = { .buffer_mode = EE_MODE_BUFFER };
-	u8 total = MT7915_EEPROM_SIZE / PER_PAGE_SIZE;
+	u8 total = DIV_ROUND_UP(MT7915_EEPROM_SIZE, PER_PAGE_SIZE);
 	u8 *eep = (u8 *)dev->mt76.eeprom.data;
 	int eep_len;
 	int i;
 
-	for (i = 0; i <= total; i++, eep += eep_len) {
+	for (i = 0; i < total; i++, eep += eep_len) {
 		struct sk_buff *skb;
 		int ret;
 
-		if (i == total)
+		if (i == total - 1 && MT7915_EEPROM_SIZE % PER_PAGE_SIZE)
 			eep_len = MT7915_EEPROM_SIZE % PER_PAGE_SIZE;
 		else
 			eep_len = PER_PAGE_SIZE;
@@ -3415,7 +3415,7 @@ static int mt7915_mcu_set_eeprom_flash(struct mt7915_dev *dev)
 		if (!skb)
 			return -ENOMEM;
 
-		req.format = FIELD_PREP(TOTAL_PAGE_MASK, total) |
+		req.format = FIELD_PREP(MAX_PAGE_IDX_MASK, total - 1) |
 			     FIELD_PREP(PAGE_IDX_MASK, i) | EE_FORMAT_WHOLE;
 		req.len = cpu_to_le16(eep_len);
 
-- 
2.18.0

