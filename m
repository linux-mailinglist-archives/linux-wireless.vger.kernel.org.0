Return-Path: <linux-wireless+bounces-18830-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 03596A32116
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Feb 2025 09:28:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7DE01165B7B
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Feb 2025 08:28:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 256612054EC;
	Wed, 12 Feb 2025 08:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jf5N4oWn"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3AE12054E0
	for <linux-wireless@vger.kernel.org>; Wed, 12 Feb 2025 08:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739348915; cv=none; b=PizMhN+V3X+mqcj0Y2BoW8IzBhs1XsD7+NZ5E/8rfqylrIoi+VXNwLa3KIWbH0ZkCTk5cZRGDYUJjC9xAyJ6N96kqxrnSF7rwR5TQOK0rAbU/yH3oatuv+ncQcQKIns5ztyniVmpXa2G+ZeHEEHdheAS7mOCbEX0oe4+zpj4vxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739348915; c=relaxed/simple;
	bh=du2ZDFxOedwumpbXAyf8Sl3rhnF49lZYu/yjJloD6Nc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PCf3wfhNUBosGImVFrcLBbRgZGvFtvVzqFyM2dBucaghQhAxft7YkbIlZgTDHKX8gMubRiD5cTIUtMiuJx3Yj4LXgcik4CrIbdA0H9BzMelomI1TDvpvoRK8epuxe0Q/N5KetnSuh5SJ+6b5nOOx0m7mSPpEc79VCwXGIJGKFes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jf5N4oWn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73625C4CEDF
	for <linux-wireless@vger.kernel.org>; Wed, 12 Feb 2025 08:28:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739348913;
	bh=du2ZDFxOedwumpbXAyf8Sl3rhnF49lZYu/yjJloD6Nc=;
	h=References:In-Reply-To:Reply-To:From:Date:Subject:To:Cc:From;
	b=Jf5N4oWnAA999TfLN+35KTEltBCNSRFS5AitvKjt82xXIMGEZgRXkLqfl+WoNnteu
	 iDc1jwE9Z+PvoIZeGRYbWpnNpJ5f3iem86gfZPXSqHMl+37Pu9dGMu7fWQRGl+dq1O
	 Id7AHea2AfwODmAEoWGv5tPZKhGVLVCx3wEGWR0CsBrBrq7xOSgWgMOmu2vJD7vHsD
	 pgA2GpUXXGH2aTBbE7cf0PjPBvEIo+M047FKuUkMx7PBYwMASsKAd5vspq+RCzs9NE
	 0i6Afq4BFDl6kB/OYOle8cuGtA8zkWQH5VFhhSNkZtl/G/u1QGiiP9O43sfL2DgpzY
	 uoU1hOcDREvDg==
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-543e49a10f5so6802475e87.1
        for <linux-wireless@vger.kernel.org>; Wed, 12 Feb 2025 00:28:33 -0800 (PST)
X-Gm-Message-State: AOJu0Yw+aWObK4v1ArGUE1x+/Afd09aULM8YCgEZ+Lce1opvQMwrqOo4
	8xsLTTYy329qsJNkuDr+rM3qSQkfUJOFtkbZBOH3Ei1SaLneLhOQlAyK4xC5N6qnNVBYGc5lhjp
	OksmvWYTh3FJlSB3Qk802Pspcowk=
X-Google-Smtp-Source: AGHT+IGFnrrPdBHO44+WsFKu0eAfeRRvAyPKO/jrBqpD/aV+EkOMQUklikciR1AXPT5iFQudplZn32CVm6q9Xw5lC7A=
X-Received: by 2002:a05:6512:3b23:b0:545:aaf:13fd with SMTP id
 2adb3069b0e04-54518166e24mr576754e87.51.1739348911789; Wed, 12 Feb 2025
 00:28:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241210030037.6380-1-pkshih@gmail.com>
In-Reply-To: <20241210030037.6380-1-pkshih@gmail.com>
Reply-To: wens@kernel.org
From: Chen-Yu Tsai <wens@kernel.org>
Date: Wed, 12 Feb 2025 16:28:18 +0800
X-Gmail-Original-Message-ID: <CAGb2v65PTLYoHeTFa80EB51_WfzJ+LBAhn=+Kn9hsxdtuR-dnQ@mail.gmail.com>
X-Gm-Features: AWEUYZkXbu7T2cJfoMw6Z-fewxG8wK35p2KNEy6lHBsdTLLoXZ-gZ6RBDfOVYDQ
Message-ID: <CAGb2v65PTLYoHeTFa80EB51_WfzJ+LBAhn=+Kn9hsxdtuR-dnQ@mail.gmail.com>
Subject: Re: [PATCH] wireless-regdb: Update regulatory info for Cayman Islands
 (KY) for 2024
