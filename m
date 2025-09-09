Return-Path: <linux-wireless+bounces-27144-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 424C4B4A43D
	for <lists+linux-wireless@lfdr.de>; Tue,  9 Sep 2025 09:53:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EF65F1886A73
	for <lists+linux-wireless@lfdr.de>; Tue,  9 Sep 2025 07:53:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E5A323ED75;
	Tue,  9 Sep 2025 07:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xZhGnT81"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A86E623C4F3
	for <linux-wireless@vger.kernel.org>; Tue,  9 Sep 2025 07:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757404377; cv=none; b=fvD71ez4L4GrU61sD1dy2xeHLOQisQkBvCuXjdaaQ3BkxqBvjnqUhNgwky63Jn4hbpkE9rrvrCsj/2MTHdtZQ638hrr2C01mw45WsSWYT+bKbij74kvMihOMVvU057aGSFEs5xIuPnSCAMFIca6Dc8SzXV+B8bxyvDNj+jJyrEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757404377; c=relaxed/simple;
	bh=inPUrZMsfA2VY/R1OZIP0EMwvOmiWnfNcCAy3+3kvw0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=L3Jq2dFj4WhkdbftHovaXoSgVn+Os3i8MJAfjc0lkpLS2062K5IawzexPnvtkh8StH3Sn8cpB309ntPARoZNMdZ93OQid1CWJ5zMYStK1FrpK7WZ5UjItsX8qyizb537lduzAMl1njDlboE+0qoi9nGzDntoMyHv9iYJAtmclGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=xZhGnT81; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-24457f581aeso47996925ad.0
        for <linux-wireless@vger.kernel.org>; Tue, 09 Sep 2025 00:52:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1757404375; x=1758009175; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MMOBMpJlH1unyBv3NyBv5FS3WF4ll7Y30j2iPvk3MmY=;
        b=xZhGnT81gRho+ch111bsRWXyfdkyXY89aVz9ek+5u9Ah3AkIdx4p08pHJVuc4T/is9
         vyh9/Y0D/eQ9wdkkNbH1MVBmkqlLUriV3tURE076a7MA1QgH4hpUQuWX4XPirBrcI6ON
         uwKwH/qgH6SQEusfePwePT7W5N5spe3Nx2hXd1RLjGjWfla4jT5eGPu0uU4VrnZfYjTV
         9xbE8fF9mm7vo6pDDElTAquWFt+867VcY8BUGtFKBnQUPnPizgmMPaiiLwWY9jwB9q3j
         0nivVqzjo2BKetROVjMib8U82oZOtJXndKhAb7rh4NPUVhBFh22qctrvE7w4MxrPJrK1
         W67Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757404375; x=1758009175;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MMOBMpJlH1unyBv3NyBv5FS3WF4ll7Y30j2iPvk3MmY=;
        b=CuMWSNFLU766Qr9PV/KT7xRJhMOY3D42/08RSttECgTMPX3wqex8roiiwh56Lp58Zh
         Ob74ma7Cf80/4vytEvxtGWpZIbENOd0EyNZCpBVYCOFLE0YFkPAznrEhESALF0uoaUlC
         FXOZlZYLkKgfwqSjQivYBRZkHgYlTyNejgkZegyrLomPZki/AYzCmPb6ctvHSvidgwrJ
         wnyfu2hSBTF4rjvvqXztVNCKNCnuRW/RSR91OW6Weci6eJ0z/pY7WGzcuCD9w3h9C0Z5
         6RVFT9JyO87117Fq4oFGxGz5vJH5eH1IjKmPw9gcD4KQR1UtIfMUif1tpZOajxRwCssO
         s2+A==
X-Forwarded-Encrypted: i=1; AJvYcCW6at70lRTiBXqpWMF3vwQr9YQLd1CreXlnhWpbw6vpvRpWdzjw/kIc6LJpthKPQDMWGoHL5FKZmxcDvJJsNg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzUH6YgeB5FJME4XOMftHZruKLk9okDWUW5tXuolWPjbZj8uHZy
	3+D/z1opZ/kZgYJIUYlZ0NdvNvtd52j/jPyZSHeWK8r1UdiafLosVu2ex58IclL/Z1z0bpMdBsN
	Y6sBcTL8Em6WCWPiAWcdm4987PeYiulsHhY9JgJH85g==
X-Gm-Gg: ASbGncuxhmVx8It9AOzGUVHI4UF/j9KXDXBgRJ2LGRPL8CnKQfRJ+fW1B1u9kDuRxCP
	aG6lloYfMynTTt+pTpsfu4sA/x5N+jRwPn2Crsk+UknNSTGntyq/MUfJCLkPV4twQzAgQARSQjm
	EJJC8tf1x9I+c3o6n7IYW2sWoYZR/vvvHfOsUgIbYED7iRWQnUynXDG/NXZ+jImCOTHpM0TDqgT
	Kwt/w9kMTq/ko98isnxu4bF/JWPETIyx2pz+HImG/8HH6G1xCBkySNaVye/80+HGqx3EBo=
