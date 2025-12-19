Return-Path: <linux-wireless+bounces-30006-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B8F90CD2309
	for <lists+linux-wireless@lfdr.de>; Sat, 20 Dec 2025 00:36:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8D8BF3020C59
	for <lists+linux-wireless@lfdr.de>; Fri, 19 Dec 2025 23:36:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F38E62264A3;
	Fri, 19 Dec 2025 23:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MAEmQnhw"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pg1-f194.google.com (mail-pg1-f194.google.com [209.85.215.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF0D53A1E64
	for <linux-wireless@vger.kernel.org>; Fri, 19 Dec 2025 23:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766187390; cv=none; b=SljM7osQpOeWajxbCP1V2ll6RS88srI1Vfz4oClP6bL5mqkQNQZLfIMbxEim3+OjM1n2ZN9WK7PCKSkDSXzbHkZOST/q/0L4MC8zvfq+GFqItrHYx+WHwBTbNJOMZzQbCWfTMEso8Tq307KF7/Uumo15NdtrkN/T07kewiSYjns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766187390; c=relaxed/simple;
	bh=kqYAQZ609rJygFWC7CbHOEHNatKsPADzGjHUdHPU3XE=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=tgeQOkMx+SRFqw3CzphipH7gXH56mvTqenhSxeCzeXMyIVyf0/u2dApRmXcEqXudqWZnoaB6DNuwI0LpqRcCHlSMyJD9Nr4QVHg3VC5LL4120qWN+A+tOz/CsCvlJ5iXqrL7GgdRoMxJCFktsnbvjaAbH+IpIEaau/4+38rYdo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MAEmQnhw; arc=none smtp.client-ip=209.85.215.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f194.google.com with SMTP id 41be03b00d2f7-c227206e6dcso180206a12.2
        for <linux-wireless@vger.kernel.org>; Fri, 19 Dec 2025 15:36:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766187388; x=1766792188; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Xjhz9NvSIj1nkwStS3EsBbpnWvjG3hzX9yFNjSmaNpQ=;
        b=MAEmQnhw6tNT8U4BN8xq4GrS6F2zDYa0yeooJEXn92taX5IAQu7Js/0K/0NFwakYu9
         5G+tLgmtZi3S3pjboBy0aRVrgekHWtMvR4bNnNV/8ydo7wEfApy4Dd/KXMPRVV4adKBC
         5sUAt2mGWSBSnhM0tD/pnMK8Gw3YdfZhKPW1TW1RZ0vF9Vtg+0WIE/ELArjoxpW1SALI
         qFdLDo7SBybfGa5Yoh5TZzkrf1KNCTvoKvBwm6eZwyGjVSNxHqcT80h+OWTaXjmTkyt+
         0Cd1UE8lxcBWJ6H8DHvm+QRPCMy/mNh6imUFYEvBcdkMy7SzAFiRBA14z8cidUpIB6V6
         aVsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766187388; x=1766792188;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Xjhz9NvSIj1nkwStS3EsBbpnWvjG3hzX9yFNjSmaNpQ=;
        b=XpS4LJryBaNXe+xdQBNpvP19eyzbpuPWMDP2F8DSm+0F8bgpy5WWNFEwWgiats2qi9
         sfZbZgnM4SfcphDJi3aHfmvK/X4PUheCVZbBVO5YvMQK+5SxwYqGeZgGtbx7OGpUagIJ
         nVDkVSImykw2Rhh/KXrOK+U4T4IJZkvbV3k420cszBpA5ZO+2/b3ExmRj/88Tk1H4ji3
         0GtQg2TExyqzz3SjMtB+UoAj97gKZPMBh5J4IUgoYO/LXDhigx6lsWpe9gtrHdAInZFa
         BCyofJ6vY7kGz1gXRJIqtUVymocxgMmBViue0PVn2d1giq3snHfplr6ndE2LaihVvXfX
         h7rg==
X-Forwarded-Encrypted: i=1; AJvYcCXKmU1lfK7CPmuxF2FrjOVu9dZ1BkC3iERgUmBZVBqasvvyyS3njDkIjSyH/c0GghwaIfxDokNM7DGsNY5bGg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/qKKwyNTWA7I/ZFo/pyy+3NiX9ufzr0k8goj3qJztmQNBc7z+
	XZMQlX0EavocRbVilJLzj86i/OYHtbNTS3JW4zdSP0qSs0Fv9toTp16Jp116RVEnRlQ=