To: Ping-Ke Shih <pkshih@gmail.com>
Cc: linux-wireless@vger.kernel.org, wireless-regdb@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 10, 2024 at 11:00=E2=80=AFAM Ping-Ke Shih <pkshih@gmail.com> wr=
ote:
>
> From: Ping-Ke Shih <pkshih@realtek.com>
>
> Utility Regulation and Competition Office, Cayman Islands, released
> Operating Parameters for Wireless Data Transmission (including WiFi)
> Services On 18th November 2024 [1].
>
> Both FCC and EU reference are permitted. Adopt FCC reference.
>
> * 2400 - 2483.5 MHz
>   - Part 15.247
>     * 1 Watt
>       For systems using digital modulation in the 902 - 928 MHz,
>       2400-2483.5 MHz, and 5725 - 5850 MHz bands: 1 Watt.
>
> * 5150 - 5350 MHz
>   - Part 15.407
>     * 250 mW
>       For client devices in the 5.15-5.25 GHz band, the maximum conducted
>       output power over the frequency band of operation shall not exceed
>       250 mW provided the maximum antenna gain does not exceed 6 dBi.
>       In addition, the maximum power spectral density shall not exceed
>       11 dBm in any 1 megahertz band.
>
>       For the 5.25-5.35 GHz and 5.47-5.725 GHz bands, the maximum conduct=
ed
>       output power over the frequency bands of operation shall not exceed
>       the lesser of 250 mW or 11 dBm + 10 log B, where B is the 26 dB
>       emission bandwidth in megahertz. In addition, the maximum power
>       spectral density shall not exceed 11 dBm in any 1 megahertz band.
>     * DFS: 5.25-5.35 GHz
>
> * 5470 - 5725 MHz
>   - Part 15.407
>     * 250 mW
>       For the 5.25-5.35 GHz and 5.47-5.725 GHz bands, the maximum conduct=
ed
>       output power over the frequency bands of operation shall not exceed
>       the lesser of 250 mW or 11 dBm + 10 log B, where B is the 26 dB
>       emission bandwidth in megahertz. In addition, the maximum power
>       spectral density shall not exceed 11 dBm in any 1 megahertz band.
>     * DFS: 5.47-5.725 GHz
>
> * 5725 - 5875
>   - Part 15.407
>     * 1 W
>       For the band 5.725-5.85 GHz, the maximum conducted output power ove=
r
>       the frequency band of operation shall not exceed 1 W.
>
> * 5925 - 6425 MHz
>   - Part 15.407 (but no description; reference [2])
>     * -1 / MHz (12 dBm is adopted)
>       Accordingly, the Commission concludes that the appropriate maximum
>       power spectral density for low power indoor client devices in this
>       band is 6 dB below the limit for access points (or -1 dBm/MHz based
>       on the adopted PSD limit).
>     * NO-OUTDOOR
>
> * 57 - 71 GHz
>   - Part 15.255 (but no power value; reference [3])
>     * 40 dBm
>       The average power of any emission shall not exceed 40 dBm and the
>       peak power of any emission shall not exceed 43 dBm.
>
> [1] https://www.ofreg.ky/viewPDF/documents/2024-11-19-16-28-50-OfReg-WiFi=
-Permitted-Parameters-V2.pdf
> [2] https://www.federalregister.gov/documents/2020/05/26/2020-11236/unlic=
ensed-use-of-the-6-ghz-band
> [3] https://docs.fcc.gov/public/attachments/FCC-16-89A1.pdf
>
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
> ---
>  db.txt | 13 ++++++++-----
>  1 file changed, 8 insertions(+), 5 deletions(-)
>
> diff --git a/db.txt b/db.txt
> index 24195fcac004..37597f9add41 100644
> --- a/db.txt
> +++ b/db.txt
> @@ -1066,12 +1066,15 @@ country KW: DFS-ETSI
>         (5470 - 5825 @ 160), (24), DFS
>         (5925 - 6425 @ 320), (200 mW), NO-OUTDOOR
>
> +# Source: https://www.ofreg.ky/viewPDF/documents/2024-11-19-16-28-50-OfR=
eg-WiFi-Permitted-Parameters-V2.pdf
>  country KY: DFS-FCC
> -       (2402 - 2482 @ 40), (20)
> -       (5170 - 5250 @ 80), (24), AUTO-BW
> -       (5250 - 5330 @ 80), (24), DFS, AUTO-BW
> -       (5490 - 5730 @ 160), (24), DFS
> -       (5735 - 5835 @ 80), (30)
> +       (2400 - 2483.5 @ 40), (1000 mW)
> +       (5150 - 5250 @ 80), (250 mW), AUTO-BW
> +       (5250 - 5350 @ 80), (250 mW), DFS, AUTO-BW
> +       (5470 - 5725 @ 160), (250 mW), DFS, AUTO-BW

Sorry for the late reply.

Can you follow the TW example and extend this band by 5MHz and also
drop the AUTO-BW?

> +       (5725 - 5875 @ 80), (1000 mW), AUTO-BW

AUTO-BW for this band doesn't make sense. While the frequency ranges do
align up, the channel assignments don't, so there's no way one can combine
this and the previous band for a 160 MHz channel.


Thanks
ChenYu

> +       (5925 - 6425 @ 320), (12), NO-OUTDOOR
> +       (57000 - 71000 @ 2160), (40)
>
>  # Source:
>  # http://adilet.zan.kz/rus/docs/V1500010730
> --
> 2.25.1
>

