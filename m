Return-Path: <linux-wireless+bounces-30612-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B7D25D0C4CC
	for <lists+linux-wireless@lfdr.de>; Fri, 09 Jan 2026 22:27:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 574CE303F794
	for <lists+linux-wireless@lfdr.de>; Fri,  9 Jan 2026 21:26:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6711033D4F2;
	Fri,  9 Jan 2026 21:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="UQJCMP5/"
X-Original-To: linux-wireless@vger.kernel.org
Received: from 013.lax.mailroute.net (013.lax.mailroute.net [199.89.1.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17A7B31B133;
	Fri,  9 Jan 2026 21:26:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767994007; cv=none; b=Wa9O5z0ie0Xj4eFrtzSN4aKooD6M9zO0FbeM6RzNDlkwAK3SDln8XGixV2LGS0yiQgF7dw26r9lCHQkhFHKxQhF3AvCJv17S8nOGjsR9t8Nv4Vvm7RfkiUGXUOt9aKFVtsvFdqf7l9kLCQTBrOSQx3wnpiuF7uAw8SXkMW00KGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767994007; c=relaxed/simple;
	bh=kVqxi06fhKwoZgXTNpFdWEZ/nlKbofAaMwqmPcPl6V4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lahfa1wI201GRGtxBCAMsjBt5v8V3TEqgZK2MQbDqDhgKNXeXlOTrVDFmFh4sHd9MFy0Dx7M2VV+IROHxW4Q1PDTx9G+ycovEv0GLlf3Y4yd/tRI890dIM9yMIHS7HTxnP5VdchHjgsmkC2mGOdYrwN5GhFHlLZ0jl8ZAPVUqVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=UQJCMP5/; arc=none smtp.client-ip=199.89.1.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Received: from localhost (localhost [127.0.0.1])
	by 013.lax.mailroute.net (Postfix) with ESMTP id 4dnvwj1rSVzlsqj1;
	Fri,  9 Jan 2026 21:26:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1767993997; x=1770585998; bh=kVqxi06fhKwoZgXTNpFdWEZ/
	nlKbofAaMwqmPcPl6V4=; b=UQJCMP5/4z5OkbytmihEViGuPxzO9MDFixo1jD/j
	b7B+ZCP9e73vZ3Lw5l0wl4bbaMC2+1fC/nuUtQ5Qlw8nIM+EbIuZnUW2Zu/mse1A
	d/KzsFdZLLYSLdLoVcxZsopqYXBfFggKKaS7l/Xzj0d4R6LcnSGzVLTsWnjCAzlG
	j0jGrM6I8VxGPhZFu7ln5JERHarPuFgd6jxrRZWTvlb8pN9qri//ThxalZKJAw4M
	2ayFAwPTWuSmIOsoqZCnT3A2Zko5jGsXg7uSYnllHsZ6Dee9gPu+KHIXFaJFY3DW
	2utpFE0Zij1eDpkq5UWLB4QwFY0l4H0xzCVpLK9pcF9oMw==
X-Virus-Scanned: by MailRoute
Received: from 013.lax.mailroute.net ([127.0.0.1])
 by localhost (013.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id 4NnprJS4L2Lu; Fri,  9 Jan 2026 21:26:37 +0000 (UTC)
Received: from [100.119.48.131] (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 013.lax.mailroute.net (Postfix) with ESMTPSA id 4dnvwJ0Q9kzm10Bh;
	Fri,  9 Jan 2026 21:26:23 +0000 (UTC)
Message-ID: <8143ab09-fd9b-4615-8afb-7ee10e073c51@acm.org>
Date: Fri, 9 Jan 2026 13:26:23 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 20/36] locking/ww_mutex: Support Clang's context
 analysis
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
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
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <aWFt6hcLaCjQQu2c@elver.google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

(+Maarten)

On 1/9/26 2:06 PM, Marco Elver wrote:
> If there's 1 out of N ww_mutex users that missed ww_acquire_done()
> there's a good chance that 1 case is wrong.

$ git grep -w ww_acquire_done '**c'|wc -l
11
$ git grep -w ww_acquire_fini '**c'|wc -l
33

The above statistics show that there are more cases where
ww_acquire_done() is not called rather than cases where
ww_acquire_done() is called.

Maarten, since you introduced the ww_mutex code, do you perhaps prefer
that calling ww_acquire_done() is optional or rather that all users that
do not call ww_acquire_done() are modified such that they call
ww_acquire_done()? The full email conversation is available here:
https://lore.kernel.org/all/20251219154418.3592607-1-elver@google.com/

Thanks,

Bart.

