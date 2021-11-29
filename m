Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C74A14624BE
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Nov 2021 23:23:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232659AbhK2W0Y (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 29 Nov 2021 17:26:24 -0500
Received: from titan58.planetwebservers.net ([51.79.1.102]:45199 "EHLO
        titan58.planetwebservers.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234150AbhK2W0O (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 29 Nov 2021 17:26:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lockie.ca;
        s=default; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
        References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=zsztU5pHTy5Mjyd8EEv1kEXiGxnHGq/OIW31d+2vN2o=; b=daeaFN0CAMTd2jX7HKzDDMGtq5
        +Lfrp5lbZ3hHhSl7nEW/wDxyKO/aM1/rjhdLBJmtzNKt4eQGRkn69t3PhdZ6SC94gDLEpN0A0OHJs
        IO9Oe8/ImNmahxnNc7as/Iui2dJ/XENai+ciN1g/ofclbaEZ6xP/iptULnoEYFnknrRBTtPyiSLow
        F47gsyYIHQljQC2a7BZWuuN63G3MgpL/AjnzvD1scc4eRLVb2g9u5DJtbUk+QnUSUv0Azr/xtv6N1
        5emFaQ5jfE4nQgikHwnyoiUFqel9tczU3YiWuGQCpwsKyDu3Ulid7nX/bzDg+qVG5KQEwZyJA1pd6
        NRGm5qPQ==;
Received: from [98.124.54.9] (port=59126 helo=[192.168.68.65])
        by titan.planetwebservers.net with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <bjlockie@lockie.ca>)
        id 1mrp30-00065p-LU; Tue, 30 Nov 2021 09:22:54 +1100
Message-ID: <dac5960c-44f0-300e-d3d7-6ae23c3ae64f@lockie.ca>
Date:   Mon, 29 Nov 2021 17:22:51 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.1
Subject: Re: USB for rtw89 driver?
Content-Language: en-US
To:     Larry Finger <Larry.Finger@lwfinger.net>,
        Pkshih <pkshih@realtek.com>
Cc:     linux-wireless@vger.kernel.org
References: <5bdf4393-273f-2ad2-40e0-556ec7dc6817@lockie.ca>
 <867f4b97151745d5a5fa0daa5ebcdbd2@realtek.com>
 <3fef8020-a496-41e3-8974-4d16ff4551b6@lockie.ca>
 <917dde5b-36c7-a079-6dc1-7441a2f90745@lwfinger.net>
From:   James <bjlockie@lockie.ca>
In-Reply-To: <917dde5b-36c7-a079-6dc1-7441a2f90745@lwfinger.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - titan.planetwebservers.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - lockie.ca
X-Get-Message-Sender-Via: titan.planetwebservers.net: authenticated_id: bjlockie@lockie.ca
X-Authenticated-Sender: titan.planetwebservers.net: bjlockie@lockie.ca
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-From-Rewrite: unmodified, already matched
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org



On 2021-11-29 16:42, Larry Finger wrote:
> On 11/29/21 08:24, James wrote:
>>
>>>> Does anyone know if the proprietary driver works on the Raspberry Pi4B
>>>> (Arm)?
>>>
>>> Don't have a proprietary driver neither.
>>
>> Dlink seems to have added USB support.
>> I assumed that is proprietary but I guess that is only x86.
>>
>> https://support.dlink.com/ProductInfo.aspx?m=DWA-181-US
>>
>> There is also an open source USB driver on github  but I don't think 
>> it is getting fixes like the lfinger github one.
>> https://github.com/neojou/rtw89-usb
>
> The D-Link driver is for the rtl8822bu, not an rtl8852au. That would 
> make it for rtw88, not rtw89. BTW, it will not compile under kernel 
> 5.16.0-rc3, but the fixes would be minor.
>
Is this statement in the readme of neojou not correct?
"This driver is based on Realtek's rtw89 driver 
<https://github.com/torvalds/linux/tree/master/drivers/net/wireless/realtek/rtw89> 
in Linux main trunk. Or can refer to this lwfinger's github [rtw89] 
(https://github.com/lwfinger/rtw89)"

I checked the dlink link and it is for a wifi5 device.
I don't know how I got there. :-(
There is no linux driver from dlink for the USB wifi6 device. :-(
Oh well, maybe in 10 years. :-)
>
> That driver is the usual collection of junk code published by the 
> Realtek USB group for years. That code base is used to generate 
> drivers for Windows, Linux, and FreeBSD.
>
> A group is currently modifying the rtl8188eu driver in staging to 
> convert it into reasonable Linux shape. This one would take the same 
> effort to make it suitable.
"Chipset:/RTL8188EU/ Standard: IEEE 802.11n"
Would a good 8188eu driver make it easier to support wifi5 and wifi6 
devices?
>
> The basic USB driver in the neojou repo should work, but I do not have 
> an rtl8852au device.
Maybe it'll be in kernel eventually. :-)

> Larry
>

