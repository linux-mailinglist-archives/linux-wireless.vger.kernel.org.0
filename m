Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 527522FAF01
	for <lists+linux-wireless@lfdr.de>; Tue, 19 Jan 2021 04:03:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388715AbhASDCa (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 18 Jan 2021 22:02:30 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:40296 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727937AbhASDCT (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 18 Jan 2021 22:02:19 -0500
X-UUID: 13d0b2f250dc46fa9142494df41bb85c-20210119
X-UUID: 13d0b2f250dc46fa9142494df41bb85c-20210119
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw01.mediatek.com
        (envelope-from <ryder.lee@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 645040433; Tue, 19 Jan 2021 11:01:34 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs08n2.mediatek.inc (172.21.101.56) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 19 Jan 2021 11:01:25 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 19 Jan 2021 11:01:26 +0800
From:   Ryder Lee <ryder.lee@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>,
        Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
CC:     Shayne Chen <shayne.chen@mediatek.com>,
        <linux-wireless@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        Ryder Lee <ryder.lee@mediatek.com>
Subject: [PATCH v2] mt76: mt7915: support TxBF for DBDC
Date:   Tue, 19 Jan 2021 11:01:25 +0800
Message-ID: <55d4370379796672abd12baacb82ace52d594b9d.1610938153.git.ryder.lee@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 84CABABC773B09E7EBDFBA5094A23FF14B3DA54BCB7ADC49741A0C36F91E371B2000:8
X-MTK:  N
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

With this patch, TxBF can be run on both bands simultaneously.

Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
---
 .../net/wireless/mediatek/mt76/mt7915/init.c  |  7 +++++++
 .../net/wireless/mediatek/mt76/mt7915/mcu.c   | 19 +++++++++++++++++++
 .../wireless/mediatek/mt76/mt7915/mt7915.h    |  1 +
 3 files changed, 27 insertions(+)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/init.c b/drivers/net/wireless/mediatek/mt76/mt7915/init.c
index 5e21646865a6..ad4e5b95158b 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/init.c
@@ -169,6 +169,13 @@ static int mt7915_txbf_init(struct mt7915_dev *dev)
 {
 	int ret;
 
+
+	if (dev->dbdc_support) {
+		ret = mt7915_mcu_set_txbf_module(dev);
+		if (ret)
+			return ret;
+	}
+
 	/* trigger sounding packets */
 	ret = mt7915_mcu_set_txbf_sounding(dev);
 	if (ret)
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
index 6d4c5b7dfd56..b8fe34da9c77 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
@@ -3422,6 +3422,25 @@ int mt7915_mcu_set_ser(struct mt7915_dev *dev, u8 action, u8 set, u8 band)
 				 &req, sizeof(req), false);
 }
 
+int mt7915_mcu_set_txbf_module(struct mt7915_dev *dev)
+{
+#define MT_BF_MODULE_UPDATE               25
+	struct {
+		u8 action;
+		u8 bf_num;
+		u8 bf_bitmap;
+		u8 bf_sel[8];
+		u8 rsv[8];
+	} __packed req = {
+		.action = MT_BF_MODULE_UPDATE,
+		.bf_num = 2,
+		.bf_bitmap = GENMASK(1, 0),
+	};
+
+	return mt76_mcu_send_msg(&dev->mt76, MCU_EXT_CMD_TXBF_ACTION, &req,
+				 sizeof(req), true);
+}
+
 int mt7915_mcu_set_txbf_type(struct mt7915_dev *dev)
 {
 #define MT_BF_TYPE_UPDATE		20
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h b/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
index b5954bae139b..f45e88bf2626 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
@@ -341,6 +341,7 @@ int mt7915_mcu_set_pm(struct mt7915_dev *dev, int band, int enter);
 int mt7915_mcu_set_sku_en(struct mt7915_phy *phy, bool enable);
 int mt7915_mcu_set_sku(struct mt7915_phy *phy);
 int mt7915_mcu_set_txbf_type(struct mt7915_dev *dev);
+int mt7915_mcu_set_txbf_module(struct mt7915_dev *dev);
 int mt7915_mcu_set_txbf_sounding(struct mt7915_dev *dev);
 int mt7915_mcu_set_fcc5_lpn(struct mt7915_dev *dev, int val);
 int mt7915_mcu_set_pulse_th(struct mt7915_dev *dev,
-- 
2.18.0

