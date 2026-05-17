Return-Path: <linux-wireless+bounces-36553-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id bfwbGDaQCWo2fwQAu9opvQ
	(envelope-from <linux-wireless+bounces-36553-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sun, 17 May 2026 11:53:58 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C2FB8560578
	for <lists+linux-wireless@lfdr.de>; Sun, 17 May 2026 11:53:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1D93730068CA
	for <lists+linux-wireless@lfdr.de>; Sun, 17 May 2026 09:53:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1049A338593;
	Sun, 17 May 2026 09:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nVin/Aof"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E18C7315D39
	for <linux-wireless@vger.kernel.org>; Sun, 17 May 2026 09:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779011634; cv=none; b=Y3jwGdb/iBVmC0M+zccChvDUWl1i7Di1ZKVov9ORZjf4+ulMIorxYnCdZxWhGAmY9V5ebutDrEcUpt4kjOdRC1+uTPJTIiRG3YdEMapdA4Gmrcy7JBhH82JmDbuLDqFB5nGUd9mmyhJcLVxgyXf6UZ9YS3SdDWC3GfekMspXm2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779011634; c=relaxed/simple;
	bh=w24E2PS0OWfP/lsPmj/aM3/EL4WwXOkwHb7K9h6rhIo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YJXrUY/ixcMz8ArZCb7iCTIdXa3Lbj2p+PXoc+Ij0v7UGFr1ZQYPFVwaB7pUSV37QVtgyjnA1dLP6c9vKJ2SDYSvKaO6pTVkn8ZFbQs69vk1hTWecmJx7iWSIp61YtouZl8JEPlR3oO47PVGo12V7t8Bwd0S4MVORIoXbnRMDaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nVin/Aof; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87FA6C2BCB3
	for <linux-wireless@vger.kernel.org>; Sun, 17 May 2026 09:53:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779011633;
	bh=w24E2PS0OWfP/lsPmj/aM3/EL4WwXOkwHb7K9h6rhIo=;
	h=References:In-Reply-To:Reply-To:From:Date:Subject:To:Cc:From;
	b=nVin/Aof1/EexC6WgfxE8FEQY9Gjgsdw3/KRyzIngZrd6mDQZIjcOspZXfT9GiXwi
	 Y46aYwgA98cpllFEmuohU+9FemBnFSY6kp9+rLpZfNH30Gt7/DaGJ2+WnB8MyNOR3A
	 3SVrqXu/6tlcmELF3+uKZCrbxVTDEx5xiroCIa9EyjJBntJfEda1f/EFTtAlVrOk6t
	 QZ/sBLZMBfZZ+5TJj8y6kWFjPRtm0rXHzonMoVg2Z5SS2L9xbB5cT8ourDoh/IzBf3
	 JfQyJ0QEho7h0gk7cDQjoZXHeGHeno33bstxhPhv2L255HjPkIQrOZmRopvAwPb6xY
	 mUjJ0kO+szYqg==
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-5a85b30dd54so1547037e87.2
        for <linux-wireless@vger.kernel.org>; Sun, 17 May 2026 02:53:53 -0700 (PDT)
X-Gm-Message-State: AOJu0Yzp+B3S9eSViq5W4+HEiKo3aFKrSAD491GFdgNA9xEHDGJiTHTW
	P8p/B/FuBL2RpcT6RUCrScA83ZidbdwHTZfLXuy8iykg0poN2eznEkcYmB3tbjoB+FTxoYEkXaw
	1HxA+ZolVxN23c6oB095TrKOF39edUNY=
X-Received: by 2002:ac2:5b4e:0:b0:5aa:128d:9104 with SMTP id
 2adb3069b0e04-5aa128d9186mr2074170e87.13.1779011631921; Sun, 17 May 2026
 02:53:51 -0700 (PDT)
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
Date: Sun, 17 May 2026 17:53:40 +0800
X-Gmail-Original-Message-ID: <CAGb2v67NMBPs5bbNfoPNjK1mum-y5FsqAa_HVTq_P3e48Dnh3A@mail.gmail.com>
X-Gm-Features: AVHnY4LHa6jKozd8dHzbv_dzE_-1r086s8QbVV2ux_NMViqm1CfKbcfn9hTUID0
Message-ID: <CAGb2v67NMBPs5bbNfoPNjK1mum-y5FsqAa_HVTq_P3e48Dnh3A@mail.gmail.com>
Subject: Re: [PATCH v2] wireless-regdb: Update regulatory info for Brunei
 Darussalam (BN) for 2022
To: hfzz7@duck.com
Cc: linux-wireless@vger.kernel.org, wireless-regdb@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: C2FB8560578
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	TAGGED_FROM(0.00)[bounces-36553-lists,linux-wireless=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_NONE(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,mail.gmail.com:mid,agc.gov.bn:url,aiti.gov.bn:url]
X-Rspamd-Action: no action

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
>
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

So the author (the email's From: header) only has your email. With
your permission, I will add use name from your Signed-off-by as
the commit's author.


ChenYu

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
> +       (57000 - 66000 @ 2160), (10000 mW), INDOOR-ONLY
>
>  country BO: DFS-JP
>         (2402 - 2482 @ 40), (20)
> --
> 2.54.0
>
>

