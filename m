Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE51A272C09
	for <lists+linux-wireless@lfdr.de>; Mon, 21 Sep 2020 18:26:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728173AbgIUQ0s (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 21 Sep 2020 12:26:48 -0400
Received: from mail.adapt-ip.com ([173.164.178.19]:52942 "EHLO
        web.adapt-ip.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726795AbgIUQ0p (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 21 Sep 2020 12:26:45 -0400
Received: from localhost (localhost [127.0.0.1])
        by web.adapt-ip.com (Postfix) with ESMTP id 32F904F9DAF;
        Mon, 21 Sep 2020 16:26:44 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at web.adapt-ip.com
Received: from web.adapt-ip.com ([127.0.0.1])
        by localhost (web.adapt-ip.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id D3anzeBd18cg; Mon, 21 Sep 2020 16:26:41 +0000 (UTC)
Received: from mail.ibsgaard.io (c-73-223-60-234.hsd1.ca.comcast.net [73.223.60.234])
        (Authenticated sender: thomas@adapt-ip.com)
        by web.adapt-ip.com (Postfix) with ESMTPSA id 2C3344F9DAE;
        Mon, 21 Sep 2020 16:26:41 +0000 (UTC)
MIME-Version: 1.0
Date:   Mon, 21 Sep 2020 09:26:40 -0700
From:   Thomas Pedersen <thomas@adapt-ip.com>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH v2 06/22] {cfg,mac}80211: get correct default channel
 width for S1G
In-Reply-To: <cb2cf1d923975b0115866b5e92efd91950a1b56d.camel@sipsolutions.net>
References: <20200831205600.21058-1-thomas@adapt-ip.com>
 <20200831205600.21058-7-thomas@adapt-ip.com>
 <c5b93cd207ce780a56ad2689d7660fee48683fe9.camel@sipsolutions.net>
 <18730e757068a05f6531ea204791eae8@adapt-ip.com>
 <cb2cf1d923975b0115866b5e92efd91950a1b56d.camel@sipsolutions.net>
User-Agent: Roundcube Webmail/1.4.7
Message-ID: <8d24ea208788ac4dbd63f86bd1ee6eab@adapt-ip.com>
X-Sender: thomas@adapt-ip.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 2020-09-21 00:01, Johannes Berg wrote:
> On Sun, 2020-09-20 at 21:59 -0700, Thomas Pedersen wrote:
>> 
>> >         default:
>> >                 /* fall back to 20 MHz for unsupported modes */
>> >                 cfg80211_chandef_create(&chandef, cbss->channel,
>> >                                         NL80211_CHAN_NO_HT);
>> 
>> Yes, but then what would we pass to cfg80211_chandef_create()?
> 
> I'd say we just shouldn't call it if there's a chance that it's an S1G
> channel?
> 
>> We should
>> probably avoid adding an additional NL80211_CHAN_S1G if enum
>> nl80211_channel_type is legacy.
> 
> Agree.
> 
>> It seems like NL80211_CHAN_NO_HT is often used as "give me the default
>> channel width".  See cfg80211_get_chandef_type() when it throws up its
>> hands
>> and returns NL80211_CHAN_NO_HT when encountering an unknown
>> chandef->width.
>> Also IBSS passes NL80211_CHAN_NO_HT when the BSS is actually 5 or 
>> 10MHz.
> 
> Yeah, agree it's a bit of a mess, but I'm not really in favour of
> keeping that mess :)
> 
> Also, that's a WARN_ON() there, so the NL80211_CHAN_NO_HT isn't meant 
> to
> be anything *valid* in that case, just a value that doesn't cause
> crashes or other bad behaviour further down the road if we hit that
> path.
> 
>> Maybe (instead of adding a new nl80211_channel_type)
>> cfg80211_chandef_create() throws a warning if anything but
>> NL80211_CHAN_NO_HT
>> is passed with an S1G frequency?
> 
> I'd literally just add
> 
> 	cfg80211_chandef_create_s1g()
> 
> and just not have the argument at all? Or just fill the chandef
> manually, but of course that's a bit tedious sometimes.

Then the caller has to make the determination which function to call 
based on the chan->band, but we've told the function implicitly by 
passing chan. It doesn't make sense to me to push that complexity onto 
the caller.

That said, it actually looks like cfg80211_chandef_create() is only 
called when a chantype is passed to nl80211 (legacy), in DFS, or HT.

After removing this hunk the S1G tests still pass, so how about we just 
drop it :)

>> > IOW, it seems to me that this function should actually instead throw a
>> > warning (and then perhaps configure something sane?), but not be the
>> > default code path.
>> 
>> Yes, but I'd also like to avoid making the caller worry about the 
>> value
>> of a parameter which only exists for HT reasons (?).
> 
> It mostly isn't even for HT reasons ... for HT, we could perfectly well
> fill the chandef directly, and do in many cases.
> 
> johannes

-- 
thomas
