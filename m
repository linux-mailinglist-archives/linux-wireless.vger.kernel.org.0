Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CE0F0519A8
	for <lists+linux-wireless@lfdr.de>; Mon, 24 Jun 2019 19:36:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732457AbfFXRgM (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 24 Jun 2019 13:36:12 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:40218 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731032AbfFXRgM (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 24 Jun 2019 13:36:12 -0400
Received: by mail-io1-f65.google.com with SMTP id n5so3947690ioc.7
        for <linux-wireless@vger.kernel.org>; Mon, 24 Jun 2019 10:36:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=cCiyhIV/ZeFps9bulDzwuhxM9PeQf2HAeqdgaNA09+M=;
        b=Nfxbn8e6e2Irl2TLmRVS9gwxS/u2Gl0Lkhn0e9v1/PZNgWPYofpLYZzonxRW9q2Y3/
         9v8dZJaywk+R1TiPBUPRDw7dzhxW4EF61bDRXXU3xmPOFNJ2zK54dTHKdbOxPwWX7oEX
         f4fRcslXd+t9Q0L/5trMIGTNnbdF/G1YqZJGRytBBBUNV1quWUwehV9My0brH+wPgAzn
         6copeSQyXsx1EJvbWYI5lGBrp6PD3Js6onRn37zuamFNZU0Coicch0U2wYYRZxAy9Nc9
         YRLNpt3y1otRUo/XU6NSVqFHnZeD0PHJKkj4Wv3fgaQyGGki4fXxscmDfTpWqN880o8G
         o1wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=cCiyhIV/ZeFps9bulDzwuhxM9PeQf2HAeqdgaNA09+M=;
        b=DDE/o3XXjqEx3LsDrO6TmwmgLxEDAPJwFVCSHJ4+lDobz58k2gLV/x4cpAGt2ZvpMB
         PtJ7ipEFjh/0Qp3p6qnDcvGP/4RQfid0KrKJ6ZKJkl305aJ36IqJvMtJG5kzc0IQBxn3
         RHdnmwh1VvcmsirZZkUl3BGVqR3GWNPJiKAVEfilMRtSIkOptiD4NKBm+Ywtz5B1x+57
         Qd8YZCsdJFcNdzdX9/pITlNW3Q6p21keH/VhccvmhDab66kyFxqpffOQ43DfWge0f4ey
         ZwZRVOqQZJCsc6LcH64Ew+3CtM/j+BQOJFiwQquTDoXPKUd3bqN1xMM3XZgRtdJMWalD
         CRzg==
X-Gm-Message-State: APjAAAU+5U5RHNGpp3UHxotG+zgnwKWUWf4NiZTlsKo33obs8xPbKmGQ
        e1cDNC0XECKZXJsIIY+LbkkNnbc4
X-Google-Smtp-Source: APXvYqwX1STdk2X1XivtMhMTc1sFIlq3N6Xk4g4BlDpYWZrOGHBqUiULcVyzYsQ/6UNWVF++owmpRg==
X-Received: by 2002:a6b:7017:: with SMTP id l23mr1397072ioc.159.1561397770998;
        Mon, 24 Jun 2019 10:36:10 -0700 (PDT)
Received: from new-host-2.home ([2605:a601:808:1001:37ba:4f0a:192f:f945])
        by smtp.googlemail.com with ESMTPSA id b8sm15327473ioj.16.2019.06.24.10.36.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 24 Jun 2019 10:36:09 -0700 (PDT)
Subject: Re: [PATCH v2 2/3] nl80211: Limit certain commands to interface owner
To:     Arend Van Spriel <arend.vanspriel@broadcom.com>,
        Marcel Holtmann <marcel@holtmann.org>
Cc:     Johannes Berg <johannes@sipsolutions.net>,
        linux-wireless@vger.kernel.org
References: <20190620220749.10071-1-denkenz@gmail.com>
 <20190620220749.10071-2-denkenz@gmail.com>
 <11852f40-67e5-9122-7d82-077bdd0b014a@broadcom.com>
 <af810765-ba1a-c7ae-abe5-35eef72eb8ce@gmail.com>
 <b1ae8df6-c8a7-e453-aad3-e31bb2e3bd60@broadcom.com>
 <011C968F-507F-4646-B206-C28BDE7EB4A0@holtmann.org>
 <08e810c0-84ca-3a63-eee4-e4c09d41f92c@broadcom.com>
From:   Denis Kenzior <denkenz@gmail.com>
Message-ID: <c248d0be-5ecf-7b75-a00d-4212cbec3c17@gmail.com>
Date:   Mon, 24 Jun 2019 12:36:08 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <08e810c0-84ca-3a63-eee4-e4c09d41f92c@broadcom.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Arend,

On 06/24/2019 03:39 AM, Arend Van Spriel wrote:
> On 6/22/2019 3:44 PM, Marcel Holtmann wrote:
>> Hi Arend,
>>
>>>>>> If the wdev object has been created (via NEW_INTERFACE) with
>>>>>> SOCKET_OWNER attribute set, then limit certain commands only to the
>>>>>> process that created that wdev.
>>>>>>
>>>>>> This can be used to make sure no other process on the system 
>>>>>> interferes
>>>>>> by sending unwanted scans, action frames or any other funny business.
>>>>>
>>>>> The flag is a good addition opposed to having handlers deal with 
>>>>> it. However, earlier motivation for SOCKET_OWNER use was about 
>>>>> netlink multicast being unreliable, which I can agree to. However, 
>>>>> avoiding
>>>> ???  I can't agree to that as I have no idea what you're talking 
>>>> about :)  Explain?  SOCKET_OWNER was introduced mainly to bring down 
>>>> links / scans / whatever in case the initiating process died.  As a 
>>>> side effect it also helped in the beginning when users ran iwd + 
>>>> wpa_s simultaneously (by accident) and all sorts of fun ensued.  We 
>>>> then re-used SOCKET_OWNER for running EAPoL over NL80211.  But 
>>>> 'multicast unreliability' was never an issue that I recall?
>>>
>>> hmm. I tried searching in memory... of my email client but to no 
>>> avail. I somehow recalled that netlink multicast was not guaranteed 
>>> to be delivered/seen by all listeners.
>>>
>>>>> "funny business" is a different thing. Our testing infrastructure 
>>>>> is doing all kind of funny business. Guess we will need to refrain 
>>>>> from
>>>> So you're going behind the managing daemon's back and messing with 
>>>> the kernel state...  I guess the question is why?  But really, if 
>>>> wpa_s wants to tolerate that, that is their problem :)  iwd doesn't 
>>>> want to, nor do we want to deal with the various race conditions and 
>>>> corner cases associated with that.  Life is hard as it is ;)
>>>
>>> That's just it, right. This is what Marcel calls the real 
>>> environment, but is it. The nl80211 is a kernel API and should that 
>>> mean that there must be a managing daemon locking down APIs for other 
>>> user-space tools to use. If I want a user-space app to show a radar 
>>> screen with surrounding APs using scanning and FTM nl80211 commands 
>>> it seems now it has to create a new interface and hope the resources 
>>> are there for it to succeed. Where is my freedom in that? If I am 
>>> using such an app don't you think I don't accept it could impact the 
>>> managing daemon.
>>
>> if you are operating on a shared radio resource you have to have some 
>> way of ensuring that nobody steals resources from you. Having an 
>> external application that will also use scanning and other off-channel 
>> operation will result in a bad experience. Especially if it involves 
>> scanning. Currently we still have 3 or more parties triggering 
>> scanning on nl80211. Essentially they are now fighting for radio time. 
>> You have wpa_supplicant scanning, you have NetworkManager scanning and 
>> you have the UI scanning. Now adding just another application that 
>> just scans at its decided time location / direction finding is not 
>> helping the situation.
> 
> My app was just a hypothetical example. I understand your conundrum, but 
> my point was that you can not know how a system is configured. Now for 
> the SOCKET_OWNER I should say it does not provide you any guarantees. At 
> best it improves your chances. With the nl80211 API being as it is, you 
> can not rule out multiple application controlling the same device. The 
> virtual interfaces can be guarded with SOCKET_OWNER, but in the end 

