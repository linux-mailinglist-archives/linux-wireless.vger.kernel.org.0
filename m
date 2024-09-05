Return-Path: <linux-wireless+bounces-12565-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D01096E5C7
	for <lists+linux-wireless@lfdr.de>; Fri,  6 Sep 2024 00:35:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2F6C01C2387A
	for <lists+linux-wireless@lfdr.de>; Thu,  5 Sep 2024 22:35:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC84A189523;
	Thu,  5 Sep 2024 22:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lLfxRo+V"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C4E915532A
	for <linux-wireless@vger.kernel.org>; Thu,  5 Sep 2024 22:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725575750; cv=none; b=nQr2OA5lI+iDPBZi08JZsVAr0rVratv9tVVp7IA6sgxOzmjgrFsH7WqoZZZV6cPqSJNbGkQn4nuvj8OxSeJNmdvSbmU2TbAvK7vHbKSV8tj3p1SeKIiH6LYvCoMJ3s84PdDLgLkeFJrgRRh9DXnYEEp7F+bJbbrki4sJ0zEU7u4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725575750; c=relaxed/simple;
	bh=UZHmDinizFIDh95B0A2Sg6NTBLlsjCyAbEywTGN5Zq4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WV5Mymkncwap1RrHgYUQpWSjNRc1dpe/5mgtEBEhXC/ox9cgdnyUx4LDFVeavykqLvlV6AsyK+kxhwBOR5Q+idN+EaLlpmD7iZ5tVDQ55RVRGBrZ7aK71HvltIpC6zYbkizDQg39MQyr/7maqdmDof/ahs5/9X3G1KAPZ9CGUn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lLfxRo+V; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-6d49cec2a5dso13218697b3.3
        for <linux-wireless@vger.kernel.org>; Thu, 05 Sep 2024 15:35:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725575748; x=1726180548; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bn1ebOYlgroaRlLYiPmVa2EP4EIz6ffz6K6YGQniFck=;
        b=lLfxRo+V65r0tKDlsG9HGsDMqwE1hub/GDgk1ZD7WyS4mjbwplIRV/96psFKfpqbEz
         UAFzXjwX4EsE1EIV6FwmAekBjZC/hE/48k4HuX7ecHe4dgZFYtuA90mOpueIYS66hseN
         NWuizFR9nroqZcDMMbHtkTzlObRf5jWcmzzHVWNmgUYRRhAwopug5ZQVndaH0smTqeeZ
         fUY9cQd52e8To+4SWp+xvU/vOmKQ7Yi9Nn3pl75V8XqpNta4L4JQzOdSPTlv8XZv2tR1
         Pq9+fO15TKfOspZWMssDMe/gMvK3dEDA/0F/JFxoO5vyFHR2wENYYYg+LY4gxIkWSdl2
         B4Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725575748; x=1726180548;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bn1ebOYlgroaRlLYiPmVa2EP4EIz6ffz6K6YGQniFck=;
        b=uv8GTho0q8xfjwZsi3ffoas7QLY+mPEw7Arq87/xQhi6/+gaoMrPnTMsGUS00KVU5D
         8ya8hF05cEx/BVSYoixeAXVCBUQkjOkWq0a5PhJWayOHbTn/jST/T08lCCVSWMadqI/C
         AYw8wrAV7k3GS7h1JHEEGAqmc3TO+CNP3Woe8JUvgwhSzdXy2wyfgsiaLdpwWWR7NlwW
         zpcONd7XrIjMhoVPDxFrmeIRAtrp4r+breiRVd0nDoicX8zl3H14od744TnN4flFS/S9
         b+3ZYhLviTv3vBimQFyWY+Wrjf9bZTtvY+pSAS67uc3nRKYEWh5Fx85is1215Q8p63/u
         Pcfg==
X-Gm-Message-State: AOJu0Yxq4B2gn3ejbXGCkmouI3bjMxuhKdRB/pC899dE+KU/26uNLpDx
	UmpfFrWlaLfCMJtooxeRg3Q1iVcGcBRKE/7Bl7lCA6YGHgqMXwATKMiS69ljt6xnN049SSfP6kl
	h1wgjzxiumXD94NOD8/ztIC+rUDQ=
