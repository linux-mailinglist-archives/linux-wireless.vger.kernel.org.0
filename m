Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCD653ECC1C
	for <lists+linux-wireless@lfdr.de>; Mon, 16 Aug 2021 02:34:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232173AbhHPAfZ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 15 Aug 2021 20:35:25 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:49816 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S232077AbhHPAfY (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 15 Aug 2021 20:35:24 -0400
X-UUID: be7de0a33a1c41f6a445478f93532b0c-20210816
X-UUID: be7de0a33a1c41f6a445478f93532b0c-20210816
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw02.mediatek.com
        (envelope-from <ryder.lee@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 999769505; Mon, 16 Aug 2021 08:34:49 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs05n2.mediatek.inc (172.21.101.140) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 16 Aug 2021 08:34:48 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 16 Aug 2021 08:34:48 +0800
From:   Ryder Lee <ryder.lee@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>
CC:     Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        Evelyn Tsai <evelyn.tsai@mediatek.com>,
        <linux-wireless@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        Ryder Lee <ryder.lee@mediatek.com>
Subject: [PATCH 1/3] mt76: mt7915: update mac timing settings
Date:   Mon, 16 Aug 2021 08:32:26 +0800
Message-ID: <3f393508b9ed8251f4e2408356110af092c8ad3e.1629073504.git.ryder.lee@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

1. EIFS has been divided into OFDM/CCK fields after 11ax generation.
2. For 5G/6G SIFS setting, hardware counts extra 6us for OFDM.

Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
---
 drivers/net/wireless/mediatek/mt76/mt7915/mac.c  | 14 ++++++--------
 drivers/net/wireless/mediatek/mt76/mt7915/regs.h |  5 ++++-
 2 files changed, 10 insertions(+), 9 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
index 0ed86cbf722b..1b8e37e265cb 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
@@ -1575,17 +1575,12 @@ void mt7915_mac_set_timing(struct mt7915_phy *phy)
 		  FIELD_PREP(MT_TIMEOUT_VAL_CCA, 48);
 	u32 ofdm = FIELD_PREP(MT_TIMEOUT_VAL_PLCP, 60) |
 		   FIELD_PREP(MT_TIMEOUT_VAL_CCA, 28);
-	int sifs, offset;
+	int offset;
 	bool is_5ghz = phy->mt76->chandef.chan->band == NL80211_BAND_5GHZ;
 
 	if (!test_bit(MT76_STATE_RUNNING, &phy->mt76->state))
 		return;
 
-	if (is_5ghz)
-		sifs = 16;
-	else
-		sifs = 10;
-
 	if (ext_phy) {
 		coverage_class = max_t(s16, dev->phy.coverage_class,
 				       coverage_class);
@@ -1607,11 +1602,14 @@ void mt7915_mac_set_timing(struct mt7915_phy *phy)
 	mt76_wr(dev, MT_TMAC_CDTR(ext_phy), cck + reg_offset);
 	mt76_wr(dev, MT_TMAC_ODTR(ext_phy), ofdm + reg_offset);
 	mt76_wr(dev, MT_TMAC_ICR0(ext_phy),
-		FIELD_PREP(MT_IFS_EIFS, 360) |
+		FIELD_PREP(MT_IFS_EIFS_OFDM, is_5ghz ? 84 : 78) |
 		FIELD_PREP(MT_IFS_RIFS, 2) |
-		FIELD_PREP(MT_IFS_SIFS, sifs) |
+		FIELD_PREP(MT_IFS_SIFS, 10) |
 		FIELD_PREP(MT_IFS_SLOT, phy->slottime));
 
+	mt76_wr(dev, MT_TMAC_ICR1(ext_phy),
+		FIELD_PREP(MT_IFS_EIFS_CCK, 314));
+
 	if (phy->slottime < 20 || is_5ghz)
 		val = MT7915_CFEND_RATE_DEFAULT;
 	else
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/regs.h b/drivers/net/wireless/mediatek/mt76/mt7915/regs.h
index a213b5cb82f8..91c1fb56b0ed 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/regs.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/regs.h
@@ -72,11 +72,14 @@
 #define MT_TMAC_TRCR0_I2T_CHK		GENMASK(24, 16)
 
 #define MT_TMAC_ICR0(_band)		MT_WF_TMAC(_band, 0x0a4)
-#define MT_IFS_EIFS			GENMASK(8, 0)
+#define MT_IFS_EIFS_OFDM			GENMASK(8, 0)
 #define MT_IFS_RIFS			GENMASK(14, 10)
 #define MT_IFS_SIFS			GENMASK(22, 16)
 #define MT_IFS_SLOT			GENMASK(30, 24)
 
+#define MT_TMAC_ICR1(_band)		MT_WF_TMAC(_band, 0x0b4)
+#define MT_IFS_EIFS_CCK			GENMASK(8, 0)
+
 #define MT_TMAC_CTCR0(_band)			MT_WF_TMAC(_band, 0x0f4)
 #define MT_TMAC_CTCR0_INS_DDLMT_REFTIME		GENMASK(5, 0)
 #define MT_TMAC_CTCR0_INS_DDLMT_EN		BIT(17)
-- 
2.29.2

