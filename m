Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E35E362AE8
	for <lists+linux-wireless@lfdr.de>; Sat, 17 Apr 2021 00:16:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234898AbhDPWQz (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 16 Apr 2021 18:16:55 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:57214 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S233514AbhDPWQy (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 16 Apr 2021 18:16:54 -0400
X-UUID: 918e583601654d2aa7d2178bf8b190f4-20210417
X-UUID: 918e583601654d2aa7d2178bf8b190f4-20210417
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw02.mediatek.com
        (envelope-from <ryder.lee@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 677753483; Sat, 17 Apr 2021 06:16:24 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs08n2.mediatek.inc (172.21.101.56) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Sat, 17 Apr 2021 06:16:22 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Sat, 17 Apr 2021 06:16:22 +0800
From:   Ryder Lee <ryder.lee@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>,
        Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
CC:     Shayne Chen <shayne.chen@mediatek.com>,
        <linux-wireless@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        Ryder Lee <ryder.lee@mediatek.com>
Subject: [PATCH 3/3] mt76: mt7915: directly read per-rate tx power from registers
Date:   Sat, 17 Apr 2021 06:16:19 +0800
Message-ID: <1341b8a7123fe04b11d8ab65240c4a19e5ca43e3.1618609024.git.ryder.lee@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <6c1be8713dfd1154b5ec61b2b094eb156d9fb659.1618609024.git.ryder.lee@mediatek.com>
References: <6c1be8713dfd1154b5ec61b2b094eb156d9fb659.1618609024.git.ryder.lee@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 899A4C9C601A63917558AC33361A8FA682CB2848391D4A10DD5B88F479AEC0712000:8
X-MTK:  N
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Shayne Chen <shayne.chen@mediatek.com>

Since driver no longer handler per-rate tx power setting, we need to
read the power values directly from registers.

Tested-by: Evelyn Tsai <evelyn.tsai@mediatek.com>
Signed-off-by: Shayne Chen <shayne.chen@mediatek.com>
Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
---
 .../wireless/mediatek/mt76/mt7915/debugfs.c   | 68 +++++++++++++------
 .../net/wireless/mediatek/mt76/mt7915/regs.h  |  5 ++
 2 files changed, 51 insertions(+), 22 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c b/drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c
index 93bde072fe4d..65d44135a560 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c
@@ -311,7 +311,7 @@ mt7915_queues_read(struct seq_file *s, void *data)
 }
 
 static void
-mt7915_puts_rate_txpower(struct seq_file *s, s8 txpower_cur, int band)
+mt7915_puts_rate_txpower(struct seq_file *s, struct mt7915_phy *phy)
 {
 	static const char * const sku_group_name[] = {
 		"CCK", "OFDM", "HT20", "HT40",
@@ -319,18 +319,54 @@ mt7915_puts_rate_txpower(struct seq_file *s, s8 txpower_cur, int band)
 		"RU26", "RU52", "RU106", "RU242/SU20",
 		"RU484/SU40", "RU996/SU80", "RU2x996/SU160"
 	};
-	s8 txpower[161];
+	struct mt7915_dev *dev = dev_get_drvdata(s->private);
+	bool ext_phy = phy != &dev->phy;
+	u32 reg_base;
 	int i, idx = 0;
 
-	for (i = 0; i < ARRAY_SIZE(txpower); i++)
-		txpower[i] = DIV_ROUND_UP(txpower_cur, 2);
+	if (!phy)
+		return;
+
+	reg_base = MT_TMAC_FP0R0(ext_phy);
+	seq_printf(s, "\nBand %d\n", ext_phy);
 
 	for (i = 0; i < ARRAY_SIZE(mt7915_sku_group_len); i++) {
-		u8 len = mt7915_sku_group_len[i];
+		u8 cnt, mcs_num = mt7915_sku_group_len[i];
+		s8 txpower[12];
+		int j;
+
+		if (i == SKU_HT_BW20 || i == SKU_HT_BW40) {
+			mcs_num = 8;
+		} else if (i >= SKU_VHT_BW20 && i <= SKU_VHT_BW160) {
+			mcs_num = 10;
+		} else if (i == SKU_HE_RU26) {
+			reg_base = MT_TMAC_FP0R18(ext_phy);
+			idx = 0;
+		}
+
+		for (j = 0, cnt = 0; j < DIV_ROUND_UP(mcs_num, 4); j++) {
+			u32 val;
+
+			if (i == SKU_VHT_BW160 && idx == 60) {
+				reg_base = MT_TMAC_FP0R15(ext_phy);
+				idx = 0;
+			}
 
-		mt76_seq_puts_array(s, sku_group_name[i],
-				    txpower + idx, len);
-		idx += len;
+			val = mt76_rr(dev, reg_base + (idx / 4) * 4);
+
+			if (idx && idx % 4)
+				val >>= (idx % 4) * 8;
+
+			while (val > 0 && cnt < mcs_num) {
+				s8 pwr = FIELD_GET(MT_TMAC_FP_MASK, val);
+
+				txpower[cnt++] = pwr;
+				val >>= 8;
+				idx++;
+			}
+		}
+
+		mt76_seq_puts_array(s, sku_group_name[i], txpower, mcs_num);
 	}
 }
 
@@ -338,21 +374,9 @@ static int
 mt7915_read_rate_txpower(struct seq_file *s, void *data)
 {
 	struct mt7915_dev *dev = dev_get_drvdata(s->private);
-	struct mt76_phy *mphy = &dev->mphy;
-	enum nl80211_band band = mphy->chandef.chan->band;
-	s8 txpower = mphy->txpower_cur;
-
-	seq_puts(s, "Band 0:\n");
-	mt7915_puts_rate_txpower(s, txpower, band);
 
-	if (dev->mt76.phy2) {
-		mphy = dev->mt76.phy2;
-		band = mphy->chandef.chan->band;
-		txpower = mphy->txpower_cur;
-
-		seq_puts(s, "Band 1:\n");
-		mt7915_puts_rate_txpower(s, txpower, band);
-	}
+	mt7915_puts_rate_txpower(s, &dev->phy);
+	mt7915_puts_rate_txpower(s, mt7915_ext_phy(dev));
 
 	return 0;
 }
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/regs.h b/drivers/net/wireless/mediatek/mt76/mt7915/regs.h
index dfb8880657bf..efe0f2904c66 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/regs.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/regs.h
@@ -82,6 +82,11 @@
 #define MT_TMAC_CTCR0_INS_DDLMT_EN		BIT(17)
 #define MT_TMAC_CTCR0_INS_DDLMT_VHT_SMPDU_EN	BIT(18)
 
+#define MT_TMAC_FP0R0(_band)		MT_WF_TMAC(_band, 0x020)
+#define MT_TMAC_FP0R15(_band)		MT_WF_TMAC(_band, 0x080)
+#define MT_TMAC_FP0R18(_band)		MT_WF_TMAC(_band, 0x270)
+#define MT_TMAC_FP_MASK			GENMASK(7, 0)
+
 #define MT_TMAC_TFCR0(_band)		MT_WF_TMAC(_band, 0x1e0)
 
 #define MT_WF_DMA_BASE(_band)		((_band) ? 0xa1e00 : 0x21e00)
-- 
2.18.0

