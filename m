Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68E7B2C9E61
	for <lists+linux-wireless@lfdr.de>; Tue,  1 Dec 2020 10:54:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728199AbgLAJxE (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 1 Dec 2020 04:53:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726099AbgLAJxE (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 1 Dec 2020 04:53:04 -0500
Received: from dvalin.narfation.org (dvalin.narfation.org [IPv6:2a00:17d8:100::8b1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 888F3C0613D2
        for <linux-wireless@vger.kernel.org>; Tue,  1 Dec 2020 01:52:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
        s=20121; t=1606816341;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=eCzOY7FMzUUJ3YzbOvcWOTlJcFvyMBj2IEXOSVccYdA=;
        b=TPktusftTcMZA/YcwMi9fQd0TNtLCaR0BJ5WfRbsDCUEMMWOiWWodzrdUll22KjGHrv9ir
        wUTZyyNiJ8gGRjiHwCLQmTePGp8NY4sFF6yCXkraNNU3Yz5fU1lpuvj+8aZhY8pXc+Izwc
        MYWBuNGvGeAGlP+yoAxGRJwTvRgGsm0=
From:   Sven Eckelmann <sven@narfation.org>
To:     linux-wireless@vger.kernel.org
Cc:     ath10k@lists.infradead.org, Yibo Zhao <yiboz@codeaurora.org>,
        Toke =?ISO-8859-1?Q?H=F8iland=2DJ=F8rgensen?= <toke@redhat.com>
Subject: ath10k: Missing airtime scheduler parts
Date:   Tue, 01 Dec 2020 10:51:57 +0100
Message-ID: <2631481.BEx9A2HvPv@ripper>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart14225578.tv2OnDr8pf"; micalg="pgp-sha512"; protocol="application/pgp-signature"
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

--nextPart14225578.tv2OnDr8pf
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"; protected-headers="v1"
From: Sven Eckelmann <sven@narfation.org>
To: linux-wireless@vger.kernel.org
Cc: ath10k@lists.infradead.org, Yibo Zhao <yiboz@codeaurora.org>, Toke =?ISO-8859-1?Q?H=F8iland=2DJ=F8rgensen?= <toke@redhat.com>
Subject: ath10k: Missing airtime scheduler parts
Date: Tue, 01 Dec 2020 10:51:57 +0100
Message-ID: <2631481.BEx9A2HvPv@ripper>

Hi,

I was asked what parts are currently missing for (a better) airtime fairness 
with ath10k. I know that the AQL were merged and enabled for ath10k (and 
mt76). But there was also the virtual time-based airtime scheduler [1] which 
was proposed. I think the development on that one didn't continue since last 
year.

Maybe someone else knows if there were some other parts worked on which I've 
am missed and which were not yet merged.

Kind regards,
	Sven

[1] https://patchwork.kernel.org/project/ath10k/cover/1576221593-1086-1-git-send-email-yiboz@codeaurora.org/
--nextPart14225578.tv2OnDr8pf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAl/GEj0ACgkQXYcKB8Em
e0YKtQ/+MBMAucLKojyhktYQ/quKAlsSzjfUToMBqbOoK/oghEJ71h8SyGfRmefY
8w59lJDdZUN6p/3avtqLMD8wJqtzh4MBP2I3lfSw1E7Q9AdEczqwpB94wgJiSSwD
HAtcMpwWxtqbst6cXvF/zDGpSvuD4F1rrr5BqhvhXRysKNmP11TjXHwVCLYbr2n8
i8Y/+8UdF7aroSOsC7yG+lDHhvDl/BQ4sEAkJhbOfs9osLz8CDH9RQmp0+XV/GsM
ndc58/iSrngXXoNQFiyd42l2/kMBsdo2UvCtTYu5z7GKjczBjj3KWhp7eq/DUdKu
cN16YrRjg8pUXqdtTQE04J453B+/SlK060MC1FfizVYMvuLqRohmNurQZdcCnUB1
M3XbyvzFEuxiDHnscdAbkcED0vZ1x/LMsm0e/OfbPJltGmULNlHa59xW5jfZg8jD
TsjRynYnBgtglS/CiEducc/PBvQzLsDMssFVu0WVqJYt6aeKukO6ZXYUIy4NZ+Ee
zjWT5ibInLTLMyAGr/zmpUOOoeP6s8Pton+U8h3VBuBNhhf9TzXP3sD61Rntc++2
OmiXpLfA5MakelgWpbLU8f/H49PAEsnzdkzVW/vO3ZZYMh58LFFo3XwOlnrKd6Pg
ArUlv4LagXWZ+AodjrxU87azC30cflukIlVuRewHdzH0HlO/fgU=
=rVaC
-----END PGP SIGNATURE-----

--nextPart14225578.tv2OnDr8pf--



