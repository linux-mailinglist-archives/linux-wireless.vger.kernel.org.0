Return-Path: <linux-wireless+bounces-37399-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id qOdOHdIeImq9SgEAu9opvQ
	(envelope-from <linux-wireless+bounces-37399-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 05 Jun 2026 02:56:50 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E6FB96442AE
	for <lists+linux-wireless@lfdr.de>; Fri, 05 Jun 2026 02:56:49 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=nmG1juc5;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-37399-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-37399-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id F26423036EAE
	for <lists+linux-wireless@lfdr.de>; Fri,  5 Jun 2026 00:56:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 331EB23D7E6;
	Fri,  5 Jun 2026 00:56:47 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB3ED1FFC59
	for <linux-wireless@vger.kernel.org>; Fri,  5 Jun 2026 00:56:45 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780621007; cv=none; b=qV9S6U6FItRrD6omvA22AeFiOB2vZaXZq4R2Y34gOW0DMGr6o6Koam4vFHVi7BRZomxOLcP1GivQB58DT1mnz1tgt3DWu+LsilqQP717j1HhGh+AeKAT8JU6Ur2vlRSM+zyq9fDlJ12Sg2FVU1ryHFWtyzdGWIX1GFENrb9+gVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780621007; c=relaxed/simple;
	bh=sBwl+Fi0WLsEJazzgdDRluTY8cehnwCnJ8Z0QQTVDw4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PS9vi5sjkh9uV0rLEWDZ359PWFLFQw4TPAoI8ajzel6Crw/ujnA3MzRXpNDwSjJsLV+WM9Eu6t/SjoxTVjnNQAGFUy0H67FljTPOG4u8XkhL3m6b45GtRHSWRp2VyN6mppxj7OYgwpEfLpj6D57PaHmSlyy8eU/JaCKTNbcA0UA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nmG1juc5; arc=none smtp.client-ip=209.85.216.43
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-36bdda53d99so650569a91.0
        for <linux-wireless@vger.kernel.org>; Thu, 04 Jun 2026 17:56:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780621005; x=1781225805; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gAfj4+hTPcQlGT5Ck/A2gCMQLo9AWh/S4FyKvN7eEWo=;
        b=nmG1juc5y36pduzoULjhkN5qWirQW1DtuXHKFLKkackqbJzFYHFt9VJTUCCvlbWENS
         MtMCMUL98UbYIUqcCbRQ0aVYJ9uUE3Sz2qpi4kcf6bYSSTVRbjPGODbZvF9FIy81tdeZ
         vI14HjaMS4Igp6Qmz6Fb5K65gUbV19IXWEgQVcUzEMm+2yJAMqx/iorYG/J1gg9YpU8G
         EEduFBygrZX24d6q+8/DpC15q3f06TOL6TIHKK9lP8SD6x0gSekJgwwjGfL8kEL8dVKZ
         7zCrWPdN5FHR8y80Ulm8FNrXpdCPrYcQljJfk/uZcfN4n1SEHXfa8CBLEQDnVSnpj50g
         NEqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780621005; x=1781225805;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gAfj4+hTPcQlGT5Ck/A2gCMQLo9AWh/S4FyKvN7eEWo=;
        b=AHpeOuigWxaLvspwTSQukWnYdp5H8JwKW8YYLHlyJxWis40t6Oyr9Y6dYW9+M1oc7s
         s3mAbF22F7KENybBeDAr8Ukr3N9+6uDAc37Pita5cc2kfPeohbsJlVySVsCuiDPeYE0x
         h3qmh/1zlR2Iv0pirCNk6LtsgFgoA23hoP9Bk9lSUSkxnEzgHAgwDk2hbUfB9GT5Agml
         xCIIDYO7zoDjAazYq6bBYMs1MtAdnhbwshdl2PV25k2wwFs+bFEscT6KOYBxumwZd1VF
         Ru8L8VnRQOe1xhE2iHs9zscHtnupk9x++7cYV5CslN7CX4GdmhJSeBmiTX6+FBKoFKyM
         mFnA==
X-Gm-Message-State: AOJu0YzJw0KwCsBMTkWc0U64OvPYJBEfG860WSDj06T9q8w3vTcaC/gn
	grR4y64NLizV7SF2/juKUHGHxG0VNdIPTjiF1O93cYBWLKMTiaBcRdIqCjShwA==
X-Gm-Gg: Acq92OF/ADOSh1SvFZqBAdsTeD0vQmjTsjiSAUux0X+cTpLEthZ7Wujur8c1Y8tO2ID
	htTP86V5K+++So3hsn6Aq/UwcbZO16DWem2mbh1oxnd2YqBxbOzGgeVrQXd7/D/4nNQ7toQnLBc
	lzEQ9LhsxaONJ+WAi2h7WNwuHHkeAOmR+gygHE/4e4VTdF00mpdpA2hStDWl9mThtqIfl0mZG+C
	FjlBM320GSCihvbRLb95XKSdH6IrRz1QO0yX+eK6682r6aqlhKbuEuLCymhqXWfDXGpC/pNg08K
	n2py2iSvCLc6v7g+xmIlSA2xM7fSVEp7yF5B7reGcxcejtY8SNYqAhqJcVyhQk8ujCtErzSv0k5
	w1UNt15zszogdSomYlH0+/TbhgTjQQXbwP99hGtp1XW2LeW5uFYVauGj/uwtmAPQj4w9BbrgJKs
	E8cnlVK8setiA4kkLVDg3TIAqCnjP4EDiMdA5PLMtcTz4rsvHsEuB4rZPB7/k10OnP317/dOD9U
	N0yoK2Pu2l+o8+xzmplMl3BF+DYmFg2rLMA/W2LwOfoSw==
X-Received: by 2002:a17:90b:4b87:b0:368:b01c:85a0 with SMTP id 98e67ed59e1d1-370f0b54dc0mr1064206a91.14.1780621004831;
        Thu, 04 Jun 2026 17:56:44 -0700 (PDT)
Received: from ryzen ([2601:644:8000:5b5d:7285:c2ff:fe45:8a32])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36f68b03ef6sm4516829a91.0.2026.06.04.17.56.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2026 17:56:44 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes@sipsolutions.net>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCHv2 wireless-next] wifi: mac80211: fold tid_ampdu_rx allocations into a flexible array
Date: Thu,  4 Jun 2026 17:56:27 -0700
Message-ID: <20260605005627.317194-1-rosenp@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-37399-lists,linux-wireless=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[rosenp@gmail.com,linux-wireless@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:linux-wireless@vger.kernel.org,m:johannes@sipsolutions.net,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCPT_COUNT_THREE(0.00)[3];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rosenp@gmail.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E6FB96442AE

Convert the separately-allocated reorder_buf pointer to a C99 flexible
array member at the end of struct tid_ampdu_rx, with both the
sk_buff_head and the jiffies timestamp in each array element. This
collapses three allocations into one and removes the corresponding
kfree() pairs from the error and free paths.

Assisted-by: opencode:big-pickle
Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 v2: use anonymous struct to combine allocations
 net/mac80211/agg-rx.c   | 22 +++-------------------
 net/mac80211/rx.c       | 14 +++++++-------
 net/mac80211/sta_info.h | 12 +++++++-----
 3 files changed, 17 insertions(+), 31 deletions(-)

diff --git a/net/mac80211/agg-rx.c b/net/mac80211/agg-rx.c
index cecd1c917e45..1a5647ddd30d 100644
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
index 26138934b72e..3ab77fafd95c 100644
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
@@ -228,6 +225,9 @@ struct tid_ampdu_tx {
  *	and ssn.
  * @removed: this session is removed (but might have been found due to RCU)
  * @started: this session has started (head ssn or higher was received)
+ * @reorder: reorder buffer entries, each with &sk_buff_head @reorder[].buf
+ *	and jiffies @reorder[].time. An MPDU may be an A-MSDU with individually
+ *	reported subframes.
  *
  * This structure's lifetime is managed by RCU, assignments to
  * the array holding it must hold the aggregation mutex.
@@ -241,8 +241,6 @@ struct tid_ampdu_rx {
 	struct rcu_head rcu_head;
 	spinlock_t reorder_lock;
 	u64 reorder_buf_filtered;
-	struct sk_buff_head *reorder_buf;
-	unsigned long *reorder_time;
 	struct sta_info *sta;
 	struct timer_list session_timer;
 	struct timer_list reorder_timer;
@@ -256,6 +254,10 @@ struct tid_ampdu_rx {
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


