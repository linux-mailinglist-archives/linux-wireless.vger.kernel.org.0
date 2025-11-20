Return-Path: <linux-wireless+bounces-29185-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F7BFC74CF6
	for <lists+linux-wireless@lfdr.de>; Thu, 20 Nov 2025 16:15:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sea.lore.kernel.org (Postfix) with ESMTPS id 28C2430F74
	for <lists+linux-wireless@lfdr.de>; Thu, 20 Nov 2025 15:14:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C6E63612D4;
	Thu, 20 Nov 2025 15:12:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fVfukvmr"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wr1-f73.google.com (mail-wr1-f73.google.com [209.85.221.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08F4135B152
	for <linux-wireless@vger.kernel.org>; Thu, 20 Nov 2025 15:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763651575; cv=none; b=gS4zYij+X+bZsyIOn/Rb8uGZ7fCcHDLh8h/3G7KvsFgGoWGRKa0GczWKgU5Xeh/H8lzQQ7m17/j2NKv4i1x1XVruBRTWr7Ca2T2ANCQQAfBj2gACpjtWsXtvgGS5PP4PDeUqiRmv5PJJH0VRsb0y9IxWOoLdx5f4WM7CozmQbhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763651575; c=relaxed/simple;
	bh=JsRVhDxMTESFNC0k9j5iAV1EVftZ5NwIrNhmhZrLX5Q=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=PH+Yym2RPCUcRKqz/1p0wyz5AoVJUKrZsTSxdsu32qSPyA0lnklKbvkiydkcm5NPGPXXc1XdS22PE2w55JGgSgncNWbA4TuYyiBxPJ5dmuCd1g4/zq3hT08tCLR3y5oLFL1GybOn8DBsKDmRXQ1ma4CCDlK+jNCe6UhLwRMmHZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--elver.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fVfukvmr; arc=none smtp.client-ip=209.85.221.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--elver.bounces.google.com
Received: by mail-wr1-f73.google.com with SMTP id ffacd0b85a97d-42b2f79759bso1100769f8f.2
        for <linux-wireless@vger.kernel.org>; Thu, 20 Nov 2025 07:12:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1763651543; x=1764256343; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=YhzmKujL7bNVWf02jAjaSOrp3urplpV1YekSTYKrBiM=;
        b=fVfukvmrtlZIh4E5wGUGJEuC5vPOv7dihBhfAbI5aQz5c3kDA3luttWFvQ20epfX4R
         sy1L2NGUzJJ9E4CLFA8moK9/63iPtg72D+v2+iSQVM/gO83xXzliQ9xRKx1EXiWf83Vb
         dFWHRV8xlFwnw3Mj0HYNrmAszRt2pUknH5pk/eVLqXcfCzNw2hgSNrwt+M8k0STZ98P7
         4bpchl8Skgut/02et0r3gtweQK6mORjU+BY7YP3iNqtVpEX81Kjxl7cUgHQZo6mA5ClF
         r9rN2f7Hz5iV/DC1MqYQAj/CMg6VrtkKXpVCxbioheE0Y69YMnLLBew1kCErdSAuFMSz
         F3QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763651543; x=1764256343;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YhzmKujL7bNVWf02jAjaSOrp3urplpV1YekSTYKrBiM=;
        b=Dz+OUk4V8SQqUDmrU2f81W9PpPFEW/b79rk8YVDoBWBW1daEx5ZeP1qC33WSTIYQdY
         makjZNZY11cO4TxESeC84ciQL90ze6banRf5iWx1c8dUyTSkRCJeD3HbplA+Rpj+3r7L
         RsUR3MmvzH/0ovhMKS44u1GOZMx7n3y2HxNZT66XgsClyr+3OCo0yqYjtsczukGjMQew
         E6RnO6e8kTNKxOcQiOmEsal5AoewxOB39F96Xs4an+uW51WGwoztTlNK4/YlatY+TXz+
         xMAzyW7JX2TdPyCl4e1AEHJK6WDYSk4USunEh4MOP7WcEdgZUWvYDk+UUgARLAJM2gKV
         MeTw==
X-Forwarded-Encrypted: i=1; AJvYcCUgeCVRMXT5w54U/TSse5yI3hU5J1HZHSlM5yMc2SYzj893UpnrY8jHw0QE2gwYK2X1cKBctVqvtGe0WpfIXg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzNoYH2EZ3cURn4pK1Gp2K3eItNFOM9lyxeGqjXwvyJoahPc6tf
	jvLmHm51ItNSH1+GGXoLB84/EDJuldWk/dMG0y0sfNzcFu3xW155740j9e99W2BId6pA0g8/x7K
	NrA==
X-Google-Smtp-Source: AGHT+IFL0EI2FVZUMy6GZbaXFPeZWxMdszC7G+QJPxJYJ5Tt54juOMlly5lP2pxtgOuHE3Qi1fA/jEG3bQ==
X-Received: from wrs17.prod.google.com ([2002:a05:6000:651:b0:42b:328d:1994])
 (user=elver job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6000:2287:b0:42b:3bd2:b2f8
 with SMTP id ffacd0b85a97d-42cb9a603f4mr3376737f8f.46.1763651542984; Thu, 20
 Nov 2025 07:12:22 -0800 (PST)
Date: Thu, 20 Nov 2025 16:09:37 +0100
In-Reply-To: <20251120151033.3840508-7-elver@google.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251120145835.3833031-2-elver@google.com> <20251120151033.3840508-7-elver@google.com>
X-Mailer: git-send-email 2.52.0.rc1.455.g30608eb744-goog
Message-ID: <20251120151033.3840508-13-elver@google.com>
Subject: [PATCH v4 12/35] bit_spinlock: Include missing <asm/processor.h>
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

Including <linux/bit_spinlock.h> into an empty TU will result in the
compiler complaining:

./include/linux/bit_spinlock.h:34:4: error: call to undeclared function 'cpu_relax'; <...>
   34 |                         cpu_relax();
      |                         ^
1 error generated.

Include <asm/processor.h> to allow including bit_spinlock.h where
<asm/processor.h> is not otherwise included.

Signed-off-by: Marco Elver <elver@google.com>
---
 include/linux/bit_spinlock.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/bit_spinlock.h b/include/linux/bit_spinlock.h
index c0989b5b0407..59e345f74b0e 100644
--- a/include/linux/bit_spinlock.h
+++ b/include/linux/bit_spinlock.h
@@ -7,6 +7,8 @@
 #include <linux/atomic.h>
 #include <linux/bug.h>
 
+#include <asm/processor.h>  /* for cpu_relax() */
+
 /*
  *  bit-based spin_lock()
  *
-- 
2.52.0.rc1.455.g30608eb744-goog


