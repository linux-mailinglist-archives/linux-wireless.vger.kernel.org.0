Return-Path: <linux-wireless+bounces-31286-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0FcsLrfBemk3+QEAu9opvQ
	(envelope-from <linux-wireless+bounces-31286-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 29 Jan 2026 03:11:03 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A2F6AB0AC
	for <lists+linux-wireless@lfdr.de>; Thu, 29 Jan 2026 03:11:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A8C1330058F2
	for <lists+linux-wireless@lfdr.de>; Thu, 29 Jan 2026 02:11:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EE7521CC62;
	Thu, 29 Jan 2026 02:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JXiM1Cud"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51EE033F389
	for <linux-wireless@vger.kernel.org>; Thu, 29 Jan 2026 02:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769652659; cv=pass; b=j9cGSd23d9fL5acR3AQJUbgD4RIPhuLWX0Tn16yaxDSlGKaG8Hc2OmBdd1KccqTKz71YuSO7RTDh/5El907UrfUJbljQ+tW3vGhD1UeS13JnA1+nOh4G0nzoVJQv1iww3GJTxXdRabkROiHfjajqcQAlsWDau3LzKceLyn15ZtU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769652659; c=relaxed/simple;
	bh=fByyVhihXHxjSrgJQzL+aCEi37+gshl2meXl0Lr0+T0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iLfxZ6TGCEycbldLT2K5KL8hT6xIUNDoZ1s0XqoBF8JPSKi+kaiYBVB29Qxj/QKE2EY8iBKYz680P/TyBs9+pZQWmq1SjfRlOVGQP64oM1Ip4qVqBPt6PHmJrW0SNZI1KmOIiSa4gfMbbk5VjnITDNIjztacvfZ+WdJbJFBqujw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JXiM1Cud; arc=pass smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-6505d141d02so774990a12.3
        for <linux-wireless@vger.kernel.org>; Wed, 28 Jan 2026 18:10:53 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769652651; cv=none;
        d=google.com; s=arc-20240605;
        b=XmzYC3rN5k6BPKkxBbprzXPx5HXTPylg+uy/lH67teXclFDxoY7C/thYtSMokWEXXa
         F99jAXinsJFyeRKFCF2Pto21/awsoqMzknmeA0pwky4Fh6LGSgdGFA8qnWLd3CboMM08
         rM0KkF51tXd0D33j+46+g0nE5QRDwgaTgmynTSEkPAi7VOIUxmU+Qq4gcNjcqVq1L21w
         vkJNemE/qb8rVry23thi8z5ppry4dmD1Y40RqQGC5Fv5TyDkMhHEve/9vG5/tk8I3o4N
         wXq5p0dDVp2gKw5sTquB/VBfidbn5x9/9xpMXSZMthJ9ah2u89fnkVGZ0yTUSlH5fiuz
         mQJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=2urmzUjTyUEoXk3lBNO0jeySho24WOjeBPLbB1jDUvE=;
        fh=rOzXskxWYlVWAH0HNRqbVVwYe9c26EtGaaAfUpb3HVU=;
        b=FmDck5l0LJ0tZSIGzh1r0bZjEtxXnYjijSDODl/jMGEk3jFr5OiFdKyLolqNIsTXkc
         qVaTNuZ3vqlMgN9a1VKRqYZprj+/a+RJUsw1BixKu5PlJ+ymgNUqcZq1HPIPliIeVlZ8
         J/mD/XcaM7+NaTNLJOVKrJBzFCNFgpoPK0lRHkR70n7rdXFYO/RCvCp8vsOnrdwOhtWL
         e4guf2cLBkRCaFRM6h53cyCpLu1ekjnVBBhceAiDCsHyVHO55hVVrISly34zZy5lRUcN
         RYRpQc7BEa09bSws1hBCp+nHikxCYonOJuJNqPTyMvRlDs4e05v/MAZmPprVZgLluJws
         xjOQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769652651; x=1770257451; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2urmzUjTyUEoXk3lBNO0jeySho24WOjeBPLbB1jDUvE=;
        b=JXiM1Cud6bofQl/DbIJVM7Lm/gvCKaj6CVcjrpdsWgEX/YW/J9Ti+D879FZtpxWJl2
         s+JmpmSsyN23V/VLX60gGNWIs6R70AVDge5GLphfnhEhTQEPZ9lNcbkR1e7zDgRaz+lx
         A5wkV7ujlNBJMbzJAEZ7oWLYyT7KSlwfl7xpuS2Wzc4AddhgP5FL61zc3GVV+LB0QEGj
         3FLfglLIvSkkgLVQfGIjH+xhiItqv5Nbms4FipW2K1DeRVDFYYHiSUnhxSYkIMrFTsUM
         RBzO/6kwd40Mtu+dskXSCYG7ETvb1dNc0YiPqAUsT1bR5367bXJH3HCDrxKsEebrX/iv
         fiYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769652651; x=1770257451;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2urmzUjTyUEoXk3lBNO0jeySho24WOjeBPLbB1jDUvE=;
        b=TJ3kwE1mq7p5rtNppUv0Vmo4VilmMiLXuRSwxeZejq7bqs3YQOwi66XrLsUU9J+iXB
         1Zifpu01ZTBv52KWXtlA5iKTy2aiaxXNCbWZzvV6Z9FFgeeMmIhWOZ1/MX5LkoAQLUbB
         Zl8IKg9XXXHJ98413szyAi6QUJZHPH7i0uiFK+uxgkCraxA3wMDfGtHgMY1US/t3j5/j
         Bmf69BQCTd/xhM63Ea1oXF2aoZxN+oYCD2dXvOttUHVe2DKv6o0cmDWscw8rx/+E+GAo
         ZmYSvJVjaIUTI7peBurvDmikIXnD0nA20ijlha2vRjXUz7Q5gEJyqdbJiMbbYvBABpqM
         Ubjg==
X-Forwarded-Encrypted: i=1; AJvYcCWcZhtz2b4rdl7NnqnDTbeKSkxNfkH04vJNJsATI4sKybDivujDxzNRC87HoRRvf8WH6tQYoR6n97aTrhIuaA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwxiTG4MSUt+z6Ew0P3uVBcianz0WceSmCHgAYaK+ATa43LBA+A
	/tZxiE748T9uP+k/7CZg0Da9UeFnLk9W9DYvFtlfTfwYl9+gDV3JtbCm7t7I1sEE+rVF+G3yOTH
	StkyyKU97bFCR9yib3vuLWriHPkDRtwE=
X-Gm-Gg: AZuq6aLVbVGZzGNd+dQbLpPqr83qLD8t5/p1PF2sVJp96v1VuxW4Pq1/lfXCoRlOPJp
	LZPbU5W6IaZCpCHOdCGsd7NeWodtdwLiP9iXhk+Y5rDZcZwQbDikKTKFKvGsKULc2gxS4cLUiBS
	jWP+6zK+kFPLxfxz0CLwPSOnwTZnO0wC0PZofmdyTomLot1VTvFJTexHFrPGFq2/7Aq0HQiFuRp
	0q3/8SR6npxqti/iPPHmGxQFjo0FNWRQ2kaDxMECz2HHFsVsC0Uyw4wsewZtrVlmFIquyE=
X-Received: by 2002:a05:6402:1469:b0:658:bab5:5801 with SMTP id
 4fb4d7f45d1cf-658bab55b16mr2555056a12.5.1769652650452; Wed, 28 Jan 2026
 18:10:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260128102525.872517-1-gaurav.kansal@nic.in>
In-Reply-To: <20260128102525.872517-1-gaurav.kansal@nic.in>
From: Ping-Ke Shih <pkshih@gmail.com>
Date: Thu, 29 Jan 2026 10:10:39 +0800
X-Gm-Features: AZwV_Qi_Nx51l-T8bisCdD1uffOdSFXKZ_6OXeIMqTZp6aDGseGCDs00nccdhkY
Message-ID: <CAHrRpuk7Xqab+BC57m_5KWJVr8rc+_LHWwKr-pWmvR3y9W2ghA@mail.gmail.com>
Subject: Re: [PATCH] wireless-regdb: add IN rules for lower 6 GHz (5925-6425
 MHz) LPI and VLP
To: gaurav.kansal@nic.in
Cc: wens@kernel.org, linux-wireless@vger.kernel.org, 
	wireless-regdb@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-31286-lists,linux-wireless=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pkshih@gmail.com,linux-wireless@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,mail.gmail.com:mid,wikipedia.org:url,dot.gov.in:url]
