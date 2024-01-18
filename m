Return-Path: <linux-wireless+bounces-2160-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 98D6983179E
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Jan 2024 11:59:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F7C62888A7
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Jan 2024 10:59:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E17C2376A;
	Thu, 18 Jan 2024 10:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="aQ7O6UoN"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-vs1-f42.google.com (mail-vs1-f42.google.com [209.85.217.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D139C22F1B
	for <linux-wireless@vger.kernel.org>; Thu, 18 Jan 2024 10:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705575545; cv=none; b=Tz0/JwoXgcVE7PUh4OrJiOYmh8CqmrV7i04Et+iNnKKkuxF/DBsFbSfmI+3RfyWzXLVeS1fSQQ7+CzmP9Fz2ZR1EWzxpa2j4VZzWNcsxnOLTrDs689HCQRa+yhWVCOvlHcnuaQGDX65biGY/InbtLdCZmESlcduESb3CVm6pYgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705575545; c=relaxed/simple;
	bh=XAezkMl8AMyv2duDx8KtemVoTiY3JEudvQLd/3+rctQ=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding; b=aIg7P/E7uTAot1mh6pAYbto4V1TmZA3RInw/AiVW1gKn4BQF7fYblWwV7EdiErRV/VuAOPQA/yTxY8W2uS0GS3G3BNH4aKG1fyz4bKFqlRLteZMF37d9rdk7JJEz13odVqKQnwhxSSVQuwsMezL9UFgzWYpHYso3wMI8kg7Ctvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=aQ7O6UoN; arc=none smtp.client-ip=209.85.217.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-vs1-f42.google.com with SMTP id ada2fe7eead31-466fb179334so2669036137.1
        for <linux-wireless@vger.kernel.org>; Thu, 18 Jan 2024 02:59:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1705575541; x=1706180341; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5kKGm3Yb15Ds8SRKMOgK2sjBctiic0JJzDM70AH8Db0=;
        b=aQ7O6UoNqmzc2cKpHkK2ZRyyOJkrA8Je2CWKJiihaMI4+R48ADOGrw4wYaVKpHFFxJ
         IUKHCUdSv1JNigRvl+evdCz6dl/8BVFHsqBb3xtycSRK3YTlJ2PcIaxBFfdTW650Foa+
         +KhO4G+I0EYvH2IOoEAf41CJAPcM384cpEsYY2o3qS9Y3GlMA0VSvbsv1gVIVPkPPNLg
         rLZq91PkAnJ2zT8GQy0V6IXgVingNu/QsB7UAnRd34xOFGuHUTO+jk6Z6lCWts0UCkSh
         6UGDSOkh6lOcgQOF7HDnZK78rHap2aHIOAD3WufjqaZOTeS/scQwL9+Bh6Ur0FevruQQ
         EXgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705575541; x=1706180341;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5kKGm3Yb15Ds8SRKMOgK2sjBctiic0JJzDM70AH8Db0=;
        b=maHxxpndBMSvxhH/wNdNX9FcASiXFVWWy+f6hAVqmZ6SBFIFPfPJyImoYVrypi5FF4
         Qg2Ko63C1WmRhgS5lmfsDJvItJsNCuBojP1ZI0icI3Y1azOvwFFV+tmHq8phOaBZIwqv
         s0ti59SaofBQphofSeVtPEYMff7/bNS/Zsirgm3iaIGWel8s9yY6iuH4Qi2JmXBcGJoj
         PROnKKdQfU7OAzymeZx/io3X80TvKMVyjnFd65EaylRcnMzfDSQxI+rMSYyUaH3dy3Oh
         UatUzN3/AcN84BYHbNm6bdxYif6Tp/wteGTK4Eaxb2uEk+VWFCOT9N7dqC0QjqRLZlk4
         PsXw==
X-Gm-Message-State: AOJu0YzFCB2CcQuMPxOZWm2/vb6xPlD4Ekfj8ETdrRgfykVPzlCHc4gu
	6bGQYMETqbA3x8yr6PyGIzltnLelnBBj3e0rF4jrMxHlIeyIY4TMA4Q8X5XZDrqS1MRtrGoxgs5
	oIhUUujaZLoqyHAUMjsMVOkZqf+rUmCN2afJcNA==
X-Google-Smtp-Source: AGHT+IErNYi3bFXEg7C3n/Klc9CkVbXd1qVuTyh7DRA66+TJldDEJ7m4oEy9GWfbxO/EHLmuHiKQcKdlVYw+jqqEvk0=
X-Received: by 2002:a67:fbcf:0:b0:468:633:aabb with SMTP id
 o15-20020a67fbcf000000b004680633aabbmr669252vsr.1.1705575541672; Thu, 18 Jan
 2024 02:59:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240117160748.37682-1-brgl@bgdev.pl> <20240117160748.37682-5-brgl@bgdev.pl>
 <2024011707-alibi-pregnancy-a64b@gregkh>
In-Reply-To: <2024011707-alibi-pregnancy-a64b@gregkh>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Thu, 18 Jan 2024 11:58:50 +0100
Message-ID: <CAMRc=Mef7wxRccnfQ=EDLckpb1YN4DNLoC=AYL8v1LLJ=uFH2Q@mail.gmail.com>
Subject: Re: [PATCH 4/9] PCI: create platform devices for child OF nodes of
 the port node
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Kalle Valo <kvalo@kernel.org>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konrad.dybcio@linaro.org>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Heiko Stuebner <heiko@sntech.de>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, Chris Morgan <macromorgan@hotmail.com>, 
	Linus Walleij <linus.walleij@linaro.org>, Geert Uytterhoeven <geert+renesas@glider.be>, 
	Arnd Bergmann <arnd@arndb.de>, Neil Armstrong <neil.armstrong@linaro.org>, 
	=?UTF-8?B?TsOtY29sYXMgRiAuIFIgLiBBIC4gUHJhZG8=?= <nfraprado@collabora.com>, 
	Marek Szyprowski <m.szyprowski@samsung.com>, Peng Fan <peng.fan@nxp.com>, 
	Robert Richter <rrichter@amd.com>, Dan Williams <dan.j.williams@intel.com>, 
	Jonathan Cameron <Jonathan.Cameron@huawei.com>, Terry Bowman <terry.bowman@amd.com>, 
	Lukas Wunner <lukas@wunner.de>, Huacai Chen <chenhuacai@kernel.org>, Alex Elder <elder@linaro.org>, 
	Srini Kandagatla <srinivas.kandagatla@linaro.org>, Abel Vesa <abel.vesa@linaro.org>, 
	linux-wireless@vger.kernel.org, netdev@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-pci@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 17, 2024 at 5:45=E2=80=AFPM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Wed, Jan 17, 2024 at 05:07:43PM +0100, Bartosz Golaszewski wrote:
> > From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> >
> > In order to introduce PCI power-sequencing, we need to create platform
> > devices for child nodes of the port node.
>
> Ick, why a platform device?  What is the parent of this device, a PCI
> device?  If so, then this can't be a platform device, as that's not what
> it is, it's something else so make it a device of that type,.
>

Greg,

This is literally what we agreed on at LPC. In fact: during one of the
hall track discussions I said that you typically NAK any attempts at
using the platform bus for "fake" devices but you responded that this
is what the USB on-board HUB does and while it's not pretty, this is
what we need to do.

Now as for the implementation, the way I see it we have two solutions:
either we introduce a fake, top-level PCI slot platform device device
that will reference the PCI host controller by phandle or we will live
with a secondary, "virtual" platform device for power sequencing that
is tied to the actual PCI device. The former requires us to add DT
bindings, add a totally fake DT node representing the "slot" which
doesn't really exist (and Krzysztof already expressed his negative
opinion of that) and then have code that will be more complex than it
needs to be. The latter allows us to not change DT at all (other than
adding regulators, clocks and GPIOs to already existing WLAN nodes),
reuse the existing parent-child relationship between the port node and
the instantiated platform device as well as result in simpler code.

Given that DT needs to be stable while the underlying C code can
freely change if we find a better solution, I think that the second
option is a no-brainer here.

> > They will get matched against
> > the pwrseq drivers (if one exists) and then the actual PCI device will
> > reuse the node once it's detected on the bus.
>
> Reuse it how?
>

By consuming the same DT node using device_set_of_node_from_dev() when
the PCI device is registered. This ensures we don't try to bind
pinctrl twice etc.

> > Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> > ---
> >  drivers/pci/bus.c    | 9 ++++++++-
> >  drivers/pci/remove.c | 3 ++-
> >  2 files changed, 10 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/pci/bus.c b/drivers/pci/bus.c
> > index 9c2137dae429..8ab07f711834 100644
> > --- a/drivers/pci/bus.c
> > +++ b/drivers/pci/bus.c
> > @@ -12,6 +12,7 @@
> >  #include <linux/errno.h>
> >  #include <linux/ioport.h>
> >  #include <linux/of.h>
> > +#include <linux/of_platform.h>
> >  #include <linux/proc_fs.h>
> >  #include <linux/slab.h>
> >
> > @@ -342,8 +343,14 @@ void pci_bus_add_device(struct pci_dev *dev)
> >        */
> >       pcibios_bus_add_device(dev);
> >       pci_fixup_device(pci_fixup_final, dev);
> > -     if (pci_is_bridge(dev))
> > +     if (pci_is_bridge(dev)) {
> >               of_pci_make_dev_node(dev);
> > +             retval =3D of_platform_populate(dev->dev.of_node, NULL, N=
ULL,
> > +                                           &dev->dev);
>
> So this is a pci bridge device, not a platform device, please don't do
> this, make it a real device of a new type.
>

Not sure what you mean. Are you suggesting adding a new bus? Or do we
already have a concept of PCI bridge devices in the kernel?

Bartosz

> thanks,
>
> greg k-h

