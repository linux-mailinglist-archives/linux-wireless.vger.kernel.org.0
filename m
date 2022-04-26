Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1FD250F200
	for <lists+linux-wireless@lfdr.de>; Tue, 26 Apr 2022 09:16:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243052AbiDZHTl (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 26 Apr 2022 03:19:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234483AbiDZHTj (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 26 Apr 2022 03:19:39 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 752527DE31
        for <linux-wireless@vger.kernel.org>; Tue, 26 Apr 2022 00:16:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        Content-Type:References:In-Reply-To:Date:To:From:Subject:Message-ID:Sender:
        Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=WUFsiz+uwy93ccSrBFza2FYOWtHTR6UGA+NZTqUG9ok=;
        t=1650957392; x=1652166992; b=NlOo4SfXAlAGqYzqszdGwXEF9XJL81afUH+sDYMj+LC+EMb
        4pPNz7bjoe39YCklXiRzmkeWmuN4T1AdD2W//nb5yn+kqRsypOCen0IiX17smxGCwBmUwjYWOGTeb
        LcOgz0+F8Mji7R3DEloxZoagDibXtgY1lOHkHMSFx7Yr546Usq1eKs9Q4F6VuYXiEhCndB27qe1jC
        vRdyk8FoXi46zjSYZxLZStA0YQ7xZAWB5CTWWFU9d4+FJP101/X6vFEMV3d/owZy0RmofUSap/4mp
        5ADuHhCnzXDik6kNZZJTReKrHsQAu7PIM84fcpGaucOeVgifhzzQwXs4oUuiyvUA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.95)
        (envelope-from <johannes@sipsolutions.net>)
        id 1njFQz-00FCrH-J5;
        Tue, 26 Apr 2022 09:16:29 +0200
Message-ID: <6b40798e349d11e495a6df20ecba479a8357dad2.camel@sipsolutions.net>
Subject: Re: [RFC PATCH] cfg80211: do some rework towards MLO link APIs
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Vasanthakumar Thiagarajan <quic_vthiagar@quicinc.com>,
        linux-wireless@vger.kernel.org
Date:   Tue, 26 Apr 2022 09:16:28 +0200
In-Reply-To: <f137ca7f-8b59-3368-c666-247f83d80383@quicinc.com>
References: <20220414145522.116716-1-johannes@sipsolutions.net>
         <f137ca7f-8b59-3368-c666-247f83d80383@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 (3.42.4-2.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-malware-bazaar: not-scanned
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

> 
> Thanks! At high level, we are fine with this approach. 
> 

:)

> As discussed,
> we need to have a mechanism to be able to set link specific 
> configurations such as link STA mac addr before assoc in STA mode.

Right.

> The proposal to have some sort of mapping between local and OTA link 
> will work. So in AP mode, it is OTA link_id but in STA mode, it is local 
> link_id which does not change the life time of the STA link
> interface? Will that be still called link_id or something which means 
> pseudo link_id (something like link_idx?) to avoid confusions with
> OTA link_id?

I started calling it link_num later, but that might also be confusing
and misinterpreted as num_links or so? ...

> With a single netdev for MLD interface, we may need to add NL options
> (in NL80211_CMD_SET_INTERFACE?) to set the link mac addr in both AP and 
> STA mode? Also, interface to report the mac addresses of all interfaces 
> to the user space in NL80211_CMD_NEW_INTERFACE event.

Right, we need to report multi-link stuff in a lot of places, inside the
LINKS attribute I guess.

I thought setting the address would be good enough when we create a
link, but maybe we need to be able to change it too, dunno. Not my
highest priority :)

> I assume link_id will be added in NL80211_CMD_FRAME command/event as 
> well for the application to identify the link on which the frame
> is-received/to-be-transmitted?

Good point, I guess we need that.

>  >   	/* currently used for IBSS and SME - might be rearranged later */
>  > +	// FIXME: move SSID to link?
> 
> It seems all the links affiliated to an MLD should have the same SSID,
> may be SSID is not link specific?

Yeah you mentioned this to me elsewhere - you're right. I got confused
about MBSSID APs. I also made it so for MLD the NL80211_ATTR_SSID
attribute is now required in AP mode.

>  > @@ -4669,8 +4709,12 @@ static int nl80211_set_mac_acl(struct sk_buff 
> *skb, struct genl_info *info)
>  >   	    dev->ieee80211_ptr->iftype != NL80211_IFTYPE_P2P_GO)
>  >   		return -EOPNOTSUPP;
>  >
>  > -	if (!dev->ieee80211_ptr->beacon_interval)
>  > -		return -EINVAL;
>  > +// FIXME: do we consider this to be on the MLD? I guess so?
>  > +//	  then what about legacy stations? or should we have
>  > +//	  ACL on each link? seems odd ...
> 
> I think it makes sense to have this for MLD rather than individual link
> interfaces, it is unlikely to have different policies for link and MLD
> interfaces in terms of blocking/allowing a particular station mac.

Agree. Also implementations are unlikely to want different tables for
different links, unless they're different NICs like in some of your use
cases, but copying the same table over to each is always possible.

>  > @@ -5785,12 +5837,18 @@ static int nl80211_start_ap(struct sk_buff 
> *skb, struct genl_info *info)
>  >   	else if (info->attrs[NL80211_ATTR_EXTERNAL_AUTH_SUPPORT])
>  >   		params->flags |= NL80211_AP_SETTINGS_EXTERNAL_AUTH_SUPPORT;
>  >
>  > +	/* FIXME: check that SSID(len) didn't change!
>  > +	 * or - ugh - can it? what about multi-BSSID
>  > +	 * where the transmitting BSSID/SSID might be
>  > +	 * different on different links?
>  > +	 */
> 
> May be this is not an issue? With mBSSID, start_ap will be called for 
> each BSS part of the mBSSID group. Configurations like SSID will be for 
> that particular BSS irrespective of whether that is transmitting or 
> non-transmitting BSS.

Yep, I got confused, thanks.

>  > +	if (internal_flags & NL80211_FLAG_MLO_VALID_LINK_ID) {
>  > +		struct nlattr *link_id = info->attrs[NL80211_ATTR_MLO_LINK_ID];

[...]
>  > +		/* non-MLO -> no link ID attribute accepted */
>  > +		if (!wdev->valid_links && link_id) {
> 
> Isn't that we hit this condition when adding the very first link to the 
> MLD using NL80211_CMD_ADD_LINK?
> 

Oh, I don't think CMD_ADD_LINK would set NL80211_FLAG_MLO_VALID_LINK_ID,
that's just helper functionality for those commands that expect
everything to already be set up.

johannes
