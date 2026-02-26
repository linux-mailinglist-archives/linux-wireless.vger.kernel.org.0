Return-Path: <linux-wireless+bounces-32235-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YAm3ByzeoGk4nwQAu9opvQ
	(envelope-from <linux-wireless+bounces-32235-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Feb 2026 00:58:36 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 73D961B1142
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Feb 2026 00:58:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BEE41300576B
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Feb 2026 23:58:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72116332EC9;
	Thu, 26 Feb 2026 23:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L6s2bZ/D"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BEC032939F
	for <linux-wireless@vger.kernel.org>; Thu, 26 Feb 2026 23:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772150304; cv=pass; b=hSQ1c/zfvHvmBntwKCxD9vgoQhmQtXaMHg7h92R5nkzIDPc87KIiLK/uAS70p4Ujf4yCCSaURIOKGFOT/tYdevP71njmhYU1sMOzvNjUDZLN+mdV7r24dHqqRITd9zRqtnpHcAfwGg4NuKtNrWQb40CW+voWIKl/ijH5AaOfgGk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772150304; c=relaxed/simple;
	bh=YVx5+6Qaw5SyLfYVVbVkKbJUWeX1JhzIJ19FkF/nVo4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RBIXgVUUJUTPkfGCRNiLmZSmwSrSLE/yKa5WK1kUlhsrLR2CXgCnkYuaT0Y9B9tycnYsaIVf+DTebrnQj5PPmTphccTzDvCWh5rgBrS48M8DlbcNTl7WOqZ6aXGCS5spYLQQEOMZKWNhxOb2IWoNb3i0tPrGyELT01GDTKRzPBI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L6s2bZ/D; arc=pass smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-b9358dd7f79so203180766b.1
        for <linux-wireless@vger.kernel.org>; Thu, 26 Feb 2026 15:58:21 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772150300; cv=none;
        d=google.com; s=arc-20240605;
        b=gGF5taJIhac6M3DlOyxek18KKFTQF2AzKy45sYkz8I21Ll2himYD3f25a73NSSSjRX
         EeUULEEKZTgW67Rplz4BrzUeAJnlK10CnzByCiUuZUcBsXhQb5INvAbgNLpQJf6rA8KJ
         7v69wBiHTSGZx6GB4fvBlk5BFc7wQ4D26fWjXt7zdZ9pu3msES26IRpBixE8hojd4VrV
         6gBOkA6wqOGTx50wjvqq/fEAXJXXh+4RJqPbFnLwXoTEWULRHirWKvX8QDDSasZgp+2x
         bs2VRLgpbQl6SVEvTVn0yBkauSBEX2E6/xbEd8inZ8Ao9pC09+yAHzZ0UqPFHkWcE0yg
         I5Og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=/nP5GGHkkXZuwZNtRkKD1sCwS459ee3qU6k4+ObnBnM=;
        fh=cO5i9jkqk8V1PSFqmpfSvjrZj9uGTsprsLwlv4NmTxg=;
        b=cKSuSw07bAU8Q7Gs+adIxmCMXqwksGXDzaMv5XAjsU48QV1jXKee+4rEE7aUBGjwX+
         ALRrW+KZlaWRVy0w08XxBavS2igh1KZqpR4LyZCdwbFkF8kFZSmdeIkYMAHfBKAalqFi
         yIsDARlCARIk/7KOaKDPUxDVhVXxx/p4j713h4+ZTHu0WswHEYEFFVqxdYiXJtVZCl8T
         +iTMUBnFgz7Y6jIDDtZ135tCMyPizFhN2OrJ1a57A2MdBGUM6YBKxx0T6WsxeVWVwDKe
         sB6egtKA/Z9mZT2gDt6CjN4xVAxNfuaF8kNNdfsfr6ZqHA4He4Qh3Bo83Nm2Sf+Fo2ua
         54XQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772150300; x=1772755100; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/nP5GGHkkXZuwZNtRkKD1sCwS459ee3qU6k4+ObnBnM=;
        b=L6s2bZ/DIojaQgO8eK/MiH0XGb7LdXHDf3vb4aZPRcFoqzM3t1R//lM/BtKVfknHXl
         YjKRf8DNfACYGyboCt4mZwaBmpshvJ36YKZqj8QiU6lTwI7NBBZ2grKz7fu7sdacdx0d
         h3OiRjxxi1eqJVht6o+s23roijbCD2SrLODNQZPay55kduCjgiCLHwDfhPhx8mL/nljr
         GeL51dZDI3EVkRJZi9HzFk3EZ0n3TxL2xIeG6l7dwAyCC6J3czLV9V3qoMy9UDjgrKBY
         HhYTD3oXF3FhmNnWqTEzf2WaF2vQpqVxINOLmMN4nnAoSHD0xudp3wx3CaUqH/4eggKp
         93UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772150300; x=1772755100;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/nP5GGHkkXZuwZNtRkKD1sCwS459ee3qU6k4+ObnBnM=;
        b=vpYgXPI7PrPSN0/ehxPvUe+El2Q2bPxM5K36pTnSCA/FQ5kz5qAPlHOcsf3OH/wV9C
         vlzKYG4Z6LJLBJcKOaFYnqp8mKGVZcQlJSArsQnUQNf9CjGXmnk/0s5ThJSCIeSlmSwm
         1Lw20QuIN3T974RWpp7fG49fJLLckYhFAArk0tfc/MnnZHGXhUMkVaZZ6qslHTHPzh/i
         Jsi7V7XaGNK+I1wwNm+jpHYdp+Scj5vD9kxzEC+5X4s/4umZ7C/EcgqRVJ9xR2r2d2S3
         KUKG3eiXHvhhUvVfi2weTXV5yr/WXRPCaOkcVkgR8GkvTSveycDNjn02XQPwAvlRY8Xf
         xOIA==
X-Gm-Message-State: AOJu0YzVa0Z9n2VEWJzbGglPXTO3G7qe1IuXqjzSXSEWkOh03dISYpj1
	nAQd+8Ud8YhDvV1K1zOBugdR4CpRWEgrPHugIYNfzalcIhdqF3hGJujn8IN04HcJx5+SfQTpvII
	CLIII8i/+PmKX6AyeiVxarOvAC+msL4o=
X-Gm-Gg: ATEYQzy8SI+XsaG7eXGcdbJPzeqO0n7ZhnD7XrfUBTQ5QE+dFqkUfCnIBLe5FPV8goZ
	OFxZmoRhHQnynj+t4VEdeS7sC3PdTWYGIIwwTMRw5lJ4HK7NK4yPUIKlpW5i79JWLKrHf1D6fjC
	rG6iZCZMXqGx8RoC8tPqcuxd1/f5FlbE+6y6O7X3vmskxgvRwbgKj0q/x4XlAXqzcjVXo7Mg2Gq
	zQjNTnaGgyorMu57rwrHSYwvOFx6q6nK2B5wlTwjlEzWNiX46VabDdP3Ox0hXoCkV7bjCrq0EqP
	+fnyYhroqZgkIuV0OEE+gsSu0STXcr6vBB2bosIDJLQ5oOqVk/AcJuUbvzeqCyYnayyFlMm2kK/
	3GAfFcg==
X-Received: by 2002:a17:907:9806:b0:b7d:1cbb:5deb with SMTP id
 a640c23a62f3a-b93763d7356mr47652366b.27.1772150300288; Thu, 26 Feb 2026
 15:58:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260223030803.19451-1-rosenp@gmail.com> <cf50211c-4f0c-45e3-860d-220b49f4cc11@kernel.org>
In-Reply-To: <cf50211c-4f0c-45e3-860d-220b49f4cc11@kernel.org>
From: Rosen Penev <rosenp@gmail.com>
Date: Thu, 26 Feb 2026 15:58:08 -0800
X-Gm-Features: AaiRm50RBxGMSSC2HWucqLabspLbzT8FNPaRJX3UJb1mqBmOogXK4IvquwKsB30
Message-ID: <CAKxU2N-cq+nOQD0JNeuBESO13vfd9QOW1MO3AdM5YwK3BcA57w@mail.gmail.com>
Subject: Re: [PATCH ath-next] wifi: ath5k: ahb: use devm for ioremap
To: Jiri Slaby <jirislaby@kernel.org>
Cc: linux-wireless@vger.kernel.org, Nick Kossifidis <mickflemm@gmail.com>, 
	Luis Chamberlain <mcgrof@kernel.org>, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-32235-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,kernel.org];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rosenp@gmail.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 73D961B1142
