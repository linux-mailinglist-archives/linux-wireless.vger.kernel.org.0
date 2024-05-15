Return-Path: <linux-wireless+bounces-7663-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BB32B8C5FA2
	for <lists+linux-wireless@lfdr.de>; Wed, 15 May 2024 06:11:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 747AC1F22EC3
	for <lists+linux-wireless@lfdr.de>; Wed, 15 May 2024 04:11:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C955E38394;
	Wed, 15 May 2024 04:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c6nOp28h"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9874F381B9;
	Wed, 15 May 2024 04:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715746292; cv=none; b=JUsWZpf8sRCU07S6Zu9fIjboqfGDXsL/vkf4ZdKnuM4dPm4xk128lSbk8LDP7OX2sm0L4f52IF9oGKnpvLdv+507CAYUb5tDh1xNpSiJ9ktR4nCppXsHILpYYwZwHKjlnkdPcogv31tuh9ZHzo5ahQ/wARqjECWVwFGksaB0ugY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715746292; c=relaxed/simple;
	bh=DGpteUQnXnqvaSKjiFXXMNv3ukrcO+rgBe/rtRI4AB4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rGrgfeZ2PNp9fEd67CnaK8EZZXh9eOvU4CMxqgUDhRU5ZHmHxxlbJJ62wBLzGHnc/YFMEsnwB/PogW25PwLpDd6b0IF7iJDF7M+yXJToKgQ4SwDZxBWIczZFqSXzG6OwNUDi5XO6yp1Q+3EfMSFojRigqeFM0RXe5QqiQcZBKdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c6nOp28h; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13FB0C4AF08;
	Wed, 15 May 2024 04:11:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715746292;
	bh=DGpteUQnXnqvaSKjiFXXMNv3ukrcO+rgBe/rtRI4AB4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=c6nOp28h9UgCQ/9V/gB8GZ8CcNsIglcFQOG8kkRMYXqyKEIb63q1EY+hCULiwhNAm
	 3pr8Vpxmwod7wKy74JwGyBc0T8RzAXaChIYleyrjRNtxUAUuX/DLrjeI0rEhizMm3n
	 K9SP7SbX1+9ZEDq428fypjpG5ewFFjHgv96G8zBIxj9GyVygBdITs/kwqLO528jrJD
	 PLPW3CcjvQhZxlPKAMJrHSXo2mpDheT7frOp+1EHBQQIyY2RCfVl4R88P1uewxBdl8
	 7Qt2FDobkvpW4A53Ql7nc4rHYmSAWBfTQ/LjQYDPrIgc4XhH26xp8vGzeNHCvRHcnE
	 CTy7b7WNYM1MA==
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-51fc01b6fe7so6922146e87.0;
        Tue, 14 May 2024 21:11:31 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWjLX5vtLTH0T61tComS9t/KJbSwzx+o8StWX+gx9cjoKa7CxBJblej8mVfQ4GpfHTZdU+Yrh07LQOhHvaM6+5O3P1i6xazHvEB5O3kcAcASDqGy+GbLOpRjnwRDTKniTv2kpefWdPxS1PfZ6Ezurw0+1WUSbGvLZyUBluC6Uq6/awxhuUvxdNzKZmuE/e63eVo5lsVBG9mzbilgdGPvSrZQYA=
X-Gm-Message-State: AOJu0YxMlnMpBvcdxKupkXWcegaj2WtGELFrPJQhNwmPo0o789liBarP
	6rjLsSL4XKzjXuAhSz/jLfdPG2gaSlm42/my3gAvBXHzEceeBa8oAK1gqlAfRd/CQTRnm2x1BH8
	+OnTvaD3SJjicSz+a3+fiyfuB32g=
X-Google-Smtp-Source: AGHT+IGf9KkaZ1XrLk3QFuoMxHqz0TLUmdPdwogXPls6TDspk0lP3qpJ++Cgv3dhmSh/1dfrghgI7eC7j7ZRMW6xKWM=
X-Received: by 2002:a05:6512:1304:b0:51c:5171:bbed with SMTP id
 2adb3069b0e04-5221006e625mr12124467e87.15.1715746290716; Tue, 14 May 2024
 21:11:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240511-ath10k-snoc-dep-v1-1-9666e3af5c27@linaro.org>
 <12a208d7-f36b-4953-abff-323a15452b3c@quicinc.com> <CAK7LNASyBNbxm-e+iZ=7pOJg-a-Zm84O6RNcqiUjZQH7f9r3Lw@mail.gmail.com>
 <e5edd92e-ab47-4a55-9276-5a7d160fd399@quicinc.com>
