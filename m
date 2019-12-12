Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CC83C11D4DA
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Dec 2019 19:07:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730275AbfLLSHF (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 12 Dec 2019 13:07:05 -0500
Received: from mail2.candelatech.com ([208.74.158.173]:55230 "EHLO
        mail3.candelatech.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730082AbfLLSHF (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 12 Dec 2019 13:07:05 -0500
Received: from [192.168.100.195] (50-251-239-81-static.hfc.comcastbusiness.net [50.251.239.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail3.candelatech.com (Postfix) with ESMTPSA id 95D2C13C283;
        Thu, 12 Dec 2019 10:07:04 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com 95D2C13C283
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
        s=default; t=1576174024;
        bh=MDpJ4ftWn7WuPrWWwnuPyDr4F1x4yNUjnTojWf1aQyo=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=E/WN6VCOd40e4d3NN28m3bojH8Zf9JoLWoQYsg7Rvso4dwZPhlEsKlFnLjtMfp6Ci
         DLvuS58fOJEa1ZlnpnmNYshSGPRz/9JvZWXaNLczBO/V+2QCYscNvMBuO4/wRlFkmK
         4W63+01SuwhbKYyln1V10UFG5zVT4ksqk7muy91o=
Subject: Re: debugging TXQs being empty
To:     Johannes Berg <johannes@sipsolutions.net>,
        Kan Yan <kyan@google.com>
Cc:     =?UTF-8?Q?Toke_H=c3=b8iland-J=c3=b8rgensen?= <toke@redhat.com>,
        linux-wireless <linux-wireless@vger.kernel.org>
References: <bbc516f28782175b27ac5e19dcdeac13cd6ee76a.camel@sipsolutions.net>
 <fd23a26dea59128ede8c1c4d02fb2f3514ffb5e9.camel@sipsolutions.net>
 <CA+iem5tjTpO_2MKL_pEu7enTa-8=g5vY3=2WJKjg9f=JA2eCEw@mail.gmail.com>
 <9b89b3b294295063aec045b9e863a44ad20b8782.camel@sipsolutions.net>
 <bf0cced86a1466285f74eb845e73fbaea1dff1c0.camel@sipsolutions.net>
 <9bcbab4b562669b96198c632f476b1b74956ca09.camel@sipsolutions.net>
 <336996e4-d9fe-bf3a-72fb-6919bd0adcbf@candelatech.com>
 <98682dcf98525b9b7db16c30f85628d5a2725eb9.camel@sipsolutions.net>
 <f4e526b1-3afd-9eee-8416-46f3e97fdb00@candelatech.com>
 <9cf0c2edcfa3ade4b53263b718b0dabf3d39e9f5.camel@sipsolutions.net>
 <bd06b9c7-a8c7-7ec6-ab98-8f59deb807af@candelatech.com>
 <ac29ab4d325cc8f33befa95d416c27e1131a2ec9.camel@sipsolutions.net>
From:   Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
Message-ID: <e7d97761-2e2d-2fb6-fe11-4283cd7212ad@candelatech.com>
Date:   Thu, 12 Dec 2019 10:07:04 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <ac29ab4d325cc8f33befa95d416c27e1131a2ec9.camel@sipsolutions.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 12/10/19 12:49 PM, Johannes Berg wrote:
> On Tue, 2019-12-10 at 12:47 -0800, Ben Greear wrote:
>>
>> We see about 675Mbps pktgen upload, and about 1Gbps download.  AP is
>> /AX and configured for 160Mhz, but AP does not actually transmit at
>> more than 80Mhz it seems.  I currently have no good way to see what MCS and BW
>> AX200 is transmitting at.
>>
> 
> Try this
> 
> https://p.sipsolutions.net/d421d04b8aef81c4.txt
> 
> That's our internal patch to fix this, will be going upstream soon I
> hope.

That appears to work fine, by the way.

Thanks,
Ben

-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com