X-Google-Smtp-Source: AGHT+IG29txRbw4UajX2F0xT7gjcDo559xTWdWKovQTzx09VzSj5bKkh0NI1O5LpP7jHKvR7PN4aqIEFR+YtfAQH8UI=
X-Received: by 2002:a05:690c:660e:b0:6b3:a6ff:769b with SMTP id
 00721157ae682-6db44a6477bmr9159527b3.0.1725575748300; Thu, 05 Sep 2024
 15:35:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240905180928.382090-1-rosenp@gmail.com> <20240905180928.382090-5-rosenp@gmail.com>
 <b666cc28-af93-4b7b-a446-adf3d1ef0fe0@kernel.org>
In-Reply-To: <b666cc28-af93-4b7b-a446-adf3d1ef0fe0@kernel.org>
From: Rosen Penev <rosenp@gmail.com>
Date: Thu, 5 Sep 2024 15:35:37 -0700
Message-ID: <CAKxU2N_nAor8SjzSH2_0ch3Sp1XScP64DK6Ni6j-2wa8nBrMUw@mail.gmail.com>
Subject: Re: [PATCH 4/5] dt-bindings: net: wireless: ath9k: add new options
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: linux-wireless@vger.kernel.org, kvalo@kernel.org, toke@toke.dk, 
	nbd@nbd.name, yangshiji66@outlook.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 5, 2024 at 2:29=E2=80=AFPM Krzysztof Kozlowski <krzk@kernel.org=
> wrote:
>
> On 05/09/2024 20:09, Rosen Penev wrote:
> > These platform_data options are now available for OF.
>
> This explains nothing. Describe the hardware, not driver.
>
> >
> > Signed-off-by: Rosen Penev <rosenp@gmail.com>
>
> <form letter>
> Please use scripts/get_maintainers.pl to get a list of necessary people
> and lists to CC. It might happen, that command when run on an older
> kernel, gives you outdated entries. Therefore please be sure you base
> your patches on recent Linux kernel.
>
> Tools like b4 or scripts/get_maintainer.pl provide you proper list of
> people, so fix your workflow. Tools might also fail if you work on some
> ancient tree (don't, instead use mainline) or work on fork of kernel
> (don't, instead use mainline). Just use b4 and everything should be
> fine, although remember about `b4 prep --auto-to-cc` if you added new
> patches to the patchset.
>
> You missed at least devicetree list (maybe more), so this won't be
> tested by automated tooling. Performing review on untested code might be
> a waste of time.
>
> Please kindly resend and include all necessary To/Cc entries.
Will do.
> </form letter>
>
> > ---
> >  .../devicetree/bindings/net/wireless/qca,ath9k.yaml  | 12 ++++++++++++
> >  1 file changed, 12 insertions(+)
> >
> > diff --git a/Documentation/devicetree/bindings/net/wireless/qca,ath9k.y=
aml b/Documentation/devicetree/bindings/net/wireless/qca,ath9k.yaml
> > index 0e5412cff2bc..5c293d558a94 100644
> > --- a/Documentation/devicetree/bindings/net/wireless/qca,ath9k.yaml
> > +++ b/Documentation/devicetree/bindings/net/wireless/qca,ath9k.yaml
> > @@ -44,6 +44,16 @@ properties:
> >
> >    ieee80211-freq-limit: true
> >
> > +  qca,led-active-high:
> > +    $ref: /schemas/types.yaml#/definitions/flag
> > +    description:
> > +      Indicates that the LED pin is active high instead of low
>
> Where is DTS user of it?
None at this time. There are only downstream users.

This maps to the led_active_high in ath9k_platform_device , which gets
removed in a subsequent commit.

drivers/net/wireless/mediatek/mt76/mac80211.c uses led-sources as the
name for the same purpose. Maybe rename?

>
> Best regards,
> Krzysztof
>

