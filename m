Return-Path: <linux-wireless+bounces-35223-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6qacG7YH6WmgTQIAu9opvQ
	(envelope-from <linux-wireless+bounces-35223-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 22 Apr 2026 19:39:02 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B7A0E4494C2
	for <lists+linux-wireless@lfdr.de>; Wed, 22 Apr 2026 19:39:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5092B302BA6E
	for <lists+linux-wireless@lfdr.de>; Wed, 22 Apr 2026 17:38:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83F5737EFF7;
	Wed, 22 Apr 2026 17:38:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M6rwZLP4"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 513AE35838A
	for <linux-wireless@vger.kernel.org>; Wed, 22 Apr 2026 17:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776879537; cv=none; b=onoOWp8cpaF3pxzlgqN9tcM4On3o+RVTrlKqXigefKWRQQ3/njZiMYPGG10xAboZ6tZk2dq/oMUKGb8aEL5xZX7xVxLDADd2h8x7/AVyjRGgh+moyueUDw1JleghdYtAbUnHOgspDENYEhc6OeiYgxiRtqtf4PhajB5U2/gYeHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776879537; c=relaxed/simple;
	bh=bFP5AY+UYMSrKv1tWAgu98ebUaRPsKu3WMtQE+No8Po=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=O6qkEzADoW3lKDy2fl8ZTks/hXGQ7aPJWdrUBKm065707Pzx6sjcoyV1MJflC4jpC0ed9MQDyXauNhLN36PG775MN4ui+eLzmXTb1Z7Q2Jzj8hEQOCTJUwNkmNNJO7CxONV7fSf2h8dBO9q126RsLr6nd4L3xhaif+r2dixa9PI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M6rwZLP4; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-82f9fdfc965so2181784b3a.1
        for <linux-wireless@vger.kernel.org>; Wed, 22 Apr 2026 10:38:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776879536; x=1777484336; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NEFtXcpoTUuSx2EDCkhHpiXviuYOC89Clel/2QQUNdI=;
        b=M6rwZLP4eXmqVS4bj2zvnY3V6mXoQ+XH6oiAE12QgXwPCnY78iPJtXjcB0YI2FE7Li
         gJ/D0hWs2S3UBPoJ00uXHRfEIXYsE93rB+P0rwqroIfFzOZ00zyCPw9MKedwEQfDvVhq
         0yiWHTYm/MwsdBhR3n+fbIWaialy/Ha3TYjKfypV2O51tmU9QzVexYe/kHfqNTn06BcD
         XfSVI2CZg+3nKfE8pwg9CGUJVlh41lpxX14kAJEraexfpHTrJsFbME6FsAeeVZheY+Jy
         aVvDYy72R9pV/xu+FIxBD9l3l8OKBigx4iwIoiU9oXy4PuZbKVjXhLkWpFLsmBiMq15M
         LCtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776879536; x=1777484336;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NEFtXcpoTUuSx2EDCkhHpiXviuYOC89Clel/2QQUNdI=;
        b=P2xujiazlZvPU3iSAg6vUQvusPRodsDNAt+EM6macmWGLBrcg2U8CAjvGQXBkRcG7u
         Oi2HKkX7Rgq9fUj6M5SMK3OAfeZxi1JutrulVyYX28eYvtHkr1VVXsv4JFE3YL0W+nkl
         +sRM6++VbLa/SicPVN8Vh4yE0hAHyhRIfyck/7hKncC+4ZSCMp+6YXGal7oVYEzh7ebw
         vaNAK617JIGyq1Bt98kTDFW7pOdUCKEajuV6cgock8Gy/HmXix+9Fb4V6TbnB8VeA579
         RAeVL0uTOyRNHBtMPHKpfJ8HmLRLih7QEWjJ0Q+BWDxLkrLjCZvK9+eyKbIwmgnpRgRw
         MWLQ==
X-Gm-Message-State: AOJu0YwvvNUVVgrOc6doAbhLWwjGMyyMn+ycUY/zyF7tOIwdSUeAe5nK
	IN0s/fKeAHgQlHS56aR0l/Ohfq/SyfD7isC4WdFkiAjdHjp9ZtKYSb9p8ZhSKA==
X-Gm-Gg: AeBDietdygRK2X73CPmabdMmP5uhbffzIfBmqCkzgvr6aynkSSnZRarg7LcTdiUorzo
	eqFbNUNiinGUa8FMDwpw4EIvIRuQdf6pAIJ3WZw8FoSLbZ/Hd88ZwbAEa9NoBrdh9MfVxbrt2j0
	M/qGCyJiPMykGTxF3krto9btYDeNPuzhopcKbkf88+eSxoVLGam5LWZTAsaAQXkqf1M4g6ZCVls
	IwWdke9ScvYpCawlr9PS0HSpzaa3bybbGFBNsGPQMPZtr6u8WYKHJyWWF2N7SkK5WKniyhjEaBV
	1CQL9M1PTiNtZzfl8v4xti8bJ9lMerPrbh034q9Up/5NeAo+n+zvQosO/trexJE7SSkQeRpoXvF
	m0+QCtJvXWbcMvBumvSjubwOc3WLzMroy1/HE5pjL760SwKJ40m9bd6HZKunmlV9mej4namDGAO
	xJuoLBuxX4Fr3kZ5NuXAnW389RDdzpfwDUYzGlay8bJt4oJUY2M1iQmA==
X-Received: by 2002:a05:6a00:1826:b0:82f:37e3:ae6e with SMTP id d2e1a72fcca58-82f8c961f73mr25139528b3a.31.1776879535597;
        Wed, 22 Apr 2026 10:38:55 -0700 (PDT)
Received: from name2965-Precision-7820-Tower.. ([14.48.8.61])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82f8ec0307esm18014517b3a.53.2026.04.22.10.38.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Apr 2026 10:38:55 -0700 (PDT)
From: Jeongjun Park <aha310510@gmail.com>
To: Johannes Berg <johannes.berg@intel.com>,
	Kalle Valo <kvalo@kernel.org>
Cc: linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzbot+5de83f57cd8531f55596@syzkaller.appspotmail.com,
	stable@vger.kernel.org,
	Jeongjun Park <aha310510@gmail.com>
Subject: [PATCH] wifi: rsi: fix kthread lifetime race between self-exit and external-stop
Date: Thu, 23 Apr 2026 02:38:46 +0900
Message-Id: <20260422173846.37640-1-aha310510@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,syzkaller.appspotmail.com,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-35223-lists,linux-wireless=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aha310510@gmail.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless,5de83f57cd8531f55596];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,appspotmail.com:email]
X-Rspamd-Queue-Id: B7A0E4494C2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

