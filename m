Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2A8D48ADA0
	for <lists+linux-wireless@lfdr.de>; Tue, 11 Jan 2022 13:31:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238801AbiAKMbh (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 11 Jan 2022 07:31:37 -0500
Received: from dvalin.narfation.org ([213.160.73.56]:50192 "EHLO
        dvalin.narfation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238766AbiAKMbh (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 11 Jan 2022 07:31:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
        s=20121; t=1641904296;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=KxI0+1ixeX04mdAflAuZYpbknnbcv7G6557+tCR3Hx0=;
        b=bbM/P19qzsJm5MJmkGudCyKHpiCdQ0f8fQnLz7c6ykNlEiKeyGloFjMhPA2SzJgLpC86Nz
        wt4WiF9qCxz4NON8IA88qqfNdmL2coflULG4c0q9YAqYCVDIESwofESDcCAm0YBO12lH0Z
        ipPKdmx3p0XqgdWnsOrhuHwV9vO0alI=
From:   Sven Eckelmann <sven@narfation.org>
To:     nbd@nbd.name, Lorenzo Bianconi <lorenzo@kernel.org>
Cc:     lorenzo.bianconi@redhat.com, linux-wireless@vger.kernel.org,
        sean.wang@mediatek.com, deren.wu@mediatek.com
Subject: Re: [PATCH] mt76: mt7921: toggle runtime-pm adding a monitor vif
Date:   Tue, 11 Jan 2022 13:31:33 +0100
Message-ID: <8554350.NRS6bbiA14@ripper>
In-Reply-To: <f6ad709b1a64152b5955e71b7eef9f9c4c7f127e.1641893305.git.lorenzo@kernel.org>
References: <f6ad709b1a64152b5955e71b7eef9f9c4c7f127e.1641893305.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart8012055.ZOJyUkArP5"; micalg="pgp-sha512"; protocol="application/pgp-signature"
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

--nextPart8012055.ZOJyUkArP5
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"; protected-headers="v1"
From: Sven Eckelmann <sven@narfation.org>
To: nbd@nbd.name, Lorenzo Bianconi <lorenzo@kernel.org>
Cc: lorenzo.bianconi@redhat.com, linux-wireless@vger.kernel.org, sean.wang@mediatek.com, deren.wu@mediatek.com
Subject: Re: [PATCH] mt76: mt7921: toggle runtime-pm adding a monitor vif
Date: Tue, 11 Jan 2022 13:31:33 +0100
Message-ID: <8554350.NRS6bbiA14@ripper>
In-Reply-To: <f6ad709b1a64152b5955e71b7eef9f9c4c7f127e.1641893305.git.lorenzo@kernel.org>
References: <f6ad709b1a64152b5955e71b7eef9f9c4c7f127e.1641893305.git.lorenzo@kernel.org>

On Tuesday, 11 January 2022 10:34:17 CET Lorenzo Bianconi wrote:
> Toggle runtime-pm and deep-sleep configuration adding/removing
> a montior vif in order to forward all tx/rx frames to mac80211.

Tested-by: Sven Eckelmann <sven@narfation.org>

So monitor interface now works out of the box for me. Only receiving of 
beacons (and maybe more?) is not possible with 

    mt7921e 0000:05:00.0: ASIC revision: 79610010
    mt7921e 0000:05:00.0: HW/SW Version: 0x8a108a10, Build Time: 20211222190839a
    mt7921e 0000:05:00.0: WM Firmware Version: ____010000, Build Time: 20211222190917

Thanks,
	Sven

--nextPart8012055.ZOJyUkArP5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAmHdeKUACgkQXYcKB8Em
e0bpcBAAv5UeRu8aCz+6BAFu+pQpN6cr6BV55+qILXudVIekhk8Nm/7Cikv3sC1G
wNzo6mCyG08eFmrZ1fQ8Yv9nStlsY+g40qd0hUIwjpml5qm0B6WxNLBsAmfg0C54
NOy5sEhsl+0kwkHU5aY7NI8vuQsxaxBpr9P+lXo9Tk7AXvNI3bfOdjUlDJyGnGfe
2vYVj0907IVFYPxdi8YDaG+LaDbIqBcBa8D9Y0zpHamgYAr69r9xsJw6g3j/7pmJ
zi8Volp9Lt05t8jmjf0IhkjHZ3SGMtFIsQxlfkC6SyQtEaMmdQD08KtADe2xzh9/
mmr/MFN/yfeBaFh5j06yQLtbz/TnUZqtW3yjcylwtqBAsWKtFob+pPrA5JTWobXi
ypWLemdJ1S90HO80Tq08HsMSEiK5VNV4kEMgj97PLjtK0Pr1EHXyK32iR7eUPoHO
FpKMxkePbAgiKTnxCkv9nAJKQVBYqF3Q8vaObpwh5B1nrmMXw87o9CUpdma8kVb+
9jYNiQKAuHuYcl9T8dOLavPXIzdSfJ6cbVa9LHG3ztF7OwRJ9wU8vdIo0dt4z6hi
EC00FtJq9JUX3VX/zOzeVvZeQqqgOflY1wZ+IC/f+RN01cVW96wLMIQv2nkD/q4d
Cq1l/R/SdVHK2tXkpJcAZ/vLJKW2gfCDs2K0FnOskwVmpr7iKC4=
=hey+
-----END PGP SIGNATURE-----

--nextPart8012055.ZOJyUkArP5--



