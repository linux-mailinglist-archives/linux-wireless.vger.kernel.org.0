Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 80DFBEE17A
	for <lists+linux-wireless@lfdr.de>; Mon,  4 Nov 2019 14:46:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727998AbfKDNqG (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 4 Nov 2019 08:46:06 -0500
Received: from smail.rz.tu-ilmenau.de ([141.24.186.67]:35871 "EHLO
        smail.rz.tu-ilmenau.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727663AbfKDNqG (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 4 Nov 2019 08:46:06 -0500
Received: from thunderstorm.prakinf.tu-ilmenau.de (thunderstorm.prakinf.tu-ilmenau.de [141.24.212.108])
        by smail.rz.tu-ilmenau.de (Postfix) with ESMTPA id E88A058006E;
        Mon,  4 Nov 2019 14:46:04 +0100 (CET)
From:   Markus Theil <markus.theil@tu-ilmenau.de>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, sgruszka@redhat.com,
        linux-wireless@vger.kernel.org,
        Markus Theil <markus.theil@tu-ilmenau.de>
Subject: [PATCH] mt76: disable softirqs while calling ieee80211_rx_napi
Date:   Mon,  4 Nov 2019 14:45:40 +0100
Message-Id: <20191104134540.19199-1-markus.theil@tu-ilmenau.de>
X-Mailer: git-send-email 2.17.1
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

mac80211 assumes ieee80211_rx_napi to be called with disabled softirqs.

ieee80211_rx_napi in mac80211.c can be called from aggregation reordering work queue
or from mt76_rx_poll_complete. mt76_rx_poll_complete does currently not disable softirq
processing.

This patch fixes this by disabling softirqs before calling ieee80211_rx_napi.
It should be no problem to disable them twice, if mt76_aggr_reorder_work calls ieee80211_rx_napi
and has already called local_bh_disable, as local_bh_disable/local_bh_enable are reentrant.

I became aware of this issue by the following dmesg output:
  NOHZ: local_softirq_pending 08

Signed-off-by: Markus Theil <markus.theil@tu-ilmenau.de>
---
 drivers/net/wireless/mediatek/mt76/mac80211.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mac80211.c b/drivers/net/wireless/mediatek/mt76/mac80211.c
index 1a2c143b34d0..43c050660fc7 100644
--- a/drivers/net/wireless/mediatek/mt76/mac80211.c
+++ b/drivers/net/wireless/mediatek/mt76/mac80211.c
@@ -628,7 +628,7 @@ void mt76_rx_complete(struct mt76_dev *dev, struct sk_buff_head *frames,
 	struct ieee80211_sta *sta;
 	struct sk_buff *skb;

-	spin_lock(&dev->rx_lock);
+	spin_lock_bh(&dev->rx_lock);
 	while ((skb = __skb_dequeue(frames)) != NULL) {
 		if (mt76_check_ccmp_pn(skb)) {
 			dev_kfree_skb(skb);
@@ -638,7 +638,7 @@ void mt76_rx_complete(struct mt76_dev *dev, struct sk_buff_head *frames,
 		sta = mt76_rx_convert(skb);
 		ieee80211_rx_napi(dev->hw, sta, skb, napi);
 	}
-	spin_unlock(&dev->rx_lock);
+	spin_unlock_bh(&dev->rx_lock);
 }

 void mt76_rx_poll_complete(struct mt76_dev *dev, enum mt76_rxq_id q,
--
2.20.1

