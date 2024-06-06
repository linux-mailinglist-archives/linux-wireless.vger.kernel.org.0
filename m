Return-Path: <linux-wireless+bounces-8622-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B6CB8FEF95
	for <lists+linux-wireless@lfdr.de>; Thu,  6 Jun 2024 16:57:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 45ADEB2AE23
	for <lists+linux-wireless@lfdr.de>; Thu,  6 Jun 2024 14:56:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35DFC19AA6E;
	Thu,  6 Jun 2024 14:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="Uqz4lGYx"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 730AE198848
	for <linux-wireless@vger.kernel.org>; Thu,  6 Jun 2024 14:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717684175; cv=none; b=lDBgiA6vGGYncx2e9zDz31/0+Yf2Qu6Rnm7qhxeHt48wVKa4ZuZV+vs1+cH5E4GqNaXh7Sk2dyNpqHJNi7uSpVG7WdBp7h1vg7exvA3xwZauqS+yAwE26P0t8GdwY8exGwApFu4puOo/d2+FU7yBpFFmIclVmbPKj34mSjaiJm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717684175; c=relaxed/simple;
	bh=GimoAQIvtE/omE2LWe9rkmcZVAyFh7hH8t8gFFgucFY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=A2rUrBqpHVsupxP1eOFwJlgIId5aeSUeXX2oN4X3ZQR45FNBYCv9mSzUvhRb7xVFPu1/Adzkp9XWfPBWADUSSh7QEwDOFPFGH0K9ZQOh0vZLCx2Xf4F7j5nggFV1GdMtDcGT25q8PYqOik/hd0NAugXZXXCQCw/hbnRX31ij7kM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=Uqz4lGYx; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2ea903cd11bso13767201fa.1
        for <linux-wireless@vger.kernel.org>; Thu, 06 Jun 2024 07:29:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1717684171; x=1718288971; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QWrHmrBVbxL2N+yjukzrB1xNIeLZkMy2NcMIU1+JPUg=;
        b=Uqz4lGYxdcOmil+vyxA0jJrA8cR4Acx4g2UO2V6EZYsl4TmmK6DDITf7fJ19Fyv0jy
         g2HD7ify7eEzsC2ZTQYfCj4yB4jVILVXjRLz+8sAXwo7c95uSQCqemDN97S6W2ka7ptz
         MLoi08vZkJM9OR36t5ZunIDtGQyTYRnabAeEH5iXOjQOg2SEy1mbYGBK09+LG0GlYxRl
         EUM/MFxFvrn5Yog8it2E+Qzp0Pub8E84clekP/wXhwfaJfR2a5UELn229IuXIjRLKDXe
         j75Gudw/i91V2bTlHgkapKt8EJ0Eqi6VeDcv/K5bFgi8CN891He2hQ0j5LwHKzio2aRd
         lO4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717684171; x=1718288971;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QWrHmrBVbxL2N+yjukzrB1xNIeLZkMy2NcMIU1+JPUg=;
        b=JjVNA6WI02OvpGWpYzZnBVVbyIX+XDePxNyFKMMECTPdl0dju6VM6dBbKrEAplL7vq
         DGX7ESp2Zi4F4o6dU+j8N3B+ROOVRKcmzXPNIU8ww6KVqwAaYocsc5crBlCyBw2ynLmZ
         XsO+FxzJHapT6hSY9eahOD1n3UfVXKvWYp0H+PrLQ3oWaY4HazDJHAfMZfGRQhfkZ08o
         3xlPkxs3mXh7p2ksyvUanGJg+N0/OD2h5Mi5TiWL7c02qhoq9tnkWrMvrPXks9eDVzkh
         g3CxZDqyWliPRdX7FKNW5nnMHw7GPleAM9lOqA4BrCZW3FxKhKe0GqT71JO2KxWSWbQC
         75Og==
X-Forwarded-Encrypted: i=1; AJvYcCUdsPVvoxcZIWi2K7VyoCv4n2uu3JsQv3lJLt415U3E30yZFed8Okgi0GqSdsuvTKtA179+0mp3F+rtk/uSI4TGjxZJ8Qc3IJ2tcw7KUds=
X-Gm-Message-State: AOJu0YwYZgMlJxLYMcYV92ihE3w6jGDDWgYu2ZzInLYrdpuyaIZiYhvF
	wTVMgNicdvDYOS8UeicsP/rpozlqLQ8f3ChXkXOp1G5Cx63QP0zXJGpI23zl6K+DAuxT19ZtfJW
	zDf7Qnr2CskefsLj0CTpuR2+xrNZa9iN4Bn/daA==
X-Google-Smtp-Source: AGHT+IE7dV5ZV/18QS1Cl24O5VDU/AyKd8svwpktd8Gq/yIywl49RVlO2hEBVV/ZBTiMOrhqd5gtrUxmBJP66OQy6UM=
X-Received: by 2002:a2e:a403:0:b0:2ea:903b:ca0e with SMTP id
 38308e7fff4ca-2eac7a986abmr42490961fa.52.1717684171575; Thu, 06 Jun 2024
 07:29:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240605122106.23818-1-brgl@bgdev.pl> <20240605122106.23818-2-brgl@bgdev.pl>
 <87h6e6qjuh.fsf@kernel.org> <CAMRc=MdiKxtnN+g92RUTXdOydaPV5M2u5iUdKyE2SNvDkdXAjg@mail.gmail.com>
 <871q5aqiei.fsf@kernel.org>
