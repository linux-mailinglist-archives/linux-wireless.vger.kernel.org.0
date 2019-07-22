Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BEE896FB99
	for <lists+linux-wireless@lfdr.de>; Mon, 22 Jul 2019 10:50:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727753AbfGVIuU (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 22 Jul 2019 04:50:20 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:12377 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725989AbfGVIuT (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 22 Jul 2019 04:50:19 -0400
X-UUID: d25003901f06453d92403987751c353f-20190722
X-UUID: d25003901f06453d92403987751c353f-20190722
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw01.mediatek.com
        (envelope-from <ryder.lee@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 1541259887; Mon, 22 Jul 2019 16:50:13 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs08n2.mediatek.inc (172.21.101.56) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Mon, 22 Jul 2019 16:50:10 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Mon, 22 Jul 2019 16:50:10 +0800
From:   Ryder Lee <ryder.lee@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>,
        Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
CC:     Roy Luo <royluo@google.com>, YF Luo <yf.luo@mediatek.com>,
        Yiwei Chung <yiwei.chung@mediatek.com>,
        Sean Wang <sean.wang@mediatek.com>,
        <linux-wireless@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        Ryder Lee <ryder.lee@mediatek.com>
Subject: [PATCH v1 2/2] mt76: mt7615: update cw_min/max related settings
Date:   Mon, 22 Jul 2019 16:50:09 +0800
Message-ID: <dd1438cdf392409179ea82bb2f32e8fcbf074057.1563779728.git.ryder.lee@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <f5c814ad88a8d959376fc77930531582eedf1a63.1563779728.git.ryder.lee@mediatek.com>
References: <f5c814ad88a8d959376fc77930531582eedf1a63.1563779728.git.ryder.lee@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 1614E78AC7BB478B9D7593A764A2A4CFE08A5FE6E9043D679098553EAAF0811B2000:8
X-MTK:  N
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Add default values of cw_min/max and use fls() for configuration.

Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
---
Changes since v1:
- Restore each WMM_* bit and add WMM_PARAM_SET.
- Use fls().
---
 .../net/wireless/mediatek/mt76/mt7615/mcu.c    | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
index 5fd162be3654..3563ddf17aad 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
@@ -626,6 +626,8 @@ int mt7615_mcu_set_wmm(struct mt7615_dev *dev, u8 queue,
 #define WMM_CW_MIN_SET	BIT(1)
 #define WMM_CW_MAX_SET	BIT(2)
 #define WMM_TXOP_SET	BIT(3)
+#define WMM_PARAM_SET	(WMM_AIFS_SET | WMM_CW_MIN_SET | \
+			 WMM_CW_MAX_SET | WMM_TXOP_SET)
 	struct req_data {
 		u8 number;
 		u8 rsv[3];
@@ -638,19 +640,17 @@ int mt7615_mcu_set_wmm(struct mt7615_dev *dev, u8 queue,
 	} __packed req = {
 		.number = 1,
 		.queue = queue,
-		.valid = WMM_AIFS_SET | WMM_TXOP_SET,
+		.valid = WMM_PARAM_SET,
 		.aifs = params->aifs,
+		.cw_min = 5,
+		.cw_max = cpu_to_le16(10),
 		.txop = cpu_to_le16(params->txop),
 	};
 
-	if (params->cw_min) {
-		req.valid |= WMM_CW_MIN_SET;
-		req.cw_min = params->cw_min;
-	}
-	if (params->cw_max) {
-		req.valid |= WMM_CW_MAX_SET;
-		req.cw_max = cpu_to_le16(params->cw_max);
-	}
+	if (params->cw_min)
+		req.cw_min = fls(params->cw_min);
+	if (params->cw_max)
+		req.cw_max = cpu_to_le16(fls(params->cw_max));
 
 	return __mt76_mcu_send_msg(&dev->mt76, MCU_EXT_CMD_EDCA_UPDATE,
 				   &req, sizeof(req), true);
-- 
2.18.0

