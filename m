Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DCF6320EF5
	for <lists+linux-wireless@lfdr.de>; Mon, 22 Feb 2021 02:14:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229895AbhBVBNx (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 21 Feb 2021 20:13:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:54238 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229634AbhBVBNt (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 21 Feb 2021 20:13:49 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id E7F3A64E5C;
        Mon, 22 Feb 2021 01:13:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1613956388;
        bh=2+YWDafBfhfXUs8iCDHkh2d+HT+EV6rENu1bTSmVCbE=;
        h=From:To:Cc:Subject:Date:From;
        b=dw17jBx0Jqo6KEN3Uv6XXR092xo3U4UkWPw8vlfPyyyepO+24NrdZi23IgcSx9gGD
         wT3gin3yygGcf7KBP++KKFbeT+Rhle6I8cI5dJL690kZQveNh+pMnbkpIj4D+sJwWd
         Flj1O8axXL/BiGFAjPQ5ZlTuDDnqT5r2hm1AFP/5zp/K9I62kZ6AyvQeEi3vlJ1pEM
         ZR39WpmJAg2Ig7Ddg1NtP39XZMWUQYTQCzKSBmYkbtiboRbyfjENAqTmm5ixK21hHh
         xRlRj+kB/PGHhfQk9Du5fU+sBa3w9Tgob42Ad43GzqnPuMLPwaLzri9VjiECn7KaTv
         jlmi+BbKKk5ug==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com,
        sean.wang@mediatek.com
Subject: [PATCH] mt76: mt7921: fix stats register definitions
Date:   Mon, 22 Feb 2021 02:12:50 +0100
Message-Id: <4a284bc865f528d594a1fc557c5e378adaaa0ab1.1613956219.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Fix register definitions for mac80211 stats reporting.

Fixes: 163f4d22c118d ("mt76: mt7921: add MAC support")
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 .../net/wireless/mediatek/mt76/mt7921/mac.c   | 25 +++++++++----------
 .../wireless/mediatek/mt76/mt7921/mt7921.h    | 10 ++++----
 .../net/wireless/mediatek/mt76/mt7921/regs.h  | 11 ++++----
 3 files changed, 23 insertions(+), 23 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mac.c b/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
index f1015ac3866d..e9a36bd0ce91 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
@@ -1328,22 +1328,21 @@ mt7921_mac_update_mib_stats(struct mt7921_phy *phy)
 	for (i = 0, aggr1 = aggr0 + 4; i < 4; i++) {
 		u32 val, val2;
 
-		val = mt76_rr(dev, MT_MIB_MB_SDR1(0, i));
+		val = mt76_rr(dev, MT_MIB_MB_BSDR3(0, i));
+		if (val > mib->ack_fail_cnt)
+			mib->ack_fail_cnt = val;
 
-		val2 = FIELD_GET(MT_MIB_ACK_FAIL_COUNT_MASK, val);
-		if (val2 > mib->ack_fail_cnt)
-			mib->ack_fail_cnt = val2;
+		val = mt76_rr(dev, MT_MIB_MB_BSDR2(0, i));
+		if (val > mib->ba_miss_cnt)
+			mib->ba_miss_cnt = val;
 
-		val2 = FIELD_GET(MT_MIB_BA_MISS_COUNT_MASK, val);
-		if (val2 > mib->ba_miss_cnt)
-			mib->ba_miss_cnt = val2;
+		val = mt76_rr(dev, MT_MIB_MB_BSDR0(0, i));
+		if (val > mib->rts_cnt)
+			mib->rts_cnt = val;
 
-		val = mt76_rr(dev, MT_MIB_MB_SDR0(0, i));
-		val2 = FIELD_GET(MT_MIB_RTS_RETRIES_COUNT_MASK, val);
-		if (val2 > mib->rts_retries_cnt) {
-			mib->rts_cnt = FIELD_GET(MT_MIB_RTS_COUNT_MASK, val);
-			mib->rts_retries_cnt = val2;
-		}
+		val = mt76_rr(dev, MT_MIB_MB_BSDR1(0, i));
+		if (val > mib->rts_retries_cnt)
+			mib->rts_retries_cnt = val;
 
 		val = mt76_rr(dev, MT_TX_AGG_CNT(0, i));
 		val2 = mt76_rr(dev, MT_TX_AGG_CNT2(0, i));
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h b/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
index 46e53fa00796..3931237a75a4 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
@@ -102,11 +102,11 @@ struct mt7921_vif {
 };
 
 struct mib_stats {
-	u16 ack_fail_cnt;
-	u16 fcs_err_cnt;
-	u16 rts_cnt;
-	u16 rts_retries_cnt;
-	u16 ba_miss_cnt;
+	u32 ack_fail_cnt;
+	u32 fcs_err_cnt;
+	u32 rts_cnt;
+	u32 rts_retries_cnt;
+	u32 ba_miss_cnt;
 };
 
 struct mt7921_phy {
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/regs.h b/drivers/net/wireless/mediatek/mt76/mt7921/regs.h
index d7e316eb006c..3973d2d5c360 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/regs.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/regs.h
@@ -96,8 +96,8 @@
 #define MT_WF_MIB_BASE(_band)		((_band) ? 0xa4800 : 0x24800)
 #define MT_WF_MIB(_band, ofs)		(MT_WF_MIB_BASE(_band) + (ofs))
 
-#define MT_MIB_SDR3(_band)		MT_WF_MIB(_band, 0x014)
-#define MT_MIB_SDR3_FCS_ERR_MASK	GENMASK(15, 0)
+#define MT_MIB_SDR3(_band)		MT_WF_MIB(_band, 0x698)
+#define MT_MIB_SDR3_FCS_ERR_MASK	GENMASK(31, 16)
 
 #define MT_MIB_SDR9(_band)		MT_WF_MIB(_band, 0x02c)
 #define MT_MIB_SDR9_BUSY_MASK		GENMASK(23, 0)
@@ -121,9 +121,10 @@
 #define MT_MIB_RTS_RETRIES_COUNT_MASK	GENMASK(31, 16)
 #define MT_MIB_RTS_COUNT_MASK		GENMASK(15, 0)
 
-#define MT_MIB_MB_SDR1(_band, n)	MT_WF_MIB(_band, 0x104 + ((n) << 4))
-#define MT_MIB_BA_MISS_COUNT_MASK	GENMASK(15, 0)
-#define MT_MIB_ACK_FAIL_COUNT_MASK	GENMASK(31, 16)
+#define MT_MIB_MB_BSDR0(_band, n)	MT_WF_MIB(_band, 0x688 + ((n) << 4))
+#define MT_MIB_MB_BSDR1(_band, n)	MT_WF_MIB(_band, 0x690 + ((n) << 4))
+#define MT_MIB_MB_BSDR2(_band, n)	MT_WF_MIB(_band, 0x518 + ((n) << 4))
+#define MT_MIB_MB_BSDR3(_band, n)	MT_WF_MIB(_band, 0x520 + ((n) << 4))
 
 #define MT_MIB_MB_SDR2(_band, n)	MT_WF_MIB(_band, 0x108 + ((n) << 4))
 #define MT_MIB_FRAME_RETRIES_COUNT_MASK	GENMASK(15, 0)
-- 
2.29.2

