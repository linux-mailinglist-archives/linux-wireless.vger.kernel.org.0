Return-Path: <linux-wireless+bounces-30611-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 750E7D0C420
	for <lists+linux-wireless@lfdr.de>; Fri, 09 Jan 2026 22:08:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 09C2D302AFB9
	for <lists+linux-wireless@lfdr.de>; Fri,  9 Jan 2026 21:07:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A938F31ED64;
	Fri,  9 Jan 2026 21:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3aufw5g0"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wr1-f65.google.com (mail-wr1-f65.google.com [209.85.221.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 240BE322A1C
	for <linux-wireless@vger.kernel.org>; Fri,  9 Jan 2026 21:07:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767992822; cv=none; b=IDsAm8oZ0p+ea+FmPQ5wDzxflW1jWtJRvTGPN/R2GUGzLIbcaz7RZRcFNdFP+ajZrFBzP1lIQIMVK3gltYvTQwd/9OWPCpTaj2b9TYVaSAVvb+98yVqwZHO9vXjjuGRgf/PS7uaV6kNgLM+JutA8PY8mBQjmeeGfolKViuyqlHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767992822; c=relaxed/simple;
	bh=wZYProj9n7cDm7L+0im3lC/7Zt3vu+GEy+eJDL5drSs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bBKJZTcmx1YmObCYARSPJ9AgC097856rDgCnJITc+KwweDQv9i+eQC8JILC7m9X+i5Uc+KSSOKWmi+BH97fqS6zrXizWy9jzpYbRJ+6fByICWjqXJLKZYUXvaYqMR9il+Gz6JNdzPP/wy5V9taAkiuTiCKOW7hNBa9NVmGDAyss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3aufw5g0; arc=none smtp.client-ip=209.85.221.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f65.google.com with SMTP id ffacd0b85a97d-42fb03c3cf2so2533038f8f.1
        for <linux-wireless@vger.kernel.org>; Fri, 09 Jan 2026 13:06:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1767992818; x=1768597618; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5YiRRXuPlaLabH8Y/4leOeBvuw8o8W+AqfnKT5Dc7EA=;
        b=3aufw5g08msYbZ+sNHV46va9ufdmUPfXEpIdAvge+2QO8/u3FhHTJ76VpoVGzI48gu
         yUXxv5KZLITdEpz24Ml11TDwIVO0GkTffSlr9K/rOk170mT1k3yOeS8S4/FANfY3rrff
         s4+rL13nFUR9fMJk4IRbUjcSv0v0P670zB/ilBpSwMH/rN3JjDCJ1TnMv9tIl2lbvXAp
         TYyJZYYdX6bPNx9dxt+VpkcrKayKQpdXl/HcXnzUOs5F7Yp60NbugiDCQ45ANQl3Y2aR
         RhouAgtXeLl3iYpRcZkAJLNG+6nQkbnRq+0v5HIX2LmGXK94CKcxc8kGWrpOeh2Du6pG
         Wx5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767992818; x=1768597618;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5YiRRXuPlaLabH8Y/4leOeBvuw8o8W+AqfnKT5Dc7EA=;
        b=E8iLNqIcYhEGOvqlgXR5LP/lnMAQJa2UMpPmaU9rL2gx9YL/SsTu8iFr7vdrmmflyv
         ORPFkbHb9MU/MIDSH7jZMl819+ifrp5EVjJwG9Hcj/KMeaOd3s/neTxSOeTQjCLYhB+4
         No+fvabO3FlcHdw5paDD8F7UFDhF2C6EPyy6I2jClS5X3Y8IHMX48eM2zw1lk4mTncjM
         xEg4iIldwaWp63/EfgZlevJk2T/3KiP7mb8ujDMna7oO3CWrDXC1Pq72ZCdvkxOtz4ob
         LXJBtvVqs9zYtS2U3w7IWeetWmnfqBgBrFSPKN2eGDMUMY/9R1Yz0OCWVh58i5gPrRmv
         zhxQ==
X-Forwarded-Encrypted: i=1; AJvYcCXrZ632Cjt4rYX6XdcIAAT/vqv+j8A6bBcdAFvT2hzLp4PNA6Ge7dwExvejt9N1w1vNZ5kSL66cPe2zRghzJQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyktyGR9ibGB5kpXLp67kPwO/hf9FhovUajSSHSYaqdCNwSDHHB
	4E2PkjX+fQ7eV6if04xpubjHq4pCsb58GvzbtDeTqr4bzpx1W0rLH+AaFqZnNwRGcw==
X-Gm-Gg: AY/fxX79dZtgOHSlcdLrjFGCk0KAr5ypN29mMLuvyFrG1WN9aWD+jcvfSGov2miDvfy
	92tR54BpmtdbxuUEMJdG+jHq91hk0Rwyiq92h0kQelCMOrlPyqa2JVuYlgpJpYU2d6LAGrC88LY
	Zaomh1jP8fmZt8DG/oOX1011XadI5lOCMWGdR4fBfYxUhp49A2bca72dLl0rTbGVPpIlX2UfZNY
	vFQ7sPMdsyb0KHUyMc1l30xL7jb6md5C4C1RaUXaQCIc1oXYnjT1V0mHHdTEEKYgEVd+Cbzhksq
	vXa2ZphK4utmOjuzxNL0gUccf2Pz/vXKwJZNNedTaiOZkmlEoKyz2joWlCr/4iv+DFyYcy/FT79
	JICH1ugpCcVMyHQ0oVVDa+j/yJUKwcLYaXHRUuSUGSMvfK6k9a9004dOn/qB68QsQ9u/zDRViY+
	lQZ9B0N+dIu0Ivu50YhuPuvRJaRJUKI97HFflijiKGlSw+9PvO
