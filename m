Return-Path: <linux-wireless+bounces-23491-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1611EAC7C53
	for <lists+linux-wireless@lfdr.de>; Thu, 29 May 2025 13:02:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3A2737AE3DA
	for <lists+linux-wireless@lfdr.de>; Thu, 29 May 2025 11:00:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2058414E2F2;
	Thu, 29 May 2025 11:02:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ER8qxb3K"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFD2E20E6E3
	for <linux-wireless@vger.kernel.org>; Thu, 29 May 2025 11:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748516526; cv=none; b=sdCWShjgRszQtt3uMqL45PAz0+BiyA0RnXHYKI3xYnvHHznWxlJ0Pkw6xtrv8G7ftPBHPvaJ3KUIyYkllYyNahStWQSl5YjCuuesXjYXsySIiJi7gMXfy/pa0dHodmeiJsNieCO7aRRc0gncgjK+p49y1+YQplmlHLtQpcyeNYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748516526; c=relaxed/simple;
	bh=t8gq5btfMXpBO7/rGcx9vPnMmkAkahLXr9rtIUEcxFY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WykUjxeQMmnkHDofcoSR0DTV5w1c4yFZso8Wi4SA5K+T9izH4MOdNidMOiQAhNSnEacU6dfLbSfE2+uyN2ZTPlliBf3czrPzmKKbQuTztbV3V6NNErUI1iDt3CEjoObvOwmeveQkT8K39J1ov60WTGMZlSRMdS2jJZ+gL31SPao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ER8qxb3K; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC24DC4CEF0
	for <linux-wireless@vger.kernel.org>; Thu, 29 May 2025 11:02:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748516525;
	bh=t8gq5btfMXpBO7/rGcx9vPnMmkAkahLXr9rtIUEcxFY=;
	h=References:In-Reply-To:From:Date:Subject:To:List-Id:Cc:From;
	b=ER8qxb3K/Ln6BwpBDCWv5zDi46u+LkHdbuS3QtJx91VVnkM+CmEG1vXta2TkVRbjD
	 7+y0ZaImKHNx9b334iFrGGmdX4x1XPTDdNKvc7Uim+Iex8Ru99sUSHNx5OoxHRJ2Eb
	 B6eIr6oITjJCKjypq0MFfFhfZQolzwHU9+aIXxlZinKrsGBScUMiA3LazNcbxvzOL9
	 kWIUaTI+cvPmPw+ZQv5ukQgRiIQVBQzWxr7lCMKJzaM95bnW58yenwHUg/sb3PTaXV
	 chOT2kNfBlkY52w8UhkDQc12CPL82U7OUTgfxn4DQkg92Clvm3pqM0gRyRJcD670Tb
	 2N7WU1DU/KLTQ==
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-70f94fe1e40so345627b3.1
        for <linux-wireless@vger.kernel.org>; Thu, 29 May 2025 04:02:05 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUvbjP4tkVSNgmuhps5yAiERcqS/2WiwpEzAQX9uCnPsJyyIy0PHQy7IzMBJna1n7k+fbYWzz5Kc4432bOvag==@vger.kernel.org
X-Gm-Message-State: AOJu0YwCsAmR14faBjC8oIBP9IBN18Dx286E5knb+/3osrcD7/TPsOLT
	0Rj5tQhu+d4D3dcj+/gJvyMwQ78VNQ0CJ3AWjFHWFulzjpJ2Lnkd3dombHYPsBsWRc48K5Muooh
	b3gQ0i5VdQOO4ZuIWgIc/b7e0QKjuV2I=
X-Google-Smtp-Source: AGHT+IHeIjPd/FEWd8vjYT/bvMS/lNZ6hH5m4mbY4pQuxcqi2+wZhL4iZQ5QR6R0F6JsEGbLMFBwz+iSbIKDvyRWz+o=
X-Received: by 2002:a05:690c:6108:b0:70e:39e:91c2 with SMTP id
 00721157ae682-70f877a38b2mr53591527b3.11.1748516525046; Thu, 29 May 2025
 04:02:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <MW5PR11MB5810FBCE212AEC8D5315F20CA367A@MW5PR11MB5810.namprd11.prod.outlook.com>
In-Reply-To: <MW5PR11MB5810FBCE212AEC8D5315F20CA367A@MW5PR11MB5810.namprd11.prod.outlook.com>
From: Josh Boyer <jwboyer@kernel.org>
Date: Thu, 29 May 2025 07:01:52 -0400
X-Gmail-Original-Message-ID: <CA+5PVA7i_J=zh345cNvffy_kr3OB8eEXUB3CkD=35YfeaStfgg@mail.gmail.com>
X-Gm-Features: AX0GCFueYVx7ja8o4W9ENPcw4nLLZfWMPMuUNgzH1MgNN5uik8AuYw0DGOSVJL4
Message-ID: <CA+5PVA7i_J=zh345cNvffy_kr3OB8eEXUB3CkD=35YfeaStfgg@mail.gmail.com>
Subject: Re: pull request: iwlwifi firmware updates 2025-05-28
To: "Korenblit, Miriam Rachel" <miriam.rachel.korenblit@intel.com>
Cc: "linux-firmware@kernel.org" <linux-firmware@kernel.org>, "kyle@infradead.org" <kyle@infradead.org>, 
	"Hutchings, Ben" <ben@decadent.org.uk>, "Yang, You-Sheng" <vicamo.yang@canonical.com>, 
	"Dreyfuss, Haim" <haim.dreyfuss@intel.com>, linux-wireless <linux-wireless@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Merged and pushed out.

