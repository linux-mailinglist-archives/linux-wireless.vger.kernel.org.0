Return-Path: <linux-wireless+bounces-19093-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D85FFA392A0
	for <lists+linux-wireless@lfdr.de>; Tue, 18 Feb 2025 06:30:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AB09016A8BE
	for <lists+linux-wireless@lfdr.de>; Tue, 18 Feb 2025 05:30:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AEBB1B0F09;
	Tue, 18 Feb 2025 05:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cqWxarKh"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34D2C1AAE01
	for <linux-wireless@vger.kernel.org>; Tue, 18 Feb 2025 05:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739856609; cv=none; b=rWVPmRaOXKZ5EqJBwrMFVgOIvQgGY1yObcDN6U57WakhPAGi2IAvyWzNLfrwzPs+sfxpLafiRJolSXXNruLX34OXwodzdZR2ByPxCbpPRY817qubr8ZYRf7dPRd4z9914IEm5u+YJXfravLqliMlkjF/eQ4pfW0BUz40qQhnQIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739856609; c=relaxed/simple;
	bh=SRLhRMvGZy9+ksm1deWp4jZ3fd0gE+mMpKcQ0UJAkIM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BCIC9ZyCg5cCjcQ4rurnAw+mAy5xKoVg6DpVD9CUlJDXTwhR4HRU02dj4tV0z4DzW/SzU/eEcnndlPkCJKrSRd8YKzONxoTteAAf4N++7dIwwDBLLk6bOJx6zCBmP9VsNcq6f7CN+pNkb3CG+B8Oi0KDLIc95LA/GrRJ9FownRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cqWxarKh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFC35C4CEE2
	for <linux-wireless@vger.kernel.org>; Tue, 18 Feb 2025 05:30:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739856608;
	bh=SRLhRMvGZy9+ksm1deWp4jZ3fd0gE+mMpKcQ0UJAkIM=;
	h=References:In-Reply-To:Reply-To:From:Date:Subject:To:Cc:From;
	b=cqWxarKhJPBp/RsAzgzFFOSN3FeHYRB6BWTCy8WIXbIbv2Dh/+SwUFCqROBSJbCgd
	 d9zzFKMw6gcFzFtLwvlW6L/Yxk5LkF91vrn6PZ//7NSbvmZ6v38pfcdrPEQDh91y/n
	 jsBgTSCJqQUOxB+85cnswt1bgmUi0B61QImvxx1sY7KIyUWVbA9fGBLg5Tk4ZVAt9I
	 A78YeMO9WrS1xiY9nienjkJCqZe95IRNlFFGP+a9kHJz0v7iwKCSMGxGGzDt5I0fHK
	 wJSVUyYUikzcJfl35Ot1HUG/HjZe0bXaHKwtaAmnWv17xvEByCh/SiJNddLWoSiMNj
	 jKyUWR4inP86w==
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-30761be8fa8so55205491fa.2
        for <linux-wireless@vger.kernel.org>; Mon, 17 Feb 2025 21:30:08 -0800 (PST)
X-Gm-Message-State: AOJu0YxM68/mMGiP+TYr1zaP50J8zhrL6aQOo/yr/0Wjfqbl+9QUFUsR
	04KNrhHANvOrN1Tk40swycHompqJwEpblvWX/1O5pRzf5VD5qHVSEgNVoZJbDt4Zils6p3rX7gZ
	TI89JM/Z0vCI6dIfnhE7ub/AuTBU=
X-Google-Smtp-Source: AGHT+IGjxjNnioiZl84qFq+LDVdB0u0Ed9PGp4NJYT1Sr6MQj/z9h9q+qSimQbuw5rwlezSF/74BT96NwfiQjRJKDbw=
X-Received: by 2002:a2e:7010:0:b0:309:25ce:8b8b with SMTP id
 38308e7fff4ca-30927a42c1cmr35628981fa.4.1739856607076; Mon, 17 Feb 2025
 21:30:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250218025957.13818-1-pkshih@gmail.com>
In-Reply-To: <20250218025957.13818-1-pkshih@gmail.com>
Reply-To: wens@kernel.org
From: Chen-Yu Tsai <wens@kernel.org>
Date: Tue, 18 Feb 2025 13:29:52 +0800
X-Gmail-Original-Message-ID: <CAGb2v66Qev8nQvt54dKDC+Q+rJ5m6+erWO2L4_vSMVqrTe_DRQ@mail.gmail.com>
X-Gm-Features: AWEUYZkZEgvpDeQmCWC4hackSWfOSldOfUQ5KzPGEVw6moEyk4SbA4xKG7JzsCg
Message-ID: <CAGb2v66Qev8nQvt54dKDC+Q+rJ5m6+erWO2L4_vSMVqrTe_DRQ@mail.gmail.com>
Subject: Re: [PATCH] wireless-regdb: Update regulatory rules for Iran (IR) on
 both 2.4 and 5Ghz for 2019
