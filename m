Return-Path: <linux-wireless+bounces-18831-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 475BEA32166
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Feb 2025 09:45:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE0593A361B
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Feb 2025 08:45:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9DA61FBCA0;
	Wed, 12 Feb 2025 08:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="khFfbe7e"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 856D61E492D
	for <linux-wireless@vger.kernel.org>; Wed, 12 Feb 2025 08:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739349950; cv=none; b=eF5q1+dg6EAuQyCZrrLEQgpol5orhVVjY1/fiJ/BIh/7F/0NpnWsjeL0qDGdGMLStV/o45Qj4cGkEPQGntFISUTocTymKbQBidwQPa7rksarClmByWY+J3+/gpVeQ6rCXw7cb6FJs6/2ZLLZIlj8Rc4yn2XZ10RzVquqJFo8708=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739349950; c=relaxed/simple;
	bh=xC6HxHdkEPHFr59/fdDLv9M7CWv7vAjy/mGMAbUZ0aI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qfbrsHWfG4Qk6wcQr3LGMva9H6n4gglD+Vmu0yLT6wN6vqR5rVEcc63VRCb4L3nw0FwY+Vs8dkWuH6aJwktyw3+YE6xpW5Dz5M8okC7cuds9iV+GKcx7MrRDiQvIgv6aUCT6BWRHGafa/YEyxE3vG4QwuUSj/yPJ5LbklqdOifo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=khFfbe7e; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAC74C4CEE2
	for <linux-wireless@vger.kernel.org>; Wed, 12 Feb 2025 08:45:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739349949;
	bh=xC6HxHdkEPHFr59/fdDLv9M7CWv7vAjy/mGMAbUZ0aI=;
	h=References:In-Reply-To:Reply-To:From:Date:Subject:To:Cc:From;
	b=khFfbe7eQMwfAyLHpVmgm0Uft1zCNQGnl9kbLadu46/iBlkFERBYZ7PjREkLaFK5Y
	 NrM58TcjPBrJlIWlQeJh1uyTrNkAmzzG0LaALLl3BFVr9SY154acufkzXOMshq+qFm
	 D/9GWnR9Lr40OHFSLF/jyuXB+uNQER5zXOar3/trgS4TvK9ch0VC5Kz5oPoId234j1
	 aqA7zlWE9aGECFQSI8KoCh/i+BRhuL8IIkpzazkgtZS7E02gEVi4694Epl9zWv07ia
	 XVJWTg9dAp7L32Vr1BF4fUqYoUZMX2Lt58lOIH35zwyKxUf6JcLqz0afVA9hvMJZ1Z
	 qPr0D1GpXsyow==
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-30797730cbdso63617741fa.3
        for <linux-wireless@vger.kernel.org>; Wed, 12 Feb 2025 00:45:49 -0800 (PST)
X-Gm-Message-State: AOJu0Yx4JkOgD89f0CUZsdKdT5Cv8fgN9JsQuBo7mX6/dKGC2bgUk4Yq
	97rwPtv0hGIUimF8Zm7tlamdWa6tSfB96FJP97UV1+sGNnDnmTrclKvi5NxVNDB1NEFKpCqQO8C
	4fx4yXoHGg34cqXo8w75lt/TUenU=
X-Google-Smtp-Source: AGHT+IH4WY0W9KzU5hyyDWjv55uObNQV1spnbfNAHGpzPF3Xm65Zd7KHcxkQZnT2bMW+UXWBkZb2shCtsO255KVlwfo=
X-Received: by 2002:a2e:be86:0:b0:306:124c:69d5 with SMTP id
 38308e7fff4ca-309037615d5mr9181071fa.34.1739349948207; Wed, 12 Feb 2025
 00:45:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2968514.e9J7NaK4W3@nakatomi>
