Return-Path: <linux-wireless+bounces-30003-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5764DCD2072
	for <lists+linux-wireless@lfdr.de>; Fri, 19 Dec 2025 22:42:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D4CA53063407
	for <lists+linux-wireless@lfdr.de>; Fri, 19 Dec 2025 21:42:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BB9533ADB4;
	Fri, 19 Dec 2025 21:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AOj/rZpt"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pl1-f196.google.com (mail-pl1-f196.google.com [209.85.214.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00276241103
	for <linux-wireless@vger.kernel.org>; Fri, 19 Dec 2025 21:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766180564; cv=none; b=cg87Eg3XhqMEWcnQv5Quk4yB9IQCfDxFhD5xRSXvFA5LTe2fLLOdCvRzUhJXwGj+6TOQmBhEAyFBKpfhvzuqYfedQ0+U5e8/wfurX+Uurn3iVVDRnNs3kBNc+D63oMT1tnF0LLW5ulLBPzoq89XHxg8sTkQN634Cj0kkp5RKY/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766180564; c=relaxed/simple;
	bh=XXvUIRo6jJ9ogO2QQaUCxttK8WosB2XGObI8UYH72+M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GUNAoFtlfrOIlZUPTkkI6UD84TmnxvEzMci07dTsEJD1YpDXuTA8TRTxJKB7UqM3lGHHwMcu96ZZ8Rw8PDCVZZmhlUz0t0sYRWWF+Ta3v7jFsVpIDhVMr2hkq4ZspmDMY11b0XOakCizLGBCkEUZnCUkdnBdVfc/R+VzaPpDofE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AOj/rZpt; arc=none smtp.client-ip=209.85.214.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f196.google.com with SMTP id d9443c01a7336-2a0b4320665so33213775ad.1
        for <linux-wireless@vger.kernel.org>; Fri, 19 Dec 2025 13:42:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766180561; x=1766785361; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xhB1Fco/aAscGV7BUmHv+KRyMsa6iylEkhRycjuIJTw=;
        b=AOj/rZptNUFI/4UnRqR9fG5FQ29cGUrYlcJJx2lflJCke/Y/I28A5KMi4N1CfFrm3L
         ow86AIq0BJG9HpLBXdf0gflqQQC5t8cN2KiV3kkBODaly4qmcOX5yvk80RVXbtRifmoH
         9sjvd9xJZDmyRyDGilORjblWWQMJNU6Agw7WMpFLYUaBksDg/a+fjRiH+L1qrHNgzxee
         Jc50o4OHuJWtqRFIa+GTKNf7qG/gwNOG10jYe9HOjwMv4hpHQfmChvlC+4bxyS64Zx7D
         8j1dm92dY/SjzI8eCA0tkgzlHwdV1ZCIC92qmEFfsCZGLieEWuaYI8kDGDZ5baKWEVWa
         OFaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766180561; x=1766785361;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xhB1Fco/aAscGV7BUmHv+KRyMsa6iylEkhRycjuIJTw=;
        b=ayKqkinjdb65ASRb/uIa+k83S82H/a+0FFrWhmDEAqf4uAzWMNaJ+ziObC1yO/D6fc
         jnkHlZ9rCBImQA3QqtYq69TponWul2zxfj/phjuinbUuEVakBCFks0pKK/6KR5Acqq1e
         9nj5cPdqkn+3XGP1Q1mKgW+hSDcpBB1tBPrtmH5gmzF/qWFwY6eWTp9Tm+R6EtlOkAPS
         942W1zpHZZZNKTVFs/M5lzjdCL2HUqTHXGgBIwJ0nEY2AyZXescJ2qpX5Tda7a6QHhP7
         ZMABQDczUTSW6frUxT4zTXLkn4e8dAmwsi1d0KFfNLrSSJVcMwgRc5qzQcuzP5eu1hy3
         9tfg==
X-Forwarded-Encrypted: i=1; AJvYcCWUEcmVYh3pVzRX5SVh9hwFieT08gckAtBqhzRaWAiefTDevdZuxJbcoompA5bmc9UG9OOqD2GZ7uaBlkm4CA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0Lj1KWjmA3cRWNd0hqUiFSkPkT4yxCG0RC/c4HcWdd50SGrtm
	fZ8Ia1X0Hpfn3WgScIzZ+bBOj8pqS/N7Kvh88IAocfAi1pwnbGHX/qeK
