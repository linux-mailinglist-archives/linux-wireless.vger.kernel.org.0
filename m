Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 448D0750FBE
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Jul 2023 19:35:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231970AbjGLRfZ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 12 Jul 2023 13:35:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231602AbjGLRfY (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 12 Jul 2023 13:35:24 -0400
Received: from forward101b.mail.yandex.net (forward101b.mail.yandex.net [178.154.239.148])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9D231FEC
        for <linux-wireless@vger.kernel.org>; Wed, 12 Jul 2023 10:35:15 -0700 (PDT)
Received: from mail-nwsmtp-smtp-production-main-17.iva.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-17.iva.yp-c.yandex.net [IPv6:2a02:6b8:c0c:ab03:0:640:a6db:0])
        by forward101b.mail.yandex.net (Yandex) with ESMTP id 6218560033;
        Wed, 12 Jul 2023 20:35:13 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-17.iva.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id CZeZZ13BUa60-9aSvUNIL;
        Wed, 12 Jul 2023 20:35:12 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail; t=1689183312;
        bh=tBsgEXpUkztgcgzQwVfDv2AkIa/Y9BOYFdQVk3U07Ug=;
        h=Message-ID:Date:Cc:Subject:To:From;
        b=VrWuPwEslADvFL6IAeYjJJHhfgF/VKXvY5smsQpmi4ITU1r4Xjcb5K0/McEZzVF8f
         d/mLknX57vdpNaowsB2G/HMkVmSJXdtQGsKIv4RM9W8cSnXLxWYmAe6DresABALUhk
         8K0xTG53lfkwrRvtAbdNsB5OIZ5nMc9a+9UGzn4o=
Authentication-Results: mail-nwsmtp-smtp-production-main-17.iva.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
From:   Dmitry Antipov <dmantipov@yandex.ru>
To:     Felix Fietkau <nbd@nbd.name>
Cc:     Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org,
        Dmitry Antipov <dmantipov@yandex.ru>
Subject: [PATCH] wifi: mt76: use native timestamps for RX reordering
Date:   Wed, 12 Jul 2023 20:34:26 +0300
Message-ID: <20230712173437.162921-1-dmantipov@yandex.ru>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Prefer native (i.e. unsigned long) timestamps for RX reordering. Since
'struct mt76_rx_status' with native timestamp becomes too large to fit
into 48-byte 'cb' area of 'struct sk_buff', use separate timestamps in
reorder array of 'struct mt76_rx_tid' instead.

Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
---
 drivers/net/wireless/mediatek/mt76/agg-rx.c | 30 ++++++++++++---------
 drivers/net/wireless/mediatek/mt76/mt76.h   |  7 ++---
 2 files changed, 21 insertions(+), 16 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/agg-rx.c b/drivers/net/wireless/mediatek/mt76/agg-rx.c
index 10cbd9e560e7..3b9eeb38e118 100644
--- a/drivers/net/wireless/mediatek/mt76/agg-rx.c
+++ b/drivers/net/wireless/mediatek/mt76/agg-rx.c
@@ -19,11 +19,13 @@ mt76_aggr_release(struct mt76_rx_tid *tid, struct sk_buff_head *frames, int idx)
 
 	tid->head = ieee80211_sn_inc(tid->head);
 
-	skb = tid->reorder_buf[idx];
+	skb = tid->reorder[idx].skb;
 	if (!skb)
 		return;
 
-	tid->reorder_buf[idx] = NULL;
+	tid->reorder[idx].skb = NULL;
+	tid->reorder[idx].timestamp = 0;
+
 	tid->nframes--;
 	__skb_queue_tail(frames, skb);
 }
@@ -46,7 +48,7 @@ mt76_rx_aggr_release_head(struct mt76_rx_tid *tid, struct sk_buff_head *frames)
 {
 	int idx = tid->head % tid->size;
 
-	while (tid->reorder_buf[idx]) {
+	while (tid->reorder[idx].skb) {
 		mt76_aggr_release(tid, frames, idx);
 		idx = tid->head % tid->size;
 	}
@@ -70,15 +72,15 @@ mt76_rx_aggr_check_release(struct mt76_rx_tid *tid, struct sk_buff_head *frames)
 	for (idx = (tid->head + 1) % tid->size;
 	     idx != start && nframes;
 	     idx = (idx + 1) % tid->size) {
-		skb = tid->reorder_buf[idx];
+		skb = tid->reorder[idx].skb;
 		if (!skb)
 			continue;
 
 		nframes--;
 		status = (struct mt76_rx_status *)skb->cb;
-		if (!time_after32(jiffies,
-				  status->reorder_time +
-				  mt76_aggr_tid_to_timeo(tid->num)))
+		if (!time_after(jiffies,
+				tid->reorder[idx].timestamp +
+				mt76_aggr_tid_to_timeo(tid->num)))
 			continue;
 
 		mt76_rx_aggr_release_frames(tid, frames, status->seqno);
@@ -222,13 +224,13 @@ void mt76_rx_aggr_reorder(struct sk_buff *skb, struct sk_buff_head *frames)
 	idx = seqno % size;
 
 	/* Discard if the current slot is already in use */
-	if (tid->reorder_buf[idx]) {
+	if (tid->reorder[idx].skb) {
 		dev_kfree_skb(skb);
 		goto out;
 	}
 
-	status->reorder_time = jiffies;
-	tid->reorder_buf[idx] = skb;
+	tid->reorder[idx].timestamp = jiffies;
+	tid->reorder[idx].skb = skb;
 	tid->nframes++;
 	mt76_rx_aggr_release_head(tid, frames);
 
@@ -246,7 +248,7 @@ int mt76_rx_aggr_start(struct mt76_dev *dev, struct mt76_wcid *wcid, u8 tidno,
 
 	mt76_rx_aggr_stop(dev, wcid, tidno);
 
-	tid = kzalloc(struct_size(tid, reorder_buf, size), GFP_KERNEL);
+	tid = kzalloc(struct_size(tid, reorder, size), GFP_KERNEL);
 	if (!tid)
 		return -ENOMEM;
 
@@ -272,12 +274,14 @@ static void mt76_rx_aggr_shutdown(struct mt76_dev *dev, struct mt76_rx_tid *tid)
 
 	tid->stopped = true;
 	for (i = 0; tid->nframes && i < size; i++) {
-		struct sk_buff *skb = tid->reorder_buf[i];
+		struct sk_buff *skb = tid->reorder[i].skb;
 
 		if (!skb)
 			continue;
 
-		tid->reorder_buf[i] = NULL;
+		tid->reorder[i].skb = NULL;
+		tid->reorder[i].timestamp = 0;
+
 		tid->nframes--;
 		dev_kfree_skb(skb);
 	}
diff --git a/drivers/net/wireless/mediatek/mt76/mt76.h b/drivers/net/wireless/mediatek/mt76/mt76.h
index 6b07b8fafec2..f38da680dc54 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76.h
@@ -372,7 +372,10 @@ struct mt76_rx_tid {
 
 	u8 started:1, stopped:1, timer_pending:1;
 
-	struct sk_buff *reorder_buf[];
+	struct {
+		struct sk_buff *skb;
+		unsigned long timestamp;
+	} reorder[];
 };
 
 #define MT_TX_CB_DMA_DONE		BIT(0)
@@ -606,8 +609,6 @@ struct mt76_rx_status {
 		u16 wcid_idx;
 	};
 
-	u32 reorder_time;
-
 	u32 ampdu_ref;
 	u32 timestamp;
 
-- 
2.41.0

