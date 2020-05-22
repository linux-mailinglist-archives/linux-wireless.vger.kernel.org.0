Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 539331DF0E8
	for <lists+linux-wireless@lfdr.de>; Fri, 22 May 2020 23:06:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731050AbgEVVGb (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 22 May 2020 17:06:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730963AbgEVVGa (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 22 May 2020 17:06:30 -0400
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54B0AC061A0E
        for <linux-wireless@vger.kernel.org>; Fri, 22 May 2020 14:06:29 -0700 (PDT)
Received: by mail-ot1-x343.google.com with SMTP id f18so9272710otq.11
        for <linux-wireless@vger.kernel.org>; Fri, 22 May 2020 14:06:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=DueuK3vWul+3EpOAZh9VPG7ANORPr8gGvdYxsT8vMV0=;
        b=Hri1J4FsCUSsZzIUNkOKz9SajAxjhibEDpxmO+3r4AQuQPJ4K9V+gqEcRCZI5iPL9e
         +79qCw0+6JyL1qhMcx2w0Zj3cf0KZAzO6CwrYzJTBHGVzhpomThEkrIuI9AIo42d39+u
         umThnSNrhOnHUDZVeX82gfXM3FCT9t/RmjSQB99Mk89UJiTxSEIvjxK59Te0v79c8hGL
         2TpS5Q77pCY5m44sGphkOxPy4sAzWi3ajY05242W6p5FnA74nOg+5z0XleWXGeiB8FX9
         FXoBdavMrjU1WodBH922jHroSSK/hXpHvqbhIA1+IcStohfzTpaQT+iVOY56jgH4LKRf
         ywrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=DueuK3vWul+3EpOAZh9VPG7ANORPr8gGvdYxsT8vMV0=;
        b=nl6ti10Mo72s32tKVQkLjhOV6d5GRjDRJQL4/BTAm5JeywS/bHYzGjslEBo8MQzGta
         mx2TVYh6XSygrTTd0xOad/oGgy4claAFyvPZWqzDzt9aG3lXQ39+KVWVqMlQfKGY8aDh
         uPImw/yUwI7K3WyDBA+YlWcRg4Zp32qvOut33K7N9aRFh7pTWLFIaElJmDkLn1HphtkX
         an8n6JbPni4n7WF2sclnPimtIi8FpfLXLksod0/mDCskwCnqG0qAt4jKcykf+IK4qb0e
         UzMB5mtnUuF8U9z6vsYxrfZkMYYxTkD1CE55sbrU5CzPU+S/Rg/Cjsi7TcxFe5eq04CL
         kBsg==
X-Gm-Message-State: AOAM531H61jF7gNADHcIe74qnbrUzXuYXXJP6HnqumI44vBkWWQeTh2M
        20VUYC+vF7Xh5B0gmyn12NY=
X-Google-Smtp-Source: ABdhPJyplkmaLgm8ThcrKCegncWiUWa6h8WRPxPnBEYL9LqbKwn5VVfi6uRbR3NLiYg7mMEEnXEPCg==
X-Received: by 2002:a05:6830:118d:: with SMTP id u13mr11996765otq.362.1590181588757;
        Fri, 22 May 2020 14:06:28 -0700 (PDT)
Received: from localhost.localdomain (cpe-24-31-245-230.kc.res.rr.com. [24.31.245.230])
        by smtp.gmail.com with ESMTPSA id l8sm2770632otr.7.2020.05.22.14.06.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 May 2020 14:06:28 -0700 (PDT)
Subject: Re: [BUG?] b43: can't connect to WPA3 network (nohwcrypt=1)
To:     Rui Salvaterra <rsalvaterra@gmail.com>
Cc:     Kalle Valo <kvalo@codeaurora.org>,
        =?UTF-8?Q?Michael_B=c3=bcsch?= <m@bues.ch>,
        linux-wireless@vger.kernel.org, b43-dev@lists.infradead.org
References: <CALjTZvbLOr5zAYyp75Cs6Zo8mWNUVq3ZRJu56G1iHdiihFejWQ@mail.gmail.com>
 <CALjTZvYCFNSQ6HMN4owkiGTVrYaiU8R-P1KXgvkwGqcOo8uMuw@mail.gmail.com>
 <CALjTZvYMF_ERBfzkhaHvsTu6kt7MW+L_979sOVs8hcH7zF_Nyg@mail.gmail.com>
 <20200521124608.4b5c78f2@wiggum>
 <CALjTZvan46UTwcUxOSN=RiE6XHm-29Ln8B6wiv40V_RVxWewtA@mail.gmail.com>
 <20200521134011.656381ad@wiggum>
 <CALjTZvZcfT-aURMa=j-1ksWyVdu42bLEsGOaq+Hw39ioiPFKAA@mail.gmail.com>
 <CALjTZvY3_wjAx9DOEgYxpc4_fG-HWh_=O7veFxeEoygPzTJptw@mail.gmail.com>
 <2b22b778-2f89-9c42-93a0-5c165de26f35@lwfinger.net>
 <CALjTZva70Ni-s5VjRZL5BPswEtz5VZsX+dvE6rq2ztLJQ9v3kA@mail.gmail.com>
 <CALjTZvbvE_cDg9mfszscSBowznp1UpxqiN1LQfbgeCOYatKMNg@mail.gmail.com>
 <f6152cd7-1043-dde2-7fc1-634d8b07a231@lwfinger.net>
 <20200522121910.254aefc1@wiggum> <87a720gpfb.fsf@tynnyri.adurom.net>
 <CALjTZvYiFfqN3UMSM89Pg1rB9fJga+L1hVkBriEDeaej7oXcPw@mail.gmail.com>
 <f1f97888-e7f6-d272-6ed1-8c040d8a7c91@lwfinger.net>
 <CALjTZvZV4kwLgoTijxsC2AYcxGeT1R_fsTdh3Gb=M03Rn_RsAg@mail.gmail.com>
From:   Larry Finger <Larry.Finger@lwfinger.net>
Message-ID: <8252e6a1-b83c-64eb-2503-2686374216ae@lwfinger.net>
Date:   Fri, 22 May 2020 16:06:27 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <CALjTZvZV4kwLgoTijxsC2AYcxGeT1R_fsTdh3Gb=M03Rn_RsAg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 5/22/20 3:40 PM, Rui Salvaterra wrote:
> On Fri, 22 May 2020 at 19:02, Larry Finger <Larry.Finger@lwfinger.net> wrote:
>>
>> Rui,
>>
>> Does this one-line
>> patch work for WPA3 without setting the nohwcrypt option?
> 
> Ok, so it "works", but I don't know what actually happened (I didn't
> do any performance testing yet). I got this relevant output on my
> kmsg…
> 
> rui@mcnugget:~$ dmesg | awk '(/80211/ || /b43/ || /wlan0/)'
> [    0.000000] Kernel command line: BOOT_IMAGE=/vmlinux-5.7.0-rc6+
> root=UUID=849bbef3-007e-491e-b187-9e259680c2e2 ro mitigations=off
> b43.qos=0 b43.verbose=3 usbhid.mousepoll=16 quiet splash
> [    0.035705] b43-pci-bridge 0001:10:12.0: enabling device (0004 -> 0006)
> [    0.210299] b43-pci-bridge 0001:10:12.0: Sonics Silicon Backplane
> found on PCI device 0001:10:12.0
> [    3.361908] b43-phy0: Broadcom 4318 WLAN found (core revision 9)
> [    3.454235] b43-phy0: Found PHY: Analog 3, Type 2 (G), Revision 7
> [    3.454259] b43-phy0: Found Radio: Manuf 0x17F, ID 0x2050, Revision
> 8, Version 0
> [    3.485125] ieee80211 phy0: Selected rate control algorithm 'minstrel_ht'
> [   28.697945] b43-phy0: Loading firmware version 666.2 (2011-02-23 01:15:07)
> [   28.730381] b43-phy0 debug: Chip initialized
> [   28.731389] b43-phy0 debug: 32-bit DMA initialized
> [   28.731400] b43-phy0 debug: QoS disabled
> [   28.792272] b43-phy0 debug: Wireless interface started
> [   28.820318] b43-phy0 debug: Adding Interface type 2
> [   33.944771] wlan0: authenticate with 04:f0:21:24:28:44
> [   33.970449] wlan0: send auth to 04:f0:21:24:28:44 (try 1/3)
> [   34.026222] wlan0: authenticate with 04:f0:21:24:28:44
> [   34.026241] wlan0: send auth to 04:f0:21:24:28:44 (try 1/3)
> [   34.028522] wlan0: authenticated
> [   34.043256] wlan0: associate with 04:f0:21:24:28:44 (try 1/3)
> [   34.046946] wlan0: RX AssocResp from 04:f0:21:24:28:44 (capab=0x431
> status=30 aid=1)
> [   34.046964] wlan0: 04:f0:21:24:28:44 rejected association
> temporarily; comeback duration 1000 TU (1024 ms)
> [   35.122051] wlan0: associate with 04:f0:21:24:28:44 (try 2/3)
> [   35.125547] wlan0: RX AssocResp from 04:f0:21:24:28:44 (capab=0x431
> status=0 aid=1)
> [   35.125808] wlan0: associated
> [   35.268256] b43-phy0 debug: Using hardware based encryption for
> keyidx: 0, mac: 04:f0:21:24:28:44
> [   35.268762] b43-phy0 debug: Using hardware based encryption for
> keyidx: 2, mac: ff:ff:ff:ff:ff:ff
> [   35.358586] wlan0: failed to set key (5, ff:ff:ff:ff:ff:ff) to hardware (-22)
> [   35.358977] IPv6: ADDRCONF(NETDEV_CHANGE): wlan0: link becomes ready
> [   87.283220] wlan0: failed to set key (4, ff:ff:ff:ff:ff:ff) to hardware (-22)
> [   87.283521] b43-phy0 debug: Using hardware based encryption for
> keyidx: 1, mac: ff:ff:ff:ff:ff:ff
> rui@mcnugget:~$
> 
> Meanwhile, iw list shows all the possible software cyphers:
> 
>      Supported Ciphers:
>          * WEP40 (00-0f-ac:1)
>          * WEP104 (00-0f-ac:5)
>          * TKIP (00-0f-ac:2)
>          * CCMP-128 (00-0f-ac:4)
>          * CCMP-256 (00-0f-ac:10)
>          * GCMP-128 (00-0f-ac:8)
>          * GCMP-256 (00-0f-ac:9)
>          * CMAC (00-0f-ac:6)
>          * CMAC-256 (00-0f-ac:13)
>          * GMAC-128 (00-0f-ac:11)
>          * GMAC-256 (00-0f-ac:12)
> 
> What I'm not sure is if b43 is doing all the cyphers it supports in
> hardware and falling back to software just for the unsupported ones,
> or if it's doing everything in software.
It will do supported ciphers in hardware, and unsupported using software. The 
patch tells mac80211 that we will accept the newer ciphers, then in the 
set_key() callback, we tell it whether the current type will be handled in 
hardware. Operations will be transparent. I will keep the nohwcrypt option just 
in case someone has a hardware malfunction that prohibits hardware use for all 
ciphers, but it will not be needed in cases like yours. Performance will be as 
you did earlier.

Thanks for testing.

Larry


