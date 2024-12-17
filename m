Return-Path: <linux-wireless+bounces-16490-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E8FB9F569B
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Dec 2024 19:54:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1146118814F5
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Dec 2024 18:54:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4A521F8ADF;
	Tue, 17 Dec 2024 18:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QjFbzyRU"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-oo1-f43.google.com (mail-oo1-f43.google.com [209.85.161.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3573D1F76AE;
	Tue, 17 Dec 2024 18:54:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734461686; cv=none; b=k/AK7lKGffB4WYXYfXYkeiXtnbO3o71ctVOA1Aod+Hfl3HkRILxgqouPGE72xPLinp7jw88E7hFUdmZBtt8KTfIu4yER/+iH+hniUF28/Q+aDRYU3bArmRH0Z8TTKq8Z5Do/+JbnnZsFTmYPsSx9MwDDI9TEcaFp+XIz2lrXUeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734461686; c=relaxed/simple;
	bh=dwEK2V+NwsxoqVLt4qwUPzJuZxjpRpVr3DgeyYIkTus=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tbAZ0ja/tdP+flIrBTGGNWySF0L1EHbzahnIAqnpkcJ/52/QTsY4wO8yFifSlhE+Q1+e7UWjn6JjYK29dy/wrgAvf1/6vhluV7Vf1OomiX73uFO6P1Mcn42TLsBJqJSmlIGxgw2FPeyRm7Z5rarD0IhBlZP4QOr9GZeDjYypVNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QjFbzyRU; arc=none smtp.client-ip=209.85.161.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-5f2ed0b70d6so2477042eaf.3;
        Tue, 17 Dec 2024 10:54:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734461684; x=1735066484; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dwEK2V+NwsxoqVLt4qwUPzJuZxjpRpVr3DgeyYIkTus=;
        b=QjFbzyRU/DApO6iDXHdYUvZQMNssZcrlCX3/zXyqcALL6A1XKJanfWYDRyNE0xk2Y2
         x0iXfknthgthBJBUZ3gU5+rAaW6/4qwTooKTrhlrtoGM9EaCcKlolWnn/oYxeSC0O19P
         JpVviiHZZocfLTa9xuek9gHyrMfmKREipcfARqMuO6xSRcTT8ccWvQz5NpjiunS5NgqU
         ZnDkZbUNXLyiGSkxSSeCkTFJEGReO1XK/W5qe0RHJtI5Cf6II/mFclfsy4iggdpVRZG8
         vS1BC3+Cq5lVuhx/iOENUVf3A+y9nZlmWgxELj5poKW8rQbLzkUiznpf4NiHyDYfvzNR
         cSbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734461684; x=1735066484;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dwEK2V+NwsxoqVLt4qwUPzJuZxjpRpVr3DgeyYIkTus=;
        b=F3DogWWGhARziGuPcy/URTc+U1XuqOjsTDqezAWAp6Zh4LYhBfD4SwJ/p7IZeYJVui
         ARGKWXiJikxpvheEvv+sQr8JsW/lBqN+DoTRZz0t6kBjwXeuLxanYRq3TAdT57Kk2opF
         IWmnN2KgDORzMLsbAMj5IRnaks8m278Fww0hCYm5y2JU8V1ou7oU2EM9k/sw0Yi3GDZA
         sNGuws48V+QTkIJFjW2P7Cu8xF/OCNIrhki4UsLTH+w+bOIDBDogoZVy5sa7I54JqgNZ
         GsZCagcXVRh5exNKz9Fc5fwRN+Jm/QQgnwkJVYYtwPDdbgGjPFfulrEE+d8ZC7+l2nh1
         jLwQ==
X-Forwarded-Encrypted: i=1; AJvYcCUU4D2bdYUKJ0hubGYEWSIkREIHBUmQ9Ntl1jaqL0tCKRWyLZ4LGzPQTuUNOcqSgGeyfzkUT/Flxe0lSPM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzYAWeHqcKcG+Vwz3kYqgXcdYg1k3zYk+eUHv4l0GRzk0ipDXkr
	dA2VMJJdEnvEjTwB4yLwbrgM6Ma+9yxOfKTErkIvdRD4xSOojSgp0/XzgxhEbMZxPOb+kx1pVi7
	wGr93tpJCJL2MWEMgsl51k7GzgOM=
X-Gm-Gg: ASbGncvi0KefeStAxUbdB6sVUu9e7qo2k7va34z1gZxWu0ZGhrASLPxo4LB8d4TP63h
	Vq8OeOE9CW+M3heLND1/oxkufHMmRdInb3IwQ
X-Google-Smtp-Source: AGHT+IGQDZLl7mfjaTH/5VIvgXt+Gr4zkRvh4UK8kHCuvd+Y3fLIH5he4Q8ShGTMod9GEHUuUogqecqkAtumrAGeHtE=
X-Received: by 2002:a05:6870:808a:b0:29e:6211:1262 with SMTP id
 586e51a60fabf-2a3abeeb4c0mr10681465fac.0.1734461684277; Tue, 17 Dec 2024
 10:54:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241122210346.2848578-1-alexthreed@gmail.com> <980c5cee-2dc3-4d26-b749-6ba00b9c2091@broadcom.com>
In-Reply-To: <980c5cee-2dc3-4d26-b749-6ba00b9c2091@broadcom.com>
From: Alex Shumsky <alexthreed@gmail.com>
Date: Tue, 17 Dec 2024 21:54:32 +0300
Message-ID: <CAF4oh-Pbbu-LJ22yyx95Zrw0rgwRHo_tEqhCnrRHRBHqADS8CA@mail.gmail.com>
Subject: Re: [PATCH] brcmfmac: fix RSSI report in AP mode
To: Arend van Spriel <arend.vanspriel@broadcom.com>
Cc: linux-wireless@vger.kernel.org, Alexey Berezhok <a@bayrepo.ru>, 
	=?UTF-8?Q?Alvin_=C5=A0ipraga?= <ALSI@bang-olufsen.dk>, 
	Hector Martin <marcan@marcan.st>, Janne Grunau <j@jannau.net>, Kalle Valo <kvalo@kernel.org>, 
	Kees Cook <kees@kernel.org>, Neal Gompa <neal@gompa.dev>, 
	Wolfram Sang <wsa+renesas@sang-engineering.com>, brcm80211-dev-list.pdl@broadcom.com, 
	brcm80211@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 26, 2024 at 2:13=E2=80=AFPM Arend van Spriel
<arend.vanspriel@broadcom.com> wrote:
>
> On 11/22/2024 10:03 PM, Alex Shumsky wrote:
> > After commit 9a1590934d9a ("brcmfmac: correctly report average RSSI in
> > station info") it is required from firmware to provide rx_lastpkt_rssi.
> > If this field is not provided brcmfmac doesn't report any RSSI at all.
> > Unfortunately some firmwares doesn't provide it. One example is firmwar=
e
> > for BCM43455 found in Raspbberry Pi.
> > See https://github.com/raspberrypi/linux/issues/4574
> >
> > Fix it by falling back to rssi field if rx_lastpkt_rssi is not provided
> > (like it was before 9a1590934d9a).
>
> Sounds like a reasonable approach. However, I would like to learn more
> about the issue. Maybe it is a per-vendor issue so I am interested what
> the sta_info version is that we get from firmware. It is printed in
> brcmf_cfg80211_get_station() with brcmf_dbg(). You can make it a
> bphy_err() call instead or enable TRACE level debug messages in the drive=
r.
>
> Also would be good to know the firmware version and kernel version of
> the BCM43455.
>
> Regards,
> Arend

Hi Arend,

Is the info I have provided sufficient?