RSI driver use both self-exit(kthread_complete_and_exit) and external-stop
(kthread_stop) when killing a kthread. Generally, kthread_stop() is called
first, and in this case, no particular issues occur.

However, in rare instances where kthread_complete_and_exit() is called
first and then kthread_stop() is called, a UAF occurs because the kthread
object, which has already exited and been freed, is accessed again.

Therefore, to prevent this with minimal modification, you must remove
kthread_stop() and change the code to wait until the self-exit operation
is completed.

Cc: <stable@vger.kernel.org>
Reported-by: syzbot+5de83f57cd8531f55596@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/all/69e5d03b.a00a0220.1bd0ca.0064.GAE@google.com/
Fixes: 4c62764d0fc2 ("rsi: improve kernel thread handling to fix kernel panic")
Signed-off-by: Jeongjun Park <aha310510@gmail.com>
---
 drivers/net/wireless/rsi/rsi_common.h | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/rsi/rsi_common.h b/drivers/net/wireless/rsi/rsi_common.h
index 591602beeec6..3cdf9ded876d 100644
--- a/drivers/net/wireless/rsi/rsi_common.h
+++ b/drivers/net/wireless/rsi/rsi_common.h
@@ -70,12 +70,11 @@ static inline int rsi_create_kthread(struct rsi_common *common,
 	return 0;
 }
 
-static inline int rsi_kill_thread(struct rsi_thread *handle)
+static inline void rsi_kill_thread(struct rsi_thread *handle)
 {
 	atomic_inc(&handle->thread_done);
 	rsi_set_event(&handle->event);
-
-	return kthread_stop(handle->task);
+	wait_for_completion(&handle->completion);
 }
 
 void rsi_mac80211_detach(struct rsi_hw *hw);
--

