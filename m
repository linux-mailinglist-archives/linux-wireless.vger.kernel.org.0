Return-Path: <linux-wireless+bounces-30696-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 23EC5D11E9F
	for <lists+linux-wireless@lfdr.de>; Mon, 12 Jan 2026 11:34:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1BA423079055
	for <lists+linux-wireless@lfdr.de>; Mon, 12 Jan 2026 10:33:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B09E330F801;
	Mon, 12 Jan 2026 10:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HPd93T2C"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18CA52D2481;
	Mon, 12 Jan 2026 10:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768214001; cv=none; b=EGzy6pVrJCWYQq0LW5lNVtfjc5Ubk1ZidVLFrgzHcEDnQYzRaPNUo7Jh0nPPZjnnOVqRLCGsP2f9Zdjq1+9KoNwMPg6o8RSfKejK4/+IDfbrXT0DuWhFxnQfWj6ogbR9bZRScOunW/RIzgz870lHLMVkeQRUqYf0dNUIpECBoN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768214001; c=relaxed/simple;
	bh=3WvoLxWPBX/nvNBdAet0EG4DRqalXwTIWl2WlwowKOE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Xylum5bs/JG8rntzj3XYXCkX2gQvuA9nBM44LFnij4DKpUbzkM62aU9ZclbAv8wBdvA2D4WOjuw6g0LTyamFYeZA1dETpEwCVPVzW0KzI8oOZewe8o8tP2Fcq+dy0vynmhsIsrXeS5Hgr4XHGZmxYOnRvoRI2/Ymdh9uOSSktj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HPd93T2C; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768214000; x=1799750000;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=3WvoLxWPBX/nvNBdAet0EG4DRqalXwTIWl2WlwowKOE=;
  b=HPd93T2Cje9vVucJkaUuwtO2R9nSXSGGb7Czteg2Mpt2VA0e+H6w4Wm0
   2WOZevI4pMou1Eaizea/iLOnE9uLYmMDqpY0nVQOiEG9KIFhal6DZSroi
   /jStJ1zmcRfF7wOg8ihT4xQVyUbIOomDnJU5CCKx30OJqKcbEqzvUoAFm
   Hs3/mL/i+6p/RVarAQ4pGk1F/7DxtNvggrw/aSTRQhVoxIJwL0mwFiF0K
   4PK8vU3vmnJaHcOmVtXi/I+BocHUU/moTYV6UvrPo+g9u4rmS7eMgu4vc
   UsonMKsKJbWWd3rNJ9LP2we5U9X7pr1MvYzTydMSyo//A+0NiziBlSJmv
   A==;
X-CSE-ConnectionGUID: iGmtH3+TSDqYP+qWK3cczw==
X-CSE-MsgGUID: JaSF/uxrRXS4q1E1oIpKTw==
X-IronPort-AV: E=McAfee;i="6800,10657,11668"; a="80939936"
X-IronPort-AV: E=Sophos;i="6.21,219,1763452800"; 
   d="scan'208";a="80939936"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2026 02:32:39 -0800
X-CSE-ConnectionGUID: KeVRm3ThTIyu/02WLS2Cvw==
X-CSE-MsgGUID: T5zF6Dw6TdejExXJJsJSFw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,219,1763452800"; 
   d="scan'208";a="241588226"
Received: from fpallare-mobl4.ger.corp.intel.com (HELO [10.245.245.90]) ([10.245.245.90])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2026 02:32:28 -0800
Message-ID: <1502e5eb-0ac7-4581-85ce-2f0c390bd7db@linux.intel.com>
Date: Mon, 12 Jan 2026 11:32:25 +0100
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 20/36] locking/ww_mutex: Support Clang's context
 analysis
