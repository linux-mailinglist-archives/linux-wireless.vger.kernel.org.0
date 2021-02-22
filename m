Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F01DD321438
	for <lists+linux-wireless@lfdr.de>; Mon, 22 Feb 2021 11:34:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230042AbhBVKdh (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 22 Feb 2021 05:33:37 -0500
Received: from dvalin.narfation.org ([213.160.73.56]:37176 "EHLO
        dvalin.narfation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230083AbhBVKde (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 22 Feb 2021 05:33:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
        s=20121; t=1613989966;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=RglH45pRougffSqyZRP1V3JRlYZ4dB4gDEVVU9O4+iM=;
        b=0gCgaWoWJjTc3wXul9RJ8DSUdlMySwMY/RV5q2L3llnZ93QCJIARTCbHqjKf6yKImwVQjv
        jg5I8LOVFkJ8a75H0jgr9kB628sh+ADeImcaRS9rkeMD9M0rEKT/srzuGyeP99uQ6Ow0XL
        UIppfF030HFQ+HlsQj0MHxLCROdGGik=
From:   Sven Eckelmann <sven@narfation.org>
To:     ath11k@lists.infradead.org, linux-wireless@vger.kernel.org,
        Maharaja Kennadyrajan <mkenna@codeaurora.org>
Cc:     Maharaja Kennadyrajan <mkenna@codeaurora.org>
Subject: Re: [PATCH 1/3] nl80211: Add support for beacon tx mode
Date:   Mon, 22 Feb 2021 11:32:43 +0100
Message-ID: <2718995.X0rUDs3ZmB@ripper>
In-Reply-To: <1613988573-10839-2-git-send-email-mkenna@codeaurora.org>
References: <1613988573-10839-1-git-send-email-mkenna@codeaurora.org> <1613988573-10839-2-git-send-email-mkenna@codeaurora.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart3417114.ojRXWDtZ2E"; micalg="pgp-sha512"; protocol="application/pgp-signature"
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

--nextPart3417114.ojRXWDtZ2E
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"; protected-headers="v1"
From: Sven Eckelmann <sven@narfation.org>
To: ath11k@lists.infradead.org, linux-wireless@vger.kernel.org, Maharaja Kennadyrajan <mkenna@codeaurora.org>
Cc: Maharaja Kennadyrajan <mkenna@codeaurora.org>
Subject: Re: [PATCH 1/3] nl80211: Add support for beacon tx mode
Date: Mon, 22 Feb 2021 11:32:43 +0100
Message-ID: <2718995.X0rUDs3ZmB@ripper>
In-Reply-To: <1613988573-10839-2-git-send-email-mkenna@codeaurora.org>
References: <1613988573-10839-1-git-send-email-mkenna@codeaurora.org> <1613988573-10839-2-git-send-email-mkenna@codeaurora.org>

On Monday, 22 February 2021 11:09:31 CET Maharaja Kennadyrajan wrote:
> User can configure the beacon tx mode while bring-up the AP
> or MESH. Hence, added the support in the nl80211/cfg80211
> layer to honour the beacon tx mode configuration and pass
> this value to the driver.

There is not a definition what this actually means. But I am guessing that you 
are mean the way the HW sends our the beacons for a multivif (beaconing) 
setup. And in this case, it is a per "phy" setting and not a per AP/meshpoint 
setting, right?

Kind regards,
	Sven
--nextPart3417114.ojRXWDtZ2E
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAmAziEsACgkQXYcKB8Em
e0ZQTxAAtiTmU3DFj/tOFyPxV9hZjvEjOkxWpqeVy6RHr0kwYcaoFUbTGOjkbqhQ
1dSmGXPze3L0cN7+hC9ZMhY8t7PZlJJ45roFFfnyq4FEmNIkDkb3ZYH9H+d4oq1H
D0AjvMSSx9yh+t9abzYQ+DcoEcmTa1oT6++XS9sDTzGP3hhA9/4pPxx49KF+XNUN
7L97eNbzIYI/A4aVkglI9hildlP0HtxNvufItM4uN1B0ap2bmfrT1N0RLaggcgpK
o9Z9nuGH0LZEpjs1J+qUgp15UhcQwfasFQ/vrow5lluIx0zUqy+6EUc0MXgNimN1
mzjg0jfCt8sbBfb6lGaWWJZzsGY11eVs3r65L36prSy1INLLlfP/NGwWDotP0uAK
xpWUWjA7rr831iufT3qwrJrLrumpAFM57EXhu/cPBOnfI1a7Nmvsiqo8157PnOrx
L1/VtL5b2gAcEOPGab3W/YCCOmg6GRyrZIa8L6PiSDFKNLNKnECmBmDeD2Gq7RI3
dSzX9Su9IrYCsAdO9RuFmRtNCWzusMQxo0jXnwpsDU0drQ8yk0iJlQ/K6r5m3nXP
c29xVsZvLFsUK1FqlAcddM/M+mZVDVpoxC6MjvlR3nABDfUIFo068NbXRGCrUq4p
njLGrX40P3HaUnmlcRSDtTxkyIfw8ZwJCnhB9sjS33UBsU5yI2Q=
=eyjT
-----END PGP SIGNATURE-----

--nextPart3417114.ojRXWDtZ2E--



