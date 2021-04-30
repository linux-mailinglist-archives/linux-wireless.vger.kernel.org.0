Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C168836F65A
	for <lists+linux-wireless@lfdr.de>; Fri, 30 Apr 2021 09:22:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229752AbhD3HXN (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 30 Apr 2021 03:23:13 -0400
Received: from dvalin.narfation.org ([213.160.73.56]:39864 "EHLO
        dvalin.narfation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229590AbhD3HXK (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 30 Apr 2021 03:23:10 -0400
X-Greylist: delayed 424 seconds by postgrey-1.27 at vger.kernel.org; Fri, 30 Apr 2021 03:23:10 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
        s=20121; t=1619766913;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4N87R8hHeys4zB3iQZJH55+DFPxABQ/mPIh4s0AtOjo=;
        b=QngDDYWITFFfYseCFsKv9KDVtQxqFca7OMmPNeqUlTee4MqVz3KaH3RmJUnRfX3c2dpkXw
        i4VR1MIWagUjITrHmajDkksU0N/e+ociWRjINqYCvx5gbthzCA3WhXvGsTqG1X8GtlYILx
        reyYjazUVHYxDK7A+mJysEYFZblamGY=
From:   Sven Eckelmann <sven@narfation.org>
To:     ath11k@lists.infradead.org, linux-wireless@vger.kernel.org
Cc:     Maharaja Kennadyrajan <mkenna@codeaurora.org>
Subject: Re: [PATCH v2 0/3] Add support to configure beacon tx mode
Date:   Fri, 30 Apr 2021 09:15:06 +0200
Message-ID: <4581459.tLtf2NohVe@ripper>
In-Reply-To: <1619696874-30072-1-git-send-email-mkenna@codeaurora.org>
References: <1619696874-30072-1-git-send-email-mkenna@codeaurora.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1712661.e4ZrjNOSLu"; micalg="pgp-sha512"; protocol="application/pgp-signature"
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

--nextPart1712661.e4ZrjNOSLu
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"; protected-headers="v1"
From: Sven Eckelmann <sven@narfation.org>
To: ath11k@lists.infradead.org, linux-wireless@vger.kernel.org
Cc: Maharaja Kennadyrajan <mkenna@codeaurora.org>
Subject: Re: [PATCH v2 0/3] Add support to configure beacon tx mode
Date: Fri, 30 Apr 2021 09:15:06 +0200
Message-ID: <4581459.tLtf2NohVe@ripper>
In-Reply-To: <1619696874-30072-1-git-send-email-mkenna@codeaurora.org>
References: <1619696874-30072-1-git-send-email-mkenna@codeaurora.org>

On Thursday, 29 April 2021 13:47:51 CEST Maharaja Kennadyrajan wrote:
[...]
> Beacons can be sent out in burst(continuously in a single shot
> one after another) or staggered (equally spread out over beacon
> interval) mode.
> 
> V2:
> 	Addressed Johannes's comment on v1 patch.
> 	Updated the commit log.

Still it is advertised as vif setting but the code itself shows that it is a 
phy setting (as you would expect). Or is it a potential feature for a device 
to send some beacons staggered and some beacons as burst?

Kind regards,
	Sven
--nextPart1712661.e4ZrjNOSLu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAmCLrnoACgkQXYcKB8Em
e0aEFQ//VpQqXvuo31Uos4tq0mqLv4uulNB+pHArrJ9LhKhtZHCIfckWRFaX/aXJ
VuzXcnCulu2JZ3iWnUpA64nhyL2y0wisEjMOqZxMZiOtcn4IGE8PyjTGZjavoAmg
UXkgdsIic4Lib5Tg1+Zw86ekAfKbTr9I9GYu1AA/LCTpYqZHzpQw/ABsbDvwYYsW
QHO43K7SLf1um3Rh9CYu21j9tZm8l/nU+8exb4X2LkZttcXihM89m7LbpxW7CaOi
lx89eR5rZ7/ZTFeBieD61EFJNNQbnAwVeNknNaJPoqYKEqVvskh6WfxPXKUywQ4m
I4EfEdX1RUXs80Lnynxp1DN/KC47ZX72bAxETYdqLyKtHdxUys6K9ThCr6kJ7E2B
fWPNAqExDL34mL2DCAEWTj4HZ981aUi1FEVCB5m+iMRM0ntgbZZvrBsiNpPu6R5o
BpBtf4J0yGWykjY10TymjFmUF/UJDGJ/hH9tkBoxHXF+M0J3WEEV086mdKN6zm7s
MKxIzeRCX43KN9FvKMvPIEOvAOH8+8YiyoO92t+QeNzG8jYd7FDfrbX7HniCdcFQ
408DMnA3cthWy23v69LdtU+3G27cm/lPUO8NO+7dXkM1a4swgiVuGaGSEQXORn76
gqbtYnOZYhNowx2EXnAUq3qm3Yu1LXNZSSrD2oHqhT0JeKb9MvE=
=v8x9
-----END PGP SIGNATURE-----

--nextPart1712661.e4ZrjNOSLu--



