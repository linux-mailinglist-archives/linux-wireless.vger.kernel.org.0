Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDB704732A7
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Dec 2021 18:05:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236262AbhLMRFk (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 13 Dec 2021 12:05:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234830AbhLMRFk (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 13 Dec 2021 12:05:40 -0500
Received: from dvalin.narfation.org (dvalin.narfation.org [IPv6:2a00:17d8:100::8b1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 345F9C061574
        for <linux-wireless@vger.kernel.org>; Mon, 13 Dec 2021 09:05:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
        s=20121; t=1639415136;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=nDKxlB5BOu0OM+kg7ZXz9kbosrhavMhXm+UgQw4CfLA=;
        b=DA5/Va5/92mh7bR1/gpmeJb0V6NL5LHE2OFUZ8uqVelPwL5nZzagcvYE0o0hFY0OiFb+9d
        CTzPWTJKhoAZFtlb2cM6GMJDjIngITVsmOqkUIh2pIjOVn7lDbI1+D25L3bE4D6IOA1+u5
        Ji9fABfvjav+uP0dLGjXmscWOkJP86U=
From:   Sven Eckelmann <sven@narfation.org>
To:     Roberto Riggio <roberto.riggio@gmail.com>
Cc:     linux-wireless@vger.kernel.org, greearb@candelatech.com,
        sw@simonwunderlich.de
Subject: Re: Frame injection on ath9k
Date:   Mon, 13 Dec 2021 18:05:29 +0100
Message-ID: <3275297.oaIAGnzijj@sven-l14>
In-Reply-To: <CAKkT90ZoMA-FYtMqqu9hm8W--g1Wj1RpkkxzT=OO4zE7VaVP=Q@mail.gmail.com>
References: <CAKkT90b_C+B-2RY2BDO9tiQJh_Vv8y95JuVGADhc+ML-bSqxmQ@mail.gmail.com> <4481549.kEIK8Ajiyv@ripper> <CAKkT90ZoMA-FYtMqqu9hm8W--g1Wj1RpkkxzT=OO4zE7VaVP=Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1794722.sOkoy3y8mK"; micalg="pgp-sha512"; protocol="application/pgp-signature"
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

--nextPart1794722.sOkoy3y8mK
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"; protected-headers="v1"
From: Sven Eckelmann <sven@narfation.org>
To: Roberto Riggio <roberto.riggio@gmail.com>
Cc: linux-wireless@vger.kernel.org, greearb@candelatech.com, sw@simonwunderlich.de
Subject: Re: Frame injection on ath9k
Date: Mon, 13 Dec 2021 18:05:29 +0100
Message-ID: <3275297.oaIAGnzijj@sven-l14>
In-Reply-To: <CAKkT90ZoMA-FYtMqqu9hm8W--g1Wj1RpkkxzT=OO4zE7VaVP=Q@mail.gmail.com>
References: <CAKkT90b_C+B-2RY2BDO9tiQJh_Vv8y95JuVGADhc+ML-bSqxmQ@mail.gmail.com> <4481549.kEIK8Ajiyv@ripper> <CAKkT90ZoMA-FYtMqqu9hm8W--g1Wj1RpkkxzT=OO4zE7VaVP=Q@mail.gmail.com>

On Monday, 13 December 2021 17:49:38 CET Roberto Riggio wrote:
> Thanks Sven for the follow-up. Do you know if besides on the ath9k
> driver the frame injection is supported also on the ath10k driver?

Yes, but not with rate selection.

There is support for this in ath10k-ct but I am not sure if this only 
supported for specific ath10k-ct firmware variant - or if you just need to 
have recent ath10k-ct firmware. The relevant feature is called 
ATH10K_FW_FEATURE_HAS_TX_RC_CT and the relevant code is in ath10k-ct since 
2018.

Kind regards,
	Sven
--nextPart1794722.sOkoy3y8mK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAmG3fVkACgkQXYcKB8Em
e0ZsHBAAnO73sqO8HgulLwf5Pc0We46yCg0ArV93p8EeSO5nEvEH+7OPkpPqP6+U
UEeCv6X3dO4WkIAaupKqJ2b/71vu5LNAADdg47nWGBZcF5KDZB1mRpvPi1jQQqx1
76b6HzBPNGFavqaawQRFJJRjuXjhjY51KbxOqsa/TPdJ90axvgGF02utoY8OxFSr
aRGiyFeowlJm9cCM1HfQNoGmUOeMvoO8tmzI8mjt4qhoZvhB5NldJSjoljl+mf+r
nWZyOTgZQJKQ+5S/rhaUh3nmNDwPp77UsI6zafcfbSUuCrM2yV/WgR0UaN/3hDMy
jsz5tIAqxzLUP0UOmBNDT5le2MJ2QW+pemdY29Naubyx74xgHiU4s+0SLRQNfzXs
tlecqkLsvmBkvqZaMQNle6UZJlruK1NAxkGx6+7tphpoRxpkQyPMUuuINmha4Nbz
vaNAf+2K/WxSIiEu+1y0mUtdKctY74adsSvslLx0xkqPxKCixTeWnlHtpby17jbD
Vf1WqU9UfLDeZEwzH9B9sQyyxaFR8dI5eyzttGJhkAREowFldm9sTqFzDSrt1Q9Y
oGC79UZoxy1phZ/jTUFE5z9QE4/m42ZO0cmkCPdqDlOPwitleIWhRFl2E/zMSUfP
Q4IvcDw/M0W6jH8bNX2p0iO0BwbcM8dQx0cZMyk6ujkXmHGk2UI=
=tlul
-----END PGP SIGNATURE-----

--nextPart1794722.sOkoy3y8mK--



