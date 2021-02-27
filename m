Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93CB4326A9C
	for <lists+linux-wireless@lfdr.de>; Sat, 27 Feb 2021 01:08:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230010AbhB0AHr (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 26 Feb 2021 19:07:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229967AbhB0AHp (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 26 Feb 2021 19:07:45 -0500
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C535EC061786
        for <linux-wireless@vger.kernel.org>; Fri, 26 Feb 2021 16:07:04 -0800 (PST)
Received: by mail-io1-xd36.google.com with SMTP id p16so11509541ioj.4
        for <linux-wireless@vger.kernel.org>; Fri, 26 Feb 2021 16:07:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/Zkk2haeiidsDP/ZwhF5BhqM9bPgv7fbdC7NxG6iRRw=;
        b=ZqyQCczX3RZW7Jszm8n6gTRjBH3oMoNrIOAtNYn3E0o4VlY0Ny9fXxmpeFdgAlUMRu
         o1cdHDYUKTpe1O+SoymyQ2X1REjAiQ0hlXiaEgQH8DCDxOvJfyRMSqKje5KJ71QhXVpe
         LlhlaZLTkZYMGTRJqaQBMUtC+NDbKFm0N4Qvs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/Zkk2haeiidsDP/ZwhF5BhqM9bPgv7fbdC7NxG6iRRw=;
        b=bjktEqEYKfy4tHWVltD9vN0kDnZFW2C1R7ugPoaFsSJjvuDsbyFmYVELaCbguyJhcv
         ORLAx2560zb92ZO6MTHsnoXXW5e60X83vgCTfDvNtqwo9oAsGrFi6RPxdnU7Ps6bdfx9
         42lhTbkLoOTdmkJAwnEAdUaCk9S1trIDYioX1dUSJN1JiFg8KscGe68qVaK8EA7TDla7
         VfmLR6qhcjtnJVIXO4oqbESsqztVauzsPfMoqzAX8f7x4WItJxLNJY2RDFWXycINZoU0
         T5YHU/arG0qhsSvIKPHl2UjQgprA1I5LMt8LXsvBVVMBVACYkSmh4NfuQoAy9dGdqTES
         c7wQ==
X-Gm-Message-State: AOAM533uROzs/43UT+dAe8feqrwlfEodZZwmwcW8csmYYMpMYBgHhc0+
        VX7etBqndd/fXFc0ScP1Dr6Yyw==
X-Google-Smtp-Source: ABdhPJyKxa0J4mJ1Q3Us1nF3cWKJxJOJv3J6flPS+IR1ljgqemUo/UlwUf5R3XFcSZdCq19XPZPoZA==
X-Received: by 2002:a02:cc2a:: with SMTP id o10mr5563036jap.62.1614384424250;
        Fri, 26 Feb 2021 16:07:04 -0800 (PST)
Received: from shuah-t480s.internal (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id w16sm5228805ilh.35.2021.02.26.16.07.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Feb 2021 16:07:03 -0800 (PST)
From:   Shuah Khan <skhan@linuxfoundation.org>
To:     peterz@infradead.org, mingo@redhat.com, will@kernel.org,
        kvalo@codeaurora.org, davem@davemloft.net, kuba@kernel.org
Cc:     Shuah Khan <skhan@linuxfoundation.org>, ath10k@lists.infradead.org,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/3] lockdep: add lockdep_assert_not_held()
Date:   Fri, 26 Feb 2021 17:06:58 -0700
Message-Id: <c22a1c5ef8a7620dce02c26993b998777d432aac.1614383025.git.skhan@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1614383025.git.skhan@linuxfoundation.org>
References: <cover.1614383025.git.skhan@linuxfoundation.org>
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
 kernel/locking/lockdep.c |  6 +++++-
 2 files changed, 13 insertions(+), 4 deletions(-)

diff --git a/include/linux/lockdep.h b/include/linux/lockdep.h
index 7b7ebf2e28ec..dbd9ea846b36 100644
--- a/include/linux/lockdep.h
+++ b/include/linux/lockdep.h
@@ -301,8 +301,12 @@ extern void lock_unpin_lock(struct lockdep_map *lock, struct pin_cookie);
 
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
@@ -393,7 +397,8 @@ extern int lockdep_is_held(const void *);
 #define lockdep_is_held_type(l, r)		(1)
 
 #define lockdep_assert_held(l)			do { (void)(l); } while (0)
-#define lockdep_assert_held_write(l)	do { (void)(l); } while (0)
+#define lockdep_assert_not_held(l)		do { (void)(l); } while (0)
+#define lockdep_assert_held_write(l)		do { (void)(l); } while (0)
 #define lockdep_assert_held_read(l)		do { (void)(l); } while (0)
 #define lockdep_assert_held_once(l)		do { (void)(l); } while (0)
 
diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index c6d0c1dc6253..818d0ceed3eb 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -5539,8 +5539,12 @@ noinstr int lock_is_held_type(const struct lockdep_map *lock, int read)
 	unsigned long flags;
 	int ret = 0;
 
+	/*
+	 * avoid false negative lockdep_assert_held() and
+	 * lockdep_assert_not_held()
+	 */
 	if (unlikely(!lockdep_enabled()))
-		return 1; /* avoid false negative lockdep_assert_held() */
+		return -1;
 
 	raw_local_irq_save(flags);
 	check_flags(flags);
-- 
2.27.0

