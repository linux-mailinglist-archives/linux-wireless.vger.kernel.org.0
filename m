Return-Path: <linux-wireless+bounces-21966-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5279FA9AB3E
	for <lists+linux-wireless@lfdr.de>; Thu, 24 Apr 2025 12:59:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 717781943F4D
	for <lists+linux-wireless@lfdr.de>; Thu, 24 Apr 2025 10:59:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1AC9221285;
	Thu, 24 Apr 2025 10:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YrsPz20Z"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDA577DA6D
	for <linux-wireless@vger.kernel.org>; Thu, 24 Apr 2025 10:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745492356; cv=none; b=s6NzGswx2UgbrHxqtlixBRMFJKdhkoBjesQTYe8aePk1P3juUGfVmqSxudnk7sUQNio0dbVsFbQqRS2c/v6r1GqxdF9kxngikSuMFRCrgGX5AOky/7GywPwFq78Uq/MFqMm0gZAK2eFvp5IcN89rYJUCYGZZqRYXydhHGtPume4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745492356; c=relaxed/simple;
	bh=APV/Agu7tbmBhr49+pjMXQ6wnUMMbqXEHoZSZ3c1ebI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=X5vW1QvyeZzh/IWmXlPv7/FuYIuZf6uq85/Mx3z9OlVIloRP2v6RVdpvuhkEAPN+plDGkkEnKcRhqtSpQeB61QUOipt0gmLTd/1UBu1ZxNUOGHdL4EhIekZs4cParZ2/rYtFpk2c5eTUYazFJIIv3fsXvxMIsJH3KXwo+eDrhzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YrsPz20Z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C8F1C4CEE4
	for <linux-wireless@vger.kernel.org>; Thu, 24 Apr 2025 10:59:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745492356;
	bh=APV/Agu7tbmBhr49+pjMXQ6wnUMMbqXEHoZSZ3c1ebI=;
	h=References:In-Reply-To:From:Date:Subject:To:List-Id:Cc:From;
	b=YrsPz20Zqj14qtlvr9CEY5XNsI6PFvO7L+MoZieEVj2DS/EfV1RKwV8BRaqEZr+fq
	 WEdPYpOnUcaJjchCFH2eOEqQJyhWiFW2Nyj7kkt1/48kJH/tbXnc8nEcZZ9rJSDAMk
	 kjTrP8u8wuRR+IELRcv42nOFAvZddVQaiC6RjuLu7BCxm0v+PjU0Rn4CrUyqJvWew0
	 Fu8jDZH9lwQS3BIUcHDRfePiL1SPLKCmcW3eRIvfkiwXLE9s/BtiHjjsxjbZLhlRk+
	 tP7lNTlvLbC15KKE+wvmDR12NqCOMum/k208e/7DrVD89wYV2YV118EbjRLj6bwtZ/
	 +sRM3YdtJF4wQ==
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-70576d2faa1so8651547b3.3
        for <linux-wireless@vger.kernel.org>; Thu, 24 Apr 2025 03:59:16 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXilLotXeKW7+mcH/GQIlnU44PTHewRn/rcfNs8IDk9dJ4/xGQzIgIeMvvFdSel+7vLBxjaE/MkZf/kPdxqgw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwrfqzxRAICS1gPCOx41zoPdvqK/tIlo5cO1C59shOteTf1R+91
	aUFDpY8tA01pLQwAIu8WHNjybKohVD8hvQkOIeSlW1WC/QffDyRd8z8yecHnYqxIrPVIvTLDWNM
	muteS/dJUawBB95LpP7otUcb4080=
X-Google-Smtp-Source: AGHT+IG99Q0hMzd0UoLGXR0Cq41m5dRYR6AQmD6eeiw1BQMLYr0a+cMubH2n/Tx7zZm8HOdEXLJw5ZdzE8VJyClJ618=
X-Received: by 2002:a05:690c:316:b0:6f9:af1f:fdd0 with SMTP id
 00721157ae682-7083eda609fmr31351247b3.31.1745492355465; Thu, 24 Apr 2025
 03:59:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <MW5PR11MB581000CDAA04235DBE96FD75A3BA2@MW5PR11MB5810.namprd11.prod.outlook.com>
In-Reply-To: <MW5PR11MB581000CDAA04235DBE96FD75A3BA2@MW5PR11MB5810.namprd11.prod.outlook.com>
From: Josh Boyer <jwboyer@kernel.org>
Date: Thu, 24 Apr 2025 06:59:03 -0400
X-Gmail-Original-Message-ID: <CA+5PVA6vTf0yKgoTYCZkazR0wg+6gMBs9=dEssiQVpM0P4aCZg@mail.gmail.com>
X-Gm-Features: ATxdqUG9QcwmKVCFx179mtjUjHOynz2ckQlFvcQ6RsdEpw3eIrjxtcIFsBxO2QM
Message-ID: <CA+5PVA6vTf0yKgoTYCZkazR0wg+6gMBs9=dEssiQVpM0P4aCZg@mail.gmail.com>
Subject: Re: pull request: iwlwifi firmware updates 2025-04-23
To: "Korenblit, Miriam Rachel" <miriam.rachel.korenblit@intel.com>
Cc: "linux-firmware@kernel.org" <linux-firmware@kernel.org>, "kyle@infradead.org" <kyle@infradead.org>, 
	"Hutchings, Ben" <ben@decadent.org.uk>, "Dreyfuss, Haim" <haim.dreyfuss@intel.com>, 
	"Yang, You-Sheng" <vicamo.yang@canonical.com>, Wireless <linux-wireless@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 23, 2025 at 4:52=E2=80=AFPM Korenblit, Miriam Rachel
