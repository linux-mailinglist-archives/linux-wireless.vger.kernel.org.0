Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B01AE117837
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Dec 2019 22:17:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726598AbfLIVRO (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 9 Dec 2019 16:17:14 -0500
Received: from smail.rz.tu-ilmenau.de ([141.24.186.67]:41535 "EHLO
        smail.rz.tu-ilmenau.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726483AbfLIVRO (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 9 Dec 2019 16:17:14 -0500
Received: from isengard.fritz.box (unknown [92.195.99.143])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smail.rz.tu-ilmenau.de (Postfix) with ESMTPSA id 964F8580074;
        Mon,  9 Dec 2019 22:17:11 +0100 (CET)
From:   Markus Theil <markus.theil@tu-ilmenau.de>
To:     nbd@nbd.name
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com,
        Stanislaw Gruszka <stf_xl@wp.pl>,
        Markus Theil <markus.theil@tu-ilmenau.de>
Subject: [PATCH] mt76: use AC specific reorder timeout
Date:   Mon,  9 Dec 2019 22:15:27 +0100
Message-Id: <20191209211527.13977-1-markus.theil@tu-ilmenau.de>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Before this patch, mt76 handled rx traffic for all TIDs  equally,
when released from reorder buffer early. This patch uses an AC specific
reorder timeout, in order to release partial aggregated frames for voice
or video ACs earlier. For example, ath10k also uses AC specific reorder
timeouts (reported by firmware in that case).

Signed-off-by: Markus Theil <markus.theil@tu-ilmenau.de>
---
 drivers/net/wireless/mediatek/mt76/agg-rx.c | 30 ++++++++++++++++++---
 drivers/net/wireless/mediatek/mt76/mt76.h   |  2 ++
 2 files changed, 28 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/agg-rx.c b/drivers/net/wireless/mediatek/mt76/agg-rx.c
index 53b5a4b2dcc5..3832be7d14f3 100644
--- a/drivers/net/wireless/mediatek/mt76/agg-rx.c
+++ b/drivers/net/wireless/mediatek/mt76/agg-rx.c
@@ -4,7 +4,27 @@
  */
 #include "mt76.h"
 
-#define REORDER_TIMEOUT (HZ / 10)
+static unsigned long mt76_aggr_tid_to_timeo(u8 tidno)
+{
+	const int ieee802_1d_to_ac[8] = {
+		IEEE80211_AC_BE,
+		IEEE80211_AC_BK,
+		IEEE80211_AC_BK,
+		IEEE80211_AC_BE,
+		IEEE80211_AC_VI,
+		IEEE80211_AC_VI,
+		IEEE80211_AC_VO,
+		IEEE80211_AC_VO
+	};
+	const int ac_to_timeout[] = {
+		[IEEE80211_AC_VO] = HZ / 30,
+		[IEEE80211_AC_VI] = HZ / 25,
+		[IEEE80211_AC_BE] = HZ / 10,
+		[IEEE80211_AC_BK] = HZ / 10
+	};
+
+	return ac_to_timeout[ieee802_1d_to_ac[tidno & 7]];
+}
 
 static void
 mt76_aggr_release(struct mt76_rx_tid *tid, struct sk_buff_head *frames, int idx)
@@ -71,7 +91,8 @@ mt76_rx_aggr_check_release(struct mt76_rx_tid *tid, struct sk_buff_head *frames)
 		nframes--;
 		status = (struct mt76_rx_status *)skb->cb;
 		if (!time_after(jiffies,
-				status->reorder_time + REORDER_TIMEOUT))
+				status->reorder_time +
+				mt76_aggr_tid_to_timeo(tid->num)))
 			continue;
 
 		mt76_rx_aggr_release_frames(tid, frames, status->seqno);
@@ -101,7 +122,7 @@ mt76_rx_aggr_reorder_work(struct work_struct *work)
 
 	if (nframes)
 		ieee80211_queue_delayed_work(tid->dev->hw, &tid->reorder_work,
-					     REORDER_TIMEOUT);
+					     mt76_aggr_tid_to_timeo(tid->num));
 	mt76_rx_complete(dev, &frames, NULL);
 
 	rcu_read_unlock();
@@ -225,7 +246,7 @@ void mt76_rx_aggr_reorder(struct sk_buff *skb, struct sk_buff_head *frames)
 	mt76_rx_aggr_release_head(tid, frames);
 
 	ieee80211_queue_delayed_work(tid->dev->hw, &tid->reorder_work,
-				     REORDER_TIMEOUT);
+				     mt76_aggr_tid_to_timeo(tid->num));
 
 out:
 	spin_unlock_bh(&tid->lock);
@@ -245,6 +266,7 @@ int mt76_rx_aggr_start(struct mt76_dev *dev, struct mt76_wcid *wcid, u8 tidno,
 	tid->dev = dev;
 	tid->head = ssn;
 	tid->size = size;
+	tid->num = tidno;
 	INIT_DELAYED_WORK(&tid->reorder_work, mt76_rx_aggr_reorder_work);
 	spin_lock_init(&tid->lock);
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt76.h b/drivers/net/wireless/mediatek/mt76/mt76.h
index c268c3d76b3d..b604d8d5f0bc 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76.h
@@ -237,6 +237,8 @@ struct mt76_rx_tid {
 	u8 size;
 	u8 nframes;
 
+	u8 num;
+
 	u8 started:1, stopped:1, timer_pending:1;
 
 	struct sk_buff *reorder_buf[];
-- 
2.24.0

