Return-Path: <linux-wireless+bounces-26456-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CA4AB2C09F
	for <lists+linux-wireless@lfdr.de>; Tue, 19 Aug 2025 13:37:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE9963AA73E
	for <lists+linux-wireless@lfdr.de>; Tue, 19 Aug 2025 11:33:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABFFF32A3F8;
	Tue, 19 Aug 2025 11:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H89LUWFp"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 873C830F813
	for <linux-wireless@vger.kernel.org>; Tue, 19 Aug 2025 11:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755603195; cv=none; b=hTlnXXUaNqbpIHyHuFEqjIMt6aNUTfqhb295rA12ShMuts9vWZaEsCtaz/7MtfZf6b+FDc8mGrqbEZobHwVZRXo89gQnu/YVIxK6YvSDzOlgeeFKCX//mkgZFdnVx43QxDhveDNcz81Yy+/dJ5z21EqTTIK46pEp2k+kfXYDHEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755603195; c=relaxed/simple;
	bh=XRdiDp/3C0n00gqHXJYBUqxKKp5lQRyRbHM02ZD53sA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=n9RsbGUnbrvfqtFx/GYj3BVFm2g0YvdXemiNSVzFKUIwaUEza/WZXUgfRhCL4I8kB3+7mKjKXaWI9z7AmRH6GoEP3WPkZczpSNg+3uYWHaNXJ3ONwpWOO9TKsngXg41Tc+lTrtQagNs2ttidWJqeDGNZnjVpJZDLzPizMIIprGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H89LUWFp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FF98C116D0
	for <linux-wireless@vger.kernel.org>; Tue, 19 Aug 2025 11:33:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755603195;
	bh=XRdiDp/3C0n00gqHXJYBUqxKKp5lQRyRbHM02ZD53sA=;
	h=References:In-Reply-To:From:Date:Subject:To:List-Id:Cc:From;
	b=H89LUWFp4fbgt8wioVEz2IoHbsI+YiGjNJWRZ98Psh9svEjVU5AczwYw7VQUT1PDw
	 JvYk+RsQDNQcM3GUIkLYjZ5TAAcGiAL1EndM8K5G7wQRTLkkJjV+00h6Ech4fG5d5L
	 T74OxMjno0/kOgguXUqtvmj7Hk83sCqKffCRCHnO4xjvCzw41dKlIf7ptoamLkpJ1J
	 IyZRHjb/Grjmqw0d7snlvmLQvhBO2f46Hlz3SMSVtKBy5avTTIelIVPPvnD5lO02hd
	 R8AhiXDZfSjFyz1liS+OIwd4QHtPHNt8bezJ9C1LTBUtzl3leBRSXqnsFMwkK6teUW
	 1+7F9U8OS4oiw==
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-e934bcb7623so1779129276.1
        for <linux-wireless@vger.kernel.org>; Tue, 19 Aug 2025 04:33:15 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU+Kg8+71dTsZaURWVW5Q89nIZ0qczagEeJx2w7OaGrTBbfZNM2bC7nwn6jD9MRm9IrgDCDiTF8nxDNV8y/5Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YxNDMUquVmzPeCVlomZ/NNfsR3Ec6AsLO1zOJp4IPzHj/lZKTfj
	i4y3iqHH5xkhNhPEeeC48kEVSV5UaCu89ozazC3Wmx+HJJbGVL/jtUl/prHWz6vGoxlqJ4BmLdM
	Z90D3v+LlJB7cc13WUOtXwmfd2h3V36A=
X-Google-Smtp-Source: AGHT+IGJwzigz0HEH/8/52Cc3yFuoANIfJNsSnK9dRTnS2+oDBTgiyjDWl34taeCBgPpXJL31H+pObxyhks2FGDMMxw=
X-Received: by 2002:a05:6902:c0a:b0:e94:d4ff:e8c0 with SMTP id
 3f1490d57ef6-e94e6343ad4mr2280668276.46.1755603194309; Tue, 19 Aug 2025
 04:33:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <DM3PPF63A6024A98DDD1D55C6EECDDE41B2A331A@DM3PPF63A6024A9.namprd11.prod.outlook.com>
In-Reply-To: <DM3PPF63A6024A98DDD1D55C6EECDDE41B2A331A@DM3PPF63A6024A9.namprd11.prod.outlook.com>
From: Josh Boyer <jwboyer@kernel.org>
Date: Tue, 19 Aug 2025 07:33:03 -0400
X-Gmail-Original-Message-ID: <CA+5PVA5fuDwVA0LVKKGaeyt_g-WcJS5VEEJheLJstV-cPE4fqA@mail.gmail.com>
X-Gm-Features: Ac12FXzGxUGVWSOuvLMyKSxg_jkIXVUp05lKotMoDR27FAuWyBofilQJJQXEAag
Message-ID: <CA+5PVA5fuDwVA0LVKKGaeyt_g-WcJS5VEEJheLJstV-cPE4fqA@mail.gmail.com>
Subject: Re: pull request: iwlwifi firmware updates 2025-08-18
To: "Korenblit, Miriam Rachel" <miriam.rachel.korenblit@intel.com>
Cc: "linux-firmware@kernel.org" <linux-firmware@kernel.org>, Josh Boyer <jwboyer@kernel.org>, 
	Linux Wireless <linux-wireless@vger.kernel.org>, "Dreyfuss, Haim" <haim.dreyfuss@intel.com>, 
	"kyle@infradead.org" <kyle@infradead.org>, "Hutchings, Ben" <ben@decadent.org.uk>, 
	"Yang, You-Sheng" <vicamo.yang@canonical.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Merged and pushed out.