In-Reply-To: <2968514.e9J7NaK4W3@nakatomi>
Reply-To: wens@kernel.org
From: Chen-Yu Tsai <wens@kernel.org>
Date: Wed, 12 Feb 2025 16:45:35 +0800
X-Gmail-Original-Message-ID: <CAGb2v67XQNwJErQF5DSCPQ02csf0nUxQDbu93Djvd0GuK7Pitw@mail.gmail.com>
X-Gm-Features: AWEUYZnuSgde1dSGNt_Q1_PiOiu61VtQVb7pOMaywxHuWhUdNP-5hRKiiO_B7MY
Message-ID: <CAGb2v67XQNwJErQF5DSCPQ02csf0nUxQDbu93Djvd0GuK7Pitw@mail.gmail.com>
Subject: Re: wireless-regdb: Update regulatory rules for Estonia (EE) on 5GHz
To: Veronika Baranova <desu@rainwalker.ee>
Cc: linux-wireless@vger.kernel.org, wireless-regdb@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Dec 24, 2024 at 11:38=E2=80=AFPM Veronika Baranova <desu@rainwalker=
.ee> wrote:
>
> Hello,
>
> The current values in the database seems to be out of date for the range =
5470
> - 5725, the max power should be 1W instead of 500mW. And 200 mW in 5250 -=
 5350
> MHz. Also, V-band is permitted up to 71GHz.

Sorry for the late reply, and thank you for providing this information.

Your email isn't in a valid patch format. Could you perhaps use git to
format it as a patch and have the message above and links below be
part of the commit message? It should also have your Signed-off-by.

Alternatively, if you don't feel like doing it, I will create a patch
based on your email and diff. I would still need your Signed-off-by,
which you can give by simply replying here.

> diff --git a/db.txt b/db.txt
> index e282e3b..2ada200 100644
> --- a/db.txt
> +++ b/db.txt
> @@ -618,15 +618,15 @@ country EC: DFS-FCC
>  # EE: https://www.itu.int/ITU-D/study_groups/SGP_1998-2002/JGRES09/pdf/
> estonia.pdf
>  country EE: DFS-ETSI
>         (2400 - 2483.5 @ 40), (100 mW)
> -       (5150 - 5250 @ 80), (200 mW), NO-OUTDOOR, AUTO-BW, wmmrule=3DETSI
> -       (5250 - 5350 @ 80), (100 mW), NO-OUTDOOR, DFS, AUTO-BW, wmmrule=
=3DETSI
> -       (5470 - 5725 @ 160), (500 mW), DFS, wmmrule=3DETSI
> +       (5150 - 5250 @ 160), (200 mW), NO-OUTDOOR, AUTO-BW, wmmrule=3DETS=
I
> +       (5250 - 5350 @ 160), (200 mW), NO-OUTDOOR, DFS, AUTO-BW, wmmrule=
=3DETSI

This is actually invalid. The maximum channel width cannot exceed the
band's width. Previously our database tool allowed it but the kernel
did not, causing the kernel to fail to load the database. The tool
was recently "fixed" to disallow this as well. So this needs to be 80 MHz.

> +       (5470 - 5725 @ 160), (1000 mW), DFS, wmmrule=3DETSI

The links you provided mention that the 5250-5350 and 5470-5725 bands
require TPC. Unfortunately neither the kernel nor this database supports
this. We have worked around this by lowering the power limits of these
bands by 3 dBm, as specified by EN 301 893.


Thanks
ChenYu

>         # short range devices (ETSI EN 300 440-1)
>         (5725 - 5875 @ 80), (25 mW)
>         # 6 GHz band
>         (5945 - 6425 @ 160), (23), NO-OUTDOOR, wmmrule=3DETSI
>         # 60 GHz band channels 1-4 (ETSI EN 302 567)
> -       (57000 - 66000 @ 2160), (40)
> +       (57000 - 71000 @ 2160), (40)
>
>
> Related links from Estonian Consumer Protection and Technical Regulatory
> Authority:
> https://www.ttja.ee/uudised/ttja-ja-keskkonnaagentuur-teevad-koostood-et-=
peatada-wi-fi-haireid-riiklikes-ilmaradarites [20.02.2023, in Estonian]
> https://www.ttja.ee/eraklient/side-ja-meediateenused/raadioside/wifi-sead=
mete-kasutus [in Estonian]
> https://www.riigiteataja.ee/aktilisa/1170/5202/4018/MKM_m15_Lisa6.pdf [in
> Estonian]
> https://www.ttja.ee/ru/chastnoe-lico/svyaz-i-media-uslugi/radiosvyaz/
> radiooborudovanie [in Russian]
>
>
>

