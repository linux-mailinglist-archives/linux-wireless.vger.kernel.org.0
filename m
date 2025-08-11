Return-Path: <linux-wireless+bounces-26276-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 34853B21661
	for <lists+linux-wireless@lfdr.de>; Mon, 11 Aug 2025 22:25:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3852817E71D
	for <lists+linux-wireless@lfdr.de>; Mon, 11 Aug 2025 20:25:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9529D2D9ECA;
	Mon, 11 Aug 2025 20:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l3H4IDnf"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F11CF311C13;
	Mon, 11 Aug 2025 20:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754943925; cv=none; b=WfQQHw3K/diRRxcfzFw/ummVRPi/4UAZzCDhBDjKKRp0+IQFSJ4xWVQOuLQIMgjq4xGIJ0/U+6nhHidpp0XipzbrxdHlMdvxu5pDPZJKAOSLEfVQfqHx/3vQd5qRMfrnlXBEYTQbpwyCXRty5QYF0MlyXA3BqjsAs/reWzxpolE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754943925; c=relaxed/simple;
	bh=xFsEMZMx71vL7LJWMb0H4gztc03wO1iFZ3A6/tkXmf0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IGHbz/b9cwFlZQZGl8vFfezSGPeA0JoLjSSwvJwWxpk21R22YyzYQ2kDnVaGu2t9G9hHATZXDf9IBr3x70h+CuxwmvTRDHEY6v+hgCAiREhu37GYFSNTKo6cae2cZBcLgkywWfnm/zQW6l4FCDaNnbkU2ohXEMGXFgz9bCBtZOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l3H4IDnf; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-71c06bb7470so24179717b3.3;
        Mon, 11 Aug 2025 13:25:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754943923; x=1755548723; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RBXQBxGfZ1zpntH+TOiqrJLsBk8tkPN10Nu3SVV4di8=;
        b=l3H4IDnfkbmonpurxXKhOPt4hTwk/M1JeaaH60AS2zZfa4hQcparluYJNN0u0I8otA
         QA6sILw1YOrXJIAw0EIiGRwUh2PH4IDOk8L0C7qSpMX9+bss10tklLylDPF2XzXKZPE3
         dOW1kKEyKlXGh4yjnCPK9BanJdmoBv+Q7DXZVoqzpxgYCGrY2Fu8Y7Nv/+ssmsLArB4H
         yg+JJ67Xi5oUxbar0n5FA/Y5cuRkkxJp+w6l8jntq8ludljeR7mysNaIGkFx4JR3/OEG
         0dcrmXKS165LeXC7L4xTj2cLyGhjwpo5+7xB3XejhvL1Sv4G2psQJNlZvpK1Nkbny1Ky
         7AZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754943923; x=1755548723;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RBXQBxGfZ1zpntH+TOiqrJLsBk8tkPN10Nu3SVV4di8=;
        b=v9iEjOiAdeVJ0cs7xzDo6pX4ppvAHlfngZwfiwLG6ImnDYERUWt1UCG0HsQFh0eLhO
         EgmbKAWppVIlZ3fejICWIBfCfkglISKS++5U3firJSkCMPE6VxjTYOhCpQQSMelCZbFL
         eXoSOo5XL7/MIRSdmBFgmMrvHQ4gNB5+ec14NW+rp9aRdiNcqdHKyprFi0r1IlxBl6AX
         zsFXAL7B8/BjjPytMxdjLdWt2Or813kQGMmFPd/hcMZVjzXClOfm8cpz+m9iF+Ve0ViO
         xuQYax/t1esZjvi2zD41c77Hxm1n+SFOI1wTL/LH+RZihGx0MY6Ji5vwUoNpgNuZxSqP
         qmDQ==
X-Forwarded-Encrypted: i=1; AJvYcCWbSiOIXjsGG5V5RjbB8M8q0QcHSzepCP8xdfZRkEg53JLNIKamkcjbeNbUhtxICuOJ1mRyV2im6TMDtOg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6FzHHjHo1dzDGfigW/p4/Gf6/BlVcSnBHe1WGOC4yvqRzb/1x
	u7b77Ka4GTPsRLMgIDbxU8BXkI4h9Tp10B4Gl/P1Gaif5ojZ07yk3/dY3ctlisuK8YVFPx1nCeD
	/Ri7MT55CLpIAGgXpo+TlQJo+FOsIW/Y=
X-Gm-Gg: ASbGncsZbg77JZ2kAHVgyxtVXFkrnyM8K4GRYF/2X5SgFQaO2rGF7wwyvzE4SjCDbLe
	gkXWHtbgym6SDvRWiCv3pAvLYGc1lpO0JUn5m5r4bSpv7+Trv2yBVajiwkrBdQlGvvpwe8y3IMH
	ZpoXXWVJsKaXkxE8j6G3KUsmcNhIrTkFH3lApBPzAIlX0Yi2/DcaByJuWLBeHrHr2JQ7X7zWNae
	sLIOl8li8FAWXhsiYqr
