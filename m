Return-Path: <linux-wireless+bounces-6320-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A1578A4C79
	for <lists+linux-wireless@lfdr.de>; Mon, 15 Apr 2024 12:26:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C0B37B213ED
	for <lists+linux-wireless@lfdr.de>; Mon, 15 Apr 2024 10:26:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B672158118;
	Mon, 15 Apr 2024 10:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GZ9O1bx9"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1045D4AEF4
	for <linux-wireless@vger.kernel.org>; Mon, 15 Apr 2024 10:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713176808; cv=none; b=RWWsWsJIvzIFJMMQFkXFCwZChkqRNqcCiHj6223tJSL/OCiYp2E/xVI7zJOHkA1eI1HW1EvsW90jKGPMgqEqE9dbdUVDJ0uZmo2NAbgMHj9kQTFVqMe01/DtF4fSQLtgz2NIMdS51hyEBhTSwMEdGyBEaPuuBoKTZalrx/B2A3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713176808; c=relaxed/simple;
	bh=+BHrAMFwJSSm6o0rGXkwRH4LGcM9VFchcmDUV8M4nsg=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Cc:Subject:From:
	 References:In-Reply-To; b=XiuB6zUdnvhXmG/6zuMzPst5cLHTP3N7EVDDUl12UHxi+Qd51vFDQgYLAmvahQBJwgAbC86kdFTjFTZXzL8Xkuf6pWpeFH4CHzvzAp0VEd1bn70FmmfKfbTCylFdH8B0WaeXbokIk+ATmn7cKg5uLLjIrftVDEcgT0YKreKdliA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GZ9O1bx9; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-41550858cabso18557935e9.2
        for <linux-wireless@vger.kernel.org>; Mon, 15 Apr 2024 03:26:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713176805; x=1713781605; darn=vger.kernel.org;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i/Y/NbqZxDj+kqOqdtLhlNs19TdoZG5mB8hj9HN7FnI=;
        b=GZ9O1bx9NfwQ9SRFJ8v3IYLF4faqtedE19t0UTn4byHYVBAsuM+Ljw0LvXLsY+wRSF
         6wTgSQrlQMZsKRJ7Rj5cCIN/Q9ejAoB2L2H02tAfWF1knKv4AbX+AihOLfl3Mfc40Tq6
         teMc7qG4j5paMq2Fep9o+tsHMmo84kAPFeTHAAt3xcX70wdlWIeopzuUQOEb55yta3TB
         M5Pj/0GDajbN1Gnipg+SUsnnhkDVvTWnKPe9CiHZlhVs6FSvdRetd5wFqpDTUpnlYCPJ
         VGnD3F285Gl8VaD7dH051Tw43I8UuAwJtUEclJ40ZZ32QJjC8YJ64MWOqGCxFnwyHrqf
         FbXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713176805; x=1713781605;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=i/Y/NbqZxDj+kqOqdtLhlNs19TdoZG5mB8hj9HN7FnI=;
        b=SLSGv7qRaM4G9EL/M9cuIar82JQ2g3mg/JcRaPElPrtwgfNuqea67NiNLgN3WIio/t
         YPWJeq8aoY+CUfosRK8aDg5gx5zRz3NdgTJnvGin9W8PGlfMP/fERyPhFp1cUXoocdVq
         D/TrBjt0JXtbuyuqEQOhMlk1aHDVjbkRy13SuVT4egrMb1zrm+pTM3te3qDr14+8LYUb
         VKvkPlr0K5RWBz4uHGjLRHREkGVvbBDihXZKZpVid7/PEcWgdzU1T74R/WdAmKtRVPxe
         Sndc8Ii2KMrVwe0ySBViTZUVvhK9TCL1Y7MRgU+uTJbPvQZ5a3/0re95ZorZxXtQIuiF
         LoOA==
X-Forwarded-Encrypted: i=1; AJvYcCUa8MYLz3wn4GbU7GgdMIQvRBasKNKQyzStvCCzXvQAKAPYfVtPllv3VRCdxZvimBVDMV9LNDod6pxluEcS+u/aWzlTEwh6vow/ThtvOU0=
X-Gm-Message-State: AOJu0Yxt7manx9oTP7/KqkdpRnj0y0pdpeFEEC91Fqba2QKfXomntrQr
	DErbh5r77/aLGuVSasCTBokRHqaKlL8GxsSbmoqD+4NfLJ98Y2UM
X-Google-Smtp-Source: AGHT+IGvKvf5HKbu50Yr8KwlSHELhAlYVvkeipf2VYz/Kv5xegJ8UnkNOufy+E3a6hs3rUhlP5GLsw==
X-Received: by 2002:a05:6000:12c6:b0:346:c7ed:22de with SMTP id l6-20020a05600012c600b00346c7ed22demr5609992wrx.14.1713176805080;
        Mon, 15 Apr 2024 03:26:45 -0700 (PDT)
Received: from localhost ([2a01:e0a:0:2100:9290:7e66:a4db:ab5a])
        by smtp.gmail.com with ESMTPSA id l8-20020a5d4808000000b0034599eca6c9sm11619063wrq.41.2024.04.15.03.26.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Apr 2024 03:26:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 15 Apr 2024 12:26:44 +0200
Message-Id: <D0KMHQSFOY0B.3P66MD08H96FZ@gmail.com>
To: =?utf-8?b?TWluZ3llbiBIc2llaCAo6Kyd5piO6Ku6KQ==?=
 <Mingyen.Hsieh@mediatek.com>, "nbd@nbd.name" <nbd@nbd.name>,
 "lorenzo@kernel.org" <lorenzo@kernel.org>
