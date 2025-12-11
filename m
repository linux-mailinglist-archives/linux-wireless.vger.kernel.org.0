Return-Path: <linux-wireless+bounces-29652-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D01FCCB5D9D
	for <lists+linux-wireless@lfdr.de>; Thu, 11 Dec 2025 13:29:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 314B0304A500
	for <lists+linux-wireless@lfdr.de>; Thu, 11 Dec 2025 12:27:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C46342EC559;
	Thu, 11 Dec 2025 12:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="K0YdkMUJ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7030D2D978D;
	Thu, 11 Dec 2025 12:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765456010; cv=none; b=i7P5wNHCUd5+SAGWpOJCRdNbVYZUOkwBjBGsPGcbgAHyi1kugZlxlZTJHi2I+5SjCKrHUbL0UUGKBqXUWbSXiv3nNocxx8i0uX5oi6DQA/VDzEbumvzx/5onTGzmrZvKenBGtBiwWgWj9uAfAduJ4VD07rPCUIp3NDIrJKBZWY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765456010; c=relaxed/simple;
	bh=k+xRpM4Z1Oucbie7O6S+5dCH8+G8rGP3jsUF9Izc83s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mQVgO++frOEaHFCbrvRGcWtsu7MwMR3pBlxd3HU2+CPkARX2lMazt90HcUk1QuQPXELkEz3RcrJt++YK3A04GvahM69yedyflqNLCrHi65wVbNWtXPdcNWuBK1YkZb0oJLGiIjQ2kOaVP/UgXzzt8W+xgC6OniFyjHmh7nLYlCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=K0YdkMUJ; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=TvaOJBAIvNxAg3dFoJJOVlV+NfsswdVw/SLF3Bn6Td0=; b=K0YdkMUJPOvWjO/lZj5urNguxm
	ZAiBii+Ae2fBpzdAfhrQzMGnUP3OjzC9L9mkrVvZjWEQfpAlquZ++ph67woSYii/zBMmEHvUQvUwV
	xzs6+MQ7OffQfjNrP9FO5P+EazF/4oqKTpptXPWWYxOTha9knM9dDMsotyDXKr+nKvwfSHhl3uQxc
	yM6eQewjA5dor1BxkERq6vqwKUckiZb1Lc2G/5lSdOV2RBYn9tqjrefNrpKqtnduWuALuI4pgaRBT
	XEHR80cmqPsAni9JZK/UPwxwegbKAnsh7vy0FTdUaPzJdezsXecMJ09nNIv88zolGW5szyo7rHJk6
	mfgk/OeA==;
Received: from 2001-1c00-8d85-5700-266e-96ff-fe07-7dcc.cable.dynamic.v6.ziggo.nl ([2001:1c00:8d85:5700:266e:96ff:fe07:7dcc] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vTetE-0000000EuI9-0zph;
	Thu, 11 Dec 2025 11:31:20 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 9A28A30301A; Thu, 11 Dec 2025 13:26:36 +0100 (CET)
Date: Thu, 11 Dec 2025 13:26:36 +0100
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
Subject: Re: [PATCH v4 16/35] kref: Add context-analysis annotations
Message-ID: <20251211122636.GI3911114@noisy.programming.kicks-ass.net>
References: <20251120145835.3833031-2-elver@google.com>
 <20251120151033.3840508-7-elver@google.com>
 <20251120151033.3840508-17-elver@google.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251120151033.3840508-17-elver@google.com>

On Thu, Nov 20, 2025 at 04:09:41PM +0100, Marco Elver wrote:
> Mark functions that conditionally acquire the passed lock.
> 
> Signed-off-by: Marco Elver <elver@google.com>
> ---
>  include/linux/kref.h | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/include/linux/kref.h b/include/linux/kref.h
> index 88e82ab1367c..9bc6abe57572 100644
> --- a/include/linux/kref.h
> +++ b/include/linux/kref.h
> @@ -81,6 +81,7 @@ static inline int kref_put(struct kref *kref, void (*release)(struct kref *kref)
>  static inline int kref_put_mutex(struct kref *kref,
>  				 void (*release)(struct kref *kref),
>  				 struct mutex *mutex)
> +	__cond_acquires(true, mutex)
>  {
>  	if (refcount_dec_and_mutex_lock(&kref->refcount, mutex)) {
>  		release(kref);
> @@ -102,6 +103,7 @@ static inline int kref_put_mutex(struct kref *kref,
>  static inline int kref_put_lock(struct kref *kref,
>  				void (*release)(struct kref *kref),
>  				spinlock_t *lock)
> +	__cond_acquires(true, lock)
>  {
>  	if (refcount_dec_and_lock(&kref->refcount, lock)) {
>  		release(kref);
> -- 
> 2.52.0.rc1.455.g30608eb744-goog
> 

Note that both use the underlying refcount_dec_and_*lock() functions.
Its a bit sad that annotation those isn't sufficient. These are inline
functions after all, the compiler should be able to see through all that.

