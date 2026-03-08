Return-Path: <linux-wireless+bounces-32722-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WBxiAUHirWks8wEAu9opvQ
	(envelope-from <linux-wireless+bounces-32722-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sun, 08 Mar 2026 21:55:29 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8968C23235B
	for <lists+linux-wireless@lfdr.de>; Sun, 08 Mar 2026 21:55:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4A15D300BCAD
	for <lists+linux-wireless@lfdr.de>; Sun,  8 Mar 2026 20:55:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF429328B58;
	Sun,  8 Mar 2026 20:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NYL2LuRX"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AC59352C22
	for <linux-wireless@vger.kernel.org>; Sun,  8 Mar 2026 20:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773003323; cv=none; b=fcncJqgtGxuWTyZMmfn2AzoGw9DOJVZkZUjqZsKctp9hUfZwY2viGTi8CldOKdDezDqqWiyWrUUOtDvrgSY0ofknKU/I40JwQuDuq0M6J7SHAP241WrZHxLYT50Ia3+oi2uqukXIEnTTNl8ao0TJGd3ITl/S/zjV0DkKxVDiZx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773003323; c=relaxed/simple;
	bh=V+HaIjOxeZCvqXsVvP4U91p/1MNE7Xa2RqirRnIi+Fs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uqD99oZusJeIpISj8A7pqKvXIR0RTi7gkUrCQwA/ZUJdvD+OimvU9yxx4bPVij6LhCYdskeKM427dt8rwG83zC0pUu78Mro5GtZvQ2Dp68fs6qTAGsXej7cPNKozEzbgPwM+29p5J2DB/eozbc3/5KHMPBHDeyrMdtdDEXFOVuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NYL2LuRX; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-35980423087so3823364a91.3
        for <linux-wireless@vger.kernel.org>; Sun, 08 Mar 2026 13:55:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773003322; x=1773608122; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dSbXQF0TQ/oDDYSYqKtbfxF1Vwex7qbylX5vtAN5cVI=;
        b=NYL2LuRXV/lfh7HitJmrW+4anrxO+JyAloZDn1LzlCATHj1ZWUb/YlB7khmikVwEF4
         J93r9H5p7zLOc3Q+5QrJ1Wsg7bw7VQAwYzjjpelur/F/UdwrW1o83AACINJnU98ioIPR
         i0M7E8888eroHb3CH53XnBccWEgJyhNKol5mmpV1wWOWsb6X14VIZi9WlVb2ffpDRyIn
         TfLoTl3YnpoCzhxNuN7zu7SzEdcjTcTkl9XqMwTcoO5lVM2+CP7RFIsRnwq/ooX77qGN
         FpOKK5foYEuhve3RHxhwj/CpKPw5kkVr0ZQezXcl7uUPhMgJNJ37DigEP81cIQR4gqnh
         2xKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773003322; x=1773608122;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dSbXQF0TQ/oDDYSYqKtbfxF1Vwex7qbylX5vtAN5cVI=;
        b=twSI25fickT21B3c1Ok89+nqfzwhUJjKsHbH3CLiymZ9xtaKo96zji9+ai8qRyLP1P
         zG/+6WCA+iOmD+BPUSaQbzsGOraMOn09kkDL3Cms3LWkwSBYyr1XxRNtBBdpITO2vthM
         jQb/WQ+Hng/K9uA9XNRFK2nZjKF9oqzA6wduNAERzEQMjlMCM1erqe6tLlzqYEO/eTP1
         CCCWUfy6cue/eBdVnAKqna8exp3eAN7gJb7fg0GkSkD0od5vdC0BmHzn5D167+ls18YY
         LCSWIEzbFrZtSVVjb8b4n4fijzbnWXbAlpBOkz6I0xjMVmXEM6Eh9oIBy1LakPXHYnFX
         dqbA==
X-Gm-Message-State: AOJu0YwcouLvSzSeTgm4CefxeYffrMSY/+N7TojUFeyXFpXTc/gZLoiA
	BVeOqavvI4HydXQQuOC1z95RgJCYMljEZjW0XXgPLYoPvW4BcABWzKdcVCOBnBVH
X-Gm-Gg: ATEYQzyVybjoKgXVYYChe+S0ZUMh4SeOo+RKSlY8q760j+GjbBn7KzqW1JU/lE29CYP
	t8JwZo06yT04eQyQ/SaEJXSNqEqzA0Xucd27IJRowB986hjVo9Y4RO+B2l4VCpyhYS1FhwgNOFH
	NLxX3JRS3LRtuQEqvDcbAMPdNvGy55+8pWvbYWfa+YY7r4/PHFz7MZkZjXiQ5xAqsMoCpNQ9WZI
	xKdTSmpqhnB2nvy6sOvD+iZsKh139+qKw4JNBsWrK6LXpp6ok9rtGzbvceWzuzxB/HLNU8MgW9F
	ozfdwFYrtK9mWqxCzqxtASppc4JSk7akHiwXXu6AX9nNNlNnbpTxBYf1/oeWfY/d+/ZfcyZqSZu
	LRjJ5qTRQbnvjLaUO+d1Cipyx8MQguZbEOKBlM8WF2DPwrBEu8m7IemJ/d4Cb9929eZ6FxHROyS
	fQF9haXvZlq8xoFR+pPsaJlP5ohDzrHGN+Bim/u37moIza9nb3DsYQTXG/F0hCz1xL
X-Received: by 2002:a17:90b:33c7:b0:359:8eaa:7f42 with SMTP id 98e67ed59e1d1-359be2f90edmr8194647a91.18.1773003321560;
        Sun, 08 Mar 2026 13:55:21 -0700 (PDT)
Received: from ryzen ([2601:644:8000:56f5::8bd])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c739e195c40sm6951607a12.31.2026.03.08.13.55.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Mar 2026 13:55:21 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linux-wireless@vger.kernel.org
Cc: Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-kernel@vger.kernel.org (open list),
	linux-hardening@vger.kernel.org (open list:KERNEL HARDENING (not covered by other areas):Keyword:\b__counted_by(_le|_be)?\b)
Subject: [PATCH ath-next] wifi: wil6210: use kzalloc_flex in wil_tid_ampdu_rx
Date: Sun,  8 Mar 2026 13:55:04 -0700
Message-ID: <20260308205504.26819-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 8968C23235B
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-32722-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rosenp@gmail.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-0.965];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

