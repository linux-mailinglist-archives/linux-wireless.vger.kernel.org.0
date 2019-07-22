Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 210466F8E6
	for <lists+linux-wireless@lfdr.de>; Mon, 22 Jul 2019 07:31:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727040AbfGVFbr (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 22 Jul 2019 01:31:47 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:34966 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726534AbfGVFbr (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 22 Jul 2019 01:31:47 -0400
X-UUID: bc9f8d5b77e047b2aaae20c6dd95a74f-20190722
X-UUID: bc9f8d5b77e047b2aaae20c6dd95a74f-20190722
Received: from mtkcas09.mediatek.inc [(172.21.101.178)] by mailgw01.mediatek.com
        (envelope-from <ryder.lee@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 1246995080; Mon, 22 Jul 2019 13:31:20 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Mon, 22 Jul 2019 13:31:19 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Mon, 22 Jul 2019 13:31:18 +0800
From:   Ryder Lee <ryder.lee@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>,
        Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
CC:     Roy Luo <royluo@google.com>, YF Luo <yf.luo@mediatek.com>,
        Yiwei Chung <yiwei.chung@mediatek.com>,
        Sean Wang <sean.wang@mediatek.com>,
        <linux-wireless@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        Ryder Lee <ryder.lee@mediatek.com>
Subject: [PATCH 3/5] mt76: mt7615: fix some checkpatch warnings
Date:   Mon, 22 Jul 2019 13:31:13 +0800
Message-ID: <715d14690b66a126b22b867e99230d470afac2eb.1563772403.git.ryder.lee@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <cover.1563772403.git.ryder.lee@mediatek.com>
References: <cover.1563772403.git.ryder.lee@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This fixes the following checkpatch.pl warning:
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

