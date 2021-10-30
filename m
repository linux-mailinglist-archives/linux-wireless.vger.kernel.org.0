Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29D90440A80
	for <lists+linux-wireless@lfdr.de>; Sat, 30 Oct 2021 19:17:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229793AbhJ3RUT (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 30 Oct 2021 13:20:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229474AbhJ3RUT (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 30 Oct 2021 13:20:19 -0400
Received: from dvalin.narfation.org (dvalin.narfation.org [IPv6:2a00:17d8:100::8b1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FA5BC061570
        for <linux-wireless@vger.kernel.org>; Sat, 30 Oct 2021 10:17:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
        s=20121; t=1635614265;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=XCIslokZ0f+/pV2HjE0E+IzvflFZFzVgQq8TfiBCAgI=;
        b=RlcXAEWV+wURSd/oGzDDnJkN9w2+YHaqRblIGSKTkhovNhZjmst+ZOjZRquDfdYXsRRnWy
        QV9GyzU6O543xMt4oGC0pVV4MuDO4bL992+YtoiP31e9AX4fslYbPJYfy5NApLvWAN4guo
        A0pLH+FihicErhh7v6PlB+t8wHT63R8=
From:   Sven Eckelmann <sven@narfation.org>
To:     luciano.coelho@intel.com,
        Sharadanand Karanjkar <sk@simonwunderlich.de>,
        johannes.berg@intel.com
Cc:     linux-wireless@vger.kernel.org
Subject: Re: iwlwifi: ax210: 6GHz channels disabled in Germany by firmware
Date:   Sat, 30 Oct 2021 19:17:38 +0200
Message-ID: <6520824.1yIjQniEF0@sven-l14>
In-Reply-To: <dd512568-9d9f-289a-bc7b-9b6dfc1c0c8a@simonwunderlich.de>
References: <57f467ec-074c-8260-7872-84eccfdcc1c7@simonwunderlich.de> <dd512568-9d9f-289a-bc7b-9b6dfc1c0c8a@simonwunderlich.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart5147874.xLufmbYGJl"; micalg="pgp-sha512"; protocol="application/pgp-signature"
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

--nextPart5147874.xLufmbYGJl
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"; protected-headers="v1"
From: Sven Eckelmann <sven@narfation.org>
To: luciano.coelho@intel.com, Sharadanand Karanjkar <sk@simonwunderlich.de>, johannes.berg@intel.com
Cc: linux-wireless@vger.kernel.org
Subject: Re: iwlwifi: ax210: 6GHz channels disabled in Germany by firmware
Date: Sat, 30 Oct 2021 19:17:38 +0200
Message-ID: <6520824.1yIjQniEF0@sven-l14>
In-Reply-To: <dd512568-9d9f-289a-bc7b-9b6dfc1c0c8a@simonwunderlich.de>
References: <57f467ec-074c-8260-7872-84eccfdcc1c7@simonwunderlich.de> <dd512568-9d9f-289a-bc7b-9b6dfc1c0c8a@simonwunderlich.de>

On Friday, 29 October 2021 16:55:16 CEST Sharadanand Karanjkar wrote:
> > We are using Intels "ax210ngw" card with "iwlwifi-ty-a0-gf-a0-66.ucode"
> > firmware, we are using the kernel from "5.15.0-rc7" tag.

Would have been nice to have some info about the relevant components directly 
in the subject. And iw is not that relevant - it is just a tool which you used 
to inspect the state of the system. I have therefore adjusted the subject 
slightly

> > The problem we are facing is we are not able to enable 6GHz channels 
> > for Germany region. Following is the output for "iw reg get"
> >
[....]
> >
> > The iw phy# info also shows that the 6GHz channels are not enabled. We 
> > have found one commit which is included in the "5.15.0-rc7" tag which 
> > indicates that 6Ghz channels are now supported in the driver.
> >
> > https://git.kernel.org/pub/scm/linux/kernel/git/sforshee/wireless-regdb.git/commit/?id=cdf854d2ddca01bf126ac138a8ee3e5d6320086f 

This is not part of the driver. But the kernel might use it - like in your 
example. Unfortunately, the previously mentioned firmware includes an own 
regulatory db which is then used for the phy0 ("self managed").

But the commit at least provides some good reasons why Intel might consider 
enabling the indoor channel in the frequency range 5945 - 6425 MHz.  It would 
therefore be nice to know whether/when Intel actually has plans to enable 
these channels in Germany (and not only for the US) in the near future. Maybe 
there are even newer (test) firmware versions available but I am not aware 
of any newer firmware version than the previously mentioned one [1].
And this firmware was published for linux-firmware right around the time when
Vfg. 55/2021 was released - so it is to some extend expected that Intel didn't 
yet incorporated such a change.

I only saw newer releases for other HW [2] but not for Ty.

Kind regards,
	Sven

[1] https://git.kernel.org/pub/scm/linux/kernel/git/iwlwifi/linux-firmware.git/commit/?id=5de082d4d0f2db7722c9e6f5c9cff1fefd8073be
[2] https://chromium-review.googlesource.com/c/chromiumos/third_party/linux-firmware/+/3159525
--nextPart5147874.xLufmbYGJl
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAmF9fjIACgkQXYcKB8Em
e0bNKQ/+L8u30O4T1d/uV+Ov8lHU6PcnOH6tXcB0iYUx7pCirq7zhAiN6/krNdwg
0sTif1+iasgdP7fBvjfOpTOIyGHiXsVOr/uGQSXSQ+zHjAJllmOHRB9eoDgHdcjU
2FjyLCry9XMravM2nleEdJ/CSbPjm/ffHN2k0toNQIGNawkaw2t9eF3i4wPFYgbO
UVYq9qFIQW6nh855k7LBZ/wbrT4rZqPrA2EohozFoYNsfMFC2ZI5tBpBZUpPl06v
X4hrwinnDW1+mFWYqSLsP/LoStSpdZv87nJW3XoK9g+PAZjsRH7xybSiBT34q5Dq
06hfKXBA2doLWsF0bXd0kaurKMgBUt2TGXRdUEDj40G8Rl3OusKlqyx6yR4Muvxg
/zFQrCdtbgRwIEU6L4gtycZ2x9uTCChtwcV1HcOq/4uisjrHsFcqKH/MQN8ff10a
k/BdF6iRjJIySGdDEjAUoJ7+dLKPBCtfgp2NgmR5Lssa1ctCju1O7UleaFUIbt3z
M5TMnXrVfIrDb1/3NAzjKQ/jFCQy7biqq5BTdFrw6pWYswpIPO2pF2YPfav828/A
0eqYRUdm80t9GNFn4EA6ezVtZg9/IG++qAWw/QH7j4fB60m8PfxU3fENOQJmlqrk
TlzGXkivLsxz5O0synAEBpTyInuExjFRm3fv2BRsC5ELi+vWcDE=
=+nXS
-----END PGP SIGNATURE-----

--nextPart5147874.xLufmbYGJl--



