Return-Path: <linux-wireless+bounces-17599-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF26FA1399D
	for <lists+linux-wireless@lfdr.de>; Thu, 16 Jan 2025 13:00:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3D1EA3A6D41
	for <lists+linux-wireless@lfdr.de>; Thu, 16 Jan 2025 12:00:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 179671DE4FF;
	Thu, 16 Jan 2025 12:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EBQuTfft"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4CB71DE4F9
	for <linux-wireless@vger.kernel.org>; Thu, 16 Jan 2025 12:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737028806; cv=none; b=ZInzWzk2uE53buJIeC1PJLoOfi5bR+j7ZfX+J0BsBKF9LE6saueE66YRzRkb1qHqxxGtGsfTy6UZzgovBhqRMt7cWzwvlL6IjQeErZOkDpiHAManDiB/bDQypWKVBGfsqpMBIy962hIBcgSAHY38bBKjktZTzD5UtcS8w1egoz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737028806; c=relaxed/simple;
	bh=aIzrQq9tBTdcVGI4/Nll1Kjfe3pVlC5BM/kqbcXYrDs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=M0A1z6kHOic5xq5N3TAIghsBzRKs8pySCMQo5YCznN3vyySP2OiEMzyndY5RdfMFQnGkiDV2vinBvqKoIZxLDaoBxlPbvbERqERWFjhko4oIy3NN8Vi9LwYJ3qfrLnMvIh+83eIn4Y3uUSJqv7fWw+ik5qCn3NJv1LuHC01/Wnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EBQuTfft; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4947FC4CEE2
	for <linux-wireless@vger.kernel.org>; Thu, 16 Jan 2025 12:00:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737028805;
	bh=aIzrQq9tBTdcVGI4/Nll1Kjfe3pVlC5BM/kqbcXYrDs=;
	h=References:In-Reply-To:From:Date:Subject:To:List-Id:Cc:From;
	b=EBQuTfftzFpQ1VMwNKHQXOhazjdIzUClt8c1HnZ7Z1atbFJ8cftmrc7rUO6C7uNHU
	 PRcHU5FgkXGtuoaZbZySDZj3XOdlPIqgFjGrE7TRtQQuj2QQJNo9gXRrvjWstbY4ol
	 ji4eVwCLVOlNbH+NFPHzGBrPjv3wi4dN/LzShx1r8HnAYfuK1rCGg1KsQUMDtw1WoR
	 yBKJatMiuZkPMeOIyvYNV8CImBtSGjF11N4cxySz3Zffm3CkZJ2hz/U2i56ijYcejA
	 RF6qilHpQ20giR4DzlWgE0vQoX8NtnXtgVmqx/XD46PfTGO1P3c7M96Tzhu6QTYjEw
	 BSzoyeAzwTejg==
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-aaf8f0ea963so161709666b.3
        for <linux-wireless@vger.kernel.org>; Thu, 16 Jan 2025 04:00:05 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVhd3krm4iY5VHULKcRpz2tfXRePFfJDkwIyStVxRz4r0D6pU7X8HyvGhUKMyI0ZAvZCgw0V+V9784oXsQ70A==@vger.kernel.org
X-Gm-Message-State: AOJu0YzIkQlWmDZXLYWCFktH8z0AbaOS2Grj05phyw8zATaV3E2Ko4KX
	24pOBH42BCs3qxSdfKpA7CiKm8v2w6P7bl7XsMHHjno7FWlgNy42z08T+4ZlQLSDgX/yYP5aO3F
	FZIgGQ7aDdksxS4a/t/KG8bWc4ic=
X-Google-Smtp-Source: AGHT+IEknswj0r6+jEMspheA8T+7pscfhXggdRbCTT49JUROv5lFYLojtUGe4XA8Xiy0BTeI1TZYz0HEqlySvLWz7/M=
X-Received: by 2002:a17:907:6d0e:b0:aaf:5c9:19f9 with SMTP id
 a640c23a62f3a-ab2ab6f3455mr3054182766b.27.1737028803814; Thu, 16 Jan 2025
 04:00:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <MW5PR11MB5810AB20FCCD2A0B4AFDC901A3192@MW5PR11MB5810.namprd11.prod.outlook.com>
In-Reply-To: <MW5PR11MB5810AB20FCCD2A0B4AFDC901A3192@MW5PR11MB5810.namprd11.prod.outlook.com>
From: Josh Boyer <jwboyer@kernel.org>
Date: Thu, 16 Jan 2025 06:59:50 -0500
X-Gmail-Original-Message-ID: <CA+5PVA5E8R0XNAJX3ymphG4PL66YxJ6RbNZG+1fCvo3cq9hR3g@mail.gmail.com>
X-Gm-Features: AbW1kvbjSZ1EgFzukx00E4xmUcszM-BRtX3HfFmSR70PW7EVuFFU-mXGPiF2Msw
Message-ID: <CA+5PVA5E8R0XNAJX3ymphG4PL66YxJ6RbNZG+1fCvo3cq9hR3g@mail.gmail.com>
Subject: Re: pull request: iwlwifi firmware updates 2024-01-15
To: "Korenblit, Miriam Rachel" <miriam.rachel.korenblit@intel.com>
Cc: "linux-firmware@kernel.org" <linux-firmware@kernel.org>, "kyle@infradead.org" <kyle@infradead.org>, 
	"Hutchings, Ben" <ben@decadent.org.uk>, "Yang, You-Sheng" <vicamo.yang@canonical.com>, 
	"Dreyfuss, Haim" <haim.dreyfuss@intel.com>, Wireless <linux-wireless@vger.kernel.org>, 
	"Damary, Guy" <guy.damary@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 15, 2025 at 2:46=E2=80=AFAM Korenblit, Miriam Rachel
<miriam.rachel.korenblit@intel.com> wrote:
>
> Hi,
>
>
>
> This contains a new firmware for Bz device.
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
> The following changes since commit a28a9226ccb8bf393b8e7dd8970a4d967c1a1d=
92:
>
>
>
>   Merge branch 'robot/pr-0-1736646402' into 'main' (2025-01-13 14:30:09 +=
0000)
>
>
>
> are available in the Git repository at:
>
>
>
>   http://git.kernel.org/pub/scm/linux/kernel/git/iwlwifi/linux-firmware.g=
it tags/iwlwifi-fw-2025-01-15

Merged and pushed out.

https://gitlab.com/kernel-firmware/linux-firmware/-/merge_requests/407

josh

>
>
>
> for you to fetch changes up to 04e6d3f371ab3ad6970603be194023bd4c700126:
>
>
>
>   iwlwifi: add Bz FW for core90-93 release (2025-01-15 09:38:48 +0200)
>
>
>
> ----------------------------------------------------------------
>
> released core90 of BZ+FM
>
>
>
> ----------------------------------------------------------------
>
> Miri Korenblit (1):
>
>       iwlwifi: add Bz FW for core90-93 release
>
>
>
>  WHENCE                       |   3 +++
>
>  iwlwifi-bz-b0-fm-c0-93.ucode | Bin 0 -> 1931432 bytes
>
>  2 files changed, 3 insertions(+)
>
>  create mode 100644 iwlwifi-bz-b0-fm-c0-93.ucode

