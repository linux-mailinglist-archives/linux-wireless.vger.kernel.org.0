Return-Path: <linux-wireless+bounces-11269-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D198694E070
	for <lists+linux-wireless@lfdr.de>; Sun, 11 Aug 2024 10:10:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6ED811C20E6F
	for <lists+linux-wireless@lfdr.de>; Sun, 11 Aug 2024 08:10:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10951208B6;
	Sun, 11 Aug 2024 08:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IayuqrgV"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C95BB200A3;
	Sun, 11 Aug 2024 08:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723363847; cv=none; b=XeClIvAgoZaGJtxn6VFdTDQVF+VmDsjysx0Qll107LmlzmbxCtXyORzwQNA1UqOLkDTvMGom9cLPt4kYHnd/aFTF0dxxaA1YSs9IYp9aKyOr2LAoxkUBsTgMjUeX35e4LGW8oIRfiAScqm5ScOm1mepfsviAnbsFgVu704+P/Vc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723363847; c=relaxed/simple;
	bh=nZFC08tDh3nttnNBJVhskJcR0F7oLOKEuY05u6lL1vI=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=CxuA3ZVID5pTIIFclHEdIT1knXHjNHJI/d3WPmySbEVwAU+HT++rYazskaqCw5hawz5sjmZsNoxVhv+mfLITfJqWpOtnnfjqKdpV9EEAcyq26hFfk/tmvWUVns2t7ieZH+FGFqrjc6BzdI0p1S65tJkLuoB0OYwVSR9SCqHynDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IayuqrgV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F856C4AF0C;
	Sun, 11 Aug 2024 08:10:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723363847;
	bh=nZFC08tDh3nttnNBJVhskJcR0F7oLOKEuY05u6lL1vI=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=IayuqrgVtF03hxP3tVa0X2jMdwJIQiZvedasEzt4EiDzetg/YWqw+N3rHwOUgj1O7
	 glWVz2/gjDD8FiVKSJCHkDIkCJXTMZ6qDM/YbL/NWJ8z7JGsUd5OYXqHyPNNZFkGJj
	 gYB4t2FWWnQdSTtDD9lgpCezPjYX4TRLQ7x0dT96pPH22G2GD4nakyMQxWA98Imdey
	 IdUYWoNzWedlDi8tZWfK8QwP+Owg9tnWU9v3y3AoknpKEJ7h8fTipsA8OwSpEhCYlD
	 198BwYKta2npoYls9aUNOuSxuf5kzTa4BkaVBAOaASOOL9jTicowjyAceLcKdzcinD
	 Tj0bIFimIcfUg==
From: Kalle Valo <kvalo@kernel.org>
To: Arend van Spriel <arend.vanspriel@broadcom.com>
Cc: jacobe.zang@wesion.com,  Sai Krishna Gajula <saikrishnag@marvell.com>,
  "robh@kernel.org" <robh@kernel.org>,  "krzk+dt@kernel.org"
 <krzk+dt@kernel.org>,  "heiko@sntech.de" <heiko@sntech.de>,
  "davem@davemloft.net" <davem@davemloft.net>,  "edumazet@google.com"
 <edumazet@google.com>,  "kuba@kernel.org" <kuba@kernel.org>,
  "pabeni@redhat.com" <pabeni@redhat.com>,  "conor+dt@kernel.org"
 <conor+dt@kernel.org>,  "efectn@protonmail.com" <efectn@protonmail.com>,
  "dsimic@manjaro.org" <dsimic@manjaro.org>,  "jagan@edgeble.ai"
 <jagan@edgeble.ai>,  "devicetree@vger.kernel.org"
 <devicetree@vger.kernel.org>,  "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
  "linux-rockchip@lists.infradead.org"
 <linux-rockchip@lists.infradead.org>,  "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>,  "arend@broadcom.com"
 <arend@broadcom.com>,  "linux-wireless@vger.kernel.org"
 <linux-wireless@vger.kernel.org>,  "netdev@vger.kernel.org"
 <netdev@vger.kernel.org>,  "megi@xff.cz" <megi@xff.cz>,
  "duoming@zju.edu.cn" <duoming@zju.edu.cn>,  "bhelgaas@google.com"
 <bhelgaas@google.com>,  "minipli@grsecurity.net" <minipli@grsecurity.net>,
  "brcm80211@lists.linux.dev" <brcm80211@lists.linux.dev>,
  "brcm80211-dev-list.pdl@broadcom.com"
 <brcm80211-dev-list.pdl@broadcom.com>,  "nick@khadas.com"
 <nick@khadas.com>