X-Rspamd-Queue-Id: 5A2F6AB0AC
X-Rspamd-Action: no action

<gaurav.kansal@nic.in> wrote=EF=BC=9A
>
> From: Gaurav Kansal <gaurav.kansal@nic.in>
>
>     DoT / Gazette notification (20 Jan 2026) delicensed lower 6 GHz (5925=
-6425 MHz).
>     Add rules for:
>      - Low Power Indoor (LPI) 5925-6425 MHz, up to 1000 mW (30 dBm) EIRP,=
 NO-OUTDOOR
>      - Very Low Power (VLP) 5925-6425 MHz, up to 25 mW (14 dBm) EIRP
>
>     References:
>      - DoT / Gazette notification (Jan 20, 2026)
>        https://blog.gauravkansal.in/2026/01/Gazette%20on%20the%20Use%20of=
%20Low%20Power%20and%20Very%20Low%20Power%20Wireless%20Access%20System%20in=
%20Lower%206%20GHz%20band%20-%202026.pdf

Is it possible to tag original official link?

>        https://blog.gauravkansal.in/2026/01/Opening-India-Lower-6-GHz-Ban=
d-for-Wireless-Use:-A-Strategic-Regulatory-Landmark.html
>        https://en.wikipedia.org/w/index.php?title=3DList_of_WLAN_channels=
#India_2
>      - Linux wireless-regdb db.txt format docs
>     Signed-off-by: Gaurav Kansal gaurav.kansal@nic.in
> ---
>  db.txt | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/db.txt b/db.txt
> index dc72989..0f90f6e 100644
> --- a/db.txt
> +++ b/db.txt
> @@ -974,12 +974,20 @@ country IL: DFS-ETSI
>  # Source:
>  # https://dot.gov.in/spectrummanagement/delicensing-24-24835-ghz-band-gs=
r-45-e-5150-5350-ghz-gsr-46-e-and-5725-5875-ghz
>  # https://dot.gov.in/spectrummanagement/license-exemption-5-ghz-gsr-1048=
e-dated-22102018
> +# Info about 6 GHz added by Gaurav Kansal (gaurav.kansal@nic.in)
> +# Lower 6 GHz delicensed for India: 5925-6425 MHz (on 21.Jan.2026)
> +# LPI: Low Power Indoor (indoor only) =E2=80=94 1000 mW =3D 30 dBm EIRP
> +# VLP: Very Low Power (outdoor allowed at very low EIRP) =E2=80=94 25 mW=
 =3D 14 dBm EIRP