To: Ping-Ke Shih <pkshih@gmail.com>, Johannes Berg <johannes@sipsolutions.net>
Cc: linux-wireless@vger.kernel.org, wireless-regdb@lists.infradead.org, 
	mobin@mobintestserver.ir
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 18, 2025 at 11:00=E2=80=AFAM Ping-Ke Shih <pkshih@gmail.com> wr=
ote:
>
> From: Ping-Ke Shih <pkshih@realtek.com>
>
> Decision No. 4004-01DEC-CRA, 8th Edition - February 2019,
> Radiocommunications and Regulatory Organization.
> General radio license for the use of parts of the frequency bands
> 2400-2483.5 MHz, 5150-5250 MHz, 5350-5250 MHz, 5470-5725 MHz, and
> 5850-5725 MHz in radio access networks. [1]
>
> * 2400 - 2483.5
>   - 100 mW e.i.r.p
>   - 10dBm in every 1Mhz

Should keep a note saying for outdoor only usage, the limit is 4000 mW.

> * 5150 - 5250
>   - 200 mW e.i.r.p
>   - 10dBm/MHz per 1MHz bandwidth or -6dBm/25kHz per 25kHz bandwidth
> * 5250 - 5350
>   - 200 mW e.i.r.p
>   - 10dBm/MHz per 1MHz bandwidth
>   - DFS

For outdoor only usage, the limit is 1000 mW.

Also, for outdoor usage, TPC is required, and there is no provision
for 3 dB power reduction if TPC is not implemented.

So I would mark this band as indoor only for now.

> * 5470 - 5725
>   - 1000 mW e.i.r.p
>   - 17dBm/MHz per 1MHz bandwidth
>   - DFS
>   - If TPC is not used, the maximum radiated e.i.r.p. must be reduced
>     by 3dB.
>   - Outdoor use only
>     (Since NO-INDOOR flag is not supported by current format, don't add
>      this entry.)

There are NO-INDOOR and NO-OUTDOOR flags for the database. The kernel
doesn't have a matching IEEE80211_CHAN_OUTDOOR_ONLY flag though.
Maybe that should be added?

Johannes, what do you think?

> * 5725 - 5850
>   - 4000 mW e.i.r.p
>   - 36dBm in every 500 kHz
>   - DFS
>   - Outdoor use only
>     (Since NO-INDOOR flag is not supported by current format, don't add
>      this entry.)

This band is point to point only. TPC is required without provision for no =
TPC.

> These information is from [4], Mobin Aydinfar shared the official link [1=
]
> (inaccessible from outside of Iran), a mirror version [2] and translated
> version [3].
>
> [1] https://asnad.cra.ir/fa/Public/Documents/Details/73af8590-f065-eb11-9=
68f-0050569b0899
> [2] https://mobintestserver.ir/Iran-2.4Ghz-5Ghz-cra-official-doc.pdf
> [3] https://mobintestserver.ir/Iran-2.4Ghz-5Ghz-cra-official-table.ods
> [4] https://lore.kernel.org/linux-wireless/c9ccf5ba-c091-45c4-9283-970bfa=
4f1afe@mobintestserver.ir/T/#u
>
> Cc: Mobin Aydinfar <mobin@mobintestserver.ir>

Please use "Reported-by" instead, and also add

Closes: https://lore.kernel.org/linux-wireless/c9ccf5ba-c091-45c4-9283-970b=
fa4f1afe@mobintestserver.ir/T/#u


Thanks
ChenYu

> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
> ---
>  db.txt | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
>
> diff --git a/db.txt b/db.txt
> index d56ad32d31c9..0189355dff17 100644
> --- a/db.txt
> +++ b/db.txt
> @@ -934,9 +934,12 @@ country IN:
>         (5470 - 5725 @ 160), (24), DFS
>         (5725 - 5875 @ 80), (30)
>
> -country IR: DFS-JP
> -       (2402 - 2482 @ 40), (20)
> -       (5735 - 5835 @ 80), (30)
> +# Source:
> +# https://asnad.cra.ir/fa/Public/Documents/Details/73af8590-f065-eb11-96=
8f-0050569b0899
> +country IR: DFS-ETSI
> +       (2400 - 2483.5 @ 40), (100 mW)
> +       (5150 - 5250 @ 80), (200 mW)
> +       (5250 - 5350 @ 80), (200 mW), DFS
>
>  # IS as part of CEPT accepted decisions 2005/513/EC (5GHz RLAN, EN 301 8=
93)
>  # and 2006/771/EC (amended by 2008/432/EC, Short-Range Devices, EN 300 4=
40)
> --
> 2.25.1
>

