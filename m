Return-Path: <linux-wireless+bounces-12567-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D8FAA96E5E0
	for <lists+linux-wireless@lfdr.de>; Fri,  6 Sep 2024 00:47:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 10B901C22E39
	for <lists+linux-wireless@lfdr.de>; Thu,  5 Sep 2024 22:47:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BF2D198A3E;
	Thu,  5 Sep 2024 22:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MaUmPddP"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A36C1B4C54
	for <linux-wireless@vger.kernel.org>; Thu,  5 Sep 2024 22:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725576407; cv=none; b=cCx4ZLMk5r4Vu/ppAhGS4Wa1sZO3YSsOZFUJQ2dtpi8luHJ3Od5AMSpYm7WFWL2MiEV0pLs7EaqqIx1uddLcLGGUBx9ETNR1iRaWeEnqJ12CFzRRxIVvLXDTQB+rTKoaS0VwzEDUgUhCQIB7h+LDC9JN91GrgVAJNkRCwoyOUJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725576407; c=relaxed/simple;
	bh=4SQuu+E3y/Kz4oFQm2dtLJsVfBD9uSxYqn8mEDzC7MQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IdK86ibSBqwcYEwXOAXHx9rolY6NL8ePPNVM+NaNNxhlXFsXiMfu506PfGCW28U7oC+3qKaKLPWgNVWLP7di2qWXNoAxTpyRgU523ZE3eKNbx+ACXHphTlDhuWmHD5aGn6pXp4kU2jTHfobhvy6bCbocJjFY2M6kNfikJxXJt+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MaUmPddP; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-6b47ff8a59aso13445777b3.2
        for <linux-wireless@vger.kernel.org>; Thu, 05 Sep 2024 15:46:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725576404; x=1726181204; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wRHClJ/8Jc/AIqNdgRcvBAu0c5jRwcJ5rBOAJNv5b9o=;
        b=MaUmPddP+h5XEiottCcDs7nMI0Z2IFnHd5/bT9Zmxi4eRfBEu/rQYtqMdtr6yjG+BP
         vGZYChJmMTFKTScKLv+ZyJxK5EruuGST9dHkKAmMTEsDMdOR9nFgz6ZRDAsM/jBh+779
         nrmNL7wccZvsVPOYvDR6PoJ8ZEWO1qnJbrjWacWcHzTgVki9h3EknagrftRCLIBcz2/m
         VyQzZKDNqmLh2Kgs1OMulmzw5eDvv3NIqsMYYtghOLaB/jDA0D8vYj/rWlpkySF7IByU
         cRqSMPCRO6GYHyDNFiF8jhfJtEUKOQDmhs1UD2I1/nNb9w+5cStJqz1KkE7/EOchQzw1
         DTDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725576404; x=1726181204;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wRHClJ/8Jc/AIqNdgRcvBAu0c5jRwcJ5rBOAJNv5b9o=;
        b=p0mhzsurM2Z9XnN6cjncMS+qszGPXfhNMUpfL+Dmc/mhfTQ2WoPPJzJHH5KuDt3MH0
         Di5nooXNTmc9eVqycxk1uf+B50rpjCkSP0y8Gt0CU4dLKGIJL/qeBApGcevmqK1RUwSF
         8II0xJ4ZV3Wft3Iy2kjFZaZDIQCjXSR1hEvT8b/VANmKSWap6aGmTzGwGw6cfhlbAQEP
         sNGrtmbHT1nvwetM9bUA0PbjfqgiaLYUVUOpo+CkSMyqGiFzMvy2IMnGP/GcyZtAEYe6
         heEhDkgZBtqqS5drMKUMHfLWVVnZcfDrWCqtUs38r/ZkUw+70ux4x0sr3nOG7Z0o/WQU
         k9zQ==
X-Gm-Message-State: AOJu0Yx/aqfNyJFxRUqNCXVLdk4pc9oun4pNSLFwL6xnwPnNdFZf/x2W
	azqQ8kTIqLg50T/B68dcuPyJbKKvlXNczNVUBeL+k4gIeQwMK8b6PZtR133ye43IJvvljoJ6Opu
	i1bR7Nljr+37n15HcCDT3cI4f6I+8HEUdnDk=