> +# https://blog.gauravkansal.in/2026/01/Opening-India-Lower-6-GHz-Band-fo=
r-Wireless-Use:-A-Strategic-Regulatory-Landmark.html
> +# https://blog.gauravkansal.in/2026/01/Gazette%20on%20the%20Use%20of%20L=
ow%20Power%20and%20Very%20Low%20Power%20Wireless%20Access%20System%20in%20L=
ower%206%20GHz%20band%20-%202026.pdf
>  country IN:
>         (2402 - 2482 @ 40), (30)
>         (5150 - 5250 @ 80), (30)
>         (5250 - 5350 @ 80), (24), DFS
>         (5470 - 5725 @ 160), (24), DFS
>         (5725 - 5875 @ 80), (30)
> +       (5925 - 6425 @ 320), (1000 mW), NO-OUTDOOR, AUTO-BW

I'd prefer in unit of dBm as [1].

I think no need AUTO-BW that is to merge adjacent rules to have large bandw=
idth.

> +        (5925 - 6425 @ 320), (25 mW), AUTO-BW

Use tab as indent instead.

I'm not aware we can possibly have two entries with the same frequency rang=
e,
and I only added one entry for indoor (or no indoor/outdoor restriction) be=
fore.
Checking freq_reg_info_regd(), I think only first matched entry is adopted,=
 but
no error to build reg-db by 'make'.

>
>  # Source:
>  # https://asnad.cra.ir/fa/Public/Documents/Details/73af8590-f065-eb11-96=
8f-0050569b0899
> --
> 2.47.3
>
>