In-Reply-To: <e5edd92e-ab47-4a55-9276-5a7d160fd399@quicinc.com>
From: Masahiro Yamada <masahiroy@kernel.org>
Date: Wed, 15 May 2024 13:10:54 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQ11Pt85_T9kvYYbqfnjMSH_Yjwvz52E+Tcmw8jS-wvDw@mail.gmail.com>
Message-ID: <CAK7LNAQ11Pt85_T9kvYYbqfnjMSH_Yjwvz52E+Tcmw8jS-wvDw@mail.gmail.com>
Subject: Re: [PATCH] wifi: ath10k: fix QCOM_RPROC_COMMON dependency
To: Jeff Johnson <quic_jjohnson@quicinc.com>
Cc: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, Kalle Valo <kvalo@kernel.org>, 
	Jeff Johnson <jjohnson@kernel.org>, Stephen Boyd <swboyd@chromium.org>, 
	Rakesh Pillai <quic_pillair@quicinc.com>, linux-wireless@vger.kernel.org, 
	ath10k@lists.infradead.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org, linux-kbuild@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 15, 2024 at 3:14=E2=80=AFAM Jeff Johnson <quic_jjohnson@quicinc=
.com> wrote:
>
> On 5/14/2024 10:45 AM, Masahiro Yamada wrote:
> > On Tue, May 14, 2024 at 11:43=E2=80=AFPM Jeff Johnson <quic_jjohnson@qu=
icinc.com> wrote:
> >>
> >> On 5/11/2024 3:49 AM, Dmitry Baryshkov wrote:
> >>> If ath10k_snoc is built-in, while Qualcomm remoteprocs are built as
> >>> modules, compilation fails with:
> >>>
> >>> /usr/bin/aarch64-linux-gnu-ld: drivers/net/wireless/ath/ath10k/snoc.o=
: in function `ath10k_modem_init':
> >>> drivers/net/wireless/ath/ath10k/snoc.c:1534: undefined reference to `=
qcom_register_ssr_notifier'
> >>> /usr/bin/aarch64-linux-gnu-ld: drivers/net/wireless/ath/ath10k/snoc.o=
: in function `ath10k_modem_deinit':
> >>> drivers/net/wireless/ath/ath10k/snoc.c:1551: undefined reference to `=
qcom_unregister_ssr_notifier'
> >>>
> >>> Add corresponding dependency to ATH10K_SNOC Kconfig entry so that it'=
s
> >>> built as module if QCOM_RPROC_COMMON is built as module too.
> >>>
> >>> Fixes: 747ff7d3d742 ("ath10k: Don't always treat modem stop events as=
 crashes")
> >>> Cc: stable@vger.kernel.org
> >>> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> >>> ---
> >>>  drivers/net/wireless/ath/ath10k/Kconfig | 1 +
> >>>  1 file changed, 1 insertion(+)
> >>>
> >>> diff --git a/drivers/net/wireless/ath/ath10k/Kconfig b/drivers/net/wi=
reless/ath/ath10k/Kconfig
> >>> index e6ea884cafc1..4f385f4a8cef 100644
> >>> --- a/drivers/net/wireless/ath/ath10k/Kconfig
> >>> +++ b/drivers/net/wireless/ath/ath10k/Kconfig
> >>> @@ -45,6 +45,7 @@ config ATH10K_SNOC
> >>>       depends on ATH10K
> >>>       depends on ARCH_QCOM || COMPILE_TEST
> >>>       depends on QCOM_SMEM
> >>> +     depends on QCOM_RPROC_COMMON || QCOM_RPROC_COMMON=3Dn
> >>>       select QCOM_SCM
> >>>       select QCOM_QMI_HELPERS
> >>>       help
> >>>
> >>> ---
> >>> base-commit: 75fa778d74b786a1608d55d655d42b480a6fa8bd
> >>> change-id: 20240511-ath10k-snoc-dep-862a9da2e6bb
> >>
> >> I see how this fixes the problem, but this doesn't seem like an ideal
> >> solution. The fact that the *_ssr_notifier() functions are correctly p=
rotected
> >> by conditional compilation ideally should mean that clients don't need=
 to call
> >> call out this as a dependency. Otherwise, it would mean we'd need to d=
o this
> >> for all feature flags.
> >
> >
> > It depends on if qcom_common.c is optional for ath10k_snoc.
> >
> > If it is optional, this patch is correct.
>
> At least from a build perspective it is optional



You need to make a decision from a run-time perspective
(that is, whether you are fine with having
ar_snoc->notifier =3D=3D NULL)


If you are able to build the kernel successfully
but you get a run-time error (e.g. NULL pointer dereference),
it is even worse because run-time debugging is generally more
difficult than compile-time debugging.




--=20
Best Regards
Masahiro Yamada

