Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9104B6380BF
	for <lists+linux-wireless@lfdr.de>; Thu, 24 Nov 2022 22:53:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229670AbiKXVxr (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 24 Nov 2022 16:53:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbiKXVxq (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 24 Nov 2022 16:53:46 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3220C7D29E
        for <linux-wireless@vger.kernel.org>; Thu, 24 Nov 2022 13:53:45 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id b12so4258015wrn.2
        for <linux-wireless@vger.kernel.org>; Thu, 24 Nov 2022 13:53:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ngu1CIQFG0i6NVFieICuM3EKBCgKRhaAt6rvXknyjFg=;
        b=IGXOmMjYA2aXICEhmQEAfD2EInR1AlIMIYtJnJyTPH4boatb2fgaX4wiNSWTBtC1HV
         q2HT+TLbdD8znCo1OauKUlOP87a9k8GZADH04CVaIne9K+RLXNvVhZ0x0SbZHj6U6iS8
         Ks6Ng2GHrUs5EtyJCtq3j/70fpx7cuhAjmuExRoTimNunIz2aTKfBmY88UdsFxeICfg6
         rhzAymTdV0ZQtOvuqO4n0FdS18AJ1Ty+4IaHlaeOW8Ddh24OwnD2CKuCHYG6ad+5IdR1
         que/4NpxMymFnQEJRA4CFKHHgPEjllaycdXG5J9Co/fvGH/WPV664rTj94gFVS9jZM8f
         YMJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ngu1CIQFG0i6NVFieICuM3EKBCgKRhaAt6rvXknyjFg=;
        b=NuEsEgTvMpwl/XdyBF6F5mKmrs8eerYmN976PCh4ZFDuDZ1KZh1xp/SkAG9GRiVC1+
         sGFEf3VmO36u/ksrXjseW46fxFt+Yk6haBeHFQw0yi9kyQwMjp+X4x2i2Sgl61GU+/a2
         v4wfDncVw7dQyvA2Y7e7DEyYKIhds9CEzT780Ga0DTDfbDL8r4a1ZEBmZtJW3XGlJqXZ
         oEDERSJ+3eWngBkEWlQcFJhl0/Rjsi6g/4tqDvRzqGBs+FErYVHFysPEJaAEJUtHHJos
         WWB3wnC/hpsTP0b6WbWVrHDavUPeh8mi1KqxgbutRlbDPu8za1dO4QbC03BtmsMT9XHj
         6a9A==
X-Gm-Message-State: ANoB5pkoNBiM2QMGxFkQNpjNLiVy+sLYtaJJned1Nwiaezi5GXDEJT5W
        BB+pwuD9tM9+3xahBrSrybk=
X-Google-Smtp-Source: AA0mqf7lLS82mhVa7jJV00VLF4uLIxpgEyDK7JzYUNLvW5oL5a3yf2OVPuCt6TS8zGiVE1qXjIfY4Q==
X-Received: by 2002:adf:e5c4:0:b0:236:9701:97d2 with SMTP id a4-20020adfe5c4000000b00236970197d2mr14948143wrn.185.1669326823510;
        Thu, 24 Nov 2022 13:53:43 -0800 (PST)
Received: from [192.168.1.50] ([79.119.240.254])
        by smtp.gmail.com with ESMTPSA id h3-20020a05600c2ca300b003cff309807esm7235477wmc.23.2022.11.24.13.53.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Nov 2022 13:53:43 -0800 (PST)
Message-ID: <f1775b71-97fc-8b23-6ae1-319aa26c414a@gmail.com>
Date:   Thu, 24 Nov 2022 23:53:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: TL-WN823N Realtek WPA3 SSID connection problem #9
To:     Ioannis Barkas <jnyb.de@gmail.com>, linux-wireless@vger.kernel.org
References: <CADUzMVYz8zJ13cunSKbtKrArsiSCr2m5k7QuwsP0nvyuVLrK6Q@mail.gmail.com>
Content-Language: en-US
From:   Bitterblue Smith <rtl8821cerfe2@gmail.com>
In-Reply-To: <CADUzMVYz8zJ13cunSKbtKrArsiSCr2m5k7QuwsP0nvyuVLrK6Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 25/11/2022 21:40, Ioannis Barkas wrote:
> Hello,
> 
> I have tested various USB devices and all worked except the TL-WN823N.
> This device has never worked and we have 2 of them.
> 
> On Ubuntu boot I get:
> [ 1208.638541] usb 1-1: RTL8192EU rev B (SMIC) 2T2R, TX queues 3,
> WiFi=1, BT=0, GPS=0, HI PA=0
> [ 1208.638553] usb 1-1: RTL8192EU MAC: d4:6e:0e:**:**:**
> [ 1208.638560] usb 1-1: rtl8xxxu: Loading firmware rtlwifi/rtl8192eu_nic.bin
> [ 1208.641483] usb 1-1: Firmware revision 19.0 (signature 0x92e1)
> [ 1209.735452] usbcore: registered new interface driver rtl8xxxu
> 
> When I attempt to connect at a 2,4GHz WPA3 SSID this is what I get:
> [ 1502.319954] wlxd46e0eeba0f4: authenticate with c6:27:28:**:**:**
> [ 1502.332105] wlxd46e0eeba0f4: send auth to c6:27:28:**:**:** (try 1/3)
> [ 1502.476159] wlxd46e0eeba0f4: authenticate with c6:27:28:**:**:**
> [ 1502.476181] wlxd46e0eeba0f4: send auth to c6:27:28:**:**:** (try 1/3)
> [ 1502.587356] wlxd46e0eeba0f4: authenticated
> [ 1502.589113] wlxd46e0eeba0f4: associate with c6:27:28:**:**:** (try 1/3)
> [ 1502.593773] wlxd46e0eeba0f4: RX AssocResp from c6:27:28:**:**:**
> (capab=0x1431 status=0 aid=16)
> [ 1502.595559] usb 1-1: rtl8xxxu_bss_info_changed: HT supported
> [ 1502.597222] wlxd46e0eeba0f4: associated
> [ 1502.743847] wlxd46e0eeba0f4: deauthenticating from
> c6:27:28:**:**:** by local choice (Reason: 1=UNSPECIFIED)
> 
> To make things worse, I accidentally inserted it in a USB 1.1 port on
> my AMD test PC and it could not even connect to a combo 2,4GHz WPA2,3
> SSID:
> [ 1001.681485] wlxd46e0eeba0f4: authenticate with c6:27:28:**:**:**
> [ 1001.703190] wlxd46e0eeba0f4: send auth to c6:27:28:**:**:** (try 1/3)
> [ 1001.904265] wlxd46e0eeba0f4: send auth to c6:27:28:**:**:** (try 2/3)
> [ 1002.108231] wlxd46e0eeba0f4: send auth to c6:27:28:**:**:** (try 3/3)
> [ 1002.312262] wlxd46e0eeba0f4: authentication with c6:27:28:**:**:** timed out
> [ 1013.501401] wlxd46e0eeba0f4: authenticate with c6:27:28:**:**:**
> [ 1013.523483] wlxd46e0eeba0f4: send auth to c6:27:28:**:**:** (try 1/3)
> [ 1013.724276] wlxd46e0eeba0f4: send auth to c6:27:28:**:**:** (try 2/3)
> [ 1013.928271] wlxd46e0eeba0f4: send auth to c6:27:28:**:**:** (try 3/3)
> [ 1014.132282] wlxd46e0eeba0f4: authentication with c6:27:28:**:**:** timed out
> [ 1027.230375] wlxd46e0eeba0f4: authenticate with c6:27:28:**:**:**
> [ 1027.242103] wlxd46e0eeba0f4: send auth to c6:27:28:**:**:** (try 1/3)
> [ 1027.444258] wlxd46e0eeba0f4: send auth to c6:27:28:**:**:** (try 2/3)
> [ 1027.648271] wlxd46e0eeba0f4: send auth to c6:27:28:**:**:** (try 3/3)
> [ 1027.852237] wlxd46e0eeba0f4: authentication with c6:27:28:**:**:** timed out
> 
> On USB 2.0 port the problem with WPA2,3 SSID was resolved. Is it
> possible to set a flag so that the driver will bail out if the device
> is on a USB 1.1 port? The truth is that the maximum speed it reached
> was way below the 12Mb of USB 1.1 so it should not have a problem but
> in practise it does...

I believe the authentication failure is not related to USB 1.1. I get
that even with USB 2.0. It's probably intermittent, the best kind of
failure. Because of this and other problems, the standard advice on
various internet forums is "blacklist rtl8xxxu, install
Mange/rtl8192eu-linux-driver". I will look into it someday soon (ish).

> 
>  This is the device:
> Device Descriptor:
>   bLength                18
>   bDescriptorType         1
>   bcdUSB               2.10
>   bDeviceClass            0
>   bDeviceSubClass         0
>   bDeviceProtocol         0
>   bMaxPacketSize0        64
>   idVendor           0x2357 TP-Link
>   idProduct          0x0109 TL-WN823N v2/v3 [Realtek RTL8192EU]
>   bcdDevice            2.00
>   iManufacturer           1 Realtek
>   iProduct                2 802.11n NIC
>   iSerial                 3 00**********
>   bNumConfigurations      1
>   Configuration Descriptor:
>     bLength                 9
>     bDescriptorType         2
>     wTotalLength       0x0035
>     bNumInterfaces          1
>     bConfigurationValue     1
>     iConfiguration          0
>     bmAttributes         0xe0
>       Self Powered
>       Remote Wakeup
>     MaxPower              500mA
>     Interface Descriptor:
>       bLength                 9
>       bDescriptorType         4
>       bInterfaceNumber        0
>       bAlternateSetting       0
>       bNumEndpoints           5
>       bInterfaceClass       255 Vendor Specific Class
>       bInterfaceSubClass    255 Vendor Specific Subclass
>       bInterfaceProtocol    255 Vendor Specific Protocol
>       iInterface              2 802.11n NIC
>       Endpoint Descriptor:
>         bLength                 7
>         bDescriptorType         5
>         bEndpointAddress     0x84  EP 4 IN
>         bmAttributes            2
>           Transfer Type            Bulk
>           Synch Type               None
>           Usage Type               Data
>         wMaxPacketSize     0x0200  1x 512 bytes
>         bInterval               0
>       Endpoint Descriptor:
>         bLength                 7
>         bDescriptorType         5
>         bEndpointAddress     0x05  EP 5 OUT
>         bmAttributes            2
>           Transfer Type            Bulk
>           Synch Type               None
>           Usage Type               Data
>         wMaxPacketSize     0x0200  1x 512 bytes
>         bInterval               0
>       Endpoint Descriptor:
>         bLength                 7
>         bDescriptorType         5
>         bEndpointAddress     0x06  EP 6 OUT
>         bmAttributes            2
>           Transfer Type            Bulk
>           Synch Type               None
>           Usage Type               Data
>         wMaxPacketSize     0x0200  1x 512 bytes
>         bInterval               0
>       Endpoint Descriptor:
>         bLength                 7
>         bDescriptorType         5
>         bEndpointAddress     0x87  EP 7 IN
>         bmAttributes            3
>           Transfer Type            Interrupt
>           Synch Type               None
>           Usage Type               Data
>         wMaxPacketSize     0x0040  1x 64 bytes
>         bInterval               3
>       Endpoint Descriptor:
>         bLength                 7
>         bDescriptorType         5
>         bEndpointAddress     0x08  EP 8 OUT
>         bmAttributes            2
>           Transfer Type            Bulk
>           Synch Type               None
>           Usage Type               Data
>         wMaxPacketSize     0x0200  1x 512 bytes
>         bInterval               0
> Binary Object Store Descriptor:
>   bLength                 5
>   bDescriptorType        15
>   wTotalLength       0x000c
>   bNumDeviceCaps          1
>   USB 2.0 Extension Device Capability:
>     bLength                 7
>     bDescriptorType        16
>     bDevCapabilityType      2
>     bmAttributes   0x00000002
>       HIRD Link Power Management (LPM) Supported
> Device Status:     0x0001
>   Self Powered