X-Google-Smtp-Source: AGHT+IGq/RRhgqPG360sNev62yK5kDA+HwwG1xM6/+WULZOG4/KY3n5LdCQUAGWoCEcUzU7iAOtzbQ==
X-Received: by 2002:a05:6000:4023:b0:432:b951:e9fc with SMTP id ffacd0b85a97d-432c37636b0mr12665932f8f.47.1767992817879;
        Fri, 09 Jan 2026 13:06:57 -0800 (PST)
Received: from elver.google.com ([2a00:79e0:2834:9:2965:801e:e18a:cba1])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-432bd5df9c5sm25214398f8f.22.2026.01.09.13.06.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jan 2026 13:06:57 -0800 (PST)
Date: Fri, 9 Jan 2026 22:06:50 +0100
From: Marco Elver <elver@google.com>
To: Bart Van Assche <bvanassche@acm.org>
Cc: Peter Zijlstra <peterz@infradead.org>,
	Boqun Feng <boqun.feng@gmail.com>, Ingo Molnar <mingo@kernel.org>,
	Will Deacon <will@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
	Chris Li <sparse@chrisli.org>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Alexander Potapenko <glider@google.com>,
	Arnd Bergmann <arnd@arndb.de>, Christoph Hellwig <hch@lst.de>,
	Dmitry Vyukov <dvyukov@google.com>,
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
Subject: Re: [PATCH v5 20/36] locking/ww_mutex: Support Clang's context
 analysis
Message-ID: <aWFt6hcLaCjQQu2c@elver.google.com>
References: <20251219154418.3592607-1-elver@google.com>
 <20251219154418.3592607-21-elver@google.com>
 <05c77ca1-7618-43c5-b259-d89741808479@acm.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <05c77ca1-7618-43c5-b259-d89741808479@acm.org>
User-Agent: Mutt/2.2.13 (2024-03-09)

On Fri, Jan 09, 2026 at 12:16PM -0800, Bart Van Assche wrote:
> On 12/19/25 8:40 AM, Marco Elver wrote:
> > Add support for Clang's context analysis for ww_mutex.
> > 
> > The programming model for ww_mutex is subtly more complex than other
> > locking primitives when using ww_acquire_ctx. Encoding the respective
> > pre-conditions for ww_mutex lock/unlock based on ww_acquire_ctx state
> > using Clang's context analysis makes incorrect use of the API harder.
> 
> That's a very short description. It should have been explained in the
> patch description how the ww_acquire_ctx changes affect callers of the
> ww_acquire_{init,done,fini}() functions.

How so? The API is the same (now statically enforced), and there's no
functional change at runtime. Or did I miss something?

> >   static inline void ww_acquire_init(struct ww_acquire_ctx *ctx,
> >   				   struct ww_class *ww_class)
> > +	__acquires(ctx) __no_context_analysis
> > [ ... ]
> >   static inline void ww_acquire_done(struct ww_acquire_ctx *ctx)
> > +	__releases(ctx) __acquires_shared(ctx) __no_context_analysis
> >   {
> > [ ... ]
> >   static inline void ww_acquire_fini(struct ww_acquire_ctx *ctx)
> > +	__releases_shared(ctx) __no_context_analysis
> 
> The above changes make it mandatory to call ww_acquire_done() before
> calling ww_acquire_fini(). In Documentation/locking/ww-mutex-design.rst
> there is an example where there is no ww_acquire_done() call between
> ww_acquire_init() and ww_acquire_fini() (see also line 202).

It might be worth updating the example with what the kernel-doc
documentation recommends (below).

> The
> function dma_resv_lockdep() in drivers/dma-buf/dma-resv.c doesn't call
> ww_acquire_done() at all. Does this mean that the above annotations are
> wrong?

If there's 1 out of N ww_mutex users that missed ww_acquire_done()
there's a good chance that 1 case is wrong.

But generally, depends if we want to enforce ww_acquire_done() or not
which itself is no-op in non-lockdep builds, however, with
DEBUG_WW_MUTEXES it's no longer no-op so it might be a good idea to
enforce it to get proper lockdep checking.

> Is there a better solution than removing the __acquire() and
> __release() annotations from the above three functions?

The kernel-doc comment for ww_acquire_done() says:

	/**
	 * ww_acquire_done - marks the end of the acquire phase
	 * @ctx: the acquire context
	 *
>>	 * Marks the end of the acquire phase, any further w/w mutex lock calls using
>>	 * this context are forbidden.
>>	 *
>>	 * Calling this function is optional, it is just useful to document w/w mutex
>>	 * code and clearly designated the acquire phase from actually using the locked
>>	 * data structures.
	 */
	static inline void ww_acquire_done(struct ww_acquire_ctx *ctx)
		__releases(ctx) __acquires_shared(ctx) __no_context_analysis
	{
	#ifdef DEBUG_WW_MUTEXES
		lockdep_assert_held(ctx);

		DEBUG_LOCKS_WARN_ON(ctx->done_acquire);
		ctx->done_acquire = 1;
	#endif
	}

It states it's optional, but it's unclear if that's true with
DEBUG_WW_MUTEXES builds. I'd vote for enforcing use of
ww_acquire_done(). If there's old code that's not using it, it should be
added there to get proper lockdep checking.

