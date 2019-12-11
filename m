Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6997311BF39
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Dec 2019 22:32:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726608AbfLKVcP (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 11 Dec 2019 16:32:15 -0500
Received: from s3.sipsolutions.net ([144.76.43.62]:41460 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726141AbfLKVcO (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 11 Dec 2019 16:32:14 -0500
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.92.3)
        (envelope-from <johannes@sipsolutions.net>)
        id 1if9ad-0057D1-RR; Wed, 11 Dec 2019 22:32:11 +0100
Message-ID: <52c69792616cbf2fba7e59e25fb14cff3fc8d2db.camel@sipsolutions.net>
Subject: Re: [RFC PATCH v1 4/4] nl80211: Allow deleting stations in ibss
 mode to reset their state.
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Nicolas Cavallari <nicolas.cavallari@green-communications.fr>,
        Krzysztof =?UTF-8?Q?Ha=C5=82asa?= <khalasa@piap.pl>
Cc:     linux-wireless@vger.kernel.org, Kalle Valo <kvalo@codeaurora.org>
Date:   Wed, 11 Dec 2019 22:32:10 +0100
In-Reply-To: <20191209102808.12014-5-nicolas.cavallari@green-communications.fr>
References: <m34l02mh71.fsf@t19.piap.pl>
         <20191209102808.12014-5-nicolas.cavallari@green-communications.fr>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.2 (3.34.2-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Mon, 2019-12-09 at 11:28 +0100, Nicolas Cavallari wrote:
> 
> diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
> index da5262b2298b..82046c990a2a 100644
> --- a/net/wireless/nl80211.c
> +++ b/net/wireless/nl80211.c
> @@ -6073,7 +6073,8 @@ static int nl80211_del_station(struct sk_buff *skb, struct genl_info *info)
>  	if (dev->ieee80211_ptr->iftype != NL80211_IFTYPE_AP &&
>  	    dev->ieee80211_ptr->iftype != NL80211_IFTYPE_AP_VLAN &&
>  	    dev->ieee80211_ptr->iftype != NL80211_IFTYPE_MESH_POINT &&
> -	    dev->ieee80211_ptr->iftype != NL80211_IFTYPE_P2P_GO)
> +	    dev->ieee80211_ptr->iftype != NL80211_IFTYPE_P2P_GO &&
> +	    dev->ieee80211_ptr->iftype != NL80211_IFTYPE_ADHOC)
>  		return -EINVAL;

If we go this route (and I'm not sure, shouldn't be _that_ hard to do
some kind of auth/deauth thing?) then you probably should make this
depend on an nl80211 extended feature bit.

That way, not only do you get visibility in userspace whether it's
supported, but also avoid the need to change those non-mac80211 drivers
(by having only mac80211 set the extended feature)

johannes

