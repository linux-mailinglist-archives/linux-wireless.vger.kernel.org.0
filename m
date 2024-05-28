Return-Path: <linux-wireless+bounces-8203-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 11F008D1DBC
	for <lists+linux-wireless@lfdr.de>; Tue, 28 May 2024 15:57:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BBD8F1F23F62
	for <lists+linux-wireless@lfdr.de>; Tue, 28 May 2024 13:57:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B98891DFEB;
	Tue, 28 May 2024 13:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a+qJ7OLG"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9461816DEC7
	for <linux-wireless@vger.kernel.org>; Tue, 28 May 2024 13:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716904523; cv=none; b=uqUZHHkZezoqzR2Lskp3rGyqIhJL1QpnXnmTPO+ioC4ilQlGFQYH0QO8QM3lvrA3SZ2AtI2Cr9Mxa9epSloDTwsGjJ2b8iqwKcGS213AU43/FHeIuTZoTLo+tRX4Y+wNUSEpjZS9jFrcmaJSPyLDOZxbFF++Ovsu/shTmXrThbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716904523; c=relaxed/simple;
	bh=J1mW5ycXKOE6GEGuTYzYdR2QfsgfqB1HyPbDjPgL1b0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FeV9Gf+pxWBc0ia4ZLyNL8AuLGRGNki1G5z2FTbKz8mD+2+aYH6wvm3BT6lmcAb5o6w8hFGzFQm+tiPoDzjAotyrSXJBo3VD5+NymSZ2VxqMmJ/UerobYZRRgadN+QanbwmREJIxBzstGtguZUM1T35CrTSJYzXEjKh9bKQW6K4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a+qJ7OLG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1ED34C32786
	for <linux-wireless@vger.kernel.org>; Tue, 28 May 2024 13:55:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716904523;
	bh=J1mW5ycXKOE6GEGuTYzYdR2QfsgfqB1HyPbDjPgL1b0=;
	h=References:In-Reply-To:Reply-To:From:Date:Subject:To:Cc:From;
	b=a+qJ7OLGeq9M8TB0BrrLzqKbeWdlX8G6SPY+hVtd7iTSzPFCQ9LAx34LwYrpYbwNh
	 oHBY8r2xAqNfH7IPRjlMzVbpZNmlI/XFiQtqRlpuKTTl40CfXohc+Tfrk4rwQr75iz
	 JNrj1XQ6tGci0fN70qgQcM6T3HBdDlqTrfgj6u9IW8RV9e/aoyUOwNIpTqV7pPJcmx
	 qgCfQFKIMaNnOz4orIoq98j0s284oiPtUT0sGOxYRpq+xxnXyVuwSvy0zmfvYtmcue
	 eVbTcHN7p1XK9yoTJqN+KpAeyaFvigUq+EEX5zA1FknNgpSmk0dxnArF4GmBvZJr5p
	 kWc7nJrRZ217w==
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2e95a1f9c53so10687151fa.0
        for <linux-wireless@vger.kernel.org>; Tue, 28 May 2024 06:55:23 -0700 (PDT)
X-Gm-Message-State: AOJu0YycO6C8vDucayVQxpRYRSQFyN2jXnK4BVMwGpo5xxflPkZHrpLm
	jroRbgkKcD4gfelXy1vZLyfSgXbp9jJz8ZMhIA7nNM/O+TQTO7cxi0QYuFIFxUl4ks3Froy2Fj/
	r5Nv9HeX1FZ4vfpUZPHwEzq+G9bw=
X-Google-Smtp-Source: AGHT+IEjHFv8zQHfB9GSG+wWe2e2/eN+jUfyeLzeHKoAPa1YTJbaz7btyqhL8Sd5iBvjCBX0kKj6Vhj7AjwwNJ4Ayrs=
X-Received: by 2002:a2e:a289:0:b0:2e4:7996:f9f0 with SMTP id
 38308e7fff4ca-2e95b0c0f7dmr70366331fa.17.1716904521470; Tue, 28 May 2024
 06:55:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240522062835.69628-1-pkshih@realtek.com> <20240522062946.69832-1-pkshih@realtek.com>
In-Reply-To: <20240522062946.69832-1-pkshih@realtek.com>
Reply-To: wens@kernel.org
From: Chen-Yu Tsai <wens@kernel.org>
Date: Tue, 28 May 2024 21:55:09 +0800
X-Gmail-Original-Message-ID: <CAGb2v65zyPyeE+=hJSPEVLmsSOHimMK2vWVxS5kQ6FzRrWTMYw@mail.gmail.com>
Message-ID: <CAGb2v65zyPyeE+=hJSPEVLmsSOHimMK2vWVxS5kQ6FzRrWTMYw@mail.gmail.com>
Subject: Re: [PATCH 4/4] wireless-regdb: Update regulatory info for Thailand
 (TH) on 6GHz
To: Ping-Ke Shih <pkshih@realtek.com>
Cc: linux-wireless@vger.kernel.org, wireless-regdb@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 22, 2024 at 2:30=E2=80=AFPM Ping-Ke Shih <pkshih@realtek.com> w=
rote:
>
> The Broadcasting Commission Television business and the National
> Telecommunications Commission announced Technical standards for
> telecommunications equipment and equipment for radiocommunication equipme=
nt
> that uses the frequency 5.925 - 6.425 GHz [2], which section 2.1 describe=
s
> e.i.r.p. (Equivalent Isotropically Radiated Power) is 250mW and 25mW for
> indoor and indoor/outdoor respectively.
>
> [1] https://ratchakitcha.soc.go.th/documents/140D100S0000000004000.pdf
> [2] https://ratchakitcha.soc.go.th/documents/140D100S0000000004200.pdf
> [3] https://ratchakitcha.soc.go.th/documents/140D100S0000000004300.pdf
>
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
> ---
>  db.txt | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/db.txt b/db.txt
> index 022ecb3719b6..c7008e23b7ca 100644
> --- a/db.txt
> +++ b/db.txt
> @@ -1702,12 +1702,17 @@ country TG: DFS-ETSI
>         (5250 - 5330 @ 40), (20), DFS
>         (5490 - 5710 @ 40), (27), DFS
>
> +# Source:
> +# https://ratchakitcha.soc.go.th/documents/140D100S0000000004000.pdf
> +# https://ratchakitcha.soc.go.th/documents/140D100S0000000004200.pdf
> +# https://ratchakitcha.soc.go.th/documents/140D100S0000000004300.pdf
>  country TH: DFS-FCC
>         (2402 - 2482 @ 40), (20)
>         (5170 - 5250 @ 80), (17), AUTO-BW
>         (5250 - 5330 @ 80), (24), DFS, AUTO-BW
>         (5490 - 5730 @ 160), (24), DFS
>         (5735 - 5835 @ 80), (30)
> +       (5925 - 6425 @ 320), (25 mW)

Other entries with different power limits for indoor and outdoor usage
seem to favor higher power for indoor-only usage. Any reason to go the
other way?


ChenYu

>
>  country TN: DFS-ETSI
>         (2402 - 2482 @ 40), (20)
> --
> 2.25.1
>

