Return-Path: <linux-wireless+bounces-28844-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 04929C4E4FC
	for <lists+linux-wireless@lfdr.de>; Tue, 11 Nov 2025 15:11:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id A49B434CEA3
	for <lists+linux-wireless@lfdr.de>; Tue, 11 Nov 2025 14:11:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDBBD3128AA;
	Tue, 11 Nov 2025 14:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dyVH4sxN"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44FD43115BD
	for <linux-wireless@vger.kernel.org>; Tue, 11 Nov 2025 14:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762870263; cv=none; b=WTCuoROkDpC5FCs8uL/LEUzQYFQ+i/jis4LjOcpINVuWI+pzyH6zto1mGA7KnMmRhv7yMQbXNZ6WEbSBjqr/1P8BEC4Gwzyr1oLCwGXQkiU93VSGTf/8jf2ghHV37TUD9yrQoFMMFX7h4RvykxrPkIrRT5Xr6zyye2h2HT9kT9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762870263; c=relaxed/simple;
	bh=Wq9fyBoDFGXqHiJdhh3nryyd8f36FPRsS0VIkxdNrm8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TmLfJ65K0LD5ubxNTgcQAkK2hwIvbWWdAhr6Mbe0TKrFIqOLZXE012F1QdF6/A5y5qGCyVEDkN9rzCGb1u0h2BLatSYGNaaBNaqZJY4ubYVeUBwiIawQOg86kgkArk+ihI09sMbhQR6JUHRO5i2c6omSVI2ElCJAOh4vnMvpa1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dyVH4sxN; arc=none smtp.client-ip=209.85.160.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-3d18422565eso2650052fac.1
        for <linux-wireless@vger.kernel.org>; Tue, 11 Nov 2025 06:11:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762870261; x=1763475061; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=txdEdm40JEr5pC5+2I7HwpHNOaO4GAfSSqE8ztv0UX0=;
        b=dyVH4sxNdvVGDhKIqApGJKsO7lBd1NrwZRIfdyiRkAUyo4huX7tlI6vRg11Z75Sjiq
         vOlM+j/lqqx3nR/Ze3tsYnYW9Iog+TAbVrKDteO8ZgipDz5WTG0ipiK4o5vH0OPgDlD9
         a/26q4JZqEf592zU1tELRIXv8wZKjbbil137jvxuqa8ei5ZWIT8f4TfsB6iMm9y+u4ds
         r7JmMusGSR1g8cTQkbM/FOQ8YuhXOp0e86BYmCM+kZtFDGWA9R8VgJHlIpNIiBoDP+T0
         2jQGqp9Ad/TXsFq1QIlR50RHRGuXRNsT/4dpUr80PzASBr68cVETIfhm/rT1MVRg8mAo
         Rb1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762870261; x=1763475061;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=txdEdm40JEr5pC5+2I7HwpHNOaO4GAfSSqE8ztv0UX0=;
        b=wTZarvapVnzI3Qt/Wt5IhKgEwSOlfwTjgS46a0d7aVoEbD/PqkrZq9zaEgx/Qm+w6t
         qqXPouEq2DgJiyYltVHwgZwJ/8nXPrcO35zAuPOTcGmwIaYOQJdulF6d5LSfZuMYZgvY
         BEhZRUTUEkX/69YmBvOcW1TRbQzz2OSjDwe4sdWxqrvc0MxmXX3jYTXZEMzjFV3FIR9S
         vc1DX/RqYtD0o7KiNwNklGh/3F6eKNFENy/div2JEPNNZoMAg6geFLat/lwOaK6Kc8ZS
         LmBXYV8GawiGR917plcpBGL3klQdwtrMflJihfdkOuTBJwJ4+QSxngfZezK067KZQATE
         dhRA==
