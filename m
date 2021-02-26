Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 914EA326683
	for <lists+linux-wireless@lfdr.de>; Fri, 26 Feb 2021 18:54:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230230AbhBZRxH (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 26 Feb 2021 12:53:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230147AbhBZRw7 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 26 Feb 2021 12:52:59 -0500
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com [IPv6:2607:f8b0:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86ACEC061788
        for <linux-wireless@vger.kernel.org>; Fri, 26 Feb 2021 09:52:19 -0800 (PST)
Received: by mail-il1-x12c.google.com with SMTP id k2so8724436ili.4
        for <linux-wireless@vger.kernel.org>; Fri, 26 Feb 2021 09:52:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KzQ9OBQajFeaiUpGgz5pU1UyInmaQ1PIgYZOHvN7J2s=;
        b=QmEx6PMwk5EzxsrPZJ6iRfQ/ny2qMbBfnWObiy0RKj7IzCtCtGd2xn3nfRRPTWrMDn
         8qODazbWCshriSjXgg2GqqfyIxkQxBwY1cmWSxb2GEk7YRApPYA3iYuVChku9DJatqOG
         Rg8jTRSgD/ztSQ1+1eAYv8ZZWPYSsXyi4jNH0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KzQ9OBQajFeaiUpGgz5pU1UyInmaQ1PIgYZOHvN7J2s=;
        b=cy81kSAk2BdUemT2M5iV7IyVGMkIJO2vh3ZhXkhLFH9U8ER+D5Uq9d62jBCLMBSHYT
         b6GP2nAZM6UE6vAgK7L5G0gMoF1rkNfubUGw7hYxZ5kjZkSKBFPxHAChck9h/dWhh+rq
         z6hBoa/xl17vHMODIHtEhk+DdABbQU/y9VlGWt1yoeyvYQDSgrChxRo7P7jsT3909Ba5
         Yp9ZhtCO4E3ezFKp8IO2c7mF9U1cGeXGgWdVXv34hFVo2eomqqzyOFIiiNnaPKAmx1Zi
         HqjdSOnOH/JX1btlzJT5bQKZwek1I4xjtoaxUkC4G0lyPL7pHiabQW1IxFymmVOg57uX
         KPeQ==
X-Gm-Message-State: AOAM530hNJlAAbbXUVL7Zj5TOm9sjAt3gFplYDLVOUfQUcR2ZhXn0L7U
        E2akNm83piyMTT9/dz/Jg0CWHg==
X-Google-Smtp-Source: ABdhPJzKtNZ9DqshtlkVijD2KykbsioNqaOrCP1Wc05drU0Weq1Yrn5ll6pcxxXm1ey3JQd/0u87WQ==
X-Received: by 2002:a92:cc49:: with SMTP id t9mr3302848ilq.86.1614361939062;
        Fri, 26 Feb 2021 09:52:19 -0800 (PST)
Received: from shuah-t480s.internal (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id y25sm5594060ioa.5.2021.02.26.09.52.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Feb 2021 09:52:18 -0800 (PST)
From:   Shuah Khan <skhan@linuxfoundation.org>
To:     peterz@infradead.org, mingo@redhat.com, will@kernel.org,
        kvalo@codeaurora.org, davem@davemloft.net, kuba@kernel.org
Cc:     Shuah Khan <skhan@linuxfoundation.org>, ath10k@lists.infradead.org,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/3] lockdep: add lockdep_assert_not_held()
Date:   Fri, 26 Feb 2021 10:52:13 -0700
Message-Id: <a40d18bba5a52662ac8fc556e1fce3752ea08472.1614355914.git.skhan@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1614355914.git.skhan@linuxfoundation.org>
References: <cover.1614355914.git.skhan@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Some kernel functions must be called without holding a specific lock.
Add lockdep_assert_not_held() to be used in these functions to detect
incorrect calls while holding a lock.

lockdep_assert_not_held() provides the opposite functionality of
lockdep_assert_held() which is used to assert calls that require
holding a specific lock.

Incorporates suggestions from Peter Zijlstra to avoid misfires when
lockdep_off() is employed.

The need for lockdep_assert_not_held() came up in a discussion on
ath10k patch. ath10k_drain_tx() and i915_vma_pin_ww() are examples
of functions that can use lockdep_assert_not_held().

Link: https://lore.kernel.org/lkml/37a29c383bff2fb1605241ee6c7c9be3784fb3c6.1613171185.git.skhan@linuxfoundation.org/
Link: https://lore.kernel.org/linux-wireless/871rdmu9z9.fsf@codeaurora.org/
Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
---
 include/linux/lockdep.h  | 11 ++++++++---
 kernel/locking/lockdep.c |  5 ++++-
 2 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/include/linux/lockdep.h b/include/linux/lockdep.h
index b9e9adec73e8..93eb5f797fc1 100644
--- a/include/linux/lockdep.h
+++ b/include/linux/lockdep.h
@@ -294,8 +294,12 @@ extern void lock_unpin_lock(struct lockdep_map *lock, struct pin_cookie);
 
 #define lockdep_depth(tsk)	(debug_locks ? (tsk)->lockdep_depth : 0)
 
-#define lockdep_assert_held(l)	do {				\
-		WARN_ON(debug_locks && !lockdep_is_held(l));	\
+#define lockdep_assert_held(l)	do {					\
+		WARN_ON(debug_locks && lockdep_is_held(l) == 0);	\
+	} while (0)
+
+#define lockdep_assert_not_held(l)	do {				\
+		WARN_ON(debug_locks && lockdep_is_held(l) == 1);	\
 	} while (0)
 
 #define lockdep_assert_held_write(l)	do {			\
@@ -384,7 +388,8 @@ extern int lockdep_is_held(const void *);
 #define lockdep_is_held_type(l, r)		(1)
 
 #define lockdep_assert_held(l)			do { (void)(l); } while (0)
-#define lockdep_assert_held_write(l)	do { (void)(l); } while (0)
+#define lockdep_assert_not_held(l)		do { (void)(l); } while (0)
+#define lockdep_assert_held_write(l)		do { (void)(l); } while (0)
 #define lockdep_assert_held_read(l)		do { (void)(l); } while (0)
 #define lockdep_assert_held_once(l)		do { (void)(l); } while (0)
 
diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index bdaf4829098c..d3299fd85c4a 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -5472,7 +5472,10 @@ noinstr int lock_is_held_type(const struct lockdep_map *lock, int read)
 	int ret = 0;
 
 	if (unlikely(!lockdep_enabled()))
-		return 1; /* avoid false negative lockdep_assert_held() */
+		/* avoid false negative lockdep_assert_not_held()
+		 * and lockdep_assert_held()
+		 */
+		return -1;
 
 	raw_local_irq_save(flags);
 	check_flags(flags);
-- 
2.27.0

