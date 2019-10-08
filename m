Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2E918CFE0F
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Oct 2019 17:48:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728104AbfJHPr4 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 8 Oct 2019 11:47:56 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:39865 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726439AbfJHPrz (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 8 Oct 2019 11:47:55 -0400
Received: by mail-oi1-f196.google.com with SMTP id w144so15183168oia.6
        for <linux-wireless@vger.kernel.org>; Tue, 08 Oct 2019 08:47:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=Lsyq7Tdh/B7fsHIpEb9mk/LzKcLB1SS5L2wOtiXC7YU=;
        b=shHCPojzvuUzi9tQt2MjLQ7hTFbtMi+QA1RX585yub/ifN1RlErU/jF3D8Pz3r339i
         lo7epCLuAsjZbzQNRzHRYgwnWOdIlL8WHreZaVK8II5cBcfOTEhQBU5QOWQhQADyQ7A7
         mA66yZsU1Q2uLI9n21ZOUenjCurGT1j2GiEBHIkc97Z3UtoLuU1Dbw7llW32XrD2iDpK
         0ypmlUAu/kBUB1XHD47672BY7O34z57/Aurgz/RJRLmZovOfjiVW6fASpwYgApaAKYAH
         eAi7S58kkBCSHtgfFWP9cWboTR852efLM5VHLJdvLNkv+Xec5H+W/KGWGOFRslwXaXJn
         8Jnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Lsyq7Tdh/B7fsHIpEb9mk/LzKcLB1SS5L2wOtiXC7YU=;
        b=fTKTc1tvn4Xz/xEc7S0LQOdqo2WpVO0Sfl8vkErri5aX4fg0KRhsrm0b0lSj0rzT9i
         NjGOTqtmvNpUQCfA0xGqizHafVgzigcgcTEPl9fjE4d9r20xoR2rI7j2XwLjER61Wpvf
         HRNOH4qK/pC0uFW0a3bttjn2ddyASqBobkTXeuLwMB3beJv2/pZ4+BXi4dpIrfU7ZJAp
         4wTpzflg3hOmJWJVu1F7uAtN+MlBADcFKCjpe/HIOJLOY7HaFmtZ2/wvbrYnySwbz1UU
         rASzjkzecVhRiPcd/ERV7N6sSjrBLQWIdWVHELutroEZ0B5iwAi5gg/4nOTcagAv2DhS
         p9oQ==
X-Gm-Message-State: APjAAAXXxpanYhFg4D/aIgEgBVnkPpGqBrXQCw1Dws1JUGMHPAe13i+t
        pE9XX5zgDRnxGZkNzOGW7MVvO0El
X-Google-Smtp-Source: APXvYqyG1GjBu3683G0tDcoTW35EGfQ2YOin5ywa2VO4mMqz21Uub3dbnUKQgosEHp7UAGy5C+O8qw==
X-Received: by 2002:aca:4f53:: with SMTP id d80mr4226055oib.41.1570549674764;
        Tue, 08 Oct 2019 08:47:54 -0700 (PDT)
Received: from [192.168.1.249] (cpe-70-114-247-242.austin.res.rr.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id w20sm5538471otk.73.2019.10.08.08.47.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 08 Oct 2019 08:47:54 -0700 (PDT)
Subject: Re: [PATCH 2/2] mac80211: Support LIVE_ADDRESS_CHANGE feature
To:     Johannes Berg <johannes@sipsolutions.net>,
        James Prestwood <prestwoj@gmail.com>,
        linux-wireless@vger.kernel.org
References: <20190913195908.7871-1-prestwoj@gmail.com>
 <20190913195908.7871-2-prestwoj@gmail.com>
 <c6835b5c5d2a97fa82b0fb21f7b7f0056aa42e1b.camel@sipsolutions.net>
 <90ae00044bc0834d87d3f9fb75ce63dce4cfadd5.camel@gmail.com>
 <0b57c1288016310050ccd6233dda886fc4a89b02.camel@gmail.com>
 <f468a8d573ddf401d2084b76eb625fef5950f265.camel@sipsolutions.net>
From:   Denis Kenzior <denkenz@gmail.com>
Message-ID: <6fa34e4c-5c81-4875-da29-cada1a078e2c@gmail.com>
Date:   Tue, 8 Oct 2019 10:37:58 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <f468a8d573ddf401d2084b76eb625fef5950f265.camel@sipsolutions.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Johannes,

On 10/7/19 4:16 PM, Johannes Berg wrote:
> Hi,
> 
>>>> If you do care about this being more granular then you should check
>>>> *which* interface is scanning, and then you can still switch the
>>>> MAC
>>>> address for *other* interfaces - but I'd still argue it should be
>>>> independent of interface type.
>>
>> So yes these can scan, but this should be covered by the
>> netif_carrier_ok check which is done first.
> 
> Not sure what you mean by that.
> 
> You could have two interfaces, one which is scanning right now, right?
> And then theoretically you don't care about the other one - it *should*
> be OK to remove/re-add (with new MAC address) the one that *isn't*
> scanning, right?

Actually, I don't think you can?  Unless I'm missing something?  All the 
scan state is stored on struct ieee80211_local, so if that struct is 
allocated per phy as you point out below, then what you suggest is 
currently not possible?

> 
> But we don't have that granularity here for anything - you're just
> checking "sdata->local->something", and by going from sdata to local
> you've now checked the whole NIC, not just a single interface on that
> NIC.

Right.  But that seems to be a limitation of mac80211 actually.  We 
can't run two scans concurrently on different interfaces.  This is 
rather unintuitive given that scan requests require an ifindex/wdev.

Can this be changed / fixed in mac80211 actually?  I would expect that 
if a card supports p2p and station simultaneously, then it can scan / go 
offchannel on two interfaces simultaneously? Or not?  What can iwlwifi 
do for example?

> 
> Which is fine, no complaint from me, just in that case you end up
> failing when really there isn't much need to fail. In fact, in a case
> like this, actually clearing IFF_UP, changing address and setting IFF_UP
> would work, concurrently with another interface scanning.
> 
>>   We can just remove the
>> switch entirely, but the roc_list/scanning check only matters for
>> station/p2p_client so checking for the other interface types is kinda
>> pointless and redundant.
> 
> But it's also completely confusing to do it this way because you go from
> "sdata" to "local", and at that point the data that you're working on is
> no longer specific to that one interface, it's actually for the whole
> NIC.

I agree its confusing, but that seems to be how mac80211 works?

> 
> Basically what I'm saying is this: it's confusing and makes no sense to
> do something like
> 
> 	if (this_is_a_certain_netdev_type)
> 		check_some_global_data();
> 
>> Also I am not sure what you mean by *which* interface. This function is
>> called on a single interface, so checking what other interfaces are
>> doing seems strange...
> 
> My point exactly - but that's what you're doing here in the code. Now I
> think perhaps without even realizing?
> 

Given the above, I'm not sure I see anything wrong?  The switch/case can 
probably be gotten rid of, but it actually makes things clear that only 
station/p2p_device and adhoc are handled specially.

Regards,
-Denis