X-Google-Smtp-Source: AGHT+IEkmM2pipF08R+KuLSTo8B7u5zRWY+NfdIonzgKcI+4XUyNX9CWwt2E/ve/LOj0rmOLRXtLi3fICojHa/GmeT4=
X-Received: by 2002:a05:690c:39b:b0:6d3:be51:6d03 with SMTP id
 00721157ae682-6db44f2c1damr8645777b3.23.1725576404381; Thu, 05 Sep 2024
 15:46:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240905180928.382090-1-rosenp@gmail.com> <20240905180928.382090-4-rosenp@gmail.com>
 <30042de9-c966-4e05-85f1-a346710389b5@kernel.org>
In-Reply-To: <30042de9-c966-4e05-85f1-a346710389b5@kernel.org>
From: Rosen Penev <rosenp@gmail.com>
Date: Thu, 5 Sep 2024 15:46:33 -0700
Message-ID: <CAKxU2N9WzepQzShMw297xZB5LHUnY3rnTVc3MD9w8VK9PUYdpw@mail.gmail.com>
Subject: Re: [PATCH 3/5] wifi: ath9k: add extra options to of_init
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: linux-wireless@vger.kernel.org, kvalo@kernel.org, toke@toke.dk, 
	nbd@nbd.name, yangshiji66@outlook.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 5, 2024 at 2:30=E2=80=AFPM Krzysztof Kozlowski <krzk@kernel.org=
> wrote:
>
> On 05/09/2024 20:09, Rosen Penev wrote:
> > This is in preparation for removing platform_data support from ath9k.
> > Except for led-active-high, these are already present downstream in
> > OpenWrt and never upstreamed.
> >
> > For tx_gain_buffalo, just set it based on the device. The flag was made
> > for a single device. Instead of adding an extra option, just look for
> > the compatible string.
> >
>
> Bindings are before users.
>
> > Signed-off-by: Rosen Penev <rosenp@gmail.com>
> > ---
> >  drivers/net/wireless/ath/ath9k/init.c | 7 +++++++
> >  1 file changed, 7 insertions(+)
> >
> > diff --git a/drivers/net/wireless/ath/ath9k/init.c b/drivers/net/wirele=
ss/ath/ath9k/init.c
> > index 7fad7e75af6a..88db51ec7e55 100644
> > --- a/drivers/net/wireless/ath/ath9k/init.c
> > +++ b/drivers/net/wireless/ath/ath9k/init.c
> > @@ -670,6 +670,7 @@ static int ath9k_of_init(struct ath_softc *sc)
> >       struct ath_common *common =3D ath9k_hw_common(ah);
> >       enum ath_bus_type bus_type =3D common->bus_ops->ath_bus_type;
> >       char eeprom_name[100];
> > +     u8 led_pin;
> >       int ret;
> >
> >       if (!of_device_is_available(np))
> > @@ -691,6 +692,12 @@ static int ath9k_of_init(struct ath_softc *sc)
> >               ah->ah_flags |=3D AH_NO_EEP_SWAP;
> >       }
> >
> > +     if (!of_property_read_u8(np, "qca,led-pin", &led_pin))
> > +             ah->led_pin =3D led_pin;
> > +
> > +     ah->config.led_active_high =3D of_property_read_bool(np, "qca,led=
-active-high");
> > +     ah->config.tx_gain_buffalo =3D of_device_is_compatible(np, "buffa=
lo,wzr-hp-g450h");
>
> There is no such compatible.
Correct. There is none at this time. As the commit message states,
tx_gain_buffalo was introduced for this device and this device only.
If it is to be upstreamed, this would be the name for it. OTOH, the
device is old and probably can't run modern kernels comfortably. It
might make sense to eventually remove this completely.

My goal with this commit is to match ath9k_platform_device capability
to OF before removing it.
>
> Please run scripts/checkpatch.pl and fix reported warnings. Then please
> run `scripts/checkpatch.pl --strict` and (probably) fix more warnings.
> Some warnings can be ignored, especially from --strict run, but the code
> here looks like it needs a fix. Feel free to get in touch if the warning
> is not clear.
>
> Best regards,
> Krzysztof
>

