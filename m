Return-Path: <linux-wireless+bounces-26491-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA185B2EEC1
	for <lists+linux-wireless@lfdr.de>; Thu, 21 Aug 2025 08:54:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5AEDA3B16F9
	for <lists+linux-wireless@lfdr.de>; Thu, 21 Aug 2025 06:51:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B59B82E093A;
	Thu, 21 Aug 2025 06:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nXVEfNPC"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23EFB2E62D4;
	Thu, 21 Aug 2025 06:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755759116; cv=none; b=jZ8eCYiiUtWyggLIVRBPb59pHWn60WZa7eGd0dBVmSF4ArAl20yNavRxoxwMHhzvkt7llQtSLNByNHDsKIeGszTi7aPz4kMw5b9215jFZE0dDwh04/V46XaWXUYPkKaxgihwkDaaSvCTtpNDHlEmqkU00JwfApGnNvmjYvoICh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755759116; c=relaxed/simple;
	bh=fVG9Y4yfM1WF5vSXD2mnbglXpSZtB22Yp8PCqp/JSWY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FhRT1Wdtg9coS6jEiyNQRjTM3ifrvtZayXs3bBJhesDuwevrTQCyMfVKjGh25slAkRzbMjJNHysaARgmq9G7sKcGubSFFIxaRheIv7eFNQdWZXyqpiB28kF6nEgXe318WApucN4P7dxB30369AK6IOe/qt2DoVhpYlxlzOPcgsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nXVEfNPC; arc=none smtp.client-ip=209.85.219.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-e94dfbf7ba1so638324276.3;
        Wed, 20 Aug 2025 23:51:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755759114; x=1756363914; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7jj0RWb3NgQmNjLgwT9jEyVWruC4wLqZypmADAd++kU=;
        b=nXVEfNPC5FVHFbYqaHQ6BmuYYq2pqs6CfnTdU1Hm5juxRBgxPcNrydmxzvx10wZKmn
         CEj9pdLyF9bGzKdMFe27A9L2lW3l2kS7oJ/XDuPIbLl4J1d9I5U5crUOj3H5kYILKxyr
         3X/7M4GhoPuNdibI69oGb1C4CjoGKSA+aqFGWDt+1gwMhMoKrohV4tdkzfTQktwz8kh6
         LTW3ahh2jRsdKv2vNIbnji8xMMx4vldgQOqbH7Jj74fP8BgkEoLqpauzQWcg8Y1tq8m9
         hyDxc1/I4CiIbX9aqurxiP6ebBx8kfgYNj4IDhmnmWZYGW43KYGv6SQxTjmlBQeC7U4b
         bkjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755759114; x=1756363914;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7jj0RWb3NgQmNjLgwT9jEyVWruC4wLqZypmADAd++kU=;
        b=mNPhaYuusYzHcWvzlJoysOzy5q1Z7kWLBuaFjPugIMFj2T5WsEvArNQPoUN5yWguzE
         qrz+oh2tp2M/QXOH/3xie3ouwnXk4CN99lYTKxuqVpDhMep7iNDiaWzK0fP/RtAon4I7
         UH/Pmt3KzDJ9OKCyaU5vRzZIC+Ky/dfOv0V5WI2f0USI1i+487sjxqktMj0KrXZI7/2Z
         JcoUxRmG2CeApEyzj18TPtdE8Z5/rflw51rUG8r/VKKEya9HYIJNmCewixRcJwXG+fkc
         C4qucV7SKYfHh4NykRfoZ7OJcMSTfk6yMwyMuT8RFKHDZQHna6ISwOmyCPa/eCaRpUxD
         WsJw==
X-Forwarded-Encrypted: i=1; AJvYcCXbi1q7iSVkyXimeRHos6kb6rwKL8mlJeTEy0SaCF+KqJBEzpPAfovk+wuSYI+BAwZ/DhajiM2iaY8nD68=@vger.kernel.org
X-Gm-Message-State: AOJu0YxfWC4m+Ckn3vuOhSRFkgDGHpZYOkeomFeRYPNgwTxDUQK1LuPL
	8qoRoMWwzXh8MEZ1steIK4YseXGRecwG+1Dj3MnJRy+zojm9gcj+dL3okczX2sqU21TjbEQLxk1
	Gcf7i/5PnkMnsXWxwGXqsz01Ju1Dlgpg=
