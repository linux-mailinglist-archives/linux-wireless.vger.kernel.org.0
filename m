Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D66481C3FDB
	for <lists+linux-wireless@lfdr.de>; Mon,  4 May 2020 18:29:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729636AbgEDQ3j (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 4 May 2020 12:29:39 -0400
Received: from dvalin.narfation.org ([213.160.73.56]:60316 "EHLO
        dvalin.narfation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728655AbgEDQ3j (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 4 May 2020 12:29:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
        s=20121; t=1588609772;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2p0xlqH/n1GRp0FBc63MMF95nvW3k0K1p0+mBKAtSW4=;
        b=VsccDo+2zaqkIeSU7CKoICc7/1p55+F44hkciv60cRfP+miV/RvyGGc5gNMQHK6dKAT/kZ
        W1JXdTQ+XcM+zoyxdBx7r8gC+6C7/xC9dclW6EPG2PPlxBIDmHlJR5t5GUVKlR9SQrEgs3
        t/D57IJhBHUrDOQVroxAJ4zH3GQ71WY=
From:   Sven Eckelmann <sven@narfation.org>
To:     ath11k@lists.infradead.org
Cc:     Markus Theil <markus.theil@tu-ilmenau.de>,
        linux-wireless@vger.kernel.org, ath10k@lists.infradead.org,
        kvalo@codeaurora.org
Subject: Re: [PATCH 1/2] ath10k: use cumulative survey statistics
Date:   Mon, 04 May 2020 18:29:26 +0200
Message-ID: <1760068.xeLkAeoAig@bentobox>
In-Reply-To: <20200504154122.91862-1-markus.theil@tu-ilmenau.de>
References: <20200504154122.91862-1-markus.theil@tu-ilmenau.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart3821530.ePlWPIuScu"; micalg="pgp-sha512"; protocol="application/pgp-signature"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

--nextPart3821530.ePlWPIuScu
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Monday, 4 May 2020 17:41:21 CEST Markus Theil wrote:
> ath10k currently reports survey results for the last interval between each
> invocation of NL80211_CMD_GET_SURVEY. For concurrent invocations, this
> can lead to unexpectedly small results, e.g. when hostapd uses survey
> data and iw survey dump is invoked in parallel. Fix this by returning
> cumulative results, that don't depend on the last invocation. Other
> drivers, e.g. ath9k or mt76 also use this behavior.

It is (unfortunately) not that trivial:

See code and comments from other people:

* https://patchwork.kernel.org/cover/11150285/
* https://patchwork.kernel.org/patch/11150287/
* https://patchwork.kernel.org/patch/11150289/

Kind regards,
	Sven

--nextPart3821530.ePlWPIuScu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAl6wQuYACgkQXYcKB8Em
e0YCdhAAygPurJUmKQJVE5BgEzHYMvKcjs753EZjE4y4jiapgn1eygKetd86eG0y
v9/H370oOke8oR7OZD+LH/8KtQDuhAENiasfB9gpDwZJoEtfA5YjBQmUJLz/+K30
GJcqjCr2s2dCqIDIqXvKz+nJFgpDUkY1qowIi0/eQN9N10gIuUzh66eTLMTUUuSt
e5E1POqjvVHD8Fh5sa+e3vTofx2aeKJHI5Bkze59xm0gIh/l44f7YyHzeZnAJ5cZ
LlCAjpENR5aQvCkr3Vt6IMjJWtDk9/zydkzIkJAL99LyScdMYAgg3qnSekvIJ3N5
gDF28qSi+PwzpqGm1YSVtwv/BK7NjP5b7t0P6CZtWPmzypEEc8fUAYeIAGTwgVib
bsbuX/HQbxglLYQkoD6UQPjRkFOrNfM8SFR+rIjxc5DfVGG8dPPwfBqok0PbsRoE
JK/KP0Enjt2XsSswER5yCbqEZkIytWsAE/Eh3OfuFLGejOw9OhmfEnZQXyVbk4RP
5+4N6KkD+WS+AdctlXuS5+aR5tb5yMutQ7COn97kZGc2cR5OU89Sc3sFm+ydZGRK
EuXrsyW2V3p6Yh82Mi8aXR1pHwAGxS5+nyMT0Tg+c9hVEQx+2gfJhrNztEOFWXjD
m9jTk3xJtsGNoKqNijhFRCDQuykk5DGWUy96v/mVknpJcZqxh48=
=sviW
-----END PGP SIGNATURE-----

--nextPart3821530.ePlWPIuScu--



