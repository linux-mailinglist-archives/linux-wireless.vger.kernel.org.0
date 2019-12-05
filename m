Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4B49C1146F0
	for <lists+linux-wireless@lfdr.de>; Thu,  5 Dec 2019 19:34:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729022AbfLESeV (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 5 Dec 2019 13:34:21 -0500
Received: from mail2.candelatech.com ([208.74.158.173]:41354 "EHLO
        mail3.candelatech.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726028AbfLESeV (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 5 Dec 2019 13:34:21 -0500
Received: from [192.168.100.195] (50-251-239-81-static.hfc.comcastbusiness.net [50.251.239.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail3.candelatech.com (Postfix) with ESMTPSA id EC277137534;
        Thu,  5 Dec 2019 10:34:19 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com EC277137534
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
        s=default; t=1575570860;
        bh=LC4GgusFBqi1/xyN4T23Qq3CfhYln2QyJBbRFLmJXGE=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=p65UBabM6Hk2PFXLgRcjmNX9w3sf8eDa5WsYYeVuf/tQ4eBgw5uSlwmlIwC6OYyhZ
         9B0W9b+1mlXYdvOph/3A1x0SM9b0RfGXkHMN4k/GmhrImW8R4/ZDLbs5aCpXf9BMDj
         kD9XhTh7EhQjGUJ/KYRMW7JsBQSrMjJFoXD/i8bM=
Subject: Re: debugging TXQs being empty
To:     Johannes Berg <johannes@sipsolutions.net>,
        =?UTF-8?Q?Toke_H=c3=b8iland-J=c3=b8rgensen?= <toke@redhat.com>
Cc:     linux-wireless@vger.kernel.org
References: <bbc516f28782175b27ac5e19dcdeac13cd6ee76a.camel@sipsolutions.net>
 <49288397-55b3-f49a-e277-5197d7c1bea3@candelatech.com>
 <2e01fb1d5b8ff3335220231251f893c01c6c22d3.camel@sipsolutions.net>
 <64a6ae15-b7be-8c27-4e60-4cb3d253f3dc@candelatech.com>
 <e600f75741bd4c766bf043b0a404286f0ea22349.camel@sipsolutions.net>
 <e89fc619-b8b2-c77a-1da5-943a34e9c607@candelatech.com>
 <792356df00a9be73f2613f5b4c74bfe2edb05013.camel@sipsolutions.net>
From:   Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
Message-ID: <25b5ffba-eb63-e3a4-4372-95ffbeff581d@candelatech.com>
Date:   Thu, 5 Dec 2019 10:34:19 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <792356df00a9be73f2613f5b4c74bfe2edb05013.camel@sipsolutions.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 12/5/19 10:20 AM, Johannes Berg wrote:
> On Thu, 2019-12-05 at 10:09 -0800, Ben Greear wrote:
> 
>>> Hmm, yeah, maybe not then. Something more general in the stack? I just
>>> can't think of anything.
>>
>> Test similar setup 10g wired to 10g wired to make sure traffic generator
>> can generate hoped for load?
> 
> Oh, I think it normally works better - I'd have to look up the numbers,
> don't have them handy now. It's a specific issue to this specific PC
> that I have, could be related to the (bastardized) kernel that has, or
> something else.
> 
> Hence my more general questions how I would understand/debug this, I
> don't think I can say what the hardware or even kernel is (and even if
> you knew it'd probably be useless, not sure that's public now.)

Well, my questions were based around trying to verify that the problem is actually
down in the wifi stack/queues vs farther up the stack and/or user-space.

If you can't trust your traffic generator can actually generate the load,
then you could be chasing phantom problems.

If you can use something like pktgen, then you can bypass upper stack and
user-space, so area to test and debug is smaller.

If you use some more stable kernel and it works fine, then you can suspect
the kernel is issue.

If you put ax200 in more standard PC and it works fine, then you can suspect
hardware is issue.

...

I'm debugging 160Mhz bugs in my /AC firmware, when I get that sorted, will try
ax200 as station and see what I can push through it in the upload direction.

Thanks,
Ben

> 
>>> Using chariot. I don't really know it well, just the testers use it.
>>
>> So, you have some PC with AX200 in it, acting as station, connected to some AP,
>> and Charriot runs on that PC and something upstream of the AP and tries to
>> send traffic from PC to AP?
> 
> Traffic is going from the DUT to a wired station behind the AP, which
> actually has two gigabit ethernet links to the AP and two IP addresses,
> so that we can distribute the wireless load onto two gigabit links.
> 
>> If you can share the AP model, just possibly we have one and could do a similar
>> test....
> 
> :)
> 
> I think it's a RT-AX88U. Not sure that really makes a difference.
> 
> Seems this AP has a bug btw, it's advertising packet extension of 16usec
> for 20 and 40 MHz, but not for 80 and 160 MHz, which seems a bit odd,
> and indeed we miss ACK there sometimes. To exclude that as a reason I
> hacked the driver to always do 16us ignoring the AP information. But I
> think the issues I outlined with the TXQs are the primary reason for
> even sending single frames where this would matter ... rather than only
> A-MPDUs.
> 
> So I don't *think* it's really related to that, but others are looking
> at that part (or well, I hope they will be on Sunday, given they're in
> Israel).
> 
> In the meantime, I'm stuck trying to figure out why we run the TXQs
> empty :)
> 
> johannes
> 


-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com

