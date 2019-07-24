Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 828307340A
	for <lists+linux-wireless@lfdr.de>; Wed, 24 Jul 2019 18:38:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387422AbfGXQiR (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 24 Jul 2019 12:38:17 -0400
Received: from dvalin.narfation.org ([213.160.73.56]:39246 "EHLO
        dvalin.narfation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387410AbfGXQiR (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 24 Jul 2019 12:38:17 -0400
Received: from bentobox.localnet (p200300C5970DABFC00000000000002FB.dip0.t-ipconnect.de [IPv6:2003:c5:970d:abfc::2fb])
        by dvalin.narfation.org (Postfix) with ESMTPSA id A1EEF1FFA1;
        Wed, 24 Jul 2019 16:38:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
        s=20121; t=1563986295;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=nrtR3zf6XlJdiY2loA3XjkqTCuwJwhG6HlltiTrKh+I=;
        b=otncQYfVsE60TA/jFMGsA/ihBBxrOgLhncP4YKm6ZSfKymUrtolNuwu7JEcr2MrG0tObfr
        1H1RnxkpN3ThU49vZ6Sd5HntMoa1nBHUCJLVrh4/MVARosIA9hbreDoMsFmoSXXdZ3wH2M
        Tbc1Q8TPccoWZ1Z6fjDnialBdKYisf4=
From:   Sven Eckelmann <sven@narfation.org>
To:     ath11k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org
Subject: Re: [PATCH v5 0/4] mac80211/ath11k: HE mesh support
Date:   Wed, 24 Jul 2019 18:38:13 +0200
Message-ID: <4232659.0svU1X7Big@bentobox>
In-Reply-To: <20190724163359.3507-1-sven@narfation.org>
References: <20190724163359.3507-1-sven@narfation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2088208.6srCk4DusC"; micalg="pgp-sha512"; protocol="application/pgp-signature"
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
        s=20121; t=1563986295;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=nrtR3zf6XlJdiY2loA3XjkqTCuwJwhG6HlltiTrKh+I=;
        b=RZMBKB62/iyACpN0kje7d1Ape9XmNHeVz+QXIdsAzdnKHV1se7ml2lPpKyRCVxrlMDMJIa
        uE7bmVX0BYSXt7QycUEkKHO3U8ELIw18b+9O08qqV8r5T3d8TRtbIbMw9xaO4RDVzCK+Y1
        qN18MyIbREzTKYlT/x8sknFG/ZpVFHk=
ARC-Seal: i=1; s=20121; d=narfation.org; t=1563986295; a=rsa-sha256;
        cv=none;
        b=DWxMLrwqjD+e3BpHmvE+2xuWs9tj7EbwdM7bF6lmyMw+MDiZG2ml7YEv0fuAiyo05OD4aw
        4TOc6VcyFZcgyJU0hdMgg0g5/cNGHlX0JaifPU35lNTZ2+Rrb4zBumm7a+hVfK/ie5zkJh
        2HkQbYSn2rEU8vKr/obGzuZtXoOaGTE=
ARC-Authentication-Results: i=1;
        dvalin.narfation.org;
        auth=pass smtp.auth=sven smtp.mailfrom=sven@narfation.org
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

--nextPart2088208.6srCk4DusC
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Wednesday, 24 July 2019 18:33:55 CEST Sven Eckelmann wrote:
> Hi,
> 
> Some features of 802.11ax without central organizing (AP) STA can also be
> used in mesh mode. The main goal is to get HE mesh working with ath11k.
> For persons without ath11k compatible hw, hwsim can be used in the as basis
> for further development of these features.
> 
> * v5

Sorry forgot to change the version to v5 for the first two patches. They have 
to generated from two different trees (one with the ath11k sources and one 
with the mac80211 stuff). And this is the reason why the ath11k ones have the 
correct version number included.

Kind regards,
	Sven

--nextPart2088208.6srCk4DusC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAl04iXUACgkQXYcKB8Em
e0YnsRAAlUdOZollmJx5aXK8//P6My4H4wWCd4J6vTt5656HEFXblwZY+Y6MaNaV
ZuJqksxO6VHrAjopVbMO9MOO8dRVm72XU9s/1slu1Z+nVvau5cKNTW1r21OV+2r2
aj5q9ESj8QoZKYskGJujKeJM5iFnqoDhq7OUV69mmGwHBGDuK0VAh+4Dopk/Q3dx
L++yw/UeFZrQLImbPy+dV5SEOaN+u0GrsSjPwCN159/JUWRXjZxrssLIABmWZGgL
O3y0BjgXikrT/hLf1bk6H/8S5nweEi4hEjOxbkyqiJSkWa8BF9ygI/ryXw5rTsVu
kU6T6V4mU6L9FxZfbWoKEYji3RvjwBn/t+vFWsBkIUcvXfCa8fkzd9z8fX+Uimrr
MgkCj8DFhRggPV8KMJQuNaUkjSMO2KbDX3hSPrr82KnLX0tG3JyWVXanYfM3HGKJ
KOEI3TWUqxbtpRy8JNNACJ++TYof6+vk5taRIeRWGrAutyGEyzBcbQO2+qri7xEL
0wj/cPWdQNcBVtRhtIx/OQG0M+q0CwuX8X+KU4SZma/SbY3a4EmMHOU+Wv9QTP1M
0MpfY+KCB/dOVfjojxP3p+qGGnMq7xxkCtJh/lUEFD2zd58qj9NIjufOzMHxGsPR
zDHORNi8FRqWFbm3rDqLO47dpo/EwDOHRuFxJJ4INu23/YMlKtQ=
=fHBH
-----END PGP SIGNATURE-----

--nextPart2088208.6srCk4DusC--



