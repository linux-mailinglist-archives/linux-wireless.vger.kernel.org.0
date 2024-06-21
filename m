Return-Path: <linux-wireless+bounces-9416-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A2ED911E6B
	for <lists+linux-wireless@lfdr.de>; Fri, 21 Jun 2024 10:18:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C9F5D281690
	for <lists+linux-wireless@lfdr.de>; Fri, 21 Jun 2024 08:17:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8E1383CDA;
	Fri, 21 Jun 2024 08:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PKgHlwL/"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A400A155C82
	for <linux-wireless@vger.kernel.org>; Fri, 21 Jun 2024 08:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718957816; cv=none; b=YJnQNkqQciFjDdVjuHqa1SJsgHZOoVf34bzt+iCo3cYkgab1VLtlcZeKR2Wzvu72Hlp3gev9ghN9ZwPVP9nUlwsvs41vXmyO2DhmYNTSvYmoKNUhDCcpOTvFi427Vc5OklPrUOltXYDwdirBP6HF5PCzWnFSeeiFo8qXj1QGMP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718957816; c=relaxed/simple;
	bh=EwpLKs93OwUsfS5SOLBq7fPsW+vKaPaOTW+HAoC6xnw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZY32KYkoMaBToBbvDkuUAos5JQ5BL5W0d4noEvjrvY+lLvpjGXMYG5qbrNad0aOuszwOoJLm0W9QqUGjp8r04hScGmOZ1DfMInmeaxzAEQ0EXAuPBL4N4obsNoZy+vcMz8xPLzHmakptbBzFrqsXvDRTg1QywXdzJ53DK2zo15U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PKgHlwL/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C911C4AF07
	for <linux-wireless@vger.kernel.org>; Fri, 21 Jun 2024 08:16:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718957816;
	bh=EwpLKs93OwUsfS5SOLBq7fPsW+vKaPaOTW+HAoC6xnw=;
	h=References:In-Reply-To:Reply-To:From:Date:Subject:To:Cc:From;
	b=PKgHlwL/NhX6pNRYgFl0594+QzAdQedJefqff1G60F/h2xBVOKTRgGTezvGhna0le
	 WzhkpnkOy3l1kLDBAPrxjzklVYu7uiRu3uf16gjJ5wYHneGw9KjHT/IqCYolVSmSIh
	 MXWq1jh/mjD/oK/fSo44LvF9oFRl9R8ZnjnXiGD+co1qYK+LyxKYFehytQaD/gXSPu
	 JUpBzOWBMwXs+EvFRxkTzWWpG7M3LEt4WLWV+y5eK0iVUa2MVG1GPWeToVCAkgGJE4
	 m+rvBdTEdhSHUzEW9zCJ8uqjCwTJxoCGO3cfunfx+io+FRUN9pWOtpxLxZTg78JWal
	 hbmvJS6tzFzPw==
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2ebdfe26217so15477251fa.2
        for <linux-wireless@vger.kernel.org>; Fri, 21 Jun 2024 01:16:56 -0700 (PDT)
X-Gm-Message-State: AOJu0YxbTAMy6jEjdpTNvSfotZYmX2ySdyZ2zaB0JZKK6mtztPTwmBAE
	buDEh29H//h9R8jtP1AgonpMZoPce7P5iKHUr79mq6cRwNP2ZDJr+dXmE9vkaUniS/dtY4kagzk
	dwz9hPFdEexNUqcIaFk3SE3lYRCY=
X-Google-Smtp-Source: AGHT+IHxmYfAfMJYDDiU+wXkFnpXJR2EvbgbYpzz/GrNW12w+YAqtYubNubax9azFUOM3EC+9XHT/DS5IwgcgIsvz50=
X-Received: by 2002:a2e:3516:0:b0:2ec:f68:51e0 with SMTP id
 38308e7fff4ca-2ec3cff8ee1mr42474881fa.44.1718957814491; Fri, 21 Jun 2024
 01:16:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240621052205.28925-1-pkshih@realtek.com> <20240621052205.28925-2-pkshih@realtek.com>
