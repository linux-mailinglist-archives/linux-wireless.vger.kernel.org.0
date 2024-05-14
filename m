Return-Path: <linux-wireless+bounces-7656-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87B898C5A7E
	for <lists+linux-wireless@lfdr.de>; Tue, 14 May 2024 19:45:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1853A283496
	for <lists+linux-wireless@lfdr.de>; Tue, 14 May 2024 17:45:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61EBB17F39E;
	Tue, 14 May 2024 17:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VKImCysY"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D67D5A0F9;
	Tue, 14 May 2024 17:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715708748; cv=none; b=PHj437TJ03Z0kWdWcsuDv8sWdicLFaEDWWTvXWwXu4ZaHu7vKulqdmpflrFNHfgSWNm9TDgGfdDLgKqtq1qkR2FDuQD7Kpce4UEYzmy/fuA2tQLwL3uGAe3Sjo0oOE5fneyAyqIq9zLO0ZVpmIYtp50XcH4f0YdnDLVSA4nD7/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715708748; c=relaxed/simple;
	bh=FOjLC9GTIUd1WGRSxLT8Kv9gyt6FdbEbbp3ZmLp/5Pw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=a0JLYv3//AGLVFq+PR2RHGbsw4khfILjB/7YuSDT9S/MZUcQseqcThIgaDUUZU159SchypuYkDgRVXfH0GH3xaLiwyjRDAU4Xul0Br5ttVzYMdI12UeJ05U4ve+GBI0FE3qUngXIqTYmrSfYRMj88GWKdHsWGAdxRvCQIxMbQdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VKImCysY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99583C4AF0B;
	Tue, 14 May 2024 17:45:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715708747;
	bh=FOjLC9GTIUd1WGRSxLT8Kv9gyt6FdbEbbp3ZmLp/5Pw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=VKImCysY3bcey58jwKO+qoQW0bnHVN/etyfwMudeR25DbYzK3YhTvWmr+708I78H5
	 D+awgxvAly3K1xsLtDkDRg63v4rcI0H6IsJD5h45j8oGdQwqlDINPektsflqTDqMwe
	 ECiDPAgaAkZgANH/wGE68CXphZKkSwNH6rjkwMQCeuKa9J1eoYRzu0bWrProSMYzrL
	 d3U1BghkuKONFSdgXJpIBALNCuhKOBXlAendOTCxizkioLVt7hv7tFgHrf6u05wvY8
	 6P70X6yHq3fs19WW6xZDGI4g8LAgCiKineGFS9Nql2tCuIequp45hrqIUz32/yGau7
	 dd5V/fRiJ9FEA==
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-51f12ccff5eso8138918e87.1;
        Tue, 14 May 2024 10:45:47 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVz4iirYGHdGthKxNWTgMmc8yYskotFiN2d/SsMDqL2qgeP8+MTylczpxR3z1yAd9ZKMNi/nFrfIgREKGhtWA7kaIYuXiPcDItMTDgRNsdlXXeX4Ane+ufLj7ThegIsMoA3vXIUbBbli+ZwzCB+xHWyJPNnnpYO5AzqjAdw5G1YEvGEoAMhF3pqcvHZP0yZzjA2VPTRsBBUrgaKSX5IX5ZFdCU=
X-Gm-Message-State: AOJu0YzFYFBJiGGQ8A34d7mU3V7uSDiNgZeFqgIQBc8y8AOlXiSFZwZ0
	a7b+6/iaHyqiaBseUzBB9aqrVci6pL65UIClQUCqzyYDdkFLVNdRuDT7DiXClUZOSu7ITe85Lf4
	+tr00S3Y/0q+U0fg6GKZ4GVlng90=
X-Google-Smtp-Source: AGHT+IFNbI6Bd5BRsGSVHMrS8noqYrRTepjcaaqy5bW0mLMfJcq2tUemTq2/g8JEYAe2AL1nwXz7wo3BaTt9cfiD81I=
X-Received: by 2002:a05:6512:b15:b0:51a:ca75:9ffe with SMTP id
 2adb3069b0e04-5221057b50bmr12345399e87.42.1715708746044; Tue, 14 May 2024
 10:45:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240511-ath10k-snoc-dep-v1-1-9666e3af5c27@linaro.org> <12a208d7-f36b-4953-abff-323a15452b3c@quicinc.com>
