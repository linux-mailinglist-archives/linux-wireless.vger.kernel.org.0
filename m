Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E50843F937
	for <lists+linux-wireless@lfdr.de>; Fri, 29 Oct 2021 10:47:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232592AbhJ2It3 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 29 Oct 2021 04:49:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232519AbhJ2It1 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 29 Oct 2021 04:49:27 -0400
Received: from dvalin.narfation.org (dvalin.narfation.org [IPv6:2a00:17d8:100::8b1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EF74C061570
        for <linux-wireless@vger.kernel.org>; Fri, 29 Oct 2021 01:46:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
        s=20121; t=1635497214;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=LkQ+lya4LKok+pmJ3WCbSidIqxGDKZLe1yDW8AMAMXA=;
        b=k3Dakf3IEfMpap/ubhYecWE2uL7BT9cYYV2BRIrC7pB5LlL0imaEB1PFpPZ2ADNHnFuyiz
        woJk9fUHdbbqsF+NqcIS3WqnPp+j7Mc9v+x+xG4zmo1s2WKlptqSl3dbggDxWE+CPNyq6V
        NM4wWj49OBJ4ehpBSjnrjcodgbkjArQ=
From:   Sven Eckelmann <sven@narfation.org>
To:     linux-wireless@vger.kernel.org,
        Johannes Berg <johannes@sipsolutions.net>
Cc:     Jan Fuchs <jf@simonwunderlich.de>,
        Johannes Berg <johannes.berg@intel.com>
Subject: Re: [PATCH] iw: survey: add support for radio stats
Date:   Fri, 29 Oct 2021 10:46:51 +0200
Message-ID: <2469845.WWC2xG1DlQ@ripper>
In-Reply-To: <20211029072939.15767-1-johannes@sipsolutions.net>
References: <20211029072939.15767-1-johannes@sipsolutions.net>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart4139706.dPFXHN7qpe"; micalg="pgp-sha512"; protocol="application/pgp-signature"
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

--nextPart4139706.dPFXHN7qpe
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"; protected-headers="v1"
From: Sven Eckelmann <sven@narfation.org>
To: linux-wireless@vger.kernel.org, Johannes Berg <johannes@sipsolutions.net>
Cc: Jan Fuchs <jf@simonwunderlich.de>, Johannes Berg <johannes.berg@intel.com>
Subject: Re: [PATCH] iw: survey: add support for radio stats
Date: Fri, 29 Oct 2021 10:46:51 +0200
Message-ID: <2469845.WWC2xG1DlQ@ripper>
In-Reply-To: <20211029072939.15767-1-johannes@sipsolutions.net>
References: <20211029072939.15767-1-johannes@sipsolutions.net>

On Friday, 29 October 2021 09:29:39 CEST Johannes Berg wrote:
> From: Johannes Berg <johannes.berg@intel.com>
> 
> Add a --radio argument to "survey dump" to support the global
> radio statistics.
> 
> Change-Id: I16e615434607d982e9cf690f03148738eca25cde
> Signed-off-by: Johannes Berg <johannes.berg@intel.com>
> ---


Tested-by: Sven Eckelmann <sven@narfation.org>

Thanks for checking the problem. I've tested it together with 
https://patchwork.kernel.org/project/linux-wireless/patch/20211029092539.2851b4799386.If9736d4575ee79420cbec1bd930181e1d53c7317@changeid/
on an AX200 and firmware version 59.601f3a66.0 cc-a0-59.ucode.

Kind regards,
	Sven
--nextPart4139706.dPFXHN7qpe
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAmF7tPsACgkQXYcKB8Em
e0ZuoA/+OK8vOmicbvcr+JuWAwadFFB4N1z8R2ucQjvSctdidhbW4WD2BWs0/yzY
qTuqZcEOIt6ovZXLoRi+ScxbwL/jQjmJxJvmQwFXRj4Rccycz7bDKNE4xGiIKdl/
XT6aOq67KNhu4aDzJdOUH26/Q4BpZeV+Mi1ml89JAzeqoOxNkFqwO3p8YSQkr08W
1ihikfDClnp+6Krj+4phu1/zbe66kE9D6M193lw10Yv2DnbJAU1C/1ej+JaKGrHl
CrHI+hqEPuvfNLV31kkdZDh7hfHRIQjxlQNxR5+IhMCZ/Q+mPdGVJ+Ks0bKWSfr0
NkgZmRsOvxZ2Jsh+QgrKDoYL1YSOoN40sa0rSZykHW8e9Q143Lv5PslDr5K/oaKk
zwelp/558EC8KnhFZx5cOSdBBujEe0WcM1QZJmqNCdljbncGeoJcKxtwfr1ukeZA
ndtFwlTVk3Bq4d6g+ngAsV5WR29g4uIxMDj8+x1p7eOJYf+3KK7kiuS5VWcfz+dd
FWjvOn7XtSbR/MR4JZtAVF797ryJuOFgGIGkFwbbsVd4ORU8ylFL2bnVoE0jsUt8
XkLasunC6sZ+cwPx9Zy4eOZqvDTWTlP/6me6i8LctiqlnKW90VIR/c+JhFfWq2GS
mq6XpXY70pphHkW57rpay2EFgHytHct4OCxRsty3x4jCIDGaw70=
=/vFW
-----END PGP SIGNATURE-----

--nextPart4139706.dPFXHN7qpe--



