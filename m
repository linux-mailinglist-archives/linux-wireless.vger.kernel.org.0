Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A1C6A1C51C
	for <lists+linux-wireless@lfdr.de>; Tue, 14 May 2019 10:39:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726143AbfENIjC (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 14 May 2019 04:39:02 -0400
Received: from s3.sipsolutions.net ([144.76.43.62]:39852 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725985AbfENIjC (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 14 May 2019 04:39:02 -0400
Received: by sipsolutions.net with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <johannes@sipsolutions.net>)
        id 1hQSxh-0006YZ-0N; Tue, 14 May 2019 10:39:01 +0200
Message-ID: <fd3addc01fc3f5362dba5771ee82659cf01c195b.camel@sipsolutions.net>
Subject: Re: [PATCH v3] {nl,mac}80211: allow 4addr AP operation on crypto
 controlled devices
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Manikanta Pubbisetty <mpubbise@codeaurora.org>
Cc:     linux-wireless@vger.kernel.org
Date:   Tue, 14 May 2019 10:38:59 +0200
In-Reply-To: <1557307533-5795-1-git-send-email-mpubbise@codeaurora.org>
References: <1557307533-5795-1-git-send-email-mpubbise@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-2.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Wed, 2019-05-08 at 14:55 +0530, Manikanta Pubbisetty wrote:
> 
> +++ b/net/mac80211/util.c
> @@ -3795,7 +3795,9 @@ int ieee80211_check_combinations(struct ieee80211_sub_if_data *sdata,
>  	}
>  
>  	/* Always allow software iftypes */
> -	if (local->hw.wiphy->software_iftypes & BIT(iftype)) {
> +	if (local->hw.wiphy->software_iftypes & BIT(iftype) ||
> +	    (iftype == NL80211_IFTYPE_AP_VLAN &&
> +	     local->hw.wiphy->flags & WIPHY_FLAG_4ADDR_AP)) {
>  		if (radar_detect)
>  			return -EINVAL;

Shouldn't this check if 4addr is actually enabled too, like here:

>  	case NETDEV_PRE_UP:
> -		if (!(wdev->wiphy->interface_modes & BIT(wdev->iftype)))
> +		if (!(wdev->wiphy->interface_modes & BIT(wdev->iftype)) &&
> +		    !(wdev->iftype == NL80211_IFTYPE_AP_VLAN &&
> +		      rdev->wiphy.flags & WIPHY_FLAG_4ADDR_AP &&
> +		      wdev->use_4addr))
>  			return notifier_from_errno(-EOPNOTSUPP);

?
Or is there some reason it doesn't matter?

> @@ -3439,6 +3438,11 @@ static int nl80211_new_interface(struct sk_buff *skb, struct genl_info *info)
>  			return err;
>  	}
>  
> +	if (!(rdev->wiphy.interface_modes & (1 << type)) &&
> +	    !(type == NL80211_IFTYPE_AP_VLAN && params.use_4addr &&
> +	      rdev->wiphy.flags & WIPHY_FLAG_4ADDR_AP))
> +		return -EOPNOTSUPP;
> +

I also wonder if we shouldn't go "all in" and actually make the check
something like

  check_interface_allowed(iftype, 4addr):
    if (iftype == AP_VLAN && 4addr)
      return wiphy.flags & WIPHY_FLAG_4ADDR_AP;

    else return wiphy.interface_modes & BIT(iftype);

i.e. make it "you must have WIPHY_FLAG_4ADDR_AP to use 4-addr AP_VLAN
interfaces", rather than "also allow it in this case".

That would seem like the clearer semantics to me?

johannes

