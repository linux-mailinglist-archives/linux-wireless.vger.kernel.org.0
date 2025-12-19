Return-Path: <linux-wireless+bounces-30002-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 260FFCD203C
	for <lists+linux-wireless@lfdr.de>; Fri, 19 Dec 2025 22:38:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id BCE4D3038AD8
	for <lists+linux-wireless@lfdr.de>; Fri, 19 Dec 2025 21:38:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0DFD28134F;
	Fri, 19 Dec 2025 21:38:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PZXXDITX"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pl1-f193.google.com (mail-pl1-f193.google.com [209.85.214.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F120285050
	for <linux-wireless@vger.kernel.org>; Fri, 19 Dec 2025 21:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766180299; cv=none; b=De44rjepfiTgGLu2JAVJKdHnlUGz2KyXBof08HxPcq28lj5NbBbyY8H5egexAUE5INVoQsfontThmKmjLvQmXVuNiLO+7meEEfup9RE4cP13i4tTlggIu3CNxf5hkMlwLrFvvu4eKj30sgu7BpvFa7pI35ah/FS36Yb3p3SN67g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766180299; c=relaxed/simple;
	bh=SBHXkRgMesGUJGSlI+YkckhHJhyJOUbeeY6s/H5FeUc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=r7HgIs7EHU1emPMsDMuz6qHeUfHbTlAlhQVn35K61XyqzH4JoMc3jSo0dsdO7pG8ayLOYKCgLRZJRCsi2t8Oxk+vvuELgqvs18VJFghhaSlIil2D1XuKAJOIpLRZlPtprfBINX7A7gpCNab7t7TVB60c7p3KddAitk9xdwNhwn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PZXXDITX; arc=none smtp.client-ip=209.85.214.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f193.google.com with SMTP id d9443c01a7336-2a2ea96930cso22706965ad.2
        for <linux-wireless@vger.kernel.org>; Fri, 19 Dec 2025 13:38:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766180296; x=1766785096; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SBHXkRgMesGUJGSlI+YkckhHJhyJOUbeeY6s/H5FeUc=;
        b=PZXXDITX8O2pITtu53MVdLOAN8xLa+E4T8O59SLKUmlhw5IGVuOVSaPVKr3RLgyRi9
         FFkrGh/mG35OypARILyigj6YN0GxLJ3X3MOyK+Jvg6PjLDf3Dq2LmoZ2Sj9s/vukVIFq
         LzzBAqPmENgXRvU7eSOKxVcijftEUHTO1jAq7CC7D0kpCfHRoPh2jBjS30aoCTlf+rtk
         nw9MA21zYZJBvVw3CEwwUHEc5WUM5bMNKamyH44/Jthx3UNRJwNqNDyGqhB/ZUDiPjj8
         /SJ5Mj3VpKOHOujtfOTulYT13laYJWXVJsjSmabdQezKKZkPMS3oWx9RPm6XWm7dEXsO
         n3+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766180296; x=1766785096;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SBHXkRgMesGUJGSlI+YkckhHJhyJOUbeeY6s/H5FeUc=;
        b=pt9EtV9QhStcW8+RqFhnbaeq9xNS23P7X1bDaEs4Zn6PTzxoVjV+kdqfuui/AMURoM
         FYcrn+o/BZoZhv+Y3Aw8SM+SPVImLbxnZARxUb2iPokHe4w6BuNONbxZjeefdgyXYKNA
         H+O2mzGw7Y7xNjw2//yrgOyJ/imk5cwEwblS1F29kwvnPCSnRnuT4wsKtRlf2pKHhC0j
         UKUEXB8LFaZwiuH1nRoE81bD8bneq2n1zf5oewJP1AS3voiMgbGUEpcLzI2bDn7mcufx
         RpQ/QdsIi+qKDOjW2bGJbVAJXBNl9X5nbKFuaYBGSLEFNI9/RnuB9UxniMSRTqe1iH4v
         214g==
X-Forwarded-Encrypted: i=1; AJvYcCVrtL2M3IILDTBkzlqACkNBzrOdPxodEgETwsudLv8SXVdlUYiki39AikBYB7ZBU7lte0zXQXbLGwBPqU6SPA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyALSSd2O1iS1Dl88MHfi4FxL+wIWiTpXJZAoNb0wAlZuxxtgsr
	anUixfqokEEY4/FHtnq19qS9w1Hc1TaJuz4yKQoNaA++1e1+xoh1Ry+J
X-Gm-Gg: AY/fxX6bDZctVPuA2oaDuC2EHomgjiE6OzOetpb0kSzIEEQyLuOs32/9JLdCHNzRKHZ
	9ZXwiXxickGVqcO6WdoGag3kOfD2HUZltL5m5pPrjdCDZu/dc647+CkpYtY7sq/TznPKMKzg7J9
	oBNWCZLSh/fYwb3nIAlNXug99bFyf4Syus2RGCg91ScTxlpHeNAFoeWNU3Ul/2vXrwm7Anf9mbC
	AT9yUiVa3j1XGHN5vnTxVj5bw9qO6xQ+utV5gks0n/8YLdE+wq85ILcw5JKWGMoGNBKU7v3Mfki
	cyMba1Ocoki2BwfJnkj0yD0LzbmzryrcguGpj8ZGmCtVqSaAlRq6EjB3m7YyVA7k1FURMn3SZbG
	w7pQ7TcKLns4YuSP+vYWBwWsCUDuAvznUqJUKgDb9BG8vv3B1vSBOPiYN/u8zCHYXua15i8U9EB
	haIh+xWKTkQQw6PIZK3jMzEd6s6o2sNMC4x9MbnACyP/6HY9pl2aFcN6p76Dnt7/1r4OKXLYR+N
	2oqNeuOS2EtVejGRNsvKj8o6yBbKKCMaQTZF+GpAeQ0A8U2SWCVwFM6B7Les6JTd6kL4NI6oB9G
	eIc=
X-Google-Smtp-Source: AGHT+IGivulZwqOvq9TkwT/0JBobQprm3JRJ6VtJUw4ydSXEmlT/iKTWxEeMw8/Q4ZWRYLdEwZEKQQ==
X-Received: by 2002:a05:7022:e0c:b0:11a:f5e0:dc8 with SMTP id a92af1059eb24-121722f462emr3455845c88.28.1766180295388;
        Fri, 19 Dec 2025 13:38:15 -0800 (PST)
Received: from ?IPV6:2a00:79e0:2e7c:8:5874:79f3:80da:a7a3? ([2a00:79e0:2e7c:8:5874:79f3:80da:a7a3])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-121724cfd95sm12051531c88.1.2025.12.19.13.38.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Dec 2025 13:38:14 -0800 (PST)
Message-ID: <34cda24f-acdc-4049-9869-b666b08897d9@gmail.com>
Date: Fri, 19 Dec 2025 14:38:12 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 23/36] compiler-context-analysis: Remove Sparse support
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
 <20251219154418.3592607-24-elver@google.com>
Content-Language: en-US
From: Bart Van Assche <bart.vanassche@gmail.com>
In-Reply-To: <20251219154418.3592607-24-elver@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/19/25 8:40 AM, Marco Elver wrote:
> Remove Sparse support as discussed at [1].

Kernel patch descriptions should be self-contained. In other words, the
conclusion from [1] should be summarized in the patch description
instead of only referring to that discussion with a hyperlink.

Thanks,

Bart.

