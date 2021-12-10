Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B685646FCBD
	for <lists+linux-wireless@lfdr.de>; Fri, 10 Dec 2021 09:27:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235989AbhLJIbQ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 10 Dec 2021 03:31:16 -0500
Received: from dvalin.narfation.org ([213.160.73.56]:52294 "EHLO
        dvalin.narfation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230463AbhLJIbQ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 10 Dec 2021 03:31:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
        s=20121; t=1639124860;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=zlbWEDc3rRiTbXPz/Qy33YDVWOCW5diPa1PQgurVtLQ=;
        b=bRNb88k8JA9R7QOmx2YkO9CwDQAD6WAk7GfkdDZTOcRH46qPqKwrzIF+yepOL4xF0yA7sb
        i4UejQhdIrXPF/0Jr+GNh4zptV4pCvxzxYuzXtSRmW70WhfBoVtdZHTP910NkWIV27La2Y
        Bw+hSQtC2XBe6VpnMLV8M/garQfmkuo=
From:   Sven Eckelmann <sven@narfation.org>
To:     linux-wireless@vger.kernel.org,
        Roberto Riggio <roberto.riggio@gmail.com>
Subject: Re: Frame injection on ath9k
Date:   Fri, 10 Dec 2021 09:27:34 +0100
Message-ID: <4481549.kEIK8Ajiyv@ripper>
In-Reply-To: <CAKkT90b_C+B-2RY2BDO9tiQJh_Vv8y95JuVGADhc+ML-bSqxmQ@mail.gmail.com>
References: <CAKkT90b_C+B-2RY2BDO9tiQJh_Vv8y95JuVGADhc+ML-bSqxmQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart4184506.IJ10No25iA"; micalg="pgp-sha512"; protocol="application/pgp-signature"
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

--nextPart4184506.IJ10No25iA
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"; protected-headers="v1"
From: Sven Eckelmann <sven@narfation.org>
To: linux-wireless@vger.kernel.org, Roberto Riggio <roberto.riggio@gmail.com>
Subject: Re: Frame injection on ath9k
Date: Fri, 10 Dec 2021 09:27:34 +0100
Message-ID: <4481549.kEIK8Ajiyv@ripper>
In-Reply-To: <CAKkT90b_C+B-2RY2BDO9tiQJh_Vv8y95JuVGADhc+ML-bSqxmQ@mail.gmail.com>
References: <CAKkT90b_C+B-2RY2BDO9tiQJh_Vv8y95JuVGADhc+ML-bSqxmQ@mail.gmail.com>

On Thursday, 9 December 2021 15:41:03 CET Roberto Riggio wrote:
> Could somebody be so kind to provide me with some pointers about
> where the frame injection at arbitrary rates from a radiotap header is
> implemented now?

Not in ath9k - it is in net/mac80211/tx.c. The function 
ieee80211_parse_tx_radiotap will inspect the radiotap header and set the flag 
IEEE80211_TX_CTRL_RATE_INJECT if it was able to retrieve some rates from it.

And ieee80211_tx_h_rate_ctrl will just not try to calculate new rates when 
they were already injected by the radiotap header (see 
IEEE80211_TX_CTRL_RATE_INJECT).

Kind regards,
	Sven
--nextPart4184506.IJ10No25iA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAmGzD3YACgkQXYcKB8Em
e0a3wxAAr95Pyfv8LlLQeCB8/TPTH5YZbwpEeBjpJpEZ/Odyl8d0OVA4ljroqmqw
39fgBC8NYH7yKm4f9Ak7nyvUsScOQYrjbJB+0ASLNKDped3Ll1JPv4y824th7iDV
PoHag6VIwoypm61JDIQWbFctYaPdBrzcTzqh2bHH536do/gycYPM/q0F1yQn5hMf
Yiv9lBHt8T8RwA9o7tJOIfF4UxaNABaalXdq6yftuTtOaItzv0kx8oYikCj1v+P9
MsvoGQRHJXi1cQCXI/Nsf+4PPqId04QaGeeRRrAtRiFqrI1G9+tkaLXwKb1wfRO+
/YMW2n/eRKS6XcE7QalPqJ3nkrcIEEzzwnS3FfmFMnr8aoaHP3h/f+Lyr0uMK1hX
KCdQkqpiaxCJtUlaAwwT/qexpOZbf5xDZ519+lbDemZlClJiFUZJGI+RUilZlo2X
af5MJbxRYV/9BQFcF8UJ6y3orpU7WiYEMx5zh+RvfFn5Zy9l+xzAHbB2t/CAxP0c
2JtJhmx/X3NnDaqNei69xyJLXFB13YGIfHDk94Umul5wKsTyWrAG6KP4N+R5yuGU
MJ8KKf2wczaVM6I6rRPDWBI6WrPX/Wj7aWCGjc/SBRkDrOm3sX9nCeTt8orFkief
li8Z9PwAx7ihrCm08o7w+vbslyc5iWCA7Y+qFIQICyg6ga9OwGY=
=XmgH
-----END PGP SIGNATURE-----

--nextPart4184506.IJ10No25iA--



