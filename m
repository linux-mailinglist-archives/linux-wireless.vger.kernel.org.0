Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E99CD43F936
	for <lists+linux-wireless@lfdr.de>; Fri, 29 Oct 2021 10:46:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232492AbhJ2ItW (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 29 Oct 2021 04:49:22 -0400
Received: from dvalin.narfation.org ([213.160.73.56]:48220 "EHLO
        dvalin.narfation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232519AbhJ2ItU (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 29 Oct 2021 04:49:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
        s=20121; t=1635497208;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=PR16w57AKj5tMTKYNam/31hky1T8WwlBs/Lp1Osscrk=;
        b=j9nBc+7DtyMJMGjp9okEexHU2uA//x4de99lPaRNvSSCeAtx4HHyd8NMaIlp6csns1F3Fg
        dJRa0a6WzHuBFzI3z32vPas4jsWgScsP5N3EFArU3z5Kzq4EYjvNNhzR+1tu5wIthrWHdu
        t9y45JmbeMspYyotzs/ZcnT82dTTOx8=
From:   Sven Eckelmann <sven@narfation.org>
To:     linux-wireless@vger.kernel.org,
        Johannes Berg <johannes@sipsolutions.net>
Cc:     Johannes Berg <johannes.berg@intel.com>,
        Jan Fuchs <jf@simonwunderlich.de>
Subject: Re: [PATCH] nl80211: fix radio statistics in survey dump
Date:   Fri, 29 Oct 2021 10:46:43 +0200
Message-ID: <2494935.OLRZgKR7aK@ripper>
In-Reply-To: <20211029092539.2851b4799386.If9736d4575ee79420cbec1bd930181e1d53c7317@changeid>
References: <20211029092539.2851b4799386.If9736d4575ee79420cbec1bd930181e1d53c7317@changeid>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2690576.6NeSVaK773"; micalg="pgp-sha512"; protocol="application/pgp-signature"
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

--nextPart2690576.6NeSVaK773
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"; protected-headers="v1"
From: Sven Eckelmann <sven@narfation.org>
To: linux-wireless@vger.kernel.org, Johannes Berg <johannes@sipsolutions.net>
Cc: Johannes Berg <johannes.berg@intel.com>, Jan Fuchs <jf@simonwunderlich.de>
Subject: Re: [PATCH] nl80211: fix radio statistics in survey dump
Date: Fri, 29 Oct 2021 10:46:43 +0200
Message-ID: <2494935.OLRZgKR7aK@ripper>
In-Reply-To: <20211029092539.2851b4799386.If9736d4575ee79420cbec1bd930181e1d53c7317@changeid>
References: <20211029092539.2851b4799386.If9736d4575ee79420cbec1bd930181e1d53c7317@changeid>

On Friday, 29 October 2021 09:25:39 CEST Johannes Berg wrote:
> From: Johannes Berg <johannes.berg@intel.com>
> 
> Even if userspace specifies the NL80211_ATTR_SURVEY_RADIO_STATS
> attribute, we cannot get the statistics because we're not really
> parsing the incoming attributes properly any more.
> 
> Fix this by passing the attrbuf to nl80211_prepare_wdev_dump()
> and filling it there, if given, and using a local version only
> if no output is desired.
> 
> Since I'm touching it anyway, make nl80211_prepare_wdev_dump()
> static.

Tested-by: Sven Eckelmann <sven@narfation.org>

Thanks for checking the problem. I've tested it together with 
https://patchwork.kernel.org/project/linux-wireless/patch/20211029072939.15767-1-johannes@sipsolutions.net/
on an AX200 and firmware version 59.601f3a66.0 cc-a0-59.ucode.

    $ sudo ./iw dev wlan0 survey dump --radio                                                                    
    Survey data from wlan0
            channel active time:            17205356 ms
            channel receive time:           653 ms
            channel transmit time:          74 ms

But you might have noticed that the channel active time is off by a lot. Just 
after a couple of seconds:

    sudo ./iw dev wlan0 survey dump --radio
    Survey data from wlan0
            channel active time:            38689859 ms
            channel receive time:           904 ms
            channel transmit time:          128 ms

Here are the times from a loop with a delay of roughly one second:

        channel active time:            47284414 ms
        channel active time:            47284455 ms
        channel active time:            47284496 ms
        channel active time:            47284637 ms
        channel active time:            47284742 ms
        channel active time:            47284788 ms
        channel active time:            47284860 ms
        channel active time:            47284871 ms
        channel active time:            47284883 ms
        channel active time:            47284911 ms
        channel active time:            47285040 ms
        channel active time:            47285280 ms
        channel active time:            47285449 ms
        channel active time:            47285745 ms
        channel active time:            47285886 ms
        channel active time:            47286074 ms
        channel active time:            47286108 ms
        channel active time:            47286120 ms
        channel active time:            47286154 ms
        channel active time:            47286235 ms
        channel active time:            47286247 ms
        channel active time:            47286405 ms
        channel active time:            47286418 ms
        channel active time:            51581468 ms
        channel active time:            51581569 ms
        channel active time:            51581765 ms
        channel active time:            51581795 ms
        channel active time:            51581807 ms
        channel active time:            51581818 ms
        channel active time:            51581836 ms
        channel active time:            51581877 ms
        channel active time:            51582130 ms
        channel active time:            51582205 ms
        channel active time:            51582219 ms
        channel active time:            51582269 ms
        channel active time:            51582319 ms
        channel active time:            51582379 ms
        channel active time:            51582430 ms
        channel active time:            51582491 ms
        channel active time:            51582694 ms
        channel active time:            51582870 ms
        channel active time:            51582926 ms
        channel active time:            51582946 ms
        channel active time:            51583078 ms
        channel active time:            51583111 ms
        channel active time:            51583120 ms
        channel active time:            51583129 ms
        channel active time:            51583142 ms
        channel active time:            51583172 ms
        channel active time:            51583186 ms
        channel active time:            51583331 ms
        channel active time:            51583449 ms
        channel active time:            51583649 ms
        channel active time:            51583776 ms
        channel active time:            51583789 ms
        channel active time:            51583801 ms
        channel active time:            51583821 ms
        channel active time:            55878795 ms
        channel active time:            55878828 ms
        channel active time:            55878853 ms
        channel active time:            55878863 ms
        channel active time:            55879005 ms
        channel active time:            55879051 ms
        channel active time:            55879114 ms
        channel active time:            55879144 ms
        channel active time:            55879169 ms
        channel active time:            55879313 ms
        channel active time:            55879610 ms
        channel active time:            55879626 ms
        channel active time:            55879641 ms
        channel active time:            55879786 ms
        channel active time:            55879931 ms
        channel active time:            55880082 ms
        channel active time:            55880114 ms
        channel active time:            55880145 ms
        channel active time:            55880304 ms
        channel active time:            55880342 ms
        channel active time:            55880397 ms
        channel active time:            55880407 ms
        channel active time:            55880595 ms
        channel active time:            55880653 ms
        channel active time:            60175670 ms
        channel active time:            60175702 ms
        channel active time:            60175714 ms
        channel active time:            60175863 ms
        channel active time:            60175876 ms
        channel active time:            60175887 ms
        channel active time:            60175925 ms
        channel active time:            60175935 ms
        channel active time:            60175950 ms
        channel active time:            60175957 ms
        channel active time:            60175968 ms
        channel active time:            60176020 ms

I haven't checked if these jumps are related to anything specific or not. But 
if you multiple the values by 1000 (msec -> usec) and then create a diff 
between the previous values then you see that these values are also all over
the place and not roughly ~1000000.

If you just read the mvm->radio_stats.on_time_rf (in usec) then you see following:

        channel active time:            2346292 us
        channel active time:            3357380 us
        channel active time:            4368516 us
        channel active time:            4567172 us
        channel active time:            126139 us
        channel active time:            196605 us
        channel active time:            214119 us
        channel active time:            234556 us
        channel active time:            293402 us
        channel active time:            311971 us
        channel active time:            322606 us
        channel active time:            368173 us
        channel active time:            382785 us
        channel active time:            420408 us
        channel active time:            430851 us
        channel active time:            442990 us
        channel active time:            458566 us
        channel active time:            54960 us
        channel active time:            67810 us
        channel active time:            187747 us
        channel active time:            4295188641 us
        channel active time:            4295229424 us
        channel active time:            16295 us
        channel active time:            160736 us
        channel active time:            330166 us
        channel active time:            340849 us
        channel active time:            356933 us
        channel active time:            562579 us
        channel active time:            628140 us
        channel active time:            678766 us
        channel active time:            736022 us
        channel active time:            751099 us
        channel active time:            769377 us
        channel active time:            787728 us
        channel active time:            822183 us
        channel active time:            832478 us
        channel active time:            863107 us
        channel active time:            915469 us
        channel active time:            52166 us
        channel active time:            201828 us
        channel active time:            364236 us
        channel active time:            387916 us
        channel active time:            422965 us
        channel active time:            8560 us
        channel active time:            4295006989 us
        channel active time:            4295020943 us
        channel active time:            4295051766 us
        channel active time:            4295086037 us
        channel active time:            4295119851 us
        channel active time:            4295157051 us
        channel active time:            4295193488 us
        channel active time:            4295247769 us
        channel active time:            4295302615 us
        channel active time:            4295315627 us
        channel active time:            4295352876 us
        channel active time:            45385 us
        channel active time:            121871 us
        channel active time:            142972 us
        channel active time:            262344 us
        channel active time:            418666 us

So it also jumps all over the place. This could be investigated further but I 
just wanted to mention it here.

Kind regards,
	Sven

--nextPart2690576.6NeSVaK773
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAmF7tPMACgkQXYcKB8Em
e0Y33A//fp2rf3ZL9iq6gwPpUWgn3BqpkPXOwcYDBs4LMnWpnKYW5gz/jpEvBUop
K48NYNt+ijt+y6Ipp+dLxPyfWTwYDT4xrcwlwHqapj7bofG/RHX5vuya3oGtsPVI
IXksAByjkaZyV0bDn8uDwT2f77L7E1vHkgKL15dMF7mh4tfMuEocxe18tL4kX7j+
UNuhxyRuc9GS/a1ba7NKZRminulL22ipKVvMScjV/dw8hGrzWXLOw/1pmcwSCxh6
ydwLCK32CI05jhlcgAMNUndnRMp4wMHslcNzgzlCR89GSfnjUimXn8S4+m8Lxcbf
wJhUu7PcEiQ9pIDAfAJZEeTCRyb8fpE61l4evX8Vt9PbzjpGVOyYQ0XVd7hSmzVT
NvzK9/cieTQhyRhuXiVJePSyZbeW0tAso+jKfJMEeAwEDsZLLpfWK6qQ0raMRGQu
jjWqXONJnH8W0pnDPaGpd2JqQ3lBHj1rJmynSAmapWhAC7GSupgAIrhxcKO4JEbo
ZJO1g3wKEyFoELSXe3V57c9u+lkwRau+Vrq04tlI41ekun0csxZfMKr7qfw6u9eN
ZH3R33Ac5s4O6f5Zs035HH4Uy7VMqBRgeAMRam7nQQICBJoGpknIpGosWiIzusaH
j1OM5N5Va1Vs+9N5IRtN+ErddFNblvdhRoz9KVqnHwoEZwMFlMI=
=FZzq
-----END PGP SIGNATURE-----

--nextPart2690576.6NeSVaK773--



