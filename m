Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0626B30C31F
	for <lists+linux-wireless@lfdr.de>; Tue,  2 Feb 2021 16:11:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235167AbhBBPLH (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 2 Feb 2021 10:11:07 -0500
Received: from mail2.candelatech.com ([208.74.158.173]:56786 "EHLO
        mail3.candelatech.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234998AbhBBPI4 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 2 Feb 2021 10:08:56 -0500
Received: from [192.168.254.6] (unknown [50.34.172.155])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail3.candelatech.com (Postfix) with ESMTPSA id 5973613C2B0
        for <linux-wireless@vger.kernel.org>; Tue,  2 Feb 2021 07:08:13 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com 5973613C2B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
        s=default; t=1612278493;
        bh=mLUYUP2tKewecuBHW4TVfIRrz+lfZgwQdf/WNAanqbQ=;
        h=Subject:From:To:References:Date:In-Reply-To:From;
        b=m0GQo8+6+JEIH7uAfmeKFoNM+y+ZQF34JuKYM4Y6T0BDlw4rcBo32q+gir0CG+0jG
         OmKddECMwzCAltJuE7GyRIMbL+6ecGz/2Xpzyi7tPWS1LKwQ4oJX4HMtuGcRVCXVcE
         h0qDYINBA2TLYICw2ES2nt9N2x6zEDDN9awJCxcg=
Subject: Re: ax210: Why no 6E channels valid in regdom?
From:   Ben Greear <greearb@candelatech.com>
To:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
References: <3b3b53f6-a974-601f-f136-d685c4841647@candelatech.com>
 <ee8074e5-dbc9-e70f-1d51-934de9ccdcf1@candelatech.com>
Organization: Candela Technologies
Message-ID: <38c196d9-ab41-fe7c-3e2c-d02bf3474117@candelatech.com>
Date:   Tue, 2 Feb 2021 07:08:13 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <ee8074e5-dbc9-e70f-1d51-934de9ccdcf1@candelatech.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-MW
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 1/30/21 9:09 AM, Ben Greear wrote:
> On 1/29/21 2:31 PM, Ben Greear wrote:
>> I cannot figure out why my ax210 won't show any 6E channels.  It worked for a bit a few days
>> ago, but now it does not..and not sure why.  Looks like it uses some internal regdom.
>>
>> Any idea from these logs what is going on?
> 
> Is that 'mcc' logic actually able to read the cellular network?  I am near enough to Canada
> that sometimes my mobile phone will pick up those towers...could the ax210 possibly be
> hearing the same and forcing itself to OO regdom, which would cause it to disable all 6E
> channels?

Ok, I think I see the pattern now.

You have to admin-up the station and start scanning before it will show the
6E channels in 'iw reg get'.  And that makes the 'band 4' frequencies become
usable as well, as seen in 'iw phy foo info'.

So, a bit confusing for me, but I guess it works as intended.

This is with 5.11-rc5+ kernel and latest ax210 FW that I can find.

Thanks,
Ben

> 
> Thanks,
> Ben
> 
>>
>>   kernel: iwlwifi 0000:0f:00.0: In iwl-mvm-init-mcc, nvm-type: 1  NVM_EXT: 1
>>   kernel: iwlwifi 0000:0f:00.0: init-fw-regd: r: 0000000000000000
>>   kernel: iwlwifi 0000:0f:00.0: Getting regdomain data for ZZ from FW
>>   kernel: iwlwifi 0000:0f:00.0: send MCC update to FW with 'ZZ' src = 16
>>   kernel: iwlwifi 0000:0f:00.0: MCC response status: 0x1. new MCC: 0x3030 ('00') n_chans: 110
>>   kernel: iwlwifi 0000:0f:00.0: MCC update response version: 6
>>   kernel: iwlwifi 0000:0f:00.0: setting alpha2 from FW to 00 (0x30, 0x30) src=7
>>   kernel: iwlwifi 0000:0f:00.0: Get current regdom: 000000001caad6b5  mcc-supported: 1
>>   kernel: cfg80211: d8:f8:83:35:e9:f9: Disabling freq 2484.000 MHz as custom regd has no rule that fits it
>> ....
>>   kernel: cfg80211: d8:f8:83:35:e9:f9: Disabling freq 5955.000 MHz as custom regd has no rule that fits it
>>   kernel: cfg80211: d8:f8:83:35:e9:f9: Disabling freq 5975.000 MHz as custom regd has no rule that fits it
>>   kernel: cfg80211: d8:f8:83:35:e9:f9: Disabling freq 5995.000 MHz as custom regd has no rule that fits it
>>   kernel: cfg80211: d8:f8:83:35:e9:f9: Disabling freq 6015.000 MHz as custom regd has no rule that fits it
>>   kernel: cfg80211: d8:f8:83:35:e9:f9: Disabling freq 6035.000 MHz as custom regd has no rule that fits it
>>   kernel: cfg80211: d8:f8:83:35:e9:f9: Disabling freq 6055.000 MHz as custom regd has no rule that fits it
>>
>> Thanks,
>> Ben
>>
> 

