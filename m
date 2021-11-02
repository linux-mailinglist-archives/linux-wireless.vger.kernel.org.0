Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 436FC442C46
	for <lists+linux-wireless@lfdr.de>; Tue,  2 Nov 2021 12:12:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229963AbhKBLPP (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 2 Nov 2021 07:15:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229720AbhKBLPM (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 2 Nov 2021 07:15:12 -0400
Received: from dvalin.narfation.org (dvalin.narfation.org [IPv6:2a00:17d8:100::8b1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DD70C061714
        for <linux-wireless@vger.kernel.org>; Tue,  2 Nov 2021 04:12:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
        s=20121; t=1635851553;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=e6kC1xaOZh66owztSybxfMsXeb+NMRVEnrWt4/X93A0=;
        b=Odf0qkbRPVgfmsXJvIPpilXy5BPnrW+eHp3V4+8bfy3QP3lcvgKxz/wxmbXq/9t8DqDxGC
        peLNjeUZKumH3C/ChnKjrA4p8vjxskwtXpBOH1kkD51BDwzQtIoD5ryiFOps2e+zJBvIFR
        3ygkp05JmIw4fVKUo/PA7TjLlo+fbmU=
From:   Sven Eckelmann <sven@narfation.org>
To:     linux-wireless@vger.kernel.org,
        Johannes Berg <johannes@sipsolutions.net>
Cc:     Johannes Berg <johannes.berg@intel.com>,
        Jan Fuchs <jf@simonwunderlich.de>
Subject: Re: [PATCH] nl80211: fix radio statistics in survey dump
Date:   Tue, 02 Nov 2021 12:12:28 +0100
Message-ID: <2007334.cWPf2AUjKI@ripper>
In-Reply-To: <2494935.OLRZgKR7aK@ripper>
References: <20211029092539.2851b4799386.If9736d4575ee79420cbec1bd930181e1d53c7317@changeid> <2494935.OLRZgKR7aK@ripper>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2029691.YG15ca5bOT"; micalg="pgp-sha512"; protocol="application/pgp-signature"
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

--nextPart2029691.YG15ca5bOT
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"; protected-headers="v1"
From: Sven Eckelmann <sven@narfation.org>
To: linux-wireless@vger.kernel.org, Johannes Berg <johannes@sipsolutions.net>
Cc: Johannes Berg <johannes.berg@intel.com>, Jan Fuchs <jf@simonwunderlich.de>
Subject: Re: [PATCH] nl80211: fix radio statistics in survey dump
Date: Tue, 02 Nov 2021 12:12:28 +0100
Message-ID: <2007334.cWPf2AUjKI@ripper>
In-Reply-To: <2494935.OLRZgKR7aK@ripper>
References: <20211029092539.2851b4799386.If9736d4575ee79420cbec1bd930181e1d53c7317@changeid> <2494935.OLRZgKR7aK@ripper>

On Friday, 29 October 2021 10:46:43 CET Sven Eckelmann wrote:
> If you just read the mvm->radio_stats.on_time_rf (in usec) then you see following:
[...]
>         channel active time:            8560 us
>         channel active time:            4295006989 us
>         channel active time:            4295020943 us
>         channel active time:            4295051766 us
>         channel active time:            4295086037 us
>         channel active time:            4295119851 us
>         channel active time:            4295157051 us
>         channel active time:            4295193488 us
>         channel active time:            4295247769 us
>         channel active time:            4295302615 us
>         channel active time:            4295315627 us
>         channel active time:            4295352876 us
>         channel active time:            45385 us
>         channel active time:            121871 us
>         channel active time:            142972 us
>         channel active time:            262344 us
>         channel active time:            418666 us
> 
> So it also jumps all over the place. This could be investigated further but I 
> just wanted to mention it here.

Sorry, wanted to write more about it last week but forgot about it. If I
basically filter out the upper 32 bit in mvm->radio_stats.on_time_rf then it 
didn't look that bad on a AX210. It seems like the upper bits is sometimes 
0x00000001 for unknown reasons. Like it would be some kind of flag which 
should indicate some kind of change/event. So maybe the firmware team could 
check what this means.

It is not really urgent - I just got interested in the problem :)

Thanks,
	Sven
--nextPart2029691.YG15ca5bOT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAmGBHRwACgkQXYcKB8Em
e0ZnMQ/+JLA7tiTaZeCEFz96+171KrBrdLCHF/ko03wYe9NmC3v73HY4qyPgA/st
vvIvXtVc3BRscQNfgeD/tc4RI3ni3147A7etdGjn8i9BJMn9AYW23VeX048d80GA
MVS5vkvsBKYu+de6KtjkmLKxi1NU5Tvc3FZZs3BNiRQLwbgBJZKwLBtFGRL5iqo/
FgupZyyr/I28ajc9H7q4MGvbop+pjj9pxgQ5LOU9hXZBN2BJcC17yIpXQaAlX8F7
4Id/lEcDgjBWyaxju8W5PzX/1n1JNA9PTs/YoWK7i+k33WQ4CfBq4JOR1hSQRtYp
djt9e2DsYa765OBNWAmEgh/2MLqsMQJBt4wzSS9HVssnLEqC0sOqJbJS/B4/CAaI
sM/gegG+PixJ/uaVcj+zZVIo57Dd7h2epT1fDHQJtKUgxLkba0++Jua3hydtZESr
/lqag9ycoNHtfKVix7OOUrU4gITUIkSK7qLdgL82tR09QYVq3DitFw+BjZXBoOF3
THtRM1nFIBTn2pkkZzOzoyKLpCvTpU4rKdcF1WbyB9D5wnwcmmd0CWor1JCB0Kzi
mEHeIc0/+ADov4a7WJqg+6tMHTAsNV9TkCnORGrDc2a8amM3Ygk3VKEnQ/ziU2WI
ZVRl9Q2nvM5Q+ZRS10mgFC+zRYV9AzsJrmugK+qprxJKhLBz3jc=
=5Nup
-----END PGP SIGNATURE-----

--nextPart2029691.YG15ca5bOT--



