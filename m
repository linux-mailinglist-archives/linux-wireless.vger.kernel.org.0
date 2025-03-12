Return-Path: <linux-wireless+bounces-20248-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CF581A5DD6E
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Mar 2025 14:09:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9B0611891A48
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Mar 2025 13:09:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E5CE243956;
	Wed, 12 Mar 2025 13:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nOq2APU+"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE464243951
	for <linux-wireless@vger.kernel.org>; Wed, 12 Mar 2025 13:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741784981; cv=none; b=pyvF6hWiqrL+N0jBqbblTmyoLo0LnB6k/N4CZviL7NE45UCqjjfOldaxxBjL5QhCYuYthpqmGbzPYHvVSA+T8VS998W30z4XtwrAp6g5z4JcGQp3uz4f2IMTkOYJ2MWnHvn7gCcq03iYyE3auZJHM8BWaSjWxwmaZZzz3b7J6/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741784981; c=relaxed/simple;
	bh=Y7a33bliUjdKsBEepv5e+YW1k8QHEMq8TH/uoO8fE4M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pucZR6lGpuijjuWPnk6TOS2DOtZTPuly+a9djttxbRa5O4E/rT+FF9ia4cKArLsrW45Ysgsb+1az8I/XoQ2h+dgBJxFklnEsL1Y9T1YAnBKvVwLv5dOb2zmaJJIupbKKzxUBRpp+PSXnN7pjDdQg0+I1rYG4lLTn+534FOmToe0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nOq2APU+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70191C4CEEF
	for <linux-wireless@vger.kernel.org>; Wed, 12 Mar 2025 13:09:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741784980;
	bh=Y7a33bliUjdKsBEepv5e+YW1k8QHEMq8TH/uoO8fE4M=;
	h=References:In-Reply-To:From:Date:Subject:To:List-Id:Cc:From;
	b=nOq2APU+4+ynDXH8PVHV878SOpWFtLVjSn0yzgNoyIfKTG6qHn9TIS+gPg1EASE+8
	 TNc7vsQbvQWEOg70aL/ON4zPq8ihULIh8mdleFahrpU3GuvJdzv4e1p1ynNWgr+SKc
	 jpdP87DcyhugnLe9wrpMRDfbRuqYG0BjG0x0/PXS+BwtwjozQmh6zPGadr39SETmSv
	 uPv301EZRsJLspXw+ZrRz1OIr+MGn+gjgCF5SVqtQt1pUrGlV+II9CeJqtuzApJ0i+
	 CHcb8bbmK0lCTOMOHykvkdQ0UZ6lzraXOSen3iiYBjFmhmA1MGnJieX1M+El4IfO2F
	 mlGSJxvJ+Ho5Q==
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-e461015fbd4so5095865276.2
        for <linux-wireless@vger.kernel.org>; Wed, 12 Mar 2025 06:09:40 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVrQ5wEGX7wy2mTVEK3hk1ur2gcHIZH8e2id266zt3odwn/fYQL8a2J/xRIIvSFgq1TP9lcMxGTUM7maXTXmg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyteNgsA/qu5t3M2kmlI77xfVGkUGFkeHesiOS6PZCiJ/GOmopR
	26O5QTly+lG/Fmjk/tFFlLjvtq01tWnryj6Nk6i0FBRKLqpI+njsz9i0rWo2V9/5WKcJ9YqrO4K
	eof1F0zE6XNaF5KpxH/e/Z/0Zb58=
X-Google-Smtp-Source: AGHT+IGfh5MnJ8HQDXFHe4PNNal8+EL7GW/CA6CzNyfz/k0qI6iHHdX8uOErnMjHLrxr2O+QlsAX8ODMmN/JCj2QDQo=
X-Received: by 2002:a05:6902:701:b0:e5a:ca6b:4531 with SMTP id
 3f1490d57ef6-e635c13860fmr28709989276.12.1741784979565; Wed, 12 Mar 2025
 06:09:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <MW5PR11MB5810E57B22E76956998C4488A3D12@MW5PR11MB5810.namprd11.prod.outlook.com>
In-Reply-To: <MW5PR11MB5810E57B22E76956998C4488A3D12@MW5PR11MB5810.namprd11.prod.outlook.com>
From: Josh Boyer <jwboyer@kernel.org>
Date: Wed, 12 Mar 2025 09:09:27 -0400
X-Gmail-Original-Message-ID: <CA+5PVA5wFa6NsTKX4c66_D18R_yGPm3LN16fO8hUZxkyOGT3vQ@mail.gmail.com>
X-Gm-Features: AQ5f1JqL5R6hbm62OWqZOmLj1tIsBFVThQVyUGTCLCPLiSYHCyteeZQgi6S6ZK0
Message-ID: <CA+5PVA5wFa6NsTKX4c66_D18R_yGPm3LN16fO8hUZxkyOGT3vQ@mail.gmail.com>
Subject: Re: pull request: iwlwifi firmware updates 2025-03-11
To: "Korenblit, Miriam Rachel" <miriam.rachel.korenblit@intel.com>
Cc: "linux-firmware@kernel.org" <linux-firmware@kernel.org>, "kyle@infradead.org" <kyle@infradead.org>, 
	"Hutchings, Ben" <ben@decadent.org.uk>, "Yang, You-Sheng" <vicamo.yang@canonical.com>, 
	"Dreyfuss, Haim" <haim.dreyfuss@intel.com>, Wireless <linux-wireless@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Merged and pushed out.

