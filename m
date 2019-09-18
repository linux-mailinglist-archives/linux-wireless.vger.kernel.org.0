Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B9D80B6422
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Sep 2019 15:13:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727004AbfIRNNz (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 18 Sep 2019 09:13:55 -0400
Received: from dvalin.narfation.org ([213.160.73.56]:48668 "EHLO
        dvalin.narfation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726268AbfIRNNz (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 18 Sep 2019 09:13:55 -0400
Received: from bentobox.localnet (p200300C5971113F0000000000000063E.dip0.t-ipconnect.de [IPv6:2003:c5:9711:13f0::63e])
        by dvalin.narfation.org (Postfix) with ESMTPSA id A307E1FF55;
        Wed, 18 Sep 2019 12:44:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
        s=20121; t=1568810668;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4fN6X+sIH7Jw3xYYUZxPZfWLfnNnQDNdbUhuy7Jx1Bc=;
        b=ACsJgPuxmWq/N1gTDKSc5B4xmgS5zYLBcWiOTpoDJcZ//8wTfrThBz4GphxqBJ6y7S4BJv
        tXlcnzS+ByMybU/kOq58scgbhDJe+JLN1Da8vAzJTehXYrTq7B9t/XX8XsRK3hobdsMoOQ
        2OogKPzJ77RZAWLyrBL1Gm02Lsiuov4=
From:   Sven Eckelmann <sven@narfation.org>
To:     Ben Greear <greearb@candelatech.com>
Cc:     ath10k@lists.infradead.org, sw@simonwunderlich.de,
        vnaralas@codeaurora.org, Johannes Berg <johannes@sipsolutions.net>,
        slakkavalli@datto.com, linux-wireless@vger.kernel.org
Subject: Re: [PATCH] cfg80211: Add cumulative channel survey dump support.
Date:   Wed, 18 Sep 2019 15:13:50 +0200
Message-ID: <1915721.epgQvm9qp9@bentobox>
In-Reply-To: <9396620.6V9WzEIOqW@bentobox>
References: <1526980556-26707-1-git-send-email-vnaralas@codeaurora.org> <b24ec622-8510-d8e4-bbc4-86a34c1dd32b@candelatech.com> <9396620.6V9WzEIOqW@bentobox>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart3096840.zzhJXNy4Gy"; micalg="pgp-sha512"; protocol="application/pgp-signature"
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
        s=20121; t=1568810668;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4fN6X+sIH7Jw3xYYUZxPZfWLfnNnQDNdbUhuy7Jx1Bc=;
        b=eE3WRZdAV2lP7ga+7twwQjXqfJCWE42A9DsVQd0tnCB2isXbbdD8qiCI5JVqLvKOsFKmwb
        9tnMDow1I0kor2fSHJafjRLze1f0pPTBO/Zt+rd5p047HeSUuMCgvH13uQ2Q8RAHtz9aYI
        4NQ9I7E0JwZ6HfO32KnO6zg2iKBOHnQ=
ARC-Seal: i=1; s=20121; d=narfation.org; t=1568810668; a=rsa-sha256;
        cv=none;
        b=cO4AI1Pt6iMNkh3u29JVUClIjnGCErFXHNX2zO1ZRHPfsOsAWlJBcvluQnTwdJKuYSbSLa
        4O7NW/0dmUGz3WjF3cEj1w/e5M34tbwt7QQOGLr9V/Uoil8jC/wVbhm0TJvkxXzvoqL3NI
        GUFvly9wgNkYEL4glCJirs00a8AyjBo=
ARC-Authentication-Results: i=1;
        dvalin.narfation.org;
        auth=pass smtp.auth=sven smtp.mailfrom=sven@narfation.org
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

--nextPart3096840.zzhJXNy4Gy
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Wednesday, 18 September 2019 15:07:11 CEST Sven Eckelmann wrote:
[...]
> I have now prepared a test patch [1] to get the data every 10 seconds. This 
> was a compromise between having useful information over time and the 
> overflowing problem. 

...over time without too many "bss channel survey timed out" errors and...

Kind regards,
	Sven
--nextPart3096840.zzhJXNy4Gy
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAl2CLY8ACgkQXYcKB8Em
e0b1SxAAtEDe5QoD4u5/aCttIe1q0DlYYCSY1cIBm7fIp8VuQsZYr5zL7lI/NEEv
ISZmqrQ5Ml4fjKPZ8P0lV1mHGvKrdAS82gk+f/QmAE5IpMeOZ2UsYN8h4BY3aH5+
tXAG+6/Dwy3hnFP4TluS4zdIhN30tSXxbafV0LL7im25GDHTwYWczQ38Y38xko62
974A6iwfavwuUSuN9L8wwee1EHPsueh7dclPoGkeLfBtMxD/vr7EE3GAffGvnYSk
FpiGZotSulIEWg7oLkZoF2QUFxZ9GaN5uVY+t2WWF+cC2xpTtjS6CfDXHRKVq9B4
Slw2+EyFe0X5u6P7cimmwR9FRSGmJYi7pFdU6wt698Oc+1/+tHGXMVnuViIMrVgT
LHt+POqDyrB8+dilI2UQKKXaK/0NdfboB2PlIZxta6CVTf93N0E9xVxmIW2IbVIi
UkBHmGjmz5C70Z1Z3MuYs+0iyMmBov0Lhr23+3t85SK8M7Hdk6DNrs9W43r7VcwE
ZSgwAF5OfNeTsWvbJWFRTOr7bVaFju8EhY/zQOgXWCWmrS3BTYvGhfL2tl9PtyWy
ELrflQVZWNbYy1ECF4ZDFAh1UBaBo4l9vhft7OeB36cFVMPAypX+ZR3wNI8uHxay
LAfGb5aSMfNj4U+1g3zuZ+7WZhC6C/tOJttV7ljFCH9fAqN4YHo=
=vMka
-----END PGP SIGNATURE-----

--nextPart3096840.zzhJXNy4Gy--



