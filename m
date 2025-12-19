Return-Path: <linux-wireless+bounces-29960-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D1417CD100A
	for <lists+linux-wireless@lfdr.de>; Fri, 19 Dec 2025 17:55:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 840B530DA452
	for <lists+linux-wireless@lfdr.de>; Fri, 19 Dec 2025 16:52:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C3BD34F49A;
	Fri, 19 Dec 2025 15:47:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qwpJpKhO"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wr1-f73.google.com (mail-wr1-f73.google.com [209.85.221.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 432DB34F470
	for <linux-wireless@vger.kernel.org>; Fri, 19 Dec 2025 15:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766159249; cv=none; b=JEmG969rHtQyayD6katkvMBsUR0Zh2TKgbge4gJTqBEZXY9ecMjd/I0chrHsX41rTftL4wzo9lF0X9TA9dTyxd63L7duAPLCtEYZAG784R9cI9QYakvXrrbrP34LCCnayhjJnRrdja8i4ImVHo6o0UpFuKLh9/IS2Xn/wsW7LUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766159249; c=relaxed/simple;
	bh=Xhk0xsW0tGqUud5kt1c33VabY4PrqeJpXHkHXkMftFw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=PIYvzSpGu7qqqxTn9IgamlknQbs5DxwCMOfYf5l9clabv1axACJDT9fc08OlKJ0riCuJv6fRK0ozJvAX6I01UIEekraYhXAS3QIHP22anwWiiOq/ZPzXYLCX7Ta3Ub5TT+wVVh+3T+FXBaL419FpcFQxaUK+zKrHkpzLaJMwBcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--elver.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qwpJpKhO; arc=none smtp.client-ip=209.85.221.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--elver.bounces.google.com
Received: by mail-wr1-f73.google.com with SMTP id ffacd0b85a97d-430fdaba167so1065003f8f.3
        for <linux-wireless@vger.kernel.org>; Fri, 19 Dec 2025 07:47:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1766159246; x=1766764046; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=OO33/jJhJQVIdzyn/h7cV8sb9potmD4v/pwOWqkGaBs=;
        b=qwpJpKhOLpgQLLRzDYwf4fl2yOTMVAck6fCMfPA3LxKY1lbNJ89HDgEqGqx+Aa+AgK
         cwslZ5c5jXP92pYuzRSb5rr8Q819WPijZDTHrEruZuPzuk5mZytFn7mwyPncNjhsMcrm
         qk5gNQs5RU4yabggbxdCSQlbLbdkdOTv7lT3lUb1X/Pmp3ugS8Pd8B97bHmADjXrD+2s
         6Aw2PD3TY9EHQcWfbSvQ5M/tRTopBe+KKuAK5GZ9c8wm+EO8iWtp8/vLYLAJybGzboDD
         kKA7lZz8vj1FZdRjtS1s00mvnX1hLZ2F/tOwW2Qf6qiV1Kkn2rBM80Yswpu3y5v0a+Mh
         1ggw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766159246; x=1766764046;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OO33/jJhJQVIdzyn/h7cV8sb9potmD4v/pwOWqkGaBs=;
        b=GAQcdevodciuW/hSzsqb8P6OWCRnq/8Ib4QEwqYclJEP0psaBk8um2oUH0wPGo14DA
         J/uix82OZSfP6X/Alzqxms9iZeIyWgu+z8vCSA4KlDZ3lYAbaEaGpR2Q6jiwkHyhkN5p
         BvjDzShcRxTmyshL0h5l/gftgT5rLu2q7s14s1OramicmCeKi7j7hviQOk7ePitTZW0z
         zJ8nhz00Ycs5zbthcpEy2/NHZxP8+v/JXPednHlB5xo5IAal6LzETOnyF3pBernZJRvj
         0mWiKse/uUydSPKC1l+bJdjMoiXaBs5i6/I3aY0EPo7Po+0jX+qbUkZXlsOtnplb/dAS
         mZ3w==
X-Forwarded-Encrypted: i=1; AJvYcCUBJDR/ib4m2miVSYxtxAMbodvtp3MhjOZBN/066j2DCmX4PgnUVl9kHKE9LPhD7ATF6rIvNWeCSCHAW8qhiA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyO/KJDKaks8fDkfOa3dnA8s4Ohjkoe3TuEPh5XcSYaWu/8SA4M
	G5auusFOfDzJwd5b69Z4C3JS4tPXRvv0kOg9EUQ5lGSjw8RVp6Xy7KC3s5WzXK+Dg8x1kcuBhkY
	iLw==