https://gitlab.com/kernel-firmware/linux-firmware/-/merge_requests/479

josh

On Tue, Mar 11, 2025 at 3:45=E2=80=AFPM Korenblit, Miriam Rachel
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
> The following changes since commit b69d4b74c98611d4c1bdd1d1a767791b451a3f=
38:
>
>
>
>   Merge branch 'robot/pr-0-1741706740' into 'main' (2025-03-11 18:34:30 +=
0000)
>
>
>
> are available in the Git repository at:
>
>
>
>   http://git.kernel.org/pub/scm/linux/kernel/git/iwlwifi/linux-firmware.g=
it tags/iwlwifi-fw-2025-03-11
>
>
>
> for you to fetch changes up to ea922918add33cef2872e1c933ba739bd0d473ca:
>
>
>
>   iwlwifi: add Bz/gl FW for core94-91 release (2025-03-11 21:37:12 +0200)
>
>
>
> ----------------------------------------------------------------
>
> core94
>
>
>
> ----------------------------------------------------------------
>
> Miri Korenblit (3):
>
>       iwlwifi: update cc/Qu/QuZ firmwares for core94-91 release
>
>       iwlwifi: update ty/So/Ma firmwares for core94-91 release
>
>       iwlwifi: add Bz/gl FW for core94-91 release
>
>
>
>  WHENCE                        |  37 +++++++++++++++++++++++-------------=
-
>
>  iwlwifi-Qu-b0-hr-b0-77.ucode  | Bin 1406176 -> 1406184 bytes
>
>  iwlwifi-Qu-b0-jf-b0-77.ucode  | Bin 1322888 -> 1322896 bytes
>
>  iwlwifi-Qu-c0-hr-b0-77.ucode  | Bin 1406192 -> 1406200 bytes
>
>  iwlwifi-Qu-c0-jf-b0-77.ucode  | Bin 1322904 -> 1322912 bytes
>
>  iwlwifi-QuZ-a0-hr-b0-77.ucode | Bin 1406312 -> 1406320 bytes
>
>  iwlwifi-QuZ-a0-jf-b0-77.ucode | Bin 1322980 -> 1322988 bytes
>
>  iwlwifi-bz-b0-fm-c0-97.ucode  | Bin 0 -> 1926136 bytes
>
>  iwlwifi-bz-b0-fm-c0.pnvm      | Bin 295324 -> 295356 bytes
>
>  iwlwifi-bz-b0-gf-a0-97.ucode  | Bin 0 -> 1773268 bytes
>
>  iwlwifi-bz-b0-gf-a0.pnvm      | Bin 55192 -> 55208 bytes
>
>  iwlwifi-cc-a0-77.ucode        | Bin 1367692 -> 1367700 bytes
>
>  iwlwifi-gl-c0-fm-c0-97.ucode  | Bin 0 -> 1911436 bytes
>
>  iwlwifi-gl-c0-fm-c0.pnvm      | Bin 295004 -> 295036 bytes
>
>  iwlwifi-ma-b0-gf-a0-89.ucode  | Bin 1747480 -> 1747512 bytes
>
>  iwlwifi-ma-b0-gf-a0.pnvm      | Bin 55128 -> 55128 bytes
>
>  iwlwifi-ma-b0-gf4-a0-89.ucode | Bin 1599820 -> 1599852 bytes
>
>  iwlwifi-ma-b0-gf4-a0.pnvm     | Bin 27836 -> 27836 bytes
>
>  iwlwifi-ma-b0-hr-b0-89.ucode  | Bin 1539540 -> 1539572 bytes
>
>  iwlwifi-so-a0-gf-a0-89.ucode  | Bin 1735904 -> 1735936 bytes
>
>  iwlwifi-so-a0-gf-a0.pnvm      | Bin 55208 -> 55208 bytes
>
>  iwlwifi-so-a0-gf4-a0-89.ucode | Bin 1590412 -> 1590444 bytes
>
>  iwlwifi-so-a0-gf4-a0.pnvm     | Bin 27876 -> 27876 bytes
>
>  iwlwifi-so-a0-hr-b0-89.ucode  | Bin 1526708 -> 1526740 bytes
>
>  iwlwifi-ty-a0-gf-a0-89.ucode  | Bin 1677772 -> 1677804 bytes
>
>  iwlwifi-ty-a0-gf-a0.pnvm      | Bin 55052 -> 55052 bytes
>
>  26 files changed, 23 insertions(+), 14 deletions(-)
>
>  create mode 100644 iwlwifi-bz-b0-fm-c0-97.ucode
>
>  create mode 100644 iwlwifi-bz-b0-gf-a0-97.ucode
>
>  create mode 100644 iwlwifi-gl-c0-fm-c0-97.ucode

