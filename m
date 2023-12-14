Return-Path: <linux-wireless+bounces-800-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B4858133D3
	for <lists+linux-wireless@lfdr.de>; Thu, 14 Dec 2023 16:03:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 32B2B1F2219A
	for <lists+linux-wireless@lfdr.de>; Thu, 14 Dec 2023 15:03:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0A695B5BB;
	Thu, 14 Dec 2023 15:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KmmmMAdj"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C48385B5B5
	for <linux-wireless@vger.kernel.org>; Thu, 14 Dec 2023 15:03:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B338C433CA
	for <linux-wireless@vger.kernel.org>; Thu, 14 Dec 2023 15:03:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702566180;
	bh=rJ9PwSVgMEg6zUUHMP/J0L6sMxNgHznuGqkJhb/nCdU=;
	h=References:In-Reply-To:Reply-To:From:Date:Subject:To:Cc:From;
	b=KmmmMAdjbvXXschXVfjRcDjZyhm3tAN0W+pb0fcLBT8dqoPOj8UIE5j9X2s1MhwDD
	 /X6cHRXaXbrhccTuF1o1N8uPdB3dMcPIa65idf4QbXYUMS9jRMALDf6e4zXMu3UX4J
	 l3FPw4m+9LUSt1yH0i+aafJT00yAoZMd/7iXUYrpcCH+k01wTSnG6ZWAoinFXv1t/z
	 U8nlyYR4Ia0euwwGFSrg80Mcgp4vG5jsC6rBwb1onUm0csz4XCDEKNxEGnyDqz8+gC
	 fpKL95Hw4lTESN+DBUTvchEhQtpVQBI5T/0ayqjWbtNLJ3dUyGAxDsNpDMnSH4LFW7
	 LDqBjd0Kk8h6g==
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-5c69ecda229so4531877a12.2
        for <linux-wireless@vger.kernel.org>; Thu, 14 Dec 2023 07:03:00 -0800 (PST)
X-Gm-Message-State: AOJu0YxjrechwV9kBo4t/k39slpoYm+ATg6UYIA9GO/FmhppIlYe0JKn
	cgHvQC7E/roOaO7pA6tHYjKU70TULXiHa3gPfpc=
X-Google-Smtp-Source: AGHT+IH2bFRWrAZe5jTe+hg+a9AGAPgFLwNAPexGo+DhypF9T2ubaCTPyTnrTDLFGvTXLYYT8GweRxS4RHjAUsJPbAY=
X-Received: by 2002:a17:90a:5d93:b0:286:a962:d4de with SMTP id
 t19-20020a17090a5d9300b00286a962d4demr4931193pji.49.1702566179814; Thu, 14
 Dec 2023 07:02:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <411a77cb-47f1-2f97-76c6-939c024654b4@16depo.xyz> <a0480e18-7b67-4e16-983e-c8f888c97261@16depo.xyz>
In-Reply-To: <a0480e18-7b67-4e16-983e-c8f888c97261@16depo.xyz>
Reply-To: wens@kernel.org
From: Chen-Yu Tsai <wens@kernel.org>
Date: Fri, 15 Dec 2023 00:02:50 +0900
X-Gmail-Original-Message-ID: <CAGb2v65V==YE=NLYyE=2ApN04jPeuFFc9d6bfTaQYBUsXoFWsQ@mail.gmail.com>
Message-ID: <CAGb2v65V==YE=NLYyE=2ApN04jPeuFFc9d6bfTaQYBUsXoFWsQ@mail.gmail.com>
Subject: Re: [wireless-regdb] [PATCH] Update regulatory info for Armenia (AM)
To: Kirill Matvienko <me@16depo.xyz>
Cc: wireless-regdb@lists.infradead.org, linux-wireless@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 14, 2023 at 7:04=E2=80=AFPM Kirill Matvienko <me@16depo.xyz> wr=
ote:
>
> Source:https://www.arlis.am/DocumentView.aspx?DocID=3D181829

This only justifies the power limit change. What about the
maximum bandwidth?


ChenYu

> Signed-off-by: Kirill Matvienko <me@16depo.xyz>
>
> ---
>   db.txt | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/db.txt b/db.txt
> index fdc2c13..0708039 100644
> --- a/db.txt
> +++ b/db.txt
> @@ -80,8 +80,8 @@ country AL: DFS-ETSI
>
>   country AM: DFS-ETSI
>       (2402 - 2482 @ 40), (20)
> -    (5170 - 5250 @ 20), (18)
> -    (5250 - 5330 @ 20), (18), DFS
> +    (5150 - 5350 @ 80), (100mW)
> +    (5470 - 5875 @ 80), (100mW), NO-OUTDOOR,DFS
>
>   country AN: DFS-ETSI
>       (2402 - 2482 @ 40), (20)
> --
> 2.34.1
>