X-Gm-Gg: ASbGncviAbe1YR/yYNJKrYBqlckqTrUwnkPolhjHQuFiLUCVzHHQMENG81UMxuGht1Y
	WK0LtRODlY4PzYm493qj8hxaAsbOcF4NMeff7XzzLKJJm9080b7MAGygL2nEwEr5taYJlnkxfS5
	Ct8BQeIItXUaYZ1U/zo6aJT2AFTGr/y62/Acd0w0I3p44D4RjOgaRj1gOQMTAAA3PWo1/KcRrlz
	sg7iwB2
X-Google-Smtp-Source: AGHT+IH5IRSj7RIwsEmgN0S7S/Fcoa63Wm/F1dJC1WTH74qSbmlrgX9PHDJjd4/36xzJZo0pxQrRH22tVi8kSuqmFfo=
X-Received: by 2002:a05:6902:540f:b0:e93:36f3:571a with SMTP id
 3f1490d57ef6-e95088fe627mr1280173276.19.1755759113882; Wed, 20 Aug 2025
 23:51:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250821032755.636661-1-rosenp@gmail.com> <86ddae9a-4931-b160-51a2-f89d45d4038d@oss.qualcomm.com>
In-Reply-To: <86ddae9a-4931-b160-51a2-f89d45d4038d@oss.qualcomm.com>
From: Rosen Penev <rosenp@gmail.com>
Date: Wed, 20 Aug 2025 23:51:43 -0700
X-Gm-Features: Ac12FXyw_ixSA4Api_c3e9oT18wZB5ZGV1G--orns_TPaSoKPXA7k3zurYMbDDA
Message-ID: <CAKxU2N-0Q2uxw=-v-XP8g=Y=yBb2ufv+T0yk7dmaszwUy8Z6tg@mail.gmail.com>
Subject: Re: [PATCH ath-next] wifi: ath11k: switch to of_get_mac_address
To: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>
Cc: linux-wireless@vger.kernel.org, Jeff Johnson <jjohnson@kernel.org>, 
	"open list:QUALCOMM ATHEROS ATH11K WIRELESS DRIVER" <ath11k@lists.infradead.org>, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 20, 2025 at 10:55=E2=80=AFPM Vasanthakumar Thiagarajan
<vasanthakumar.thiagarajan@oss.qualcomm.com> wrote:
>
>
>
> On 8/21/2025 8:57 AM, Rosen Penev wrote:
> > This is needed to support nvmem defined MAC addresses in DTS.
> >
> > In addition, check if the probe should be deferred as nvmem can load
> > after ath11k.
> >
> > For brevity, ACPI is not a factor here. ath11k is too new for that.
>
> This may not be accurate, pcie devices are widely used on x86 where
> ACPI is not certainly new.
No way ACPI is used to define MAC addresses.
>
> >
> > Signed-off-by: Rosen Penev <rosenp@gmail.com>
> > ---
> >   drivers/net/wireless/ath/ath11k/mac.c | 5 ++++-
> >   1 file changed, 4 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/net/wireless/ath/ath11k/mac.c b/drivers/net/wirele=
ss/ath/ath11k/mac.c
> > index 1fadf5faafb8..801db15ca78b 100644
> > --- a/drivers/net/wireless/ath/ath11k/mac.c
> > +++ b/drivers/net/wireless/ath/ath11k/mac.c
> > @@ -9,6 +9,7 @@
> >   #include <linux/etherdevice.h>
> >   #include <linux/bitfield.h>
> >   #include <linux/inetdevice.h>
> > +#include <linux/of_net.h>
> >   #include <net/if_inet6.h>
> >   #include <net/ipv6.h>
> >
> > @@ -10434,7 +10435,9 @@ int ath11k_mac_register(struct ath11k_base *ab)
> >       if (ret)
> >               return ret;
> >
> > -     device_get_mac_address(ab->dev, mac_addr);
> > +     ret =3D of_get_mac_address(ab->dev->of_node, mac_addr);
>
> I still think it is better to keep the generic API and add the the one sp=
ecific
> to nvmem when the generic one fails.
I don't. ath10k and ath11k are the only modern drivers using
device_get_mac_address
>
> > +     if (ret =3D=3D -EPROBE_DEFER)
> > +             return ret;
>
> Please note that this error does not impact the device probe as this is
> being done in the event path after probe returns withis complete.
> Also, this will result in device registration failure even when
> the device is not really looking for mac_addr from nvmem (or it is not
> there) as firmware can also provide the mac_addr from the hardware.

Does probe not handle EPROBE_DEFER?
>
> Vasanth

