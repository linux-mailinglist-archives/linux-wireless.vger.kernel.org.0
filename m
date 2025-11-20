Return-Path: <linux-wireless+bounces-29177-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 69DB4C74D2A
	for <lists+linux-wireless@lfdr.de>; Thu, 20 Nov 2025 16:17:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 09F874E761E
	for <lists+linux-wireless@lfdr.de>; Thu, 20 Nov 2025 15:06:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5523734CFC7;
	Thu, 20 Nov 2025 15:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pRDQkdoJ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ed1-f73.google.com (mail-ed1-f73.google.com [209.85.208.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C906E34BA24
	for <linux-wireless@vger.kernel.org>; Thu, 20 Nov 2025 15:03:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763651006; cv=none; b=ISTPz9Ima1kA9aEwwEn8PqNDz9kDYJYM3RY1hNr1E6Xnv+bzzmZMT12dX9GghN+RNftDPgQJ2WUzLujJzu8kxuM8GZ6llXV7uSNgy8JODWrg6j1YusEREnhnuJW3eOGXS8oRA4cnnyQNy4tOzJ4kc7hsyRSpx0hLmjvHojWUcHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763651006; c=relaxed/simple;
	bh=tTGjUHrfXR5isY+lSEFNNwASkyVwRARVzePML9vCCTo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=htrnlWsK9huyXVy1tnyUJE12+N9pvr4rs1O4bBsLgzsJRUNvRxfOTiXCjwsYwjULgDl4/3u/v1S3LN8eFbZRe4sFGBKfN3RMReEOFhRuyAT2vQZfnmVyoVcyad+AGF0U3ZOfW47zuBzizLka2uKBBNrL4FmA/ZaRxLWLvzdjAjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--elver.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pRDQkdoJ; arc=none smtp.client-ip=209.85.208.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--elver.bounces.google.com
Received: by mail-ed1-f73.google.com with SMTP id 4fb4d7f45d1cf-64165abd7ffso1295535a12.0
        for <linux-wireless@vger.kernel.org>; Thu, 20 Nov 2025 07:03:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1763650979; x=1764255779; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=QTNBohfvQLfYyJiWHtGyLx9FZqAAISthRH9eXaAWBIw=;
        b=pRDQkdoJOB8BfljkDcQrj/uje2IXL2T/x5eZ/wk8Uc4x/XefY5p5EFYXDGT51MXa7A
         I9l55vHaC9zE4/cxhD6UmVf6gV7TpKWoE8cGMDsCdDbQnDkewx6hrqthpt4o94TtQL/u
         MjbcVlir4o3Ji4GPc4Epv0fpq/JlTGllQX22aOwxrTB0zUpmz3DAEXUZAceGwEEaBHb5
         lvxujEoCa4QrSLs6V+CUcQRu2XDzktl3P9vyuulCEbS3jrwzJgkkFTVq1OoRAkt1J6aW
         ekIDBh2nsF6UpK2cJB/ae6naY0w2EbbMIvM2xruXokam9a5643ErVpY8TmJS9Kj3i8CB
         WEwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763650979; x=1764255779;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QTNBohfvQLfYyJiWHtGyLx9FZqAAISthRH9eXaAWBIw=;
        b=I6pPQgK+rMlZXbTF15TQDkX6cjXj3a9CqLGDVxRyF90X0ahDHr6CPbKg4M59YLLPdQ
         XVrZBzvjJQIP5OdBCcGEdXqmsasMMW6UKtwG6vl/aPCcKl7o1thGSLqCSJucWrMdx2Pv
         EF6K7Mm7HqVOmb/Vy/kwTXYCJR5i0LCvAcp5wb0i3lW/J0Sc5jaddIvHro9BLQgwtOhA
         yoPd8RF0pafGtJmapom+wgESgUdbZYtF7dExNbXGm5zObFh57WZuPNheu0eUxfwEbpib
         pDIZZ0/dleGsSpBQSv74PLP+wISDFR+gbPtK7EQauRdRCcH6bGSf6OKKfG6Hbg0CvbNJ
         6s7A==
X-Forwarded-Encrypted: i=1; AJvYcCWLXFGDzaFGRpuEd6b2Lbcprq4ogVXPSkybL31hH3a4kzG3G/3CuCHS6xPqFbpZCDlv/dsIxbmCqnjhtRLN4g==@vger.kernel.org
X-Gm-Message-State: AOJu0YzSuchzUGNcvAAqegMREQIo2v8eNzq2VgKjVl87pCEoBY7H3FTv
	mx4/HqD5aMwtjotACE1nIqWBy+zAMVhRjo52LkxUFPakXiL0JVq+ptvRkc4VWxb2GA6TWjCm97K
	rpw==
X-Google-Smtp-Source: AGHT+IF9OaX/QGeSo05eKeUEdCvjlZVpqfgwLf4/MHL/rv8J5uT/4osVo9PFxwafA3Q6L9NfftMIvUQ5OA==
X-Received: from edb10.prod.google.com ([2002:a05:6402:238a:b0:643:5f58:caa7])
 (user=elver job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6402:268d:b0:640:b1cf:f800
 with SMTP id 4fb4d7f45d1cf-6453d084770mr1885049a12.4.1763650978915; Thu, 20
 Nov 2025 07:02:58 -0800 (PST)
Date: Thu, 20 Nov 2025 15:49:07 +0100
In-Reply-To: <20251120145835.3833031-2-elver@google.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251120145835.3833031-2-elver@google.com>
X-Mailer: git-send-email 2.52.0.rc1.455.g30608eb744-goog
Message-ID: <20251120145835.3833031-7-elver@google.com>
Subject: [PATCH v4 05/35] checkpatch: Warn about context_unsafe() without comment
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

Warn about applications of context_unsafe() without a comment, to
encourage documenting the reasoning behind why it was deemed safe.

Signed-off-by: Marco Elver <elver@google.com>
---
v4:
* Rename capability -> context analysis.
* Avoid nested if.
---
 scripts/checkpatch.pl | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 92669904eecc..a5db6b583b88 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -6722,6 +6722,13 @@ sub process {
 			}
 		}
 
+# check for context_unsafe without a comment.
+		if ($line =~ /\bcontext_unsafe\b/ &&
+		    !ctx_has_comment($first_line, $linenr)) {
+			WARN("CONTEXT_UNSAFE",
+			     "context_unsafe without comment\n" . $herecurr);
+		}
+
 # check of hardware specific defines
 		if ($line =~ m@^.\s*\#\s*if.*\b(__i386__|__powerpc64__|__sun__|__s390x__)\b@ && $realfile !~ m@include/asm-@) {
 			CHK("ARCH_DEFINES",
-- 
2.52.0.rc1.455.g30608eb744-goog


