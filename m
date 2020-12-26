Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C41C2E2E95
	for <lists+linux-wireless@lfdr.de>; Sat, 26 Dec 2020 17:02:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726167AbgLZP6y (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 26 Dec 2020 10:58:54 -0500
Received: from mail.toke.dk ([45.145.95.4]:36475 "EHLO mail.toke.dk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725995AbgLZP6x (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 26 Dec 2020 10:58:53 -0500
X-Greylist: delayed 417 seconds by postgrey-1.27 at vger.kernel.org; Sat, 26 Dec 2020 10:58:52 EST
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=toke.dk; s=20161023;
        t=1608997868; bh=2JylgwVFA8756jMa2nl+If9D08U2iyMStNUgt9+KuU4=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=anb1r6GPlqoSLj4F3Kh6WeHqm0ZhWRuo9WLofj8BrdCA++p+17Xt0JDrFWqxoP213
         fkHBiG1QSJLb8HFXpSLFDW02mUm7wW5iu0+ZVGVXw2UZzG+i6qOS2zobFIXMxXBmVj
         rBzmf6fJfaf97yEGGYF+tgDGmueiYYaQGrI9523LJjPlVdE9OPjU3oNz0sJdqhNidX
         khglGiz//ZcRU3wOk/XhHNIevD1qDPuIoZI6qsgBcwUYQZ2nEwqT/JS7nRDfv2hyvW
         JZUPbs9vuzKTYhcJIB45myssZ4FmG/WEfPcHtTw/4nOQufnRnI5UVUj6iPwkuRFRgo
         Fqq1wy9HfzamQ==
To:     Lorenzo Bianconi <lorenzo@kernel.org>,
        linux-wireless@vger.kernel.org
Cc:     johannes@sipsolutions.net
Subject: Re: [PATCH mac80211] mac80211: check if atf has been disabled in
 __ieee80211_schedule_txq
In-Reply-To: <93889406c50f1416214c079ca0b8c9faecc5143e.1608975195.git.lorenzo@kernel.org>
References: <93889406c50f1416214c079ca0b8c9faecc5143e.1608975195.git.lorenzo@kernel.org>
Date:   Sat, 26 Dec 2020 16:51:08 +0100
X-Clacks-Overhead: GNU Terry Pratchett
Message-ID: <87v9cozhub.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Lorenzo Bianconi <lorenzo@kernel.org> writes:

> Check if atf has been disabled in __ieee80211_schedule_txq() in order to
> avoid a given sta is always put to the beginning of the active_txqs list
> and never moved to the end since deficit is not decremented in
> ieee80211_sta_register_airtime()
>
> Fixes: b4809e9484da1 ("mac80211: Add airtime accounting and scheduling to=
 TXQs")
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>

Acked-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@toke.dk>

> ---
>  net/mac80211/tx.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/net/mac80211/tx.c b/net/mac80211/tx.c
> index 56a4d0d20a26..fa69644a14f9 100644
> --- a/net/mac80211/tx.c
> +++ b/net/mac80211/tx.c
> @@ -3836,7 +3836,7 @@ void __ieee80211_schedule_txq(struct ieee80211_hw *=
hw,
>  		 * get immediately moved to the back of the list on the next
>  		 * call to ieee80211_next_txq().
>  		 */
> -		if (txqi->txq.sta &&
> +		if (txqi->txq.sta && local->airtime_flags &&
>  		    wiphy_ext_feature_isset(local->hw.wiphy,
>  					    NL80211_EXT_FEATURE_AIRTIME_FAIRNESS))
>  			list_add(&txqi->schedule_order,
> --=20
> 2.29.2
