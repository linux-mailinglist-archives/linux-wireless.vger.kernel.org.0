Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C81AE233273
	for <lists+linux-wireless@lfdr.de>; Thu, 30 Jul 2020 14:55:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726781AbgG3MzO (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 30 Jul 2020 08:55:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726535AbgG3MzN (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 30 Jul 2020 08:55:13 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 814E8C061794
        for <linux-wireless@vger.kernel.org>; Thu, 30 Jul 2020 05:55:13 -0700 (PDT)
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.93)
        (envelope-from <johannes@sipsolutions.net>)
        id 1k185X-00DWzH-PP; Thu, 30 Jul 2020 14:55:11 +0200
Message-ID: <5e0206e79c71ecfeae004dadcebaa44e40d96b8b.camel@sipsolutions.net>
Subject: Re: [PATCH V2 01/10] nl80211: add basic multiple bssid support
From:   Johannes Berg <johannes@sipsolutions.net>
To:     John Crispin <john@phrozen.org>
Cc:     linux-wireless@vger.kernel.org, ath11k@lists.infradead.org
Date:   Thu, 30 Jul 2020 14:55:10 +0200
In-Reply-To: <20200706115219.663650-1-john@phrozen.org>
References: <20200706115219.663650-1-john@phrozen.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.4 (3.36.4-1.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


> +++ b/include/net/cfg80211.h
> @@ -604,6 +604,8 @@ struct vif_params {
>  	u8 macaddr[ETH_ALEN];
>  	const u8 *vht_mumimo_groups;
>  	const u8 *vht_mumimo_follow_addr;
> +	enum nl80211_multi_bssid_mode multi_bssid_mode;
> +	u32 multi_bssid_parent;

Can you put this into a(n anonymous) sub-structure?

This also missed kernel-doc.

>   *	unprotected beacon report
> + * @multi_bssid_mode: Is this a legacy, transmitted or non-transmitted bssid
> + * @multi_bssid_parent: a non-transmitted bssid has a transmitted parent
> + * @multi_bssid_list: linked list for tracking parent - child relations.


FWIW, you can (now?) write

 * @multi_bssid.list: ...

to document data for anonymous sub-structures.

I started applying this and changed it myself, but am having second
thoughts on later patches in this series.

> + * @NL80211_ATTR_MULTI_BSSID_MODE: Set the (Non-)Transmitted flag for this
> + *	BSSIDs beacon.
> + *
> + * @NL80211_ATTR_MULTI_BSSID_PARENT: If this is a Non-Transmitted BSSID, define
> + *	the parent interface.

Maybe clarify

	the parent (transmitted BSSID) interface

or so?

> +/**
> + * enum nl80211_multi_bssid_mode - Multiple BSSID beacon type
> + *
> + * Used by cfg80211_ap_settings

That'd be weird, but it's not true, you have it for
NL80211_ATTR_MULTI_BSSID_MODE. Actually, that documentation should point
here and say the values are from this enum.

> + * @MULTIPLE_BSSID_LEGACY: This BSS is not part of a multiple BSSID group
> + * @MULTIPLE_BSSID_TRANSMITTED: This BSS is broadcasting a multiple BSSID
> + *                                    beacon

Please just use a single tab there :)

> +	[NL80211_ATTR_MULTI_BSSID_MODE] = NLA_POLICY_RANGE(NLA_U8,
> +					NL80211_MULTIPLE_BSSID_LEGACY,
> +					NL80211_MULTIPLE_BSSID_NON_TRANSMITTED),

Maybe nicer as

	[...] = 
		NLA_POLICY_RANGE(...

johannes

