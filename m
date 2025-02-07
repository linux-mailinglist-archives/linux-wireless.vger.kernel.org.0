Return-Path: <linux-wireless+bounces-18634-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EAFAFA2C2DD
	for <lists+linux-wireless@lfdr.de>; Fri,  7 Feb 2025 13:40:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 07BD37A7975
	for <lists+linux-wireless@lfdr.de>; Fri,  7 Feb 2025 12:39:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 849691448E0;
	Fri,  7 Feb 2025 12:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m5UZNU87"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F6D917C68
	for <linux-wireless@vger.kernel.org>; Fri,  7 Feb 2025 12:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738932007; cv=none; b=DRP286WHm8RM+5hC1w1jDMx/y4HsspIp8Xf18+n6ZTZQIx5pEjVbasz2JKzkcfTU8RCcaPUVJIRBp4vU/+lzeERkjkWbCro9VccAGQjkCrygEaTsYzURPtKk3oEtvnJAuyU/tTIKElt+NjE2DQNbEqEUCPCmPCP5qeJj+9jzSW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738932007; c=relaxed/simple;
	bh=LULE6dhcYLRBJ3wTxRmiq6ICHBFGoY0lwWu57YR+iMY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=I2yUiK/Vsl1kx7sh22nzgTuBVyEhlpYYNy8Zytr5dCDmzBY9tNxioa75LzdmaBhGDpAChNx1qWJFUPmgXAlzaFPUaPhaEjBeu9Gh+Jj8Ks959gnkxeKH/LsyYqKqqE0qsDLteHPtxH3r0R/RuMmVBhUvEHk1iLl1px74mKZWvko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m5UZNU87; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC1A3C4AF0B
	for <linux-wireless@vger.kernel.org>; Fri,  7 Feb 2025 12:40:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738932006;
	bh=LULE6dhcYLRBJ3wTxRmiq6ICHBFGoY0lwWu57YR+iMY=;
	h=References:In-Reply-To:From:Date:Subject:To:List-Id:Cc:From;
	b=m5UZNU87l2NvNkrkLbRARIlQIh5qznt+/BznaHIkQfZfAhE334fkEeCtH0ys82alT
	 5vYznbWT6TFdti3hKwDK/4xf64BIoTSMPVgBoxAaxZKL1T49o2oQxDb8pTo12/PK7F
	 UwD2zAXgxT1cs+KJtFT6/xyY0igKN/2qfd1ZUTzzN+hvZ+zSMd9hZzCr/ra4D7N+U1
	 BBvUg2D797TooXtPLcoZYxryYvUD58V42rT/Y2QADDttk+7x7/FQ/WphPQlU+q796O
	 MtnhIoC48W622nYs1enb5afLtyqGVFJkoQOuetQRJ4XuqWiJwINue/u72zMxBtqlbi
	 gLvlFMGIXaLrw==
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-e5b107c4346so1633044276.2
        for <linux-wireless@vger.kernel.org>; Fri, 07 Feb 2025 04:40:06 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUsOqjd9Q6tr2chCCeQ4fQ+3UkQko6jBiwYpzuGnxUuK/zhiJHmT95YkLr5N+I7wS5r20LpVkNOwpC+ZUb6Ug==@vger.kernel.org
X-Gm-Message-State: AOJu0YzCTpwol6OOWFO4mL6xIsiNUlCiez8ZA/AsaR1WInD9OvRzb09/
	CfmFJeGxAE7qJrvx9yiFT6X4q5pOJUaErYCPA9TVBuqHzB+wKAInpol3P/IOHK8fAjtukOoOHck
	GTi6Ga2WN5/WWByxgGL+41ii0Fbk=
X-Google-Smtp-Source: AGHT+IGwFG0DeuZXUakfOINeqiJLXekMT+pEAIDlHL34PwNYOVeen+G1IKlcw9N8/7B2Ij+kKI9V6OYuEGBTamQd2Ms=
X-Received: by 2002:a05:6902:1886:b0:e58:a918:fdd0 with SMTP id
 3f1490d57ef6-e5b46178224mr2319267276.4.1738932005964; Fri, 07 Feb 2025
 04:40:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <MW5PR11MB5810E6BC1E21F490B39AE464A3F62@MW5PR11MB5810.namprd11.prod.outlook.com>
In-Reply-To: <MW5PR11MB5810E6BC1E21F490B39AE464A3F62@MW5PR11MB5810.namprd11.prod.outlook.com>
From: Josh Boyer <jwboyer@kernel.org>
Date: Fri, 7 Feb 2025 07:39:54 -0500
X-Gmail-Original-Message-ID: <CA+5PVA7WFgB9Lice5awPbT3KaRTFmCz-165wUdexYRRoqrFp4Q@mail.gmail.com>
X-Gm-Features: AWEUYZkj94XVQowGHAi2dExLQBqehQMuAtZZRpFZOWUIDX1Rx-E0mEa7NfMzuYo
Message-ID: <CA+5PVA7WFgB9Lice5awPbT3KaRTFmCz-165wUdexYRRoqrFp4Q@mail.gmail.com>
Subject: Re: pull request: iwlwifi firmware updates 2025-02-06
To: "Korenblit, Miriam Rachel" <miriam.rachel.korenblit@intel.com>
Cc: "linux-firmware@kernel.org" <linux-firmware@kernel.org>, "kyle@infradead.org" <kyle@infradead.org>, 
	"Hutchings, Ben" <ben@decadent.org.uk>, "Yang, You-Sheng" <vicamo.yang@canonical.com>, 
	Wireless <linux-wireless@vger.kernel.org>, "Dreyfuss, Haim" <haim.dreyfuss@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Merged and pushed out.

