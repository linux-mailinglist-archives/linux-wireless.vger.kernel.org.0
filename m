Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A2BE324AAE
	for <lists+linux-wireless@lfdr.de>; Thu, 25 Feb 2021 07:59:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232982AbhBYG4m (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 25 Feb 2021 01:56:42 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:36820 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S232429AbhBYG4k (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 25 Feb 2021 01:56:40 -0500
X-UUID: cd16b42e45084b0396e63f7a149c83bc-20210225
X-UUID: cd16b42e45084b0396e63f7a149c83bc-20210225
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw02.mediatek.com
        (envelope-from <ryder.lee@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1416992479; Thu, 25 Feb 2021 14:55:51 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs06n2.mediatek.inc (172.21.101.130) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 25 Feb 2021 14:55:50 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 25 Feb 2021 14:55:50 +0800
From:   Ryder Lee <ryder.lee@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>,
        Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
CC:     Shayne Chen <shayne.chen@mediatek.com>,
        <linux-wireless@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        Ryder Lee <ryder.lee@mediatek.com>
Subject: [PATCH 2/2] mt76: mt7615: add missing capabilities for DBDC
Date:   Thu, 25 Feb 2021 14:55:48 +0800
Message-ID: <6db470fc868e6215f969690ce04d50a595d7fe4c.1614235992.git.ryder.lee@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <fe9afbb21ade32aac31f077bb1e741f917bd4596.1614235992.git.ryder.lee@mediatek.com>
References: <fe9afbb21ade32aac31f077bb1e741f917bd4596.1614235992.git.ryder.lee@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: B9272D57C3D5D59240B9C754354933433CC29B38BD304882B8575962BEFA927B2000:8
X-MTK:  N
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Same as mt7915, this should improve performance.

Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
---
 drivers/net/wireless/mediatek/mt76/mt7615/init.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/init.c b/drivers/net/wireless/mediatek/mt76/mt7615/init.c
index 88a2ee7e7143..fced902d11bc 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/init.c
@@ -368,6 +368,17 @@ mt7615_init_wiphy(struct ieee80211_hw *hw)
 		hw->max_tx_fragments = MT_TXP_MAX_BUF_NUM;
 	else
 		hw->max_tx_fragments = MT_HW_TXP_MAX_BUF_NUM;
+
+	if (phy->mt76->cap.has_2ghz)
+		phy->mt76->sband_2g.sband.ht_cap.cap |=
+			IEEE80211_HT_CAP_LDPC_CODING;
+
+	if (phy->mt76->cap.has_5ghz) {
+		phy->mt76->sband_5g.sband.ht_cap.cap |=
+			IEEE80211_HT_CAP_LDPC_CODING;
+		phy->mt76->sband_5g.sband.vht_cap.cap |=
+			IEEE80211_VHT_CAP_MAX_A_MPDU_LENGTH_EXPONENT_MASK;
+	}
 }
 
 static void
@@ -505,10 +516,6 @@ void mt7615_init_device(struct mt7615_dev *dev)
 
 	mt7615_init_wiphy(hw);
 	dev->pm.idle_timeout = MT7615_PM_TIMEOUT;
-	dev->mphy.sband_2g.sband.ht_cap.cap |= IEEE80211_HT_CAP_LDPC_CODING;
-	dev->mphy.sband_5g.sband.ht_cap.cap |= IEEE80211_HT_CAP_LDPC_CODING;
-	dev->mphy.sband_5g.sband.vht_cap.cap |=
-			IEEE80211_VHT_CAP_MAX_A_MPDU_LENGTH_EXPONENT_MASK;
 	mt7615_cap_dbdc_disable(dev);
 	dev->phy.dfs_state = -1;
 
-- 
2.18.0

