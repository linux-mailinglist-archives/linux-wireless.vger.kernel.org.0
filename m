Return-Path: <linux-wireless+bounces-36642-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sHWZBAEJDGo5UQUAu9opvQ
	(envelope-from <linux-wireless+bounces-36642-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 19 May 2026 08:53:53 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 178C95786C4
	for <lists+linux-wireless@lfdr.de>; Tue, 19 May 2026 08:53:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 8938430CACB2
	for <lists+linux-wireless@lfdr.de>; Tue, 19 May 2026 06:41:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0C4D390CBF;
	Tue, 19 May 2026 06:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QZEBPmmB"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDEEC390981
	for <linux-wireless@vger.kernel.org>; Tue, 19 May 2026 06:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779172901; cv=none; b=MX0JRdAtF9cynorqALEMZXYLT+W2z1CAbdmeIZQPSXpBbgyrYayfK0FxTaY5u6sey2z4pvgM+mr+v1F1sUKru+BkzZn84keru4LnZYTuP2G187NdOkcEi5muI8QSs9hZOWS/U81awjbG3Eylb90X26+0Rtj/vZiS3No78qGrd7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779172901; c=relaxed/simple;
	bh=HWHosOrNJ6PP/PMVms5O55R5dHcu/KFNcOUCtba9UcI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZRaLPHy2GS70F81EJ22Na+/u7KrJhtdXDYsRxqaUVBh/K7dUCp/NkIJ3vJ8dJKPMcQrAN+n9mzrGW+YonbzeTgZ+tn3sJ3cYsXIRERR1Sqb1a2qgNe6o3WUDrEKYLXkJr5Z0i6QsacnZK5gIQiUypfsygpgB4CLk67Agga7Z1L4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QZEBPmmB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83C2EC2BCB3
	for <linux-wireless@vger.kernel.org>; Tue, 19 May 2026 06:41:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779172901;
	bh=HWHosOrNJ6PP/PMVms5O55R5dHcu/KFNcOUCtba9UcI=;
	h=References:In-Reply-To:Reply-To:From:Date:Subject:To:Cc:From;
	b=QZEBPmmBgLQoyjLsFeK5/NqSobQsz+V9E7RDMmIuMhjiu6hBOdRsCNv1xaUfg5AzO
	 NW7JU/SeSDvOCcxK0gSD2BWVaKqJYqqvkBPIoHi8PeW9JxfUbdm3icIQLyN0LVuw9v
	 HjQnTLSSKZFn0q31rYBV1J3rFE8xAazFITQ/oDJYqwXPf295zWPzgNi8YfUW99ATNa
	 yoeRJX9Pb3CmvxXGJEt4qFLdEovfKK5HV3958vFPpmDiaOy75qLjoFqoM4pJh89eRs
	 XgDZiccwtUeb7ZgnqisD20YGyoU8PzBlnSpEWmtAt7DFgFiKs9lPn11MQBXMszoDzI
	 3AbsEfNsgNKyQ==
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-38e84ed22bdso39876771fa.2
        for <linux-wireless@vger.kernel.org>; Mon, 18 May 2026 23:41:41 -0700 (PDT)
X-Gm-Message-State: AOJu0YwIYwzRV+Y/lRtdNmMy4dJe+DpMssq+1J/Zw2eEl/EIOOgKY40H
	6hQsXE76F2tM/D2ZK5zfme+W9QLC+u6tgeWmdkMzPqiCO1qidERI29m88OiXHkzgktgeUmzLCEx
	MWw7LeRlZi4sFtlBX/wRxC2nj03B5A/M=
X-Received: by 2002:a05:651c:12c1:b0:38c:13c8:a4b2 with SMTP id
 38308e7fff4ca-39561d62689mr55825151fa.17.1779172899922; Mon, 18 May 2026
 23:41:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260501153303.8521-1-hfzz7@duck.com> <BFBA868E-9B63-48A6-9B73-E749857BD106.1@smtp-inbound1.duck.com>
In-Reply-To: <BFBA868E-9B63-48A6-9B73-E749857BD106.1@smtp-inbound1.duck.com>
Reply-To: wens@kernel.org
From: Chen-Yu Tsai <wens@kernel.org>
Date: Tue, 19 May 2026 14:41:27 +0800
X-Gmail-Original-Message-ID: <CAGb2v64pXqi0ZSGKwphHWPhre0jH+kux+y5tceFYruAmVX0ThA@mail.gmail.com>
X-Gm-Features: AVHnY4LQs2e9gsbzquZw57Hq6K7qVBjGw1OPzFpDJDxKzQVG59tRNFoqekYiZe4
Message-ID: <CAGb2v64pXqi0ZSGKwphHWPhre0jH+kux+y5tceFYruAmVX0ThA@mail.gmail.com>
Subject: Re: [PATCH v2] wireless-regdb: Update regulatory info for Brunei
 Darussalam (BN) for 2022
To: hfzz7@duck.com
Cc: linux-wireless@vger.kernel.org, wireless-regdb@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-36642-lists,linux-wireless=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	HAS_REPLYTO(0.00)[wens@kernel.org];
	RCVD_COUNT_FIVE(0.00)[5];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wens@kernel.org,linux-wireless@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	PRECEDENCE_BULK(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,duck.com:email,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,aiti.gov.bn:url]
X-Rspamd-Queue-Id: 178C95786C4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, May 1, 2026 at 11:41=E2=80=AFPM <hfzz7@duck.com> wrote:
>
> In 2022, Authority for Info-communications Technology Industry of Brunei
> Darussalam (AITI) updated The Brunei Darussalam Radio Spectrum Plan. [1]
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
>
> * 5725-5850 MHz
>         - 4000 mW
>
> Also, add regulatory info for WiGig/60 GHz
> * 57000-66000 MHz
>         - 10 W / 10000 mW

The power density should be mentioned, and there should be separate
entries for indoor use and outdoor use. I added them while applying.

> Note: According to the Telecommunications (Radio-communication) Regulatio=
ns,
> 2013 of the Telecommunications Order, 2001 (S 38/2001), "non-localised us=
e"
> refers to the operations of specified radio-communication equipment or ne=
twork
> at a specific frequency or in any specified frequency within the whole of
> Brunei Darussalam. [2]
>
> [1] https://aiti.gov.bn/media/planjc1p/bd-radio-spectrum-plan-2019.pdf
> [2] https://www.agc.gov.bn/AGC%20Images/LAWS/Gazette_PDF/2013/EN/s086.pdf
>
> Signed-off-by: Hafiz Zafran <hfzz7@duck.com>
>
> ---
> Changes since v1:
>         - fix grammar issues on the commit message
>         - adjust transmit power limit to 500 mW for frequencies that
>           require TPC
>         - add INDOOR-ONLY flag to WiGig, as per review
> ---
>  db.txt | 15 ++++++++++-----
>  1 file changed, 10 insertions(+), 5 deletions(-)
>
> diff --git a/db.txt b/db.txt
> index 3252521..2de3281 100644
> --- a/db.txt
> +++ b/db.txt
> @@ -326,11 +326,16 @@ country BM: DFS-FCC
>         (5490 - 5730 @ 160), (24), DFS
>         (5735 - 5835 @ 80), (30)
>
> -country BN: DFS-JP
> -       (2402 - 2482 @ 40), (20)
> -       (5170 - 5250 @ 80), (20), AUTO-BW
> -       (5250 - 5330 @ 80), (20), DFS, AUTO-BW
> -       (5735 - 5835 @ 80), (20)
> +# Source:
> +# https://aiti.gov.bn/media/planjc1p/bd-radio-spectrum-plan-2019.pdf
> +# Section 7.5, Page 244-251
> +country BN: DFS-FCC
> +       (2400 - 2483.5 @ 40), (200 mW)
> +       (5150 - 5250 @ 80), (1000 mW), AUTO-BW
> +       (5250 - 5350 @ 80), (500 mW), DFS, AUTO-BW
> +       (5470 - 5730 @ 160), (500 mW), DFS
> +       (5725 - 5850 @ 80), (4000 mW), AUTO-BW

This should start at 5730 since the previous one end at 5730. Also,
AUTO-BW does nothing for this range now, as there is nothing to combine
it with after it.

> +       (57000 - 66000 @ 2160), (10000 mW), INDOOR-ONLY

This should have been NO-OUTDOOR. I fixed it up while applying.

Please check the commit after I push it out.


Thanks
ChenYu

>
>  country BO: DFS-JP
>         (2402 - 2482 @ 40), (20)
> --
> 2.54.0
>
>

