Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D587320D4B7
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Jun 2020 21:15:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730877AbgF2TLC (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 29 Jun 2020 15:11:02 -0400
Received: from mon2.sibername.com ([162.144.51.228]:51299 "EHLO
        mon1.sibername.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1731023AbgF2TK7 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 29 Jun 2020 15:10:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lockie.ca;
         s=default; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version
        :Date:Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=Q/1z8cGxys/InkFiFhEyk1DcvcZJuXa4Ynlwi/r/W+g=; b=nAPM+ZPs+4DEBpBBeF90c/FmwA
        l6t1HOJn/n33MBHE8XDhfklr++gtQk1hiiUdMlRJlLpJAI0823ZK+xR7cR6/Z9icss+lRIX3kA+A5
        aewlRwAfAkIrMDhW3ViiWi2jbm6JgTaMIaHcW9v3z0N9WTWdbTrDh7KmwxpqDuZ02SER9REUvBq5b
        aYQeLn229he9ZEnhHTv1rozYp2xOUXvdPHzORSsCQiMs5ktps0b7oRxxUjk64jpt4n4CebDT8bw3r
        HfQhrnOoHT+oVmTMWqlxNkXAG5TpjwC218inRkElvKaOhacze6sZg5ArKDa+7IBH1iegyn0oUlrPM
        o7DZseAg==;
Received: from 216-58-17-101.cpe.distributel.net ([216.58.17.101]:35012 helo=[192.168.1.4])
        by montreal.sibername.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <bjlockie@lockie.ca>)
        id 1jpwsi-008jFf-MB; Mon, 29 Jun 2020 12:44:06 -0400
Subject: Re: Alfa AWUS036ACM (Mediatek MT7612U) AP problem
To:     Lorenzo Bianconi <lorenzo@kernel.org>
Cc:     Mathy Vanhoef <vanhoefm@gmail.com>,
        linux-wireless <linux-wireless@vger.kernel.org>
References: <ba64416e-d34b-9bdd-d482-6ea722e3d6b9@lockie.ca>
 <CAFXAJYwgRPAbY4i8XHNGzcyJg-11BwOSdDS6098eh_CEzxeEUQ@mail.gmail.com>
 <9c44f87b-eaa5-afcb-b830-30b2b36232d5@lockie.ca>
 <20200629091919.GA10533@localhost.localdomain>
From:   James <bjlockie@lockie.ca>
Message-ID: <589a2269-38e2-2897-1f68-6a4617fdf400@lockie.ca>
Date:   Mon, 29 Jun 2020 12:43:43 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200629091919.GA10533@localhost.localdomain>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-OutGoing-Spam-Status: No, score=-1.0
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - montreal.sibername.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - lockie.ca
X-Get-Message-Sender-Via: montreal.sibername.com: authenticated_id: bjlockie@lockie.ca
X-Authenticated-Sender: montreal.sibername.com: bjlockie@lockie.ca
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org



On 2020-06-29 5:19 a.m., Lorenzo Bianconi wrote:
>> Kernel 5.4.48 is better so far:
>> Uptime
>> 1d 18h 6m 32s
>> It sounds like it is only a matter of time since you have the problem on a
>> later kernel.
>> I did get rid of a cable and use a powered USB 3 hub.
> Can you please try to load the mt76_usb module with disable_usb_sg=1?
>
> Regards,
> Lorenzo
It just died, Uptime 2d 14h 23m 22s. :-(

Shouldn't modinfo list the available parameters?
# modinfo mt76_usb
module:         /lib/modules/5.4.48/mt76-usb.ko
license:        Dual BSD/GPL
depends:        mt76,mac80211
name:           mt76_usb
vermagic:       5.4.48 SMP mod_unload aarch64

# ls /sys/module/mt76_usb/parameters/
disable_usb_sg


# cat /sys/module/mt76_usb/parameters/disable_usb_sg
N

I've tried a few things in /etc/module.d but nothing worked yet.
I unplugged the dongle and did:
# echo 1 > /sys/module/mt76_usb/parameters/disable_usb_sg
I plugged in the dongle:
# cat /sys/module/mt76_usb/parameters/disable_usb_sg
Y

I found this old post that helped:
https://github.com/openwrt/mt76/issues/398
