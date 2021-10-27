Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2958B43C627
	for <lists+linux-wireless@lfdr.de>; Wed, 27 Oct 2021 11:09:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241172AbhJ0JMO (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 27 Oct 2021 05:12:14 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:58956 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S241174AbhJ0JMM (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 27 Oct 2021 05:12:12 -0400
X-UUID: 688695a60465428c9315cb29f9511f4e-20211027
X-UUID: 688695a60465428c9315cb29f9511f4e-20211027
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw02.mediatek.com
        (envelope-from <bo.jiao@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1071637633; Wed, 27 Oct 2021 17:09:43 +0800
Received: from MTKMBS34N1.mediatek.inc (172.27.4.172) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Wed, 27 Oct 2021 17:09:42 +0800
Received: from MTKCAS32.mediatek.inc (172.27.4.184) by MTKMBS34N1.mediatek.inc
 (172.27.4.172) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 27 Oct
 2021 16:40:37 +0800
Received: from mcddlt001.gcn.mediatek.inc (10.19.240.15) by
 MTKCAS32.mediatek.inc (172.27.4.170) with Microsoft SMTP Server id
 15.0.1497.2 via Frontend Transport; Wed, 27 Oct 2021 16:40:37 +0800
From:   Bo Jiao <bo.jiao@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>
CC:     linux-wireless <linux-wireless@vger.kernel.org>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Xing Song <xing.song@mediatek.com>,
        Sujuan Chen <sujuan.chen@mediatek.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        "Evelyn Tsai" <evelyn.tsai@mediatek.com>,
        linux-mediatek <linux-mediatek@lists.infradead.org>,
        Bo Jiao <Bo.Jiao@mediatek.com>
Subject: [PATCH 09/11] mt76: mt7915: update mt7915_chan_mib_offs for mt7916
Date:   Wed, 27 Oct 2021 16:40:17 +0800
Message-ID: <175d571e0c16287c1d7b57d60340497a8cfb2ddb.1635323366.git.Bo.Jiao@mediatek.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <cover.1635323366.git.Bo.Jiao@mediatek.com>
References: <cover.1635323366.git.Bo.Jiao@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Bo Jiao <Bo.Jiao@mediatek.com>

Update v2 offset. This is an intermediate patch to add mt7916 support.

Co-developed-by: Sujuan Chen <sujuan.chen@mediatek.com>
Signed-off-by: Sujuan Chen <sujuan.chen@mediatek.com>
Co-developed-by: Ryder Lee <ryder.lee@mediatek.com>
Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
Signed-off-by: Bo Jiao <Bo.Jiao@mediatek.com>
---
 drivers/net/wireless/mediatek/mt76/mt7915/mcu.c | 13 +++++++++----
 drivers/net/wireless/mediatek/mt76/mt7915/mcu.h |  8 +++++++-
 2 files changed, 16 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
index b60b4b2..dcd8939 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
@@ -3794,19 +3794,24 @@ int mt7915_mcu_apply_tx_dpd(struct mt7915_phy *phy)
 int mt7915_mcu_get_chan_mib_info(struct mt7915_phy *phy, bool chan_switch)
 {
 	/* strict order */
-	static const enum mt7915_chan_mib_offs offs[] = {
-		MIB_BUSY_TIME, MIB_TX_TIME, MIB_RX_TIME, MIB_OBSS_AIRTIME
+	static const u32 offs[] = {
+		MIB_BUSY_TIME, MIB_TX_TIME, MIB_RX_TIME, MIB_OBSS_AIRTIME,
+		MIB_BUSY_TIME_V2, MIB_TX_TIME_V2, MIB_RX_TIME_V2,
+		MIB_OBSS_AIRTIME_V2
 	};
 	struct mt76_channel_state *state = phy->mt76->chan_state;
 	struct mt76_channel_state *state_ts = &phy->state_ts;
 	struct mt7915_dev *dev = phy->dev;
 	struct mt7915_mcu_mib *res, req[4];
 	struct sk_buff *skb;
-	int i, ret;
+	int i, ret, start = 0;
+
+	if (!is_mt7915(&dev->mt76))
+		start = 4;
 
 	for (i = 0; i < 4; i++) {
 		req[i].band = cpu_to_le32(phy != &dev->phy);
-		req[i].offs = cpu_to_le32(offs[i]);
+		req[i].offs = cpu_to_le32(offs[i + start]);
 	}
 
 	ret = mt76_mcu_send_and_get_msg(&dev->mt76, MCU_EXT_CMD(GET_MIB_INFO),
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.h b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.h
index e9f39ed..22b0e85 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.h
@@ -182,10 +182,16 @@ struct mt7915_mcu_mib {
 } __packed;
 
 enum mt7915_chan_mib_offs {
+	/* mt7915 */
 	MIB_BUSY_TIME = 14,
 	MIB_TX_TIME = 81,
 	MIB_RX_TIME,
-	MIB_OBSS_AIRTIME = 86
+	MIB_OBSS_AIRTIME = 86,
+	/* mt7916 */
+	MIB_BUSY_TIME_V2 = 0,
+	MIB_TX_TIME_V2 = 6,
+	MIB_RX_TIME_V2 = 8,
+	MIB_OBSS_AIRTIME_V2 = 490
 };
 
 struct edca {
-- 
2.18.0

