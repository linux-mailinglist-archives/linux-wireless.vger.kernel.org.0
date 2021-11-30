Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84A30462AEB
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Nov 2021 04:10:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231947AbhK3DN0 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 29 Nov 2021 22:13:26 -0500
Received: from titan58.planetwebservers.net ([51.79.1.102]:51377 "EHLO
        titan58.planetwebservers.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230208AbhK3DNZ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 29 Nov 2021 22:13:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lockie.ca;
        s=default; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:Cc:From:
        References:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID
        :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
        Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe
        :List-Post:List-Owner:List-Archive;
        bh=13nM4q+lelUex53QNnCqopF6xWGvjcluOfFAsME0OMo=; b=S9JFIyKssHnOwWnd/y9/arJgXN
        JmHHC8HxrwJmdjvxNpGY6PtHEZ/Bz5fuaghBzdoDeVLi3/tRJNyW7F3OwMBX6fldnYK5+idr0Ztpv
        NphGmOPOHfICwqpPvmmSsYLyzFsUYUMVUZfS3ZEiCh7qOf09wZSuJ70IxF9YF2cAMwFaDIM/8osvW
        fdoI6C6Gr4wwtN5HkZnAT4X9uOE1CF8xzqD9dm13klL/vMGku5a5OQ2hHpFKxfzxZ9dsDJ6MnSZWW
        ILPV//JxLqSHFbc1L5GDJOxDAAWDfSj6kG99pgypdnQUUshehXHZ2WCO9/PtRAsVSRzXcdcBKI2mL
        KZZcV75g==;
Received: from [98.124.54.9] (port=59158 helo=[192.168.68.65])
        by titan.planetwebservers.net with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <bjlockie@lockie.ca>)
        id 1mrtWw-0002GR-NN; Tue, 30 Nov 2021 14:10:06 +1100
Message-ID: <90a01a09-a280-0dec-2a36-fc70762144ed@lockie.ca>
Date:   Mon, 29 Nov 2021 22:10:04 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.1
Subject: Re: USB for rtw89 driver?
Content-Language: en-US
To:     Larry Finger <Larry.Finger@lwfinger.net>
References: <5bdf4393-273f-2ad2-40e0-556ec7dc6817@lockie.ca>
 <867f4b97151745d5a5fa0daa5ebcdbd2@realtek.com>
 <3fef8020-a496-41e3-8974-4d16ff4551b6@lockie.ca>
 <917dde5b-36c7-a079-6dc1-7441a2f90745@lwfinger.net>
 <dac5960c-44f0-300e-d3d7-6ae23c3ae64f@lockie.ca>
 <5e815a38-eb5c-7dac-7243-1d734c1acd3f@lockie.ca>
 <5fff6faf-87a0-673e-0fda-853eb0391797@lwfinger.net>
From:   James <bjlockie@lockie.ca>
Cc:     linux-wireless <linux-wireless@vger.kernel.org>
In-Reply-To: <5fff6faf-87a0-673e-0fda-853eb0391797@lwfinger.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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



On 2021-11-29 20:44, Larry Finger wrote:
> On 11/29/21 17:37, James wrote:
>> Does anyone know what this is?
>> The releasenotes pdf says it came from Realtek.
>>
>> https://github.com/shiqishao/RTL8852AU_WiFi_linux_v1.15.0.1-0-g487ee886.20210714 
>>
>>
>> What are the roadblocks to getting USB support in the kernel driver?
>>
>> Is it possible to have a USB part of the driver that uses the kernel 
>> part of the driver?
>>
>
> The file structure indicates that it is a variation of the USB driver 
> from the Realtek group. As such, it will have all the flaws of that 
> family of drivers.

That is unfortunate but not surprising.
>
> I have previously estimated that it would take about 6 months of work 
> to get such a driver into shape to be submitted into staging. The 
> approach taken in https://github.com/neojou/rtw89-usb will take a lot 
> less time; however, without the cooperation of Realtek, it will take a 
> lot of USB dumps to compare the communication with the chip to 
> discover what differences there are between the PCI and USB versions, 
> other than the obvious base platform data flow.

>
> Have you tried either the shiqishao or the neojou driver? If you are 
> willing to provide me with a device, I could probably give you some 
> help getting the neojou driver into kernel shape.
>
> Larry
>
I don't have the adapter but I do want a wifi6 one.
I have a mediatek wifi5 one and that is pretty decent.

It is unlikely the neojou driver with work by replacing the PCI with 
corresponding USB calls?
I tried to compile it (to see if it even compiles :-)) but there are 
tons of "unused-*" warnings.

I've been reading about the lwfinger repo for the rtw89 PCI driver.
I'm guessing at one point the code between neojou and lwfinger was similar?
Do I have this right, the rtw89 driver will compile on ubuntu but not work?
What distro do you use for development?
Maybe Realtek will help to add the USB support. :-)

Can you provide me with a link to a local store that has the DLink 
DWA-X1850?
I'm not opposed to buying you one but it wouldn't be until next year. :-)