Subject: Re: [PATCH v9 4/5] wifi: brcmfmac: Add optional lpo clock enable
 support
References: <20240810035141.439024-1-jacobe.zang@wesion.com>
	<20240810035141.439024-5-jacobe.zang@wesion.com>
	<BY3PR18MB47072A9CC7E1EEB4BD1FC063A0BB2@BY3PR18MB4707.namprd18.prod.outlook.com>
	<d9a182e4-c620-476d-8eb2-752dfd1ba4f8@wesion.com>
	<fb9947fa-bca8-4c51-9feb-bf7ac6c6cc22@broadcom.com>
Date: Sun, 11 Aug 2024 11:10:39 +0300
In-Reply-To: <fb9947fa-bca8-4c51-9feb-bf7ac6c6cc22@broadcom.com> (Arend van
	Spriel's message of "Sat, 10 Aug 2024 20:32:42 +0200")
Message-ID: <8734nb32f4.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Arend van Spriel <arend.vanspriel@broadcom.com> writes:

> On 8/10/2024 12:08 PM, jacobe.zang@wesion.com wrote:
>
>> On 2024/8/10 17:44, Sai Krishna Gajula <saikrishnag@marvell.com>
>> wrote:
>>>
>>> > -----Original Message-----
>>> > From: Jacobe Zang <jacobe.zang@wesion.com>
>>> > Sent: Saturday, August 10, 2024 9:22 AM
>>> > To: robh@kernel.org; krzk+dt@kernel.org; heiko@sntech.de;
>>> > kvalo@kernel.org; davem@davemloft.net; edumazet@google.com;
>>> > kuba@kernel.org; pabeni@redhat.com; conor+dt@kernel.org;
>>> > arend.vanspriel@broadcom.com
>>> > Cc: efectn@protonmail.com; dsimic@manjaro.org; jagan@edgeble.ai;
>>> > devicetree@vger.kernel.org; linux-arm-kernel@lists.infradead.org;
>>> linux-
>>> > rockchip@lists.infradead.org; linux-kernel@vger.kernel.org;
>>> > arend@broadcom.com; linux-wireless@vger.kernel.org;
>>> > netdev@vger.kernel.org; megi@xff.cz; duoming@zju.edu.cn;
>>> > bhelgaas@google.com; minipli@grsecurity.net; brcm80211@lists.linux.de=
v;
>>> > brcm80211-dev-list.pdl@broadcom.com; nick@khadas.com; Jacobe Zang
>>> > <jacobe.zang@wesion.com>
>>> > Subject:=C2=A0 [PATCH v9 4/5] wifi: brcmfmac: Add optional lpo clock
>>> > enable support
>>> >
>>> > WiFi modules often require 32kHz clock to function. Add support
>>> to enable
>>> > the clock to PCIe driver and move "brcm,bcm4329-fmac" check to
>>> the top of
>>> > brcmf_of_probe. Change function prototypes from void to int and add
>>> > appropriate errno's for return
>>> > WiFi modules often require 32kHz clock to function. Add support
>>> to enable
>>> > the clock to PCIe driver and move "brcm,bcm4329-fmac" check to
>>> the top of
>>> > brcmf_of_probe. Change function prototypes from void to int and add
>>> > appropriate errno's for return values that will be send to bus
>>> when error
>>> > occurred.
>>> >
>>> > Co-developed-by: Ondrej Jirman <megi@xff.cz>
>>> > Signed-off-by: Ondrej Jirman <megi@xff.cz>
>>> > Co-developed-by: Arend van Spriel <arend.vanspriel@broadcom.com>
>>> > Signed-off-by: Arend van Spriel <arend.vanspriel@broadcom.com>
>>> > Signed-off-by: Jacobe Zang <jacobe.zang@wesion.com>
>>> > ---
>>> >=C2=A0=C2=A0 .../broadcom/brcm80211/brcmfmac/bcmsdh.c=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 |=C2=A0 4 +-
>>> >=C2=A0=C2=A0 .../broadcom/brcm80211/brcmfmac/common.c=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 |=C2=A0 3 +-
>>> >=C2=A0=C2=A0 .../wireless/broadcom/brcm80211/brcmfmac/of.c | 53
>>> +++++++++++--------
>>> > .../wireless/broadcom/brcm80211/brcmfmac/of.h |=C2=A0 9 ++--
>>> >=C2=A0=C2=A0 .../broadcom/brcm80211/brcmfmac/pcie.c=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 3 ++
>>> >=C2=A0=C2=A0 .../broadcom/brcm80211/brcmfmac/sdio.c=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 | 24 ++++++---
>>> >=C2=A0=C2=A0 .../broadcom/brcm80211/brcmfmac/usb.c=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 3 ++
>>> >=C2=A0=C2=A0 7 files changed, 63 insertions(+), 36 deletions(-)
>>> >
>>> > diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c
>>> > b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c
>>> > index 13391c2d82aae..b2ede4e579c5c 100644
>>> > --- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c
>>> > +++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c
>>> > @@ -947,8 +947,8 @@ int brcmf_sdiod_probe(struct brcmf_sdio_dev
>>> > *sdiodev)
>>> >
>>> >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* try to attach to the target de=
vice */
>>> >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sdiodev->bus =3D brcmf_sdio_probe=
(sdiodev);
>>> > -=C2=A0=C2=A0=C2=A0 if (!sdiodev->bus) {
>>> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D -ENODEV;
>>> > +=C2=A0=C2=A0=C2=A0 if (IS_ERR(sdiodev->bus)) {
>>> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D PTR_ERR(sdiodev->=
bus);
>>> >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto out;
>>> >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>> >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 brcmf_sdiod_host_fixup(sdiodev->f=
unc2->card->host);
>>> > diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/common.c
>>> > b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/common.c
>>> > index b24faae35873d..58d50918dd177 100644
>>> > --- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/common.c
>>> > +++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/common.c
>>> > @@ -561,7 +561,8 @@ struct brcmf_mp_device
>>> > *brcmf_get_module_param(struct device *dev,
>>> >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!found) {
>>> >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* No pla=
tform data for this device, try OF and DMI data */
>>> >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 brcmf_dmi=
_probe(settings, chip, chiprev);
>>> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 brcmf_of_probe(dev, bus_t=
ype, settings);
>>> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (brcmf_of_probe(dev, b=
us_type, settings) =3D=3D -
>>> > EPROBE_DEFER)
>>> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 r=
eturn ERR_PTR(-EPROBE_DEFER);
>>> >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 brcmf_acp=
i_probe(dev, bus_type, settings);
>>> >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>> >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return settings;
>>> > diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/of.c
>>> > b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/of.c
>>> > index e406e11481a62..f19dc7355e0e8 100644
>>> > --- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/of.c
>>> > +++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/of.c
>>> > @@ -6,6 +6,7 @@
>>> >=C2=A0=C2=A0 #include <linux/of.h>
>>> >=C2=A0=C2=A0 #include <linux/of_irq.h>
>>> >=C2=A0=C2=A0 #include <linux/of_net.h>
>>> > +#include <linux/clk.h>
>>> >
>>> >=C2=A0=C2=A0 #include <defs.h>
>>> >=C2=A0=C2=A0 #include "debug.h"
>>> > @@ -65,17 +66,21 @@ static int brcmf_of_get_country_codes(struct devi=
ce
>>> > *dev,
>>> >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return 0;
>>> >=C2=A0=C2=A0 }
>>> >
>>> > -void brcmf_of_probe(struct device *dev, enum brcmf_bus_type bus_type,
>>> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 s=
truct brcmf_mp_device *settings)
>>> > +int brcmf_of_probe(struct device *dev, enum brcmf_bus_type bus_type,
>>> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct =
brcmf_mp_device *settings)
>>> >=C2=A0=C2=A0 {
>>> >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct brcmfmac_sdio_pd *sdio =3D=
 &settings->bus.sdio;
>>> >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct device_node *root, *np =3D=
 dev->of_node;
>>> > +=C2=A0=C2=A0=C2=A0 struct clk *clk;
>>> >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 const char *prop;
>>>
>>> Small nit, please check if reverse x-mas tree order need to be
>>> follow here.
>>>
>>> >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int irq;
>>> >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int err;
>>> >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 u32 irqf;
>> It can be seen from this line that there should be no need to follow
>> the reverse x-mas tree order. Because it is a struct variable, so
>> place with other struct ones.
>
> As driver maintainer I do not care about such neatness, but maybe
> Kalle has another preference. The code above looks fine to me.

We haven't been strongly requiring reverse x-mas tree in wireless code,
it has been just a preference. Also for me the code above looks fine.

--=20
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatc=
hes

