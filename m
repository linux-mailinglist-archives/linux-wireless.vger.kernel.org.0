Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E9AE36E13C
	for <lists+linux-wireless@lfdr.de>; Fri, 19 Jul 2019 08:56:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726320AbfGSGzq (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 19 Jul 2019 02:55:46 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:29417 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725616AbfGSGzq (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 19 Jul 2019 02:55:46 -0400
X-UUID: af31ce153ea848c1bc425f9b6cf813ef-20190719
X-UUID: af31ce153ea848c1bc425f9b6cf813ef-20190719
Received: from mtkmrs01.mediatek.inc [(172.21.131.159)] by mailgw01.mediatek.com
        (envelope-from <ryder.lee@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 1331009977; Fri, 19 Jul 2019 14:55:39 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs08n1.mediatek.inc (172.21.101.55) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Fri, 19 Jul 2019 14:55:38 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Fri, 19 Jul 2019 14:55:38 +0800
From:   Ryder Lee <ryder.lee@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>,
        Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
CC:     Roy Luo <royluo@google.com>, YF Luo <yf.luo@mediatek.com>,
        Yiwei Chung <yiwei.chung@mediatek.com>,
        Sean Wang <sean.wang@mediatek.com>,
        <linux-wireless@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Ryder Lee <ryder.lee@mediatek.com>
Subject: [PATCH 3/3] mt76: mt7615: add cwmin/cwmax initial values
Date:   Fri, 19 Jul 2019 14:55:36 +0800
Message-ID: <c83e14787bc86f8f8062e0aa44e03ef80c3fd38a.1563518381.git.ryder.lee@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <50d28c9b0f9e7d6b277d36fc93f55142d7535259.1563518381.git.ryder.lee@mediatek.com>
References: <50d28c9b0f9e7d6b277d36fc93f55142d7535259.1563518381.git.ryder.lee@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Add initial values in mt7615_mcu_set_wmm() to cleanup setup flow.

Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
---
 drivers/net/wireless/mediatek/mt76/mt7615/mcu.c | 17 ++++++-----------
 1 file changed, 6 insertions(+), 11 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
index 5fd162be3654..154c09428b69 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
@@ -622,10 +622,7 @@ int mt7615_mcu_set_rts_thresh(struct mt7615_dev *dev, u32 val)
 int mt7615_mcu_set_wmm(struct mt7615_dev *dev, u8 queue,
 		       const struct ieee80211_tx_queue_params *params)
 {
-#define WMM_AIFS_SET	BIT(0)
-#define WMM_CW_MIN_SET	BIT(1)
-#define WMM_CW_MAX_SET	BIT(2)
-#define WMM_TXOP_SET	BIT(3)
+#define WMM_PARAM_SET	GENMASK(3, 0)
 	struct req_data {
 		u8 number;
 		u8 rsv[3];
@@ -638,19 +635,17 @@ int mt7615_mcu_set_wmm(struct mt7615_dev *dev, u8 queue,
 	} __packed req = {
 		.number = 1,
 		.queue = queue,
-		.valid = WMM_AIFS_SET | WMM_TXOP_SET,
+		.valid = WMM_PARAM_SET,
 		.aifs = params->aifs,
+		.cw_min = BIT(5) - 1,
+		.cw_max = cpu_to_le16(BIT(10) - 1),
 		.txop = cpu_to_le16(params->txop),
 	};
 
-	if (params->cw_min) {
-		req.valid |= WMM_CW_MIN_SET;
+	if (params->cw_min)
 		req.cw_min = params->cw_min;
-	}
-	if (params->cw_max) {
-		req.valid |= WMM_CW_MAX_SET;
+	if (params->cw_max)
 		req.cw_max = cpu_to_le16(params->cw_max);
-	}
 
 	return __mt76_mcu_send_msg(&dev->mt76, MCU_EXT_CMD_EDCA_UPDATE,
 				   &req, sizeof(req), true);
-- 
2.18.0

