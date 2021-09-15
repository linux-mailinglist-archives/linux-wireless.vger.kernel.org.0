Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0B2540C3EB
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Sep 2021 12:46:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232642AbhIOKsR (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 15 Sep 2021 06:48:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232291AbhIOKsQ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 15 Sep 2021 06:48:16 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14958C061574
        for <linux-wireless@vger.kernel.org>; Wed, 15 Sep 2021 03:46:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=aQUccrzd3OWRqbsr231nUg88RRWJqwyyQiOH9qmiKTc=;
        t=1631702818; x=1632912418; b=q4tCM+GuUbwCD/LEGaqYhUPQf0qtgDWODQfBmbIeZTlEBUF
        BBPS/lGpmoQYpifyrN2zTfCsLb3Vrh5U7OWpHgict07UbglWGR+5Z592zF9OV2r6ZNR9PgD5FyubG
        alMCjmIqzKlyTw+uMJZa9Vk3JV4dYP/aa68VbE63zxm54/awk/tVG1VGON5krcfKc3/ceLZvORQgz
        o0djzRD42AvJSc1v1cRJNieyf8tRpEhrN+KJPfDNg5d4rbFNo8Oo5rEJRpNAi52XZgN4ZRfp5lKEi
        sonVOCFa+dfi16VG939IlJJLphELNMC+MR8JfmQw7uIlstgMtNV5F3qONsCwgoUA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.95-RC2)
        (envelope-from <johannes@sipsolutions.net>)
        id 1mQSRL-007G44-P2;
        Wed, 15 Sep 2021 12:46:55 +0200
Message-ID: <9d1465d5756c81e3ac1fa6e2f0c761036b9d9edf.camel@sipsolutions.net>
Subject: Re: [PATCH v11 1/4] nl80211: MBSSID and EMA support in AP mode
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Aloka Dixit <alokad@codeaurora.org>
Cc:     linux-wireless@vger.kernel.org
Date:   Wed, 15 Sep 2021 12:46:54 +0200
In-Reply-To: <a1d3ea130c11902bd772535eadd0ef47@codeaurora.org>
References: <20210715070745.5033-1-alokad@codeaurora.org>
         <20210715070745.5033-2-alokad@codeaurora.org>
         <46cbed48d41a7200cec3d7428abe7bc6746e14fe.camel@sipsolutions.net>
         <a1d3ea130c11902bd772535eadd0ef47@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.4 (3.38.4-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-malware-bazaar: not-scanned
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Tue, 2021-09-14 at 21:00 -0700, Aloka Dixit wrote:
> > 
> > > +	if (tb[NL80211_MBSSID_CONFIG_ATTR_TRANSMITTING_IFINDEX]) {
> > > +		tx_ifindex =
> > > +			nla_get_u32(tb[NL80211_MBSSID_CONFIG_ATTR_TRANSMITTING_IFINDEX]);
> > > +
> > > +		if (!config->index && tx_ifindex != dev->ifindex)
> > > +			return -EINVAL;
> > > +
> > > +		tx_dev = __dev_get_by_index(wiphy_net(wiphy), tx_ifindex);
> > 
> > Here you try to look up the other transmitting device, and use
> > __dev_get_by_index() for that - but we don't hold any relevant lock
> > here!
> > 
> > This is (only) called from nl80211_start_ap(), which doesn't hold the
> > RTNL since commit a05829a7222e ("cfg80211: avoid holding the RTNL when
> > calling the driver"):
> > 
> >         {
> >                 .cmd = NL80211_CMD_START_AP,
> >                 .validate = GENL_DONT_VALIDATE_STRICT | 
> > GENL_DONT_VALIDATE_DUMP,
> >                 .flags = GENL_UNS_ADMIN_PERM,
> >                 .doit = nl80211_start_ap,
> > -               .internal_flags = NL80211_FLAG_NEED_NETDEV_UP |
> > -                                 NL80211_FLAG_NEED_RTNL,
> > +               .internal_flags = NL80211_FLAG_NEED_NETDEV_UP,
> >         },
> > 
> > 
> > I'd fix this, but it's not really trivial - we'd need to use
> > dev_get_by_index() and ensure we dev_put() appropriately, but *only* if
> > it's different from the original dev ... could probably do that in this
> > function.
> > 
> > All told though this doesn't make me really very confident you tested
> > this recently, seems like something would've complained here?
> > 
> 
> I tested a flavored version, testing without that this time.
> 
> Other instances of calls to __dev_get_by_index() which don't already 
> hold
> RTNL explicitly call rtnl_lock()/unlock().
> 
> Is it okay to do same here?
> 
I don't think so, we're holding other locks, so that would create an
ABBA deadlock - sometimes we do take RTNL->wiphy_mutex, but here you'd
end up doing the opposite.

But why not just use dev_get_by_index()?

> Regarding the reference, I will call dev_hold() before assigning the 
> value
> to 'tx_dev' pointer if different than the current net_device,
> and dev_put() after the processing is done.

Then you also don't need dev_hold(), since that's implied by
dev_get_by_index()?

An example in nl80211 would be get_vlan().

johannes

