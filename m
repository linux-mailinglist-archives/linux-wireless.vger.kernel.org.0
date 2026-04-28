Return-Path: <linux-wireless+bounces-35442-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kLpALk9a8Gn/SAEAu9opvQ
	(envelope-from <linux-wireless+bounces-35442-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 28 Apr 2026 08:57:19 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B23947E57B
	for <lists+linux-wireless@lfdr.de>; Tue, 28 Apr 2026 08:57:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 68370300DF60
	for <lists+linux-wireless@lfdr.de>; Tue, 28 Apr 2026 06:57:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B91135AC31;
	Tue, 28 Apr 2026 06:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qvJZ5Ugn"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37D8D32A3EC
	for <linux-wireless@vger.kernel.org>; Tue, 28 Apr 2026 06:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777359436; cv=none; b=pUqpoTr0+8bKpI5ajAp2p7I6nI5SSt7mmHF8nu/iVI75/ouY8ET5GPf6aOjH3IOD08W2xut62YVK5vx+XxKD73F3lwGSNoQo1HdT7KkB4hijr659t6WY1GZztUVoe4IkNHU/OFYWpzHEOyV0ql7cHJ1YVn3gbjDGaspLqPvP074=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777359436; c=relaxed/simple;
	bh=lWrdM2SjRzIwrZ4CHDBSQc3n/YiBy7qNIwxSUU9W/PA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ML4T+VBGK10OpipabO9f/KqzWf7TknJDMXJNxuC5uriUiCE9bMYJdZwJd2eJ/kF4YoR5B3md9RL8Xz7s5FCeo1ttLavokpgEsyIWn7VJVENb3AeQTAH0HdUNFMRHZ5dTrbH6lFgXnqldhpCRpSyCLcRjHiL+7G2G1+jFAc9PX9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qvJZ5Ugn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6F69C2BCB7
	for <linux-wireless@vger.kernel.org>; Tue, 28 Apr 2026 06:57:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777359435;
	bh=lWrdM2SjRzIwrZ4CHDBSQc3n/YiBy7qNIwxSUU9W/PA=;
	h=References:In-Reply-To:Reply-To:From:Date:Subject:To:Cc:From;
	b=qvJZ5Ugn4eiJdKpQAaPrqStEje6niMZvq3q1MkzXN09jugnP/Q30n5NRI9tm93yxJ
	 v9EHYxViMIPRHK+Vv0pjBio4WBrhswPM+J0TD8L89VsBsfHwbg5M/ROjSv9I60BvW3
	 hUQRVgcaoa016dqJjoTIa/670nqVCSfiN5bxYEXKB8BxtVGEaj/l/ODpli5yBwJh7V
	 G5dX84d/jypfbJoFw/rviWSaeDWdNQmbB6j4IGEtn3iZQJ3F+zK4fhyiEBLAF2ajJk
	 shV/UDhwTa57bD+m46hGZmA5WA8PsZ4Lc271C5c99LqraOoiMY2qBrGqAVJGCx0kQl
	 rluMuC9uDlt8g==
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-386b553c70eso89033401fa.0
        for <linux-wireless@vger.kernel.org>; Mon, 27 Apr 2026 23:57:15 -0700 (PDT)
X-Gm-Message-State: AOJu0YyJWwvkVXv6Ecg4fwTsMyGhLkmNuwx537akfrOoVIgyhjxFw8JS
	0u1Qf+bw021yEAE18bxkl8jpJbYf8FYlEoGgyqAJkTuRdtSmvt9mn8WtkjzCGNnerCgqpPCIOZf
	fnAIM5IO9auvoxs9UBec6NJNTC+uguSw=
X-Received: by 2002:a05:651c:212a:b0:38a:5102:9190 with SMTP id
 38308e7fff4ca-39240fca0c2mr5687421fa.28.1777359434160; Mon, 27 Apr 2026
 23:57:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CB87FEAB-DAEC-49D6-83C2-8B8D59025164.1@smtp-inbound1.duck.com>
In-Reply-To: <CB87FEAB-DAEC-49D6-83C2-8B8D59025164.1@smtp-inbound1.duck.com>
Reply-To: wens@kernel.org
From: Chen-Yu Tsai <wens@kernel.org>
Date: Tue, 28 Apr 2026 15:57:00 +0900
X-Gmail-Original-Message-ID: <CAGb2v650r=2+=Z4VBMdX4+55p2XLpG0dvHUGPZBrgp473NJn8Q@mail.gmail.com>
X-Gm-Features: AVHnY4K2vtNCI2r-eTOCxzr9M1KJJ6LNCzcPowlkx0LxaXshA-fzFUH6lsfT4pY
Message-ID: <CAGb2v650r=2+=Z4VBMdX4+55p2XLpG0dvHUGPZBrgp473NJn8Q@mail.gmail.com>
Subject: Re: [PATCH] wireless-regdb: Update regulatory info for Brunei
 Darussalam (BN) for 2022
To: hfzz7@duck.com
Cc: linux-wireless@vger.kernel.org, wireless-regdb@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 5B23947E57B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	TAGGED_FROM(0.00)[bounces-35442-lists,linux-wireless=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	HAS_REPLYTO(0.00)[wens@kernel.org];
	RCVD_COUNT_FIVE(0.00)[5];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wens@kernel.org,linux-wireless@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_NONE(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,agc.gov.bn:url,aiti.gov.bn:url]

Hi,

Thank you for the patch and sorry for taking so long to get to it.

On Sat, Oct 25, 2025 at 4:53=E2=80=AFPM <hfzz7@duck.com> wrote:
>
> In 2022, Authority for Info-communications Technology Industry of Brunei =
Darussalam (AITI) updates The Brunei Darussalam Radio Spectrum Plan. [1]
>
> * 2400-2483.5 MHz
>         - 200 mW
>
> * 5150-5350 MHz
>         - 1000 mW
>         (For 5250-5.350 MHz, DFS and TPC are required)
>
> * 5470-5725 MHz
>         - 1000 mW
>         - DFS
>         - TPC

The database nor Linux supports TPC. Here we can follow FCC 15.407 and
limit the power to under 500mW:

    Transmit power control (TPC). U-NII devices operating in the
    5.25-5.35 GHz band and the 5.47-5.725 GHz band shall employ
    a TPC mechanism. The U-NII device is required to have the
    capability to operate at least 6 dB below the mean EIRP value
    of 30 dBm. A TPC mechanism is not required for systems with
    an e.i.r.p. of less than 500 mW.

> * 5725-5850 MHz
>         - 4000 mW
>
> Also, add regulatory info for WiGig/60 GHz
> * 57000-66000 MHz
>         - 10 W / 10000 mW

This limit is for indoor use only.  The remark column says

    outdoor use is restricted to maximum EIRP of 25 dBm and maximum
    EIRP power spectral density of -2 dBm / MHz

So please add the INDOOR-ONLY flag.

> Note: According to the Telecommunications (Radio-communication) Regulatio=
ns, 2013 of the Telecommunications Order, 2001 (S 38/2001), "non-localised =
use" refers to the operations of specified radio-communication equipment or=
 network at a specific frequency or in any specified frequency within the w=
hole of Brunei Darussalam. [2]

Please wrap the commit message to 80 characters per line. This however
doesn't apply to URLs.


Thanks
ChenYu

> [1] https://aiti.gov.bn/media/planjc1p/bd-radio-spectrum-plan-2019.pdf
> [2] https://www.agc.gov.bn/AGC%20Images/LAWS/Gazette_PDF/2013/EN/s086.pdf
>
> Signed-off-by: Hafiz Zafran <hfzz7@duck.com>
> ---
>  db.txt | 14 +++++++++-----
>  1 file changed, 9 insertions(+), 5 deletions(-)
>
> diff --git a/db.txt b/db.txt
> index 1d17271..8e5cbb5 100644
> --- a/db.txt
> +++ b/db.txt
> @@ -326,11 +326,15 @@ country BM: DFS-FCC
>         (5490 - 5730 @ 160), (24), DFS
>         (5735 - 5835 @ 80), (30)
>
> -country BN: DFS-JP
> -       (2402 - 2482 @ 40), (20)
> -       (5170 - 5250 @ 80), (20), AUTO-BW
> -       (5250 - 5330 @ 80), (20), DFS, AUTO-BW
> -       (5735 - 5835 @ 80), (20)
> +# https://aiti.gov.bn/media/planjc1p/bd-radio-spectrum-plan-2019.pdf
> +# Section 7.5, Page 244-251
> +country BN: DFS-FCC
> +       (2400 - 2483.5 @ 40), (200 mW)
> +       (5150 - 5250 @ 80), (1000 mW), AUTO-BW
> +       (5250 - 5350 @ 80), (1000 mW), DFS, AUTO-BW
> +       (5470 - 5730 @ 160), (1000 mW), DFS
> +       (5725 - 5850 @ 80), (4000 mW), AUTO-BW
> +       (57000 - 66000 @ 2160), (10000 mW)
>
>  country BO: DFS-JP
>         (2402 - 2482 @ 40), (20)
> --
> 2.51.1
>
>