In-Reply-To: <12a208d7-f36b-4953-abff-323a15452b3c@quicinc.com>
From: Masahiro Yamada <masahiroy@kernel.org>
Date: Wed, 15 May 2024 02:45:09 +0900
X-Gmail-Original-Message-ID: <CAK7LNASyBNbxm-e+iZ=7pOJg-a-Zm84O6RNcqiUjZQH7f9r3Lw@mail.gmail.com>
Message-ID: <CAK7LNASyBNbxm-e+iZ=7pOJg-a-Zm84O6RNcqiUjZQH7f9r3Lw@mail.gmail.com>
Subject: Re: [PATCH] wifi: ath10k: fix QCOM_RPROC_COMMON dependency
To: Jeff Johnson <quic_jjohnson@quicinc.com>
Cc: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, Kalle Valo <kvalo@kernel.org>, 
	Jeff Johnson <jjohnson@kernel.org>, Stephen Boyd <swboyd@chromium.org>, 
	Rakesh Pillai <quic_pillair@quicinc.com>, linux-wireless@vger.kernel.org, 
	ath10k@lists.infradead.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org, linux-kbuild@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 14, 2024 at 11:43=E2=80=AFPM Jeff Johnson <quic_jjohnson@quicin=
c.com> wrote:
>
> On 5/11/2024 3:49 AM, Dmitry Baryshkov wrote:
> > If ath10k_snoc is built-in, while Qualcomm remoteprocs are built as
> > modules, compilation fails with:
> >
> > /usr/bin/aarch64-linux-gnu-ld: drivers/net/wireless/ath/ath10k/snoc.o: =
in function `ath10k_modem_init':
> > drivers/net/wireless/ath/ath10k/snoc.c:1534: undefined reference to `qc=
om_register_ssr_notifier'
> > /usr/bin/aarch64-linux-gnu-ld: drivers/net/wireless/ath/ath10k/snoc.o: =
in function `ath10k_modem_deinit':
> > drivers/net/wireless/ath/ath10k/snoc.c:1551: undefined reference to `qc=
om_unregister_ssr_notifier'
> >
> > Add corresponding dependency to ATH10K_SNOC Kconfig entry so that it's
> > built as module if QCOM_RPROC_COMMON is built as module too.
> >
> > Fixes: 747ff7d3d742 ("ath10k: Don't always treat modem stop events as c=
rashes")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> > ---
> >  drivers/net/wireless/ath/ath10k/Kconfig | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/drivers/net/wireless/ath/ath10k/Kconfig b/drivers/net/wire=
less/ath/ath10k/Kconfig
> > index e6ea884cafc1..4f385f4a8cef 100644
> > --- a/drivers/net/wireless/ath/ath10k/Kconfig
> > +++ b/drivers/net/wireless/ath/ath10k/Kconfig
> > @@ -45,6 +45,7 @@ config ATH10K_SNOC
> >       depends on ATH10K
> >       depends on ARCH_QCOM || COMPILE_TEST
> >       depends on QCOM_SMEM
> > +     depends on QCOM_RPROC_COMMON || QCOM_RPROC_COMMON=3Dn
> >       select QCOM_SCM
> >       select QCOM_QMI_HELPERS
> >       help
> >
> > ---
> > base-commit: 75fa778d74b786a1608d55d655d42b480a6fa8bd
> > change-id: 20240511-ath10k-snoc-dep-862a9da2e6bb
>
> I see how this fixes the problem, but this doesn't seem like an ideal
> solution. The fact that the *_ssr_notifier() functions are correctly prot=
ected
> by conditional compilation ideally should mean that clients don't need to=
 call
> call out this as a dependency. Otherwise, it would mean we'd need to do t=
his
> for all feature flags.


It depends on if qcom_common.c is optional for ath10k_snoc.

If it is optional, this patch is correct.


If it is mandatory
depends on QCOM_RPROC_COMMON


>
> +linux-kbuild just to make sure there isn't a better approach.


Commit 28d49e171676afb7df7f47798391364af9abed7f suggested

  depends on BAR || !BAR

but

  depends on BAR || BAR=3Dn

works equivalently.



>
> /jeff
>
>


--=20
Best Regards
Masahiro Yamada

