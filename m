Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 303695630CC
	for <lists+linux-wireless@lfdr.de>; Fri,  1 Jul 2022 11:58:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236178AbiGAJ6S (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 1 Jul 2022 05:58:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235928AbiGAJ6Q (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 1 Jul 2022 05:58:16 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53643D58
        for <linux-wireless@vger.kernel.org>; Fri,  1 Jul 2022 02:58:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=2TQVqnYl0YCDnqjTLC+OZA3Hb/N8rBlaMJVrfsItu0c=;
        t=1656669494; x=1657879094; b=ae4OAyejIqhHiIR983ailkMww2u4jQ99H/0BK2D7gt2x5AR
        McXV8G14Xk8YTfxr0GpRUyK5t2qU7zlzSS+eaL4Msl8XHlT0eTUYHDyQLeMDWcDACpiD49/oUoCeh
        P0gug9OkbIMV1HDwXKEg7LbjDu831yOj/eRke/IuCQus5T4Xw55gS5yMS3mKSXQEy/yy4/YTZtn+c
        DGNMCz/ZAJSFtGz9Jo3Jw6zE6PoL69j6xmL/whT6jSU/FddzSPtZBScbgECY1aUslMRUfuyyG2Fs2
        tfG/ds9HN8VUqAWnmtH2doqrIm8JEQ1enfC01yzdiQhdcE6roUyIOAtx1d2K/roA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.95)
        (envelope-from <johannes@sipsolutions.net>)
        id 1o7DPg-003QzG-7T;
        Fri, 01 Jul 2022 11:58:12 +0200
Message-ID: <aa0f3770698f4a9a3ec62d7b898838726af4f82e.camel@sipsolutions.net>
Subject: Re: [PATCH] wifi: mac80211: fix get inactive time for station mode
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Issam Hamdi <ih@simonwunderlich.de>
Cc:     linux-wireless@vger.kernel.org, sw@simonwunderlich.de
Date:   Fri, 01 Jul 2022 11:58:11 +0200
In-Reply-To: <20220628150511.1185132-1-ih@simonwunderlich.de>
References: <20220628150511.1185132-1-ih@simonwunderlich.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.2 (3.44.2-1.fc36) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Tue, 2022-06-28 at 17:05 +0200, Issam Hamdi wrote:
> In station mode, the value last_rx is not updated often.
> Therefore the calculation of the inactive time will be wrong (will give
> values between 1000 ms to 30000 ms).
> To fix this add the update of "sta->deflink.rx_stats.last_rx" for
> station mode in the response of the packets process
> (ieee80211_rx_h_sta_process).

Not really sure I understand that.

> +++ b/net/mac80211/rx.c
> @@ -1756,6 +1756,9 @@ ieee80211_rx_h_sta_process(struct ieee80211_rx_data=
 *rx)
>  			sta->deflink.rx_stats.last_rate =3D sta_stats_encode_rate(status);
>  	}
> =20
> +	if (rx->sdata->vif.type =3D=3D NL80211_IFTYPE_STATION)
> +		sta->deflink.rx_stats.last_rx =3D jiffies;

Why the interface type check? It's a per-station thing, so why would it
not apply here for other types?

>  	sinfo->inactive_time =3D
> -		jiffies_to_msecs(jiffies - ieee80211_sta_last_active(sta));
> +		jiffies_to_msecs(abs(jiffies - ieee80211_sta_last_active(sta)));
>=20

That seems ... rather questionable.

johannes
