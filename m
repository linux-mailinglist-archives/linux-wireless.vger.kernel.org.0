Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D1094117324
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Dec 2019 18:49:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726818AbfLIRtP (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 9 Dec 2019 12:49:15 -0500
Received: from mail2.candelatech.com ([208.74.158.173]:54810 "EHLO
        mail3.candelatech.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726477AbfLIRtO (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 9 Dec 2019 12:49:14 -0500
Received: from [192.168.100.195] (50-251-239-81-static.hfc.comcastbusiness.net [50.251.239.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail3.candelatech.com (Postfix) with ESMTPSA id BE35B137531;
        Mon,  9 Dec 2019 09:49:13 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com BE35B137531
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
        s=default; t=1575913753;
        bh=wey5wpJIoaIBeuADTyHcc44AauQSRezYPduCc1h7ypU=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=EiT1FkjSF0LTPUUYaL+JjaNMqUB4DiIHJfYTAKOrNOJXtWtHJzsUg86ud2IIE6fi3
         /yC1DmFArZp7BjcQ7bEps5vvL9CKeU3m22mcBWibZBXx5vB+zruDir2/VhCWiATshK
         wg9tnj8+Lt/P0N6ESWdSoIoLrVp6xuh0lOW2JXf8=
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
From:   Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
Message-ID: <f4e526b1-3afd-9eee-8416-46f3e97fdb00@candelatech.com>
Date:   Mon, 9 Dec 2019 09:49:13 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <98682dcf98525b9b7db16c30f85628d5a2725eb9.camel@sipsolutions.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 12/9/19 12:07 AM, Johannes Berg wrote:
> On Fri, 2019-12-06 at 15:44 -0800, Ben Greear wrote:
>>
>> kernel is 5.2.21+, with the fix for ax200 upload corruption bug.
> 
> Actually, thinking about this - there are *two* recent important fixes.
> 
> 1) the A-MSDU frag fix
> 2) security corruption fix
> 
> Which patch exactly did you take?
> 
> (if you're not using encryption on the AP 2) won't matter)
> 
> johannes
> 

I have only this one:

ommit 1416758748a12963b7dc619a54fb9cef4354fa2e
Author: Johannes Berg <johannes.berg@intel.com>
Date:   Wed Nov 20 12:26:39 2019 +0200

     iwlwifi: pcie: fix support for transmitting SKBs with fraglist


Please point me to the other one.

Thanks,
Ben

-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com

