Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 480A4117665
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Dec 2019 20:55:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726999AbfLITzq (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 9 Dec 2019 14:55:46 -0500
Received: from mail2.candelatech.com ([208.74.158.173]:36534 "EHLO
        mail3.candelatech.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726354AbfLITzq (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 9 Dec 2019 14:55:46 -0500
Received: from [192.168.100.195] (50-251-239-81-static.hfc.comcastbusiness.net [50.251.239.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail3.candelatech.com (Postfix) with ESMTPSA id 43515137534;
        Mon,  9 Dec 2019 11:55:45 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com 43515137534
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
        s=default; t=1575921345;
        bh=UUH+dDtkSFZ8a0imx9Ut7sDLICaW3i5znZoP6LoT6Ic=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=g49PH/kCyCSY0AibWof7hLmPbYlcxtbC1VZyaLnQiOmI6xcSUFTbe2ulJoCB7bClA
         bVqegBUUWJ8cc7ZxUBCB4E8rX9usPFdVbM9IG0IF1Bi5sYtCTANUQ90UeIJhghOU9r
         XChK9jIzp8v/Sczjq9x+V6pVwIK9DEoDgpXaQ6hQ=
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
From:   Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
Message-ID: <1dbae50c-28f3-228b-bbb5-710648f2eb2d@candelatech.com>
Date:   Mon, 9 Dec 2019 11:55:44 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <9cf0c2edcfa3ade4b53263b718b0dabf3d39e9f5.camel@sipsolutions.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 12/9/19 11:37 AM, Johannes Berg wrote:
> On Mon, 2019-12-09 at 09:49 -0800, Ben Greear wrote:
>>
>> ommit 1416758748a12963b7dc619a54fb9cef4354fa2e
>> Author: Johannes Berg <johannes.berg@intel.com>
>> Date:   Wed Nov 20 12:26:39 2019 +0200
>>
>>       iwlwifi: pcie: fix support for transmitting SKBs with fraglist
> 
> OK.
> 
>> Please point me to the other one.
> 
> This one:
> 
> commit cb1a4badf59275eb7221dcec621e8154917eabd1 (tag: wireless-drivers-2019-11-14)
> Author: Mordechay Goodstein <mordechay.goodstein@intel.com>
> Date:   Thu Nov 7 13:51:47 2019 +0200
> 
>      iwlwifi: pcie: don't consider IV len in A-MSDU
> 
> but maybe it's included already?

It is not in 5.2, I'll add it to my tree.

> 
> I just tested (in conductive setup, open network) kernel 5.4, still see
> TP significantly lower than what I'd expect... But even in RX?

Please let us know what you actually see and expect and if what mode
you are using (VHT, HE, 160Mhz, 2x2 vs 1x1, etc).

Conductive test is not actually isolation from your environment (cables leak, especially
SMA pigtails, as do radio cards and so forth, and they leak both in and out), so
you will need a real shield chamber if you want to have repeatable
testing.  And, make sure you have 30db of attenuation or so inserted
if you are doing cabled setup, otherwise signal is too hot for the chips.

Thanks,
Ben

-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com

