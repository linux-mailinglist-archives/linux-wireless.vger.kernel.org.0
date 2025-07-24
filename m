Return-Path: <linux-wireless+bounces-25980-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2D1CB1026F
	for <lists+linux-wireless@lfdr.de>; Thu, 24 Jul 2025 09:55:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 66457546143
	for <lists+linux-wireless@lfdr.de>; Thu, 24 Jul 2025 07:55:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C62B52A1BB;
	Thu, 24 Jul 2025 07:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BwGnQIJa"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13CD926FA52
	for <linux-wireless@vger.kernel.org>; Thu, 24 Jul 2025 07:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753343729; cv=none; b=fNBOf8ANel+un3nDp6BZlziWlXlKwxJF8PTykYOt7BwYHh1RGtowizOinE0iFPjGCOEMZHNUDNeqm5sDFJlik43XwDiaM14BNb3yp9cl2erruBp0BCeuDAg9OWV+sCIW9oTZqHcVAs5Nq6fA3u91F/iBZPQuhHAWb64S1MBvrqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753343729; c=relaxed/simple;
	bh=Ri6nxh+BJrlZoeEGcR3HZPDkL3/jAsjmaGepz4E9I84=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=iNLqrPBngbz4rL6P9H70XR05C8vHPtQIUtyaM4SOYRumjmmG0pvF0F+MpnbS5MhI7tS/xRZybs1bL9ZTLatVUD0FKikUbtElHAUgsyB2MNI11d458zAkP1Xf+sIsNQjiHMPe5pukqP99c5dBuaIkxLZBNob8V5Yp2a4uOedykAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BwGnQIJa; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-607ec30df2bso1430052a12.1
        for <linux-wireless@vger.kernel.org>; Thu, 24 Jul 2025 00:55:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753343726; x=1753948526; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ri6nxh+BJrlZoeEGcR3HZPDkL3/jAsjmaGepz4E9I84=;
        b=BwGnQIJaNIZvhhV1Su/xqNmneT+Q5e1GxsVwWoxn0TpFHrbQEMlKByGCF6j95U2sIH
         LD2TsMEMRS4A9OpixR2wEvJwhh+MwMX7Tn5zMseMuArZAcaSAZ/6V7OpcRUmaAL7A/6k
         tn4p1JeOchJThaw9IhbICPOQx9N4yhZ5dp7qnjltZX6xR0xQx4paifhqdrzuKWaJtfv5
         tFfVZeuiI9HQeN+mtbdvY3CvohOMSTuU/BDX/73WphZwKE3Rsu93Kbw/m93jrWNR0RgA
         t6XgdRJjhx4ggeH7ED00detVmQYT8uk/t07+vVPGXHcJlqE0J5/KESsnXGLnnA9zNhrq
         yXAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753343726; x=1753948526;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ri6nxh+BJrlZoeEGcR3HZPDkL3/jAsjmaGepz4E9I84=;
        b=h3bkFR8B8gqd8decZy058FeLuYZuWd12+kNnxcdFtuy6gzt4/Z/AtJfbEGK/YEzvOr
         RuJ5mWPvAx1XxFIRlA6pjmOsjarL5SJEMM9+af7nAjh1mfXmDOKpC5MpwnwJVsGUx8uj
         XmctrBduYbY1q0ICLdPb4MTXFNQsO5vCg/akCmgmYzLrk3YJ8McREZUA0eEsEZXS1tAk
         TXibzLyr7QtN/nHoLV557tt7eKH++nmk1i/gVjW/3vDRJ5Z9Pb6F8b2hxnieyav2ZzkF
         AL+p5ZMWB9Q2qzZ4DMKATIxwTFW7gjkR+xod6HAjMS501AWjxllEUfbw2kNrOZgrIG1F
         b7Dw==
X-Forwarded-Encrypted: i=1; AJvYcCX9YqXYIHsMDab6p1/nE6fNt8bDRSnNLBHO39+Y4Bcuu9M+r7mwvaHRdmRoJvpXMUlw9JXxYmhTpfDcB7QJSQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzqcnLckkoO/LUO7OU0kgicXp3xotS+tLzkJmgLWQx0qZXLgH87
	RVTgOLYdoSpFGxqWksFNXkecDrJYEy49sP56ISi8NnoDI+exXJbQvJ7KIhzEtg==
