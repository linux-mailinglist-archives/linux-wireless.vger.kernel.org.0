Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 781A911469A
	for <lists+linux-wireless@lfdr.de>; Thu,  5 Dec 2019 19:09:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729793AbfLESJP (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 5 Dec 2019 13:09:15 -0500
Received: from mail2.candelatech.com ([208.74.158.173]:40750 "EHLO
        mail3.candelatech.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726028AbfLESJP (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 5 Dec 2019 13:09:15 -0500
Received: from [192.168.100.195] (50-251-239-81-static.hfc.comcastbusiness.net [50.251.239.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail3.candelatech.com (Postfix) with ESMTPSA id 0EECA137531;
        Thu,  5 Dec 2019 10:09:15 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com 0EECA137531
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
        s=default; t=1575569355;
        bh=3yG6hawqFldzQPCpVnhw/zdRxWbBO1ALa1XHuZ5hWpQ=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=KGZ+1643ceJ5sEm4WGi4/Ni9FDNIXhkPdHzGt8pBumkWGuXGmCCROncTDKn2xvotp
         hf20W+ihlVQmSEXcnbqK/escz+kOVgjHh73vlOZak8Mebm5JbGv+0XPO4iE9zFKcTB
         tsNeJT7a71WmlnFgWLkbBNsSXvXB4cz6R5TM2TJ4=
Subject: Re: debugging TXQs being empty
To:     Johannes Berg <johannes@sipsolutions.net>,
        =?UTF-8?Q?Toke_H=c3=b8iland-J=c3=b8rgensen?= <toke@redhat.com>
Cc:     linux-wireless@vger.kernel.org
References: <bbc516f28782175b27ac5e19dcdeac13cd6ee76a.camel@sipsolutions.net>
 <49288397-55b3-f49a-e277-5197d7c1bea3@candelatech.com>
 <2e01fb1d5b8ff3335220231251f893c01c6c22d3.camel@sipsolutions.net>
 <64a6ae15-b7be-8c27-4e60-4cb3d253f3dc@candelatech.com>
 <e600f75741bd4c766bf043b0a404286f0ea22349.camel@sipsolutions.net>
From:   Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
Message-ID: <e89fc619-b8b2-c77a-1da5-943a34e9c607@candelatech.com>
Date:   Thu, 5 Dec 2019 10:09:14 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <e600f75741bd4c766bf043b0a404286f0ea22349.camel@sipsolutions.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 12/5/19 10:04 AM, Johannes Berg wrote:
> On Thu, 2019-12-05 at 08:57 -0800, Ben Greear wrote:
>> On 12/5/19 8:49 AM, Johannes Berg wrote:
>>> On Thu, 2019-12-05 at 08:37 -0800, Ben Greear wrote:
>>>
>>>>> All this seems to mean that the TCP stack isn't feeding us fast enough,
>>>>> but is that really possible?
>>>>
>>>> Does UDP work better?
>>>
>>> Somewhat, I get about 1020-1030 Mbps. But still a TON of "TXQ of STA ...
>>> is now empty" messages. Say this run got about 15 per second of those.
>>
>> It would seem that it is not some issue with TCP stack then?
> 
> Hmm, yeah, maybe not then. Something more general in the stack? I just
> can't think of anything.

Test similar setup 10g wired to 10g wired to make sure traffic generator
can generate hoped for load?

> 
>> In general, UDP uses more CPU to send from user-space than TCP
>> because of TSO, etc.  Sendmmsg can help a bit, but it is a bit painful
>> to code against so things like iperf do not use it, at least ones I've
>> looked at.
> 
> True.
> 
>> Can you provide some details on how you are generating this load?
> 
> Using chariot. I don't really know it well, just the testers use it.

So, you have some PC with AX200 in it, acting as station, connected to some AP,
and Charriot runs on that PC and something upstream of the AP and tries to
send traffic from PC to AP?

If you can share the AP model, just possibly we have one and could do a similar
test....

Thanks,
Ben


-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com

