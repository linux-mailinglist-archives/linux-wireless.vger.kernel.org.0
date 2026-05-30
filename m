Return-Path: <linux-wireless+bounces-37175-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QKGVKWMDG2rx+QgAu9opvQ
	(envelope-from <linux-wireless+bounces-37175-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sat, 30 May 2026 17:33:55 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 97F5B60DC10
	for <lists+linux-wireless@lfdr.de>; Sat, 30 May 2026 17:33:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 7E5B93003808
	for <lists+linux-wireless@lfdr.de>; Sat, 30 May 2026 15:33:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFC452C029D;
	Sat, 30 May 2026 15:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PCSHOjXh"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7244729ACC5
	for <linux-wireless@vger.kernel.org>; Sat, 30 May 2026 15:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780155228; cv=none; b=ZS9tRt1fQVnAX2e49lEExFTtJvN0sKJ5ai4T5g3u1bjAlWzATWCfRlUgx1lDDS6xuhKuoXCxGhtZULvllk3rb6k85N+NLUMNvOUgYPeygMxS3MKCYwcAoDeHPLKjldCgHiKSNlEZQTQ/do0HUmkhuAPobiI5O1j8FQxzm0OfECc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780155228; c=relaxed/simple;
	bh=vL/Y5JiIcwBBv6RGqvXff8cYL3KxMchzEM6KHPA9OoI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mJmc6TDfjH4HLFBU9811YbvKGUPyuR5Q5Jj7TXGsoVFu8ZdTms/hvnlMa3r6OiOYpQrI+YdpqA/IqQaBBbZNc3tG0jNbXaoQed/GVT9pzTN0clVcyG9zw2Q2jw4/J49QpT1N/n3WLUxMGKe0bGkDvbNtu3WiAoMna05zsvCJo3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PCSHOjXh; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6C191F00898
	for <linux-wireless@vger.kernel.org>; Sat, 30 May 2026 15:33:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780155226;
	bh=PaaMX06Hb9Qet7b/Ta2+gfIEUiRqgAjujDcukqX0l0w=;
	h=References:In-Reply-To:Reply-To:From:Date:Subject:To:Cc;
	b=PCSHOjXh8xc8aQpgyjlslFlE6RfX12MWi1WrL14Kynvl1/rYW7DtA5ARTj3oNl65D
	 juHV6MkYRYOUM31okFTZdZCh9XzLoDDKewgGpuPqK1Q4MCAmwY1vYz1iQouhhJs3Y2
	 3AjPI12d+WJ0FGy+Q6IXAhnu9DxrWKHdn0y+SqmyLbIi1fnnKjnL3p+yDyKxdPifpA
	 ZXC1p8R8B2YUhBG/a+LMk1hYpy++V/18FLgW5NH3HDRUH1cEVzHDbUb+A4a4ReBnxR
	 xtPI8knFXrijWVZykO+rz3oVc1ilHIgAIwALoDPtMdHK6SNbX/FIjO56Hbj7YL41V3
	 jNi1HC5lP1PDg==
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-5aa4a628ab0so3796167e87.2
        for <linux-wireless@vger.kernel.org>; Sat, 30 May 2026 08:33:46 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ9tUzWQIEtyoKOvBksAtPxU9/jkn8iL9YmxR35DQjdMtvzYrT5G0GdEB8OvgTaYXBZKC4hEx+viSfQAAx57sA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyyV7do8E3/x5KxVnyhufDOmVdy48YBFD8TZEwIcfhIS7IlHcP8
	G8nQ3bdwEUqIqLTvYhYLYKq0DdGbFEUKf45e9CsskfNvtItASPEl+a/zB0mWTM9t/nWgMH3RYex
	U9bJy5OKza8m8UN6JM57FiScVt0I+MtE=
X-Received: by 2002:a05:6512:2525:b0:5a8:8df1:61bf with SMTP id
 2adb3069b0e04-5aa6090ab09mr1186716e87.21.1780155225333; Sat, 30 May 2026
 08:33:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260521101501.1841-1-mnew_iraq.ref@yahoo.com> <20260521101501.1841-1-mnew_iraq@yahoo.com>
In-Reply-To: <20260521101501.1841-1-mnew_iraq@yahoo.com>
Reply-To: wens@kernel.org
From: Chen-Yu Tsai <wens@kernel.org>
Date: Sat, 30 May 2026 18:33:33 +0300
X-Gmail-Original-Message-ID: <CAGb2v66pbBcCL+wmW8CS8LQWJ+KrhO1u+RV+2LKxoM23ywvBDg@mail.gmail.com>
X-Gm-Features: AVHnY4Ik9SJLBKP4RabgX9OJbY6wCM6R-CjqZu2QG7HjqjGjdpfYwDvGCAbfoDM
Message-ID: <CAGb2v66pbBcCL+wmW8CS8LQWJ+KrhO1u+RV+2LKxoM23ywvBDg@mail.gmail.com>
Subject: Re: [PATCH v2] wireless-regdb: add regulatory rules for Iraq (IQ)
To: Mohammed Abdullah Ali Al-Obaidi <mnew_iraq@yahoo.com>
Cc: wireless-regdb@lists.infradead.org, linux-wireless@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	URIBL_MULTI_FAIL(0.00)[cmc.iq:server fail,mail.gmail.com:server fail,sin.lore.kernel.org:server fail];
	TAGGED_FROM(0.00)[bounces-37175-lists,linux-wireless=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[yahoo.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	MISSING_XM_UA(0.00)[];
	HAS_REPLYTO(0.00)[wens@kernel.org];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wens@kernel.org,linux-wireless@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[3];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	HAS_WP_URI(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,cmc.iq:url]
X-Rspamd-Queue-Id: 97F5B60DC10
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi,

Just a couple notes.

On Thu, May 21, 2026 at 1:15=E2=80=AFPM Mohammed Abdullah Ali Al-Obaidi
<mnew_iraq@yahoo.com> wrote:
>
> Add a regulatory entry for Iraq (ISO 3166-1 alpha-2: IQ).
>
> Iraq is currently absent from the regulatory database. Devices set
> to country=3DIQ fall back to the world domain (00), which leaves most
> of the 5 GHz spectrum marked "no IR" and severely restricts even
> 2.4 GHz operation. The Iraqi Communications and Media Commission
> (CMC) has now published an explicit, numerical national regulation
> that fills this gap.
>
> Source document
> ---------------
>
>   Title : Regulation on short-range radio communication devices
>           (SRD) and devices using ultra-broadband (UWB) technology
>   Issuer: Republic of Iraq, Communications and Media Commission
>           (CMC), Telecommunications Regulatory Department,
>           International Relations Section
>   Decree: Council of Commissioners decision No. 122/q-2025
>   In force from: 2025-09-22
>   Edition: First edition, 2025; 26 pages
>   URL   : https://cmc.iq/wp-content/uploads/2025/09/Regulation-on-short-r=
ange-radio-communication-devices-SRD-and-devices-using-ultra-broadband-UWB-=
technology.pdf
>
> The values below are taken directly from Article 4-1-13 ("Wireless
> Access Systems / WAS") of that regulation, which is the table
> governing Wi-Fi (Annex A of the regulation defines Wi-Fi as
> "802.11 Local Area Networking in 2.4 and 5 GHz ISM bands").
>
> Bands and limits, as stated in Article 4-1-13:
>
>   2400-2483.5 MHz  : 100  mW EIRP, indoor and outdoor, LBT/DAA
>                      (EN 300 328, ERC/REC 70-03)
>   5150-5250 MHz    : 200  mW EIRP, indoor
>                      (EN 301 893, ITU-R Res. 229 Rev. WRC-19)
>   5250-5350 MHz    : 200  mW EIRP, indoor
>                      (EN 301 893)
>   5470-5725 MHz    : 1000 mW EIRP, indoor, DFS + TPC
>                      (EN 301 893)
>   5725-5875 MHz    : 2000 mW EIRP (10 MHz ch) / 4000 mW (20 MHz ch),
>                      indoor and outdoor
>                      (EN 302 502)
>   5945-6425 MHz    : 200  mW EIRP, indoor
>                      (EN 303 687, ECC Report 75)
>   57-66 GHz        : 10   W  EIRP, indoor, LBT/DAA
>                      (EN 302 567)
>
> Notes on the encoding chosen below
> ----------------------------------
>
> * TPC handling for 5470-5725 MHz: The regulation explicitly requires
>   both DFS and TPC. Because Linux/wireless-regdb does not natively
>   enforce TPC limits, the rule is encoded with the standard DFS flag
>   to remain as compliant as possible within the framework's capabilities.
> * Indoor/Outdoor for 5725-5875 MHz: The regulation explicitly permits
>   both indoor and outdoor operation for this band, so no NO-OUTDOOR flag
>   is applied.
> * EIRP limit for 5725-5875 MHz: The regulation provides two figures
>   (2000 mW for 10 MHz channels, 4000 mW for 20 MHz channels). Because
>   wireless-regdb expresses a strict per-band ceiling to ensure compliance
>   across all configurations, the limit is conservatively set to 2000 mW
>   to prevent narrower channel widths from exceeding their legal limit.

Please leave a short comment above the rule mentioning this. Something
like "adopting limits for 10 MHz channel width to be conservative."

> * 6 GHz channel width: Encoded at 80 MHz (the widest standard-power
>   option) pending further clarification from the CMC regarding AFC
>   requirements.
>
> Background on the unique 5.8 GHz figure
> ---------------------------------------
>
> The 2000 mW EIRP ceiling for 5725-5875 MHz reflects an explicit Iraqi
> national choice that follows EN 302 502 (BFWA). This choice puts Iraq
> at the high end of the regional spectrum policy for the 5.8 GHz band
> and is included verbatim from the regulation.
>
> Signed-off-by: Mohammed Abdullah Ali Al-Obaidi <mnew_iraq@yahoo.com>
> ---
> v2:
>   - Changed 5725-5875 MHz EIRP ceiling from 4000 mW to 2000 mW to
>     ensure absolute compliance at narrower channel widths (10 MHz).
>   - Trimmed redundant encoding notes regarding standard NO-OUTDOOR,
>     DFS, and AUTO-BW conventions.
>   - Clarified TPC handling limitations and indoor/outdoor encoding
>     choices.
>
>  db.txt | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
>
> diff --git a/db.txt b/db.txt
> --- a/db.txt
> +++ b/db.txt
> @@ -insert-after-IN-block@@
> +# Iraq
> +# Source: Regulation on short-range radio communication devices (SRD)
> +# and devices using ultra-broadband (UWB) technology, First Edition
> +# 2025, issued by the Iraqi Communications and Media Commission (CMC)
> +# under Council of Commissioners decision No. 122/q-2025, in force
> +# from 2025-09-22. Limits below are taken from Article 4-1-13
> +# (Wireless Access Systems) of that regulation.
> +# https://cmc.iq/wp-content/uploads/2025/09/Regulation-on-short-range-ra=
dio-communication-devices-SRD-and-devices-using-ultra-broadband-UWB-technol=
ogy.pdf
> +country IQ: DFS-ETSI
> +       (2400 - 2483.5 @ 40), (100 mW), wmmrule=3DETSI
> +       (5150 - 5250 @ 80), (200 mW), NO-OUTDOOR, AUTO-BW, wmmrule=3DETSI
> +       (5250 - 5350 @ 80), (200 mW), NO-OUTDOOR, DFS, AUTO-BW, wmmrule=
=3DETSI
> +       (5470 - 5725 @ 160), (1000 mW), NO-OUTDOOR, DFS, wmmrule=3DETSI

Since Linux doesn't support TPC, it would be better if this rule follows
EN 301 893 and reduces the EIRP. EN 301 893 reduces the limit from 30 dBm
to 27 dBm. Please just use 27 dBm here, and also mention it in the commit
message.

> +       (5725 - 5875 @ 80), (2000 mW)

The boundary of WiFi channel 144 actually goes up to 5730. Since this
5 MHz is split between two bands, the current way actually prevents
you from using this channel. Normally we add AUTO-BW to both channels
that are straddled. But since the restrictions for 5725-5875 are looser,
we just let the previous band go up to 5730 MHz instead of 5725 MHz,
and leave a comment explaining it.

Please do so as well. You can use the US region as an example.

> +       (5945 - 6425 @ 80), (200 mW), NO-OUTDOOR, wmmrule=3DETSI
> +       (57000 - 66000 @ 2160), (40)

Please copy the the numbers and units from the regulation verbatim,
unless modifications like the TPC-less reduction was done. So this
should not be "40" dBm, but "10000 mW".


Thanks
ChenYu

