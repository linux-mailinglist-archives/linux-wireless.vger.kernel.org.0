Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E67383F6A74
	for <lists+linux-wireless@lfdr.de>; Tue, 24 Aug 2021 22:35:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234838AbhHXUgI (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 24 Aug 2021 16:36:08 -0400
Received: from mailgw01.mediatek.com ([60.244.123.138]:52744 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S229514AbhHXUgI (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 24 Aug 2021 16:36:08 -0400
X-UUID: 814b16205a6c480ab5a64afe02273594-20210825
X-UUID: 814b16205a6c480ab5a64afe02273594-20210825
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw01.mediatek.com
        (envelope-from <ryder.lee@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 557214062; Wed, 25 Aug 2021 04:35:19 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs05n2.mediatek.inc (172.21.101.140) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 25 Aug 2021 04:35:18 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 25 Aug 2021 04:35:18 +0800
From:   Ryder Lee <ryder.lee@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>
CC:     Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        Evelyn Tsai <evelyn.tsai@mediatek.com>,
        <linux-wireless@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        Ryder Lee <ryder.lee@mediatek.com>
Subject: [PATCH] mt76: fill boottime_ns in Rx path
Date:   Wed, 25 Aug 2021 04:35:16 +0800
Message-ID: <f098865a41b59e82fb05adfbc8b661bb8e7d5f8e.1629836741.git.ryder.lee@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Give a proper boottime_ns value for netlink RX to avoid scan
issues with Android.

Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
---
 drivers/net/wireless/mediatek/mt76/mac80211.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/wireless/mediatek/mt76/mac80211.c b/drivers/net/wireless/mediatek/mt76/mac80211.c
index 2a434a97fa45..fab55f7d3766 100644
--- a/drivers/net/wireless/mediatek/mt76/mac80211.c
+++ b/drivers/net/wireless/mediatek/mt76/mac80211.c
@@ -801,6 +801,7 @@ mt76_rx_convert(struct mt76_dev *dev, struct sk_buff *skb,
 		struct ieee80211_sta **sta)
 {
 	struct ieee80211_rx_status *status = IEEE80211_SKB_RXCB(skb);
+	struct ieee80211_hdr *hdr = mt76_skb_get_hdr(skb);
 	struct mt76_rx_status mstat;
 
 	mstat = *((struct mt76_rx_status *)skb->cb);
@@ -823,6 +824,10 @@ mt76_rx_convert(struct mt76_dev *dev, struct sk_buff *skb,
 	status->device_timestamp = mstat.timestamp;
 	status->mactime = mstat.timestamp;
 
+	if (ieee80211_is_beacon(hdr->frame_control) ||
+	    ieee80211_is_probe_resp(hdr->frame_control))
+		status->boottime_ns = ktime_get_boottime_ns();
+
 	BUILD_BUG_ON(sizeof(mstat) > sizeof(skb->cb));
 	BUILD_BUG_ON(sizeof(status->chain_signal) !=
 		     sizeof(mstat.chain_signal));
-- 
2.29.2

