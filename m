Return-Path: <linux-wireless+bounces-26365-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D6A3B24BB8
	for <lists+linux-wireless@lfdr.de>; Wed, 13 Aug 2025 16:17:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 17B963B8628
	for <lists+linux-wireless@lfdr.de>; Wed, 13 Aug 2025 14:13:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7405E2E9EA1;
	Wed, 13 Aug 2025 14:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nTQy73FU"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E33352EAB6A;
	Wed, 13 Aug 2025 14:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755094424; cv=none; b=WVBs4YLtvMz4WN3zsYARJRWZDy5pVheAspz18qNG7xuBiSHE9drSoKPDwwAxGs6dlxO7jV8GFElKi1+iFT/IwIOnvwaol5d7a1mioimDvUIT0ZguKf1DaBJ73Rm7zki4lfgYBKYSK4P8gu7JtCMccvivroSHsxJ0UOGcQJmL5ws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755094424; c=relaxed/simple;
	bh=1806fHgVHrvXvwwYH4cO0aCEnas1j5+fCDRQvdoKNsQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CjEXmX8RXBZ84OMgn/HDK031hQaDJYtEnyvxg4acS6rHPoLAGnHDoOz7I2mmn66MbEsXGgtMrTVr38Y+GqwtSzXZSXuYV0051DeKlgnGQ0pponMHe2JgJ4mdM78bSqctnmsKVurtq/ePGmVJmEMs2hw4U5bEUwc2RxmxypMWSxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nTQy73FU; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-4b0632ae199so14846841cf.1;
        Wed, 13 Aug 2025 07:13:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755094422; x=1755699222; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WARLCY0cBcmQtgbWBsLZHA7KrPzPqDIpjlTk0tlOfnk=;
        b=nTQy73FUxHAKoRTGiMJAgGM98lznbPIPFGkYKUJIU8TBQnAdFIdOrIP9OT11Sltily
         S+FQM4fs9SKER4Eh5MDris/xWpmyeEPkDmD7AiLfnf6pn3zFDbSb0ebUUkLingcTCGMB
         NclwcQ5iEqhDBToZki2s5yAdmVLIFa60VoGnrldS8ZXOouvHfVY3L+Y+w5XMZYarfXc2
         HEK/gopoPoV/Ugu/TABjroHaaOFtZKcgbWgXEUjcnUp+bCNUjpPVnISMJf2SHrL2O3GR
         9lDjI7cfKFlwY78pcYKP2kTLw0auhgrPOqEjIVTl8apEsTfGJuCB9jtYq0SUrRggrTmk
         AY/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755094422; x=1755699222;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WARLCY0cBcmQtgbWBsLZHA7KrPzPqDIpjlTk0tlOfnk=;
        b=uv+CFcFo6r2XmCEwb83tGbqPczayXbWxEZo4aU+X3jNmvbVBvYYw2zBdPARgifxUqP
         AthmeAawO5LUfK4wLJ3h3XUS2mm5AviV6LcSL+YAO/SovEjrmUuigY7D+jQF3r/x9VD3
         +MmuimCpR26dUsr5JfCaLQ3eYjH4Vceo457uqpmL5uqMI0F/L1enxhJc90pIbEoRmHM5
         JU0T/Z8NkGwYG+OE7iVSVbIs6NJEkNFc5xaiPhxSBdLIQ5GpuQNG9KDTEVqMbW+I30HD
         QDe1wyF6pA7T26AIS7o8plTvRO2Gb7Vk25ohz1VmKEE6z7vrvvpRd22LBZmL1Y1YZkat
         pe+A==
X-Forwarded-Encrypted: i=1; AJvYcCUjwgjjzfH+yrCG42hGHTOg0KGwAl1G2fnHcveP/pU6HLWXfW1AoRuTgzI7iu7elSGJ/3Sfq4zYdcPEutU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzAKyFX7nVHNr6gm4q3H8jsbbYI/PCybp3oExgg6IEsdCnxqYyS
	/wdB+e9DnXOvegc3dL9p4W9/+JvUKL832TGKCuhwyazVLs0ZVnuxMCzYm+Fu1UUoeAjFBstZW5N
	2aPvih3l38gJg5P2+ICXtznZMW0Q5pf8=