https://gitlab.com/kernel-firmware/linux-firmware/-/merge_requests/442

josh

On Thu, Feb 6, 2025 at 1:47=E2=80=AFPM Korenblit, Miriam Rachel
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
>
>
> The following changes since commit 2166884332990f45dcdff597ee9477ec31c064=
28:
>
>
>
>   Merge branch 'robot/patch-0-1738852296' into 'main' (2025-02-06 14:33:4=
6 +0000)
>
>
>
> are available in the Git repository at:
>
>
>
>   http://git.kernel.org/pub/scm/linux/kernel/git/iwlwifi/linux-firmware.g=
it tags/iwlwifi-fw-2025-02-06
>
>
>
> for you to fetch changes up to 608fdf4c775b1c852320fc694097ad1d2dbf4860:
>
>
>
>   iwlwifi: add Bz/gl FW for core93-123 release (2025-02-06 20:37:28 +0200=
)
>
>
>
> ----------------------------------------------------------------
>
> core93
>
>
>
> ----------------------------------------------------------------
>
> Miri Korenblit (3):
>
>       iwlwifi: update cc/Qu/QuZ firmwares for core93-82 release
>
>       iwlwifi: update ty/So/Ma firmwares for core93-123 release
>
>       iwlwifi: add Bz/gl FW for core93-123 release
>
>
>
> WHENCE                        |  37 +++++++++++++++++++++++--------------
>
> iwlwifi-Qu-b0-hr-b0-77.ucode  | Bin 1405988 -> 1406176 bytes
>
> iwlwifi-Qu-b0-jf-b0-77.ucode  | Bin 1322744 -> 1322888 bytes
>
> iwlwifi-Qu-c0-hr-b0-77.ucode  | Bin 1406004 -> 1406192 bytes
>
> iwlwifi-Qu-c0-jf-b0-77.ucode  | Bin 1322760 -> 1322904 bytes
>
> iwlwifi-QuZ-a0-hr-b0-77.ucode | Bin 1406124 -> 1406312 bytes
>
> iwlwifi-QuZ-a0-jf-b0-77.ucode | Bin 1322828 -> 1322980 bytes
>
> iwlwifi-bz-b0-fm-c0-96.ucode  | Bin 0 -> 1935524 bytes
>
> iwlwifi-bz-b0-fm-c0.pnvm      | Bin 295324 -> 295324 bytes
>
> iwlwifi-bz-b0-gf-a0-96.ucode  | Bin 0 -> 1762852 bytes
>
> iwlwifi-bz-b0-gf-a0.pnvm      | Bin 55192 -> 55192 bytes
>
> iwlwifi-cc-a0-77.ucode        | Bin 1367504 -> 1367692 bytes
>
> iwlwifi-gl-c0-fm-c0-96.ucode  | Bin 0 -> 1919592 bytes
>
> iwlwifi-gl-c0-fm-c0.pnvm      | Bin 295004 -> 295004 bytes
>
> iwlwifi-ma-b0-gf-a0-89.ucode  | Bin 1747384 -> 1747480 bytes
>
> iwlwifi-ma-b0-gf-a0.pnvm      | Bin 55112 -> 55128 bytes
>
> iwlwifi-ma-b0-gf4-a0-89.ucode | Bin 1599724 -> 1599820 bytes
>
> iwlwifi-ma-b0-gf4-a0.pnvm     | Bin 27828 -> 27836 bytes
>
> iwlwifi-ma-b0-hr-b0-89.ucode  | Bin 1539472 -> 1539540 bytes
>
> iwlwifi-so-a0-gf-a0-89.ucode  | Bin 1739904 -> 1735904 bytes
>
> iwlwifi-so-a0-gf-a0.pnvm      | Bin 55192 -> 55208 bytes
>
> iwlwifi-so-a0-gf4-a0-89.ucode | Bin 1590316 -> 1590412 bytes
>
> iwlwifi-so-a0-gf4-a0.pnvm     | Bin 27868 -> 27876 bytes
>
> iwlwifi-so-a0-hr-b0-89.ucode  | Bin 1530736 -> 1526708 bytes
>
> iwlwifi-ty-a0-gf-a0-89.ucode  | Bin 1681772 -> 1677772 bytes
>
> iwlwifi-ty-a0-gf-a0.pnvm      | Bin 55036 -> 55052 bytes
>
> 26 files changed, 23 insertions(+), 14 deletions(-)
>
> create mode 100644 iwlwifi-bz-b0-fm-c0-96.ucode
>
> create mode 100644 iwlwifi-bz-b0-gf-a0-96.ucode
>
> create mode 100644 iwlwifi-gl-c0-fm-c0-96.ucode

