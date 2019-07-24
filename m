Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1253872ADB
	for <lists+linux-wireless@lfdr.de>; Wed, 24 Jul 2019 10:58:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726807AbfGXI6i (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 24 Jul 2019 04:58:38 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:13746 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726207AbfGXI6g (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 24 Jul 2019 04:58:36 -0400
X-UUID: 72f2db9026f24c9cbbe2caf28079d657-20190724
X-UUID: 72f2db9026f24c9cbbe2caf28079d657-20190724
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw02.mediatek.com
        (envelope-from <ryder.lee@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 1323067817; Wed, 24 Jul 2019 16:58:25 +0800
Received: from mtkcas09.mediatek.inc (172.21.101.178) by
 mtkmbs08n2.mediatek.inc (172.21.101.56) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Wed, 24 Jul 2019 16:58:23 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas09.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Wed, 24 Jul 2019 16:58:23 +0800
From:   Ryder Lee <ryder.lee@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>,
        Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
CC:     Roy Luo <royluo@google.com>, YF Luo <yf.luo@mediatek.com>,
        Yiwei Chung <yiwei.chung@mediatek.com>,
        Sean Wang <sean.wang@mediatek.com>,
        <linux-wireless@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Ryder Lee <ryder.lee@mediatek.com>
Subject: [PATCH v1 3/6] mt76: mt7615: fix some checkpatch warnings
Date:   Wed, 24 Jul 2019 16:58:17 +0800
Message-ID: <e1119dd3042472ffb35f31d56b524110cecbaa0d.1563944758.git.ryder.lee@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <cover.1563944758.git.ryder.lee@mediatek.com>
References: <cover.1563944758.git.ryder.lee@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 3EC1AEFA5528E089390308B69032CB2782F5E543118D9F6DE644E92C68F758212000:8
X-MTK:  N
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This fixes the following checkpatch warnings:

WARNING: Improper SPDX comment style
Fix blank lines.

Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
---
 drivers/net/wireless/mediatek/mt76/mt7615/debugfs.c | 2 +-
 drivers/net/wireless/mediatek/mt76/mt7615/mac.c     | 5 +++--
 drivers/net/wireless/mediatek/mt76/mt7615/mcu.c     | 2 --
 3 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/debugfs.c b/drivers/net/wireless/mediatek/mt76/mt7615/debugfs.c
index ed605fcc99f9..2618248946a1 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/debugfs.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/debugfs.c
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: ISC */
+// SPDX-License-Identifier: ISC
 
 #include "mt7615.h"
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mac.c b/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
index b3e8ee06a783..8f9a2bb68ded 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
@@ -508,7 +508,6 @@ void mt7615_mac_set_rates(struct mt7615_dev *dev, struct mt7615_sta *sta,
 
 			rates[i].idx--;
 		}
-
 	}
 
 	val[0] = mt7615_mac_tx_rate_val(dev, &rates[0], stbc, &bw);
@@ -586,6 +585,7 @@ void mt7615_mac_set_rates(struct mt7615_dev *dev, struct mt7615_sta *sta,
 	sta->rate_count = 2 * MT7615_RATE_RETRY * n_rates;
 	sta->wcid.tx_info |= MT_WCID_TX_INFO_SET;
 }
+
 int mt7615_tx_prepare_skb(struct mt76_dev *mdev, void *txwi_ptr,
 			  enum mt76_txq_id qid, struct mt76_wcid *wcid,
 			  struct ieee80211_sta *sta,
@@ -725,8 +725,9 @@ static bool mt7615_fill_txs(struct mt7615_dev *dev, struct mt7615_sta *sta,
 			sta->rate_probe = false;
 		}
 		spin_unlock_bh(&dev->mt76.lock);
-	} else
+	} else {
 		info->status.rates[0] = rs->rates[first_idx / 2];
+	}
 	info->status.rates[0].count = 0;
 
 	for (i = 0, idx = first_idx; count && idx <= last_idx; idx++) {
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
index e57b51290c61..5fd162be3654 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
@@ -1646,5 +1646,3 @@ int mt7615_mcu_set_rx_ba(struct mt7615_dev *dev,
 	return __mt76_mcu_send_msg(&dev->mt76, MCU_EXT_CMD_WTBL_UPDATE,
 				   &wtbl_req, sizeof(wtbl_req), true);
 }
-
-
-- 
2.18.0

