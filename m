Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4DBB4FC0CB
	for <lists+linux-wireless@lfdr.de>; Thu, 14 Nov 2019 08:32:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725920AbfKNHcp (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 14 Nov 2019 02:32:45 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:45706 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725838AbfKNHcp (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 14 Nov 2019 02:32:45 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 7E2DD60A66; Thu, 14 Nov 2019 07:32:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1573716764;
        bh=OiCfWYpdSOB2oNC2Sz3z1EVbqnvrCDY9s3QTuWIYrtA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=PcVkktCf3jtrm4bVVE5wfG6leGy4e7La9BfYeqN9hiXrIfDdt4l4GcVf6pJ+31yKX
         PRj90jmkzJCXZisoRvla77IHkyB9ofwNyBhIpw17kn9YpWStnK01TkmKo6ozquTd8C
         lVZfmZhZBV0tLjO+n175qxfjVRUYxVD18a7FCLx8=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_INVALID,DKIM_SIGNED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id 168A66087F;
        Thu, 14 Nov 2019 07:32:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1573716764;
        bh=OiCfWYpdSOB2oNC2Sz3z1EVbqnvrCDY9s3QTuWIYrtA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=PcVkktCf3jtrm4bVVE5wfG6leGy4e7La9BfYeqN9hiXrIfDdt4l4GcVf6pJ+31yKX
         PRj90jmkzJCXZisoRvla77IHkyB9ofwNyBhIpw17kn9YpWStnK01TkmKo6ozquTd8C
         lVZfmZhZBV0tLjO+n175qxfjVRUYxVD18a7FCLx8=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Thu, 14 Nov 2019 13:02:44 +0530
From:   Tamizh chelvam <tamizhr@codeaurora.org>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     Sergey Matyukevich <sergey.matyukevich.os@quantenna.com>,
        linux-wireless@vger.kernel.org
Subject: Re: [PATCHv8 0/6] cfg80211/mac80211: Add support for TID specific
 configuration
In-Reply-To: <c95e9e9f5539150459f97f811b784a6e9af163cf.camel@sipsolutions.net>
References: <1572957714-16085-1-git-send-email-tamizhr@codeaurora.org>
 <20191108093207.uv4j44xpm2qvtsv5@bars>
 <84ca3a8b61757360ab9898afcdd3f2f63c770f86.camel@sipsolutions.net>
 <20191108120504.ptl25hacxcftb7tw@bars>
 <1c553c457024b295c7d0a6b118c3848eec28bcbd.camel@sipsolutions.net>
 <20191108160121.tbatmqwx64aoqqai@bars>
 <c95e9e9f5539150459f97f811b784a6e9af163cf.camel@sipsolutions.net>
Message-ID: <b70dd0ab69f968366d7cb836d2b880bc@codeaurora.org>
X-Sender: tamizhr@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 2019-11-08 22:37, Johannes Berg wrote:
> On Fri, 2019-11-08 at 16:01 +0000, Sergey Matyukevich wrote:
> 
>> > I think we still need NL80211_TID_CONFIG_ATTR_OVERRIDE in some way
>> > (maybe only as a flag attribute), since you could have
>> >
>> >  * change all stations (some subset of TIDs) *including* already
>> >    configured stations
>> >  * or *excluding* already configured stations
>> 
>> Hmmm... Logic is straightforwad without this flag:
>> - settings are applied to bitmasked TIDs of a single peer if address 
>> is specifed
>> - settings are applied to bitmasked TIDs of all the peers if no 
>> address is specified
> 
> Sure, this is obvious, but what exactly does "all the peers" mean?
> 
> Say I do
> 
> set_tid_config(tids=0x1, peer=02:11:22:33:44:55, noack=yes)
> set_tid_config(tids=0x1, peer=NULL, noack=no)
> 
> Does that reset peer 02:11:22:33:44:55, or not? This is not documented
> right now, and one could argue both ways - the override for that
> particular peer should stick, or should be removed. Which one is it?
> 
Here, the second command won't reset the peer 02:11:22:33:44:55. Here we 
are giving more
preference to the peer specific configuration. We have to reset the peer 
02:11:22:33:44:55 using the set_tid_config(tids=0x1, 
peer=02:11:22:33:44:55, DEFAULT). I will add these in the DOC section 
and send it in next patchset.

>> It looks like you want to infer too much from a single flag. Why keep 
>> this logic in
>> cfg80211/mac80211/driver ?
> 
> I just want to disambiguate what "all the peers" means. Not sure what
> you mean by keeping the logic?
> 

Thanks,
Tamizh.
