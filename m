Return-Path: <linux-wireless+bounces-19473-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 155EAA45921
	for <lists+linux-wireless@lfdr.de>; Wed, 26 Feb 2025 09:58:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A8473AAD12
	for <lists+linux-wireless@lfdr.de>; Wed, 26 Feb 2025 08:58:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C0031E1DF6;
	Wed, 26 Feb 2025 08:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qB0nVSxA"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56841258CC6
	for <linux-wireless@vger.kernel.org>; Wed, 26 Feb 2025 08:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740560312; cv=none; b=DD4RkGVKyEXZDhoALp75KU+AZocW9voFHoybtmBuzIMf3smEgxYG6pPM6zu3NoKyVO8ANwun5wQMBK/8Wt4Td+S3at3P6hX4hAMrnK5IsBEs/vsXElWaqCUEj5NYKvWyORGVzJBfx3jU1dyto6VYylDIqrLNdYiTiomoSJLSp6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740560312; c=relaxed/simple;
	bh=r+d2GDeEhk5nWbfN0eIqGCaqhybLzeYgFAkmXjneBe8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EWzUBM5NwdaZQWZJQiHoKYMNwRhGEJhU5KkCXD8/CUfMCcOcTnoyxS/PzA5FZ4bYQDFlOdi6MKEVvYYp0WVNp2S2kISWBv8PGqgUIyf8ohWGChyCKP+qCda/3iPqjJB4Q7fe05exOYzZeKHtsSugMZzoocbqKHWoe0kxu8Cu6KM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qB0nVSxA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C116BC4CEE9
	for <linux-wireless@vger.kernel.org>; Wed, 26 Feb 2025 08:58:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740560311;
	bh=r+d2GDeEhk5nWbfN0eIqGCaqhybLzeYgFAkmXjneBe8=;
	h=References:In-Reply-To:Reply-To:From:Date:Subject:To:Cc:From;
	b=qB0nVSxA1tmQwga2VQOqFxRsMUekM3hkFMfaQrvHGYM9/x0LqnraFJWriHjkPp0l2
	 cNC8tViPwlNoIhnBHp0k6+kaw5bcRDEGLn64wf0WSqPiqDcICd0/7jls/3ChRTcRGm
	 xTTvEUrlF54Wi2u4/rrg3gYi4zybhSCWiP932CtP6O6gqIdfCBW5Ze6bqviSGHumEQ
	 RVIGtI1TQwq45M7/IGtJhFTy+SMUm6GSDiVCppUX0oEKJL1dOd9qwt3cSuImGltJAU
	 0mh3P8cCT8pTodA6+6fxuFsqYBgPTLFEySqsqOT2Pl+Le7+qVByn/YityVPRrPjheC
	 Z9SY5H6fi4a/w==
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-546237cd3cbso6646596e87.0
        for <linux-wireless@vger.kernel.org>; Wed, 26 Feb 2025 00:58:31 -0800 (PST)
X-Gm-Message-State: AOJu0YxMINENtAVuRmrCD2Y5DGPy6pAB4udv8VAIP8Cao3xdPHV9jJWU
	3l+KYeEx/IaF/Gm9m2lF0BX7gR4EHJPHDuzayALtoIcBSE59AKUJpfYsXDeWZshrIrY6WdjkKOV
	iku/c0dsWWtRbDQWJIBjvVtW/JPs=
X-Google-Smtp-Source: AGHT+IF+5iYiZmdfk3MQsoUCofo2kaSekZRjfw2qLdrcNSedt79i1Hy8VAPwzBKEG496hBcpldV30BYSDaISadXxJn4=
X-Received: by 2002:a05:6512:114d:b0:546:2ea9:6662 with SMTP id
 2adb3069b0e04-54851109c6emr4425914e87.51.1740560310105; Wed, 26 Feb 2025
 00:58:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <000201db8822$98f28da0$cad7a8e0$@gmail.com>
In-Reply-To: <000201db8822$98f28da0$cad7a8e0$@gmail.com>
Reply-To: wens@kernel.org
From: Chen-Yu Tsai <wens@kernel.org>
Date: Wed, 26 Feb 2025 16:58:18 +0800
X-Gmail-Original-Message-ID: <CAGb2v65490c1m3W_1RkxJ-E7Q=3V_K8xqS2jmd6awcOdzWHXzQ@mail.gmail.com>
X-Gm-Features: AQ5f1JooJqS3tNZUNR5r1a1dhMiVLAirpBoNgek75sBI8ivoUWypoas7gORZiNc
Message-ID: <CAGb2v65490c1m3W_1RkxJ-E7Q=3V_K8xqS2jmd6awcOdzWHXzQ@mail.gmail.com>
Subject: Re: wireless-regdb: Allow 6ghz in the US
To: rmandrad@gmail.com
Cc: linux-wireless@vger.kernel.org, wireless-regdb@lists.infradead.org, 
	Dennis Bland <dennis@dbperformance.com>, Ping-Ke Shih <pkshih@realtek.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

CC-ing Dennis, the original submitter, and also Ping-Ke, who has done
a lot of 6 GHz updates, for more information.

On Wed, Feb 26, 2025 at 4:03=E2=80=AFPM <rmandrad@gmail.com> wrote:
>
> Allow 6ghz in the US
>
> https://www.federalregister.gov/documents/2020/05/26/2020-11236/unlicense=
d-u
> se-of-the-6-ghz-band allows the use of 6ghz in the US namely section
> 59 https://www.federalregister.gov/d/2020-11236/p-66 with absolute radiat=
ed
> power of 30 dBm for the 320 megahertz channel

Please don't wrap URLs.

Please see the original submission [1], which explains why the power limit
is so low. Basically, neither the database nor the kernel supports
specifying power spectral density limits, so we can only take the
narrowest bandwidth to calculate the applicable power limit.

[1] https://lore.kernel.org/wireless-regdb/CAPRryQp6j4UKvLZCkMAuQdaxepMBETQ=
UJ1eNULJSh3ZWXC0f5Q@mail.gmail.com/

> based on this remove NO-IR flag and allow 30 dBm max power

The original submission mentioned NO-IR requirements, though I did not
find such wording. Dennis, do you have any ideas?

> Signed-off-by: Rudy Andram <rmandrad@gmail.com>
>
> diff --git a/db.txt b/db.txt
> index 803f1bc..bc2b4fe 100644
> --- a/db.txt
> +++ b/db.txt
> @@ -1953,7 +1953,8 @@ country US: DFS-FCC
>         (5850 - 5895 @ 40), (27), NO-OUTDOOR, AUTO-BW, NO-IR
>         # 6g band
>         #
> https://www.federalregister.gov/documents/2020/05/26/2020-11236/unlicense=
d-u
> se-of-the-6ghz-band
> -       (5925 - 7125 @ 320), (12), NO-OUTDOOR, NO-IR
> +       (5925 - 6425 @ 320), (30), NO-OUTDOOR
> +       (6525 - 6875 @ 320), (30), NO-OUTDOOR

The database entry targets LPI usage instead of standard usage, which
requires the presence of AFC, which is also a requirement that the
database is unable to represent. And under LPI usage, the full 6GHz
band (U-NII-5, 6, 7) is available.


Thanks
ChenYu

>         # 60g band
>         # reference: section IV-D
> https://docs.fcc.gov/public/attachments/FCC-16-89A1.pdf
>         # channels 1-6 EIRP=3D40dBm(43dBm peak)
>
>
>

