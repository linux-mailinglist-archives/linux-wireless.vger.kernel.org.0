Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6AFCCB6403
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Sep 2019 15:07:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729855AbfIRNHR (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 18 Sep 2019 09:07:17 -0400
Received: from dvalin.narfation.org ([213.160.73.56]:48524 "EHLO
        dvalin.narfation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727001AbfIRNHR (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 18 Sep 2019 09:07:17 -0400
Received: from bentobox.localnet (p200300C5971113F0000000000000063E.dip0.t-ipconnect.de [IPv6:2003:c5:9711:13f0::63e])
        by dvalin.narfation.org (Postfix) with ESMTPSA id F2DD31FEDA;
        Wed, 18 Sep 2019 12:37:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
        s=20121; t=1568810269;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7mkuvuGCv8D1pI1RqMuReknb7eYubYgm6b4koTPPIwo=;
        b=0a17J9XEAFKruUEdzu1G9MoVD1TDC4+hONx+qBtTK01hrtniUJx/1BZdGwFJQ7eh8yGL92
        DuhLFWE4ZYh2rIDwgysKdGveZPvZjYqLHdgmdiuLuTlXka/IprbhQ13Tw5GswqUGcL8zy7
        JiGnSwnmSWTBGuSXkjsn2ZfGiApdu7I=
From:   Sven Eckelmann <sven@narfation.org>
To:     Ben Greear <greearb@candelatech.com>
Cc:     ath10k@lists.infradead.org, sw@simonwunderlich.de,
        vnaralas@codeaurora.org, Johannes Berg <johannes@sipsolutions.net>,
        slakkavalli@datto.com, linux-wireless@vger.kernel.org
Subject: Re: [PATCH] cfg80211: Add cumulative channel survey dump support.
Date:   Wed, 18 Sep 2019 15:07:11 +0200
Message-ID: <9396620.6V9WzEIOqW@bentobox>
In-Reply-To: <b24ec622-8510-d8e4-bbc4-86a34c1dd32b@candelatech.com>
References: <1526980556-26707-1-git-send-email-vnaralas@codeaurora.org> <18458963.ukFM9YuvQx@bentobox> <b24ec622-8510-d8e4-bbc4-86a34c1dd32b@candelatech.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart32686119.arC66jU3Z4"; micalg="pgp-sha512"; protocol="application/pgp-signature"
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
        s=20121; t=1568810269;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7mkuvuGCv8D1pI1RqMuReknb7eYubYgm6b4koTPPIwo=;
        b=e14pZy+D0tc6yal2HpZP3yxn9yljSA5jnrPSDFr+73/6trEFVGCNEziUEunzxHhRuq8bM5
        nmHcCuHpU0sE6A+JI197y02IfZRatO9CzJ/07DecdmCP8sZkUbN5ef9bmgp1707ZfIIqiG
        PXam7At73G+qLnT8gevKKtGFpbGMNvo=
ARC-Seal: i=1; s=20121; d=narfation.org; t=1568810269; a=rsa-sha256;
        cv=none;
        b=UKGw/dzrqFKv8jU5ewM/ak+/qaodMTEDzUf4MGm92QG6iSx6Kui+J6jL5E/v3aP23rdKNR
        SsxaHQbeBvYRq/yqyRNIW8ceLIHQnYOY7as3IHK40HSldv6BcHC4owkgcjHmseZQ7ap/mf
        Yd7hU1juunZrQCwRmvKUiicdZun2QF8=
ARC-Authentication-Results: i=1;
        dvalin.narfation.org;
        auth=pass smtp.auth=sven smtp.mailfrom=sven@narfation.org
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

--nextPart32686119.arC66jU3Z4
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Wednesday, 18 September 2019 14:58:46 CEST Ben Greear wrote:
[...]
> > So as Ben Greear said, the 10.4 firmware version is fixed and 10.2.* (for
> > the wave-1 cards) is still broken and we need a QCA firmware engineer to
> > fix it. Or to work around it by polling every couple of seconds and
> > manually do the cleanup of the values from the firmware.
> 
> Have you tried probing very fast, like every 100ms, to see if returned values
> look sane?  I seem to recall that there was some firmware issue with this, like
> it only updates internal counters every second or so.
> 
> Polling slow would have the same off-by-a-second's-worth-of-data, but you would not
> easily notice it at slower polling intervals.

Yes, I've polled at ~100ms intervals at some point. And it looked like I get 
most of the time only 0 values (for everything - including noisefloor) from 
the firmware when I do this. And the actual values are only send every second 
or so (I didn't actual make precise calculations here).

I have now prepared a test patch [1] to get the data every 10 seconds. This 
was a compromise between having useful information over time and the 
overflowing problem. While it is not the perfect solution (QCA *cough*), it is 
at least more bearable for me.

Kind regards,
	Sven

[1] https://patchwork.kernel.org/patch/11150289/
--nextPart32686119.arC66jU3Z4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAl2CK/8ACgkQXYcKB8Em
e0Y94hAA0/ROFoGwOKnIIlCRxVRpa4GmCdYUKUYB32Dk1Pnm4atB6xdzT4bTk9+Y
TY/0AcQ0ycYSgw/T52kiyfGS79WSsUzce6oHpy7LD/fBr9QF2WBp66N5Ydw+VpK6
egcp31kHvTznCasXUbIejdlRBgEXyDPfpWuhobGrcRLjg8AZNsj/4fFtWdTCEeJn
u/2o+AAtK2CkSH5cyWf6oDF1f3essL2GiOl2/6fbo7dfvbGYhQ8BtKrPzWyiNVDs
Saxym1JX4lI0thTa/NB6g+UZzDeEpR6Kvcj0X2M9aqH69bckgxQoakRo245Z5/TH
UYO9b6OtM52ZP93s6AXd/grSi14EbrY92Yap4LQT1Rf7ldOJnPlS8ugPKKEuUZu+
CcsPfQHB8CHLe0Zi8mmkS91/ox7TUyPxtC/uXrb8L5Hesj5BiLL2rF26HQnzGWvI
E7qF48nx2Q4xNpe5nhhD8wv3KuJwkG1T0iXxBf9UNdlCqnNsWBwxHYiX835RH/MO
tj28Kn5yd00lSin2Yf8A7V6EDShmb8OSdVrHdYV9MqPnNnvp8qXBITPnMW1l1gzh
VOVqYDUxdaa/DZUnVtlFzsmzNWGhFlS1jtOrPZcGzkYmkLvw48PO48OBct8j1EpR
IbJCYGMSFNbkvCJblMrcjX+c6ZVJbP6ckYyt0GJJkjnMDofOGSc=
=SJ3l
-----END PGP SIGNATURE-----

--nextPart32686119.arC66jU3Z4--



