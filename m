Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E7013114537
	for <lists+linux-wireless@lfdr.de>; Thu,  5 Dec 2019 17:57:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729047AbfLEQ5i (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 5 Dec 2019 11:57:38 -0500
Received: from mail2.candelatech.com ([208.74.158.173]:38130 "EHLO
        mail3.candelatech.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726028AbfLEQ5i (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 5 Dec 2019 11:57:38 -0500
Received: from [192.168.100.195] (50-251-239-81-static.hfc.comcastbusiness.net [50.251.239.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail3.candelatech.com (Postfix) with ESMTPSA id A5EF3137531;
        Thu,  5 Dec 2019 08:57:37 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com A5EF3137531
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
        s=default; t=1575565057;
        bh=GT3Kfq28O8/jytxcmj3IIENh+6oLIrfoYN9hxhL1ZHs=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=h97OGLcKYPCRqG/zq1UgY6wVsSt79+lvv11iRcMkNGBKe5JE8Mo16t7PP6+4ju/CB
         zbzHK7xO2pn8/Fk5fHLBw2Tky8zB4vKkpWbTC6Z8QrqX49zLF1v95SmDFqXzJB3B7C
         V7bzjlhVhYyyW6SOTHTM+NwnpGId4tuSr3A2wSMo=
Subject: Re: debugging TXQs being empty
To:     Johannes Berg <johannes@sipsolutions.net>,
        =?UTF-8?Q?Toke_H=c3=b8iland-J=c3=b8rgensen?= <toke@redhat.com>
Cc:     linux-wireless@vger.kernel.org
References: <bbc516f28782175b27ac5e19dcdeac13cd6ee76a.camel@sipsolutions.net>
 <49288397-55b3-f49a-e277-5197d7c1bea3@candelatech.com>
 <2e01fb1d5b8ff3335220231251f893c01c6c22d3.camel@sipsolutions.net>
From:   Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
Message-ID: <64a6ae15-b7be-8c27-4e60-4cb3d253f3dc@candelatech.com>
Date:   Thu, 5 Dec 2019 08:57:37 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <2e01fb1d5b8ff3335220231251f893c01c6c22d3.camel@sipsolutions.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 12/5/19 8:49 AM, Johannes Berg wrote:
> On Thu, 2019-12-05 at 08:37 -0800, Ben Greear wrote:
> 
>>> All this seems to mean that the TCP stack isn't feeding us fast enough,
>>> but is that really possible?
>>
>> Does UDP work better?
> 
> Somewhat, I get about 1020-1030 Mbps. But still a TON of "TXQ of STA ...
> is now empty" messages. Say this run got about 15 per second of those.

It would seem that it is not some issue with TCP stack then?

In general, UDP uses more CPU to send from user-space than TCP
because of TSO, etc.  Sendmmsg can help a bit, but it is a bit painful
to code against so things like iperf do not use it, at least ones I've
looked at.

Can you provide some details on how you are generating this load?

For what it's worth, we've seen about 1.9Gbps download goodput
when using ax200 as a station receiving traffic from 160Mhz AP.
I don't have any reports of > 1Gbps of upload performance though,
not sure our user with the fast AP has done much upload testing...

>> or pktgen?
> 
> I haven't really tried, the setup is a bit complicated ... and it's
> nowhere near me either :)

Yeah, it will likely crash your system unless you apply years-old patches I posted
too :)

But, at least with pktgen, you can be quite sure it is not some slowdown farther up
the stack that is causing the problem.

Thanks,
Ben

-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com