https://gitlab.com/kernel-firmware/linux-firmware/-/merge_requests/566

josh

On Wed, May 28, 2025 at 4:32=E2=80=AFPM Korenblit, Miriam Rachel
<miriam.rachel.korenblit@intel.com> wrote:
>
> Hi,
>
> This contains some new and updated firmwares for all our currently
> maintained FW binaries.
>
> Please pull or let me know if there are any issues.
>
> --
> Thanks,
> Miri
>
> The following changes since commit 31afae6b274a4df9a110fcf86b94b30f63ca18=
01:
>
>   Merge branch 'mt7925bt' into 'main' (2025-05-28 12:43:01 +0000)
>
> are available in the Git repository at:
>
>   http://git.kernel.org/pub/scm/linux/kernel/git/iwlwifi/linux-firmware.g=
it tags/iwlwifi-fw-2025-05-28
>
> for you to fetch changes up to 6e15e748c1a7024709b29f031cc6479d11522459:
>
>   iwlwifi: add Bz/gl FW for core96-76 release (2025-05-28 23:23:08 +0300)
>
> ----------------------------------------------------------------
> release core96 FWs
>
> ----------------------------------------------------------------
> Miri Korenblit (5):
>       iwlwifi: update 7265D firmware
>       iwlwifi: update firmwares for 8000 series
>       iwlwifi: update cc/Qu/QuZ firmwares for core96-76 release
>       iwlwifi: update ty/So/Ma firmwares for core96-76 release
>       iwlwifi: add Bz/gl FW for core96-76 release
>
>  WHENCE                        |  46 ++++++++++++++++++++++++++----------=
------
>  iwlwifi-7265D-29.ucode        | Bin 1036772 -> 1036312 bytes
>  iwlwifi-8000C-36.ucode        | Bin 2428004 -> 2425084 bytes
>  iwlwifi-8265-36.ucode         | Bin 2436632 -> 2432528 bytes
>  iwlwifi-Qu-b0-hr-b0-77.ucode  | Bin 1406184 -> 1406184 bytes
>  iwlwifi-Qu-b0-jf-b0-77.ucode  | Bin 1322896 -> 1322896 bytes
>  iwlwifi-Qu-c0-hr-b0-77.ucode  | Bin 1406200 -> 1406200 bytes
>  iwlwifi-Qu-c0-jf-b0-77.ucode  | Bin 1322912 -> 1322912 bytes
>  iwlwifi-QuZ-a0-hr-b0-77.ucode | Bin 1406320 -> 1406320 bytes
>  iwlwifi-QuZ-a0-jf-b0-77.ucode | Bin 1322988 -> 1322988 bytes
>  iwlwifi-bz-b0-fm-c0-99.ucode  | Bin 0 -> 1927196 bytes
>  iwlwifi-bz-b0-fm-c0.pnvm      | Bin 295356 -> 296060 bytes
>  iwlwifi-bz-b0-gf-a0-99.ucode  | Bin 0 -> 1777464 bytes
>  iwlwifi-bz-b0-gf-a0.pnvm      | Bin 55208 -> 55208 bytes
>  iwlwifi-bz-b0-hr-b0-99.ucode  | Bin 0 -> 1578840 bytes
>  iwlwifi-bz-b0-hr-b0.pnvm      | Bin 1788 -> 1788 bytes
>  iwlwifi-cc-a0-77.ucode        | Bin 1367700 -> 1367700 bytes
>  iwlwifi-gl-c0-fm-c0-99.ucode  | Bin 0 -> 1912536 bytes
>  iwlwifi-gl-c0-fm-c0.pnvm      | Bin 295036 -> 295740 bytes
>  iwlwifi-ma-b0-gf-a0-89.ucode  | Bin 1747520 -> 1751700 bytes
>  iwlwifi-ma-b0-gf-a0.pnvm      | Bin 55128 -> 55128 bytes
>  iwlwifi-ma-b0-gf4-a0-89.ucode | Bin 1599864 -> 1599948 bytes
>  iwlwifi-ma-b0-gf4-a0.pnvm     | Bin 27836 -> 27836 bytes
>  iwlwifi-ma-b0-hr-b0-89.ucode  | Bin 1539572 -> 1539656 bytes
>  iwlwifi-so-a0-gf-a0-89.ucode  | Bin 1735944 -> 1736028 bytes
>  iwlwifi-so-a0-gf-a0.pnvm      | Bin 55208 -> 55208 bytes
>  iwlwifi-so-a0-gf4-a0-89.ucode | Bin 1590456 -> 1590540 bytes
>  iwlwifi-so-a0-gf4-a0.pnvm     | Bin 27876 -> 27876 bytes
>  iwlwifi-so-a0-hr-b0-89.ucode  | Bin 1526740 -> 1526824 bytes
>  iwlwifi-ty-a0-gf-a0-89.ucode  | Bin 1677812 -> 1677896 bytes
>  iwlwifi-ty-a0-gf-a0.pnvm      | Bin 55052 -> 55052 bytes
>  31 files changed, 29 insertions(+), 17 deletions(-)
>  create mode 100644 iwlwifi-bz-b0-fm-c0-99.ucode
>  create mode 100644 iwlwifi-bz-b0-gf-a0-99.ucode
>  create mode 100644 iwlwifi-bz-b0-hr-b0-99.ucode
>  create mode 100644 iwlwifi-gl-c0-fm-c0-99.ucode

