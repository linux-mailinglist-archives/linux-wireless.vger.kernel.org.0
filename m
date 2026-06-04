Return-Path: <linux-wireless+bounces-37369-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id G/nGBL3EIGr37gAAu9opvQ
	(envelope-from <linux-wireless+bounces-37369-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 04 Jun 2026 02:20:13 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 67A0463C08E
	for <lists+linux-wireless@lfdr.de>; Thu, 04 Jun 2026 02:20:12 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=qTsLSklC;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-37369-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-37369-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 80EC2304D7C3
	for <lists+linux-wireless@lfdr.de>; Thu,  4 Jun 2026 00:14:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AA8532C8B;
	Thu,  4 Jun 2026 00:14:49 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5F19AD24
	for <linux-wireless@vger.kernel.org>; Thu,  4 Jun 2026 00:14:47 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780532088; cv=none; b=NweRyNNhQlhw4ujN+VfzquBGahdb7QbGu3w0d1OjX2aa7RAx4xki/GyH3C7IB07Sp+8tJL4tLMigXKxDws9LqNkn97MAEXC5UlZTl5oX5BjxOm6WOUYnG9p3+0GP4DlR47akntZ391byFJxIFIZXfuQViZuSYYyUib0G9F/Vrvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780532088; c=relaxed/simple;
	bh=uRUwW8sJEn66H88eqi7V403X+OCJlfaNIvy1M5GTx4M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=c/Eivz4RGc7KWYweIsqpPWlu1LPrnX1leQhI1Ml2894BqL47XD5bnT+EGSraiBMgBqWlkzZa7pFcm66xa+DkK4eALrCdSpCTpLyrlwzHRYf8+F0YN5Mf5ImYfunLFganuxU4l5To0YNHJtgrgU++UlAOTHj7Vq8kNrXN8PCS2Is=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qTsLSklC; arc=none smtp.client-ip=209.85.215.169
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-c858cc9870aso669616a12.0
        for <linux-wireless@vger.kernel.org>; Wed, 03 Jun 2026 17:14:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780532087; x=1781136887; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=86GCrPPX3bP7K5pDkgyiAoWdFZ0y9yG0vMKrhP9/ARA=;
        b=qTsLSklCw6nGiDiE60q43R7qfweW4AITbacWNQ+wcwcnPGSEL9WIumdAvcvTvgfDBj
         8atcxUvlCxdCN5S5brGSp/tO8/oUUPvWEADZ6C3r1CC7OaSnRdqxWP2UkiTyUvmPAyZ0
         iciJIqndm3c320zD7gwocIXVBXhD9wWKIvK9Nf9Gj8D09Z2KTBSgfBwXIt26xZmO0jAp
         pp7ddPNacyFydjemD2gfrydi8j2WRJMZF0GprQLGw/SapEpnujnokeqL3haxq63P01kX
         kD+p18WWVsYSG4qDWWtRnL2G9e8txLDlb1Mm/16et61j3FtjmfXPoXFcSVZ7e/k2ZwzW
         YorA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780532087; x=1781136887;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=86GCrPPX3bP7K5pDkgyiAoWdFZ0y9yG0vMKrhP9/ARA=;
        b=gSpXJl2bTAB6jXUR0M1ARC1s93mC3nh0cGGODGxpmgs2TggJTPGUFdspo8kp13Rrcq
         YJ55n/0d3VFuQf7JFKIkHeQHbdP3GYG7a5D3ZBOhVmfkATVz47vFE6i9SGLU9YPBtE7a
         +B0GySRtXlxNkEBae1jaQzQrKhCU6FBu0S4shrAKuCjAh/GS4bFLIyjI4ltYHXK8B5et
         gYT64/bmqL5tYVb45QP5UgRBXNtmKMOcUofnukJrQPXI3Sb14djdMzuxMBVMhLDmagmZ
         5gYIDmIxzpfLZz3r0zrgB4jreFVZCMLq8h2yFsE01pxf3+zc4JzU3A8JaQHSUTwA9Sms
         tLZg==
X-Gm-Message-State: AOJu0YxA5BRzZaFT3ZghuG5JGHg+5oogn4EtirLjRPqTNQAskxwv5fSQ
	QRIQ+zC51bVMbNtLaTK95w01gSTx92LV/7DVUcLebpZf1pYWSt1Jdfjj0v1hjc+X
X-Gm-Gg: Acq92OHUfDqmxeGez4fi5n8W2gmFOt2ooqvg9/aEnqQuhIZml74HEpuxQyApmI/XgqR
	N0fQsKiOGDjHvDdX6/A2gZG9mETJeOvi5sEZRN+h+UWdbSmTSP5lKcRwbgwRKe6/SMxRhGsBUWF
	fLiP3nzVtW8Vr2Xy1W/FTqyby6OQah4xtUW9kows43ehEd4Bxu/JN77Ul6dJdLIewSeHfIXzIz1
	28mpU090VlStAXiSf2LWwWmlaICPo5U3HIGic0kv8pSdFjpqzT4liLujG56cQH1rEyIBpoZirnG
	bWEKCf7Xy0Mu9fVadlGhCCed8KF3zxMu2DFwuBs0G6Di99ooKPg0QAs2bRCkIAwEKMr1vkoZy0r
	lyRFYOIxl+TqLRd25Aq9+ORK+i4E3UJgR6Pd2NpkmcftqqMhB89hkgRa0uvW4rGGQXOIQQv6AWO
	dUBxfTeiAm5YDZxaFfr0qcWIGquFnFTrLLZM/WbgpDSGCRv3oqZKEugHZ1UcG7cS9iOCNJhmPHg
	1s1rzQijmqdnfUj58asLIkKjtd1LN5HVbAS+e3tiF9BuQ==
X-Received: by 2002:a17:903:380d:b0:2bd:2c3a:2a36 with SMTP id d9443c01a7336-2c1951d279dmr13550705ad.0.1780532086757;
        Wed, 03 Jun 2026 17:14:46 -0700 (PDT)
Received: from ryzen ([2601:644:8000:5b5d:7285:c2ff:fe45:8a32])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c164f6d395sm51498375ad.17.2026.06.03.17.14.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jun 2026 17:14:45 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes@sipsolutions.net>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH wireless-next] wifi: mac80211: fold tid_ampdu_rx allocations into a flexible array
Date: Wed,  3 Jun 2026 17:14:27 -0700
Message-ID: <20260604001427.16466-1-rosenp@gmail.com>
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
	TAGGED_FROM(0.00)[bounces-37369-lists,linux-wireless=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[rosenp@gmail.com,linux-wireless@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:linux-wireless@vger.kernel.org,m:johannes@sipsolutions.net,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 67A0463C08E

Convert the separately-allocated reorder_buf pointer to a C99 flexible
array member at the end of struct tid_ampdu_rx, and place reorder_time
in the same allocation immediately after it. This collapses three
allocations into one and removes the corresponding kfree() pairs from
the error and free paths.

Assisted-by: Claude:Opus-4.7
Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 net/mac80211/agg-rx.c   | 23 ++++++-----------------
 net/mac80211/sta_info.h |  6 +++---
 2 files changed, 9 insertions(+), 20 deletions(-)

diff --git a/net/mac80211/agg-rx.c b/net/mac80211/agg-rx.c
index cecd1c917e45..20669cd8a34f 100644
--- a/net/mac80211/agg-rx.c
+++ b/net/mac80211/agg-rx.c
@@ -50,8 +50,6 @@ static void ieee80211_free_tid_rx(struct rcu_head *h)

 	for (i = 0; i < tid_rx->buf_size; i++)
 		__skb_queue_purge(&tid_rx->reorder_buf[i]);
-	kfree(tid_rx->reorder_buf);
-	kfree(tid_rx->reorder_time);
 	kfree(tid_rx);
 }

@@ -294,6 +292,7 @@ void __ieee80211_start_rx_ba_session(struct sta_info *sta,
 	};
 	int i, ret = -EOPNOTSUPP;
 	u16 status = WLAN_STATUS_REQUEST_DECLINED;
+	size_t alloc_size;
 	u16 max_buf_size;

 	lockdep_assert_wiphy(sta->local->hw.wiphy);
@@ -412,10 +411,14 @@ void __ieee80211_start_rx_ba_session(struct sta_info *sta,
 	}

 	/* prepare A-MPDU MLME for Rx aggregation */
-	tid_agg_rx = kzalloc_obj(*tid_agg_rx);
+	alloc_size = struct_size(tid_agg_rx, reorder_buf, buf_size);
+	alloc_size += sizeof(*tid_agg_rx->reorder_time) * buf_size;
+	tid_agg_rx = kzalloc(alloc_size, GFP_KERNEL);
 	if (!tid_agg_rx)
 		goto end;

+	tid_agg_rx->reorder_time = (void *)(tid_agg_rx->reorder_buf + buf_size);
+
 	spin_lock_init(&tid_agg_rx->reorder_lock);

 	/* rx timer */
@@ -426,18 +429,6 @@ void __ieee80211_start_rx_ba_session(struct sta_info *sta,
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
 		__skb_queue_head_init(&tid_agg_rx->reorder_buf[i]);

@@ -445,8 +436,6 @@ void __ieee80211_start_rx_ba_session(struct sta_info *sta,
 	ht_dbg(sta->sdata, "Rx A-MPDU request on %pM tid %d result %d\n",
 	       sta->sta.addr, tid, ret);
 	if (ret) {
-		kfree(tid_agg_rx->reorder_buf);
-		kfree(tid_agg_rx->reorder_time);
 		kfree(tid_agg_rx);
 		goto end;
 	}
diff --git a/net/mac80211/sta_info.h b/net/mac80211/sta_info.h
index 39608a0abbb5..66adfc5c89b2 100644
--- a/net/mac80211/sta_info.h
+++ b/net/mac80211/sta_info.h
@@ -207,8 +207,6 @@ struct tid_ampdu_tx {
 /**
  * struct tid_ampdu_rx - TID aggregation information (Rx).
  *
- * @reorder_buf: buffer to reorder incoming aggregated MPDUs. An MPDU may be an
- *	A-MSDU with individually reported subframes.
  * @reorder_buf_filtered: bitmap indicating where there are filtered frames in
  *	the reorder buffer that should be ignored when releasing frames
  * @reorder_time: jiffies when skb was added
@@ -228,6 +226,8 @@ struct tid_ampdu_tx {
  *	and ssn.
  * @removed: this session is removed (but might have been found due to RCU)
  * @started: this session has started (head ssn or higher was received)
+ * @reorder_buf: buffer to reorder incoming aggregated MPDUs. An MPDU may be an
+ *	A-MSDU with individually reported subframes.
  *
  * This structure's lifetime is managed by RCU, assignments to
  * the array holding it must hold the aggregation mutex.
@@ -241,7 +241,6 @@ struct tid_ampdu_rx {
 	struct rcu_head rcu_head;
 	spinlock_t reorder_lock;
 	u64 reorder_buf_filtered;
-	struct sk_buff_head *reorder_buf;
 	unsigned long *reorder_time;
 	struct sta_info *sta;
 	struct timer_list session_timer;
@@ -256,6 +255,7 @@ struct tid_ampdu_rx {
 	u8 auto_seq:1,
 	   removed:1,
 	   started:1;
+	struct sk_buff_head reorder_buf[];
 };

 /**
--
2.54.0


