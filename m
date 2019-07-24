Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7F4AC72AD6
	for <lists+linux-wireless@lfdr.de>; Wed, 24 Jul 2019 10:58:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726300AbfGXI63 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 24 Jul 2019 04:58:29 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:22342 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725999AbfGXI63 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 24 Jul 2019 04:58:29 -0400
X-UUID: f6a6ca004bcc44e3ad3a0567367f55b7-20190724
X-UUID: f6a6ca004bcc44e3ad3a0567367f55b7-20190724
Received: from mtkmrs01.mediatek.inc [(172.21.131.159)] by mailgw01.mediatek.com
        (envelope-from <ryder.lee@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 1920702467; Wed, 24 Jul 2019 16:58:25 +0800
Received: from mtkcas09.mediatek.inc (172.21.101.178) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
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
Subject: [PATCH v1 2/6] mt76: mt7603: fix some checkpatch warnings
Date:   Wed, 24 Jul 2019 16:58:16 +0800
Message-ID: <5e7d187a7dfa55ceb58ea721596865e0d529c4ee.1563944758.git.ryder.lee@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <cover.1563944758.git.ryder.lee@mediatek.com>
References: <cover.1563944758.git.ryder.lee@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This fixes the following checkpatch warnings:

WARNING: Improper SPDX comment style
CHECK: No space is necessary after a cast

Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
---
 drivers/net/wireless/mediatek/mt76/mt7603/beacon.c  | 2 +-
 drivers/net/wireless/mediatek/mt76/mt7603/core.c    | 2 +-
 drivers/net/wireless/mediatek/mt76/mt7603/debugfs.c | 2 +-
 drivers/net/wireless/mediatek/mt76/mt7603/dma.c     | 7 ++++---
 drivers/net/wireless/mediatek/mt76/mt7603/eeprom.c  | 2 +-
 drivers/net/wireless/mediatek/mt76/mt7603/init.c    | 3 +--
 drivers/net/wireless/mediatek/mt76/mt7603/mac.c     | 6 +++---
 drivers/net/wireless/mediatek/mt76/mt7603/main.c    | 7 ++++---
 drivers/net/wireless/mediatek/mt76/mt7603/mcu.c     | 2 +-
 drivers/net/wireless/mediatek/mt76/mt7603/pci.c     | 2 +-
 drivers/net/wireless/mediatek/mt76/mt7603/soc.c     | 2 +-
 11 files changed, 19 insertions(+), 18 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7603/beacon.c b/drivers/net/wireless/mediatek/mt76/mt7603/beacon.c
index 58e68fbdbf75..7a41cdf1c4ae 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7603/beacon.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7603/beacon.c
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: ISC */
+// SPDX-License-Identifier: ISC
 
 #include "mt7603.h"
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7603/core.c b/drivers/net/wireless/mediatek/mt76/mt7603/core.c
index e7ee58e3379c..e5af4f3389cc 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7603/core.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7603/core.c
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: ISC */
+// SPDX-License-Identifier: ISC
 
 #include "mt7603.h"
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7603/debugfs.c b/drivers/net/wireless/mediatek/mt76/mt7603/debugfs.c
index a1bc3103cbe9..5942fe76c6e9 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7603/debugfs.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7603/debugfs.c
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: ISC */
+// SPDX-License-Identifier: ISC
 
 #include "mt7603.h"
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7603/dma.c b/drivers/net/wireless/mediatek/mt76/mt7603/dma.c
index 58dc511f93c5..79dc3b97dfe8 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7603/dma.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7603/dma.c
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: ISC */
+// SPDX-License-Identifier: ISC
 
 #include "mt7603.h"
 #include "mac.h"
@@ -63,7 +63,7 @@ mt7603_rx_loopback_skb(struct mt7603_dev *dev, struct sk_buff *skb)
 	txd[0] = cpu_to_le32(val);
 
 	sta = container_of(priv, struct ieee80211_sta, drv_priv);
-	hdr = (struct ieee80211_hdr *) &skb->data[MT_TXD_SIZE];
+	hdr = (struct ieee80211_hdr *)&skb->data[MT_TXD_SIZE];
 	tid = *ieee80211_get_qos_ctl(hdr) & IEEE80211_QOS_CTL_TID_MASK;
 	ieee80211_sta_set_buffered(sta, tid, true);
 
@@ -181,7 +181,8 @@ int mt7603_dma_init(struct mt7603_dev *dev)
 	init_waitqueue_head(&dev->mt76.mmio.mcu.wait);
 	skb_queue_head_init(&dev->mt76.mmio.mcu.res_q);
 
-	tasklet_init(&dev->mt76.tx_tasklet, mt7603_tx_tasklet, (unsigned long)dev);
+	tasklet_init(&dev->mt76.tx_tasklet, mt7603_tx_tasklet,
+		     (unsigned long)dev);
 
 	mt76_clear(dev, MT_WPDMA_GLO_CFG,
 		   MT_WPDMA_GLO_CFG_TX_DMA_EN |
diff --git a/drivers/net/wireless/mediatek/mt76/mt7603/eeprom.c b/drivers/net/wireless/mediatek/mt76/mt7603/eeprom.c
index 8c120e4461b0..2b6a4d8a8dc7 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7603/eeprom.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7603/eeprom.c
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: ISC */
+// SPDX-License-Identifier: ISC
 
 #include "mt7603.h"
 #include "eeprom.h"
diff --git a/drivers/net/wireless/mediatek/mt76/mt7603/init.c b/drivers/net/wireless/mediatek/mt76/mt7603/init.c
index 568e57e1d69c..ad2ccdbe7258 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7603/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7603/init.c
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: ISC */
+// SPDX-License-Identifier: ISC
 
 #include <linux/etherdevice.h>
 #include "mt7603.h"
@@ -506,7 +506,6 @@ mt7603_init_txpower(struct mt7603_dev *dev,
 	}
 }
 
-
 int mt7603_register_device(struct mt7603_dev *dev)
 {
 	struct mt76_bus_ops *bus_ops;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7603/mac.c b/drivers/net/wireless/mediatek/mt76/mt7603/mac.c
index 81fb4276e742..a532676a1175 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7603/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7603/mac.c
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: ISC */
+// SPDX-License-Identifier: ISC
 
 #include <linux/etherdevice.h>
 #include <linux/timekeeping.h>
@@ -644,7 +644,6 @@ void mt7603_wtbl_set_rates(struct mt7603_dev *dev, struct mt7603_sta *sta,
 
 			rates[i].idx--;
 		}
-
 	}
 
 	w9 &= MT_WTBL2_W9_SHORT_GI_20 | MT_WTBL2_W9_SHORT_GI_40 |
@@ -1017,8 +1016,9 @@ mt7603_fill_txs(struct mt7603_dev *dev, struct mt7603_sta *sta,
 			sta->rate_probe = false;
 		}
 		spin_unlock_bh(&dev->mt76.lock);
-	} else
+	} else {
 		info->status.rates[0] = rs->rates[first_idx / 2];
+	}
 	info->status.rates[0].count = 0;
 
 	for (i = 0, idx = first_idx; count && idx <= last_idx; idx++) {
diff --git a/drivers/net/wireless/mediatek/mt76/mt7603/main.c b/drivers/net/wireless/mediatek/mt76/mt7603/main.c
index d70f42dac923..34dd05a36de9 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7603/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7603/main.c
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: ISC */
+// SPDX-License-Identifier: ISC
 
 #include <linux/etherdevice.h>
 #include <linux/platform_device.h>
@@ -399,7 +399,7 @@ mt7603_ps_set_more_data(struct sk_buff *skb)
 {
 	struct ieee80211_hdr *hdr;
 
-	hdr = (struct ieee80211_hdr *) &skb->data[MT_TXD_SIZE];
+	hdr = (struct ieee80211_hdr *)&skb->data[MT_TXD_SIZE];
 	hdr->frame_control |= cpu_to_le16(IEEE80211_FCTL_MOREDATA);
 }
 
@@ -647,7 +647,8 @@ mt7603_set_coverage_class(struct ieee80211_hw *hw, s16 coverage_class)
 	mt7603_mac_set_timing(dev);
 }
 
