Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47F501C4FB2
	for <lists+linux-wireless@lfdr.de>; Tue,  5 May 2020 09:55:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728220AbgEEHzO (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 5 May 2020 03:55:14 -0400
Received: from dvalin.narfation.org ([213.160.73.56]:54294 "EHLO
        dvalin.narfation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725320AbgEEHzN (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 5 May 2020 03:55:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
        s=20121; t=1588665310;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=6eitsOTt2uKwhWLjUuCnARFT8tInxkqJma7dnpaVIGc=;
        b=BuZPKOClqfBmnOGY/DG0zi1WB3VCNcOJQFiVA7DA23qYylHvAdlQrMZ4muCtbk7bbjAQ2m
        8yAzEVf1MJRrYP2j5dL+VqQdnNUqiMoZ7cR7TcUa3Io7qKrKQGwQGEvhBGdVbx+Mrba0H7
        kCNhxQ6hKTnPwWwsti0nECmjJm4BrrY=
From:   Sven Eckelmann <sven@narfation.org>
To:     ath11k@lists.infradead.org
Cc:     Rajkumar Manoharan <rmanohar@codeaurora.org>,
        linux-wireless-owner@vger.kernel.org,
        linux-wireless@vger.kernel.org,
        Markus Theil <markus.theil@tu-ilmenau.de>,
        ath10k@lists.infradead.org, kvalo@codeaurora.org
Subject: Re: [PATCH 1/2] ath10k: use cumulative survey statistics
Date:   Tue, 05 May 2020 09:55:08 +0200
Message-ID: <5194473.9tBAi8KRnL@bentobox>
In-Reply-To: <1845755.pTfhzBy2qg@bentobox>
References: <20200504154122.91862-1-markus.theil@tu-ilmenau.de> <2335594.cnkAv9Vaq7@bentobox> <1845755.pTfhzBy2qg@bentobox>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1919120.v24dTSXcW5"; micalg="pgp-sha512"; protocol="application/pgp-signature"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

--nextPart1919120.v24dTSXcW5
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Tuesday, 5 May 2020 09:49:46 CEST Sven Eckelmann wrote:
[...]
> See also https://patchwork.kernel.org/patch/9701459/

And I completely forgot about this one: https://patchwork.kernel.org/patch/10417673/

Kind regards,
	Sven
--nextPart1919120.v24dTSXcW5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAl6xG9wACgkQXYcKB8Em
e0YkJhAAxZ5ZkAftBeyPFhdZ1oSQ3Rtt2EfbS9lOfQLqGW33memF3NQ56Rf/Seap
Oqz9MiJ2ix+6iI6GoOEU8th59vL7Ve5yjNxp46G4OYzYjjtaQ6bd3ZaNYq6E9Cx/
VAEeKFTkmNyuglwj+xradnU31JN4bMbsDm0p57c3A1YTExhtbPud+e2SDXxrjww0
FBWPN625g7lgSMWLpVoaTRnFaXRVJ5Fq5m00BpFEDcTZieiTmfwYpDswveU2Ei3c
UXUfbQ88zoCh0OW3gvHT0aTjk76Atgnk/KFWVVeyZuV0whp94CatyuZem0BEMGII
DqVJEm9TEHVuxzZN4e+MK8exIF209HLa4ReX6KHdUBgYPAwo+Nm0ZWMd/BWrvJi6
BF5k6pEXwevLLkPFcdOPG13fWF2ExMxlEztOY3yo9pyk7CtZmZECMh/0KYrNZe1z
YqxGrnu5Qd9mzRI5q/5PtXf4Ni9z9aEwkVJaQSzO/fId64ysxYrnmGNvc+hbFnLr
iI/x5mp7CpJVa5F1qg1X+9hwouQi7g756A9pnY2O7fVvJzYG0GmsH2KUt6k7SJSH
vb7aRjxpfk4DKm6P6o/u2bgIUU6J8m8IyJI5evkKbX4YbhZsoea7egLQmG0rYUMR
kMNymnkhCDraj46HlOHCWRvbZL+v6hehB1jBIDvjIGLcSEfUZ84=
=93bm
-----END PGP SIGNATURE-----

--nextPart1919120.v24dTSXcW5--



