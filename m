Return-Path: <linux-wireless+bounces-34414-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8JEqIZ951GlduQcAu9opvQ
	(envelope-from <linux-wireless+bounces-34414-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 07 Apr 2026 05:27:27 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 004F93A9690
	for <lists+linux-wireless@lfdr.de>; Tue, 07 Apr 2026 05:27:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9197D3018288
	for <lists+linux-wireless@lfdr.de>; Tue,  7 Apr 2026 03:27:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46B93372EE3;
	Tue,  7 Apr 2026 03:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nUjzjYza"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D79841A9FBA
	for <linux-wireless@vger.kernel.org>; Tue,  7 Apr 2026 03:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775532443; cv=none; b=PnjDN5Ld1JsqIwij41kBBpNRi4yQ+frIvoZMIrICgxeAuQIdYMMCqtg6DnNY6Br1Gu3lSJvVkD8T2yZPEZdOI1Lmk+DtD80jvcPbfAjME4zBWiVznVKeJ9JqRFBQxHOCLmGY5B/B17YY6EgTJLMu6aOpFD7EX15NwGZ8w4idIfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775532443; c=relaxed/simple;
	bh=BTGRWqkDamRrCkE8SFpfsStqtn8Zy5O6oPx7aiP3jMk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Vq7ILNyL4JdUx498N9mEF1NeOilPLZVCovZ881OJRuipiyFO9fX7NytUKtIUGMGQN+KW2dNxTWRD5F77/w77uS8EU4DTbAMTXMsb+xVIEJlxC3op4oAorclNZu5H63dkDqMVIXCjkBz8w6E2lVZOzv9vLf0N+dc473TE0YoOij0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nUjzjYza; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-7986e538decso46290347b3.1
        for <linux-wireless@vger.kernel.org>; Mon, 06 Apr 2026 20:27:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775532441; x=1776137241; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pINxwcLmFeu0LzI7j9kan7HKdcBO5MqBxoPH2nIMDVg=;
        b=nUjzjYzavo0xLFQI1LH8utPHKBPCcXWD/kiboONuSqU01JkltwczZRseIyl4Bvq2FW
         +Wjr7gcgXsXlu+apfbfJFLYwzglANH4HAUMsMQn3jfuyjFrfKvFw3F48QkhBX8vv3dQS
         behMIZFECu+iYMHmnsXKQcMZr63qIeWX7TcnlAZHK8/JAhitdQ/DDbe+58Rtjs+lf9Xf
         RbBAqGoCKEN2TJFsOZecT42hZRLQp9jZT9kFdZ/1u/UMBcbnD3TUvA0EYmIsfM2lzqyR
         JSUYQHvVn7QRhvTGa+FdnS2ewFR24oGSeJzb+jCpFTkQCMeZUle0Vse5WpIvBPbRmEPD
         8G6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775532441; x=1776137241;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pINxwcLmFeu0LzI7j9kan7HKdcBO5MqBxoPH2nIMDVg=;
        b=Oq0Cb30tJX1IyyaYQAQ2rCRaN3Q9gMiiqsNOHmb6xCATVwDKGc9N+8i1d5Sz5QokF8
         o6FttpNChFwPoYVxdUC7OBPvp81TfCltwILpTB9Zqd/V5MuE7FRhbd/42gR1g1OPNcMZ
         EcXZ1IpPSnVyXXTcmPsbL222nyfikIMxmQ4Ntf+wDsS0zZqA5HR/jSjjL1jKefemXsFl
         QtHjb4lAiT++srMaCUFdrTYrcDE9BJ3IU1XU6xRh4TQWJ5VCy8dldVTXQVXTaLYgr88X
         SIv1VIY/ikqMqLaJ0zsXyhTnPEHhh2vzZoGh9voc6kfkiG9Q9yE28mwFns/hbwHl2i/Y
         JyGA==
X-Gm-Message-State: AOJu0YzEQ5cwi87fluJgu1CqdQbkc6bC9NifduMrd7ohgxERruU3X7No
	J5oafPSlncwefvwyUgg4cpZwdW4sZ0yEOc7Z8mjaJWnOtW4S0mHQeDBLJYmchpLi
X-Gm-Gg: AeBDieto60grgdvAz2SFQY7ZTud9DooYseA8tSE7lIx1p6wSFihUnyQm64S256mjC4R
	PI7muM/Ij2gTY6cQIHpBUCCzGELmvC4B0KONWDQZmh1avuDK2eCKMCbsumqDBHc/dRnZkcogI+k
	c9Dz9qV3fmFB2MRjukWMuzvVnzwuuii32gPiALG7j+YmJUlVMDZoXVaaADv93EVpUDX6f9+v8n9
	IwbOEeX70ZoZSMVqAr0f6UConKDWZDINrXfvzeZJbo9yl+4srt0+nC+2Nbg8Rs8mF9aKaRCEW0u
	qWyC4a2hYd3anPIBfXsXy4LyWtCm2U4kJRpZf9MVLGco8PbT8JN4rEVAY6U/Xqo7Qd6Ea/jk986
	Du3zjr9GnwbR1Fh6frTII7/ERd1dpl1vrCoTcKQQvvFnla+GRAH5IZksPCczv3TMMA5dn/unn9G
	R2MWhx/AyqO299hoC5DKnDVFnSQSSJtu8lmpQv8TwvhvCW6+fL7Ikq2VuzCvVG
X-Received: by 2002:a05:690c:8e10:b0:78f:9801:7606 with SMTP id 00721157ae682-7a4d84c5bb0mr124496127b3.34.1775532440790;
        Mon, 06 Apr 2026 20:27:20 -0700 (PDT)
Received: from DEV.lan (c-75-74-152-49.hsd1.fl.comcast.net. [75.74.152.49])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7a36ea289e5sm61857687b3.18.2026.04.06.20.27.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Apr 2026 20:27:18 -0700 (PDT)
From: Joshua Klinesmith <joshuaklinesmith@gmail.com>
To: linux-wireless@vger.kernel.org
Cc: nbd@nbd.name,
	lorenzo@kernel.org,
	Joshua Klinesmith <joshuaklinesmith@gmail.com>
Subject: [PATCH wireless-next] wifi: mt76: use wait_event_interruptible in worker thread for PREEMPT_RT
Date: Mon,  6 Apr 2026 23:27:12 -0400
Message-ID: <20260407032712.57868-1-joshuaklinesmith@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[nbd.name,kernel.org,gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-34414-lists,linux-wireless=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[joshuaklinesmith@gmail.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-0.999];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 004F93A9690
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The mt76 worker thread uses a manual set_current_state(TASK_INTERRUPTIBLE)
/ schedule() loop. On PREEMPT_RT kernels, this pattern triggers:

  BUG: scheduling while atomic: mt76-usb-rx phy/2852/0x00000002

The manual task state manipulation interacts poorly with RT's preemption
model, where different locking and state transition semantics apply.

Replace the open-coded sleep loop with wait_event_interruptible() on a
new wait_queue_head embedded in struct mt76_worker. The schedule point
becomes an RT-safe wait_event that properly handles the task state
transitions. Update mt76_worker_schedule() to use wake_up() to signal
the wait queue.

This follows the standard kernel pattern for kthread wait loops and
eliminates the need for manual set_current_state() calls entirely.

Link: https://github.com/openwrt/mt76/issues/1053
Signed-off-by: Joshua Klinesmith <joshuaklinesmith@gmail.com>
---
 drivers/net/wireless/mediatek/mt76/util.c | 8 ++++----
 drivers/net/wireless/mediatek/mt76/util.h | 5 ++++-
 2 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/util.c b/drivers/net/wireless/mediatek/mt76/util.c
index 83d3dc42e534..452c303d8a68 100644
--- a/drivers/net/wireless/mediatek/mt76/util.c
+++ b/drivers/net/wireless/mediatek/mt76/util.c
@@ -111,20 +111,20 @@ int __mt76_worker_fn(void *ptr)
 	struct mt76_worker *w = ptr;
 
 	while (!kthread_should_stop()) {
-		set_current_state(TASK_INTERRUPTIBLE);
-
 		if (kthread_should_park()) {
 			kthread_parkme();
 			continue;
 		}
 
 		if (!test_and_clear_bit(MT76_WORKER_SCHEDULED, &w->state)) {
-			schedule();
+			wait_event_interruptible(w->wq,
+				test_bit(MT76_WORKER_SCHEDULED, &w->state) ||
+				kthread_should_stop() ||
+				kthread_should_park());
 			continue;
 		}
 
 		set_bit(MT76_WORKER_RUNNING, &w->state);
-		set_current_state(TASK_RUNNING);
 		w->fn(w);
 		cond_resched();
 		clear_bit(MT76_WORKER_RUNNING, &w->state);
diff --git a/drivers/net/wireless/mediatek/mt76/util.h b/drivers/net/wireless/mediatek/mt76/util.h
index 617966e8de76..a1ac52753a3f 100644
--- a/drivers/net/wireless/mediatek/mt76/util.h
+++ b/drivers/net/wireless/mediatek/mt76/util.h
@@ -9,12 +9,14 @@
 #include <linux/skbuff.h>
 #include <linux/bitops.h>
 #include <linux/bitfield.h>
+#include <linux/wait.h>
 #include <net/mac80211.h>
 
 struct mt76_worker
 {
 	struct task_struct *task;
 	void (*fn)(struct mt76_worker *);
+	wait_queue_head_t wq;
 	unsigned long state;
 };
 
@@ -63,6 +65,7 @@ mt76_worker_setup(struct ieee80211_hw *hw, struct mt76_worker *w,
 
 	if (fn)
 		w->fn = fn;
+	init_waitqueue_head(&w->wq);
 	w->task = kthread_run(__mt76_worker_fn, w,
 			      "mt76-%s %s", name, dev_name);
 
@@ -82,7 +85,7 @@ static inline void mt76_worker_schedule(struct mt76_worker *w)
 
 	if (!test_and_set_bit(MT76_WORKER_SCHEDULED, &w->state) &&
 	    !test_bit(MT76_WORKER_RUNNING, &w->state))
-		wake_up_process(w->task);
+		wake_up(&w->wq);
 }
 
 static inline void mt76_worker_disable(struct mt76_worker *w)
-- 
2.43.0


