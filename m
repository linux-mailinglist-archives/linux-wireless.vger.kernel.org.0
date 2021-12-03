Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A170467A53
	for <lists+linux-wireless@lfdr.de>; Fri,  3 Dec 2021 16:32:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381797AbhLCPfm (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 3 Dec 2021 10:35:42 -0500
Received: from dvalin.narfation.org ([213.160.73.56]:32894 "EHLO
        dvalin.narfation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381772AbhLCPfj (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 3 Dec 2021 10:35:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
        s=20121; t=1638545532;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=KDEb36E4YLXNFoIVpMkEuU1ZVg+cNe5IMJDkmd+ss/A=;
        b=gHWwhKP+f9iUSCL8TV+3cvwJf7bPQa9KJfd039zEOL65IcSfEZIYMQwcLncQ/aV/xc3rLK
        rztkVwsBsg0+c9M4gHKcWqtF64vuOBnGpFVXDhTdKGOmeThFHqYkyj8gcN3oZN3/EcDc4t
        NbypO0CKx28iy7mKWDyU9SW2v9NLHUM=
From:   Sven Eckelmann <sven@narfation.org>
To:     Lorenzo Bianconi <lorenzo@kernel.org>
Cc:     Jan Fuchs <jf@simonwunderlich.de>, linux-wireless@vger.kernel.org,
        nbd@nbd.name, linux-mediatek <linux-mediatek@lists.infradead.org>
Subject: Re: mt76: MT7921K monitor mode not working
Date:   Fri, 03 Dec 2021 16:32:09 +0100
Message-ID: <3467395.ZLqV6DWSsM@ripper>
In-Reply-To: <YalFC7UlCPsCSZqE@lore-desk>
References: <7e156597-a206-b236-e4c8-d476614de7ef@simonwunderlich.de> <YalFC7UlCPsCSZqE@lore-desk>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart5961587.kT4IN9KiTn"; micalg="pgp-sha512"; protocol="application/pgp-signature"
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

--nextPart5961587.kT4IN9KiTn
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"; protected-headers="v1"
From: Sven Eckelmann <sven@narfation.org>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: Jan Fuchs <jf@simonwunderlich.de>, linux-wireless@vger.kernel.org, nbd@nbd.name, linux-mediatek <linux-mediatek@lists.infradead.org>
Subject: Re: mt76: MT7921K monitor mode not working
Date: Fri, 03 Dec 2021 16:32:09 +0100
Message-ID: <3467395.ZLqV6DWSsM@ripper>
In-Reply-To: <YalFC7UlCPsCSZqE@lore-desk>
References: <7e156597-a206-b236-e4c8-d476614de7ef@simonwunderlich.de> <YalFC7UlCPsCSZqE@lore-desk>

On Thursday, 2 December 2021 23:13:31 CET Lorenzo Bianconi wrote:
> IIRC you need to disable runtime-pm and deep-sleep to proper enable monitor
> mode:
> 
> echo 0 > /sys/kernel/debug/ieee80211/phy<x>/mt76/runtime-pm
> echo 0 > /sys/kernel/debug/ieee80211/phy<x>/mt76/deep-sleep
> 
> Can you please give it whirl?

Jan gave me the card. I've set it to a rather busy channel (2.4GHz channel 
11), created a monitor interface, attached tcpdump and then waited what 
happens. I didn't get anything and then I've tried to set runtime-pm and deep-
sleep to 0. This didn't change the behavior for me at lot. I saw two packets 
and then it went silent again.

I wanted to try the same on a different card (ath11k) in the same system. But
it crashed my complete system - so I had to recreate the test setup. This time, 
I've set runtime-pm + deep-sleep to 0 before creating mon0. After doing this, 
it seemed to work.

Kind regards,
	Sven
--nextPart5961587.kT4IN9KiTn
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAmGqOHkACgkQXYcKB8Em
e0alJBAAjZ+Fk8GfFSDsiGJrSp0EiqoERd2NZuzTI9iawdlkwp+v2uI4ye1AdSk8
GXsZ1UkvkjSbRY+7V1A8M5VSLMwLIc0y9v6+6QifWUXmMFlOZegJ7wyr88cX0aNZ
TqWb9x4fsnbLAF8ntnj3r8DWFPPymlf1PnaAJmZydzL256gE98JqxGFo9gjw5R+v
zcIxvYYMZcoRuMNd4J7UnWxQp8ILAKQoiQZNqFGDMTjeUG9m66iknUG3klJD3DD2
NK2LibU4E0N++yDy0xDMD1wQyoGMsIcgMq2yrlGudYnjk6o448GbR91Rwi7w5tc/
bsThxnokUbzJrXqRcOeq+JTC8D13q2ePo9Zez+1ooKqfhw8m8zgewJC1PkKtlGyD
2MWg39F4O4ej8FLgXTLr2uirF/ZSHKqNMYpWC+XADwaOmWj0y554aKOh5BYW4ck3
alpgha2DXo+BiXiIEwWgGHqdJrrRxMSRMzIP0vWYk/TDJh35SkN3CaqsMRJX8icx
8hg6rKVJuglb4shYY9mfzM82Jt3YxADiQ/qgIlMGnEmjIUvUQFowmKn8jJTgGv1N
mR8DBJbwelyrHBY+sxqG56qT3trThLdVyqyCYyTmzbuwfpshg9bg2jC3DJ5SI0P4
V+8HtqfPYCe3hxy8z6GoOCSkZ1DdYuVhyGh2ct4p8n8EFi/uNhs=
=AOwR
-----END PGP SIGNATURE-----

--nextPart5961587.kT4IN9KiTn--



