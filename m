Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB4D148ABB8
	for <lists+linux-wireless@lfdr.de>; Tue, 11 Jan 2022 11:53:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349341AbiAKKxR (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 11 Jan 2022 05:53:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237719AbiAKKxQ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 11 Jan 2022 05:53:16 -0500
Received: from dvalin.narfation.org (dvalin.narfation.org [IPv6:2a00:17d8:100::8b1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CA91C06173F
        for <linux-wireless@vger.kernel.org>; Tue, 11 Jan 2022 02:53:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
        s=20121; t=1641898392;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=QTd0FTuJ1zu6nHPFav2wUHpH9/BRDgLmM7wW3sL7Nzg=;
        b=oLaJMtpsujuEk1zQOAC161mq515hFcZJP0N4CTep3ceeV82BQPW7UOZULiv7/I3y9iqfg5
        22iPeccgyDnpA/IhQ6rhgPJA1QUJ5aH5wJ3KFpB5obAXLZQDZx2ohrzjr4uoUFYKwQ96sE
        eG0o/PRHkgrGQVFu3NLX9/CDwdtCac4=
From:   Sven Eckelmann <sven@narfation.org>
To:     Lorenzo Bianconi <lorenzo@kernel.org>
Cc:     lorenzo.bianconi@redhat.com, sean.wang@mediatek.com, nbd@nbd.name,
        jf@simonwunderlich.de, linux-wireless@vger.kernel.org,
        linux-mediatek@lists.infradead.org,
        Deren Wu <deren.wu@mediatek.com>
Subject: Re: mt76: MT7921K monitor mode not working
Date:   Tue, 11 Jan 2022 11:53:09 +0100
Message-ID: <34944167.qDeGz8lmHr@ripper>
In-Reply-To: <YbusBazb4GAC6YQl@lore-desk>
References: <YapTmM3EztojTS9F@lore-desk--annotate> <12706913.cppxkphV4n@ripper> <YbusBazb4GAC6YQl@lore-desk>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1995525.QtnH1V4xGb"; micalg="pgp-sha512"; protocol="application/pgp-signature"
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

--nextPart1995525.QtnH1V4xGb
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"; protected-headers="v1"
From: Sven Eckelmann <sven@narfation.org>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: lorenzo.bianconi@redhat.com, sean.wang@mediatek.com, nbd@nbd.name, jf@simonwunderlich.de, linux-wireless@vger.kernel.org, linux-mediatek@lists.infradead.org, Deren Wu <deren.wu@mediatek.com>
Subject: Re: mt76: MT7921K monitor mode not working
Date: Tue, 11 Jan 2022 11:53:09 +0100
Message-ID: <34944167.qDeGz8lmHr@ripper>
In-Reply-To: <YbusBazb4GAC6YQl@lore-desk>
References: <YapTmM3EztojTS9F@lore-desk--annotate> <12706913.cppxkphV4n@ripper> <YbusBazb4GAC6YQl@lore-desk>

Hi,

On Thursday, 16 December 2021 22:13:41 CET Lorenzo Bianconi wrote:
> can you please try the patch below to see if it fixes the crash/hang in monitor
> mode?

I have tested it now. But it seems like it was already applied. Otherwise I 
would have provided my Tested-by.

The only problem I have with the monitor mode is the missing beacons (and 
maybe more frames which I haven't yet identified).

Kind regards,
	Sven
--nextPart1995525.QtnH1V4xGb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAmHdYZUACgkQXYcKB8Em
e0bz6hAAvN8XCN4JT8UAOQ2mqUvc4un4LFdZErMfVY3E0PFPX68IdIw3xVlZZbVx
4KHkCAO6lsfcQnYytpxljYCA+m0iT/A5WLObqwmNTevZ4pXW2IO2bK2Jpt8FaSCd
8PZfw1YeTzHT8oryQXXpc+3T6X6i9/txs3IYxdA3aCW28bLugJzaJrV68JI73PPm
lSsCUAlEiUtPmWmWmNuD0XIbPgVc7tCF72ghX3lMK6r39vx1EuKfzhePOh6FQBLg
Hvjbyhs5xKU7nAYsaV5ZODmDl+lbXmxTlqfHqlNnRwnoxiD1CMwZJdWk1Sy0mfxB
6vNCJJykja0isJwvTb0lkFP9emgPiDspzGf78dgPRSs+tHwNsVrdU2Rx7xYYGYU9
pQVT4b1E1rot7z5u9fo9rQewVvsKC1ayLyijhjred0A2gZmtqEBp/wpxbcmAy6k+
Ab66IjYWZF/iuuqjyCSinRJFeqQbqi96F5sX/qwutSXZPwZSMCt8R7+TenB9JrDq
bQnsiIaDkmr5QZk+LuBKr07OX+zt4qtkygSHeHXZHsd+TrFn7WgmIJ/yanzNGauW
Gf+AnT3uLwdfhuD7g34q+LustQrgfrjTNX+Hrs7VeV8uG1cM9Rhs4l5i19HE29JC
fYCgmDPSX1k7xwJqKwxEszClcDjIKiIeQ42482hPsWTcT0emHso=
=trR3
-----END PGP SIGNATURE-----

--nextPart1995525.QtnH1V4xGb--