Use it to simplify allocation and freeing.

Add __counted_by for extra runtime analysis.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/net/wireless/ath/wil6210/rx_reorder.c | 13 +++----------
 drivers/net/wireless/ath/wil6210/wil6210.h    |  4 ++--
 2 files changed, 5 insertions(+), 12 deletions(-)

diff --git a/drivers/net/wireless/ath/wil6210/rx_reorder.c b/drivers/net/wireless/ath/wil6210/rx_reorder.c
index 5841098ff8f9..3f11c6090234 100644
--- a/drivers/net/wireless/ath/wil6210/rx_reorder.c
+++ b/drivers/net/wireless/ath/wil6210/rx_reorder.c
@@ -241,21 +241,15 @@ void wil_rx_bar(struct wil6210_priv *wil, struct wil6210_vif *vif,
 struct wil_tid_ampdu_rx *wil_tid_ampdu_rx_alloc(struct wil6210_priv *wil,
 						int size, u16 ssn)
 {
-	struct wil_tid_ampdu_rx *r = kzalloc_obj(*r);
+	struct wil_tid_ampdu_rx *r;

+	r = kzalloc_flex(*r, reorder_buf, size);
 	if (!r)
 		return NULL;

-	r->reorder_buf =
-		kzalloc_objs(struct sk_buff *, size);
-	if (!r->reorder_buf) {
-		kfree(r);
-		return NULL;
-	}
-
+	r->buf_size = size;
 	r->ssn = ssn;
 	r->head_seq_num = ssn;
-	r->buf_size = size;
 	r->stored_mpdu_num = 0;
 	r->first_time = true;
 	r->mcast_last_seq = U16_MAX;
@@ -278,7 +272,6 @@ void wil_tid_ampdu_rx_free(struct wil6210_priv *wil,
 	for (i = 0; i < r->buf_size; i++)
 		kfree_skb(r->reorder_buf[i]);

-	kfree(r->reorder_buf);
 	kfree(r);
 }

diff --git a/drivers/net/wireless/ath/wil6210/wil6210.h b/drivers/net/wireless/ath/wil6210/wil6210.h
index 31e107c81e2d..768e6573cd29 100644
--- a/drivers/net/wireless/ath/wil6210/wil6210.h
+++ b/drivers/net/wireless/ath/wil6210/wil6210.h
@@ -659,7 +659,6 @@ struct pci_dev;
 /**
  * struct wil_tid_ampdu_rx - TID aggregation information (Rx).
  *
- * @reorder_buf: buffer to reorder incoming aggregated MPDUs
  * @last_rx: jiffies of last rx activity
  * @head_seq_num: head sequence number in reordering buffer.
  * @stored_mpdu_num: number of MPDUs in reordering buffer
@@ -672,9 +671,9 @@ struct pci_dev;
  * @first_time: true when this buffer used 1-st time
  * @mcast_last_seq: sequence number (SN) of last received multicast packet
  * @drop_dup_mcast: duplicate multicast frames dropped for this reorder buffer
+ * @reorder_buf: buffer to reorder incoming aggregated MPDUs
  */
 struct wil_tid_ampdu_rx {
-	struct sk_buff **reorder_buf;
 	unsigned long last_rx;
 	u16 head_seq_num;
 	u16 stored_mpdu_num;
@@ -687,6 +686,7 @@ struct wil_tid_ampdu_rx {
 	bool first_time; /* is it 1-st time this buffer used? */
 	u16 mcast_last_seq; /* multicast dup detection */
 	unsigned long long drop_dup_mcast;
+	struct sk_buff *reorder_buf[] __counted_by(buf_size);
 };

 /**
--
2.53.0


