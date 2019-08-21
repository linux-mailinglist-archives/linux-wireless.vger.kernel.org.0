Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1534997358
	for <lists+linux-wireless@lfdr.de>; Wed, 21 Aug 2019 09:28:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727922AbfHUH2i (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 21 Aug 2019 03:28:38 -0400
Received: from s3.sipsolutions.net ([144.76.43.62]:56640 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727063AbfHUH2i (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 21 Aug 2019 03:28:38 -0400
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <johannes@sipsolutions.net>)
        id 1i0L2q-0004S7-Gi; Wed, 21 Aug 2019 09:28:36 +0200
Message-ID: <b97092279b6147af6c9f4366293bc15df2996b86.camel@sipsolutions.net>
Subject: Re: [PATCH] cfg80211: VLAN offload support for set_key and
 set_sta_vlan
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Jouni Malinen <jouni@codeaurora.org>
Cc:     linux-wireless@vger.kernel.org,
        Gurumoorthi Gnanasambandhan <gguru@codeaurora.org>
Date:   Wed, 21 Aug 2019 09:28:35 +0200
In-Reply-To: <20190815133825.8131-1-jouni@codeaurora.org>
References: <20190815133825.8131-1-jouni@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Thu, 2019-08-15 at 16:38 +0300, Jouni Malinen wrote:

> +/**
> + * DOC: VLAN offload support for setting group keys and binding STAs to VLANs
> + *
> + * By setting @NL80211_EXT_FEATURE_VLAN_OFFLOAD flag drivers can indicate they
> + * support offloading VLAN functionality in a manner where the driver exposes a
> + * single netdev that used VLAN tagged frames and separate VLAN-specific netdevs
> + * can then be added using vconfig similarly to the Ethernet case.

I don't think we should be referring to vconfig these days? It's pretty
much a deprecated userspace tool, the kernel would like to think that
all of this is done over netlink with iproute2 now :-)

But even then, it should probably just reference the kernel mechanisms
(creating a VLAN netdev) than the userspace implementation thereof
(vconfig or iproute2).

Something that's not quite clear to me - I think we support some frames
on the AP interface even when VLANs are in use. Would the tagged AP/VLAN
interface actually support untagged frames, and then in what way? I
think it'd be good to specify that here.


> + * %NL80211_CMD_NEW_KEY and %NL80211_CMD_SET_STATION will optionally specify
> + * vlan_id using NL80211_ATTR_VLAN_ID.

Guess that should be %NL80211_ATTR_VLAN_ID too.

> +	[NL80211_ATTR_VLAN_ID] = { .type = NLA_U16 },

That should probably have a range, VLAN IDs can only be 1-4094 since
there's only a 12-bit field and all-0/all-1 are reserved.

Saves us from having to check it in the drivers later on, since they'd
otherwise generate invalid (or confusing) frames if there's no check.
 
>  /* policy for the key attributes */
> @@ -3865,6 +3866,9 @@ static int nl80211_new_key(struct sk_buff *skb, struct genl_info *info)
>  	if (info->attrs[NL80211_ATTR_MAC])
>  		mac_addr = nla_data(info->attrs[NL80211_ATTR_MAC]);
>  
> +	if (info->attrs[NL80211_ATTR_VLAN_ID])
> +		key.p.vlan_id = nla_get_u16(info->attrs[NL80211_ATTR_VLAN_ID]);

Seems like there probably should be some kind of check on what type of
key can set a VLAN ID?

>  	if (key.type == -1) {
>  		if (mac_addr)
>  			key.type = NL80211_KEYTYPE_PAIRWISE;
> @@ -5647,6 +5651,9 @@ static int nl80211_set_station(struct sk_buff *skb, struct genl_info *info)
>  	if (info->attrs[NL80211_ATTR_STA_AID])
>  		params.aid = nla_get_u16(info->attrs[NL80211_ATTR_STA_AID]);
>  
> +	if (info->attrs[NL80211_ATTR_VLAN_ID])
> +		params.vlan_id = nla_get_u16(info->attrs[NL80211_ATTR_VLAN_ID]);

How about nl80211_new_station()? Also, should it really be allowed to
change this at will? I'm not sure we allow changing the VLAN netdev (if
used) at will?

johannes

