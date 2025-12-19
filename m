Return-Path: <linux-wireless+bounces-29952-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CFA32CD1358
	for <lists+linux-wireless@lfdr.de>; Fri, 19 Dec 2025 18:47:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 59E573008193
	for <lists+linux-wireless@lfdr.de>; Fri, 19 Dec 2025 17:42:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEB0E34D3BF;
	Fri, 19 Dec 2025 15:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cKbw4Wbp"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E0C434D3A7
	for <linux-wireless@vger.kernel.org>; Fri, 19 Dec 2025 15:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766159216; cv=none; b=InuFPffdwU+/Ht+pSwjfRD1OSPXJhfvQK1W9J/9P5bBeQiOZLlOs414u2GXFaMC/he1StlO4MDgIMpMJWRQtVLw92FwZ0pE26JSFVMMezRs7M7CftY8WaB1hGfuFsRvaOcbeoKMglZMePO9jK/wlrPRwuQYTRp5Y9A82NHpvfWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766159216; c=relaxed/simple;
	bh=ffn5A72rAl7FAFjS1rk5YlULl8qajeM/K30VyhzfQ+s=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=PWXyPByw5sh2QGMXh6G3mfrbsf2+vIeaZff/yFRfob4LZNim3GgSWgDX4w7cirBD+xLQ6JhFekYM/BPbs2pWsfLoxF79qBn2uhdnEzL1zpPuzmz9G1ExzwCOLzNaeZUOwiqjF+EyAZuHJ1YoPZHwXfetAzKLmlNFmWENyiSxtzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--elver.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cKbw4Wbp; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--elver.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-47a97b785bdso13260985e9.3
        for <linux-wireless@vger.kernel.org>; Fri, 19 Dec 2025 07:46:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1766159212; x=1766764012; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=BPiD3KqRf4YAgh6EJvt9JR+cuwWr4Dg7H+dSvPnSAFc=;
        b=cKbw4WbpL+Cvqd22rO3gflpWRfLXWYBA5lTrVXemFojS3IzY5B9bWRbqDk2NK0N5t+
         S5DGaTfJHL9AqeYURPH5JK9KoHPOx9g7bg1oGlDBd5GIM6jdMJ/GYz0brlm5FgEwe3/R
         8hzLlb7c2OIt0Cz3ZEsSa5XLsFON5bYu4TWEly9dZ54gGSaJ1d5Fn2IqyQv0ACbeidRj
         5AvEhmdol57VZWfEu7fgZNF/nPMGpICpSyo/4PHezLaG/9mBryDgF9i+ajBGDFX/Q2wW
         tFpczKzYxk4WX11wkI5XPDZVYqjZOqtv3il3BJ6fDvOV3P8nlfkM9y986Cc1BrDN3PPQ
         1grg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766159212; x=1766764012;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BPiD3KqRf4YAgh6EJvt9JR+cuwWr4Dg7H+dSvPnSAFc=;
        b=m4MlxEXplsdIoh5AfGIXw/jmiVPjUrRxkcVka3X7yhpcXuEZXPNFyA4qyFOBh5Eg/V
         7cj5TDOf8MWrWv9qAl7bsiMs9gSR9Q7FTnKJdadO1KI5xttBBp9fgmno4ZpXnXZ0fcOa
         XI2ywvM9wFIxyytgUphuyN+/khiWgTFh1+Fy9hXKNjV+eZ9dz3askZ1SI3PwLmIup3/e
         ijvC6b9xWUXT0K6rH81Gx9ovJYv+rFsFFRyS86GB4am80kCcjA76+6l/TCZ3R1kf4vqI
         bXZMFLzk1KarNDQMShFgRFw1TY/lz+sIfVNntOhVak9bfCOcVZt+VMhW6gL/9t0Df56y
         feEw==
X-Forwarded-Encrypted: i=1; AJvYcCXtXEeRgZTw1ah/lZiiqhoDPgQyX3AtGAdw3ZKVfjCDLoNf0fZGrhFou0eZvSFHuvdw4IoJ5OJ/RzKEmIYmLw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw77I190jRjgtCe9qiunOJiaKfdw4j6HwdlV6PMpQ7LRyyQjgAd
	EM/tRbUNP8r+rSLExUj+iPxnlR74GNuLu40Y0R91qXk9kghdqJwpkdxfrFI3Haw45XUk5WO71le
	Rzg==
X-Google-Smtp-Source: AGHT+IGhAhPmou604sSjPj23AvOGmEtACeK8/O1HXfeBpY2WmsP8AIbWuFkf2cEj+zrFEmw2cUXjp49BYQ==
X-Received: from wmco23.prod.google.com ([2002:a05:600c:a317:b0:477:93dd:bbb1])
 (user=elver job=prod-delivery.src-stubby-dispatcher) by 2002:a05:600d:108:20b0:477:214f:bd95
 with SMTP id 5b1f17b1804b1-47d1c036d6cmr18724405e9.23.1766159212483; Fri, 19
 Dec 2025 07:46:52 -0800 (PST)
Date: Fri, 19 Dec 2025 16:40:11 +0100
In-Reply-To: <20251219154418.3592607-1-elver@google.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251219154418.3592607-1-elver@google.com>
X-Mailer: git-send-email 2.52.0.322.g1dd061c0dc-goog
Message-ID: <20251219154418.3592607-23-elver@google.com>
Subject: [PATCH v5 22/36] um: Fix incorrect __acquires/__releases annotations
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
	linux-wireless@vger.kernel.org, llvm@lists.linux.dev, rcu@vger.kernel.org, 
	kernel test robot <lkp@intel.com>, Johannes Berg <johannes@sipsolutions.net>, 
	Tiwei Bie <tiwei.btw@antgroup.com>
