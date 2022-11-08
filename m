Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C6A7621F63
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Nov 2022 23:36:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229509AbiKHWgm (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 8 Nov 2022 17:36:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbiKHWgk (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 8 Nov 2022 17:36:40 -0500
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22EDB51C3C
        for <linux-wireless@vger.kernel.org>; Tue,  8 Nov 2022 14:36:39 -0800 (PST)
Received: by mail-ot1-x32c.google.com with SMTP id p8-20020a056830130800b0066bb73cf3bcso9175372otq.11
        for <linux-wireless@vger.kernel.org>; Tue, 08 Nov 2022 14:36:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=NG++oP1x5QjFaPhyGFGUkXXMsErrIoKg1NlTP7YuHOw=;
        b=qYgNjad6HSAqH0XF2ue3Ywqxba8o6Y6+5pE5odi8d7gxIrL1J9FAJ/2RTqMJkj/WFu
         UOxa8RWmcz35iMpIDterDWyzrkt/6QeEwe0ow1WW0TNEW75fXZtshm9vWZ8FK17rsmn5
         CYxejjkgQvkZf980a5W8yVVvhEfXhzRhNSMFWCwlW8k/rf5Mkg2Xw0lZZTavWE5qXLur
         kCavhgXEMA2H/uKibdKDTb90VoxH+Mw9xaxQFkJXcuBaYBujUW/QxkRFbKMClYymTQDe
         5kk/MPqf+a+csLBXP53IoseNKEzthVANFf6jI+rw0vk8bE8WHTm6R94dnNFKiGauVwUg
         DtXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NG++oP1x5QjFaPhyGFGUkXXMsErrIoKg1NlTP7YuHOw=;
        b=rN349EJ2g2qFJEE26LP9DWvnZIxT4AMr0uiF/usJORk98jT0ANA8FjyloRcBX6IN8S
         H4/ODb3O6uZATQuzDh0azqavhkc4F2sDHM2nQhfVICJGE0KciVumB9iJ4X12nnnigKeK
         SkGMkUR4CQpaaIy199p3gFHiPVXUqq12GEZOaayfdTffLmVBqAVM2h5jYDCdOGLPNxer
         Liqh3xKRGDdGAFySnHGJOsTzyLcum9Sp5XaKcIw94/NtrmKN8KVoYXKmqzygsufkKztl
         AULsp/Bqz4yH3Su8p8iiKjSU/NjcXc+3Bjlq1QkL1vs2U8DPLDFCww3JtXxUkDZIjKYS
         +83Q==
X-Gm-Message-State: ACrzQf3BFQy4GPkvJaP20TAsAujZVUesxdudNTZ4WXTLcRfTOUPgajdx
        9oxpD/U/AX5UPp2A3Dug1Z7hzY4TNbg=
X-Google-Smtp-Source: AMsMyM4bulsh4Kq+MZTFWqXpQzmbh/yFwalbAdtZuKX7owjK8n+EDMmXiHaleGl42WO9PSU5XF18qA==
X-Received: by 2002:a9d:68cf:0:b0:66c:7459:de7 with SMTP id i15-20020a9d68cf000000b0066c74590de7mr18372088oto.156.1667946998393;
        Tue, 08 Nov 2022 14:36:38 -0800 (PST)
Received: from [192.168.1.119] ([216.130.59.33])
        by smtp.gmail.com with ESMTPSA id z26-20020a056808065a00b003544822f725sm3996782oih.8.2022.11.08.14.36.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Nov 2022 14:36:37 -0800 (PST)
Sender: Larry Finger <larry.finger@gmail.com>
Message-ID: <fd317fc1-70e3-44bd-912a-07ce9aec0b86@lwfinger.net>
Date:   Tue, 8 Nov 2022 16:36:37 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: rtlwifi: RTL8188EE: Unable to connect to Wifi network
Content-Language: en-US
To:     Paul Menzel <pmenzel@molgen.mpg.de>,
        Ping-Ke Shih <pkshih@realtek.com>
Cc:     linux-wireless@vger.kernel.org, it+linux-wireless@molgen.mpg.de
References: <eb1885f2-abd9-1f1f-1c3e-c879372d8db0@molgen.mpg.de>
 <4899c9d3-acad-6cc0-e1ec-ab4b27754ecb@molgen.mpg.de>
From:   Larry Finger <Larry.Finger@lwfinger.net>
In-Reply-To: <4899c9d3-acad-6cc0-e1ec-ab4b27754ecb@molgen.mpg.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 11/8/22 10:18, Paul Menzel wrote:
> Dear Linux folks,
> 
> 
> Am 08.11.22 um 13:49 schrieb Paul Menzel:
> 
>> Using Debian sid/unstable with Linux 6.1-rc3 [1] on an Intel Haswell Haier 
>> laptop with a RTL8188EE, I am unable to connect to a wireless network.
>>
>>      $ sudo lspci -k -s 08:00.0
>>      08:00.0 Network controller: Realtek Semiconductor Co., Ltd. RTL8188EE 
>> Wireless Network Adapter (rev 01)
>>          Subsystem: AzureWave RTL8188EE Wireless Network Adapter
>>          Kernel driver in use: rtl8188ee
>>          Kernel modules: rtl8188ee
>>
>> ```
>> [  262.822320] wlp8s0: authenticate with 6c:f3:7f:10:ae:12
>> [  262.822341] wlp8s0: 80 MHz not supported, disabling VHT
>> [  262.832384] wlp8s0: send auth to 6c:f3:7f:10:ae:12 (try 1/3)
>> [  262.835124] wlp8s0: authenticated
>> [  262.839046] wlp8s0: associate with 6c:f3:7f:10:ae:12 (try 1/3)
>> [  262.850099] wlp8s0: RX AssocResp from 6c:f3:7f:10:ae:12 (capab=0x421 
>> status=0 aid=1)
>> [  262.850331] wlp8s0: associated
>> [  262.850925] IPv6: ADDRCONF(NETDEV_CHANGE): wlp8s0: link becomes ready
>> […]
>> [  307.618423] wlp8s0: deauthenticating from 6c:f3:7f:10:ae:12 by local choice 
>> (Reason: 3=DEAUTH_LEAVING)
>> ```
>>
>> wpa_supplicant 2:2.10-9+b2 logs:
>>
>> ```
>> Nov 08 13:29:35 brecht wpa_supplicant[612]: wlp8s0: SME: Trying to 
>> authenticate with 6c:f3:7f:10:ae:12 (SSID='MPI Guest' freq=2437 MHz)
>> Nov 08 13:29:35 brecht wpa_supplicant[612]: wlp8s0: Trying to associate with 
>> 6c:f3:7f:10:ae:12 (SSID='MPI Guest' freq=2437 MHz)
>> Nov 08 13:29:35 brecht wpa_supplicant[612]: wlp8s0: Associated with 
>> 6c:f3:7f:10:ae:12
>> Nov 08 13:29:35 brecht wpa_supplicant[612]: wlp8s0: CTRL-EVENT-CONNECTED - 
>> Connection to 6c:f3:7f:10:ae:12 completed [id=0 id_str=]
>> Nov 08 13:29:35 brecht wpa_supplicant[612]: bgscan simple: Failed to enable 
>> signal strength monitoring
>> Nov 08 13:29:35 brecht wpa_supplicant[612]: wlp8s0: 
>> CTRL-EVENT-SUBNET-STATUS-UPDATE status=0
>> Nov 08 13:30:20 brecht wpa_supplicant[612]: wlp8s0: CTRL-EVENT-DISCONNECTED 
>> bssid=6c:f3:7f:10:ae:12 reason=3  locally_generated=1
>> ```
>>
>> With more debugging verbosity (`-d`) it shows:
>>
>> ```
>> […]
>> Nov 08 13:42:13 brecht wpa_supplicant[3547]: wlp8s0: State: ASSOCIATED -> 
>> COMPLETED
>> Nov 08 13:42:13 brecht wpa_supplicant[3547]: wlp8s0: Radio work 
>> 'sme-connect'@0x556b491b5a80 done in 0.026679 seconds
>> Nov 08 13:42:13 brecht wpa_supplicant[3547]: wlp8s0: 
>> radio_work_free('sme-connect'@0x556b491b5a80): num_active_works --> 0
>> Nov 08 13:42:13 brecht wpa_supplicant[3547]: wlp8s0: CTRL-EVENT-CONNECTED - 
>> Connection to 6c:f3:7f:10:ae:12 completed [id=0 id_str=]
>> Nov 08 13:42:13 brecht wpa_supplicant[3547]: nl80211: Set wlp8s0 operstate 
>> 0->1 (UP)
>> Nov 08 13:42:13 brecht wpa_supplicant[3547]: netlink: Operstate: ifindex=3 
>> linkmode=-1 (no change), operstate=6 (IF_OPER_UP)
>> Nov 08 13:42:13 brecht wpa_supplicant[3547]: bgscan simple: Signal strength 
>> threshold -70  Short bgscan interval 30  Long bgscan interval 86400
>> Nov 08 13:42:13 brecht wpa_supplicant[3547]: nl80211: Signal monitor 
>> threshold=-70 hysteresis=4
>> Nov 08 13:42:13 brecht wpa_supplicant[3547]: bgscan simple: Failed to enable 
>> signal strength monitoring
>> Nov 08 13:42:13 brecht wpa_supplicant[3547]: bgscan simple: Init scan 
>> interval: 86400
>> Nov 08 13:42:13 brecht wpa_supplicant[3547]: bgscan: Initialized module 
>> 'simple' with parameters '30:-70:86400'
>> Nov 08 13:42:13 brecht wpa_supplicant[3547]: nl80211: Received scan results 
>> (19 BSSes)
>> Nov 08 13:42:13 brecht wpa_supplicant[3547]: nl80211: Scan results indicate 
>> BSS status with 6c:f3:7f:10:ae:12 as associated
>> Nov 08 13:42:13 brecht wpa_supplicant[3547]: wlp8s0: BSS: Start scan result 
>> update 5
>> Nov 08 13:42:13 brecht wpa_supplicant[3547]: bgscan simple: scan result 
>> notification
>> Nov 08 13:42:13 brecht wpa_supplicant[3547]: wlp8s0: Determining shared radio 
>> frequencies (max len 1)
>> Nov 08 13:42:13 brecht wpa_supplicant[3547]: wlp8s0: Shared frequencies 
>> (len=1): completed iteration
>> Nov 08 13:42:13 brecht wpa_supplicant[3547]: wlp8s0: freq[0]: 2437, flags=0x1
>> Nov 08 13:42:13 brecht wpa_supplicant[3547]: P2P: Add operating class 81
>> Nov 08 13:42:13 brecht wpa_supplicant[3547]: P2P: Channels - hexdump(len=13): 
>> 01 02 03 04 05 06 07 08 09 0a 0b 0c 0d
>> Nov 08 13:42:13 brecht wpa_supplicant[3547]: P2P: Update channel list
>> Nov 08 13:42:13 brecht wpa_supplicant[3547]: P2P: channels: 
>> 81:1,2,3,4,5,6,7,8,9,10,11,12,13
>> Nov 08 13:42:13 brecht wpa_supplicant[3547]: P2P: cli_channels:
>> Nov 08 13:42:13 brecht wpa_supplicant[3547]: wlp8s0: Cancelling scan request
>> Nov 08 13:42:13 brecht wpa_supplicant[3547]: WMM AC: AC mandatory: AC_BE=0 
>> AC_BK=0 AC_VI=0 AC_VO=0
>> Nov 08 13:42:13 brecht wpa_supplicant[3547]: WMM AC: U-APSD queues=0x0
>> Nov 08 13:42:13 brecht wpa_supplicant[3547]: WMM AC: Valid WMM association, 
>> WMM AC is enabled
>> Nov 08 13:42:13 brecht wpa_supplicant[3547]: wlp8s0: 
>> CTRL-EVENT-SUBNET-STATUS-UPDATE status=0
>> Nov 08 13:42:13 brecht wpa_supplicant[3547]: RTM_NEWLINK: ifi_index=3 
>> ifname=wlp8s0 operstate=6 linkmode=1 ifi_family=0 ifi_flags=0x11043 
>> ([UP][RUNNING][LOWER_UP])
>> Nov 08 13:42:13 brecht wpa_supplicant[3547]: nl80211: Drv Event 46 
>> (NL80211_CMD_CONNECT) received for wlp8s0
>> Nov 08 13:42:13 brecht wpa_supplicant[3547]: nl80211: Ignore connect event 
>> (cmd=46) when using userspace SME
>> Nov 08 13:42:58 brecht wpa_supplicant[3547]: nl80211: Drv Event 20 
>> (NL80211_CMD_DEL_STATION) received for wlp8s0
>> Nov 08 13:42:58 brecht wpa_supplicant[3547]: nl80211: Delete station 
>> 6c:f3:7f:10:ae:12
>> Nov 08 13:42:58 brecht wpa_supplicant[3547]: nl80211: Drv Event 39 
>> (NL80211_CMD_DEAUTHENTICATE) received for wlp8s0
>> Nov 08 13:42:58 brecht wpa_supplicant[3547]: nl80211: Deauthenticate event
>> Nov 08 13:42:58 brecht wpa_supplicant[3547]: wlp8s0: Event DEAUTH (11) received
>> Nov 08 13:42:58 brecht wpa_supplicant[3547]: wlp8s0: Deauthentication 
>> notification
>> Nov 08 13:42:58 brecht wpa_supplicant[3547]: wlp8s0:  * reason 3 
>> (DEAUTH_LEAVING) locally_generated=1
>> Nov 08 13:42:58 brecht wpa_supplicant[3547]: wlp8s0:  * address 6c:f3:7f:10:ae:12
>> Nov 08 13:42:58 brecht wpa_supplicant[3547]: Deauthentication frame IE(s) - 
>> hexdump(len=0): [NULL]
>> Nov 08 13:42:58 brecht wpa_supplicant[3547]: wlp8s0: CTRL-EVENT-DISCONNECTED 
>> bssid=6c:f3:7f:10:ae:12 reason=3 locally_generated=1
>> ```
>>
>> It’d be really great to get WLAN working on the device.
> 
> I tested Debian 11 Live ISO with Linux 5.10 and wpa_supplicant 2.9, and it has 
> the same problem. I configured iwd, and ran iwmon, which got a trace [2] (where 
> I unplugged the Ethernet cable during the trace).

I cannot duplicate your problem. When I installed the RTL8188EE chip in my 
computer, wifi connected immediately, even before I connected an external antenna.

My configuration is openSUSE Tumbleweed running a 6.1-rc4 kernel. The network is 
controlled by NetworkManager v1.40.2 with wpa_supplicant v2.10-4.

Larry

