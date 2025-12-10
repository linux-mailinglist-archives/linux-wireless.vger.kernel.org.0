Return-Path: <linux-wireless+bounces-29640-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D129CB42B6
	for <lists+linux-wireless@lfdr.de>; Wed, 10 Dec 2025 23:50:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3C80B3055B9B
	for <lists+linux-wireless@lfdr.de>; Wed, 10 Dec 2025 22:50:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FF552D7390;
	Wed, 10 Dec 2025 22:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AO3exkGe"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42EEA26056D;
	Wed, 10 Dec 2025 22:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765407002; cv=none; b=oz5AmFCWnw0KsMJK2O838CX0sbSRircEtyjJ/NvmByjWB7xoruuqg/hlhiI5W6ujLZCaYYZaOmLzhDzF6KPBw/hSI1i/xQamk1WBIBdGOyjqdej5XjERXggNhaY+qGcZMxLvzO0J/42r2+nJOYiGyRhOSLk8va0gD4sFI1JWqFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765407002; c=relaxed/simple;
	bh=qW/tF+X/GtmF1/qBlEvZg0QJgsmBQoUZONiEY+CGh0s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SibZZBnO6H6e4OU0AQIXh+Bxwp8n2uUdP8ST8OBFOv2XbnAbXw9Dib4idLFjCHiECEGBobHWcYgzwppeAs8JZChm+YCg09r8nFlWBxmJeY8IIwiW4+CmslPa8f8BXhkUBY1ZJCF04bHsQewwjKDCUtK6p2YUt9WcjF5X9rw0CKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AO3exkGe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D001C4CEF1;
	Wed, 10 Dec 2025 22:50:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765407001;
	bh=qW/tF+X/GtmF1/qBlEvZg0QJgsmBQoUZONiEY+CGh0s=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=AO3exkGe9nKbfvet6/zsxhBl37cIXDnVvN50TlnHA29GEmWWrfZrAHmxs281V3PcM
	 w8i9dwQDFrIKGbj1buQnqWIBRdY+OQV/RidCp4SikXk7xFANcs4g9bOE44rMROiXA9
	 5indEXpSk9hqMDmVgEXdZ5jhDcB7nJqL81Y2A56028sG+Dflc31Gve7lsV5ALgl5t5
	 Nx/7m9WMWKbuuj4Gkh9Am3GzzLgxvfLNJ9ZlQz2t15+5qEeAUhhnP+3aXxrpxulf5/
	 8+AxuKQXlUFczaJK6RjgBZIlaSv1k70gFjf5NOILerGsKTul7tXvrQxQTt/8MFZcYh
	 dkvcoQb5zDo4w==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 31591CE0CA7; Wed, 10 Dec 2025 14:49:59 -0800 (PST)
Date: Wed, 10 Dec 2025 14:49:59 -0800
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Marco Elver <elver@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>,
	Boqun Feng <boqun.feng@gmail.com>, Ingo Molnar <mingo@kernel.org>,
	Will Deacon <will@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
	Chris Li <sparse@chrisli.org>,
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
Subject: Re: [PATCH v4 14/35] rcu: Support Clang's context analysis
Message-ID: <31a77eff-5295-48a9-96be-ecc7ff416317@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20251120145835.3833031-2-elver@google.com>
 <20251120151033.3840508-7-elver@google.com>
 <20251120151033.3840508-15-elver@google.com>
 <98453e19-7df2-43cb-8f05-87632f360028@paulmck-laptop>
 <CANpmjNNsR_+Mx=H6+4zxJHwpRuM7vKUakS8X+edBD521=w4y_g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANpmjNNsR_+Mx=H6+4zxJHwpRuM7vKUakS8X+edBD521=w4y_g@mail.gmail.com>

