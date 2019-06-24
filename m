Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B4640504AF
	for <lists+linux-wireless@lfdr.de>; Mon, 24 Jun 2019 10:39:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727381AbfFXIjg (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 24 Jun 2019 04:39:36 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:46924 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726351AbfFXIjg (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 24 Jun 2019 04:39:36 -0400
Received: by mail-wr1-f68.google.com with SMTP id n4so12872480wrw.13
        for <linux-wireless@vger.kernel.org>; Mon, 24 Jun 2019 01:39:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=xMZyuuOlQhjNkoxoa9jG3oDQNZIQAToAMM3i0+PpYcE=;
        b=WA0qZDnOjUCIFKz/H4yc22ZuoG7jM9QiPmb+0x3GLRBtUiZD1PbnrxQaB04SDekZ+A
         Te1kF6EhVawTjMVfxhEslE0YILn9xtJE3fUOOEkKBKHy44d8h3aUBN2vhkeSczC/gplX
         HIYhmEMqE28wL6NJwlE41S+UacYJdv05lXJjI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=xMZyuuOlQhjNkoxoa9jG3oDQNZIQAToAMM3i0+PpYcE=;
        b=HB0aM37k0/GKDwFPIuYqmOqQXyJncjOMQSM2v7UkLM+96zItUWAiY2kS5HRBsPYPjg
         1JU4+tkHCGte29nNIIO11QOOCCcxqUD3WQ3yH5wQtGucbhNrY7UHyPjTq8gf6USFbFPT
         Ryp8fhBviFnez/JTA0brHssXAntQwRm5sQR+QzfbnrflWlBddTJ5z2rHr+wqZtsWgtdG
         moSRI+mn9sg1XfPYHPGQZcq1lkLs1evIDi3qRV7c6G27PE7Y9Kyv1jKqCEW3DpRa6XI4
         3pEODcY4LOplmpiaEgiCrGKzto5tRtU+12xEiRgcrlZgMifTj03t7hJ5ucQdSHCC8w26
         gmPA==
X-Gm-Message-State: APjAAAV5XWZ5SeJeGoF69aTatZkHDUEqwgKEL4E+1hEE2lAANxbCwzps
        29yqIOaG+oQRGE1aIfkVYu7bonM95XNw6A6VxGkRGqNTolZ9iYEe5iGSaIqCODs8kL7IzeoHzvV
        qEezApsmFHmnBVnQNEDQpZZzV1tIPSaPFj6uVe9FTZdnq7QCQBhqKbVRshSoTne8c47L6dgQSLS
        9bz0MQzZssQ8xFTA==
X-Google-Smtp-Source: APXvYqwf7YnpJ0GPEbj1kpiPd5Gz2/v9bPZ5zvwUPbXOtSn57ijCi2k6vIab1QYroBuQVLTfWHCWEw==
X-Received: by 2002:a5d:4302:: with SMTP id h2mr12991774wrq.137.1561365572705;
        Mon, 24 Jun 2019 01:39:32 -0700 (PDT)
Received: from [10.176.68.244] ([192.19.248.250])
        by smtp.gmail.com with ESMTPSA id y19sm13744788wmc.21.2019.06.24.01.39.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 24 Jun 2019 01:39:31 -0700 (PDT)
Subject: Re: [PATCH v2 2/3] nl80211: Limit certain commands to interface owner
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     Denis Kenzior <denkenz@gmail.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        linux-wireless@vger.kernel.org
References: <20190620220749.10071-1-denkenz@gmail.com>
 <20190620220749.10071-2-denkenz@gmail.com>
 <11852f40-67e5-9122-7d82-077bdd0b014a@broadcom.com>
 <af810765-ba1a-c7ae-abe5-35eef72eb8ce@gmail.com>
 <b1ae8df6-c8a7-e453-aad3-e31bb2e3bd60@broadcom.com>
 <011C968F-507F-4646-B206-C28BDE7EB4A0@holtmann.org>
From:   Arend Van Spriel <arend.vanspriel@broadcom.com>
Message-ID: <08e810c0-84ca-3a63-eee4-e4c09d41f92c@broadcom.com>
Date:   Mon, 24 Jun 2019 10:39:30 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <011C968F-507F-4646-B206-C28BDE7EB4A0@holtmann.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 6/22/2019 3:44 PM, Marcel Holtmann wrote:
> Hi Arend,
> 
>>>>> If the wdev object has been created (via NEW_INTERFACE) with
>>>>> SOCKET_OWNER attribute set, then limit certain commands only to the
>>>>> process that created that wdev.
>>>>>
>>>>> This can be used to make sure no other process on the system interferes
>>>>> by sending unwanted scans, action frames or any other funny business.
>>>>
>>>> The flag is a good addition opposed to having handlers deal with it. However, earlier motivation for SOCKET_OWNER use was about netlink multicast being unreliable, which I can agree to. However, avoiding
>>> ???  I can't agree to that as I have no idea what you're talking about :)  Explain?  SOCKET_OWNER was introduced mainly to bring down links / scans / whatever in case the initiating process died.  As a side effect it also helped in the beginning when users ran iwd + wpa_s simultaneously (by accident) and all sorts of fun ensued.  We then re-used SOCKET_OWNER for running EAPoL over NL80211.  But 'multicast unreliability' was never an issue that I recall?
>>
>> hmm. I tried searching in memory... of my email client but to no avail. I somehow recalled that netlink multicast was not guaranteed to be delivered/seen by all listeners.
>>
>>>> "funny business" is a different thing. Our testing infrastructure is doing all kind of funny business. Guess we will need to refrain from
>>> So you're going behind the managing daemon's back and messing with the kernel state...  I guess the question is why?  But really, if wpa_s wants to tolerate that, that is their problem :)  iwd doesn't want to, nor do we want to deal with the various race conditions and corner cases associated with that.  Life is hard as it is ;)
>>
>> That's just it, right. This is what Marcel calls the real environment, but is it. The nl80211 is a kernel API and should that mean that there must be a managing daemon locking down APIs for other user-space tools to use. If I want a user-space app to show a radar screen with surrounding APs using scanning and FTM nl80211 commands it seems now it has to create a new interface and hope the resources are there for it to succeed. Where is my freedom in that? If I am using such an app don't you think I don't accept it could impact the managing daemon.
> 
> if you are operating on a shared radio resource you have to have some way of ensuring that nobody steals resources from you. Having an external application that will also use scanning and other off-channel operation will result in a bad experience. Especially if it involves scanning. Currently we still have 3 or more parties triggering scanning on nl80211. Essentially they are now fighting for radio time. You have wpa_supplicant scanning, you have NetworkManager scanning and you have the UI scanning. Now adding just another application that just scans at its decided time location / direction finding is not helping the situation.

