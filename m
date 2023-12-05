Return-Path: <linux-wireless+bounces-410-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E6D3804553
	for <lists+linux-wireless@lfdr.de>; Tue,  5 Dec 2023 03:50:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9755AB2098D
	for <lists+linux-wireless@lfdr.de>; Tue,  5 Dec 2023 02:50:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6DC43FC7;
	Tue,  5 Dec 2023 02:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TNHLE38R"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99D8520E8
	for <linux-wireless@vger.kernel.org>; Tue,  5 Dec 2023 02:50:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16F54C433D9
	for <linux-wireless@vger.kernel.org>; Tue,  5 Dec 2023 02:50:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701744618;
	bh=ULpntSrxY40uh1Zf8syjVkac9wphSqfByi5sZ3iJ2qw=;
	h=References:In-Reply-To:Reply-To:From:Date:Subject:To:Cc:From;
	b=TNHLE38Rf1VN6YiHq1WYAbFFWL8oEptdItLUpEwGRKt8E5G0aqbm9hrUBYTJe8t5u
	 OstFfMddoJHYY1XN6iBWrbM7QvVEMnGX3gZso6tqz1c0N8mxpscwHvqqf1CBSIR0WX
	 TV880oI96NzBiWDNz4+GvUqRB4LO1X2NtFl4/tvm8sIv5fHYxaoNMgEt983VqwK1Nd
	 L1BYf+/ErBn97kB1n2cLEQqEJBX2Igmn+X4h+HciYat4jcHLQE9TjvbkTEn8/vzfAt
	 4xmNCuhzCtBaD1RG19Fi6SkYUnIEpnnQBB5nUtjapITAS8w4Ugkj/JqtnWkfRpDRFA
	 Xh6E+wRtNkJZA==
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-2866e4ac34bso2675708a91.1
        for <linux-wireless@vger.kernel.org>; Mon, 04 Dec 2023 18:50:18 -0800 (PST)
X-Gm-Message-State: AOJu0YyP97UR5+qHzX40SY/2/u0zA1kx6JKhIRFMKCCx6iAsEPzpkhqm
	V/dH0xKoKZ3G7kfvsSEmq0CT2zbK3XiaIa8o+o8=
X-Google-Smtp-Source: AGHT+IEXQZlOAFGrn4d7v71+WbE227957zpUCn1GfwYl18kJYruA+a2hF3nicrEBJlzYKrwzsRG3s7M/YMxgnXBLYNo=
X-Received: by 2002:a17:90b:4a08:b0:286:6cc0:cad7 with SMTP id
 kk8-20020a17090b4a0800b002866cc0cad7mr591557pjb.78.1701744617643; Mon, 04 Dec
 2023 18:50:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAE+BM3=Neb_g3QPMiGjpmkkpUK6wupM1FX06DyZOtDnQgBz_YA@mail.gmail.com>
In-Reply-To: <CAE+BM3=Neb_g3QPMiGjpmkkpUK6wupM1FX06DyZOtDnQgBz_YA@mail.gmail.com>
Reply-To: wens@kernel.org
From: Chen-Yu Tsai <wens@kernel.org>
Date: Tue, 5 Dec 2023 10:50:06 +0800
X-Gmail-Original-Message-ID: <CAGb2v673ZhHiCDGCbTLVqQqaJLr2xTvJYQwtLTJUFwTKBJa9SA@mail.gmail.com>
Message-ID: <CAGb2v673ZhHiCDGCbTLVqQqaJLr2xTvJYQwtLTJUFwTKBJa9SA@mail.gmail.com>
Subject: Re: [wireless-regdb] Add extra check in regdb scripts
To: Rusty Howell <rustyhowell@gmail.com>
Cc: linux-wireless@vger.kernel.org, wireless-regdb@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Sep 14, 2023 at 12:16=E2=80=AFPM Rusty Howell <rustyhowell@gmail.co=
m> wrote:
>
> From 434588b8f06f78a3188909c298a6f6671dab7b3f Mon Sep 17 00:00:00 2001
> From: Rusty Howell <rhowell@control4.com>
> Date: Thu, 7 Sep 2023 12:56:47 -0600
> Subject: [PATCH] Add same check that kernel uses to check reg domain
>
> The kernel will reject a regulatory domain if the max bandwidth is greate=
r than
> the span from start to end. We should catch this error when compiling the
> regulatory database.
> ---
>  dbparse.py | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/dbparse.py b/dbparse.py
> index 5f7e082..1e87813 100755
> --- a/dbparse.py
> +++ b/dbparse.py
> @@ -218,6 +218,9 @@ class DBParser(object):
>                  self._syntax_error("Inverted freq range (%d - %d)" %
> (start, end))
>              if start =3D=3D end:
>                  self._syntax_error("Start and end freqs are equal
> (%d)" % start)
> +            if bw > (end - start):
> +                self._syntax_error("Max bandwidth must not exceed the
> range from start to end")
> +
>          except ValueError:
>              self._syntax_error("band must have frequency range")
>
> --
> 2.25.1

It looks like this patch was incorrectly line wrapped (by Gmail maybe).
Can you resend?


Thanks
ChenYu