X-Gm-Gg: AY/fxX65k2/xeu5KPItQMLVMbNV86U0/6Qd/+VhT+U/tGkGwCDg7djprFf6Z19JUm09
	8vGb7NBmhxwu9HCUtQccDSzGrVXx+SH1ceHDyLFCNsdMRMRnziXCBTf2pHmcbnhBDkWnpQebmX4
	zCNiLMMXQeooEBlCoRXvQTwHISFKOpdIf4H1jAkeYR8qdoALaZFh76XpsTR2OsOTPayhEGFns7x
	cQsBdbymf8YPt7QqUSxekkSiWlC9WsPe45/UWSEpEuC3EIDnekaSVYgeRtobSYzNaxnRYzBRng/
	n3WlpU09SVF+gd2E73HaPh0x6vI9XH8PXQ4zjgZ25kSbwGbwTg2mpV8IHpDMeNgAOoeAJLYfO5c
	t2/haadUyCYxznWVgzhVrM4ChikVPz5bBtZ1m69U7tWysgdkoVfb3gEho26Xozs/dPswhozF4NJ
	RcDWMIZtxzmBfwuKykttvMF8sYfA+zDBd+J5akZjvJpeARvRFRJhiSXQAVdwW9uOr8t/F+CxojV
	o7TRt2CjmnrhQCusf57YTARfZd1otQhyjCHRQPeq9qPpOQW51HTJwIdVwoJsB1DnWnAuZQkUt59
	5B0=
X-Google-Smtp-Source: AGHT+IFD9VEfhTkWGAUJ+KrkgUpiheofAxrSZVwNtEffu0+8gx+hrdlGu9tKXSDKwQO+mDr4xt9mXg==
X-Received: by 2002:a05:7022:3a83:b0:11c:b397:2657 with SMTP id a92af1059eb24-121722be81emr4954809c88.22.1766180747284;
        Fri, 19 Dec 2025 13:45:47 -0800 (PST)
Received: from ?IPV6:2a00:79e0:2e7c:8:5874:79f3:80da:a7a3? ([2a00:79e0:2e7c:8:5874:79f3:80da:a7a3])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b05fe99410sm10260116eec.2.2025.12.19.13.45.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Dec 2025 13:45:46 -0800 (PST)
Message-ID: <ae957ee5-cb47-433f-b0b3-f4ac8ec7116b@gmail.com>
Date: Fri, 19 Dec 2025 14:45:45 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Bart Van Assche <bart.vanassche@gmail.com>
Subject: Re: [PATCH v5 08/36] locking/rwlock, spinlock: Support Clang's
 context analysis
To: Peter Zijlstra <peterz@infradead.org>, Marco Elver <elver@google.com>
Cc: Boqun Feng <boqun.feng@gmail.com>, Ingo Molnar <mingo@kernel.org>,
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
 <20251219154418.3592607-9-elver@google.com>
 <17723ae6-9611-4731-905c-60dab9fb7102@acm.org>
 <CANpmjNO0B_BBse12kAobCRBK0D2pKkSu7pKa5LQAbdzBZa2xcw@mail.gmail.com>
Content-Language: en-US
In-Reply-To: <CANpmjNO0B_BBse12kAobCRBK0D2pKkSu7pKa5LQAbdzBZa2xcw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/19/25 1:02 PM, Marco Elver wrote:
> On Fri, 19 Dec 2025 at 21:26, Bart Van Assche <bvanassche@acm.org> wrote:
>> On 12/19/25 7:39 AM, Marco Elver wrote:
>>> - extern void do_raw_read_lock(rwlock_t *lock) __acquires(lock);
>>> + extern void do_raw_read_lock(rwlock_t *lock) __acquires_shared(lock);
>>
>> Given the "one change per patch" rule, shouldn't the annotation fixes
>> for rwlock operations be moved into a separate patch?
>>
>>> -typedef struct {
>>> +context_lock_struct(rwlock) {
>>>        arch_rwlock_t raw_lock;
>>>    #ifdef CONFIG_DEBUG_SPINLOCK
>>>        unsigned int magic, owner_cpu;
>>> @@ -31,7 +31,8 @@ typedef struct {
>>>    #ifdef CONFIG_DEBUG_LOCK_ALLOC
>>>        struct lockdep_map dep_map;
>>>    #endif
>>> -} rwlock_t;
>>> +};
>>> +typedef struct rwlock rwlock_t;
>>
>> This change introduces a new globally visible "struct rwlock". Although
>> I haven't found any existing "struct rwlock" definitions, maybe it's a
>> good idea to use a more unique name instead.
> 
> This doesn't actually introduce a new globally visible "struct
> rwlock", it's already the case before.
> An inlined struct definition in a typedef is available by its struct
> name, so this is not introducing a new name
> (https://godbolt.org/z/Y1jf66e1M).

Please take another look. The godbolt example follows the pattern
"typedef struct name { ... } name_t;". The "name" part is missing from
the rwlock_t definition. This is why I wrote that the above code
introduces a new global struct name.

Bart.