X-Gm-Gg: ASbGncvlbENXDHmOqaDy3fQp1roCq8apdDUxOxpNLc3ux64oFj3MAXxVjDpJp2b6eXG
	bSNwbzD+1MtcSxRj7ZSxwJn+EkMdMM47vIbCCR3AppidGLdCUKTgcsnK7Uy4/PuMYnmp+IGh0+L
	CR1LC6wzMWJHb9LbDhxmNCtZJzG4xNsL8J5ncUWY6A29KP5CXtZnBKNdqpWjaVK3pWpI92AwNAW
	zBHcg==
X-Google-Smtp-Source: AGHT+IH0OUqPFF2OAmBmmyQVnYWrTf+kgSA3SmC4KfOBUbYLHJEpW1sWKER2B6fu0r7fb47UrSCF0PfRfse3xIEirFQ=
X-Received: by 2002:ac8:5981:0:b0:4ab:6d02:c061 with SMTP id
 d75a77b69052e-4b0fc6ee4d9mr18190961cf.6.1755094421607; Wed, 13 Aug 2025
 07:13:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250705134810.197494-1-miguelgarciaroman8@gmail.com> <DB5MMOAEFZZU.5TK1BDNOTFEO@bootlin.com>
In-Reply-To: <DB5MMOAEFZZU.5TK1BDNOTFEO@bootlin.com>
From: =?UTF-8?B?TWlndWVsIEdhcmPDrWEgUm9tw6Fu?= <miguelgarciaroman8@gmail.com>
Date: Wed, 13 Aug 2025 16:13:29 +0200
X-Gm-Features: Ac12FXwEIJRL4UB-B460eVYTQqv1Yu6V-YfbLfnCrluBzhLSBPK4mTm4ZR6Hnck
Message-ID: <CABKbRo+7=_p=yt02FsCtTksA5C0_eS2LHt-FMkE1ddpuaEDJ6w@mail.gmail.com>
Subject: Re: [PATCH] wilc1000: replace deprecated strcpy() with strscpy()
To: =?UTF-8?Q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org, 
	ajay.kathat@microchip.com, claudiu.beznea@tuxon.dev, marex@denx.de, 
	kvalo@kernel.org, skhan@linuxfoundation.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Gentle ping.

Just checking if anything else is needed for this patch.
Reviewed-by: Alexis Lothor=C3=A9 <alexis.lothore@bootlin.com>
Thanks!

El lun, 7 jul 2025 a las 8:58, Alexis Lothor=C3=A9
(<alexis.lothore@bootlin.com>) escribi=C3=B3:
>
> Hi,
>
> On Sat Jul 5, 2025 at 3:48 PM CEST, Miguel Garc=C3=ADa wrote:
> > strcpy() is deprecated for NUL-terminated strings.  Replace the single
> > instance in wilc1000 netdev setup with strscpy(), which guarantees
> > NUL-termination and prevents overflow.
> >
> > ndev->name is a fixed-size buffer (IFNAMSIZ, 16 bytes).
> >
> > Signed-off-by: Miguel Garc=C3=ADa <miguelgarciaroman8@gmail.com>
>
> LGTM, thanks for the update
>
> Reviewed-by: Alexis Lothor=C3=A9 <alexis.lothore@bootlin.com>
>
> > ---
> >  drivers/net/wireless/microchip/wilc1000/netdev.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/net/wireless/microchip/wilc1000/netdev.c b/drivers=
/net/wireless/microchip/wilc1000/netdev.c
> > index af298021e050..8f4d11e1a2a6 100644
> > --- a/drivers/net/wireless/microchip/wilc1000/netdev.c
> > +++ b/drivers/net/wireless/microchip/wilc1000/netdev.c
> > @@ -960,7 +960,7 @@ struct wilc_vif *wilc_netdev_ifc_init(struct wilc *=
wl, const char *name,
> >
> >       vif =3D netdev_priv(ndev);
> >       ndev->ieee80211_ptr =3D &vif->priv.wdev;
> > -     strcpy(ndev->name, name);
> > +     strscpy(ndev->name, name, sizeof(ndev->name));
> >       vif->wilc =3D wl;
> >       vif->ndev =3D ndev;
> >       ndev->ml_priv =3D vif;
>
>
>
>
> --
> Alexis Lothor=C3=A9, Bootlin
> Embedded Linux and Kernel engineering
> https://bootlin.com
>

