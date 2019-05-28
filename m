Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8B15F2BFD6
	for <lists+linux-wireless@lfdr.de>; Tue, 28 May 2019 09:03:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727603AbfE1HCW (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 28 May 2019 03:02:22 -0400
Received: from narfation.org ([79.140.41.39]:46976 "EHLO v3-1039.vlinux.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726203AbfE1HCW (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 28 May 2019 03:02:22 -0400
Received: from bentobox.localnet (p200300C59712C6EA00000000000002FB.dip0.t-ipconnect.de [IPv6:2003:c5:9712:c6ea::2fb])
        by v3-1039.vlinux.de (Postfix) with ESMTPSA id C81431100D3;
        Tue, 28 May 2019 09:02:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
        s=20121; t=1559026940;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ukNVcz26LrZdBiIqJZMtQS98DaVUsP6U1/L6SzkgMK8=;
        b=rTWdQpOYPiXK7AJDN3AVFOWnR+BqpEMfGITp737rTskaJnq3lHWFufXrgl2Ejp6c4mTFb6
        yHWX0FFMKmzN3wVNBlZ6iiQV4HcTgYUts1MC5VmCuXL5VYWPvudwEO4XVYl0IhdrS4BWlq
        0Qxokm8NPt22dZrsme+glCVgLq6GBwU=
From:   Sven Eckelmann <sven@narfation.org>
To:     John Crispin <john@phrozen.org>
Cc:     Johannes Berg <johannes@sipsolutions.net>,
        linux-wireless@vger.kernel.org,
        Shashidhar Lakkavalli <slakkavalli@datto.com>
Subject: Re: [PATCH V2] iw: print HE capabilities
Date:   Tue, 28 May 2019 09:02:12 +0200
Message-ID: <2100673.vGQeuS8Cl6@bentobox>
In-Reply-To: <20190528065828.25356-1-john@phrozen.org>
References: <20190528065828.25356-1-john@phrozen.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart31819263.QlU1AoI2qx"; micalg="pgp-sha512"; protocol="application/pgp-signature"
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
        s=20121; t=1559026940;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ukNVcz26LrZdBiIqJZMtQS98DaVUsP6U1/L6SzkgMK8=;
        b=YNrnWrLLJXwzhoR0Y2VhrUd/P0qiRMIs7REisxoa3m9ax+UtkBuiC2fZo17jIxLT1r9Pg5
        AqmWfX4gWyce/u5RzuupWKNQVACAmPjOrzyS9yMdzETxDjp+75OLO9nVmRWi4D0CPQ7Xqf
        OX7lSWiXQ9yW0blo9BEikW9r2POpODI=
ARC-Seal: i=1; s=20121; d=narfation.org; t=1559026940; a=rsa-sha256;
        cv=none;
        b=Q8WudUaUeT2OmrH2B1pM5y72HeQZn/RsmfhGFnStyABF9C7rvICCPoEr6JjXr2kwq1ZmtU
        cBirmx5ULF8G0a989ia3iwGGeLTNU2kHoBNOXX8AB3M9yD/UxzXPyakJENxhRa3FoMctES
        LDJ7r4aT4EEtYGWRdPPjkGa8QR2eA7Q=
ARC-Authentication-Results: i=1;
        v3-1039.vlinux.de;
        auth=pass smtp.auth=sven smtp.mailfrom=sven@narfation.org
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

--nextPart31819263.QlU1AoI2qx
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Tuesday, 28 May 2019 08:58:28 CEST John Crispin wrote:
> Print the HE MAC/PHY capabilities and MCS/NSS sets.
> 
> Signed-off-by: Shashidhar Lakkavalli <slakkavalli@datto.com>
> Signed-off-by: John Crispin <john@phrozen.org>
> ---
> Changes in V2
> * add a missing ',' in the iftypes name list

The patch was already added with the bugfix [1].

Kind regards,
	Sven

[1] https://git.kernel.org/pub/scm/linux/kernel/git/jberg/iw.git/commit/?id=c741be9f6ca34411c4dbeb03dd13e0dd794713a5
--nextPart31819263.QlU1AoI2qx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAlzs3PUACgkQXYcKB8Em
e0YEWxAAmOG1CNXIO7LPMkGzhFg1YSuvC+PvC8v7p2tdQ2atspuzk0XyNdu3daNQ
xigLpu4EGOHP7XjmnI1HJ2S3OPkOLebTfnAN9hdau2jtkyoqBBV6nBxj3PKiVyLD
vrgFB2j7HBw0g+PNxuZV1EUPapbrw+qxoGrp0gpmHH3wJSQ85fg8HQkA1FaBJKLU
EfW1xoltWBI4sUrUA6AI2QDHs3/2HS9aET5cS5epeuHb8lFHl4Qlm3C00iEFbUbM
qgiW6qqVsM4LH1ZhpwW1dRfxWjlVbQsK59NiKsnE0Lun0SGLHO0O0fxmn3+gDyPD
vt17V38LuSx9XM+/OCYeIgeufGlvggOJxlZwJmKJGjWzEeHitZqgxIcxTpDsoI/3
COFYjXT5Xqchey0GLTlxM2/jHibLj1TObaqBUTXLhvoEbpjfFy+mQ1Um/HtAXdNq
yvrqSoqCaOEgnrpMyqTFKfvnz4XDeXHmGbPN0DaQzC5Em+V3EsUiKHgGpo6Q73xx
d4K80p9CPif09y5bfYV30xo8g7X0gk8ItXQDYMv0tqKwX25KQIjLBlnlMXA4yjoM
LhqfYeN4IhNqWNqb7OqRQGZyx5D9DMjPCH3m+rtdGJvhZ3pDHKmRlD7S5UQ+iVE/
LaFk22pA5sC1DwWzAQUau/30IrsJd3JNFo/95dDs0doKXfhe4/w=
=98tm
-----END PGP SIGNATURE-----

--nextPart31819263.QlU1AoI2qx--