X-Google-Smtp-Source: AGHT+IHKMwwuJuV9mWv+A5szEpOumIuvlZcVWUqldPFr6JIn3jDsrrgM3BJF5KeyNQI945RkqqnfgQuc2lOpuPGqW0g=
X-Received: by 2002:a17:902:d2c7:b0:24c:e6a6:9e50 with SMTP id
 d9443c01a7336-25174a2e860mr141006125ad.45.1757404373705; Tue, 09 Sep 2025
 00:52:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250907195600.953058118@linuxfoundation.org>
In-Reply-To: <20250907195600.953058118@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Tue, 9 Sep 2025 13:22:42 +0530
X-Gm-Features: AS18NWB51GMfdNxH5F_7y6R9Phs7xYbSJja9zt2vDLfRVbapihqj_C3CM63O-h0
Message-ID: <CA+G9fYt3xc6DmR+EYZD1cAiBSf0VxH6jqbdf0PK-8uGPivw8ew@mail.gmail.com>
Subject: Re: [PATCH 5.4 00/45] 5.4.299-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, 
	broonie@kernel.org, achill@achill.org, Netdev <netdev@vger.kernel.org>, 
	linux-wireless@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 8 Sept 2025 at 01:40, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 5.4.299 release.
> There are 45 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Tue, 09 Sep 2025 19:55:53 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-=
5.4.299-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-5.4.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h


Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm, x86_64, and i386.

Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>

NOTE:
Following list of new build warnings noticed on arm build with gcc-12 and c=
lang.

drivers/net/wireless/marvell/libertas/cfg.c: In function 'lbs_associate':
include/linux/kernel.h:843:43: warning: comparison of distinct pointer
types lacks a cast
  843 |                 (!!(sizeof((typeof(x) *)1 =3D=3D (typeof(y) *)1)))
      |                                           ^~

drivers/net/wireless/st/cw1200/sta.c:1292:20: warning: comparison of
distinct pointer types ('typeof (ssidie[1]) *' (aka 'const unsigned
char *') and 'typeof (32) *' (aka 'int *'))
[-Wcompare-distinct-pointer-types]
 1292 |                         join.ssid_len =3D min(ssidie[1],
IEEE80211_MAX_SSID_LEN);
      |
^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

drivers/net/wireless/marvell/libertas/cfg.c:1106:18: warning:
comparison of distinct pointer types ('typeof (ssid_eid[1]) *' (aka
'const unsigned char *') and 'typeof (32) *' (aka 'int *'))
[-Wcompare-distinct-pointer-types]
 1106 |                 u32 ssid_len =3D min(ssid_eid[1], IEEE80211_MAX_SSI=
D_LEN);
      |                                ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~=
~~~~

## Build
* kernel: 5.4.299-rc1
* git: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-=
rc.git
* git commit: f858bf5484295b4f9ee720b49c5348ce54eceae3
* git describe: v5.4.297-70-gf858bf548429
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-5.4.y/build/v5.4.2=
97-70-gf858bf548429

## Test Regressions (compared to v5.4.297-24-g79c1b3cebd7a)

## Metric Regressions (compared to v5.4.297-24-g79c1b3cebd7a)

## Test Fixes (compared to v5.4.297-24-g79c1b3cebd7a)

## Metric Fixes (compared to v5.4.297-24-g79c1b3cebd7a)

## Test result summary
total: 39701, pass: 30356, fail: 2171, skip: 7026, xfail: 148

## Build Summary
* arc: 5 total, 5 passed, 0 failed
* arm: 131 total, 131 passed, 0 failed
* arm64: 31 total, 29 passed, 2 failed
* i386: 18 total, 13 passed, 5 failed
* mips: 25 total, 25 passed, 0 failed
* parisc: 3 total, 0 passed, 3 failed
* powerpc: 26 total, 26 passed, 0 failed
* riscv: 9 total, 3 passed, 6 failed
* s390: 6 total, 6 passed, 0 failed
* sh: 10 total, 10 passed, 0 failed
* sparc: 6 total, 6 passed, 0 failed
* x86_64: 27 total, 27 passed, 0 failed

## Test suites summary
* boot
* kselftest-arm64
* kselftest-breakpoints
* kselftest-capabilities
* kselftest-clone3
* kselftest-core
* kselftest-cpu-hotplug
* kselftest-exec
* kselftest-fpu
* kselftest-futex
* kselftest-intel_pstate
* kselftest-kcmp
* kselftest-membarrier
* kselftest-mincore
* kselftest-mqueue
* kselftest-openat2
* kselftest-ptrace
* kselftest-rseq
* kselftest-rtc
* kselftest-sigaltstack
* kselftest-size
* kselftest-timers
* kselftest-tmpfs
* kselftest-tpm2
* kselftest-user_events
* kselftest-vDSO
* kselftest-x86
* kunit
* lava
* libhugetlbfs
* log-parser-boot
* log-parser-build-clang
* log-parser-build-gcc
* log-parser-test
* ltp-capability
* ltp-commands
* ltp-containers
* ltp-controllers
* ltp-crypto
* ltp-cve
* ltp-dio
* ltp-fcntl-locktests
* ltp-fs
* ltp-fs_bind
* ltp-fs_perms_simple
* ltp-hugetlb
* ltp-math
* ltp-mm
* ltp-nptl
* ltp-pty
* ltp-sched
* ltp-smoke
* ltp-syscalls
* ltp-tracing
* perf
* rcutorture

--
Linaro LKFT
https://lkft.linaro.org