X-Rspamd-Action: no action

On Tue, Feb 24, 2026 at 10:23=E2=80=AFAM Jiri Slaby <jirislaby@kernel.org> =
wrote:
>
> On 23. 02. 26, 4:08, Rosen Penev wrote:
> > Simplifies the code by quite a bit in probe.
> >
> > Also allows removing a goto and returning directly.
>
> Looks good except:
>
> > --- a/drivers/net/wireless/ath/ath5k/ahb.c
> > +++ b/drivers/net/wireless/ath/ath5k/ahb.c
> ...
> > @@ -95,35 +94,21 @@ static int ath_ahb_probe(struct platform_device *pd=
ev)
> >
> >       if (!dev_get_platdata(&pdev->dev)) {
> >               dev_err(&pdev->dev, "no platform data specified\n");
> > -             ret =3D -EINVAL;
> > -             goto err_out;
> > +             return -EINVAL;
> >       }
> >
> > -     res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
> > -     if (res =3D=3D NULL) {
> > -             dev_err(&pdev->dev, "no memory resource found\n");
> > -             ret =3D -ENXIO;
> > -             goto err_out;
> > -     }
> > -
> > -     mem =3D ioremap(res->start, resource_size(res));
> > -     if (mem =3D=3D NULL) {
> > -             dev_err(&pdev->dev, "ioremap failed\n");
> > -             ret =3D -ENOMEM;
> > -             goto err_out;
> > -     }
> > +     mem =3D devm_platform_ioremap_resources(pdev, 0);
>
> Is this a typo or devm_platform_ioremap_resources() is new?
typo. Looks like COMPILE_TEST is needed.
>
> --
> js
> suse labs

