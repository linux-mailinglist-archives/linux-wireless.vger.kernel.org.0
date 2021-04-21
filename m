Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73DBD36671B
	for <lists+linux-wireless@lfdr.de>; Wed, 21 Apr 2021 10:40:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236149AbhDUIk6 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 21 Apr 2021 04:40:58 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:41456 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S231354AbhDUIk6 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 21 Apr 2021 04:40:58 -0400
X-UUID: 2fadfe9f4ef04bb49288ae9e3bd9ed95-20210421
X-UUID: 2fadfe9f4ef04bb49288ae9e3bd9ed95-20210421
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw02.mediatek.com
        (envelope-from <shayne.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 714931352; Wed, 21 Apr 2021 16:40:21 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs06n2.mediatek.inc (172.21.101.130) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 21 Apr 2021 16:40:18 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 21 Apr 2021 16:40:18 +0800
From:   Shayne Chen <shayne.chen@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>
CC:     linux-wireless <linux-wireless@vger.kernel.org>,
        Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        linux-mediatek <linux-mediatek@lists.infradead.org>,
        Shayne Chen <shayne.chen@mediatek.com>
Subject: [PATCH] mt76: mt7915: do not read rf value from efuse in flash mode
Date:   Wed, 21 Apr 2021 16:39:45 +0800
Message-ID: <20210421083945.10337-1-shayne.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 9CB6740FDC6112994172C00188E65583B1497F58073ABDC406148BBFC99349012000:8
X-MTK:  N
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Do not read rf value from efuse when driver is configured to
use flash mode.

Tested-by: Bruce Chuang <bruce-ss.chuang@mediatek.com>
Signed-off-by: Shayne Chen <shayne.chen@mediatek.com>
---
 drivers/net/wireless/mediatek/mt76/mt7915/eeprom.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/eeprom.c b/drivers/net/wireless/mediatek/mt76/mt7915/eeprom.c
index 738ecf8..e004e51 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/eeprom.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/eeprom.c
@@ -8,7 +8,7 @@ static u32 mt7915_eeprom_read(struct mt7915_dev *dev, u32 offset)
 {
 	u8 *data = dev->mt76.eeprom.data;
 
-	if (data[offset] == 0xff)
+	if (data[offset] == 0xff && !dev->flash_mode)
 		mt7915_mcu_get_eeprom(dev, offset);
 
 	return data[offset];
-- 
2.18.0

