Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71F0B3A0C3E
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Jun 2021 08:15:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232257AbhFIGRg (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 9 Jun 2021 02:17:36 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:53547 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S232001AbhFIGRf (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 9 Jun 2021 02:17:35 -0400
X-UUID: a6c0a2539f0e4c529b30171850528b8c-20210609
X-UUID: a6c0a2539f0e4c529b30171850528b8c-20210609
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw01.mediatek.com
        (envelope-from <sean.wang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1871896836; Wed, 09 Jun 2021 14:15:35 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs06n1.mediatek.inc (172.21.101.129) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 9 Jun 2021 14:15:34 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 9 Jun 2021 14:15:33 +0800
From:   <sean.wang@mediatek.com>
To:     <nbd@nbd.name>, <lorenzo.bianconi@redhat.com>
CC:     <sean.wang@mediatek.com>, <Soul.Huang@mediatek.com>,
        <YN.Chen@mediatek.com>, <Leon.Yen@mediatek.com>,
        <Eric-SY.Chang@mediatek.com>, <Deren.Wu@mediatek.com>,
        <km.lin@mediatek.com>, <robin.chiu@mediatek.com>,
        <ch.yeh@mediatek.com>, <posh.sun@mediatek.com>,
        <Eric.Liang@mediatek.com>, <Stella.Chang@mediatek.com>,
        <jemele@google.com>, <yenlinlai@google.com>,
        <linux-wireless@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>
Subject: [PATCH] mt76: connac: fix the maximum interval schedule scan can support
Date:   Wed, 9 Jun 2021 14:15:32 +0800
Message-ID: <1623219333-11122-1-git-send-email-sean.wang@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Sean Wang <sean.wang@mediatek.com>

Maximum interval (in seconds) for schedule scan plan supported by
the offload firmware can be U16_MAX.

Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 drivers/net/wireless/mediatek/mt76/mt7615/init.c     | 2 +-
 drivers/net/wireless/mediatek/mt76/mt76_connac.h     | 3 ++-
 drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h | 2 +-
 drivers/net/wireless/mediatek/mt76/mt7921/init.c     | 2 +-
 4 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/init.c b/drivers/net/wireless/mediatek/mt76/mt7615/init.c
index 36c9e527bb9a..95d16cd17b53 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/init.c
@@ -383,7 +383,7 @@ mt7615_init_wiphy(struct ieee80211_hw *hw)
 	wiphy->reg_notifier = mt7615_regd_notifier;
 
 	wiphy->max_sched_scan_plan_interval =
-		MT76_CONNAC_MAX_SCHED_SCAN_INTERVAL;
+		MT76_CONNAC_MAX_TIME_SCHED_SCAN_INTERVAL;
 	wiphy->max_sched_scan_ie_len = IEEE80211_MAX_DATA_LEN;
 	wiphy->max_scan_ie_len = MT76_CONNAC_SCAN_IE_LEN;
 	wiphy->max_sched_scan_ssids = MT76_CONNAC_MAX_SCHED_SCAN_SSID;
diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac.h b/drivers/net/wireless/mediatek/mt76/mt76_connac.h
index 0dfa09902ffd..9b3f8d22f17e 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac.h
@@ -7,7 +7,8 @@
 #include "mt76.h"
 
 #define MT76_CONNAC_SCAN_IE_LEN			600
-#define MT76_CONNAC_MAX_SCHED_SCAN_INTERVAL	10
+#define MT76_CONNAC_MAX_NUM_SCHED_SCAN_INTERVAL	 10
+#define MT76_CONNAC_MAX_TIME_SCHED_SCAN_INTERVAL U16_MAX
 #define MT76_CONNAC_MAX_SCHED_SCAN_SSID		10
 #define MT76_CONNAC_MAX_SCAN_MATCH		16
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
index 258b262c7c23..3dc5da116a5f 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
@@ -771,7 +771,7 @@ struct mt76_connac_sched_scan_req {
 	u8 intervals_num;
 	u8 scan_func; /* MT7663: BIT(0) eable random mac address */
 	struct mt76_connac_mcu_scan_channel channels[64];
-	__le16 intervals[MT76_CONNAC_MAX_SCHED_SCAN_INTERVAL];
+	__le16 intervals[MT76_CONNAC_MAX_NUM_SCHED_SCAN_INTERVAL];
 	union {
 		struct {
 			u8 random_mac[ETH_ALEN];
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/init.c b/drivers/net/wireless/mediatek/mt76/mt7921/init.c
index 021abd75e522..2caa5096a419 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/init.c
@@ -68,7 +68,7 @@ mt7921_init_wiphy(struct ieee80211_hw *hw)
 	wiphy->max_scan_ie_len = MT76_CONNAC_SCAN_IE_LEN;
 	wiphy->max_scan_ssids = 4;
 	wiphy->max_sched_scan_plan_interval =
-		MT76_CONNAC_MAX_SCHED_SCAN_INTERVAL;
+		MT76_CONNAC_MAX_TIME_SCHED_SCAN_INTERVAL;
 	wiphy->max_sched_scan_ie_len = IEEE80211_MAX_DATA_LEN;
 	wiphy->max_sched_scan_ssids = MT76_CONNAC_MAX_SCHED_SCAN_SSID;
 	wiphy->max_match_sets = MT76_CONNAC_MAX_SCAN_MATCH;
-- 
2.25.1

