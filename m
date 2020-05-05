Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A3651C4F8E
	for <lists+linux-wireless@lfdr.de>; Tue,  5 May 2020 09:49:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727938AbgEEHtx (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 5 May 2020 03:49:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726568AbgEEHtw (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 5 May 2020 03:49:52 -0400
X-Greylist: delayed 55215 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 05 May 2020 00:49:52 PDT
Received: from dvalin.narfation.org (dvalin.narfation.org [IPv6:2a00:17d8:100::8b1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E571C061A0F
        for <linux-wireless@vger.kernel.org>; Tue,  5 May 2020 00:49:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
        s=20121; t=1588664989;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1IWrsJBZhdCsDyfYSJJhd0QFKh2SYgRZbADR1astMwI=;
        b=dKzclyKzpjnaFtGo6rLlMP9ke/9p0TWzxDP+nC0/7MxO3EW9HfHwdCArWZMGCfVDfnbwnk
        lmm/+xonJ2rCn7mOPylZVwaLgPWtqhisnhioGRESPuVwvXfJKakr/8n/4ZYPfT/3LkfWVT
        sCMjAKUGeE6wC3X2YbqE3eA9VuXuBIk=
From:   Sven Eckelmann <sven@narfation.org>
To:     ath11k@lists.infradead.org
Cc:     Rajkumar Manoharan <rmanohar@codeaurora.org>,
        linux-wireless-owner@vger.kernel.org,
        linux-wireless@vger.kernel.org,
        Markus Theil <markus.theil@tu-ilmenau.de>,
        ath10k@lists.infradead.org, kvalo@codeaurora.org
Subject: Re: [PATCH 1/2] ath10k: use cumulative survey statistics
Date:   Tue, 05 May 2020 09:49:46 +0200
Message-ID: <1845755.pTfhzBy2qg@bentobox>
In-Reply-To: <2335594.cnkAv9Vaq7@bentobox>
References: <20200504154122.91862-1-markus.theil@tu-ilmenau.de> <f772b7bf0eac31516a4e28719c1938f2@codeaurora.org> <2335594.cnkAv9Vaq7@bentobox>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart4024693.4Mujkspm9b"; micalg="pgp-sha512"; protocol="application/pgp-signature"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

--nextPart4024693.4Mujkspm9b
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Tuesday, 5 May 2020 09:01:34 CEST Sven Eckelmann wrote:
> On Tuesday, 5 May 2020 01:46:12 CEST Rajkumar Manoharan wrote:
> [...]
> > IIRC this was fixed a while ago by below patch. Somehow it never landed 
> > in ath.git.
> > Simple one line change is enough.
> > 
> > https://patchwork.kernel.org/patch/10550707/
> 
> Because it doesn't work for everything. Remember that 10.2.4.x overflows all 
> the time (14-30s) because it used only 31 bit for the counters.
> 
> But feel free to point me to the firmware version which fixed this.

See also https://patchwork.kernel.org/patch/9701459/

Kind regards,
	Sven
--nextPart4024693.4Mujkspm9b
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAl6xGpoACgkQXYcKB8Em
e0ZzCRAAgqYCt2mvPP4dcDSuLObeeqnrlCg1zGaJJZTOYiTbGbBOFPKRKKWoX/PG
manCnusFGFRHSpoGC94W89wlOJ6EW9x2RMy7ylws0z15iOzziE6faiE9XNuczjQw
+NVHZthe6xgWq5iORv2+zGtVqPPjvzoVcObZyyTdWtYmnVEb/Vo5W0g713/ha42K
IHfFLbcwdW3OjVFEd88hEt6sOaMeM86ZmZql6cox23CNzYfG76BcNUvgta7l2Tr1
MvpLrattlWdTP+6uWabdIdJp2IDKFj9DeEQrvUUuIlQJO1lbiZSBK+/jMqv0buNS
dImQBdrJZElVL7LW0hqgYHesekgpigVOt4gWd/mZfJlH6dtzW8hp/btxonCzecfd
DUJchzFPJv4LfAswoWEr/Uw3MYwi7W0pdcbKCJQbzchHgMfO2mtWX6BvfdU5Pvl3
V5tmKzNbpJIZTFUKh0mFqsceBRXU/fYWU9S3IuAuFmPzTnew4YeBKQj/xhHmduhx
dXF6IQU69fM2hKUQWZV9NCxmCzHXhytChza4JeQpGhXKM8bQ4sH7yuMWrSlKJ7VU
D14XlUppGsOW8uKK6VNl76DfFpWqs76bZs95npCX0u188PwTTTAGpbqaizZjXZ5q
OWF98ErpHvU88aaLjKsYNmUOj6pXyRCfADeukZnuXHKUWSyf3jw=
=8mIN
-----END PGP SIGNATURE-----

--nextPart4024693.4Mujkspm9b--



