Return-Path: <linux-wireless+bounces-29193-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 23ECAC74E53
	for <lists+linux-wireless@lfdr.de>; Thu, 20 Nov 2025 16:23:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 49AD54EA600
	for <lists+linux-wireless@lfdr.de>; Thu, 20 Nov 2025 15:17:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47109364EBF;
	Thu, 20 Nov 2025 15:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GMcirOcn"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D24AD3624DC
	for <linux-wireless@vger.kernel.org>; Thu, 20 Nov 2025 15:13:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763651614; cv=none; b=jR9am9Wc4az8OBt8JaGDVyViVxMY+Za/otIwdhnI5zfctPKfbKlI1332Ld3rqhJ7AS1xndZqv3rTVnv4AkESORVB8GAJORfW7lnYZdIp3SB/gSkTzYDnl+FqXLk56uEQVHcC/yrEeVeG/JGzXvacBzY9wHIkDzuS0MsGbKxsZFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763651614; c=relaxed/simple;
	bh=sAXWpweCk1HKaMB/YWFmccYNlA1uAb5802MTkRNhnIk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=XeZ5qlou6wLvsKviviPPGRsQlPHVBqvFmis+uajS7Uo62lJ/B0nfuTZD7h6CbvfaWYedbWiVhx80G0ZlEadQd2WNqBk10kBsxzh6ClrHqcCj+se75doZ0Y/0Q5paLmzB1xsxsiPEtLkw0vuk6Q6KVx7YJm43kWd+ie/ZNg8nk3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--elver.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GMcirOcn; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--elver.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-477563a0c75so5572395e9.1
        for <linux-wireless@vger.kernel.org>; Thu, 20 Nov 2025 07:13:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1763651592; x=1764256392; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=P8aLbx9Sl47RYxftyEseQjhVT7SfF+KyN6wsDyYV/tA=;
        b=GMcirOcnN8Q6oR1juYEex76iiuJDNbiKmN1Hn0kxUO2mfs6cbhlugXyApA/+10Yekq
         hk+kv5a5al/6mjwGt3PIwcEXipdkTGFJjnNKRX+9hYrk86srMswh8cNnJ0vlK1nyUh3E
         IP8oUH1WiZrqot6k0VsOxKbohrbe4HsPYl1wJziBWaLSO1ALLFe5hwj3W8kx+FSRslMr
         tYpi5a+4nOUU+s3onUjF+VN8D9f/1vLhl7qB3xTj72zd/kP6+RE8U3pfRQJ/YrQtDcN/
         m+67LZcTtWhUPLtUgvGlNT8vqp/BdoMsCgzrFu930G/B/z29qt+zbuDNeVJgeOQ/BERu
         rHbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763651592; x=1764256392;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=P8aLbx9Sl47RYxftyEseQjhVT7SfF+KyN6wsDyYV/tA=;
        b=oeuRjO/tXbWzamEHrukAHaz5yZUu3l+x2UAcalkHzRbZ1Q+jTjN3zADLitn/vsjm9Q
         7a5oJQPGkv9oG5zFcnkFlnUWIQ7tIfkSCGAEFVh8GEKRfRRGXMKnAbXVPQh46r6QPsl9
         FKFCBcraYQ0GPW8HqjUEbY5RtzFA76CB0kn92uKs4+lfyvRc8iwtj1Y6V8rs1tO70F+5
         //Nq89YiGaPyzjOn34dkUpehwHrY5k4o5OJbAz2VQTSWOW4Mg71vd9GD16bqCSXxOJBl
         YIU5YaWewj1cDpvs+Xe+RQ0MGXPXfw8iixWunNS1v28OZ/Wo9f4JQqGPCUfUbVnqNQy8
         5KvA==
X-Forwarded-Encrypted: i=1; AJvYcCUpEzdSty5W2TfLBOwT56fWJI25K1G919xgoTXejr6rSXFacKTfnPAMFlg7EwAStNAD2TzjyqMwCHnxEJBfpg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzG9JIgb3A44VBwPGhktqn4A5ZFGCVGevX/fxJVGpb0zWsxuQLE
	pFPA/2uDOUF/K7nJYiKuM4wzDWimmhNfOBzFi6Oxfads5DqHMYxa6DrFLsqY7/qLSWUSZ6XKFdh
	rwg==
X-Google-Smtp-Source: AGHT+IFjAbTy0j0ap6YuUuYLwX6mC93Q/ee200zfIzNbmIifUkyrBIOtI3LFwq1L7M4ens6voO/IZCXXTQ==
X-Received: from wmco22.prod.google.com ([2002:a05:600c:a316:b0:477:b15:2ccc])
 (user=elver job=prod-delivery.src-stubby-dispatcher) by 2002:a05:600c:1987:b0:45d:d97c:236c
 with SMTP id 5b1f17b1804b1-477b8a8a5damr33384125e9.21.1763651592065; Thu, 20
 Nov 2025 07:13:12 -0800 (PST)
Date: Thu, 20 Nov 2025 16:09:46 +0100
In-Reply-To: <20251120151033.3840508-7-elver@google.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251120145835.3833031-2-elver@google.com> <20251120151033.3840508-7-elver@google.com>
X-Mailer: git-send-email 2.52.0.rc1.455.g30608eb744-goog
Message-ID: <20251120151033.3840508-22-elver@google.com>
Subject: [PATCH v4 21/35] debugfs: Make debugfs_cancellation a context guard struct
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

When compiling include/linux/debugfs.h with CONTEXT_ANALYSIS enabled, we
can see this error:

./include/linux/debugfs.h:239:17: error: use of undeclared identifier 'cancellation'
  239 | void __acquires(cancellation)

Move the __acquires(..) attribute after the declaration, so that the
compiler can see the cancellation function argument, as well as making
struct debugfs_cancellation a real context guard to benefit from Clang's
context analysis.

Signed-off-by: Marco Elver <elver@google.com>
---
v4:
* Rename capability -> context analysis.
---
 include/linux/debugfs.h | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/include/linux/debugfs.h b/include/linux/debugfs.h
index 7cecda29447e..43f49bfc9e25 100644
--- a/include/linux/debugfs.h
+++ b/include/linux/debugfs.h
@@ -239,18 +239,16 @@ ssize_t debugfs_read_file_str(struct file *file, char __user *user_buf,
  * @cancel: callback to call
  * @cancel_data: extra data for the callback to call
  */
-struct debugfs_cancellation {
+context_guard_struct(debugfs_cancellation) {
 	struct list_head list;
 	void (*cancel)(struct dentry *, void *);
 	void *cancel_data;
 };
 
-void __acquires(cancellation)
-debugfs_enter_cancellation(struct file *file,
-			   struct debugfs_cancellation *cancellation);
-void __releases(cancellation)
-debugfs_leave_cancellation(struct file *file,
-			   struct debugfs_cancellation *cancellation);
+void debugfs_enter_cancellation(struct file *file,
+				struct debugfs_cancellation *cancellation) __acquires(cancellation);
+void debugfs_leave_cancellation(struct file *file,
+				struct debugfs_cancellation *cancellation) __releases(cancellation);
 
 #else
 
-- 
2.52.0.rc1.455.g30608eb744-goog


