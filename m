Return-Path: <linux-wireless+bounces-23924-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F9E8AD3422
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Jun 2025 12:56:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 659141885CB7
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Jun 2025 10:56:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B41527F72C;
	Tue, 10 Jun 2025 10:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ks1zTuIO"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8FA8278E6F
	for <linux-wireless@vger.kernel.org>; Tue, 10 Jun 2025 10:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749552975; cv=none; b=R9Tpa9k9x8x+ewac7b2SQnC79e6YXFKXrpYuSBnl+4idXCKrRSNKbQntr0KTjYJJLuW5uTFjFzrt7bErSTN4cLpP2j7ILDUMLk34fB8x2OpEHWMJmPEsW+jgEpu46ImkYWPhHd6DuglQhPVfHD+qPZ+AHlZbqW5R8uU8XejMNlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749552975; c=relaxed/simple;
	bh=LeMCqbsz2Y6lOb1tBEOvdEU2lstNBFQUpl1wwV7BPVY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Uig+55PIbRgq6IKurMT2Ab0Wr45ic02q0ArICGK3WsSw4wx2k2TebUR/5Mdt9FXEkz/8cXxblClUguTM3Tdt0u0HcOXjUdyD9FoYuXtf/P0iYw01Ujqu3gAivqk4DHtGEbC6eA1lT2vydogSfcYbH58cIpAo+Xjzrmkr99wLcvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ks1zTuIO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72BE6C4CEF1
	for <linux-wireless@vger.kernel.org>; Tue, 10 Jun 2025 10:56:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749552975;
	bh=LeMCqbsz2Y6lOb1tBEOvdEU2lstNBFQUpl1wwV7BPVY=;
	h=References:In-Reply-To:From:Date:Subject:To:List-Id:Cc:From;
	b=Ks1zTuIOUyn+tyC0ju1aj4EsoInuX1ZIU5xGMlJ3q3vJ3AgJeLJ4OJ6JA11KAokcz
	 Naz3LPf86u+N9Smb02wzCYZueEr5eS6u+kJUW0Q1KKEMdYmL/n4Db457NcmV3TfBkl
	 E1tyJx93BGxU1gc9KXMYJsVHakr11Gk6kHs4sfDmT5EQ7Q9hOm/vr5UHs0bTPKLLPN
	 UKk29B7IcEdavLweqlMWIhdpI0RuY26TAMI5RNi9bH95p+RA2Dvhba9GLODOGe4uRI
	 rHUvR23iT0EdT2pHhLajnt7KtlMx5ADX/GGY6HWAPXhAiLokx+CWBW72B8W9pXfbYO
	 8L1SQ4l/z3Osw==
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-70f147b5a52so31859307b3.3
        for <linux-wireless@vger.kernel.org>; Tue, 10 Jun 2025 03:56:15 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCX1O6hlrHbT76Qtz6x7Jifxccpuu9IliOKjdAzaX5RTpn5qdF33pKNAzyRpvYjnwa6qMycfXnxGNQ58b4zrhw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwavVYmAeclTkyilKnMs8OmCrM6pPODi/7bX19jfUeBUZMfbqRu
	5/0E9ZcWnpJ6GNa29m4Znayefu2R0zluAd1eeb3UdtuNvMZOlxXe+G0VPg6gjy5gemBVgFi338J
	Vc5ViEU7xtLCD/4xkjWPbmvFQE8qYwwA=
X-Google-Smtp-Source: AGHT+IGScghRE/zlPz+X1QQqXKGLodydzMYxvVqaKFuHJnBPG0bTil/7smICi/J2D74Xc8gLOSQpLdjVQXjkn2ITGV4=
X-Received: by 2002:a05:690c:360a:b0:70c:90af:154 with SMTP id
 00721157ae682-710f76863d6mr253191787b3.20.1749552974708; Tue, 10 Jun 2025
 03:56:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <DM3PPF63A6024A9415C3A590026C051A7A2A36BA@DM3PPF63A6024A9.namprd11.prod.outlook.com>