X-Gm-Gg: AY/fxX4ZZAf0SxzQK7PJ1wc1oyn5cF6aUasra93gW3osseWMsNGvBYAefXrRdEoHOYl
	GvxB049cxRqDR3MyapkDCD3+sfkJCNH/Ynddj3/AdsD/dHLblswvxJ2wMqUj+W0o/yGxI2eXZc0
	CVCVeBzT5DVS9+v4vKwVEyP4hZ2uffHO8XKOP4KzbtjPndm3A26kpAtwRVNI16Fr34JsdGSs8V7
	qc/NARGE5wQyXlIS6MBhXkNhD+rz2jOXEuguka46it0pb5mSOI9vng2N4g6LoNuBHBaZ98+wyrt
	CKF0Hrk935yhnbyEU+5oO2uvuH5k6lFrhdnCmLOJxV6i3ULx1DyJN0HJBQ8GoVqHU89tSOMTOSk
	Y7JcC6T53W+Si5t4RQCv/V8TCRucShgus1WybhXOcL6BTrBzj4U8UNt2ivXyVArPjUbKmHyBiqz
	tiVGWX3mK2O3otrwg7FEOi9zsVQDxNqrYV8WJ2dxY3+JzDJoG5fFm0AM1Po25yDlE/L9plkQXEv
	lRb5ue5duCYbdUIN8yKf7bjZtbjDvfIMTT+p8EjMUBCbaGZwqpAjm0Qwsj6FRMUpbNA53bHb1Zc
	Pko=
X-Google-Smtp-Source: AGHT+IGTM6mjPPfNhqA9HPe48U2bDECheHzAzGuJpcTxojW/wC3VfdWLu4jNEE4Msq7vw7t+QoPUtw==
X-Received: by 2002:a05:7022:62a9:b0:11b:78e6:8323 with SMTP id a92af1059eb24-121722fd212mr4438541c88.37.1766180561251;
        Fri, 19 Dec 2025 13:42:41 -0800 (PST)
Received: from ?IPV6:2a00:79e0:2e7c:8:5874:79f3:80da:a7a3? ([2a00:79e0:2e7c:8:5874:79f3:80da:a7a3])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1217254c734sm11636083c88.13.2025.12.19.13.42.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Dec 2025 13:42:40 -0800 (PST)
Message-ID: <9af0d949-45f5-45cd-b49d-d45d53f5d8f6@gmail.com>
Date: Fri, 19 Dec 2025 14:42:38 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 24/36] compiler-context-analysis: Remove __cond_lock()
 function-like helper
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
 <20251219154418.3592607-25-elver@google.com>
Content-Language: en-US
From: Bart Van Assche <bart.vanassche@gmail.com>
In-Reply-To: <20251219154418.3592607-25-elver@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/19/25 8:40 AM, Marco Elver wrote:
>   Documentation/dev-tools/context-analysis.rst  |  2 -
>   Documentation/mm/process_addrs.rst            |  6 +-
>   .../net/wireless/intel/iwlwifi/iwl-trans.c    |  4 +-
>   .../net/wireless/intel/iwlwifi/iwl-trans.h    |  6 +-
>   .../intel/iwlwifi/pcie/gen1_2/internal.h      |  5 +-
>   .../intel/iwlwifi/pcie/gen1_2/trans.c         |  4 +-
>   include/linux/compiler-context-analysis.h     | 31 ----------
>   include/linux/lockref.h                       |  4 +-
>   include/linux/mm.h                            | 33 ++--------
>   include/linux/rwlock.h                        | 11 +---
>   include/linux/rwlock_api_smp.h                | 14 ++++-
>   include/linux/rwlock_rt.h                     | 21 ++++---
>   include/linux/sched/signal.h                  | 14 +----
>   include/linux/spinlock.h                      | 45 +++++---------
>   include/linux/spinlock_api_smp.h              | 20 ++++++
>   include/linux/spinlock_api_up.h               | 61 ++++++++++++++++---
>   include/linux/spinlock_rt.h                   | 26 ++++----
>   kernel/signal.c                               |  4 +-
>   kernel/time/posix-timers.c                    | 13 +---
>   lib/dec_and_lock.c                            |  8 +--
>   lib/lockref.c                                 |  1 -
>   mm/memory.c                                   |  4 +-
>   mm/pgtable-generic.c                          | 19 +++---
>   tools/include/linux/compiler_types.h          |  2 -

This patch should be split into one patch per subsystem or driver.
E.g. one patch for the iwlwifi driver, another patch for the mm
subsystem, one patch for the rwlock primitive, one patch for the
spinlock primitive, etc.

The tools/include/linux/compiler_types.h change probably should be
left out because it is user space code instead of kernel code and
the rest of the series applies to kernel code only.

Thanks,

Bart.

