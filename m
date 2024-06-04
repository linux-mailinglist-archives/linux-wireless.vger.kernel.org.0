Return-Path: <linux-wireless+bounces-8481-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BB2FE8FAF95
	for <lists+linux-wireless@lfdr.de>; Tue,  4 Jun 2024 12:09:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6EA591F22622
	for <lists+linux-wireless@lfdr.de>; Tue,  4 Jun 2024 10:09:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E901F143C7B;
	Tue,  4 Jun 2024 10:09:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oMNUgPJF"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C471B143C72
	for <linux-wireless@vger.kernel.org>; Tue,  4 Jun 2024 10:09:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717495793; cv=none; b=hsbvXkiZMmweZRtVnxuMbuKQlG/dWJDjUvTgOIzM10Uc/PZmY1OiD2VlyhyswzSjWniocY4vmP1g78GHcHc5QYX/SfqWGIIIkoB0T9LM8nmxr2RvjM0mIdTNtRL0KEGdtRfZzHufPqNJS63ayJTd8qTnxjB7/uwwCwIcwjxN8U0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717495793; c=relaxed/simple;
	bh=0AGulmW0IOyFEIGDLnVd9WKnbGj9S56eEMRuFE4tgbY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=m/3E/J8IpWh92qrXuaW8RxvsOoSFpmkvUyb/HXUDHkuCocT3VD1H6rsVPW2wt12zGNtNidhLZteH0g87ArQ/4YlmyWEK89Od6CTd7wU9Y/vcfVg6MfTKiefGZI15P0rg9gLmomOM/7R1CmdIzI+BYy+gHUaI6T1ZUn6ARzgu/5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oMNUgPJF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54EEDC2BBFC
	for <linux-wireless@vger.kernel.org>; Tue,  4 Jun 2024 10:09:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717495793;
	bh=0AGulmW0IOyFEIGDLnVd9WKnbGj9S56eEMRuFE4tgbY=;
	h=References:In-Reply-To:Reply-To:From:Date:Subject:To:Cc:From;
	b=oMNUgPJFx4bfFOQOH4OLwgyN64n8AMGeLxNg7YgEfHIFQhWi5ggYNwjF+cHxq2jXw
	 JKOCZ77M8wxg/tZB2WZPNzXwqD3Q+fVCrHg98JfXl/b+O9VLkl1G8dJXd8ddgOOgo+
	 Zut8JjzNZh2HQu6TDX4bl4qpGR6DX/5YfxahHXu0DRx398TmIitDVkrNncOPBh/HUe
	 dc3ONF6uHVtOmqQzQ+M+fBEt2oBGFn7F+GzDMhk29a4RPcXc9R87pRmxXgUJKQoljp
	 3JX6Dppc5Adbu3BdOFyoY8IQNmiYuDxjikG6hueD1F2GqCIzSOiSSENs90SfI0vOib
	 7PytC4qkQFEOA==
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2e96f29884dso8764111fa.0
        for <linux-wireless@vger.kernel.org>; Tue, 04 Jun 2024 03:09:53 -0700 (PDT)
X-Gm-Message-State: AOJu0YxubP946oW5uE1d2o8xxx5dcUGaDHwtV3EcR36vw05xPKiP3FV2
	6PyIPsoeV4MWI0b3XLz8Ji5z668WYkFkmiMf6nLLBpJelJ63woiR4xUzo4t2VTtKZN0cvA6VmDH
	1BZWq3FVaRmV4iEVs6j5e7MB5fDY=
X-Google-Smtp-Source: AGHT+IEi5jXAGaQ4eBOsKfb6zLxYleuEoYCm0ppaJnq9Ilf2pRy9wrm5Ho7uExo0E17dcwwdRDnKL5S02schagHQ5aI=
X-Received: by 2002:a2e:9290:0:b0:2e9:d4fa:1cc with SMTP id
 38308e7fff4ca-2ea951e1b97mr80242811fa.39.1717495791673; Tue, 04 Jun 2024
 03:09:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240603060558.98791-1-pkshih@realtek.com> <20240603060939.99093-1-pkshih@realtek.com>
In-Reply-To: <20240603060939.99093-1-pkshih@realtek.com>
Reply-To: wens@kernel.org
From: Chen-Yu Tsai <wens@kernel.org>
Date: Tue, 4 Jun 2024 18:09:39 +0800
X-Gmail-Original-Message-ID: <CAGb2v64w0hZXsx4V12sSTqv7AUno8NYR+1KXYW41Po68-wZxfQ@mail.gmail.com>
Message-ID: <CAGb2v64w0hZXsx4V12sSTqv7AUno8NYR+1KXYW41Po68-wZxfQ@mail.gmail.com>
Subject: Re: [PATCH 3/4] wireless-regdb: Update regulatory info for Chile (CL)
 on 6GHz
To: Ping-Ke Shih <pkshih@realtek.com>
Cc: linux-wireless@vger.kernel.org, wireless-regdb@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Jun 3, 2024 at 2:09=E2=80=AFPM Ping-Ke Shih <pkshih@realtek.com> wr=
ote:
>
> MINISTRY OF TRANSPORT AND TELECOMMUNICATIONS; UNDERSECRETARY OF
> TELECOMMUNICATIONS announced RESOLUTION 1985 EXEMPT FIXED TECHNICAL
> STANDARD FOR REDUCED RANGE EQUIPMENT. Section j.1) describes access
> equipment, also referred to as AP, must be for exclusive indoor use with
> condition of Maximum EIRP of 30 dBm. User terminal devices that are
> associated with low-power AP equipment must operate at the following powe=
r
> levels of Maximum EIRP of 24 dBm. Devices that use internal batteries may
> operate outdoors, with a maximum average EIRP power of 17 dBm.
>
> [1] https://www.bcn.cl/leychile/navegar?idNorma=3D1109333&idParte=3D98415=
04&idVersion=3D&r_c=3D6
>
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
> ---
>  db.txt | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/db.txt b/db.txt
> index 59d7549ce604..1999086d4694 100644
> --- a/db.txt
> +++ b/db.txt
> @@ -395,11 +395,14 @@ country CI: DFS-FCC
>         (5490 - 5730 @ 160), (24), DFS
>         (5735 - 5835 @ 80), (30)
>
> +# Source:
> +# https://www.bcn.cl/leychile/navegar?idNorma=3D1109333&idParte=3D984150=
4&idVersion=3D&r_c=3D6
>  country CL: DFS-JP
>         (2402 - 2482 @ 40), (20)
>         (5170 - 5250 @ 80), (20), AUTO-BW
>         (5250 - 5330 @ 80), (20), DFS, AUTO-BW
>         (5735 - 5835 @ 80), (20)
> +       (5925 - 6425 @ 320), (30), NO-OUTDOOR

We consider Linux devices to be client or user terminal devices, so this
needs to be reduced to 24 dBm. However, this is further limited by the
spectral density clause, which states a limit of -1 dBm / MHz. Given
the smallest channel is 20 MHz, this gives a new limit of 12 dBm.

This is basically the same as the one for the US.


Thanks
ChenYu

>
>  # Source:
>  # https://wap.miit.gov.cn/cms_files/filemanager/1226211233/attach/20219/=
d125301b13454551b698ff5afa49ca28.pdf
> --
> 2.25.1
>

