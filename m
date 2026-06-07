Return-Path: <linux-wireless+bounces-37463-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id XHrhNvPTJGo7AQIAu9opvQ
	(envelope-from <linux-wireless+bounces-37463-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sun, 07 Jun 2026 04:14:11 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F32564EACE
	for <lists+linux-wireless@lfdr.de>; Sun, 07 Jun 2026 04:14:11 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=Ww0Zro3k;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-37463-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-37463-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7A75330262E6
	for <lists+linux-wireless@lfdr.de>; Sun,  7 Jun 2026 02:13:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B69E6246774;
	Sun,  7 Jun 2026 02:13:05 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5357C242D9B
	for <linux-wireless@vger.kernel.org>; Sun,  7 Jun 2026 02:13:04 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780798385; cv=none; b=ZFqWf3+w9ynMZtnJhUSbuC2p3ommJvIGwvaUiwzaw8i9Az6zWKzq7FYQoISfhBPa6CzH6dqAbkNfAyG+CA6FI5Poqwo74dIPWrxJesOWUYw/YIsywkc7MgCEjpv8jrrRjewVDCLh4b4XorSxvGP7TT11PlzhwCiWrU8AGLDg2SM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780798385; c=relaxed/simple;
	bh=uQsMeEbR6kDv0rOCTarB+WL0+qAK97AZ0MjgyylTOhA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GSjicpUiU8zVyS2onKchHpdNbzzKmQwmqTyfJfYHtkaimGdzXdlvRAPH4bvP7ZheTJL6tkDfgk9Et//smfY675PtOhB4VeDFtzQsr9E2Ra7I16S4g9KEZY6l+VLUW3mku8Y+5P08goEKDooLe/mUb+xiDqQTHbgmmayB4otHWuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ww0Zro3k; arc=none smtp.client-ip=209.85.210.176
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-84229481d44so1261681b3a.0
        for <linux-wireless@vger.kernel.org>; Sat, 06 Jun 2026 19:13:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780798383; x=1781403183; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=iBfzAvBmHxoTdEDnxAcg3ks9n3jJCgw3BECtZF4cCsY=;
        b=Ww0Zro3kM9I9PiaBwI5tPtrEhm3dPpwJcwIRUlP+5b+ispwNgLBbFOAJlEZdVMj+3H
         +QrXuwQhn7Vg91+5th53nLKxrVgx8DbFVe6R6v86ayhGsk0zSKaypfgXIwCaViM3oW98
         DMcL1GI6294P911Va9m5jDrZzNKO/l3Cq4hAmTbfCYtR08P+GGalJ6nnEszdwv1g6nE0
         1NChR9bTjSb0qRxNN33/vJi5SB7xayc1lLohodeCgMwfWhfMzUqJRvWXWKTuymIsrpc1
         0B8kgligX17ko/2NUhA25zMK9c2gePGK9kfJLKmAPdyTdQLfVg9wWI2SJkHBH46KBXwu
         yD0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780798383; x=1781403183;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iBfzAvBmHxoTdEDnxAcg3ks9n3jJCgw3BECtZF4cCsY=;
        b=U+KIwbZqvGUroDQ9tW9TXdhbyxJvHYk2DN3ofhwEw1TVxjVW71nh0OXJ+0be5cPz2p
         dgadkhJOaR3VIpTUWHJHAayOKpD4SAkY8kfMflyTUvTPAXvBXjRKz+vH1tASWOZHajGy
         QyJRV+bcIQb3OYVKfB6Y7MVHdeGU490Zo74VA+axdsBJTO/44t4IXvfxsXjHZeNMlQHU
         jY0qP41cxcw/IFZotdB54U1VIoR4TIhdR8aR4JEHlIslvUpu3Qi6dTxbGm8xogbQ56w1
         QpYwTSe282WPwbM7tH5XhKZQgCEuKP4BZiVZSVM5zC/G+DAIW1/BrfNAQu8KYgS2yHgp
         AkVA==
X-Gm-Message-State: AOJu0YwEHOjajeLh3bo5ZHUXgYFnX0esNEEgNbxJZreBiCu1yLXl5Z15
	VZCpMIQdcgm12Ug6byeIyPt5PcCfRvQkljBvltVeEZa11aQ9AV91eUWw/7NRjg==
X-Gm-Gg: Acq92OEqwBJF5G6g7pPFfIXmpzGkNsqyySZvylf9s7aIAHkjuyy4Rt2tKpbA2H9hJor
	91r2gKZ2ons6l/+DxBnG0D6dlcVLERQWbjwNOUMklYolK3tiftzDNiLRtTcNq31yvcMQJrc3vdr
	8MRrhOVftjheXKWzYwjeLteASPlCHXD88Q7d37gfDeAMcFW2p+BMFFo/3m7ZheicVhX+48XrSar
	bXpjBvVVpwNsXb/rUBFhRTn7hMmAW88UAWeA3h4xk6rBjjSecI9d5hkDlIEmgl9Wk6k1PsAdrjk
	z2YsPwTyvWJrxyUowQYbtorFHZlJaKOaM4bwIve7YXsgLUSYQ6ccoxKnslr+z/g+Iv7BUfMhx1m
	5zlVJfVX2tBtxujkouUI6Gk5jP+r8CX6helu4oIsiAjCi95UxogRCXEFp98Z0VQH0/OG2cbrYLa
	SyMTMBvmn5NMBvawm/dAZgLqVBC+kmIVA9MnyEAM7YzS6QKMHnxH19CvmoYRmtD4WEtB1NuFQHO
	nE2VmiYHbBYzO9ziOQzWsVvBQ0uGZGOaNdUqha12Gvusw==
X-Received: by 2002:a05:6a00:3e22:b0:842:4af4:3099 with SMTP id d2e1a72fcca58-842b0e6a336mr9677898b3a.20.1780798383394;
        Sat, 06 Jun 2026 19:13:03 -0700 (PDT)
Received: from ryzen ([2601:644:8000:5b5d:7285:c2ff:fe45:8a32])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8428706fa9asm13184098b3a.45.2026.06.06.19.13.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Jun 2026 19:13:02 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes@sipsolutions.net>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCHv3 wireless-next] wifi: mac80211: fold tid_ampdu_rx allocations into a flexible array
Date: Sat,  6 Jun 2026 19:12:45 -0700
Message-ID: <20260607021245.6470-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-37463-lists,linux-wireless=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[rosenp@gmail.com,linux-wireless@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:linux-wireless@vger.kernel.org,m:johannes@sipsolutions.net,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rosenp@gmail.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3F32564EACE

Convert the separately-allocated reorder_buf pointer to a C99 flexible
array member at the end of struct tid_ampdu_rx, with both the
sk_buff_head and the jiffies timestamp in each array element. This
collapses three allocations into one and removes the corresponding
kfree() pairs from the error and free paths.

Assisted-by: opencode:big-pickle
Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 v3: Fix kernel-doc
 v2: use anonymous struct to combine allocations
 net/mac80211/agg-rx.c   | 22 +++-------------------
 net/mac80211/rx.c       | 14 +++++++-------
 net/mac80211/sta_info.h | 13 ++++++++-----
 3 files changed, 18 insertions(+), 31 deletions(-)

diff --git a/net/mac80211/agg-rx.c b/net/mac80211/agg-rx.c
index 0140ac826b23..9629e00069a1 100644
--- a/net/mac80211/agg-rx.c
+++ b/net/mac80211/agg-rx.c
@@ -49,9 +49,7 @@ static void ieee80211_free_tid_rx(struct rcu_head *h)
 	int i;

 	for (i = 0; i < tid_rx->buf_size; i++)
-		__skb_queue_purge(&tid_rx->reorder_buf[i]);
-	kfree(tid_rx->reorder_buf);
-	kfree(tid_rx->reorder_time);
+		__skb_queue_purge(&tid_rx->reorder[i].buf);
 	kfree(tid_rx);
 }

