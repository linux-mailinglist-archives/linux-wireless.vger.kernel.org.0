Return-Path: <linux-wireless+bounces-29992-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F5AFCD1E4A
	for <lists+linux-wireless@lfdr.de>; Fri, 19 Dec 2025 22:01:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2D98D30FDB4A
	for <lists+linux-wireless@lfdr.de>; Fri, 19 Dec 2025 20:57:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EAF03242B1;
	Fri, 19 Dec 2025 20:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="42advhE8"
X-Original-To: linux-wireless@vger.kernel.org
Received: from 013.lax.mailroute.net (013.lax.mailroute.net [199.89.1.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CC032D73A7;
	Fri, 19 Dec 2025 20:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766177837; cv=none; b=PqcqK593N/ITXmSJFsUoPT7xAY8HfTzppFr96f9IX+vsKm1mpnNo+s+YwCFxGSdB7+jINBo357Ny57wez80suzTD+e4Mjh+YzqqaCFDJUXFNKXT7hp1j2MCZYWOb211B83ywGheWbrs3+60Hsyv40II4zxUJdMLMQzL8C0ueGiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766177837; c=relaxed/simple;
	bh=UUutlXsyKb2gG6q2Bb60u4frplNSTg/akfFMQ0csH/s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OSt6/g8STgF+MvRfx9kYYt8DSOwq8D7l9im2JxQw5W95Vr8rnWfUdiIG3WO/uUjwnAhCG33c+sQgH4MQdlCegqyDO7wn2ERKKSRzAImm0aZQZqqyzydDS5Feg+pKxZFRugWmeo6cBTW7SgwVqw4oma64tatilXCsvjU8V85JHQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=42advhE8; arc=none smtp.client-ip=199.89.1.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Received: from localhost (localhost [127.0.0.1])
	by 013.lax.mailroute.net (Postfix) with ESMTP id 4dY0GL6DqzzlwqQK;
	Fri, 19 Dec 2025 20:57:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1766177827; x=1768769828; bh=4FWBwq5pA2UdoaEgzi2KEETe
	O4vK6VBDGoxeKhWq2EE=; b=42advhE8BUZnyv/5oJUUeZfNT/pyn/krhapzDFZR
	OBUJ0SwyUsXO7uWfZ6iD0TrvIUO0ufVYHcs9gPs9Yqxc4qotWvsEzwGramYp6CYN
	o+EGCohH3V8J9IhuomIk/LCHjW3RgZPH2dV8y8Y9/buyyKUpXBWBMrItfx8AOqTX
	jq7pYXvADCFY2Cl8TGfhSzpmEiMCCTvc43oPwpNA7c+USkz6m87eVaXEmQbE1pLZ
	puRIt1KDSkfXRrJ6t868WlCL5q0CmJX9IeVQSPmC/fOCbhWY/f8+bgPqRX1GSUKF
	gqoq4DJuwCbsLvpoRdEwWeEfLonpdDECo4UR7y1nVmqsyg==
X-Virus-Scanned: by MailRoute
Received: from 013.lax.mailroute.net ([127.0.0.1])
 by localhost (013.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id cbXucOoI7gI2; Fri, 19 Dec 2025 20:57:07 +0000 (UTC)
Received: from [100.119.48.131] (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 013.lax.mailroute.net (Postfix) with ESMTPSA id 4dY0Fy2c2mzlwqPy;
	Fri, 19 Dec 2025 20:56:53 +0000 (UTC)
Message-ID: <4d6ba8aa-cc33-42a5-ae28-7a480d660c45@acm.org>
Date: Fri, 19 Dec 2025 12:56:53 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 18/36] locking/local_lock: Include missing headers
To: Marco Elver <elver@google.com>, Peter Zijlstra <peterz@infradead.org>,
 Boqun Feng <boqun.feng@gmail.com>, Ingo Molnar <mingo@kernel.org>,
 Will Deacon <will@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>,
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
 Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
 Thomas Gleixner <tglx@linutronix.de>, Thomas Graf <tgraf@suug.ch>,
 Uladzislau Rezki <urezki@gmail.com>, Waiman Long <longman@redhat.com>,
 kasan-dev@googlegroups.com, linux-crypto@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kbuild@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 linux-security-module@vger.kernel.org, linux-sparse@vger.kernel.org,
 linux-wireless@vger.kernel.org, llvm@lists.linux.dev, rcu@vger.kernel.org
References: <20251219154418.3592607-1-elver@google.com>
 <20251219154418.3592607-19-elver@google.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20251219154418.3592607-19-elver@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable

On 12/19/25 7:40 AM, Marco Elver wrote:
> Including <linux/local_lock.h> into an empty TU will result in the
> compiler complaining:
>=20
> ./include/linux/local_lock.h: In function =E2=80=98class_local_lock_irq=
save_constructor=E2=80=99:
> ./include/linux/local_lock_internal.h:95:17: error: implicit declaratio=
n of function =E2=80=98local_irq_save=E2=80=99; <...>
>     95 |                 local_irq_save(flags);                        =
  \
>        |                 ^~~~~~~~~~~~~~
>=20
> As well as (some architectures only, such as 'sh'):
>=20
> ./include/linux/local_lock_internal.h: In function =E2=80=98local_lock_=
acquire=E2=80=99:
> ./include/linux/local_lock_internal.h:33:20: error: =E2=80=98current=E2=
=80=99 undeclared (first use in this function)
>     33 |         l->owner =3D current;
>=20
> Include missing headers to allow including local_lock.h where the
> required headers are not otherwise included.
>=20
> Signed-off-by: Marco Elver <elver@google.com>
> ---
>   include/linux/local_lock_internal.h | 2 ++
>   1 file changed, 2 insertions(+)
>=20
> diff --git a/include/linux/local_lock_internal.h b/include/linux/local_=
lock_internal.h
> index 8f82b4eb542f..1a1ea1232add 100644
> --- a/include/linux/local_lock_internal.h
> +++ b/include/linux/local_lock_internal.h
> @@ -4,7 +4,9 @@
>   #endif
>  =20
>   #include <linux/percpu-defs.h>
> +#include <linux/irqflags.h>
>   #include <linux/lockdep.h>
> +#include <asm/current.h>
>  =20
>   #ifndef CONFIG_PREEMPT_RT
>  =20

The abbreviation "TU" is uncommon. Hence, please expand that
abbreviation. Anyway:

Reviewed-by: Bart Van Assche <bvanassche@acm.org>

