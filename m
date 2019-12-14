Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CDBA011F14B
	for <lists+linux-wireless@lfdr.de>; Sat, 14 Dec 2019 11:01:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725884AbfLNJ7L (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 14 Dec 2019 04:59:11 -0500
Received: from smail.rz.tu-ilmenau.de ([141.24.186.67]:33475 "EHLO
        smail.rz.tu-ilmenau.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725872AbfLNJ7L (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 14 Dec 2019 04:59:11 -0500
Received: from isengard.fritz.box (unknown [87.147.48.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smail.rz.tu-ilmenau.de (Postfix) with ESMTPSA id 63799580075;
        Sat, 14 Dec 2019 10:59:09 +0100 (CET)
From:   Markus Theil <markus.theil@tu-ilmenau.de>
To:     nbd@nbd.name
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com,
        Stanislaw Gruszka <stf_xl@wp.pl>, kvalo@codeaurora.org,
        Markus Theil <markus.theil@tu-ilmenau.de>
Subject: [PATCH v4] mt76: use AC specific reorder timeout
Date:   Sat, 14 Dec 2019 10:58:59 +0100
Message-Id: <20191214095859.16861-1-markus.theil@tu-ilmenau.de>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Before this patch, mt76 handled rx traffic for all TIDs  equally,
when released from reorder buffer early. This patch uses an AC specific
reorder timeout, in order to release partial aggregated frames for video
ACs earlier. Voice ACs are currently not aggregated (thanks to Felix for
this hint). For example, ath10k also uses AC specific reorder timeouts
(reported by firmware in that case).

Signed-off-by: Markus Theil <markus.theil@tu-ilmenau.de>
---
v4: simplify patch
v3: fix changelog
v2: use static const mapping arrays

 drivers/net/wireless/mediatek/mt76/agg-rx.c | 16 ++++++++++++----
 drivers/net/wireless/mediatek/mt76/mt76.h   |  2 ++
 2 files changed, 14 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/agg-rx.c b/drivers/net/wireless/mediatek/mt76/agg-rx.c
index 53b5a4b2dcc5..6d64c2c4a159 100644
--- a/drivers/net/wireless/mediatek/mt76/agg-rx.c
+++ b/drivers/net/wireless/mediatek/mt76/agg-rx.c
@@ -4,7 +4,13 @@
  */
 #include "mt76.h"

-#define REORDER_TIMEOUT (HZ / 10)
+static unsigned long mt76_aggr_tid_to_timeo(u8 tidno)
+{
+	/* Currently voice traffic (AC_VO) always runs without aggregation,
+	 * no special handling is needed. AC_BE/AC_BK use tids 0-3. Just check
+	 * for non AC_BK/AC_BE and set smaller timeout for it. */
+	return HZ / (tidno >= 4 ? 25 : 10);
+}

 static void
 mt76_aggr_release(struct mt76_rx_tid *tid, struct sk_buff_head *frames, int idx)
@@ -71,7 +77,8 @@ mt76_rx_aggr_check_release(struct mt76_rx_tid *tid, struct sk_buff_head *frames)
 		nframes--;
 		status = (struct mt76_rx_status *)skb->cb;
 		if (!time_after(jiffies,
-				status->reorder_time + REORDER_TIMEOUT))
+				status->reorder_time +
+				mt76_aggr_tid_to_timeo(tid->num)))
 			continue;

 		mt76_rx_aggr_release_frames(tid, frames, status->seqno);
@@ -101,7 +108,7 @@ mt76_rx_aggr_reorder_work(struct work_struct *work)

 	if (nframes)
 		ieee80211_queue_delayed_work(tid->dev->hw, &tid->reorder_work,
-					     REORDER_TIMEOUT);
+					     mt76_aggr_tid_to_timeo(tid->num));
 	mt76_rx_complete(dev, &frames, NULL);

 	rcu_read_unlock();
@@ -225,7 +232,7 @@ void mt76_rx_aggr_reorder(struct sk_buff *skb, struct sk_buff_head *frames)
 	mt76_rx_aggr_release_head(tid, frames);

 	ieee80211_queue_delayed_work(tid->dev->hw, &tid->reorder_work,
-				     REORDER_TIMEOUT);
+				     mt76_aggr_tid_to_timeo(tid->num));

 out:
 	spin_unlock_bh(&tid->lock);
@@ -245,6 +252,7 @@ int mt76_rx_aggr_start(struct mt76_dev *dev, struct mt76_wcid *wcid, u8 tidno,
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
2.24.1

