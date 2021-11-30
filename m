Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F9A0462983
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Nov 2021 02:16:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235286AbhK3BTs (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 29 Nov 2021 20:19:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230248AbhK3BTs (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 29 Nov 2021 20:19:48 -0500
Received: from mail-oo1-xc32.google.com (mail-oo1-xc32.google.com [IPv6:2607:f8b0:4864:20::c32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A980C061574
        for <linux-wireless@vger.kernel.org>; Mon, 29 Nov 2021 17:16:30 -0800 (PST)
Received: by mail-oo1-xc32.google.com with SMTP id g11-20020a4a754b000000b002c679a02b18so6216063oof.3
        for <linux-wireless@vger.kernel.org>; Mon, 29 Nov 2021 17:16:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=sdW3Kbj3OWp+L5WnGoFaw+Ow73vwNrzGyp5sXG5EouU=;
        b=cIbiYmtSqyJCI1V+tXhS8uo4tf5xqRXhkPiUKITkWrXPidOJIWGw2So37QmjK8/yS3
         /3hvf9bY+lnSgnAqfs9Ng2+Xftnikfhb1WgnCn5DLgv8Q303ouaHP4WEFo0GXMQ+1zsv
         Y+P+wsR/U/zlOrpAyrMJB7ftHM8oO1I0vKpFjjVrWGbo+8tUEv7CAjepFbKH4noz3ptJ
         S/jM6W74l3N0kn840aOyZeR+YmuP4pm7xxzJGbuiSa7ejuGk94TwVGGkm6V7vb6Mk2TD
         0+aEk5NCejvOgbcJ9TgimSRfjyBz7grNbO5+kQAhY4F9aPPIesaEZrvl9umW9DBxrl6o
         5SYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:message-id:date:mime-version:user-agent
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=sdW3Kbj3OWp+L5WnGoFaw+Ow73vwNrzGyp5sXG5EouU=;
        b=EqudALO2ow93m6RtXesbMRWlvBFHMZ7cJkxDDybnQ3/9ZJ+kgtDVnl7SqSfiZXqn+U
         lrs2qdel6mzly6h1q2ThxqWvgEQTSrdkITgDr7vzMO6LmdQlztRPdbLtCcS2vrw13/x8
         Ih1VGCIG2f3Fe05ZjYRXPDTMg7iOy58iVI+E4fuYI+FDaTDU08zrv0lNQooSM++50pLz
         zKTdC9+fh1IbAG/S4UCd2HKoxczReGBOLdKx+fnuxVx1mfyI0gZwEDLqP6D6hdetVtgL
         nh05vQidjmsJdC8oo5aLDZuPGPd1bVot2fMD+AWVjbnYVkJWzJH9nZZFcC8F2nQSYAmT
         j5Gw==
X-Gm-Message-State: AOAM531r6c4qSydrP2Ub9+7awVHq9YLAwqqb4WXHYCV6rhT1HblnZVn1
        7K4dlIHA2McDKvVc3ca8LWpa90BgQzjcKB+p
X-Google-Smtp-Source: ABdhPJz+XO/THy0iX8FCV2NFpWTurgxpWpHjlg0H0iuYHm2aDEa5NiKEq7nv5rbx51D0LfE4JWG+cg==
X-Received: by 2002:a4a:e50e:: with SMTP id r14mr34469363oot.27.1638234989586;
        Mon, 29 Nov 2021 17:16:29 -0800 (PST)
Received: from [10.62.118.101] (cpe-24-31-246-181.kc.res.rr.com. [24.31.246.181])
        by smtp.gmail.com with ESMTPSA id s13sm2989612otv.34.2021.11.29.17.16.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Nov 2021 17:16:28 -0800 (PST)
Sender: Larry Finger <larry.finger@gmail.com>
Message-ID: <ea1afcf4-ff5b-9b32-ec4b-421a898f809d@lwfinger.net>
Date:   Mon, 29 Nov 2021 19:16:27 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: USB for rtw89 driver?
Content-Language: en-US
To:     James <bjlockie@lockie.ca>, Pkshih <pkshih@realtek.com>
Cc:     linux-wireless@vger.kernel.org
References: <5bdf4393-273f-2ad2-40e0-556ec7dc6817@lockie.ca>
 <867f4b97151745d5a5fa0daa5ebcdbd2@realtek.com>
 <3fef8020-a496-41e3-8974-4d16ff4551b6@lockie.ca>
 <917dde5b-36c7-a079-6dc1-7441a2f90745@lwfinger.net>
 <dac5960c-44f0-300e-d3d7-6ae23c3ae64f@lockie.ca>
From:   Larry Finger <Larry.Finger@lwfinger.net>
In-Reply-To: <dac5960c-44f0-300e-d3d7-6ae23c3ae64f@lockie.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 11/29/21 16:22, James wrote:
> 
> 
> On 2021-11-29 16:42, Larry Finger wrote:
>> On 11/29/21 08:24, James wrote:
>>>
>>>>> Does anyone know if the proprietary driver works on the Raspberry Pi4B
>>>>> (Arm)?
>>>>
>>>> Don't have a proprietary driver neither.
>>>
>>> Dlink seems to have added USB support.
>>> I assumed that is proprietary but I guess that is only x86.
>>>
>>> https://support.dlink.com/ProductInfo.aspx?m=DWA-181-US
>>>
>>> There is also an open source USB driver on github  but I don't think it is 
>>> getting fixes like the lfinger github one.
>>> https://github.com/neojou/rtw89-usb
>>
>> The D-Link driver is for the rtl8822bu, not an rtl8852au. That would make it 
>> for rtw88, not rtw89. BTW, it will not compile under kernel 5.16.0-rc3, but 
>> the fixes would be minor.
>>
> Is this statement in the readme of neojou not correct?
> "This driver is based on Realtek's rtw89 driver 
> <https://github.com/torvalds/linux/tree/master/drivers/net/wireless/realtek/rtw89> 
> in Linux main trunk. Or can refer to this lwfinger's github [rtw89] 
> (https://github.com/lwfinger/rtw89)"

That is correct. What has been done there, and in the equivalent rtw88-usb 
version, is replace the PCI I/O calls with the equivalent USB library calls. 
What cannot be determined outside the Realtek halls is whether there are changes 
in the NIC chip itself between the two versions. Certainly, there are 
differences between the setup of the rtl8192ce and the rtl8192cu. I would expect 
the same here.
> 
> I checked the dlink link and it is for a wifi5 device.
> I don't know how I got there. :-(
> There is no linux driver from dlink for the USB wifi6 device. :-(
> Oh well, maybe in 10 years. :-)
>>
>> That driver is the usual collection of junk code published by the Realtek USB 
>> group for years. That code base is used to generate drivers for Windows, 
>> Linux, and FreeBSD.
>>
>> A group is currently modifying the rtl8188eu driver in staging to convert it 
>> into reasonable Linux shape. This one would take the same effort to make it 
>> suitable.
> "Chipset:/RTL8188EU/ Standard: IEEE 802.11n"
> Would a good 8188eu driver make it easier to support wifi5 and wifi6 devices?

Not really. That hardware is wifi4 (802.11n) and has no higher capabilities. The 
basic silicon and firmware could not handle the higher protocols.
>>
>> The basic USB driver in the neojou repo should work, but I do not have an 
>> rtl8852au device.
> Maybe it'll be in kernel eventually. :-)

Perhaps. That will depend on the PCI group from Realtek deciding to tackle that 
project.

Larry