In-Reply-To: <DM3PPF63A6024A9415C3A590026C051A7A2A36BA@DM3PPF63A6024A9.namprd11.prod.outlook.com>
From: Josh Boyer <jwboyer@kernel.org>
Date: Tue, 10 Jun 2025 06:56:03 -0400
X-Gmail-Original-Message-ID: <CA+5PVA7TR0NZEmn02zetxUHQvHZk3LtNOLW5a1qUaJOhAn0=Yw@mail.gmail.com>
X-Gm-Features: AX0GCFuzzO-OGaUbuzg1r5Cc6kHI7YCshe0JTmFHLVP3zDKwzC2VInjNgwz8BuQ
Message-ID: <CA+5PVA7TR0NZEmn02zetxUHQvHZk3LtNOLW5a1qUaJOhAn0=Yw@mail.gmail.com>
Subject: Re: pull request: iwlwifi firmware updates 2025-06-09
To: "Korenblit, Miriam Rachel" <miriam.rachel.korenblit@intel.com>
Cc: "linux-firmware@kernel.org" <linux-firmware@kernel.org>, 
	Linux Wireless <linux-wireless@vger.kernel.org>, "Dreyfuss, Haim" <haim.dreyfuss@intel.com>, 
	"kyle@infradead.org" <kyle@infradead.org>, "Hutchings, Ben" <ben@decadent.org.uk>, 
	"Yang, You-Sheng" <vicamo.yang@canonical.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Merged and pushed out.

https://gitlab.com/kernel-firmware/linux-firmware/-/merge_requests/578

josh

On Mon, Jun 9, 2025 at 6:22=E2=80=AFAM Korenblit, Miriam Rachel
<miriam.rachel.korenblit@intel.com> wrote:
>
> Hi,
>
> Due to an unexpected incompatibility between the FW and PNVM,
> Revert the FW and PNVM updates for the affected devices.
>
> Please pull or let me know if there are any issues.
>
> Thanks,
> Miri
> ---
>
> The following changes since commit 5ac6303062e4f052100439783cf06f26c5529b=
4c:
>
>   amdgpu: DMCUB updates for various ASICs (2025-06-06 20:58:30 +0000)
>
> are available in the Git repository at:
>
>   http://git.kernel.org/pub/scm/linux/kernel/git/iwlwifi/linux-firmware.g=
it tags/iwlwifi-fw-2025-06-09
>
> for you to fetch changes up to 7738031c44a325b63247f984d19d3a578423f5f3:
>
>   Revert "iwlwifi: add Bz/gl FW for core96-76 release" (2025-06-09 10:18:=
18 +0300)
>
> ----------------------------------------------------------------
> revert core96 for Bz/Gl, due to FW and PNVM compatibility issue
>
> ----------------------------------------------------------------
> Miri Korenblit (1):
>       Revert "iwlwifi: add Bz/gl FW for core96-76 release"
>
>  WHENCE                       |  12 ------------
>  iwlwifi-bz-b0-fm-c0-99.ucode | Bin 1927196 -> 0 bytes
>  iwlwifi-bz-b0-fm-c0.pnvm     | Bin 296060 -> 295356 bytes
>  iwlwifi-bz-b0-gf-a0-99.ucode | Bin 1777464 -> 0 bytes
>  iwlwifi-bz-b0-gf-a0.pnvm     | Bin 55208 -> 55208 bytes
>  iwlwifi-bz-b0-hr-b0-99.ucode | Bin 1578840 -> 0 bytes
>  iwlwifi-bz-b0-hr-b0.pnvm     | Bin 1788 -> 1788 bytes
>  iwlwifi-gl-c0-fm-c0-99.ucode | Bin 1912536 -> 0 bytes
>  iwlwifi-gl-c0-fm-c0.pnvm     | Bin 295740 -> 295036 bytes
>  9 files changed, 12 deletions(-)
>  delete mode 100644 iwlwifi-bz-b0-fm-c0-99.ucode
>  delete mode 100644 iwlwifi-bz-b0-gf-a0-99.ucode
>  delete mode 100644 iwlwifi-bz-b0-hr-b0-99.ucode
>  delete mode 100644 iwlwifi-gl-c0-fm-c0-99.ucode

