Return-Path: <linux-wireless+bounces-33680-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 1+WcJ43KwGmmKwQAu9opvQ
	(envelope-from <linux-wireless+bounces-33680-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Mar 2026 06:07:25 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A9DE2EC951
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Mar 2026 06:07:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 5E6E03002D08
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Mar 2026 05:07:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B4572609EE;
	Mon, 23 Mar 2026 05:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JlxGCfCI"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC5224414
	for <linux-wireless@vger.kernel.org>; Mon, 23 Mar 2026 05:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774242438; cv=none; b=kT3urjZ/5yUN+TXIxXe4lHesow6yktyZnKvY0ALJP6E/N7xescy4z9szs/HO3mboIuQlxg/uxFeZ2pUzKfXBLwGh9y050ClRZbu8rVyG3dFdNHbTlcKBqejq+Q7rylayl6I54IhLEX3dGmNhDGWQu5FYZPAkNDEVvx4dXt9RGJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774242438; c=relaxed/simple;
	bh=sLcVd4BfxLbz51Qpm3+Zxr/F9Yo3nuTokM6mB+pQSQo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=L+iLZwilx/vqdzhd2N8rEFlISKZGHVSrkZEQ5kaAk8tJlrNRts2/48SEs3aA/O4R9zSsLmEA1BJ98e3ZMMbio1BUvNIFStisaWip6LhGzVDb7vqr0+0Vr/A+YNOi3TQ52kDRDEP9s6iWPECPFAdkReDOHyji383ojU3IpGI8hGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JlxGCfCI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C9DBC2BCB1
	for <linux-wireless@vger.kernel.org>; Mon, 23 Mar 2026 05:07:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774242438;
	bh=sLcVd4BfxLbz51Qpm3+Zxr/F9Yo3nuTokM6mB+pQSQo=;
	h=References:In-Reply-To:Reply-To:From:Date:Subject:To:Cc:From;
	b=JlxGCfCIDj7636DN2MbKZpxZhyJkhh0IwUmFgBkfucTfAXSlNf9aHt/0EYOgjfv1M
	 YG5zvmKWd/Rq7f7+E/NfHU+Gjel6RegcEie6ljBNK0FeAdXchjOjnBGCyK9FSD1aTI
	 5mbZ4JaiXyreoKi6p+np13zbzC0ZzJ11rvwZUVRtfRsu0ypsDwtE0e15nhg87HNEcM
	 B9uQ1hoHaWQzZiOGL5KUp0AF6F8ZNjrNaAaSBdBr6wtzJ9fmdoJJZFQcTVnQsbCH+1
	 U5P6fE7RB0uIUygJn/zBre3lrYzIDxp9VQJzjb/5zvFHl2LadtcCFEk/8bYoy6XDIF
	 ijhh7XgamcO7g==
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-38bd15d82bdso16747801fa.2
        for <linux-wireless@vger.kernel.org>; Sun, 22 Mar 2026 22:07:18 -0700 (PDT)
X-Gm-Message-State: AOJu0YxjM2TXM0zbZ5JTBl2CtmPYj5Jx9YSlzqDNyuMREOvXX2loOAEf
	d2zagSn7uBYCvK+hMSSpqDItItrr1cbGMvrtJmYCtGQH8ukfmHEVHH5E6hIvzoy5M36FigYqM14
	oCjY/RbzBu+aJ1oc562kSOA8x8bNRnME=
X-Received: by 2002:a2e:3514:0:b0:38a:55b7:dfa8 with SMTP id
 38308e7fff4ca-38bf962906bmr24897971fa.13.1774242436867; Sun, 22 Mar 2026
 22:07:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <C9C14F68-BFFF-4BF6-A8AA-60E5EB445F4E@fitzsimons.org>
In-Reply-To: <C9C14F68-BFFF-4BF6-A8AA-60E5EB445F4E@fitzsimons.org>
Reply-To: wens@kernel.org
From: Chen-Yu Tsai <wens@kernel.org>
Date: Mon, 23 Mar 2026 13:07:03 +0800
X-Gmail-Original-Message-ID: <CAGb2v662bq4Edw_wW07fc=dNkv8OErReOMycMZwhwQucgj-jtA@mail.gmail.com>
X-Gm-Features: AQROBzD_wEg_4B9BhQMFl0knBEArpYxmf5LvwMWuAnqAm8Usmu9ngi9umE1JeBA
Message-ID: <CAGb2v662bq4Edw_wW07fc=dNkv8OErReOMycMZwhwQucgj-jtA@mail.gmail.com>
Subject: Re: [PATCH] wireless-regdb: Update Australia (AU) 6 GHz band to 6585 MHz
To: bruce@fitzsimons.org
Cc: linux-wireless@vger.kernel.org, wireless-regdb@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	TAGGED_FROM(0.00)[bounces-33680-lists,linux-wireless=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_NONE(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,acma.gov.au:url]
X-Rspamd-Queue-Id: 8A9DE2EC951
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sun, Dec 7, 2025 at 5:06=E2=80=AFPM <bruce@fitzsimons.org> wrote:
>
>
> Extend the 6 GHz band allocation for Australia from 5925-6425 MHz
> to 5925-6585 MHz, adding 160 MHz of additional spectrum.
>
> This change reflects the Australian Radiofrequency Spectrum Plan
> Variation 2025 (No. 1), which took effect on 1 October 2025.
>
> References:
> - ACMA Outcomes Paper: Future use of the upper 6 GHz band (December 2024)
>   https://www.acma.gov.au/sites/default/files/2024-12/Outcomes%20paper%20=
-%20Future%20use%20of%20the%20upper%206%20GHz%20band_0.pdf
>
> Signed-off-by: Bruce Fitzsimons <bruce@fitzsimons.org>

Sorry for getting to this just now. I somehow accidentally archived it.

Thanks for the patch. I believe it was already covered by a previous
change updating all the rules for AU.

> ---
> db.txt | 3 ++-
> 1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/db.txt b/db.txt
> index fdc2c13..7eac515 100644
> --- a/db.txt
> +++ b/db.txt
> @@ -159,7 +159,8 @@ country AU: DFS-ETSI
> (5850 - 5875 @ 20), (25 mW), AUTO-BW
>
> # Item 63AA (25 mW if outdoors)
> - (5925 - 6425 @ 160), (250 mW), NO-OUTDOOR
> + # Extended to 6585 MHz as of 1 October 2025
> + (5925 - 6585 @ 160), (250 mW), NO-OUTDOOR
>
> # Item 65
> (57000 - 71000 @ 2160), (20000 mW), NO-OUTDOOR
> --
> 2.43.0

