Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B36322D4589
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Dec 2020 16:38:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727008AbgLIPhK (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 9 Dec 2020 10:37:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726354AbgLIPhJ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 9 Dec 2020 10:37:09 -0500
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 998A6C0613CF
        for <linux-wireless@vger.kernel.org>; Wed,  9 Dec 2020 07:36:29 -0800 (PST)
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.94)
        (envelope-from <johannes@sipsolutions.net>)
        id 1kn1Vx-005XuP-Ol; Wed, 09 Dec 2020 16:36:25 +0100
Message-ID: <9320c4f30cd3ba67ababf8e245963b656e2bf1ad.camel@sipsolutions.net>
Subject: Re: [RFC] Introduce NL80211_IFTYPE_MLO_LINK_DEVICE for MLO link
 (IEEE 802.11be)
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Sunil Dutt <usdutt@codeaurora.org>
Cc:     linux-wireless@vger.kernel.org
Date:   Wed, 09 Dec 2020 16:36:24 +0100
In-Reply-To: <1607526302-8063-1-git-send-email-usdutt@codeaurora.org>
References: <1607526302-8063-1-git-send-email-usdutt@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-1.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-malware-bazaar: not-scanned
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi,

> Multi-link support is introduced in 802.11be specification.
[...]

I'll definitely have to take a closer look at this and the spec and
think about it - but a couple of quick comments below.

> @@ -3131,6 +3139,7 @@ enum nl80211_iftype {
>  	NL80211_IFTYPE_P2P_DEVICE,
>  	NL80211_IFTYPE_OCB,
>  	NL80211_IFTYPE_NAN,
> +	NL80211_IFTYPE_MLO_LINK_DEVICE,

You'll probably have to update some mac80211 code in this patch to avoid
compiler warnings.
 
> +void cfg80211_stop_mlo_link_device(struct cfg80211_registered_device *rdev,
> +				   struct wireless_dev *wdev)
> +{
> +	ASSERT_RTNL();
> +
> +	if (WARN_ON(wdev->iftype != NL80211_IFTYPE_MLO_LINK_DEVICE))
> +		return;
> +
> +	if (!wdev_running(wdev))
> +		return;
> +
> +	rdev_stop_mlo_link_device(rdev, wdev);
> +	wdev->is_running = false;
> +
> +	rdev->opencount--;
> +
> +	if (rdev->scan_req && rdev->scan_req->wdev == wdev) {
> +		if (WARN_ON(!rdev->scan_req->notified &&
> +			    (!rdev->int_scan_req ||
> +			     !rdev->int_scan_req->notified)))
> +			rdev->scan_req->info.aborted = true;
> +		___cfg80211_scan_done(rdev, false);
> +	}

Does it even make sense to allow scanning on this wdev, rather than on
the normal client interfaces? Perhaps should just not be able to get
there?

> @@ -718,6 +718,7 @@ static const struct nla_policy nl80211_policy[NUM_NL80211_ATTR] = {
>  	[NL80211_ATTR_SAE_PWE] =
>  		NLA_POLICY_RANGE(NLA_U8, NL80211_SAE_PWE_HUNT_AND_PECK,
>  				 NL80211_SAE_PWE_BOTH),
> +	[NL80211_ATTR_MLO_LINK_INFO] = { .type = NLA_NESTED },

That should specify what/how it's nested, using
NLA_POLICY_NESTED_ARRAY() (I think, in this case)

>  	struct sk_buff *msg;
>  	void *hdr;
> +	struct nlattr *nested, *nested_mlo_links;
> +	struct cfg80211_mlo_link_device_params *mlo_link;
> +	int i = 0;
>  
>  	msg = nlmsg_new(100 + cr->req_ie_len + cr->resp_ie_len +
>  			cr->fils.kek_len + cr->fils.pmk_len +
> -			(cr->fils.pmkid ? WLAN_PMKID_LEN : 0), gfp);
> +			(cr->fils.pmkid ? WLAN_PMKID_LEN : 0) +
> +			(cr->n_mlo_links ? cr->n_mlo_links * 32 : 0), gfp);

32 probably should be some NLA_SIZE or something constant?

There's also no point in the ternary operator since 0 * 32 is 0 :)

>  /* Consumes bss object one way or another */
> @@ -833,7 +849,9 @@ void cfg80211_connect_done(struct net_device *dev,
>  	ev = kzalloc(sizeof(*ev) + (params->bssid ? ETH_ALEN : 0) +
>  		     params->req_ie_len + params->resp_ie_len +
>  		     params->fils.kek_len + params->fils.pmk_len +
> -		     (params->fils.pmkid ? WLAN_PMKID_LEN : 0), gfp);
> +		     (params->fils.pmkid ? WLAN_PMKID_LEN : 0) +
> +		     (params->n_mlo_links ? params->n_mlo_links *
> +		      sizeof(struct cfg80211_mlo_link_device_params) : 0), gfp);

same here, no need for the ternary


It feels strangely asymmetric to have stop and no start ... but I guess
that's the part where I need to think about it and look a bit at how it
all works :)

johannes

