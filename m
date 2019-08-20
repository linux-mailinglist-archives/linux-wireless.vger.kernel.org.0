Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4CEEF969F5
	for <lists+linux-wireless@lfdr.de>; Tue, 20 Aug 2019 22:06:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730330AbfHTUGk (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 20 Aug 2019 16:06:40 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:43520 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729833AbfHTUGk (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 20 Aug 2019 16:06:40 -0400
Received: by mail-oi1-f193.google.com with SMTP id y8so5115122oih.10
        for <linux-wireless@vger.kernel.org>; Tue, 20 Aug 2019 13:06:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=2xGFoIRxAurgLAWzEwqfQLCHQOZuH9k5DTBY5IC2kDo=;
        b=H87vdBiNYFQ4+61oOdMQxkKcE5f81dHHGg1dlJvzMlW8uD2wwiPyGci7Efp3lmQ2Y4
         8jsxYtfedpivAHnXoQW75G/l8GbHBm0eDt2RCiUshe7kOzA8o1YJOM1wreX+xQ308JLe
         yaq1x7uzb41RQTYfXcg0ogxyTdgcSw+/l3R+fQPq4jZaxkw+WFsWv13pxDy/aQsKOcen
         N+rI6BxPWceEdpqgjPxzjiawW08WM8PXj7b+vfZ/3G1/4wJj6Ayke7qeN7yzCj8oTpDq
         yMEVf+nvPfVxf+PEifNyJUvEh4Rsfcuuly0W6jEMIxvNTrhNCFfbrJAXlwU+nO1ft8+i
         siJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=2xGFoIRxAurgLAWzEwqfQLCHQOZuH9k5DTBY5IC2kDo=;
        b=ncvI1gCAIbmSPV2tKiiK69jWtvQMDmDrZYhLF8ChTxWes0RPjw8OBL8vXsZfqtBALy
         oBZgiC/euG9tIpdPb997AHvMqZFzYbtC5H7LgjO7pnSzHxETr8SXBfiig4nnG3WAbDeY
         Nvs2H5PWlYXi0YHvTt3+/gNLQcI3MuxCCqKlZ812Ajg5fCF8ukYCFUgUGtdYvCEl/kQx
         1VlzPVMckKhoHoD+e11uMEY5H9oZAC50lk1Itz0jxUhuu2dxL5r6aYfmpziG1SDhfXVV
         J7du2We7f804NHQCj2ooGCs82y4kQZqXyWEUf9/qfya6JtduqcnBBeF05zqKfl2/dl9s
         90/g==
X-Gm-Message-State: APjAAAUJmebpKU3lgyVxq8SwBTj1LacMkfCORuncfed1NxW/bGaWDvPl
        058rV5/cIM91xyzjulFiG3kfI9IV
X-Google-Smtp-Source: APXvYqxjsCFrUFHFjiEN4sZeeuwTPIS2QXKTulkrhQZcMHx7AynrixAKFSYzzFsar4dvJaPuhdo2kg==
X-Received: by 2002:aca:bfc3:: with SMTP id p186mr1335691oif.107.1566331598394;
        Tue, 20 Aug 2019 13:06:38 -0700 (PDT)
Received: from [192.168.1.249] (cpe-70-114-247-242.austin.res.rr.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id 13sm7077823otv.14.2019.08.20.13.06.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 20 Aug 2019 13:06:37 -0700 (PDT)
Subject: Re: [RFC 0/1] Allow MAC change on up interface
To:     Johannes Berg <johannes@sipsolutions.net>,
        James Prestwood <prestwoj@gmail.com>
Cc:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        Dan Williams <dcbw@redhat.com>
References: <20190815185702.30937-1-prestwoj@gmail.com>
 <645af7dad899e8eb186b3fee0f8a8a151a408557.camel@sipsolutions.net>
 <394092a2f20697c9b055166a8254a5ef888551a5.camel@gmail.com>
 <4848c3a9d0b330fab4442436244387a2c127fa03.camel@sipsolutions.net>
 <c6b719d6279211bbf52443f327884d96ef63f2b2.camel@gmail.com>
 <6835732fcc59ba8dbbcda4abc6e17dad499a7d8d.camel@sipsolutions.net>
 <b115e933-a357-9904-e831-dea7df1b46b9@gmail.com>
 <3576ad937c0b40b971a1b9c1a7c7396731a94bad.camel@sipsolutions.net>
From:   Denis Kenzior <denkenz@gmail.com>
Message-ID: <8c04da29-7515-1196-8431-67a6390bc00d@gmail.com>
Date:   Tue, 20 Aug 2019 14:58:53 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <3576ad937c0b40b971a1b9c1a7c7396731a94bad.camel@sipsolutions.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Johannes,

On 8/20/19 2:43 PM, Johannes Berg wrote:
> On Tue, 2019-08-20 at 14:22 -0500, Denis Kenzior wrote:
>> Hi Johannes,
>>
>> So keeping things purely technical now :)
>>
>>> I thought so, but I had another thought later. It might be possible to
>>> set LIVE_ADDR_CHANGE, but then block it in mac80211 when the interface
>>> is already connected (or beaconing, or whatever, using the MAC address
>>> in some way - even while scanning, remain-on-channel is active, etc.)
>>>
>>
>> Here's what we would like to see:
>>
>> - The ability for userspace to add a 'Local Mac Address to use'
>> attribute on CMD_CONNECT and CMD_AUTHENTICATE.
> 
> Why here though? I don't really like this as it's extra complexity
> there, and dev_set_mac_address() is really easy to call from userspace.
> Yes, that's sort of a round-trip more (you wouldn't even really have to
> wait for it I guess), but we have to make trade-offs like that (vs.
> kernel complexity) at some point.

But what actual complexity are we talking about here? If the kernel can 
do this while the CONNECT is pending, why not?  It makes things simpler 
and faster for userspace.  I don't see the downside unless you can 
somehow objectively explain 'complexity'.

> 
>> - It doesn't seem useful to add this to CMD_ASSOCIATE at the moment, as
>> for new connections you'd always go either through CMD_AUTHENTICATE,
>> CMD_ASSOCIATE sequence or use CMD_CONNECT.  This should take care of
>> some (most) of your objections about specifying different addresses for
>> authenticate/associate.  Feel free to correct me here.
> 
> That wasn't really my objection, I was more wondering why James
> implemented it *only* for CMD_CONNECT, when I had been under the
> (apparently mistaken) impression that one would generally prefer
> CMD_ASSOCIATE over CMD_CONNECT, if available.

This was an RFC.  There isn't much point for us to cross all the 't's 
and dot all the 'i's if you hate the idea in the first place.

> 
>> - Optionally (and I'm thinking of tools like NM here), add the ability
>> to set the mac address via RTNL while the device is UP but has no
>> carrier, and things like scanning, offchannel, etc are not in progress.
>> Though really I don't see how NM could guarantee this without bringing
>> the device down first, so I'll let NM guys chime in to see if this is a
>> good idea.
> 
> I'm thinking along the lines of letting you do this *instead* of the
> scheme you described above. That way, we don't even need to have a
> discussion over whether it makes sense at CONNECT, AUTH, ASSOC, or
> whatever because you can essentially do it before/with any of these
> commands.
> 
> Why would this not be sufficient?
> 

It would get the job done.  But it is still a waste of time and still 
slowing us down.  Look at it this way, even if we save 10ms here.  Take 
that and multiply by 3-4 billion devices and then by the number of 
connections one does each day.  This adds up to some serious time 
wasted.  So why not do this elegantly and faster in the first place?

>> - We definitely do not want to to mess with the device state otherwise.
>> E.g. no firmware downloading, powering the adapter down, etc.  That just
>> takes too much time.
> 
> I can understand this part.
> 
>> So tell us what you would like to see.  A new
>> IFF_NO_CARRIER_ADDRESS_CHANGE or whether it is possible to use
>> IFF_LIVE_ADDR_CHANGE with some additional restrictions.
> 
> I don't know. This is not something I'm intimately familiar with. I
> could imagine (as you quoted above) that we just set
> IFF_LIVE_ADDR_CHANGE and manage the exclusions local to e.g. mac80211.
> 

Okay, so lets operate under the assumption we can hi-jack 
IFF_LIVE_ADDR_CHANGE for this

>>> I still think you'd have to bake it into the mac80211<->driver API
>>> somehow, because we normally "add_interface()" with the MAC address, and
>>> nothing says that the driver cannot ignore the MAC address from that
>>> point on. The fact that iwlwifi just copies it into every new MAC_CTXT
>>> command and the firmware actually accepts the update seems rather
>>> accidental and therefore fragile to rely on.
>>>
>>
>> Since you seem to have a clear(er?) idea here, can you elaborate or
>> possibly provide the driver interface changes you want to see?
> 
> I can see a few ways of doing this, for example having an optional
> "change_vif_addr" method in the mac80211 ops, so that drivers can do the
> necessary work. I suppose iwlwifi would actually want to send a new
> MAC_CONTEXT command at this time, for example, because the firmware is
> notoriously finicky when it comes to command sequences.
> 
> Alternatively, and this would work with all drivers, you could just
> pretend to remove/add the interface, ie. in mac80211 call
> 
>   drv_remove_interface(sdata)
>   // set new mac addr
>   drv_add_interface(sdata)
> 
> This has the advantage that it'll be guaranteed to work with all
> drivers, at the expense of perhaps a few more firmware commands
> (depending on the driver).
> 
> You can probably come up with other ways, like having a feature flag
> whether this is supported and then the driver has to detect it as
> certain documented points in time, etc., but all of those feel
> relatively fragile to me.
> 
> 
> My personal preference would be for
> 
>   * allow RTNL MAC address changes at "idle" times (TBD what that really
>     means) with IFF_LIVE_ADDR_CHANGE, but mac80211 guarding it
>   * mac80211 doing remove/add as far as the driver is concerned

Okay, so that's really what we wanted from you.  :)

> 
> Yes, you can probably shave a few more milliseconds off by adding more
> complexity, but unless we measure that and find it to be significant, I
> think the added complexity (in cfg80211 code) and restrictions (many
> drivers not supporting it if it's opt-in) wouldn't be worth it.
> 

So we have a tool in the works that can measure some of these details. 
Also, we can simply attempt to implement both ways and see if the 
complexity is as bad as you say.  Then you can make that choice.

Regards,
-Denis
