Return-Path: <linux-wireless+bounces-29951-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id ECF82CD0CF2
	for <lists+linux-wireless@lfdr.de>; Fri, 19 Dec 2025 17:19:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B0C02318B037
	for <lists+linux-wireless@lfdr.de>; Fri, 19 Dec 2025 16:08:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B099334BA2E;
	Fri, 19 Dec 2025 15:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4oadzVeY"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ed1-f73.google.com (mail-ed1-f73.google.com [209.85.208.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31C1434CFC2
	for <linux-wireless@vger.kernel.org>; Fri, 19 Dec 2025 15:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766159212; cv=none; b=QchyGGU1mUZjTEnrxTagLkKeYqSOq0DKORscpN1ermYUtWZI34stemofUAn8MkuLblAjeYAknQcq8AHpJcAVreRC/2N+Smah1Lb8mIJBE6nz22wJgzIV//kFpQ9d+g4MVYw04IyBmTa299/vG7XZUWSiyJRDxisERKq5xwpKRZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766159212; c=relaxed/simple;
	bh=ln67g4FksJVOa0BRa1f5CRH52V/ROTo9NVPtsH31YyE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=fDAgghePt6t4UyxBoz6LonBFBu/zw3l+02x35zaUuesoI7s3JBVqCjkmZE1LknH2NKE7ZRt2pJufeqJLv9O0U3eBhIACo0A69tro8qdC6EK/DyQRA5dzxptQslgoXZ/MmhJcuiXh5haFlAz6jig6bKg/iISomONFgtnFuiKjL2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--elver.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4oadzVeY; arc=none smtp.client-ip=209.85.208.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--elver.bounces.google.com
Received: by mail-ed1-f73.google.com with SMTP id 4fb4d7f45d1cf-6495ccea18dso2019483a12.2
        for <linux-wireless@vger.kernel.org>; Fri, 19 Dec 2025 07:46:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1766159208; x=1766764008; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=iwJwFE4RR+G0qPj93NacKXfc9Bqs8f3KUgfNaIjFSIY=;
        b=4oadzVeYYlhSHL8EVuAggfjknO+wAgJgEn/pDwg3EUlp4Al8SWsMW/bllQrjMC24xJ
         7OEJoJiYIdsTBQhs4TobyKhHejj/Zj/EKOVAfmN/w2a9BkPp2V2F1s5ijG+bv/FWCc+6
         9XqtRYZkLCZ4toa/eliZ05VtbcLdtKK7vzijZuOkemDKYBP8+FdRBqYBAMAZWRoLru5s
         ZZGpdD8ulG2vHnalpjuwDcYADtxfE2DW7gRNwQj3aXfRlEYmWZNmk7Ur04noWaT4NY6C
         bEbbLnV9VdGnaPku6sZ/Y+6hS6G59XEew6PGJcmZ0rOJaWQj/5kaWvOs0Gxq5ewpe6LZ
         gDSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766159208; x=1766764008;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iwJwFE4RR+G0qPj93NacKXfc9Bqs8f3KUgfNaIjFSIY=;
        b=UBmu2IcD2M6wlzvveRoTqFbi1pwpPkPo0mIAGIpGI+HeSlITiUN0d60vIYRop+UXlg
         /p4AyS7aU0q7k9/BdaKcz08od/H9xGSUNpXLQkG9+ZnQxywtUg9exFSo9PpRCu5l+M37
         CP4iwtyTxAgaHeBj2lyLUkMhN65dCQIjbINuRiDtlDY+H0c44kYhZSuIG1KuKLgzT9jL
         t6dWJIO+IyMA9lQftMqyzurbXm6Z1v4+/vVnxLNqDrY7qZ75ED9DUWkET1q1YlzGL9fo
         TKSckM+bq1awjRXkdAIyyGfQCZkuj17audhzArt3fPF6eoc8Fc3eHFsz3jGAJcepUxpv
         HmLw==
X-Forwarded-Encrypted: i=1; AJvYcCUmbZX2iArjjxTiBtSwOYSqqsmCwEt2euWwbqdpsWDgCNXj5paLNbdD2SgkxQnMZZB6s7Y66jC9BJP8iFLI6g==@vger.kernel.org
X-Gm-Message-State: AOJu0YzfAUjxOBrjEbOxqzTZqRiLaR+qqPvwqNzScpTcUjPxNpLrRge5
	C5m7uGng32q075LRkijhqcDM0IDAQINccvvKzj10NEPUn15S4Ihm0K+61wzO59sVBUSZrDtLMIj
	jHQ==
X-Google-Smtp-Source: AGHT+IFnXG6cE34nzlKUaF0YLjZuRw/c6GtHv7aWsx/cCEAUfVEyphXLuEYpLswMSP0zGStw/fZIKiWOPA==
X-Received: from edwv2.prod.google.com ([2002:aa7:cd42:0:b0:643:8c4d:bca0])
 (user=elver job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6402:27cb:b0:64b:46d4:5d5c
 with SMTP id 4fb4d7f45d1cf-64b8e9379dcmr2970087a12.5.1766159208169; Fri, 19
 Dec 2025 07:46:48 -0800 (PST)
Date: Fri, 19 Dec 2025 16:40:10 +0100
In-Reply-To: <20251219154418.3592607-1-elver@google.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251219154418.3592607-1-elver@google.com>
X-Mailer: git-send-email 2.52.0.322.g1dd061c0dc-goog
Message-ID: <20251219154418.3592607-22-elver@google.com>
Subject: [PATCH v5 21/36] debugfs: Make debugfs_cancellation a context lock struct
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
struct debugfs_cancellation a real context lock to benefit from Clang's
context analysis.

This change is a preparatory change to allow enabling context analysis
in subsystems that include the above header.

Signed-off-by: Marco Elver <elver@google.com>
---
v5:
* Rename "context guard" -> "context lock".

v4:
* Rename capability -> context analysis.
---
 include/linux/debugfs.h | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/include/linux/debugfs.h b/include/linux/debugfs.h
index 7cecda29447e..4177c4738282 100644
--- a/include/linux/debugfs.h
+++ b/include/linux/debugfs.h
@@ -239,18 +239,16 @@ ssize_t debugfs_read_file_str(struct file *file, char __user *user_buf,
  * @cancel: callback to call
  * @cancel_data: extra data for the callback to call
  */
-struct debugfs_cancellation {
+context_lock_struct(debugfs_cancellation) {
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
2.52.0.322.g1dd061c0dc-goog


