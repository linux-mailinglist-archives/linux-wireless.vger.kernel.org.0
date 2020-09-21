Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41605271B34
	for <lists+linux-wireless@lfdr.de>; Mon, 21 Sep 2020 09:01:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726384AbgIUHBt (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 21 Sep 2020 03:01:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726011AbgIUHBs (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 21 Sep 2020 03:01:48 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0CB3C061755
        for <linux-wireless@vger.kernel.org>; Mon, 21 Sep 2020 00:01:48 -0700 (PDT)
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.94)
        (envelope-from <johannes@sipsolutions.net>)
        id 1kKFpb-0084OK-4X; Mon, 21 Sep 2020 09:01:47 +0200
Message-ID: <cb2cf1d923975b0115866b5e92efd91950a1b56d.camel@sipsolutions.net>
Subject: Re: [PATCH v2 06/22] {cfg,mac}80211: get correct default channel
 width for S1G
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Thomas Pedersen <thomas@adapt-ip.com>
Cc:     linux-wireless <linux-wireless@vger.kernel.org>
Date:   Mon, 21 Sep 2020 09:01:46 +0200
In-Reply-To: <18730e757068a05f6531ea204791eae8@adapt-ip.com>
References: <20200831205600.21058-1-thomas@adapt-ip.com>
         <20200831205600.21058-7-thomas@adapt-ip.com>
         <c5b93cd207ce780a56ad2689d7660fee48683fe9.camel@sipsolutions.net>
         <18730e757068a05f6531ea204791eae8@adapt-ip.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-1.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Sun, 2020-09-20 at 21:59 -0700, Thomas Pedersen wrote:
> 
> >         default:
> >                 /* fall back to 20 MHz for unsupported modes */
> >                 cfg80211_chandef_create(&chandef, cbss->channel,
> >                                         NL80211_CHAN_NO_HT);
> 
> Yes, but then what would we pass to cfg80211_chandef_create()? 

I'd say we just shouldn't call it if there's a chance that it's an S1G
channel?

> We should
> probably avoid adding an additional NL80211_CHAN_S1G if enum
> nl80211_channel_type is legacy.

Agree.

> It seems like NL80211_CHAN_NO_HT is often used as "give me the default
> channel width".  See cfg80211_get_chandef_type() when it throws up its 
> hands
> and returns NL80211_CHAN_NO_HT when encountering an unknown 
> chandef->width.
> Also IBSS passes NL80211_CHAN_NO_HT when the BSS is actually 5 or 10MHz.

Yeah, agree it's a bit of a mess, but I'm not really in favour of
keeping that mess :)

Also, that's a WARN_ON() there, so the NL80211_CHAN_NO_HT isn't meant to
be anything *valid* in that case, just a value that doesn't cause
crashes or other bad behaviour further down the road if we hit that
path.

> Maybe (instead of adding a new nl80211_channel_type)
> cfg80211_chandef_create() throws a warning if anything but 
> NL80211_CHAN_NO_HT
> is passed with an S1G frequency?

I'd literally just add

	cfg80211_chandef_create_s1g()

and just not have the argument at all? Or just fill the chandef
manually, but of course that's a bit tedious sometimes.

> > IOW, it seems to me that this function should actually instead throw a
> > warning (and then perhaps configure something sane?), but not be the
> > default code path.
> 
> Yes, but I'd also like to avoid making the caller worry about the value 
> of a parameter which only exists for HT reasons (?).

It mostly isn't even for HT reasons ... for HT, we could perfectly well
fill the chandef directly, and do in many cases.

johannes