https://gitlab.com/kernel-firmware/linux-firmware/-/merge_requests/650

josh

On Mon, Aug 18, 2025 at 4:19=E2=80=AFPM Korenblit, Miriam Rachel
<miriam.rachel.korenblit@intel.com> wrote:
>
> Hi,
>
> This contains some new and updated firmwares for all our currently mainta=
ined FW binaries.
>
> Please pull or let me know if there are any issues.
>
> Thanks,
> Miri
> ---
>
> The following changes since commit 07ed893df57c8b1fb30e497d617548254bbf11=
23:
>
>   Merge branch 'amd-staging' into 'main' (2025-08-15 20:59:11 +0000)
>
> are available in the Git repository at:
>
>   http://git.kernel.org/pub/scm/linux/kernel/git/iwlwifi/linux-firmware.g=
it tags/iwlwifi-fw-2025-08-18
>
> for you to fetch changes up to b5b78dda06f9a62955abfaac54515b6039a681d3:
>
>   iwlwifi: add Bz/gl FW for core97-84 release (2025-08-18 23:11:14 +0300)
>
> ----------------------------------------------------------------
> core97
>
> ----------------------------------------------------------------
> Miri Korenblit (3):
>       iwlwifi: update cc/Qu/QuZ firmwares for core97-84 release
>       iwlwifi: update ty/So/Ma firmwares for core97-84 release
>       iwlwifi: add Bz/gl FW for core97-84 release
>
>  WHENCE                        |  40 ++++++++++++++++++++++++++----------=
----
>  iwlwifi-Qu-b0-hr-b0-77.ucode  | Bin 1406184 -> 1406572 bytes
>  iwlwifi-Qu-b0-jf-b0-77.ucode  | Bin 1322896 -> 1323292 bytes
>  iwlwifi-Qu-c0-hr-b0-77.ucode  | Bin 1406200 -> 1406588 bytes
>  iwlwifi-Qu-c0-jf-b0-77.ucode  | Bin 1322912 -> 1323308 bytes
>  iwlwifi-QuZ-a0-hr-b0-77.ucode | Bin 1406320 -> 1406716 bytes
>  iwlwifi-QuZ-a0-jf-b0-77.ucode | Bin 1322988 -> 1323376 bytes
>  iwlwifi-bz-b0-fm-c0-100.ucode | Bin 0 -> 2225948 bytes
>  iwlwifi-bz-b0-gf-a0-100.ucode | Bin 0 -> 1837024 bytes
>  iwlwifi-bz-b0-hr-b0-100.ucode | Bin 0 -> 1584684 bytes
>  iwlwifi-cc-a0-77.ucode        | Bin 1367700 -> 1368096 bytes
>  iwlwifi-gl-c0-fm-c0-100.ucode | Bin 0 -> 2210748 bytes
>  iwlwifi-ma-b0-gf-a0-89.ucode  | Bin 1751700 -> 1752072 bytes
>  iwlwifi-ma-b0-gf-a0.pnvm      | Bin 55128 -> 55128 bytes
>  iwlwifi-ma-b0-gf4-a0-89.ucode | Bin 1599948 -> 1600024 bytes
>  iwlwifi-ma-b0-gf4-a0.pnvm     | Bin 27836 -> 27836 bytes
>  iwlwifi-ma-b0-hr-b0-89.ucode  | Bin 1539656 -> 1539788 bytes
>  iwlwifi-so-a0-gf-a0-89.ucode  | Bin 1736028 -> 1736108 bytes
>  iwlwifi-so-a0-gf-a0.pnvm      | Bin 55208 -> 55208 bytes
>  iwlwifi-so-a0-gf4-a0-89.ucode | Bin 1590540 -> 1590688 bytes
>  iwlwifi-so-a0-gf4-a0.pnvm     | Bin 27876 -> 27876 bytes
>  iwlwifi-so-a0-hr-b0-89.ucode  | Bin 1526824 -> 1522860 bytes
>  iwlwifi-ty-a0-gf-a0-89.ucode  | Bin 1677896 -> 1677976 bytes
>  iwlwifi-ty-a0-gf-a0.pnvm      | Bin 55052 -> 55052 bytes
>  24 files changed, 26 insertions(+), 14 deletions(-)
>  create mode 100644 iwlwifi-bz-b0-fm-c0-100.ucode
>  create mode 100644 iwlwifi-bz-b0-gf-a0-100.ucode
>  create mode 100644 iwlwifi-bz-b0-hr-b0-100.ucode
>  create mode 100644 iwlwifi-gl-c0-fm-c0-100.ucode

