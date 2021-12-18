Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DAD644799C1
	for <lists+linux-wireless@lfdr.de>; Sat, 18 Dec 2021 09:43:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231286AbhLRIna (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 18 Dec 2021 03:43:30 -0500
Received: from dvalin.narfation.org ([213.160.73.56]:52356 "EHLO
        dvalin.narfation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230018AbhLRIna (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 18 Dec 2021 03:43:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
        s=20121; t=1639817009;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=KnjbssXCNVGeaKnilFi+t7KdY+BtRy52CmoJpR1wwK0=;
        b=w0ySm+cV3XTMNTyAUZXcsb/6keAnVPLwOUTw1vGY9c3jvCEXhlUfTlADca0kEnHQ5w/Bv0
        mrj4en6bhRKzEIRLCUrFEP90K1IKDUTGsfJ0R2uAOn4p5E2XpYHwy50GGL8du02sVzRZ3i
        uAOPlfMnOqCJkb1u6MWPdxS0qajso5I=
From:   Sven Eckelmann <sven@narfation.org>
To:     Kalle Valo <kvalo@kernel.org>, ath11k@lists.infradead.org
Cc:     ath11k@lists.infradead.org, linux-wireless@vger.kernel.org,
        quic_cjhuang@quicinc.com, Carl Huang <cjhuang@codeaurora.org>
Subject: Re: [PATCH 6/6] ath11k: support GTK rekey offload
Date:   Sat, 18 Dec 2021 09:43:26 +0100
Message-ID: <2990117.pcrbhTqeWH@sven-l14>
In-Reply-To: <2102838.219ycuhFCz@sven-l14>
References: <20211011193750.4891-1-cjhuang@codeaurora.org> <4f28496abae7743ab2a9fa7150c5d64c@codeaurora.org> <2102838.219ycuhFCz@sven-l14>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart3507083.0544kFUCgU"; micalg="pgp-sha512"; protocol="application/pgp-signature"
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

--nextPart3507083.0544kFUCgU
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"; protected-headers="v1"
From: Sven Eckelmann <sven@narfation.org>
To: Kalle Valo <kvalo@kernel.org>, ath11k@lists.infradead.org
Cc: ath11k@lists.infradead.org, linux-wireless@vger.kernel.org, quic_cjhuang@quicinc.com, Carl Huang <cjhuang@codeaurora.org>
Subject: Re: [PATCH 6/6] ath11k: support GTK rekey offload
Date: Sat, 18 Dec 2021 09:43:26 +0100
Message-ID: <2990117.pcrbhTqeWH@sven-l14>
In-Reply-To: <2102838.219ycuhFCz@sven-l14>
References: <20211011193750.4891-1-cjhuang@codeaurora.org> <4f28496abae7743ab2a9fa7150c5d64c@codeaurora.org> <2102838.219ycuhFCz@sven-l14>

On Saturday, 18 December 2021 09:37:02 CET Sven Eckelmann wrote:
> Why isn't the firmware taking care of the conversion at that place?

Forget this part - this was non-sense.

But the rest of the questions still stand.

Kind regards,
	Sven
--nextPart3507083.0544kFUCgU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAmG9ny4ACgkQXYcKB8Em
e0YppBAAlZ5ITaDdvMw8teBFRwszkRrK/XXbdCSu4ebSDsoGfA0cslv/WJOfZV57
q5EJ0kxEp3K9Mg8JWnnMIkwF6qxhiuynpxC6Hxc66YpwZArg70q7atNbhN+qtZK5
LSm8wCFz6fR52IRg+TwUQPREuMXvCVKO8Cs7On/U52dXv1YjiQNwi+B8BQz6M0Yp
LGDd/+NMgVp65rFCDhlaYGWt/BBPa0voKwj3kPA1y6AfAm/3xUhBJDrbVq7a2NKw
p5RM0qxVkTyTZdnh/HGM65lC5R32qTsIo4Tuaz/gcY1OK4N+n+N30L51PepVghp2
KxNntLOSkcDC5i9K4J14wZt0JBgm1sZqDSNjKgZUM3nT1Nn/FerLV5bwFthDe1xR
RZUCGaBpFfC9XaX1XGIyoeKAQicQ4oVJdUpv4Hnwz0PW7yAAsm9T9pgOwxZsVV7p
jew0se/XzTKOnvD51V4VaZABkh5MW79db4LcFVjpBVdYA44GgHk3bSdpyC2WAvWg
1o9GUYx/b8mig9HD4vpYZ7NNpxY84mZ6ZhDGzfauE998CkELxyBFT6F+hGfmTiPO
rpSFltUMlX5457GMmgMq1xopj3OztxFDiSGfJjRsiP8z48YAWWAM25Pq5BIRX1bv
8n9y2P7cViP7dBw3T5hAWQLVDnxHXpnIqcBiB7xwa3W73cOIB4w=
=uSUM
-----END PGP SIGNATURE-----

--nextPart3507083.0544kFUCgU--