<miriam.rachel.korenblit@intel.com> wrote:
>
> Hi,
>
>
>
> This contains some new and updated firmwares for all our currently
>
> maintained FW binaries.
>
>
>
> Please pull or let me know if there are any issues.
>
>
>
> --
>
> Thanks,
>
> Miri
>
>
>
> The following changes since commit 32f3227b67c0e70ffba1103cd6f0767fb7dc76=
fd:
>
>
>
>   Merge branch 'robot/pr-0-1745343662' into 'main' (2025-04-22 18:37:42 +=
0000)
>
>
>
> are available in the Git repository at:
>
>
>
>   http://git.kernel.org/pub/scm/linux/kernel/git/iwlwifi/linux-firmware.g=
it tags/iwlwifi-fw-2025-04-23

Merged and pushed out.

https://gitlab.com/kernel-firmware/linux-firmware/-/merge_requests/526

josh

>
>
>
> for you to fetch changes up to c1d4c8991f615ebf3545bb9335f98479e346fe30:
>
>
>
>   iwlwifi: add Bz/gl FW for core95-82 release (2025-04-23 23:24:40 +0300)
>
>
>
> ----------------------------------------------------------------
>
> release core95
>
>
>
> ----------------------------------------------------------------
>
> Miri Korenblit (3):
>
>       iwlwifi: update cc/Qu/QuZ firmwares for core95-82 release
>
>       iwlwifi: update ty/So/Ma firmwares for core95-82 release
>
>       iwlwifi: add Bz/gl FW for core95-82 release
>
>
>
>  WHENCE                        |  40 ++++++++++++++++++++++++++----------=
----
>
>  iwlwifi-Qu-b0-hr-b0-77.ucode  | Bin 1406184 -> 1406184 bytes
>
>  iwlwifi-Qu-b0-jf-b0-77.ucode  | Bin 1322896 -> 1322896 bytes
>
>  iwlwifi-Qu-c0-hr-b0-77.ucode  | Bin 1406200 -> 1406200 bytes
>
>  iwlwifi-Qu-c0-jf-b0-77.ucode  | Bin 1322912 -> 1322912 bytes
>
>  iwlwifi-QuZ-a0-hr-b0-77.ucode | Bin 1406320 -> 1406320 bytes
>
>  iwlwifi-QuZ-a0-jf-b0-77.ucode | Bin 1322988 -> 1322988 bytes
>
>  iwlwifi-bz-b0-fm-c0-98.ucode  | Bin 0 -> 1925092 bytes
>
>  iwlwifi-bz-b0-fm-c0.pnvm      | Bin 295356 -> 295356 bytes
>
>  iwlwifi-bz-b0-gf-a0-98.ucode  | Bin 0 -> 1772684 bytes
>
>  iwlwifi-bz-b0-gf-a0.pnvm      | Bin 55208 -> 55208 bytes
>
>  iwlwifi-bz-b0-hr-b0-98.ucode  | Bin 0 -> 1569048 bytes
>
>  iwlwifi-bz-b0-hr-b0.pnvm      | Bin 1788 -> 1788 bytes
>
>  iwlwifi-cc-a0-77.ucode        | Bin 1367700 -> 1367700 bytes
>
>  iwlwifi-gl-c0-fm-c0-98.ucode  | Bin 0 -> 1910432 bytes
>
>  iwlwifi-gl-c0-fm-c0.pnvm      | Bin 295036 -> 295036 bytes
>
>  iwlwifi-ma-b0-gf-a0-89.ucode  | Bin 1747512 -> 1747520 bytes
>
>  iwlwifi-ma-b0-gf-a0.pnvm      | Bin 55128 -> 55128 bytes
>
>  iwlwifi-ma-b0-gf4-a0-89.ucode | Bin 1599852 -> 1599864 bytes
>
>  iwlwifi-ma-b0-gf4-a0.pnvm     | Bin 27836 -> 27836 bytes
>
>  iwlwifi-ma-b0-hr-b0-89.ucode  | Bin 1539572 -> 1539572 bytes
>
>  iwlwifi-so-a0-gf-a0-89.ucode  | Bin 1735936 -> 1735944 bytes
>
>  iwlwifi-so-a0-gf-a0.pnvm      | Bin 55208 -> 55208 bytes
>
>  iwlwifi-so-a0-gf4-a0-89.ucode | Bin 1590444 -> 1590456 bytes
>
>  iwlwifi-so-a0-gf4-a0.pnvm     | Bin 27876 -> 27876 bytes
>
>  iwlwifi-so-a0-hr-b0-89.ucode  | Bin 1526740 -> 1526740 bytes
>
>  iwlwifi-ty-a0-gf-a0-89.ucode  | Bin 1677804 -> 1677812 bytes
>
>  iwlwifi-ty-a0-gf-a0.pnvm      | Bin 55052 -> 55052 bytes
>
>  28 files changed, 26 insertions(+), 14 deletions(-)
>
> create mode 100644 iwlwifi-bz-b0-fm-c0-98.ucode
>
> create mode 100644 iwlwifi-bz-b0-gf-a0-98.ucode
>
> create mode 100644 iwlwifi-bz-b0-hr-b0-98.ucode
>
> create mode 100644 iwlwifi-gl-c0-fm-c0-98.ucode