X-Forwarded-Encrypted: i=1; AJvYcCXc1slw3RRFD4FvvscnT5+gs/vpvpkpX48vvm/oFQGW561GM9LX+3J0dVf3v3EWi6EhI6Uc/VN2WA6RXXCc8A==@vger.kernel.org
X-Gm-Message-State: AOJu0YwXsJ2W3h9k2r0f8jFNQ5nPIjZYiSe6/5Jb+TOYgOvUbKKKeU4C
	uS65LKkpY2d2is5u/Ms+fTpQb4UZzgyfiansFg1+dw+LcmYS2WNc9m1tKEOc3JxwCO1pO97HtDn
	2e3jBY4616uarHX50Ktif9gQ6e2r56+A=
X-Gm-Gg: ASbGncv05sxKJYlyPZpVZi+ETbFw8JR7RmoVUM6l4r1v7mLTRbG/jP7IhXMuLpEqCAr
	5DN0E5Iou8TjfG/9QqfgP3sfeOZZzXLCDYL7DNbvLZN/FB5TglTDZ7tC82Po3K1NUowCbqzhAJr
	gsKQB2NH2GztnTxSWFLNkDUoZm6CP9qlW/QC1RYIgtPkDkYaLDOxqY1jSogD0MOaIIy3txtUfZX
	pfsAfkGJSNh8h4+ibELb39Z81YkGfxJRTN2I/SDdCJHhAnnfNHk/99TS3/YH9po7n1tebyB
X-Google-Smtp-Source: AGHT+IH9NsGeAGXbfrkGaLkI4eT/HyQdZyA7+2QW2Tz3Nh3t6elSCgFx6DzEmvDROMRAAY0dK1BfQ/UaepIHAEj/9uQ=
X-Received: by 2002:a05:6870:899a:b0:3d4:760f:544b with SMTP id
 586e51a60fabf-3e7c294ab31mr8000185fac.46.1762870261279; Tue, 11 Nov 2025
 06:11:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251111134400.5258-1-sef1548@gmail.com> <aRNBak9Xl_wsBJ6w@lore-desk>
In-Reply-To: <aRNBak9Xl_wsBJ6w@lore-desk>
From: Nick Huang <sef1548@gmail.com>
Date: Tue, 11 Nov 2025 22:10:50 +0800
X-Gm-Features: AWmQ_bkn9vJFX_qKrlLafWMdsY1_qiyP8xv9zY7kAo8K6GWks1Gw41ZZnCWDwno
Message-ID: <CABZAGRG-7T2mp3UYRaJ5c7eTi1B4hWybtJrfPwdo2aSEvhcMqg@mail.gmail.com>
Subject: Re: [PATCH] mt76: connac: remove unused reserved field in gtk rekey
 TLV struct
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: nbd@nbd.name, ryder.lee@mediatek.com, shayne.chen@mediatek.com, 
	sean.wang@mediatek.com, linux-wireless@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Lorenzo Bianconi <lorenzo@kernel.org> =E6=96=BC 2025=E5=B9=B411=E6=9C=8811=
=E6=97=A5 =E9=80=B1=E4=BA=8C =E4=B8=8B=E5=8D=8810:00=E5=AF=AB=E9=81=93=EF=
=BC=9A
>
> > The 'reserverd' field in struct mt76_connac_gtk_rekey_tlv was unused
> > and misspelled. Removing it cleans up the structure definition and
> > improves code readability.
> >
> > Signed-off-by: Nick Huang <sef1548@gmail.com>
> > ---
> >  drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h | 1 -
> >  1 file changed, 1 deletion(-)
> >
> > diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h b/dri=
vers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
> > index 27daf4195..28cf46a5f 100644
> > --- a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
> > +++ b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
> > @@ -1681,7 +1681,6 @@ struct mt76_connac_gtk_rekey_tlv {
> >       __le32 group_cipher;
> >       __le32 key_mgmt; /* NONE-PSK-IEEE802.1X */
> >       __le32 mgmt_group_cipher;
> > -     u8 reserverd[4];
>
> This field is used to keep the struct size consistent with the fw one so =
it is
> expected to not be used.
>
> Regards,
> Lorenzo
>
> >  } __packed;
> >
> >  #define MT76_CONNAC_WOW_MASK_MAX_LEN                 16
> > --
> > 2.48.1
> >
Hi Lorenzo,

Got it, thanks for explaining. Makes sense that this field is just for
size consistency.

Cheers,
Nick Huang

