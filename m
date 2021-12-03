Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A62B64671C8
	for <lists+linux-wireless@lfdr.de>; Fri,  3 Dec 2021 07:05:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378548AbhLCGI3 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 3 Dec 2021 01:08:29 -0500
Received: from mailgw01.mediatek.com ([60.244.123.138]:44516 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S231182AbhLCGIY (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 3 Dec 2021 01:08:24 -0500
X-UUID: a56d349921fb4a5690b83137de29dbdc-20211203
X-UUID: a56d349921fb4a5690b83137de29dbdc-20211203
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw01.mediatek.com
        (envelope-from <ryder.lee@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1870578513; Fri, 03 Dec 2021 14:04:57 +0800
Received: from mtkexhb01.mediatek.inc (172.21.101.102) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 3 Dec 2021 14:04:56 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by mtkexhb01.mediatek.inc
 (172.21.101.102) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Fri, 3 Dec
 2021 14:04:56 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 3 Dec 2021 14:04:56 +0800
From:   Ryder Lee <ryder.lee@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>
CC:     Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        Evelyn Tsai <evelyn.tsai@mediatek.com>,
        <linux-wireless@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        "Ryder Lee" <ryder.lee@mediatek.com>
Subject: [PATCH] mt76: only access ieee80211_hdr after mt76_insert_ccmp_hdr
Date:   Fri, 3 Dec 2021 14:04:54 +0800
Message-ID: <37d186367a8221b637489dd914cc524b3e545bbc.1638508664.git.ryder.lee@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Get rid of unsafe access since mt76_insert_ccmp_hdr moves the header.

Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
---
 drivers/net/wireless/mediatek/mt76/mt7915/mac.c | 3 ++-
 drivers/net/wireless/mediatek/mt76/mt7921/mac.c | 2 +-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
index 5757284b24a5..c8747f59ba51 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
@@ -777,7 +777,7 @@ mt7915_mac_fill_rx(struct mt7915_dev *dev, struct sk_buff *skb)
 	}
 
 	if (!hdr_trans) {
-		struct ieee80211_hdr *hdr = mt76_skb_get_hdr(skb);
+		struct ieee80211_hdr *hdr;
 
 		if (insert_ccmp_hdr) {
 			u8 key_id = FIELD_GET(MT_RXD1_NORMAL_KEY_ID, rxd1);
@@ -785,6 +785,7 @@ mt7915_mac_fill_rx(struct mt7915_dev *dev, struct sk_buff *skb)
 			mt76_insert_ccmp_hdr(skb, key_id);
 		}
 
+		hdr = mt76_skb_get_hdr(skb);
 		fc = hdr->frame_control;
 		if (ieee80211_is_data_qos(fc)) {
 			seq_ctrl = le16_to_cpu(hdr->seq_ctrl);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mac.c b/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
index 30cce5743731..edf54b192f37 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
@@ -772,7 +772,7 @@ mt7921_mac_fill_rx(struct mt7921_dev *dev, struct sk_buff *skb)
 	}
 
 	if (!hdr_trans) {
-		struct ieee80211_hdr *hdr = mt76_skb_get_hdr(skb);
+		struct ieee80211_hdr *hdr;
 
 		if (insert_ccmp_hdr) {
 			u8 key_id = FIELD_GET(MT_RXD1_NORMAL_KEY_ID, rxd1);
-- 
2.29.2

