Return-Path: <linux-wireless+bounces-4805-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FAFD87DCCC
	for <lists+linux-wireless@lfdr.de>; Sun, 17 Mar 2024 10:53:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BA9901F211DF
	for <lists+linux-wireless@lfdr.de>; Sun, 17 Mar 2024 09:53:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C54321429E;
	Sun, 17 Mar 2024 09:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fbo+qHJw"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1045414285
	for <linux-wireless@vger.kernel.org>; Sun, 17 Mar 2024 09:53:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710669199; cv=none; b=r2SNwDA81wKhGYuGcfPnUSs7uo27GfjXgMF3KbW3lE3wt3CfycDkkeUoMS4SUU/qTSdnPyJcjMiN3Y3J9V+oykc9cxgIRrPvUu/6AxxABl8RArHQCJVMszFiXsnPFaPsBO2HurRUajqO005XnDrY1AWrrhIlknqnNLWS9vAlwD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710669199; c=relaxed/simple;
	bh=xvfN9bHNxyDdwX7pxgBfNlNfHwuWkocrRTbBNz73WuI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OFxmksPkUXRNfiOmGXk+0pTg+sIZwdT37o3QJFQ0hpdsVRnkncbLKsckHYaNBZuIPDpJpQD1hbcmAO+7+2qwOzPBRa0aOonLXqRY34H058P5ykUxraz0a2HM0IuPzExwOk75Pj8Wj2HDJSXXdv/Kv3VJMLbGYLUMkdxi4zZUAk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fbo+qHJw; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a46ac74611bso105828166b.0
        for <linux-wireless@vger.kernel.org>; Sun, 17 Mar 2024 02:53:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710669196; x=1711273996; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O+kvfkm2+T1FsF0Lyu3Z24EAkdOeNAuipAJCjA7UiDg=;
        b=fbo+qHJwMivbUeFD02qQ3+YoO8rq0HyIBYkh1AKlnJazR4xdEd2I4G0kpQ297hSeF3
         krKhKWdjtmEaw4tSGi1o3Ga1XDscg5a8YRcfXIvK4PgP7Rul2ZGw4A6V1G1YG1wRRNqK
         IlmOGZIsgNGkorDoRLMKU/pr4FXJBj7YZWauL3yEUhvHkR9D3kCHDqwDbYAyzOsKXUmK
         HSqcEMBxAKNq56zYXN+OLkCi9IukQyJsxfZ9Gs3eo4Eet1w4A8Iy4jPBPdU7gpErNsuN
         rZ8rjqKxDXt5BpUkwT2oAsb5mdw15y66gWeef9oYtMojiD/MywUrfgVRx5EW1dK0WMFM
         Fr0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710669196; x=1711273996;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O+kvfkm2+T1FsF0Lyu3Z24EAkdOeNAuipAJCjA7UiDg=;
        b=n8nuUQaXLm+MfNymfleXGwMQ2zrvmQvk2tZFKGXAppuAT5db/AiHxM/NOY6amdsxC6
         k9UH3S7wIT+Djgnm5IhB6tc2n9/Fz0bq5HGnSqZdealir7zRcHXbLclq7QCU/0nNRLuU
         LNlxwM9zDjOuRMLYnUysXghv1QaKvzFyDNknkVEiUk6gezKaMUZtzL6EZ35O+b0A/4AE
         9eb+ECx2vE8HQ3Pf2pwjvh2t644TW4JG/iO2Ow5Y0ZihC9f6fh4kytBGAA99fNiJPwIe
         QelfKv++QMEYFTWeC60ydPj16Zmie2XeoQ5jthNZOYkapKe/h7HIpW4HDZQMqLLgQhqI
         1WOw==
X-Gm-Message-State: AOJu0Yw0d31hWO7Plh3FGlIsTy1mnk39jEDFNtHJ+NWf8ZAg3T1YIK9f
	13qlFAkk27Fqv3tC+Iy3XlwUu0phWSGMoHvtfEEuATb/8GPKp6kZ2kZGVsHPEkai9uIg7UfMHHV
	RrrVFcEVqW1UjwIa7w+vKS5S1JewEdOaRC+Q=
X-Google-Smtp-Source: AGHT+IG4XCVrOTfJLaOa29sN69dat7+r6sQr8+Fj1uyC2oVFY1bmND6D1Hnk7o2xmc1pC6QdirnV5hQtGKLwq4p2XVU=
X-Received: by 2002:a17:907:a687:b0:a46:1e21:3739 with SMTP id
 vv7-20020a170907a68700b00a461e213739mr8666647ejc.6.1710669196191; Sun, 17 Mar
 2024 02:53:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAFED-j=3_xLuJFp5R_gThMtv2C6r6WzRxzrY3_wjFTn=XJQLwg@mail.gmail.com>
 <bb884b84dbaa1c97f9d3a1e610f98ec6e069a706.camel@sipsolutions.net>
In-Reply-To: <bb884b84dbaa1c97f9d3a1e610f98ec6e069a706.camel@sipsolutions.net>
From: Janusz Dziedzic <janusz.dziedzic@gmail.com>
Date: Sun, 17 Mar 2024 10:53:04 +0100
Message-ID: <CAFED-jkowv0GTtWUC3=HwGNjzwe8d2F-m_QrZratdpA5HnkuBA@mail.gmail.com>
Subject: Re: BE200 - 6.5 backports - disabled EHT issue
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-wireless <linux-wireless@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

pt., 15 mar 2024 o 19:04 Johannes Berg <johannes@sipsolutions.net> napisa=
=C5=82(a):
>
> >
> > I see this one do this:
> >  if (!ieee80211_verify_sta_eht_mcs_support(sdata, sband, eht_oper))
> >       *conn_flags |=3D IEEE80211_CONN_DISABLE_EHT;
> >
> > Testing on openwrt and using backports.
> > Is there some patch I can easy cherry-pick to fix it?
> > So far just disable ieee80211_verify_sta_eht_mcs_support() check and
> > BE200 works in EHT mode correctly.
>
> Then either the code there or the AP is broken?
>
> That function checks that the client supports the MCSes that the AP
> requires. If it lets you connect without them, then it's broken. If the
> checks there are wrong, the code is broken :)
>
> I guess you can capture the assoc response frame and we can check
> manually.
Added such dbg:

printk(KERN_ERR "%d vs %d, %d vs %d\n",
                                req_rx_nss, have_rx_nss,
                                req_tx_nss, have_tx_nss);
                        if (req_rx_nss > have_rx_nss ||
                            req_tx_nss > have_tx_nss)
                                return false;

[   70.243183] ieee80211_verify_sta_eht_mcs_support nss 4  -
(ARRAY_SIZE(req->rx_tx_max_nss))
[   70.248336] 4 vs 2, 4 vs 2
[   70.251035] disable EHT due to mcs
[   70.260724] wlan1: send auth to ....

AP have 4 NSS.
Will dig more ...

BR
Janusz