In-Reply-To: <871q5aqiei.fsf@kernel.org>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Thu, 6 Jun 2024 16:29:20 +0200
Message-ID: <CAMRc=McacZMP-51hjH+d8=PVe+Wgw4a8xWcv0sRPLJKL_gP=KQ@mail.gmail.com>
Subject: Re: [PATCH v9 1/2] dt-bindings: net: wireless: qcom,ath11k: describe
 the ath11k on QCA6390
To: Kalle Valo <kvalo@kernel.org>
Cc: "David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Jeff Johnson <jjohnson@kernel.org>, linux-wireless@vger.kernel.org, 
	netdev@vger.kernel.org, devicetree@vger.kernel.org, 
	ath11k@lists.infradead.org, linux-kernel@vger.kernel.org, 
	ath12k@lists.infradead.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 6, 2024 at 4:02=E2=80=AFPM Kalle Valo <kvalo@kernel.org> wrote:
>
> Bartosz Golaszewski <brgl@bgdev.pl> writes:
>
> > On Thu, Jun 6, 2024 at 3:30=E2=80=AFPM Kalle Valo <kvalo@kernel.org> wr=
ote:
> >
> >>
> >> Bartosz Golaszewski <brgl@bgdev.pl> writes:
> >>
> >> > From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> >> >
> >> > Add a PCI compatible for the ATH11K module on QCA6390 and describe t=
he
> >> > power inputs from the PMU that it consumes.
> >> >
> >> > Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> >> > Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> >>
> >> [...]
> >>
> >> > +allOf:
> >> > +  - if:
> >> > +      properties:
> >> > +        compatible:
> >> > +          contains:
> >> > +            const: pci17cb,1101
> >> > +    then:
> >> > +      required:
> >> > +        - vddrfacmn-supply
> >> > +        - vddaon-supply
> >> > +        - vddwlcx-supply
> >> > +        - vddwlmx-supply
> >> > +        - vddrfa0p8-supply
> >> > +        - vddrfa1p2-supply
> >> > +        - vddrfa1p7-supply
> >> > +        - vddpcie0p9-supply
> >> > +        - vddpcie1p8-supply
> >>
> >> Not sure if we discussed this before, but based on this I understand
> >> that there can't be an DT entry for device pci17cb,1101 without all th=
e
> >> supply properties? But there are QCA6390 devices with PCI id 17cb:1101
> >> which do not need these supplies and already work. For example, my Del=
l
> >> XPS 13 x86 laptop is one. Or anyone who manually installs QCA6390 boar=
d
> >> to their PCI slot and some of them might want to use DT, for example
> >> setting qcom,ath11k-calibration-variant.
> >>
> >> This is not a blocker for me, just making sure that we are not breakin=
g
> >> any existing setups.
> >>
> >
> > If they are already powered up without the need for the PCI pwrctl
> > driver to do it, then they will work alright. Bindings don't affect
> > functionality.
>
> Sure, I'm not worried about functionality. I'm worried that if I
> there's, for example, an ARM based setup which uses DT and wants to use
> a similar QCA6390 board that I have, and set
> qcom,ath11k-calibration-variant in DT. In other words, I'm worried if
> you are looking at this only for Snapdragon family of boards?
>

No, what I'm looking at is the entire QCA6390 package. That means WLAN
*and* Bluetooth *and* the PMU that manages power.

If you're using the QCA6390 on a device-tree system then you should
probably model at least the WLAN node and the PMU and the problem with
supplies is fixed. But if you don't have the supplies, that's alright
for downstream.

> Again, I don't see this as a blocker. I just want to understand how this
> should work for all types of devices there are out there.
>
> > But if you have a QCA6390 then you have its PMU too and the bindings
> > model the real-world hardware.
> >
> > IOW: your laptop should be alright but the supplies are really there
> > which warrants adding them to the bindings.
>
> Sorry, not following here. Can you clarify your comment "the supplies
> are really there"? You mean inside the PCI board? But that's not visible
> to the kernel in anyway, the PCI board just works after I plug it in.
> It's like a regular PCI device. So I don't understand why that should be
> visible in DT, but I can very well be missing something.
>

I think you're thinking about some kind of detachable PCIe board with
this chipset on it. I refer to the QCA6390 chipset itself which is
also more than just PCI. The Bluetooth interface doesn't use PCI at
all. On the boards I'm working on, the chipset is just soldered to the
main board. If your detachable board "just works" then it must be
wired in a way that enables WLAN the moment it's plugged in but this
doesn't happen over PCI. The chipset has a power input and GPIOs to
enable each module.

Also: I doubt you need DT for your detachable board?

Bart

> --
> https://patchwork.kernel.org/project/linux-wireless/list/
>
> https://wireless.wiki.kernel.org/en/developers/documentation/submittingpa=
tches