My app was just a hypothetical example. I understand your conundrum, but 
my point was that you can not know how a system is configured. Now for 
the SOCKET_OWNER I should say it does not provide you any guarantees. At 
best it improves your chances. With the nl80211 API being as it is, you 
can not rule out multiple application controlling the same device. The 
virtual interfaces can be guarded with SOCKET_OWNER, but in the end 
there is still one physical device and only if you are lucky you may 
come across a device with two physical radios, but most of them just 
have one. If you really want to be in control we should allow only one 
socket or at least only one "control" socket.

> If our kernel cfg80211 / nl80211 would be smart enough to handle these concurrent tasks, I would have little objection to let all clients do whatever they want, but we don’t have that. I do not want an external application messing with my planned radio time. And frankly if I am in the middle of roaming, I don’t want to be delayed because some fancy radar looking UI decides to start a full spectrum scan or blocks us via an action frame that times out.

The have been some efforts to handle concurrent use. For scheduled scan 
concurrency was added and critical proto primitives allow to temporarily 
disable scans when user-space needs it, eg. for EAPOL or DHCP exchange.

> With iwd we are moving towards the direction that we are utilizing the information from access points and surrounding networks to intelligently scan and reduce the time spent scanning to a minimum. For us that is the way to improve WiFi experience for Linux.
> 
> We have been through this with Bluetooth already years ago. You need a central daemon that watches out for your radio utilization. Doing anything behind the back of such a daemon is not going to work out long term. Same applies to 2G/3G/LTE where even more tasks need to be managed. And even wpa_supplicant has an internal mutex to control radio time.

Right. Given how nl80211 works today the only real control of radio time 
would need to be done in kernel space or go for the one "control" socket 
approach.

Regards,
Arend
