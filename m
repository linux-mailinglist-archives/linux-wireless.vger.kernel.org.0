Return-Path: <linux-wireless+bounces-9754-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 58F1C91DAF5
	for <lists+linux-wireless@lfdr.de>; Mon,  1 Jul 2024 11:02:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0D3C528967C
	for <lists+linux-wireless@lfdr.de>; Mon,  1 Jul 2024 09:02:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AE81127B62;
	Mon,  1 Jul 2024 09:01:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZPD8siRA"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04C5A85C5E
	for <linux-wireless@vger.kernel.org>; Mon,  1 Jul 2024 09:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719824465; cv=none; b=ZQRWR684auKIAQzmUGicgbZYJmG8vYrLSN3+FUEvV1HfYo9uR73lOW3WpK+mCIc4tHJ7g3k++J+3iG+yo8FZO1rQf90v+pryMaS/cODlV7jEJArQDd0P9pfHQ2/O5oSzW/PnMw8swy61gLSb+PCHR5uWzSYgDnW5D5OUzVISsVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719824465; c=relaxed/simple;
	bh=Kxtbl8cDBMjbTL4kGU6mhOa8DAjjdTsa58adBx+9QrI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qjT+XXeI4KKiW8kvrfXElLgDfe5QYcZ1RvlaHRlypxFkoHWCqSAO5ZU0MMRsDw7w2QGPA/L0suXqRabGeRMA05Fi0xO7ITyAKxIkWN5D+378esA/pwTVgs6ZD85e6bIEiOTGQEr24NlsmrQ3roLyYNKZf/QvX90H8bgz7z4cmBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZPD8siRA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9270FC116B1
	for <linux-wireless@vger.kernel.org>; Mon,  1 Jul 2024 09:01:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719824464;
	bh=Kxtbl8cDBMjbTL4kGU6mhOa8DAjjdTsa58adBx+9QrI=;
	h=References:In-Reply-To:Reply-To:From:Date:Subject:To:Cc:From;
	b=ZPD8siRAHjCfvmjv+SUymR5IIkexvspoBZFRuqSglAVYrgykuzgnhbf1fct1qM2Od
	 V3/txEUqsvAZTpvS8k3xLnb563/NoMNeZffpN/4sN2FsUqj1Y+fPuTi8oH/Bb3EM9K
	 n1TEX52fz7O6RrEgRn8fOjoWJT8iE+te+UmzU6dHSEMeYJSgz8r+3jGM3v15v6nDno
	 j5T5F6jXH4yNshWFQKEZGoFTCU+RWXBDtVRLJGxyMNC53oEt9rztaxESLVjWglWxKz
	 gSk/t2baUDZXWXCU5kSlsbYxRp7Z8ZEs9+xu05klZh8tCSp7Nvph77TH2/hyDtD7rk
	 O9qYY45umy4Rw==
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2ebeefb9a7fso31895771fa.0
        for <linux-wireless@vger.kernel.org>; Mon, 01 Jul 2024 02:01:04 -0700 (PDT)
X-Gm-Message-State: AOJu0Ywj67mYnFIkCRx2OWdoODiyy1D9QOVNVcyRuWLSTa9fDkVraHHQ
	Hlpj73WC5TzlKvHPDwJQNlUC4UNrAlvkUGsmdtC6YJl7guG9I35le3Lhg0BXl417PuK9D7+fgtQ
	RbWQh3LNUhW13cQi0wEwjVUhg40U=
X-Google-Smtp-Source: AGHT+IFH82fIrft+vPFRrkFUdR5HcTeNXvbtf44v8BJ+4vFHVPTjhXrL5rhK4W30aAYSi9w+IsRHYPbouJLD7S1uYu8=
X-Received: by 2002:a05:651c:2229:b0:2ec:637a:c212 with SMTP id
 38308e7fff4ca-2ee5e6e7256mr36247571fa.39.1719824462901; Mon, 01 Jul 2024
 02:01:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240624025623.6021-1-pkshih@realtek.com> <20240624025623.6021-3-pkshih@realtek.com>
In-Reply-To: <20240624025623.6021-3-pkshih@realtek.com>
Reply-To: wens@kernel.org
From: Chen-Yu Tsai <wens@kernel.org>
Date: Mon, 1 Jul 2024 17:00:50 +0800
X-Gmail-Original-Message-ID: <CAGb2v66WBG6FjXCvE5+sUv1YXfMxLHiQPH-st_wzCJH8XDF=mQ@mail.gmail.com>
Message-ID: <CAGb2v66WBG6FjXCvE5+sUv1YXfMxLHiQPH-st_wzCJH8XDF=mQ@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] wireless-regdb: Update regulatory info for Kenya
 (KE) for 2022