To: Bart Van Assche <bvanassche@acm.org>
Cc: Marco Elver <elver@google.com>, Peter Zijlstra <peterz@infradead.org>,
 Boqun Feng <boqun.feng@gmail.com>, Ingo Molnar <mingo@kernel.org>,
 Will Deacon <will@kernel.org>, "David S. Miller" <davem@davemloft.net>,
 Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
 Chris Li <sparse@chrisli.org>, "Paul E. McKenney" <paulmck@kernel.org>,
 Alexander Potapenko <glider@google.com>, Arnd Bergmann <arnd@arndb.de>,
 Christoph Hellwig <hch@lst.de>, Dmitry Vyukov <dvyukov@google.com>,
 Eric Dumazet <edumazet@google.com>, Frederic Weisbecker
 <frederic@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Herbert Xu <herbert@gondor.apana.org.au>, Ian Rogers <irogers@google.com>,
 Jann Horn <jannh@google.com>, Joel Fernandes <joelagnelf@nvidia.com>,
 Johannes Berg <johannes.berg@intel.com>, Jonathan Corbet <corbet@lwn.net>,
 Josh Triplett <josh@joshtriplett.org>, Justin Stitt
 <justinstitt@google.com>, Kees Cook <kees@kernel.org>,
 Kentaro Takeda <takedakn@nttdata.co.jp>,
 Lukas Bulwahn <lukas.bulwahn@gmail.com>, Mark Rutland
 <mark.rutland@arm.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Miguel Ojeda <ojeda@kernel.org>, Nathan Chancellor <nathan@kernel.org>,
 Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
 Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
 Steven Rostedt <rostedt@goodmis.org>,
 Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
 Thomas Gleixner <tglx@linutronix.de>, Thomas Graf <tgraf@suug.ch>,
 Uladzislau Rezki <urezki@gmail.com>, Waiman Long <longman@redhat.com>,
 kasan-dev@googlegroups.com, linux-crypto@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kbuild@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 linux-security-module@vger.kernel.org, linux-sparse@vger.kernel.org,
 linux-wireless@vger.kernel.org, llvm@lists.linux.dev, rcu@vger.kernel.org
References: <20251219154418.3592607-1-elver@google.com>
 <20251219154418.3592607-21-elver@google.com>
 <05c77ca1-7618-43c5-b259-d89741808479@acm.org>
 <aWFt6hcLaCjQQu2c@elver.google.com>
 <8143ab09-fd9b-4615-8afb-7ee10e073c51@acm.org>
Content-Language: en-US
From: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
In-Reply-To: <8143ab09-fd9b-4615-8afb-7ee10e073c51@acm.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hey,

The acquire_done() call was always optional. It's meant to indicate that after this point,
ww_acquire_lock may no longer be called and backoff can no longer occur.

It's allowed to call ww_acquire_fini() without ww_acquire_done()

Think of this case:
ww_acquire_init()

ww_acquire_lock_interruptible() -> -ERESTARTSYS

ww_acquire_fini()

Here it wouldn't make sense to call ww_acquire_done().

It's mostly to facilitate this case:

ww_acquire_init()

ww_acquire_lock() a bunch.

/* Got all locks, do the work as no more backoff occurs */
ww_acquire_done()

...

unlock_all()
ww_acquire_fini()

If you call ww_acquire_lock after done, a warning should occur as this should no longer happen.

Kind regards,
~Maarten Lankhorst

Den 2026-01-09 kl. 22:26, skrev Bart Van Assche:
> (+Maarten)
> 
> On 1/9/26 2:06 PM, Marco Elver wrote:
>> If there's 1 out of N ww_mutex users that missed ww_acquire_done()
>> there's a good chance that 1 case is wrong.
> 
> $ git grep -w ww_acquire_done '**c'|wc -l
> 11
> $ git grep -w ww_acquire_fini '**c'|wc -l
> 33
> 
> The above statistics show that there are more cases where
> ww_acquire_done() is not called rather than cases where
> ww_acquire_done() is called.
> 
> Maarten, since you introduced the ww_mutex code, do you perhaps prefer
> that calling ww_acquire_done() is optional or rather that all users that
> do not call ww_acquire_done() are modified such that they call
> ww_acquire_done()? The full email conversation is available here:
> https://lore.kernel.org/all/20251219154418.3592607-1-elver@google.com/
> 
> Thanks,
> 
> Bart.