X-Gm-Gg: ASbGnctkYTB2f/PNuBD9MJYx5qo1IN0gf0GIHPPXQSkahknveLoRBcwhvKjzTm0J9ag
	zQptLKrGKu2/jv0UDXybeZlLCfXU+gl6GE1wOhpohtDhYVaAM9gTl8LUK2e3NfLC/u1FCFuZtxX
	AwhXh5pJZswjcSo1hm3hBzzyP6Z71rCp8Visd5BZvOvUawOjj/bJkuQqsvUak8K/t/Zn3i2lsXu
	XLqK/FyvMxZonmh7mDI/l36e22S6dNIJOTQAwNosb88DFiZnlX/x4xnvfb2j8xtumweHZAs5OZq
	CG0eqXWaE2GYeHioPx5WesTRuHsmRWO9f5itLK8YZzEpB+/BwMKloL/F+ZSo7Uu32liiufiTdXi
	2bhs3RT8ckpFq5iNa9k+VdD1lf8XicUvuFiatWkmKg0Qoyank66bDNBJT4di1Vev68B3+fRPJyD
	7l
X-Google-Smtp-Source: AGHT+IF1hZoMN5HuSpkuZ+44y1boXP1JWuw8iObMOrQ/SVEqLH4IiufQqOCA1Cmc9+/Y2GnNiBWxIg==
X-Received: by 2002:a05:6402:35c6:b0:60f:ea89:5128 with SMTP id 4fb4d7f45d1cf-6149b5b2ca4mr5739161a12.34.1753343725986;
        Thu, 24 Jul 2025 00:55:25 -0700 (PDT)
Received: from smtpclient.apple (89-66-237-154.dynamic.play.pl. [89.66.237.154])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-614cd31a0e3sm523139a12.50.2025.07.24.00.55.25
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 24 Jul 2025 00:55:25 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.600.51.1.1\))
Subject: Re: rtl8822cs, mainline 6.16-rc7: kernel reports ' unsupported rf
 path'
From: Piotr Oniszczuk <piotr.oniszczuk@gmail.com>
In-Reply-To: <3a93f5580be34135a5b7f942d5b6ea44@realtek.com>
Date: Thu, 24 Jul 2025 09:55:14 +0200
Cc: Bitterblue Smith <rtl8821cerfe2@gmail.com>,
 "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
 "martin.blumenstingl@googlemail.com" <martin.blumenstingl@googlemail.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <B89A3F05-FE7E-4AE8-8F75-34DBBC285C0E@gmail.com>
References: <7407FAA3-F4A4-48AA-91E5-A78DA711447D@gmail.com>
 <ec5d762f3ee64a0188953a1aecbef2cc@realtek.com>
 <AFB036A4-80C6-4880-B798-FB22C7C137FA@gmail.com>
 <b29df36b838049a088d8298220078134@realtek.com>
 <5CA196F3-90B4-479F-9A19-E9C71C8726D4@gmail.com>
 <34d9c169c92540caa294095d2172b4fc@realtek.com>
 <18989932-3578-4E45-BA8B-6C2C76FDE7FE@gmail.com>
 <ed867462c8d945b28b2e913d1cd0c3d5@realtek.com>
 <7dfa0377-538f-464b-b4e4-4c9daa1fb85a@gmail.com>
 <5933c3ef71914cdf83687042488800d2@realtek.com>
 <699C22B4-A3E3-4206-97D0-22AB3348EBF6@gmail.com>
 <3a93f5580be34135a5b7f942d5b6ea44@realtek.com>
To: Ping-Ke Shih <pkshih@realtek.com>
X-Mailer: Apple Mail (2.3826.600.51.1.1)



> Wiadomo=C5=9B=C4=87 napisana przez Ping-Ke Shih <pkshih@realtek.com> w =
dniu 24 lip 2025, o godz. 02:52:
>=20
> I sent a patch [1] with a change that check RTW_FLAG_POWERON flag =
first,=20
> so things will be the same as this final try. Still want you test the =
patch
> again, and give me a Tested-by tag there. Thanks.
>=20
> [1] =
https://lore.kernel.org/linux-wireless/20250724004815.7043-1-pkshih@realte=
k.com/T/#u
>=20
>=20

I give test and with this patch issue disappear.
thx for fixing this!

pla add=20

Tested-by: Piotr Oniszczuk <piotr.oniszczuk@gmail.com =
<mailto:piotr.oniszczuk@gmail.com>>