X-Google-Smtp-Source: AGHT+IGT6zgJrI+bwB8rpn6s+VJg0y2XQvjU11F/NMNvCcXTBbAqPiT0BUy1aINV8dMOssmCRvrZmQOBZRc5rglA2U0=
X-Received: by 2002:a05:690c:350f:b0:71c:149b:869a with SMTP id
 00721157ae682-71c4286f33dmr17279787b3.0.1754943922701; Mon, 11 Aug 2025
 13:25:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250809031517.5535-1-rosenp@gmail.com> <adf6d126-1f80-4590-a9f6-171b7feaf656@oss.qualcomm.com>
In-Reply-To: <adf6d126-1f80-4590-a9f6-171b7feaf656@oss.qualcomm.com>
From: Rosen Penev <rosenp@gmail.com>
Date: Mon, 11 Aug 2025 13:25:11 -0700
X-Gm-Features: Ac12FXwdnaim6R97XiHA8gvSEBp7k4c9rBg3M3JXjfO7r7BbFC0AH16IyBnLB64
Message-ID: <CAKxU2N8=B8JHNppr+RbOBbzBztXs1f2wLVn3ZtwDHSpokCNf0Q@mail.gmail.com>
Subject: Re: [PATCH ath-next] wifi: ath10k: switch to of_get_mac_address
To: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Cc: linux-wireless@vger.kernel.org, Jeff Johnson <jjohnson@kernel.org>, 
	"open list:QUALCOMM ATHEROS ATH10K WIRELESS DRIVER" <ath10k@lists.infradead.org>, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 11, 2025 at 12:55=E2=80=AFPM Jeff Johnson
<jeff.johnson@oss.qualcomm.com> wrote:
>
> On 8/8/2025 8:15 PM, Rosen Penev wrote:
> > In 9d5804662ce1f9bdde0a14c3c40940acbbf09538 , device_get_mac_address wa=
s
>
> see
> https://www.kernel.org/doc/html/latest/process/submitting-patches.html#de=
scribe-your-changes
>
> specifically: If you want to refer to a specific commit, don=E2=80=99t ju=
st refer to
> the SHA-1 ID of the commit. Please also include the oneline summary of th=
e
> commit, to make it easier for reviewers to know what it is about.
>
> So in this case:
> 9d5804662ce1 ("ath10k: retrieve MAC address from system firmware if provi=
ded")
>
> > introduced as a generic way to get MAC addresses from anywhere.
> > Unfortunately since then, the landscape has changed and the OF version
>
> when did the landscape change? if using device_get_mac_address() is break=
ing
> folks, it would be nice to know which versions of the kernel have the bad
> behavior so that the patch can be backported to any broken LTS kernels.
>
> > is required for NVMEM support. The second problem is that with NVMEM
> > it's possible that it loads after ath10k. For that reason, check for
> > deferred errors and exit out of probe in such a case.
> >
> > Signed-off-by: Rosen Penev <rosenp@gmail.com>
> > ---
> >  drivers/net/wireless/ath/ath10k/core.c | 5 ++++-
> >  1 file changed, 4 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/net/wireless/ath/ath10k/core.c b/drivers/net/wirel=
ess/ath/ath10k/core.c
> > index 6f78f1752cd6..76747eb0925b 100644
> > --- a/drivers/net/wireless/ath/ath10k/core.c
> > +++ b/drivers/net/wireless/ath/ath10k/core.c
> > @@ -11,6 +11,7 @@
> >  #include <linux/module.h>
> >  #include <linux/firmware.h>
> >  #include <linux/of.h>
> > +#include <linux/of_net.h>
> >  #include <linux/property.h>
> >  #include <linux/dmi.h>
> >  #include <linux/ctype.h>
> > @@ -3456,7 +3457,9 @@ static int ath10k_core_probe_fw(struct ath10k *ar=
)
> >               ath10k_debug_print_board_info(ar);
> >       }
> >
> > -     device_get_mac_address(ar->dev, ar->mac_addr);
> > +     ret =3D of_get_mac_address(ar->dev->of_node, ar->mac_addr);
> > +     if (ret =3D=3D -EPROBE_DEFER)
> > +             goto err_free_firmware_files;
>
> Note a similar proposal for ath11k was deferred since it seems to break x=
86
> attachment when there isn't a device tree node:
> https://msgid.link/ec974dc0-962b-f611-7bbb-c07a3872f70f@oss.qualcomm.com
In response to this, I'll change this patch to only add NVMEM support
>
> I'd have the same concerns here.
> (but I didn't dig into how the fwnode items are set if there isn't a DT)
I have no idea either. I assume for pcie cards the MAC is set from the EEPR=
OM.
>
> >
> >       ret =3D ath10k_core_init_firmware_features(ar);
> >       if (ret) {
>