@@ -412,7 +410,7 @@ void __ieee80211_start_rx_ba_session(struct sta_info *sta,
 	}

 	/* prepare A-MPDU MLME for Rx aggregation */
-	tid_agg_rx = kzalloc_obj(*tid_agg_rx);
+	tid_agg_rx = kzalloc_flex(*tid_agg_rx, reorder, buf_size);
 	if (!tid_agg_rx)
 		goto end;

@@ -426,27 +424,13 @@ void __ieee80211_start_rx_ba_session(struct sta_info *sta,
 	timer_setup(&tid_agg_rx->reorder_timer,
 		    sta_rx_agg_reorder_timer_expired, 0);

-	/* prepare reordering buffer */
-	tid_agg_rx->reorder_buf =
-		kzalloc_objs(struct sk_buff_head, buf_size);
-	tid_agg_rx->reorder_time =
-		kcalloc(buf_size, sizeof(unsigned long), GFP_KERNEL);
-	if (!tid_agg_rx->reorder_buf || !tid_agg_rx->reorder_time) {
-		kfree(tid_agg_rx->reorder_buf);
-		kfree(tid_agg_rx->reorder_time);
-		kfree(tid_agg_rx);
-		goto end;
-	}
-
 	for (i = 0; i < buf_size; i++)
-		__skb_queue_head_init(&tid_agg_rx->reorder_buf[i]);
+		__skb_queue_head_init(&tid_agg_rx->reorder[i].buf);

 	ret = drv_ampdu_action(local, sta->sdata, &params);
 	ht_dbg(sta->sdata, "Rx A-MPDU request on %pM tid %d result %d\n",
 	       sta->sta.addr, tid, ret);
 	if (ret) {
-		kfree(tid_agg_rx->reorder_buf);
-		kfree(tid_agg_rx->reorder_time);
 		kfree(tid_agg_rx);
 		goto end;
 	}
diff --git a/net/mac80211/rx.c b/net/mac80211/rx.c
index db421edfd54c..fb9a3574afe9 100644
--- a/net/mac80211/rx.c
+++ b/net/mac80211/rx.c
@@ -1188,7 +1188,7 @@ static ieee80211_rx_result ieee80211_rx_mesh_check(struct ieee80211_rx_data *rx)
 static inline bool ieee80211_rx_reorder_ready(struct tid_ampdu_rx *tid_agg_rx,
 					      int index)
 {
-	struct sk_buff_head *frames = &tid_agg_rx->reorder_buf[index];
+	struct sk_buff_head *frames = &tid_agg_rx->reorder[index].buf;
 	struct sk_buff *tail = skb_peek_tail(frames);
 	struct ieee80211_rx_status *status;

@@ -1211,7 +1211,7 @@ static void ieee80211_release_reorder_frame(struct ieee80211_sub_if_data *sdata,
 					    int index,
 					    struct sk_buff_head *frames)
 {
-	struct sk_buff_head *skb_list = &tid_agg_rx->reorder_buf[index];
+	struct sk_buff_head *skb_list = &tid_agg_rx->reorder[index].buf;
 	struct sk_buff *skb;
 	struct ieee80211_rx_status *status;

@@ -1290,14 +1290,14 @@ static void ieee80211_sta_reorder_release(struct ieee80211_sub_if_data *sdata,
 				continue;
 			}
 			if (skipped &&
-			    !time_after(jiffies, tid_agg_rx->reorder_time[j] +
+			    !time_after(jiffies, tid_agg_rx->reorder[j].time +
 					HT_RX_REORDER_BUF_TIMEOUT))
 				goto set_release_timer;

 			/* don't leave incomplete A-MSDUs around */
 			for (i = (index + 1) % tid_agg_rx->buf_size; i != j;
 			     i = (i + 1) % tid_agg_rx->buf_size)
-				__skb_queue_purge(&tid_agg_rx->reorder_buf[i]);
+				__skb_queue_purge(&tid_agg_rx->reorder[i].buf);

 			ht_dbg_ratelimited(sdata,
 					   "release an RX reorder frame due to timeout on earlier frames\n");
@@ -1331,7 +1331,7 @@ static void ieee80211_sta_reorder_release(struct ieee80211_sub_if_data *sdata,

 		if (!tid_agg_rx->removed)
 			mod_timer(&tid_agg_rx->reorder_timer,
-				  tid_agg_rx->reorder_time[j] + 1 +
+				  tid_agg_rx->reorder[j].time + 1 +
 				  HT_RX_REORDER_BUF_TIMEOUT);
 	} else {
 		timer_delete(&tid_agg_rx->reorder_timer);
@@ -1426,9 +1426,9 @@ static bool ieee80211_sta_manage_reorder_buf(struct ieee80211_sub_if_data *sdata
 	}

 	/* put the frame in the reordering buffer */
-	__skb_queue_tail(&tid_agg_rx->reorder_buf[index], skb);
+	__skb_queue_tail(&tid_agg_rx->reorder[index].buf, skb);
 	if (!(status->flag & RX_FLAG_AMSDU_MORE)) {
-		tid_agg_rx->reorder_time[index] = jiffies;
+		tid_agg_rx->reorder[index].time = jiffies;
 		tid_agg_rx->stored_mpdu_num++;
 		ieee80211_sta_reorder_release(sdata, tid_agg_rx, frames);
 	}
diff --git a/net/mac80211/sta_info.h b/net/mac80211/sta_info.h
index 26138934b72e..b5f1310d2cd6 100644
--- a/net/mac80211/sta_info.h
+++ b/net/mac80211/sta_info.h
@@ -207,11 +207,8 @@ struct tid_ampdu_tx {
 /**
  * struct tid_ampdu_rx - TID aggregation information (Rx).
  *
- * @reorder_buf: buffer to reorder incoming aggregated MPDUs. An MPDU may be an
- *	A-MSDU with individually reported subframes.
  * @reorder_buf_filtered: bitmap indicating where there are filtered frames in
  *	the reorder buffer that should be ignored when releasing frames
- * @reorder_time: jiffies when skb was added
  * @session_timer: check if peer keeps Tx-ing on the TID (by timeout value)
  * @reorder_timer: releases expired frames from the reorder buffer.
  * @sta: station we are attached to
@@ -228,6 +225,10 @@ struct tid_ampdu_tx {
  *	and ssn.
  * @removed: this session is removed (but might have been found due to RCU)
  * @started: this session has started (head ssn or higher was received)
+ * @reorder: array containing a buffer with a jiffies component
+ * @reorder.buf: buffer to reorder incoming aggregated MPDUs. An MPDU may be an
+ *     A-MSDU with individually reported subframes.
+ * @reorder.time: jiffies when skb was added
  *
  * This structure's lifetime is managed by RCU, assignments to
  * the array holding it must hold the aggregation mutex.
@@ -241,8 +242,6 @@ struct tid_ampdu_rx {
 	struct rcu_head rcu_head;
 	spinlock_t reorder_lock;
 	u64 reorder_buf_filtered;
-	struct sk_buff_head *reorder_buf;
-	unsigned long *reorder_time;
 	struct sta_info *sta;
 	struct timer_list session_timer;
 	struct timer_list reorder_timer;
@@ -256,6 +255,10 @@ struct tid_ampdu_rx {
 	u8 auto_seq:1,
 	   removed:1,
 	   started:1;
+	struct {
+		struct sk_buff_head buf;
+		unsigned long time;
+	} reorder[];
 };

 /**
--
2.54.0