+1, SOCKET_OWNER is a band-aid.  But in the end this is a fairly simple 
change.   So we can have the managing daemon destroy any existing wdevs 
and re-create them with SOCKET_OWNER set (can we get brcmfmac to support 
this please?).  This at least gives us a chance that nothing will 
inadvertently cause interference.  It won't stop other processes from 
creating other wdevs or other funny business, but that is currently much 
more rare anyway.  In case it really becomes a problem, we can at least 
say "Don't hold it that way."

> there is still one physical device and only if you are lucky you may 
> come across a device with two physical radios, but most of them just 
> have one. If you really want to be in control we should allow only one 
> socket or at least only one "control" socket.

+1.  I've been saying this for a while, there should only be a single 
controlling socket/process, or at least an option for something like 
that.  But the current nl80211 design makes this quite hard.  Hopefully 
the recognition that this is needed will gain traction, until then we're 
stuck with band-aids.

> 
>> If our kernel cfg80211 / nl80211 would be smart enough to handle these 
>> concurrent tasks, I would have little objection to let all clients do 
>> whatever they want, but we don’t have that. I do not want an external 
>> application messing with my planned radio time. And frankly if I am in 
>> the middle of roaming, I don’t want to be delayed because some fancy 
>> radar looking UI decides to start a full spectrum scan or blocks us 
>> via an action frame that times out.
> 
> The have been some efforts to handle concurrent use. For scheduled scan 
> concurrency was added and critical proto primitives allow to temporarily 
> disable scans when user-space needs it, eg. for EAPOL or DHCP exchange.

Which only a single driver seems to support, unfortunately.

Regards,
-Denis

> 
>> With iwd we are moving towards the direction that we are utilizing the 
>> information from access points and surrounding networks to 
>> intelligently scan and reduce the time spent scanning to a minimum. 
>> For us that is the way to improve WiFi experience for Linux.
>>
>> We have been through this with Bluetooth already years ago. You need a 
>> central daemon that watches out for your radio utilization. Doing 
>> anything behind the back of such a daemon is not going to work out 
>> long term. Same applies to 2G/3G/LTE where even more tasks need to be 
>> managed. And even wpa_supplicant has an internal mutex to control 
>> radio time.
> 
> Right. Given how nl80211 works today the only real control of radio time 
> would need to be done in kernel space or go for the one "control" socket 
> approach.
> 
> Regards,
> Arend