Cc: "linux-mediatek@lists.infradead.org"
 <linux-mediatek@lists.infradead.org>,
 =?utf-8?b?TGVvbiBZZW4gKOmhj+iJr+WEkik=?= <Leon.Yen@mediatek.com>,
 =?utf-8?b?RGVyZW4gV3UgKOatpuW+t+S7gSk=?= <Deren.Wu@mediatek.com>,
 =?utf-8?b?U2hheW5lIENoZW4gKOmZs+i7kuS4nik=?= <Shayne.Chen@mediatek.com>,
 =?utf-8?b?UXVhbiBaaG91ICjlkajlhagp?= <Quan.Zhou@mediatek.com>, "Sean Wang"
 <Sean.Wang@mediatek.com>, =?utf-8?b?S00gTGluICjmnpfmmIbmsJEp?=
 <km.lin@mediatek.com>, =?utf-8?b?U291bCBIdWFuZyAo6buD6Iez5pi2KQ==?=
 <Soul.Huang@mediatek.com>, =?utf-8?b?UG9zaCBTdW4gKOWtq+eRnuW7tyk=?=
 <posh.sun@mediatek.com>, =?utf-8?b?RXJpYy1TWSBDaGFuZyAo5by15pu45rqQKQ==?=
 <Eric-SY.Chang@mediatek.com>, =?utf-8?b?Q0ggWWVoICjokYnlv5fosaop?=
 <ch.yeh@mediatek.com>, =?utf-8?b?Um9iaW4gQ2hpdSAo6YKx5ZyL5r+xKQ==?=
 <robin.chiu@mediatek.com>, "Ryder Lee" <Ryder.Lee@mediatek.com>,
 "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH] wifi: mt76: mt7921: avoid undesired changes of the
 preset regulatory domain
From: "Nicolas Escande" <nico.escande@gmail.com>
X-Mailer: aerc 0.17.0
References: <20240412085357.13756-1-mingyen.hsieh@mediatek.com>
 <D0I1D2J8EB1L.2DPV9W79YKN2C@gmail.com>
 <3e2eb7ab155cbc4819096e32b914d220166a9adb.camel@mediatek.com>
In-Reply-To: <3e2eb7ab155cbc4819096e32b914d220166a9adb.camel@mediatek.com>

On Mon Apr 15, 2024 at 7:53 AM CEST, Mingyen Hsieh (=E8=AC=9D=E6=98=8E=E8=
=AB=BA) wrote:
> On Fri, 2024-04-12 at 11:27 +0200, Nicolas Escande wrote:
> >  	=20
> > External email : Please do not click links or open attachments until
> > you have verified the sender or the content.
> >  On Fri Apr 12, 2024 at 10:53 AM CEST, Mingyen Hsieh wrote:
> > > From: Leon Yen <leon.yen@mediatek.com>
> > >
> > > Some countries have strict RF restrictions where changing the
> > regulatory
> > > domain dynamically based on the connected AP is not acceptable.
> > > This patch disables Beacon country IE hinting when a valid country
> > code
> > > is set from usersland (e.g., by system using iw or CRDA).
> >=20
> > I always had trouble fully understanding the regulation but isn't the
> > country
> > code IE sole purpose to adapt the regulatory of the client ?=20
> >=20
> Hi Nicolas,
>
> Yes, it is. However, if the users have set the specific country code
> based on their region to the driver, they do not expect the country
> setting to be changed by the country code IE as the AP cannot be
> entirely trusted.

Hi,

In AP mode, I understand that the hardware/firmware (and so user mode to so=
me
extend) is the source of truth about which country/market the product has p=
assed
certification and what not. Thus the country code of an AP should be truste=
d.
If you put an AP from another market at some place, you are responsible for=
 that

But in STA mode the end user should not need to know which regulation follo=
w,
right ? The AP's Country code IE is where the sta gets the final info. So n=
o,
the AP should be trusted, and the user should not (and not the other way ar=
ound)

Of course, I am no an expert on this. I just want to check if there was som=
e
though behind this change. You guys make Wifi chips, you know what you are =
doing

Thanks
>
> Best Regards,
> Yen.
>
> > >
> > > Signed-off-by: Leon Yen <leon.yen@mediatek.com>
> > > Signed-off-by: Ming Yen Hsieh <mingyen.hsieh@mediatek.com>
> > > ---
> > >  drivers/net/wireless/mediatek/mt76/mt7921/init.c | 7 +++++++
> > >  1 file changed, 7 insertions(+)
> > >
> > > diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/init.c
> > b/drivers/net/wireless/mediatek/mt76/mt7921/init.c
> > > index ef0c721d26e3..3c9a5fcd6924 100644
> > > --- a/drivers/net/wireless/mediatek/mt76/mt7921/init.c
> > > +++ b/drivers/net/wireless/mediatek/mt76/mt7921/init.c
> > > @@ -135,6 +135,13 @@ mt7921_regd_notifier(struct wiphy *wiphy,
> > >  dev->mt76.region =3D request->dfs_region;
> > >  dev->country_ie_env =3D request->country_ie_env;
> > > =20
> > > +if (request->initiator =3D=3D NL80211_REGDOM_SET_BY_USER) {
> > > +if (dev->mt76.alpha2[0] =3D=3D '0' && dev->mt76.alpha2[1] =3D=3D '0'=
)
> > > +wiphy->regulatory_flags &=3D ~REGULATORY_COUNTRY_IE_IGNORE;
> > > +else
> > > +wiphy->regulatory_flags |=3D REGULATORY_COUNTRY_IE_IGNORE;
> > > +}
> > > +
> > >  if (pm->suspended)
> > >  return;
> > > =20
> >=20