X-Google-Smtp-Source: AGHT+IFerDd1vd4X97dkJpWHrvPSjwQcqOjMG8Z0RXSvdbWhPjy9O9psZiuBXvn9GzAtKPBtfUrWDqrhqg==
X-Received: from wrbbs1.prod.google.com ([2002:a05:6000:701:b0:42b:2aa2:e459])
 (user=elver job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6000:2303:b0:429:b9bc:e81a
 with SMTP id ffacd0b85a97d-4324e458883mr2916935f8f.0.1766159245502; Fri, 19
 Dec 2025 07:47:25 -0800 (PST)
Date: Fri, 19 Dec 2025 16:40:19 +0100
In-Reply-To: <20251219154418.3592607-1-elver@google.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251219154418.3592607-1-elver@google.com>
X-Mailer: git-send-email 2.52.0.322.g1dd061c0dc-goog
Message-ID: <20251219154418.3592607-31-elver@google.com>
Subject: [PATCH v5 30/36] kcsan: Enable context analysis
From: Marco Elver <elver@google.com>
To: elver@google.com, Peter Zijlstra <peterz@infradead.org>, 
	Boqun Feng <boqun.feng@gmail.com>, Ingo Molnar <mingo@kernel.org>, Will Deacon <will@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, 
	Chris Li <sparse@chrisli.org>, "Paul E. McKenney" <paulmck@kernel.org>, 
	Alexander Potapenko <glider@google.com>, Arnd Bergmann <arnd@arndb.de>, Bart Van Assche <bvanassche@acm.org>, 
	Christoph Hellwig <hch@lst.de>, Dmitry Vyukov <dvyukov@google.com>, Eric Dumazet <edumazet@google.com>, 
	Frederic Weisbecker <frederic@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Herbert Xu <herbert@gondor.apana.org.au>, Ian Rogers <irogers@google.com>, 
	Jann Horn <jannh@google.com>, Joel Fernandes <joelagnelf@nvidia.com>, 
	Johannes Berg <johannes.berg@intel.com>, Jonathan Corbet <corbet@lwn.net>, 
	Josh Triplett <josh@joshtriplett.org>, Justin Stitt <justinstitt@google.com>, 
	Kees Cook <kees@kernel.org>, Kentaro Takeda <takedakn@nttdata.co.jp>, 
	Lukas Bulwahn <lukas.bulwahn@gmail.com>, Mark Rutland <mark.rutland@arm.com>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Miguel Ojeda <ojeda@kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>, Neeraj Upadhyay <neeraj.upadhyay@kernel.org>, 
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>, Thomas Gleixner <tglx@linutronix.de>, 
	Thomas Graf <tgraf@suug.ch>, Uladzislau Rezki <urezki@gmail.com>, Waiman Long <longman@redhat.com>, 
	kasan-dev@googlegroups.com, linux-crypto@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kbuild@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	linux-security-module@vger.kernel.org, linux-sparse@vger.kernel.org, 
	linux-wireless@vger.kernel.org, llvm@lists.linux.dev, rcu@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Enable context analysis for the KCSAN subsystem.

Signed-off-by: Marco Elver <elver@google.com>
---
v4:
* Rename capability -> context analysis.

v3:
* New patch.
---
 kernel/kcsan/Makefile |  2 ++
 kernel/kcsan/report.c | 11 ++++++++---
 2 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/kernel/kcsan/Makefile b/kernel/kcsan/Makefile
index a45f3dfc8d14..824f30c93252 100644
--- a/kernel/kcsan/Makefile
+++ b/kernel/kcsan/Makefile
@@ -1,4 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
+CONTEXT_ANALYSIS := y
+
 KCSAN_SANITIZE := n
 KCOV_INSTRUMENT := n
 UBSAN_SANITIZE := n
diff --git a/kernel/kcsan/report.c b/kernel/kcsan/report.c
index e95ce7d7a76e..11a48b78f8d1 100644
--- a/kernel/kcsan/report.c
+++ b/kernel/kcsan/report.c
@@ -116,6 +116,7 @@ static DEFINE_RAW_SPINLOCK(report_lock);
  * been reported since (now - KCSAN_REPORT_ONCE_IN_MS).
  */
 static bool rate_limit_report(unsigned long frame1, unsigned long frame2)
+	__must_hold(&report_lock)
 {
 	struct report_time *use_entry = &report_times[0];
 	unsigned long invalid_before;
@@ -366,6 +367,7 @@ static int sym_strcmp(void *addr1, void *addr2)
 
 static void
 print_stack_trace(unsigned long stack_entries[], int num_entries, unsigned long reordered_to)
+	__must_hold(&report_lock)
 {
 	stack_trace_print(stack_entries, num_entries, 0);
 	if (reordered_to)
@@ -373,6 +375,7 @@ print_stack_trace(unsigned long stack_entries[], int num_entries, unsigned long
 }
 
 static void print_verbose_info(struct task_struct *task)
+	__must_hold(&report_lock)
 {
 	if (!task)
 		return;
@@ -389,6 +392,7 @@ static void print_report(enum kcsan_value_change value_change,
 			 const struct access_info *ai,
 			 struct other_info *other_info,
 			 u64 old, u64 new, u64 mask)
+	__must_hold(&report_lock)
 {
 	unsigned long reordered_to = 0;
 	unsigned long stack_entries[NUM_STACK_ENTRIES] = { 0 };
@@ -496,6 +500,7 @@ static void print_report(enum kcsan_value_change value_change,
 }
 
 static void release_report(unsigned long *flags, struct other_info *other_info)
+	__releases(&report_lock)
 {
 	/*
 	 * Use size to denote valid/invalid, since KCSAN entirely ignores
@@ -507,13 +512,11 @@ static void release_report(unsigned long *flags, struct other_info *other_info)
 
 /*
  * Sets @other_info->task and awaits consumption of @other_info.
- *
- * Precondition: report_lock is held.
- * Postcondition: report_lock is held.
  */
 static void set_other_info_task_blocking(unsigned long *flags,
 					 const struct access_info *ai,
 					 struct other_info *other_info)
+	__must_hold(&report_lock)
 {
 	/*
 	 * We may be instrumenting a code-path where current->state is already
@@ -572,6 +575,7 @@ static void set_other_info_task_blocking(unsigned long *flags,
 static void prepare_report_producer(unsigned long *flags,
 				    const struct access_info *ai,
 				    struct other_info *other_info)
+	__must_not_hold(&report_lock)
 {
 	raw_spin_lock_irqsave(&report_lock, *flags);
 
@@ -603,6 +607,7 @@ static void prepare_report_producer(unsigned long *flags,
 static bool prepare_report_consumer(unsigned long *flags,
 				    const struct access_info *ai,
 				    struct other_info *other_info)
+	__cond_acquires(true, &report_lock)
 {
 
 	raw_spin_lock_irqsave(&report_lock, *flags);
-- 
2.52.0.322.g1dd061c0dc-goog