In-Reply-To: <20240621052205.28925-2-pkshih@realtek.com>
Reply-To: wens@kernel.org
From: Chen-Yu Tsai <wens@kernel.org>
Date: Fri, 21 Jun 2024 16:16:42 +0800
X-Gmail-Original-Message-ID: <CAGb2v66m4BcEQUd4NxzVGADhwLdzW5=z4EGCqDgjqCY3YFTFBw@mail.gmail.com>
Message-ID: <CAGb2v66m4BcEQUd4NxzVGADhwLdzW5=z4EGCqDgjqCY3YFTFBw@mail.gmail.com>
Subject: Re: [PATCH 2/6] wireless-regdb: Update regulatory info for
 Liechtenstein (LI) on 6GHz
To: Ping-Ke Shih <pkshih@realtek.com>
Cc: linux-wireless@vger.kernel.org, wireless-regdb@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 21, 2024 at 1:22=E2=80=AFPM Ping-Ke Shih <pkshih@realtek.com> w=
rote:
>
> CEPT ECC/DEC/(20)01 of 20 November 2020 on the harmonised use of the
> frequency band 5945-6425 MHz for Wireless Access Systems including Radio
> Local Area Networks (WAS/RLAN), which [1] defines
>
>  - LOW POWER INDOOR (LPI) DEVICES
>    * Restricted to indoor use only
>    * Maximum mean e.i.r.p. 23 dBm
>    * Maximum mean e.i.r.p. density 10 dBm/MHz
>
>  - VERY LOW POWER (VLP) WAS/RLAN DEVICES
>    * Indoors and outdoors; Use on drones is prohibited
>    * Maximum mean e.i.r.p. 14 dBm
>    * Maximum mean e.i.r.p. density 1 dBm/MHz
>
> Liechtenstein, Frequency Allocation Plan (FAP) and Specific Assignments [=
2]
> note references of 5945 - 6425 MHz on Wideband data transmission systems:
>  - RIR1010-11,

This is the regional regulatory rule, which is what the database follows.
Please add a link in the commit message and in the database to
https://www.ofcomnet.ch/api/rir/1010/11

>  - ECC/DEC/(20)01

This is [1]. Please add the reference.

>  - EC Decision (EU) 2021/1067 on WAS/RLANs.

Please add a link.

Thanks
ChenYu


>
> [1] https://docdb.cept.org/download/1448
> [2] https://archiv.llv.li/files/ak/pdf-llv-ak-frequenzzuweisungsplan.pdf
>
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
> ---
>  db.txt | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/db.txt b/db.txt
> index 7b34fe2d8660..e10c3fc752e9 100644
> --- a/db.txt
> +++ b/db.txt
> @@ -1071,6 +1071,7 @@ country LC: DFS-ETSI
>  # LI: https://www.ofcomnet.ch/api/rir/1010/04
>  # LI: https://www.ofcomnet.ch/api/rir/1008/12
>  # LI: https://www.ofcomnet.ch/#/fatTable
> +# CEPT ECC Decision (20)01 for 6GHz: https://docdb.cept.org/download/144=
8
>  country LI: DFS-ETSI
>         (2400 - 2483.5 @ 40), (100 mW)
>         (5150 - 5250 @ 80), (200 mW), NO-OUTDOOR, AUTO-BW, wmmrule=3DETSI
> @@ -1078,6 +1079,7 @@ country LI: DFS-ETSI
>         (5470 - 5725 @ 160), (500 mW), DFS, wmmrule=3DETSI
>         # short range devices (ETSI EN 300 440-1)
>         (5725 - 5875 @ 80), (25 mW)
> +       (5945 - 6425 @ 320), (23), NO-OUTDOOR
>         # 60 GHz band channels 1-4 (ETSI EN 302 567)
>         (57000 - 66000 @ 2160), (40)
>
> --
> 2.25.1
>

