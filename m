Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9212373A66E
	for <lists+linux-wireless@lfdr.de>; Thu, 22 Jun 2023 18:50:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230266AbjFVQuq (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 22 Jun 2023 12:50:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230129AbjFVQuo (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 22 Jun 2023 12:50:44 -0400
Received: from nbd.name (nbd.name [46.4.11.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B981D10A
        for <linux-wireless@vger.kernel.org>; Thu, 22 Jun 2023 09:50:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
        s=20160729; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:Subject:From
        :References:To:MIME-Version:Date:Message-ID:Sender:Reply-To:Cc:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=eWqBmZ92UCAhXMtmI+rt+smfB+ZxymRXaiXuJ664vdQ=; b=ZuH/rYIrlAkgFJH3R/SJBO2gui
        ziPUOuGcTCASZeUHClsK3QaMJXAZMqn/mKbEIJ4QpVkmGAx0E9/MWLXq8OQ7Co4gYzNBUSNLLZ8EV
        OwOwr2wnP+VlV+N3OhWSehg91g1Hv/YFkcSAmlkkFwtQ9WmhqenNmpYX+YLIbNY06Z9g=;
Received: from p4ff133b9.dip0.t-ipconnect.de ([79.241.51.185] helo=nf.local)
        by ds12 with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <nbd@nbd.name>)
        id 1qCNW4-008vlT-Oe; Thu, 22 Jun 2023 18:50:40 +0200
Message-ID: <14bd0b06-d8c1-5c02-42a6-0c8d045b93ff@nbd.name>
Date:   Thu, 22 Jun 2023 18:50:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Content-Language: en-US
To:     Johannes Berg <johannes@sipsolutions.net>,
        linux-wireless@vger.kernel.org
References: <20230622160501.40666-1-nbd@nbd.name>
 <adf8c1b8ea96c0c6ddc12579eacb8d9948440dcf.camel@sipsolutions.net>
 <2815ff55-5b5d-1412-5694-7692337bc473@nbd.name>
 <f717c60c24bf3dcec7cd3b0308c6bd804683276a.camel@sipsolutions.net>
From:   Felix Fietkau <nbd@nbd.name>
Subject: Re: [PATCH] cfg80211: fix sband iftype data lookup for AP_VLAN
In-Reply-To: <f717c60c24bf3dcec7cd3b0308c6bd804683276a.camel@sipsolutions.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 22.06.23 18:41, Johannes Berg wrote:
> On Thu, 2023-06-22 at 18:25 +0200, Felix Fietkau wrote:
>> On 22.06.23 18:07, Johannes Berg wrote:
>> > On Thu, 2023-06-22 at 18:05 +0200, Felix Fietkau wrote:
>> > > Since AP_VLAN interfaces are not pushed to the driver, 
>> > > 
>> > That's a mac80211 thing though.
>> > 
>> > > the driver should not
>> > > be expected to register iftype data for them.
>> > > Map them to the regular AP iftype on lookup.
>> > 
>> > And this is in cfg80211 - not sure that seems right?
>> > 
>> > OTOH I'd expect no callers with VLAN here, it doesn't really make sense
>> > since they're not a standalone mode that actually has HE/EHT, but still,
>> > seems odd this way?
>> > 
>> > What's actually calling it? I'm guessing somewhere in mac80211?
>> 
>> Yes, I guess only mac80211 is affected. I put in the cfg80211 prefix
>> because that's what the header file belongs to.
>> 
>> I made the patch in response to this:
>> https://patchwork.kernel.org/project/linux-wireless/patch/20230605152141.17434-4-shayne.chen@mediatek.com/
> 
> OK, sure, that also doesn't really make sense.
> 
>> I found that there are several calls to ieee80211_get_he_iftype_cap and
>> ieee80211_get_eht_iftype_cap, which could be affected by this issue.
>> I thought dealing with this in a single place would be better than playing
>> whac-a-mole by fixing it at the call sites.
>> 
> 
> I replaced almost all of them with ieee80211_get_he_iftype_cap_vif() so
> it shouldn't be that bad? Looks like I forgot some though.

I guess one advantage in using my fix would be that it's way easier to 
backport.
How about using my fix initially (with a changed prefix if you prefer), 
and then replace it once the call sites have been switched over to 
ieee80211_get_he_iftype_cap_vif?

- Felix
