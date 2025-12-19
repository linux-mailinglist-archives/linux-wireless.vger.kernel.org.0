Return-Path: <linux-wireless+bounces-30000-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BCA9CD1F73
	for <lists+linux-wireless@lfdr.de>; Fri, 19 Dec 2025 22:29:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C1445305D7B0
	for <lists+linux-wireless@lfdr.de>; Fri, 19 Dec 2025 21:28:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1AD1342538;
	Fri, 19 Dec 2025 21:28:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RMtyxVaH"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pf1-f195.google.com (mail-pf1-f195.google.com [209.85.210.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1226533B6D2
	for <linux-wireless@vger.kernel.org>; Fri, 19 Dec 2025 21:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766179734; cv=none; b=KKO6HmsTlsOmmaqW8Uyx5jn6L7LAIDkT0y/q+rNydhEZNfw3DUFnt2NiXNSGabS4ng/G/WnEpEHnpMzRaDGkTXS5RO2Y2R4zPSDM6mgZQZb8tU2cUylJh7tHElUfvfwdlaYpfYhw7jayD1rSyB3UftWqaGt/Ay4lFULmv0M31Uw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766179734; c=relaxed/simple;
	bh=9qdyLYhk6D9KpgNEc9lTRHJNMgr66Y5zIziSEMCrXTM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AyiiP+lcKI9VoPhyOHfSNvQ/jfgazDJ5y+2ft85t7ibIJ00CQy9/hyvJIXyCEiRfZkjn6xQpOYcsk3mRCL1keDrf4W0yfOlSxmJtoLkFPs6cfXBPk0l3I3wYeU1Q18mvldexc+/VMGU0W74EK5ISND31rEEOf/Zm2NEVKonHSkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RMtyxVaH; arc=none smtp.client-ip=209.85.210.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f195.google.com with SMTP id d2e1a72fcca58-7ade456b6abso1926621b3a.3
        for <linux-wireless@vger.kernel.org>; Fri, 19 Dec 2025 13:28:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766179731; x=1766784531; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9qdyLYhk6D9KpgNEc9lTRHJNMgr66Y5zIziSEMCrXTM=;
        b=RMtyxVaHlb4x5czCBEyOx56xfjT+RNoyzgmUIOLM8rQyyjHAn8b14RHWVg+U9yECU2
         DNet9BX2LSDx+fbfhj2eagJwVgKFUN3paA/J0jVpzr17MqrPGIkC8uWMpzr25M5n/Svh
         riLL7VUKYl3lLur1iiIDnUxqZzSyVldJOlWErwA4BYTCmBjZa+IIIv/4tggBwnPyd5N1
         4sP+EomK5LaRfaouO3drpoA8BG7gNbSc2L4KFhFCx08iZDlPsih1J+3De+KvkTA6nBjx
         xSBUnB9EV5NlQAOueOI5ovsh9ZrpK2mKI2rYqZMt2HvppVyMTV6Z5xJIcetFL+mvKY9C
         JWsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766179731; x=1766784531;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9qdyLYhk6D9KpgNEc9lTRHJNMgr66Y5zIziSEMCrXTM=;
        b=O3QAXJDBmaT0MRmVGCcdfnXD5tK0I9j1vVnrQlMAW3Ut15fl+RQZ0xtcgk4mGMm93f
         9iu0ZiiBCB187yZUrE3dwYU9KPj7E0XsLq/OflgZoZmm/0TuheBB+U5TKCX15mLwrK+z
         n+i5pLe5Q+hQGFmq2znmJDHvdHEuGcIBS8VARdrnI3Le8D6WnZGfFevAidm9bD5JoZ21
         rIUkEwlxNGXjTQbhUSHW5Bt5VHhKWTS7HBwkkPb8eYU6vpHZDdxAwBVt87+RXPKdv025
         Hr4ahEx0Yt79wKsrdOS2Tr8L69bESGvA0OAY7DRnsLgbjy9bG6QjzX1PgZM/dXvpVlKl
         sxpA==
