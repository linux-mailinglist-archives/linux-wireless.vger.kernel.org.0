Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88D3A3E58B5
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Aug 2021 12:58:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238063AbhHJK7C (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 10 Aug 2021 06:59:02 -0400
Received: from dvalin.narfation.org ([213.160.73.56]:60094 "EHLO
        dvalin.narfation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236602AbhHJK7B (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 10 Aug 2021 06:59:01 -0400
X-Greylist: delayed 364 seconds by postgrey-1.27 at vger.kernel.org; Tue, 10 Aug 2021 06:59:01 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
        s=20121; t=1628592748;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vaByksnZU0SJEQddb5aLty6JxOjM7E9gHuqnSrHVxIY=;
        b=va2OkbaZUnybNsNJgvbLYD6cyhKkKOenUxtS/vyUWXreNV2RJQ5Uz+K4jd8sK5w2GJW138
        bLe8K9FYsQwPzplzFAuag5neDaa9pFNvVHE8Gihake6iWxieHc2Vu4aFnd6dLsGDr3rA8j
        cN8+VgDKdJCCxLI8jmbnHYmcxeTYyUY=
From:   Sven Eckelmann <sven@narfation.org>
To:     ath11k@lists.infradead.org, linux-wireless@vger.kernel.org,
        Maharaja Kennadyrajan <mkenna@codeaurora.org>
Subject: Re: [PATCH v5 1/3] nl80211: Add support for beacon tx mode
Date:   Tue, 10 Aug 2021 12:52:20 +0200
Message-ID: <6210385.n8AMQ0p90U@ripper>
In-Reply-To: <1628585783-21139-2-git-send-email-mkenna@codeaurora.org>
References: <1628585783-21139-1-git-send-email-mkenna@codeaurora.org> <1628585783-21139-2-git-send-email-mkenna@codeaurora.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart6500757.dMg44LP4KO"; micalg="pgp-sha512"; protocol="application/pgp-signature"
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

--nextPart6500757.dMg44LP4KO
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"; protected-headers="v1"
From: Sven Eckelmann <sven@narfation.org>
To: ath11k@lists.infradead.org, linux-wireless@vger.kernel.org, Maharaja Kennadyrajan <mkenna@codeaurora.org>
Subject: Re: [PATCH v5 1/3] nl80211: Add support for beacon tx mode
Date: Tue, 10 Aug 2021 12:52:20 +0200
Message-ID: <6210385.n8AMQ0p90U@ripper>
In-Reply-To: <1628585783-21139-2-git-send-email-mkenna@codeaurora.org>
References: <1628585783-21139-1-git-send-email-mkenna@codeaurora.org> <1628585783-21139-2-git-send-email-mkenna@codeaurora.org>

On Tuesday, 10 August 2021 10:56:21 CEST Maharaja Kennadyrajan wrote:
> 1. Staggered mode and 2. Burst mode while bring-up the AP
> or MESH.

Why when you bring up mesh or AP when it is actually a global setting for this 
radio/PHY?


Kind regards,
	Sven
--nextPart6500757.dMg44LP4KO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAmESWmQACgkQXYcKB8Em
e0ZVNhAAzEL7jFJRhuGh9GrlP6Jrf8AdcQ+Loy1Pg3u6f4QtRmPvUtYyuh49dqXJ
PA5Qheatm8hWbKRnvMLbJSwz6eZoN23R4bacKh0Zf3hpnyw3t5Z2VzLuEcqT1VYA
N8X1sMQgqiFtUAsd+B3XXgJW+MIf73IY1/iQ3BNpoVJNCT6+rsCC+Nuc9/kQ7vzN
U0X3/f4llpaaWoJqXuCOQwEMeEBU7VzMeliYki7qaecUYV09wx6Y5iDB4FN9BzBC
7e32l7rQ/HIK4Ddr3g4/pUz1st3+2gJdVPcufS4KMMbremWw4nqSy4/cEqPMuZ2y
vguzy+98Z7vJi2iFFP0o5GYYjDcE0Qn3e85bxoyj4jlNtZg5THufIty6LH+NB7do
YPYd8xja/9DhlmbIbJf0rTRg70xSpbpf8fG+8nodxwPHnfdntj1aZkdWomzSIhVT
txYkEFHbd/O7pAYZ2dHSmLYyDVFlclJonIPNrPq3aP687xagDSFt+i0vt2iRMl83
zVM0lwIDZsyl1Z6MO53xcHQ3bFJOsf1ovzUm/roZ4cuxjPFhw9HWRXb6tQ3u0BFV
uf1SBsGNBA6Ep1//suXx8+Qp1bxDWAthXouAsQyV44aX+ppR7nIaDh6KhUzep5q4
K3VavYf3/cvOgDiHFuGgIyBYL3VmgYWHiGyaz/Bvh/xn1UJU/M8=
=OsUH
-----END PGP SIGNATURE-----

--nextPart6500757.dMg44LP4KO--



