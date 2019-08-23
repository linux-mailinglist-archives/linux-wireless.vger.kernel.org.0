Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 040A49AA93
	for <lists+linux-wireless@lfdr.de>; Fri, 23 Aug 2019 10:46:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732682AbfHWIqS (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 23 Aug 2019 04:46:18 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41340 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732418AbfHWIqS (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 23 Aug 2019 04:46:18 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id C3B0130014C6;
        Fri, 23 Aug 2019 08:46:17 +0000 (UTC)
Received: from localhost (unknown [10.43.2.236])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8D5C42635A;
        Fri, 23 Aug 2019 08:46:14 +0000 (UTC)
From:   Stanislaw Gruszka <sgruszka@redhat.com>
To:     linux-wireless@vger.kernel.org
Cc:     Felix Fietkau <nbd@nbd.name>,
        Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        Ryder Lee <ryder.lee@mediatek.com>, Roy Luo <royluo@google.com>
Subject: [PATCH] mt76: make mt76_rx_convert static
Date:   Fri, 23 Aug 2019 10:46:12 +0200
Message-Id: <1566549972-6026-1-git-send-email-sgruszka@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.45]); Fri, 23 Aug 2019 08:46:17 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

mt76_rx_convert() not need to be exported any longer.

Signed-off-by: Stanislaw Gruszka <sgruszka@redhat.com>
---
 drivers/net/wireless/mediatek/mt76/mac80211.c | 3 +--
 drivers/net/wireless/mediatek/mt76/mt76.h     | 2 --
 2 files changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mac80211.c b/drivers/net/wireless/mediatek/mt76/mac80211.c
index fa481d2f11bd..1a2c143b34d0 100644
--- a/drivers/net/wireless/mediatek/mt76/mac80211.c
+++ b/drivers/net/wireless/mediatek/mt76/mac80211.c
@@ -484,7 +484,7 @@ void mt76_wcid_key_setup(struct mt76_dev *dev, struct mt76_wcid *wcid,
 }
 EXPORT_SYMBOL(mt76_wcid_key_setup);
 
-struct ieee80211_sta *mt76_rx_convert(struct sk_buff *skb)
+static struct ieee80211_sta *mt76_rx_convert(struct sk_buff *skb)
 {
 	struct ieee80211_rx_status *status = IEEE80211_SKB_RXCB(skb);
 	struct mt76_rx_status mstat;
@@ -511,7 +511,6 @@ struct ieee80211_sta *mt76_rx_convert(struct sk_buff *skb)
 
 	return wcid_to_sta(mstat.wcid);
 }
-EXPORT_SYMBOL(mt76_rx_convert);
 
 static int
 mt76_check_ccmp_pn(struct sk_buff *skb)
diff --git a/drivers/net/wireless/mediatek/mt76/mt76.h b/drivers/net/wireless/mediatek/mt76/mt76.h
index d67c6a26c87c..570c159515a0 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76.h
@@ -749,8 +749,6 @@ int mt76_sta_state(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 void __mt76_sta_remove(struct mt76_dev *dev, struct ieee80211_vif *vif,
 		       struct ieee80211_sta *sta);
 
-struct ieee80211_sta *mt76_rx_convert(struct sk_buff *skb);
-
 int mt76_get_min_avg_rssi(struct mt76_dev *dev);
 
 int mt76_get_txpower(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
-- 
1.9.3