Content-Type: text/plain; charset="UTF-8"

With Clang's context analysis, the compiler is a bit more strict about
what goes into the __acquires/__releases annotations and can't refer to
non-existent variables.

On an UM build, mm_id.h is transitively included into mm_types.h, and we
can observe the following error (if context analysis is enabled in e.g.
stackdepot.c):

   In file included from lib/stackdepot.c:17:
   In file included from include/linux/debugfs.h:15:
   In file included from include/linux/fs.h:5:
   In file included from include/linux/fs/super.h:5:
   In file included from include/linux/fs/super_types.h:7:
   In file included from include/linux/list_lru.h:14:
   In file included from include/linux/xarray.h:16:
   In file included from include/linux/gfp.h:7:
   In file included from include/linux/mmzone.h:22:
   In file included from include/linux/mm_types.h:26:
   In file included from arch/um/include/asm/mmu.h:12:
>> arch/um/include/shared/skas/mm_id.h:24:54: error: use of undeclared identifier 'turnstile'
      24 | void enter_turnstile(struct mm_id *mm_id) __acquires(turnstile);
         |                                                      ^~~~~~~~~
   arch/um/include/shared/skas/mm_id.h:25:53: error: use of undeclared identifier 'turnstile'
      25 | void exit_turnstile(struct mm_id *mm_id) __releases(turnstile);
         |                                                     ^~~~~~~~~

One (discarded) option was to use token_context_lock(turnstile) to just
define a token with the already used name, but that would not allow the
compiler to distinguish between different mm_id-dependent instances.

Another constraint is that struct mm_id is only declared and incomplete
in the header, so even if we tried to construct an expression to get to
the mutex instance, this would fail (including more headers transitively
everywhere should also be avoided).

Instead, just declare an mm_id-dependent helper to return the mutex, and
use the mm_id-dependent call expression in the __acquires/__releases
attributes; the compiler will consider the identity of the mutex to be
the call expression. Then using __get_turnstile() in the lock/unlock
wrappers (with context analysis enabled for mmu.c) the compiler will be
able to verify the implementation of the wrappers as-is.

We leave context analysis disabled in arch/um/kernel/skas/ for now. This
change is a preparatory change to allow enabling context analysis in
subsystems that include any of the above headers.

No functional change intended.

Closes: https://lore.kernel.org/oe-kbuild-all/202512171220.vHlvhpCr-lkp@intel.com/
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Marco Elver <elver@google.com>
Cc: Johannes Berg <johannes@sipsolutions.net>
Cc: Tiwei Bie <tiwei.btw@antgroup.com>
---
 arch/um/include/shared/skas/mm_id.h |  5 +++--
 arch/um/kernel/skas/mmu.c           | 13 ++++++++-----
 2 files changed, 11 insertions(+), 7 deletions(-)

diff --git a/arch/um/include/shared/skas/mm_id.h b/arch/um/include/shared/skas/mm_id.h
index fb96c0bd8222..18c0621430d2 100644
--- a/arch/um/include/shared/skas/mm_id.h
+++ b/arch/um/include/shared/skas/mm_id.h
@@ -21,8 +21,9 @@ struct mm_id {
 	int syscall_fd_map[STUB_MAX_FDS];
 };
 
-void enter_turnstile(struct mm_id *mm_id) __acquires(turnstile);
-void exit_turnstile(struct mm_id *mm_id) __releases(turnstile);
+struct mutex *__get_turnstile(struct mm_id *mm_id);
+void enter_turnstile(struct mm_id *mm_id) __acquires(__get_turnstile(mm_id));
+void exit_turnstile(struct mm_id *mm_id) __releases(__get_turnstile(mm_id));
 
 void notify_mm_kill(int pid);
 
diff --git a/arch/um/kernel/skas/mmu.c b/arch/um/kernel/skas/mmu.c
index 00957788591b..b5017096028b 100644
--- a/arch/um/kernel/skas/mmu.c
+++ b/arch/um/kernel/skas/mmu.c
@@ -23,18 +23,21 @@ static_assert(sizeof(struct stub_data) == STUB_DATA_PAGES * UM_KERN_PAGE_SIZE);
 static spinlock_t mm_list_lock;
 static struct list_head mm_list;
 
-void enter_turnstile(struct mm_id *mm_id) __acquires(turnstile)
+struct mutex *__get_turnstile(struct mm_id *mm_id)
 {
 	struct mm_context *ctx = container_of(mm_id, struct mm_context, id);
 
-	mutex_lock(&ctx->turnstile);
+	return &ctx->turnstile;
 }
 
-void exit_turnstile(struct mm_id *mm_id) __releases(turnstile)
+void enter_turnstile(struct mm_id *mm_id)
 {
-	struct mm_context *ctx = container_of(mm_id, struct mm_context, id);
+	mutex_lock(__get_turnstile(mm_id));
+}
 
-	mutex_unlock(&ctx->turnstile);
+void exit_turnstile(struct mm_id *mm_id)
+{
+	mutex_unlock(__get_turnstile(mm_id));
 }
 
 int init_new_context(struct task_struct *task, struct mm_struct *mm)
-- 
2.52.0.322.g1dd061c0dc-goog