X-Forwarded-Encrypted: i=1; AJvYcCUpS+KMJdJLZibue/rreowB1VXYzyhb0G1kNBkauBkSW4T1ZGoUeZbTp86jCqF7e5bs7vcqMHuwLnkeSkECwg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8baU6PAZ8088OTelIK6FS2dtkg133fTMiaBScwhGFQ/5UHHhk
	XBidLYqLGXriUsMTFthq2Ccs/Na994O167kbtZzfpeLL1PhRF6VIaQMX
X-Gm-Gg: AY/fxX7j4xLWFE9LArCyl7kT1Qn6Yl7YyKTkyCsdRMKkCUqDMBJqj41vbuh1wu8oCAi
	f+x2FGWuPaB6l5sych0rkIkKgDfXVpXqH/IBHjqQCih7Nd2GoBSFJ56tU/Nr/TfqBrjDwfA0GQ+
	ze3eGID7tAh10dB9JBdPXQerD1W4rYN2pGZn4e6kDPXolnQ28PYOC4yA+g+cFIamFa1u3Bztb1v
	WkO+xU0aXHr+WmhpWq/+muu7bJ1lA5KJLBd2YMcv5Dk2X+1KoTwohi348hbRGTuQqxbiMFCbvf6
	Rj3sKNFLCI3KQABRmYxNOXMkJ3lZFYV2GXm5gBxYXtQOGEKNlGncCMIeN+tlxJLQZ1U/CQYPtOu
	oaOu5RhxPjLslpkMi79o4MfishByc5ffbo75VVjJ18dhk5kcQd30kHVixCqC5zTTO6/PuwUB8Mj
	7QmNiQSWNMckSVv5D3u4BbT/qYZV4/Gt3N1pmXfkfMbtQDFisp/KF7g2MVeKYQv8ZYOOIGWNOsW
	p0iq2OzU/Mffs3XQS1p3lgnmikiUhcFJIMVBTzlz4bEI4/cPP+qEPK/ufZLae7hxvYveR02gfEM
	kDU=
X-Google-Smtp-Source: AGHT+IFntC97OMoIKW8iak4Csi+Sa/wJHZS2qz46SkDovenEuEnw3BILL/ha2LHm12T/rhrLMeYBbA==
X-Received: by 2002:a05:7022:6988:b0:119:e56b:91ed with SMTP id a92af1059eb24-121722e01c2mr4354548c88.30.1766179731046;
        Fri, 19 Dec 2025 13:28:51 -0800 (PST)
Received: from ?IPV6:2a00:79e0:2e7c:8:5874:79f3:80da:a7a3? ([2a00:79e0:2e7c:8:5874:79f3:80da:a7a3])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1217254cd77sm12305503c88.14.2025.12.19.13.28.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Dec 2025 13:28:50 -0800 (PST)
Message-ID: <ecb35204-ea13-488b-8d60-e21d4812902a@gmail.com>
Date: Fri, 19 Dec 2025 14:28:48 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 07/36] lockdep: Annotate lockdep assertions for context
 analysis
To: Marco Elver <elver@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Boqun Feng <boqun.feng@gmail.com>,
 Ingo Molnar <mingo@kernel.org>, Will Deacon <will@kernel.org>,
 "David S. Miller" <davem@davemloft.net>,
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
 <20251219154418.3592607-8-elver@google.com>
 <cdde6c60-7f6f-4715-a249-5aab39438b57@acm.org>
 <CANpmjNPJXVtZgT96PP--eNAkHNOvw1MrYzWt5f2aA0LUeK8iGA@mail.gmail.com>
Content-Language: en-US
From: Bart Van Assche <bart.vanassche@gmail.com>
In-Reply-To: <CANpmjNPJXVtZgT96PP--eNAkHNOvw1MrYzWt5f2aA0LUeK8iGA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/19/25 2:16 PM, Marco Elver wrote:
> It's basically an escape hatch to defer to dynamic analysis where the
> limits of the static analysis are reached.

That's not how lockdep_assert_held() is used in the kernel. This macro
is more often than not used to document assumptions that can be verified
at compile time.

This patch seems like a step in the wrong direction to me because it
*suppresses* compile time analysis compile-time analysis is useful. I
think that this patch either should be dropped or that the __assume()
annotations should be changed into __must_hold() annotations.

Bart.