To: Ping-Ke Shih <pkshih@realtek.com>
Cc: linux-wireless@vger.kernel.org, wireless-regdb@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 24, 2024 at 10:56=E2=80=AFAM Ping-Ke Shih <pkshih@realtek.com> =
wrote:
>
> Communications of Authority of Kenya issued GUIDELINES ON THE USE OF
> RADIOFREQUENCY SPECTRUM BY SHORT RANGE DEVICES on JUNE 2022 [1].
> The section 5.8. covers frequency bands and technical parameters for
> non-specific short range applications and wireless access systems.
>
>  - 2400-2483.5 MHz: 2W e.i.r.p.
>  - 5150-5350 MHz: 200mW; max e.i.r.p. density of 10mW/MHz
>                   (ETSI: -6 dBm to be 17 dBm)
>  - 5470-5725 MHz: 250mW; Max mean e.i.r.p. of 1W &
>                   Max mean e.i.r.p. density of 50mW /MHz
>                   (ETSI: -6 dBm to be 18 dBm)

The database documents e.i.r.p values. So it should be 1W - 6 dBm.
The -6 dBm interpretation should be fully documented.

    1W (30 dBm) - 6 dBm =3D 24 dBm

This is the same as the "Limit for RF output power at the lowest power
level (PL) of the TPC range" for this particular range. See below.

>  - 5725-5875 MHz: 23 dBm/MHz; Mean e.i.r.p. of 2W in any 10 MHz band
>                   (ETSI: -6 dBm to be 17 dBm)

The original rule was probably wrong or out of date. Please update the
numbers together. The regulations say:

   Mean e.i.r.p. spectral density of 23 dBm/MHz
   Mean e.i.r.p. of 2W in any 10 MHz band

WiFi channels are at least 20 MHz. That means the nominal limit is
4W / 36 dBm with TPC. This is the same as ETSI EN 302 502. This is
the correct ETSI reference for the 5.8 GHz range. This also says

    The FWA device shall have the capability to reduce the operating
    mean EIRP level to a level not exceeding 24 dBm for ChS =3D 20 MHz
    and 21 dBm for ChS =3D 10 MHz.

And since neither this database nor Linux supports specifying TPC,
we could just reduce the power limit to 24 dBm so that the device
always conforms. This is an interpretation of the rule, and should
be properly documented, saying that this is derived from the lowest
power setting under TPC.


Thanks
ChenYu


>  - 5925-6425 MHz:
>    * LPI: 23 dBm (200 mW)
>           Mean e.i.r.p. density for in-band emissions 10 dBm/MHz
>           Indoor only
>    * VLP: 14 dBm (25 mW)
>           Mean e.i.r.p. density for in-band emissions 1 dBm/MHz
>           Indoor and outdoor use
>
> Reference ETSI EN 301 893 [2], for the 5 GHz and 5.8 GHz ranges, TPC is
> required. being able to reduce TX power by up to 6 dB. (Add this rule
> followed by [1] with annotation "ETSI:")
>
> [1] https://www.ca.go.ke/sites/default/files/2023-06/Guidelines-on-the-Us=
e-of-Radiofrequency-Spectrum-by-Short-Range-Devices-2022.pdf
> [2] https://www.etsi.org/deliver/etsi_en/301800_301899/301893/02.01.01_60=
/en_301893v020101p.pdf
>
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
> ---
> v2:
>   - align freq range of reference
>   - use power unit as reference
>   - -6dBm for 5 GHz and 5.8 GHz ranges
> ---
>  db.txt | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)
>
> diff --git a/db.txt b/db.txt
> index 60343a745ecf..648530192b75 100644
> --- a/db.txt
> +++ b/db.txt
> @@ -984,11 +984,15 @@ country JP: DFS-JP
>         # ref: http://www.arib.or.jp/english/html/overview/doc/1-STD-T74v=
1_1.pdf
>         (57000 - 66000 @ 2160), (10 mW)
>
> +# Source:
> +# https://www.ca.go.ke/sites/default/files/2023-06/Guidelines-on-the-Use=
-of-Radiofrequency-Spectrum-by-Short-Range-Devices-2022.pdf
> +# ETSI EN 301 893: https://www.etsi.org/deliver/etsi_en/301800_301899/30=
1893/02.01.01_60/en_301893v020101p.pdf
>  country KE: DFS-JP
> -       (2402 - 2482 @ 40), (20)
> -       (5170 - 5250 @ 80), (23)
> -       (5490 - 5570 @ 80), (30), DFS
> -       (5735 - 5775 @ 40), (23)
> +       (2400 - 2483.5 @ 40), (2000 mW)
> +       (5150 - 5350 @ 80), (17), DFS
> +       (5470 - 5725 @ 80), (18), DFS
> +       (5725 - 5875 @ 40), (17), DFS
> +       (5925 - 6425 @ 320), (23), NO-OUTDOOR
>
>  country KH: DFS-ETSI
>         (2402 - 2482 @ 40), (20)
> --
> 2.25.1
>

