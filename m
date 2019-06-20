Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 155E34DB4E
	for <lists+linux-wireless@lfdr.de>; Thu, 20 Jun 2019 22:35:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726129AbfFTUfy (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 20 Jun 2019 16:35:54 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:41522 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725913AbfFTUfy (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 20 Jun 2019 16:35:54 -0400
Received: by mail-io1-f66.google.com with SMTP id w25so1727298ioc.8
        for <linux-wireless@vger.kernel.org>; Thu, 20 Jun 2019 13:35:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=kanIEJbwlbihL3llobnlf73jqpRLgg9EFXzGM7pz0tY=;
        b=laWJRjqnTWhXEJxPebHgDa4vF7pW0LXA/u8wVBH/TpB+sRr3WRbY33CHqbrhAWlt0k
         RRKFtWHziJ8HyvPuU5zSdg777aZMeFkK3mAKLVmsETqbvGdIFcgllrBaGXU94pCr7Ywd
         DrKRRF4nLwlvftpHKj4MphFvDk1K/lFg0N4jCfU6eW28ML1Ennoujq0v1qxroAAu5m9K
         DxVqN41twh2GrGasYml6aTWKqaRHOm41X55LqK3D5PYIF/qVq6J5ZthEHdvRPATXqjqw
         r201W/WzPm1VqeSa6gVWjCIeOV/96El4Ed/B+ECsmeBk2igDqvqy1YNbJib8vlSu+XK5
         wytw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=kanIEJbwlbihL3llobnlf73jqpRLgg9EFXzGM7pz0tY=;
        b=d5GYxgufMoEkYYJiRN0SKWTQ08jdSDOyRE6d/pwY5rHgw9HZWsJOSxxeng4mGNoPoz
         JSJukqp3hLAFqNY6wvO4hezUUTUWXU96LPBVik1+QutwuGp1soN/MnjP9dyB7Iwv2oTB
         J36ZP7ifYc3RDJJ6S/Su/bGUBeUVMQ4tRwIKsPv+Wba+aBoGfHjODtUWIpGDzZYH5Oz0
         FteLPAMlqvUaAWsoUez7hYxW6/caAVcu6l2d/8oI/QH7OHQe7q3Kd92AGJtICj6K3ekE
         LNxQ/XgZm+PQsKnbyRSjrA4lLSFoXW8JksUgUFMinDCTqHKuvoctsad6CfYelxqIsux0
         UZTA==
X-Gm-Message-State: APjAAAXvQpBS8gEdAz+S14USI9VHyDVW1JTE1z+Q1uJHNhJuf/NrZB09
        r9zpJb7DEFW8qNJjhHiNiIktPZ5/
X-Google-Smtp-Source: APXvYqzsl0DKrqJu/WT66bE04bE1tZz/fL7ma8Le93nA+otXvXcx/e/OKpZAlUPtwrryRNe+uJs//A==
X-Received: by 2002:a6b:8bd1:: with SMTP id n200mr82520916iod.134.1561062953270;
        Thu, 20 Jun 2019 13:35:53 -0700 (PDT)
Received: from new-host-2.home ([2605:a601:808:1001:37ba:4f0a:192f:f945])
        by smtp.googlemail.com with ESMTPSA id s6sm566826ioo.31.2019.06.20.13.35.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Jun 2019 13:35:52 -0700 (PDT)
Subject: Re: [PATCH 3/3] nl80211: Include wiphy address setup in NEW_WIPHY
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless@vger.kernel.org
References: <20190619223606.4575-1-denkenz@gmail.com>
 <20190619223606.4575-3-denkenz@gmail.com>
 <ec1ca95a5789f9001e89e603633b20316d687721.camel@sipsolutions.net>
 <7da9b924-78c7-ba72-fecc-a11700a34ff4@gmail.com>
 <44923833f1068e360b1f9534a9bbd37be41e4833.camel@sipsolutions.net>
 <427f488f-98f5-f888-f079-e2bbbb6eedf3@gmail.com>
 <144f36779085498bdc1b2f7ac0d0c267d431f51d.camel@sipsolutions.net>
From:   Denis Kenzior <denkenz@gmail.com>
Message-ID: <4e2407af-ef56-d1dc-93a8-b2cf558a5460@gmail.com>
Date:   Thu, 20 Jun 2019 15:35:51 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <144f36779085498bdc1b2f7ac0d0c267d431f51d.camel@sipsolutions.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Johannes,

On 06/20/2019 03:09 PM, Johannes Berg wrote:
> On Thu, 2019-06-20 at 15:05 -0500, Denis Kenzior wrote:
>>
>> Ugh.  So, if I understand this correctly, NEW_WIPHY events that are
>> generated when a new wiphy is plugged would only send the old 'legacy'
>> info and any info we add in cases 9+ would be 'lost' and the application
>> is forced into re-dumping the phy.
> 
> Yes.
> 
>> This is pretty much counter to what we want.
> 
> Well, you want the info, shouldn't matter how you get it?
> 

Well, it kind of does.  You're asking userspace to introduce extra 
complexity, extra round trips, extra stuff to go wrong just because the 
kernel API has painted itself into a corner.

>> If you want to keep your sanity in userspace, you need proper 'object
>> appeared' / 'object disappeared' events from the kernel.
> 
> Sure, but you don't really need to know *everything* about the events
> right there ... you can already filter which ones you care about
> (perhaps you know you never want to bind hwsim ones for example) and
> then request data on those that you do need.

Sure, but it would be nice to have all the info available if we do not 
want to filter it...

> 
>> And those
>> events should have all or nearly all info to not bother the kernel going
>> forward.
> 
> That's what you wish for, but ...

Well, it is a pretty basic requirement for any event driven API, no?

> 
>>    It sounds like nl80211 API has run into the extend-ability
>> wall, no?
> 
> I don't really see it that way.
> 
>> Any suggestions on how to resolve this?  Should NEW_WIPHY events also do
>> the whole split_dump semantic and generate 15+ or whatever messages?
> 
> No, that'd be awful, and anyway you'd have to send a new command because
> otherwise old applications might be completely confused (not that I know
> of any other than "iw event" that would event listen to this, but who
> knows)

Well, given that we're the only ones that seem to care about this right 
now, I don't see sending a new command as much of a big deal.  I welcome 
other ideas, but having the kernel send us an event, then us turning 
around and requesting the *same* info is just silly.

Regards,
-Denis
