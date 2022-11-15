Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F9F462A0B0
	for <lists+linux-wireless@lfdr.de>; Tue, 15 Nov 2022 18:48:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229926AbiKORsA (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 15 Nov 2022 12:48:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbiKORr6 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 15 Nov 2022 12:47:58 -0500
Received: from mx1.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3CCEDFF3
        for <linux-wireless@vger.kernel.org>; Tue, 15 Nov 2022 09:47:56 -0800 (PST)
Received: from [141.14.14.54] (v054.vpnx.molgen.mpg.de [141.14.14.54])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        (Authenticated sender: pmenzel)
        by mx.molgen.mpg.de (Postfix) with ESMTPSA id 75C9661EA1930;
        Tue, 15 Nov 2022 18:47:54 +0100 (CET)
Message-ID: <1f635ca8-28df-8762-4484-2b5daf896bb7@molgen.mpg.de>
Date:   Tue, 15 Nov 2022 18:47:54 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: rtlwifi: RTL8188EE: Unable to connect to Wifi network
Content-Language: en-US
To:     Larry Finger <Larry.Finger@lwfinger.net>,
        Ping-Ke Shih <pkshih@realtek.com>
Cc:     linux-wireless@vger.kernel.org, it+linux-wireless@molgen.mpg.de
References: <eb1885f2-abd9-1f1f-1c3e-c879372d8db0@molgen.mpg.de>
 <4899c9d3-acad-6cc0-e1ec-ab4b27754ecb@molgen.mpg.de>
 <fd317fc1-70e3-44bd-912a-07ce9aec0b86@lwfinger.net>
From:   Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <fd317fc1-70e3-44bd-912a-07ce9aec0b86@lwfinger.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Dear Larry, dear Ping-Ke,


Thank you very much for your replies.

Am 08.11.22 um 23:36 schrieb Larry Finger:
> On 11/8/22 10:18, Paul Menzel wrote:

[…]

>> Am 08.11.22 um 13:49 schrieb Paul Menzel:
>>
>>> Using Debian sid/unstable with Linux 6.1-rc3 [1] on an Intel Haswell 
>>> Haier laptop with a RTL8188EE, I am unable to connect to a wireless 
>>> network.
>>>
>>>      $ sudo lspci -k -s 08:00.0
>>>      08:00.0 Network controller: Realtek Semiconductor Co., Ltd. 
>>> RTL8188EE Wireless Network Adapter (rev 01)
>>>          Subsystem: AzureWave RTL8188EE Wireless Network Adapter
>>>          Kernel driver in use: rtl8188ee
>>>          Kernel modules: rtl8188ee
>>>
>>> ```
>>> [  262.822320] wlp8s0: authenticate with 6c:f3:7f:10:ae:12
>>> [  262.822341] wlp8s0: 80 MHz not supported, disabling VHT
>>> [  262.832384] wlp8s0: send auth to 6c:f3:7f:10:ae:12 (try 1/3)
>>> [  262.835124] wlp8s0: authenticated
>>> [  262.839046] wlp8s0: associate with 6c:f3:7f:10:ae:12 (try 1/3)
>>> [  262.850099] wlp8s0: RX AssocResp from 6c:f3:7f:10:ae:12 (capab=0x421 status=0 aid=1)
>>> [  262.850331] wlp8s0: associated
>>> [  262.850925] IPv6: ADDRCONF(NETDEV_CHANGE): wlp8s0: link becomes ready
>>> […]
>>> [  307.618423] wlp8s0: deauthenticating from 6c:f3:7f:10:ae:12 by local choice (Reason: 3=DEAUTH_LEAVING)
>>> ```
>>>
>>> wpa_supplicant 2:2.10-9+b2 logs:

[…]

>>> With more debugging verbosity (`-d`) it shows:

[…]
>>> It’d be really great to get WLAN working on the device.
>>
>> I tested Debian 11 Live ISO with Linux 5.10 and wpa_supplicant 2.9, 
>> and it has the same problem. I configured iwd, and ran iwmon, which 
>> got a trace [2] (where I unplugged the Ethernet cable during the trace).
> 
> I cannot duplicate your problem. When I installed the RTL8188EE chip in 
> my computer, wifi connected immediately, even before I connected an 
> external antenna.
> 
> My configuration is openSUSE Tumbleweed running a 6.1-rc4 kernel. The 
> network is controlled by NetworkManager v1.40.2 with wpa_supplicant 
> v2.10-4.

Thank you for checking. Just a quick update, the user reported back, 
that Wifi is working fine at here home. So it must be some 
incompatibility with our institute Aruba access points/Wifi.

Hopefully I have more time next week to gather more logs.


Kind regards,

Paul
