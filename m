Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2705B32DE45
	for <lists+linux-wireless@lfdr.de>; Fri,  5 Mar 2021 01:22:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230058AbhCEAWY (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 4 Mar 2021 19:22:24 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:53041 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S230135AbhCEAWU (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 4 Mar 2021 19:22:20 -0500
X-UUID: dfc1fef1f77d4d6387074c55aa30bc8b-20210305
X-UUID: dfc1fef1f77d4d6387074c55aa30bc8b-20210305
Received: from mtkmrs01.mediatek.inc [(172.21.131.159)] by mailgw01.mediatek.com
        (envelope-from <ryder.lee@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 2087061753; Fri, 05 Mar 2021 08:22:16 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs06n1.mediatek.inc (172.21.101.129) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 5 Mar 2021 08:22:15 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 5 Mar 2021 08:22:15 +0800
From:   Ryder Lee <ryder.lee@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>,
        Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
CC:     Shayne Chen <shayne.chen@mediatek.com>,
        <linux-wireless@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        Ryder Lee <ryder.lee@mediatek.com>
Subject: [PATCH v5] mt76: mt7615: add missing capabilities for DBDC
Date:   Fri, 5 Mar 2021 08:22:14 +0800
Message-ID: <58c50d543644554898894b90538c392bf672f851.1614901979.git.ryder.lee@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This improves performance for second phy.

Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
---
change since v5 - drop cap.has_* checks to fix order issue.
change since v4 - fix init order.
change since v3 - none.
change since v2 - adjust setup sequence.
---
 drivers/net/wireless/mediatek/mt76/mt7615/init.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/init.c b/drivers/net/wireless/mediatek/mt76/mt7615/init.c
index 88a2ee7e7143..c59043195870 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/init.c
@@ -368,6 +368,11 @@ mt7615_init_wiphy(struct ieee80211_hw *hw)
 		hw->max_tx_fragments = MT_TXP_MAX_BUF_NUM;
 	else
 		hw->max_tx_fragments = MT_HW_TXP_MAX_BUF_NUM;
+
+	phy->mt76->sband_2g.sband.ht_cap.cap |= IEEE80211_HT_CAP_LDPC_CODING;
+	phy->mt76->sband_5g.sband.ht_cap.cap |= IEEE80211_HT_CAP_LDPC_CODING;
+	phy->mt76->sband_5g.sband.vht_cap.cap |=
+			IEEE80211_VHT_CAP_MAX_A_MPDU_LENGTH_EXPONENT_MASK;
 }
 
 static void
@@ -505,10 +510,6 @@ void mt7615_init_device(struct mt7615_dev *dev)
 
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