On Wed, Dec 10, 2025 at 10:50:11PM +0100, Marco Elver wrote:
> On Wed, 10 Dec 2025 at 20:30, Paul E. McKenney <paulmck@kernel.org> wrote:
> > On Thu, Nov 20, 2025 at 04:09:39PM +0100, Marco Elver wrote:
> > > Improve the existing annotations to properly support Clang's context
> > > analysis.
> > >
> > > The old annotations distinguished between RCU, RCU_BH, and RCU_SCHED;
> > > however, to more easily be able to express that "hold the RCU read lock"
> > > without caring if the normal, _bh(), or _sched() variant was used we'd
> > > have to remove the distinction of the latter variants: change the _bh()
> > > and _sched() variants to also acquire "RCU".
> > >
> > > When (and if) we introduce context guards to denote more generally that
> > > "IRQ", "BH", "PREEMPT" contexts are disabled, it would make sense to
> > > acquire these instead of RCU_BH and RCU_SCHED respectively.
> 
>  ^

"I can't read!"  ;-)

> > > The above change also simplified introducing __guarded_by support, where
> > > only the "RCU" context guard needs to be held: introduce __rcu_guarded,
> > > where Clang's context analysis warns if a pointer is dereferenced
> > > without any of the RCU locks held, or updated without the appropriate
> > > helpers.
> > >
> > > The primitives rcu_assign_pointer() and friends are wrapped with
> > > context_unsafe(), which enforces using them to update RCU-protected
> > > pointers marked with __rcu_guarded.
> > >
> > > Signed-off-by: Marco Elver <elver@google.com>
> >
> > Good reminder!  I had lost track of this series.
> >
> > My big questions here are:
> >
> > o       What about RCU readers using (say) preempt_disable() instead
> >         of rcu_read_lock_sched()?
> 
> The infrastructure that is being built up in this series will be able
> to support this, it's "just" a matter of enhancing our various
> interfaces/macros to use the right annotations, and working out which
> kinds of contexts we want to support. There are the obvious
> candidates, which this series is being applied to, as a starting
> point, but longer-term there are other kinds of context rules that can
> be checked with this context analysis. However, I think we have to
> start somewhere.
> 
> > o       What about RCU readers using local_bh_disable() instead of
> >         rcu_read_lock_sched()?
> 
> Same as above; this requires adding the necessary annotations to the
> BH-disabling/enabling primitives.
> 
> > And keeping in mind that such readers might start in assembly language.
> 
> We can handle this by annotating the C functions invoked from assembly
> with attributes like  __must_hold_shared(RCU) or
> __releases_shared(RCU) (if the callee is expected to release the RCU
> read lock / re-enable preemption / etc.) or similar.
> 
> > One reasonable approach is to require such readers to use something like
> > rcu_dereference_all() or rcu_dereference_all_check(), which could then
> > have special dispensation to instead rely on run-time checks.
> 
> Agree. The current infrastructure encourages run-time checks where the
> static analysis cannot be helped sufficiently otherwise (see patch:
> "lockdep: Annotate lockdep assertions for context analysis").

OK, very good.

> > Another more powerful approach would be to make this facility also
> > track preemption, interrupt, NMI, and BH contexts.
> >
> > Either way could be a significant improvement over what we have now.
> >
> > Thoughts?
> 
> The current infrastructure is powerful enough to allow for tracking
> more contexts, such as interrupt, NMI, and BH contexts, and as I
> hinted above, would be nice to eventually get to!  But I think this is
> also a question of how much do we want to front-load for this to be
> useful, and what should incrementally be enhanced while the baseline
> infrastructure is already available.
> 
> I think the current series is the baseline required support to be
> useful to a large fraction of "normal" code in the kernel.

Makes sense to me!

> On a whole, my strategy was to get to a point where maintainers and
> developers can start using context analysis where appropriate, but at
> the same time build up and incrementally add more supported contexts
> in parallel. There's also a good chance that, once baseline support
> lands, more interested parties contribute and things progress faster
> (or so I'd hope :-)).

I know that feelling!  ;-)

OK, for this patch and the SRCU patch based on a quick once-over:

Acked-by: Paul E. McKenney <paulmck@kernel.org>

							Thanx, Paul

