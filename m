Return-Path: <linux-wireless+bounces-29649-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 14FD4CB5B47
	for <lists+linux-wireless@lfdr.de>; Thu, 11 Dec 2025 12:52:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6DFF1301A193
	for <lists+linux-wireless@lfdr.de>; Thu, 11 Dec 2025 11:51:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E072C30B538;
	Thu, 11 Dec 2025 11:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="YCtHfTx7"
X-Original-To: linux-wireless@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D912930B524;
	Thu, 11 Dec 2025 11:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765453914; cv=none; b=hmUpUNexiwRCMfrzB1BSt3KikHtTtXhwg6k1T+ds/+C0HweErk8JEc9WGuI4MSu3Ve/E2vqUAXLMnzA6tQkb6BTSV6jTbOgnyb6Fm/WqNvMAUCFDpr6eMm0URGHOvf58Ol0ie/fwCU2LODAVVLZ8vRFu+xDP/KfK8DJHbJt8YAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765453914; c=relaxed/simple;
	bh=WpIi3NiHt72rCR9TsNfja5edDw64OCPZ8812Jd4nQUE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V03kRAFjOqEE65RT/NKoOt0PlFEmZtQtlkYim0yyuQ04uRJGbX7zTY051PJg3A3F0nmNIwZQp0DNgiJW73LvkxAHXtnlW0vAz5u/KB2Q9HHTxkSfani/yjP/QZ429lHQiQn9Anu2A77VQ5cTiXh4PX8JvoSvuF3tdkBbmgA8kwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=YCtHfTx7; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=+ruouxJOUh2d+f+e8HHYpqnGoZEuPo3luh7bn7bAHeI=; b=YCtHfTx7RoM+FUijwKYs4TN7la
	V38IiN6UXEJqoevDxSusV4xIKVmpUvu7bxeHyT1ebhxYje8Y8ewjpnUYe/AwPBWps727+uIgDIxGh
	gHylwobYVFURCe1AhaSiscraq4UreJJ8qzq798CHWb/cBBob/1iZKF377N3zfzcIJ0TOPZsrSel9n
	6sEuHcwYOL0ArmngL2gHZ2LsDyvZyXXzu1RFeIcoPmnUV1UOXv6jd2LeqmWmL1Yf8zM1kQcwdf6KN
	3gr5k3gALYgZb+dCe5b//7iQ82XTD18jysr8AvEqOPt1OtNyHnlF7O1kL1V4e/6nZWZZvwAcoAjKU
	8Sg8GQrA==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vTeLL-0000000ErCa-0UbQ;
	Thu, 11 Dec 2025 10:56:19 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 3748730301A; Thu, 11 Dec 2025 12:51:35 +0100 (CET)
Date: Thu, 11 Dec 2025 12:51:35 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Marco Elver <elver@google.com>
Cc: Boqun Feng <boqun.feng@gmail.com>, Ingo Molnar <mingo@kernel.org>,
	Will Deacon <will@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
	Chris Li <sparse@chrisli.org>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Alexander Potapenko <glider@google.com>,
	Arnd Bergmann <arnd@arndb.de>, Bart Van Assche <bvanassche@acm.org>,
	Christoph Hellwig <hch@lst.de>, Dmitry Vyukov <dvyukov@google.com>,
	Eric Dumazet <edumazet@google.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Ian Rogers <irogers@google.com>, Jann Horn <jannh@google.com>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Johannes Berg <johannes.berg@intel.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Josh Triplett <josh@joshtriplett.org>,
	Justin Stitt <justinstitt@google.com>, Kees Cook <kees@kernel.org>,
	Kentaro Takeda <takedakn@nttdata.co.jp>,
	Lukas Bulwahn <lukas.bulwahn@gmail.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
	Thomas Gleixner <tglx@linutronix.de>, Thomas Graf <tgraf@suug.ch>,
	Uladzislau Rezki <urezki@gmail.com>,
	Waiman Long <longman@redhat.com>, kasan-dev@googlegroups.com,
	linux-crypto@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, linux-security-module@vger.kernel.org,
	linux-sparse@vger.kernel.org, linux-wireless@vger.kernel.org,
	llvm@lists.linux.dev, rcu@vger.kernel.org
Subject: Re: [PATCH v4 06/35] cleanup: Basic compatibility with context
 analysis
Message-ID: <20251211115135.GF3911114@noisy.programming.kicks-ass.net>
References: <20251120145835.3833031-2-elver@google.com>
 <20251120151033.3840508-7-elver@google.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251120151033.3840508-7-elver@google.com>

On Thu, Nov 20, 2025 at 04:09:31PM +0100, Marco Elver wrote:
> +#define DECLARE_LOCK_GUARD_0_ATTRS(_name, _lock, _unlock)		\
> +static inline class_##_name##_t class_##_name##_constructor(void) _lock;\
> +static inline void class_##_name##_destructor(class_##_name##_t *_T) _unlock;
> +
> +#define DECLARE_LOCK_GUARD_1_ATTRS(_name, _lock, _unlock)		\
> +static inline class_##_name##_t class_##_name##_constructor(lock_##_name##_t *_T) _lock;\
> +static inline void class_##_name##_destructor(class_##_name##_t *_T) _unlock;

When you rebase this series; you'll find cleanup.h moved to
__always_inline (because compilers are weird) and these should probably
also switch.