-static void mt7603_tx(struct ieee80211_hw *hw, struct ieee80211_tx_control *control,
+static void mt7603_tx(struct ieee80211_hw *hw,
+		      struct ieee80211_tx_control *control,
 		      struct sk_buff *skb)
 {
 	struct ieee80211_tx_info *info = IEEE80211_SKB_CB(skb);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7603/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7603/mcu.c
index 343ddc5543c2..02b2bd60d04d 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7603/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7603/mcu.c
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: ISC */
+// SPDX-License-Identifier: ISC
 
 #include <linux/firmware.h>
 #include "mt7603.h"
diff --git a/drivers/net/wireless/mediatek/mt76/mt7603/pci.c b/drivers/net/wireless/mediatek/mt76/mt7603/pci.c
index 4acdbf5d8968..2f2f337e2201 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7603/pci.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7603/pci.c
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: ISC */
+// SPDX-License-Identifier: ISC
 
 #include <linux/kernel.h>
 #include <linux/module.h>
diff --git a/drivers/net/wireless/mediatek/mt76/mt7603/soc.c b/drivers/net/wireless/mediatek/mt76/mt7603/soc.c
index b920be1f5718..b7138485844a 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7603/soc.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7603/soc.c
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: ISC */
+// SPDX-License-Identifier: ISC
 
 #include <linux/kernel.h>
 #include <linux/module.h>
-- 
2.18.0

