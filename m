Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6D3739E612
	for <lists+linux-wireless@lfdr.de>; Tue, 27 Aug 2019 12:49:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726574AbfH0Kt4 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 27 Aug 2019 06:49:56 -0400
Received: from dvalin.narfation.org ([213.160.73.56]:58304 "EHLO
        dvalin.narfation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726071AbfH0Kt4 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 27 Aug 2019 06:49:56 -0400
Received: from bentobox.localnet (p200300C5970B0CE86C4047C4D7108D73.dip0.t-ipconnect.de [IPv6:2003:c5:970b:ce8:6c40:47c4:d710:8d73])
        by dvalin.narfation.org (Postfix) with ESMTPSA id 2528D1FFBA;
        Tue, 27 Aug 2019 10:49:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
        s=20121; t=1566902994;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=UuWlMu5kWvW/4a97MuESS4MI5GJljsjFlOJKAFn9wJA=;
        b=cGyOau77+o18UPUbfiCIAakczz/76jKOATEoEie3wwNGu7qJPSM/umI+N/OE4qw++K6ZUc
        3r2TN66LVj7wT6BAiglc+iejXjQ0I2E6kf6s0RS74AvrVbHZ0jMNF23Ebd/hnPPE1Wc/D0
        iaLQHST1vPQGuKp1BHJBECJxXspZuMA=
From:   Sven Eckelmann <sven@narfation.org>
To:     Anilkumar Kolli <akolli@codeaurora.org>
Cc:     ath11k@lists.infradead.org, devicetree@vger.kernel.org,
        linux-wireless@vger.kernel.org, Kalle Valo <kvalo@codeaurora.org>
Subject: Re: [PATCH 10/49] ath11k: add debug.c
Date:   Tue, 27 Aug 2019 12:49:48 +0200
Message-ID: <1739552.6LiyvA3Ra0@bentobox>
In-Reply-To: <f93b9c98fcfb9a910c3efc04d11d5aa0@codeaurora.org>
References: <1566316095-27507-1-git-send-email-kvalo@codeaurora.org> <18655975.RomJW5s5WE@bentobox> <f93b9c98fcfb9a910c3efc04d11d5aa0@codeaurora.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart41236698.1DgVcCGkzx"; micalg="pgp-sha512"; protocol="application/pgp-signature"
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
        s=20121; t=1566902994;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=UuWlMu5kWvW/4a97MuESS4MI5GJljsjFlOJKAFn9wJA=;
        b=Qq1GUcL9MxpGTbh6O6eT7yUxU9vHJlJZIPWUNZASVpFBFwmwpgw/pRAkPz6WmQMlArB9L2
        Ty14cyTrCxxTK/r1Tj0wlDMcR16DYVu1dxs66lBKHhErAVuU8Eyn+2EKl1T74uICDfNi7i
        O80wwDJ3CCEn2LRcXcBeWF51l0T1FvE=
ARC-Seal: i=1; s=20121; d=narfation.org; t=1566902994; a=rsa-sha256;
        cv=none;
        b=J3ZbAxtq5vzqrxaQYNleE9nxLOOIlGH/a05jZF7jXlTSTI9aYtnwRI16WnEixh8zZklKQH
        6Pm1LySnTHKK4iuvsMsWiQM5TpY0B4FzEwYe5LSzJ0Y+cmC9TWd5FL4Op9Kh6UWisPOAeV
        cqRFocHjS2vM3xZGtduD0evaCw0IlKU=
ARC-Authentication-Results: i=1;
        dvalin.narfation.org;
        auth=pass smtp.auth=sven smtp.mailfrom=sven@narfation.org
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

--nextPart41236698.1DgVcCGkzx
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Tuesday, 27 August 2019 12:04:27 CEST Anilkumar Kolli wrote:
> Could you plz try removing below patch?
> https://source.codeaurora.org/quic/qsdk/oss/system/feeds/wlan-open/tree/mac80211/patches/072-ath11k-print-stats-on-crash.patch?h=win_ap.1.0

It is not applied. At least I can't find any ath11k_core_dump_bp_stats

Kind regards,
	Sven
--nextPart41236698.1DgVcCGkzx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAl1lCswACgkQXYcKB8Em
e0Yu8Q//UsAcD8O2MzZ8xpv84cQJY2NkB1JsFRc3Ww2QoYBKt2IP/wz5BiMwN1E6
bol+r3264SViCt3znDKhCy5MTiPYY5eOR0hk7BCa+d6Dsv1aklmTb8sgXEcdEGWD
O4v18ZAAWaTuUJlR1x1mNekYmqPR21qEB7+J/6RcAU0jPfeHOPS6X93ZWnyghcmI
YSq/GN+1coZ5xfDTH/4aIZ2fL8LnOwxFKzpmj81drqlrrw/iljN3RA4OrPa9HtNN
7uDBJPmk0H2+4rht/koJDg0EbUdF+pYHRcU/d2ktM6ho210kOcvNEDjK2T3PL6HZ
HH5/BVblq9gNLquQZSe/7qTweLzeIbOpARhnflRu1Xct2A8l0ibBwkn+ybxPNC2v
WJTp/6iOwrwAXs1pRfFnrYdvBDP/9Fw7fk4DnjEvolvmjNdjFIExqFxroYPI58IK
JMEwnIDGDtXJJ3B0mU9aSmPRDMraxgOR30rEzqvgB6TVfCUAVnmwl623nGfZ+fvW
nSpT/+q/SPt1YIsS413OanQbbhXkmIip+bzVByEMbObXCH2uK918oUGstalccqN2
ZjV63AEYOj7q+N7AD3s17KrUcrhu82fjnVxBi36eQlvTojZtk/tuNW3HK29CKVLJ
iZiZ0nyzAIk/s/qvU74KFVXmIAdqrECntuKOPtJtILoN5kxqDMc=
=9HJ7
-----END PGP SIGNATURE-----

--nextPart41236698.1DgVcCGkzx--



