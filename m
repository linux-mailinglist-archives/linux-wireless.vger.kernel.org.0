Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD2C92A694A
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Nov 2020 17:18:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728258AbgKDQSr (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 4 Nov 2020 11:18:47 -0500
Received: from dvalin.narfation.org ([213.160.73.56]:48390 "EHLO
        dvalin.narfation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726564AbgKDQSq (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 4 Nov 2020 11:18:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
        s=20121; t=1604506724;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Bnr/XAJwHxn0CQVrJy3GzlIfrFLrGLc0xtXaWyRVg1M=;
        b=gG5OxVueW9QMUEPOa9i3sQBid7TVY7+ior9irwsHlv1QjzK7qUXiC4WGEIlBym13I5/C+8
        7RpVfcaW3ZVIrhpMgMXXUG2He6sNN75CvjnsPB4r9Ezen3k1otdso33tPjBCD/bu+z3k2f
        Yv7BkG7mlZVaBk5HOWzo8fXcUrfN8kY=
From:   Sven Eckelmann <sven@narfation.org>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     ath11k@lists.infradead.org, linux-wireless@vger.kernel.org
Subject: Re: [PATCH] ath11k: Initialize complete alpha2 for regulatory change
Date:   Wed, 04 Nov 2020 17:18:41 +0100
Message-ID: <1801487.IobQ9Gjlxr@ripper>
In-Reply-To: <87v9elqeuj.fsf@codeaurora.org>
References: <20201021140555.4114715-1-sven@narfation.org> <87v9elqeuj.fsf@codeaurora.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2507857.Isy0gbHreE"; micalg="pgp-sha512"; protocol="application/pgp-signature"
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

--nextPart2507857.Isy0gbHreE
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"; protected-headers="v1"
From: Sven Eckelmann <sven@narfation.org>
To: Kalle Valo <kvalo@codeaurora.org>
Cc: ath11k@lists.infradead.org, linux-wireless@vger.kernel.org
Subject: Re: [PATCH] ath11k: Initialize complete alpha2 for regulatory change
Date: Wed, 04 Nov 2020 17:18:41 +0100
Message-ID: <1801487.IobQ9Gjlxr@ripper>
In-Reply-To: <87v9elqeuj.fsf@codeaurora.org>
References: <20201021140555.4114715-1-sven@narfation.org> <87v9elqeuj.fsf@codeaurora.org>

On Wednesday, 4 November 2020 17:14:12 CET Kalle Valo wrote:
> Sven Eckelmann <sven@narfation.org> writes:
> 
> > The function ath11k_wmi_send_init_country_cmd is taking 3 byte from alpha2
> > of the structure wmi_init_country_params. But the function
> > ath11k_reg_notifier is only initializing 2 bytes. The third byte is
> > therefore always an uninitialized value.
> >
> > The command can happen to look like
> >
> >   0c 00 87 02 01 00 00 00 00 00 00 00 43 41 f8 00
> >
> > instead of
> >
> >   0c 00 87 02 01 00 00 00 00 00 00 00 43 41 00 00
> >
> > Fixes: d5c65159f289 ("ath11k: driver for Qualcomm IEEE 802.11ax devices")
> > Signed-off-by: Sven Eckelmann <sven@narfation.org>
> 
> On what hardware and firmware did you test this? I'll add that to the
> commit log. I know it doesn't matter here but I want to have that info
> anyway.

Tested with:

* IPQ8074 WLAN.HK.2.1.0.1-01161-QCAHKSWPL_SILICONZ-1
* IPQ8074 WLAN.HK.2.1.0.1-01228-QCAHKSWPL_SILICONZ-1
* IPQ8074 WLAN.HK.2.1.0.1-01238-QCAHKSWPL_SILICONZ-2
* IPQ8074 WLAN.HK.2.4.0.1.r1-00019-QCAHKSWPL_SILICONZ-1
* IPQ8074 WLAN.HK.2.4.0.1.r1-00026-QCAHKSWPL_SILICONZ-2

Kind regards,
	Sven
--nextPart2507857.Isy0gbHreE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAl+i1GEACgkQXYcKB8Em
e0a7CA/+K7zHT3/p8rHaW2vUM0s8GBL6EQrc/tvkpkIYFdg4qiOIHREUv9cbRnXQ
GnU4eleY0WzsvoU3QsEiy3Gp0FOmWtTlBlRB3gSxhdP7q6N3uECz+KyndLyBxQt2
4ZqiUrcF0UTCF+JD+jLSdFjayiIRp9YJ68l95R5eMgEc97muuAMFM+b5GnKKzG45
mcIA895MUcbS+1ZAETMgWFhTVyINJnCbFOTWPQlyN5L33+lQ3C4Hv2SDOHkWhODw
zUCgT9tkQTj4BN9zieGlCeT1YhWizDJz3d++G5yMFeGodBoy3ZjCAl49FRwgHM2w
dj+8im4EiW4PezRk47Fyqw/FiOm6s73m47jD5vKSSS30FuCY1tfpwTSvAocWpWW8
+qskY1yQK6/BmeBHT6VEheoAUAkd6FFz7QPdK3Zs2L6Y7YGXaCgTIfBIZkgd6/fI
95yJKyk4IN/EbojFuh8wg0u+4FXyz9bdctLiLQ488oZBLtx+M9himTL+TYzr4MlX
WVu1zGjtAbwAeErqu/TtyBqu4W1vw+bWeu2DkJSAGmII+5bfHCVAJIgrppIXoZCl
pFNodY0gcTmm3IWnNVl2Fwd6SjTRRJuaa0wEslhqaV+8F4o9yN7H/JbT3ijCOzRC
F3iGq0vMXrj2UfdiECVhPV1FGcS85+pn95G7w2yhvbQsEgKcyeg=
=JL4m
-----END PGP SIGNATURE-----

--nextPart2507857.Isy0gbHreE--



