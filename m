Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B888A1C4EB5
	for <lists+linux-wireless@lfdr.de>; Tue,  5 May 2020 09:01:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726065AbgEEHBm (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 5 May 2020 03:01:42 -0400
Received: from dvalin.narfation.org ([213.160.73.56]:52940 "EHLO
        dvalin.narfation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725320AbgEEHBm (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 5 May 2020 03:01:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
        s=20121; t=1588662099;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=flt+0nv/wY6EtEjl/gozth8PAjTpWfBxfoBL5ar5q9U=;
        b=V72ELWoX7v6oOmg11Q+GW046l9XV3fOKF/Kc0iysoJ5BSdRQzs1zpqwFfbocOoMIEdVthB
        s0DO4LzEplLZRtfnwL3PCyObY/JYfeCZN67NReUgGdHghALOFYvQGBa2m7KVJE5SQ2J7rK
        6E+WDW99b0X8rflgSPj8VfvtCuCR7Sk=
From:   Sven Eckelmann <sven@narfation.org>
To:     ath11k@lists.infradead.org
Cc:     Rajkumar Manoharan <rmanohar@codeaurora.org>,
        Markus Theil <markus.theil@tu-ilmenau.de>,
        linux-wireless-owner@vger.kernel.org,
        linux-wireless@vger.kernel.org, ath10k@lists.infradead.org,
        kvalo@codeaurora.org
Subject: Re: [PATCH 1/2] ath10k: use cumulative survey statistics
Date:   Tue, 05 May 2020 09:01:34 +0200
Message-ID: <2335594.cnkAv9Vaq7@bentobox>
In-Reply-To: <f772b7bf0eac31516a4e28719c1938f2@codeaurora.org>
References: <20200504154122.91862-1-markus.theil@tu-ilmenau.de> <f772b7bf0eac31516a4e28719c1938f2@codeaurora.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2406179.bnRGkfsQJl"; micalg="pgp-sha512"; protocol="application/pgp-signature"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

--nextPart2406179.bnRGkfsQJl
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Tuesday, 5 May 2020 01:46:12 CEST Rajkumar Manoharan wrote:
[...]
> IIRC this was fixed a while ago by below patch. Somehow it never landed 
> in ath.git.
> Simple one line change is enough.
> 
> https://patchwork.kernel.org/patch/10550707/

Because it doesn't work for everything. Remember that 10.2.4.x overflows all 
the time (14-30s) because it used only 31 bit for the counters.

But feel free to point me to the firmware version which fixed this.

Kind regards,
	Sven
--nextPart2406179.bnRGkfsQJl
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAl6xD04ACgkQXYcKB8Em
e0YEVw//TH/fq0NNa8BsCXeGXzxlVMEexjFoX4Kd4gu+kbKZaN6e6kHdfp4jVfFL
nWvkEuCkVytqr+7pBRVvPHOdKoLTJXwkbIdfbtz2GR+qpVDqxC90qn+pPJr33V4D
Tinws56w4EhXK3YLaptPZRYGmRUjXIsMd6+KCdUyNupG1ztIlwrSUfTYdk6imWkS
XXUin/LTR5YsVGkBKoj3NNyBcjAvr//g+PLTiWR/PBmIDBYzl1QhvBrxMURuN8wx
sUeco+4LlP1nunB6OE2JwikoOK0AAFc8SyjHgZeBXm45cDmbnMeYhcLYYnakl+gs
BifsmGgeeNPl2smGYgkUC0VtisX3p4/mFU0B87Fp9RD4ouO2bFTCldbmDROTX/gY
m55yIZIWhH908xPVjf4SLQpaC3IBSTHmfEZ1ie/5guO8E0q19pZCoDLRiYdYpUtv
USM/9+8M68yXrvgdg/Xxi/gcOHDeKeZIXb3gxYK1+xoIfahGdM/t/IFE9qIN5O+n
hCYEBnbA26niZop3JDQxDHesjGA8uuPkBT+xtaUqWzDgBANG4DWn94uyZGffTapk
dCYwFM0jdzTdQQuPYDphwMisi+P42x9jgk0QkmCgAh6CfWxdTe9D44UgCs/8+lZd
wTzFvz5lcyJv8BsOjpzHA/6mI9CiJ7178pwOYU9SR43zF4pr8kw=
=nZKo
-----END PGP SIGNATURE-----

--nextPart2406179.bnRGkfsQJl--



