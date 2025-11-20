Return-Path: <linux-wireless+bounces-29195-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 54C81C74E65
	for <lists+linux-wireless@lfdr.de>; Thu, 20 Nov 2025 16:24:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8601E4EBD5F
	for <lists+linux-wireless@lfdr.de>; Thu, 20 Nov 2025 15:17:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9ACC0363C58;
	Thu, 20 Nov 2025 15:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ekSHrE5z"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ej1-f73.google.com (mail-ej1-f73.google.com [209.85.218.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCBF935F8DA
	for <linux-wireless@vger.kernel.org>; Thu, 20 Nov 2025 15:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763651619; cv=none; b=ZUxtgPZh4+QfEFqH2b9Pa1Szsraw8AcPR9/pZ7rBat4qecyVmwqLLwBPdYtcETC8OLWGgO5MdrNM38mR/pOygglCQJQYi+YMUNvLcHZXLZNTcqun4m00WJ3Uud+c/jjKX3JZookUvDeILNk1PfTZOz2ZHZFtmc4RZB6vBtercis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763651619; c=relaxed/simple;
	bh=3Y89mJHosRaENaLb5tk2xkCy/Hd7qH1R9BEoKf0fV0w=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=FcQ1yVEqznVm4nGzrIF6diiATH3QvRdAtIG9Ak3QIOyFvccK7VXPxd6hgmUk7C4AxWln78ALNe+av8RxV++rO6qYnbgL//3zkyzmluwDMdG++T4prw2EReVSqQ0ZGHPGYLUGVRvJMXq6lguZxx4D8ZzNQQCgVQiNE2YbJQEQHlk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--elver.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ekSHrE5z; arc=none smtp.client-ip=209.85.218.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--elver.bounces.google.com
Received: by mail-ej1-f73.google.com with SMTP id a640c23a62f3a-b735eea0bddso90149766b.2
        for <linux-wireless@vger.kernel.org>; Thu, 20 Nov 2025 07:13:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1763651609; x=1764256409; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=kN628sGqwThlti0A3ZPE5fg7KLj/Ov6I/vXTKugeedg=;
        b=ekSHrE5zybqJTGQ6PputajlArki3ecYjV6YbSd28O7uoxhpgNG71RAqFQStJYMZikS
         jgHJ1a3WUcu8xi6qNBis5i9CC5W8KJwF4TFLQqYNQy/VO1arXQoE1Rwq6Z1XU2aNn9J5
         Tx8IH9fEqiV9nPZPERqKks6fzr2ysC5FjxS7ugt+7ikp9RiK20XzPodS7N8Q2ZqQsCT+
         OzAluTJmnfngm0ZQN1+76+zPg/cvrxLuFwFk8ubI7m28RrFPdaL5dU1N1KEBA28UiFMn
         ITO1qqNUxTJl7VTHWL+Nt81FmuMMFVGU4EdPVZ8VMLn5xQs6l7mAr9JpTwtPsguVFQ0A
         faxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763651609; x=1764256409;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kN628sGqwThlti0A3ZPE5fg7KLj/Ov6I/vXTKugeedg=;
        b=oihu0SC65fjGPyBhqq/MMWSVKcq2q7LuaM/7zNErfmrWsyabceWZUEPy0ycJWbdZ1U
         0hurDCD8jvo89YcbqFpM4hTDPnRJjLXYC+IrgV83vYSKazDT1RjwrE5R4BMR4XoavBW2
         11JeM9dmOw23y+oUSiTff8BmF4sld22VcqnrPf7Q5VkOKqZs19prrBvy5Y+0/eZKXsBy
         YolohpyZ+ZJ1/eeUyWomtd/eq2czDBiJ0OqbuJ5xbzLXK7qwr4iATz+1uM8wHH2RWj77
         q8yS1Wk4Pfq83Or6QdyRu7p84s4TtFYqwb7r770eqi4hPxSteDNOWx/JujnHEKKmDnSF
         ldOA==
X-Forwarded-Encrypted: i=1; AJvYcCWytC/gvS7k/xaHkf2Nxxt9AUyfzWhzLl4B8AWxD/+Vut9Zge5tDMOT0lwCEFkWNf4btt4Emu5+b/z3qBR/Vg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyyIMgBjbleCkduaxvqGwlvI6Qvhzbto7EyltrbLPPfuuaXEY/7
	Jm6nkx32UJHxcCSit72RQexvsMXw5wexTjAPNyuiI4P7WnKfTc1sHv7ZXXk8zE4VgC15jzyNCVG
	L+Q==
X-Google-Smtp-Source: AGHT+IGPQ40L++aTOvA8JIRy1kdoYShFPO1YhmYJSO3OkON5NZw8EMACaSNJB6l90jTWpiXg4l2yJf3kSw==
X-Received: from ejcwe11.prod.google.com ([2002:a17:907:d64b:b0:b72:63c8:2878])
 (user=elver job=prod-delivery.src-stubby-dispatcher) by 2002:a17:906:6a0d:b0:b76:23b0:7d6f
 with SMTP id a640c23a62f3a-b76554a515bmr362722666b.56.1763651608428; Thu, 20
 Nov 2025 07:13:28 -0800 (PST)
Date: Thu, 20 Nov 2025 16:09:50 +0100
In-Reply-To: <20251120151033.3840508-7-elver@google.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251120145835.3833031-2-elver@google.com> <20251120151033.3840508-7-elver@google.com>
X-Mailer: git-send-email 2.52.0.rc1.455.g30608eb744-goog
Message-ID: <20251120151033.3840508-26-elver@google.com>
Subject: [PATCH v4 25/35] compiler: Let data_race() imply disabled context analysis
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

Many patterns that involve data-racy accesses often deliberately ignore
normal synchronization rules to avoid taking a lock.

If we have a lock-guarded variable on which we do a lock-less data-racy
access, rather than having to write context_unsafe(data_race(..)),
simply make the data_race(..) macro imply context-unsafety. The
data_race() macro already denotes the intent that something subtly
unsafe is about to happen, so it should be clear enough as-is.

Signed-off-by: Marco Elver <elver@google.com>
---
v4:
* Rename capability -> context analysis.

v2:
* New patch.
---
 include/linux/compiler.h    | 2 ++
 lib/test_context-analysis.c | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/include/linux/compiler.h b/include/linux/compiler.h
index 5b45ea7dff3e..8ad1d4fd14e3 100644
--- a/include/linux/compiler.h
+++ b/include/linux/compiler.h
@@ -186,7 +186,9 @@ void ftrace_likely_update(struct ftrace_likely_data *f, int val,
 #define data_race(expr)							\
 ({									\
 	__kcsan_disable_current();					\
+	disable_context_analysis();					\
 	__auto_type __v = (expr);					\
+	enable_context_analysis();					\
 	__kcsan_enable_current();					\
 	__v;								\
 })
diff --git a/lib/test_context-analysis.c b/lib/test_context-analysis.c
index 522769c9586d..4612025a1065 100644
--- a/lib/test_context-analysis.c
+++ b/lib/test_context-analysis.c
@@ -92,6 +92,8 @@ static void __used test_raw_spinlock_trylock_extra(struct test_raw_spinlock_data
 {
 	unsigned long flags;
 
+	data_race(d->counter++); /* no warning */
+
 	if (raw_spin_trylock_irq(&d->lock)) {
 		d->counter++;
 		raw_spin_unlock_irq(&d->lock);
-- 
2.52.0.rc1.455.g30608eb744-goog


