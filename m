Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD4276D6D69
	for <lists+linux-wireless@lfdr.de>; Tue,  4 Apr 2023 21:48:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235739AbjDDTs6 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 4 Apr 2023 15:48:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230004AbjDDTs5 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 4 Apr 2023 15:48:57 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15BD4A8
        for <linux-wireless@vger.kernel.org>; Tue,  4 Apr 2023 12:48:56 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id ce4so9178128pfb.1
        for <linux-wireless@vger.kernel.org>; Tue, 04 Apr 2023 12:48:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680637735;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=9f4rYpvhS+Wesh3THbm1d/IXk5TjD3L5lWgHwExEUas=;
        b=F+XGY4GlMY/0LvOlY1uJxMn3ve2sCYhO5SAmAGCNUQHE9Z55ADpAiyN5iPl8bcvRq0
         uemn4DygqjydpqPlLzM6e7S2KrwgNWoOvGYSio3HyWzid9e748c7opJl39LRefQ7BH5q
         fCl+ADqtxEUY2Ahw57Xi1o88t8OIKfr9o2FFF589wIEmR3WtOgGdqlu5548eIiWLJBUU
         shFdNTsjl7JJ5YWbBzjkt6orWJeMtE2qIEvtMpe/3CxSgAhv+umzGGF1bcodAxm6aVn+
         o3Gv1MTHOmfDY7LHQhPoC7BG5jpSuo9Tvdxl7iiTHgtZ7TDfLBjlUAZLpBOPPzqEkeME
         nt3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680637735;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9f4rYpvhS+Wesh3THbm1d/IXk5TjD3L5lWgHwExEUas=;
        b=XesfzSVnUhTpXSVh27oBnw5mgoqPLSPqrGJ2qYMpaEltNecfgYXfGw3QM2Yf8kuY/S
         nuEJWVdorDuoeLUJ7d04LUHlO3HeXNifbTg6KD3EBkot+MW2gxHSDYxgySfwBh2mVTzb
         MuXVdgxp3xyrFos/Xn8cdd1DGStFBlbUxoOVHq1LQVnFKuwWnvcdVFZB1fRfPsT+O0Q2
         sVx6qWwWwfHvUjEVjfCNeLkeRUZPvan+cjXVNS6PMi7y54OHcOP3JBXkTJTAoLuWPYpW
         i44cNuNhOrrUWDCV70IaPqZGTLAbgacDoMuIJf5WXQn34tw+xwX9T1PCHygxz8J2Gr1c
         ddQQ==
X-Gm-Message-State: AAQBX9fbWSNYdF6VGTNOaVfpMAcREDB4BTe+tjU6A0QtnHQbuS0iWdX2
        A24wpK4rnokRAAsLbDZ1FKEhgzP60SXnTVrpTgokut69
X-Google-Smtp-Source: AKy350bKMgmkkrTXzgJu1P21mj+lZdpggkQEMQwYoHYb06+GOjccybyBJTXt3HEsUDVmCYNL91bxrpivGghWyygzj4Y=
X-Received: by 2002:a05:6a00:2e8a:b0:625:73a7:326f with SMTP id
 fd10-20020a056a002e8a00b0062573a7326fmr1853122pfb.3.1680637735463; Tue, 04
 Apr 2023 12:48:55 -0700 (PDT)
MIME-Version: 1.0
References: <CADUzMVYz8zJ13cunSKbtKrArsiSCr2m5k7QuwsP0nvyuVLrK6Q@mail.gmail.com>
 <1ca8aafd-63c8-95f4-82fa-457b14a8c0d5@gmail.com>
In-Reply-To: <1ca8aafd-63c8-95f4-82fa-457b14a8c0d5@gmail.com>
From:   Ioannis Barkas <jnyb.de@gmail.com>
Date:   Tue, 4 Apr 2023 22:48:44 +0300
Message-ID: <CADUzMVYFAv+9=6vSOHjmuoKzqy1UBJ8m4q0h_c==-pXmouYi=w@mail.gmail.com>
Subject: Re: TL-WN823N Realtek WPA3 SSID connection problem #9
To:     Bitterblue Smith <rtl8821cerfe2@gmail.com>
Cc:     linux-wireless@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hello,

As low as it goes. This is a port for keyboard/mouse usage.

Nothing useful was seen in dmesg. Will make a kernel with your patch,
test it at the weekend and tell you how it goes. I have a PCI USB 1.1
only controller to test it as well!

Thanks

On Thu, 16 Mar 2023 at 16:18, Bitterblue Smith <rtl8821cerfe2@gmail.com> wrote:
>
> On 25/11/2022 21:40, Ioannis Barkas wrote:
> > Hello,
> >
> > I have tested various USB devices and all worked except the TL-WN823N.
> > This device has never worked and we have 2 of them.
> >
> > On Ubuntu boot I get:
> > [ 1208.638541] usb 1-1: RTL8192EU rev B (SMIC) 2T2R, TX queues 3,
> > WiFi=1, BT=0, GPS=0, HI PA=0
> > [ 1208.638553] usb 1-1: RTL8192EU MAC: d4:6e:0e:**:**:**
> > [ 1208.638560] usb 1-1: rtl8xxxu: Loading firmware rtlwifi/rtl8192eu_nic.bin
> > [ 1208.641483] usb 1-1: Firmware revision 19.0 (signature 0x92e1)
> > [ 1209.735452] usbcore: registered new interface driver rtl8xxxu
> >
> > When I attempt to connect at a 2,4GHz WPA3 SSID this is what I get:
> > [ 1502.319954] wlxd46e0eeba0f4: authenticate with c6:27:28:**:**:**
> > [ 1502.332105] wlxd46e0eeba0f4: send auth to c6:27:28:**:**:** (try 1/3)
> > [ 1502.476159] wlxd46e0eeba0f4: authenticate with c6:27:28:**:**:**
> > [ 1502.476181] wlxd46e0eeba0f4: send auth to c6:27:28:**:**:** (try 1/3)
> > [ 1502.587356] wlxd46e0eeba0f4: authenticated
> > [ 1502.589113] wlxd46e0eeba0f4: associate with c6:27:28:**:**:** (try 1/3)
> > [ 1502.593773] wlxd46e0eeba0f4: RX AssocResp from c6:27:28:**:**:**
> > (capab=0x1431 status=0 aid=16)
> > [ 1502.595559] usb 1-1: rtl8xxxu_bss_info_changed: HT supported
> > [ 1502.597222] wlxd46e0eeba0f4: associated
> > [ 1502.743847] wlxd46e0eeba0f4: deauthenticating from
> > c6:27:28:**:**:** by local choice (Reason: 1=UNSPECIFIED)
> >
> > To make things worse, I accidentally inserted it in a USB 1.1 port on
> > my AMD test PC and it could not even connect to a combo 2,4GHz WPA2,3
> > SSID:
> > [ 1001.681485] wlxd46e0eeba0f4: authenticate with c6:27:28:**:**:**
> > [ 1001.703190] wlxd46e0eeba0f4: send auth to c6:27:28:**:**:** (try 1/3)
> > [ 1001.904265] wlxd46e0eeba0f4: send auth to c6:27:28:**:**:** (try 2/3)
> > [ 1002.108231] wlxd46e0eeba0f4: send auth to c6:27:28:**:**:** (try 3/3)
> > [ 1002.312262] wlxd46e0eeba0f4: authentication with c6:27:28:**:**:** timed out
> > [ 1013.501401] wlxd46e0eeba0f4: authenticate with c6:27:28:**:**:**
> > [ 1013.523483] wlxd46e0eeba0f4: send auth to c6:27:28:**:**:** (try 1/3)
> > [ 1013.724276] wlxd46e0eeba0f4: send auth to c6:27:28:**:**:** (try 2/3)
> > [ 1013.928271] wlxd46e0eeba0f4: send auth to c6:27:28:**:**:** (try 3/3)
> > [ 1014.132282] wlxd46e0eeba0f4: authentication with c6:27:28:**:**:** timed out
> > [ 1027.230375] wlxd46e0eeba0f4: authenticate with c6:27:28:**:**:**
> > [ 1027.242103] wlxd46e0eeba0f4: send auth to c6:27:28:**:**:** (try 1/3)
> > [ 1027.444258] wlxd46e0eeba0f4: send auth to c6:27:28:**:**:** (try 2/3)
> > [ 1027.648271] wlxd46e0eeba0f4: send auth to c6:27:28:**:**:** (try 3/3)
> > [ 1027.852237] wlxd46e0eeba0f4: authentication with c6:27:28:**:**:** timed out
> >
>
> So this problem is fixed now since kernels 4.14.308 4.19.276 5.4.235
> 5.10.173 5.15.99 6.1.16 6.2.3 6.3-rc1.
>
> > On USB 2.0 port the problem with WPA2,3 SSID was resolved. Is it
> > possible to set a flag so that the driver will bail out if the device
> > is on a USB 1.1 port? The truth is that the maximum speed it reached
> > was way below the 12Mb of USB 1.1 so it should not have a problem but
> > in practise it does...
> >
>
> I'm curious about the low speed. How low is it? Do you see anything
> in dmesg? Does this patch fix it?
> https://bugzilla.kernel.org/attachment.cgi?id=302960
>
> The driver can be modified to support USB 1.1 at least with some of the
> chips, but I don't have USB 1.1 to test it.
>
> >  This is the device:
> > Device Descriptor:
> >   bLength                18
> >   bDescriptorType         1
> >   bcdUSB               2.10
> >   bDeviceClass            0
> >   bDeviceSubClass         0
> >   bDeviceProtocol         0
> >   bMaxPacketSize0        64
> >   idVendor           0x2357 TP-Link
> >   idProduct          0x0109 TL-WN823N v2/v3 [Realtek RTL8192EU]
> >   bcdDevice            2.00
> >   iManufacturer           1 Realtek
> >   iProduct                2 802.11n NIC
> >   iSerial                 3 00**********
> >   bNumConfigurations      1
> >   Configuration Descriptor:
> >     bLength                 9
> >     bDescriptorType         2
> >     wTotalLength       0x0035
> >     bNumInterfaces          1
> >     bConfigurationValue     1
> >     iConfiguration          0
> >     bmAttributes         0xe0
> >       Self Powered
> >       Remote Wakeup
> >     MaxPower              500mA
> >     Interface Descriptor:
> >       bLength                 9
> >       bDescriptorType         4
> >       bInterfaceNumber        0
> >       bAlternateSetting       0
> >       bNumEndpoints           5
> >       bInterfaceClass       255 Vendor Specific Class
> >       bInterfaceSubClass    255 Vendor Specific Subclass
> >       bInterfaceProtocol    255 Vendor Specific Protocol
> >       iInterface              2 802.11n NIC
> >       Endpoint Descriptor:
> >         bLength                 7
> >         bDescriptorType         5
> >         bEndpointAddress     0x84  EP 4 IN
> >         bmAttributes            2
> >           Transfer Type            Bulk
> >           Synch Type               None
> >           Usage Type               Data
> >         wMaxPacketSize     0x0200  1x 512 bytes
> >         bInterval               0
> >       Endpoint Descriptor:
> >         bLength                 7
> >         bDescriptorType         5
> >         bEndpointAddress     0x05  EP 5 OUT
> >         bmAttributes            2
> >           Transfer Type            Bulk
> >           Synch Type               None
> >           Usage Type               Data
> >         wMaxPacketSize     0x0200  1x 512 bytes
> >         bInterval               0
> >       Endpoint Descriptor:
> >         bLength                 7
> >         bDescriptorType         5
> >         bEndpointAddress     0x06  EP 6 OUT
> >         bmAttributes            2
> >           Transfer Type            Bulk
> >           Synch Type               None
> >           Usage Type               Data
> >         wMaxPacketSize     0x0200  1x 512 bytes
> >         bInterval               0
> >       Endpoint Descriptor:
> >         bLength                 7
> >         bDescriptorType         5
> >         bEndpointAddress     0x87  EP 7 IN
> >         bmAttributes            3
> >           Transfer Type            Interrupt
> >           Synch Type               None
> >           Usage Type               Data
> >         wMaxPacketSize     0x0040  1x 64 bytes
> >         bInterval               3
> >       Endpoint Descriptor:
> >         bLength                 7
> >         bDescriptorType         5
> >         bEndpointAddress     0x08  EP 8 OUT
> >         bmAttributes            2
> >           Transfer Type            Bulk
> >           Synch Type               None
> >           Usage Type               Data
> >         wMaxPacketSize     0x0200  1x 512 bytes
> >         bInterval               0
> > Binary Object Store Descriptor:
> >   bLength                 5
> >   bDescriptorType        15
> >   wTotalLength       0x000c
> >   bNumDeviceCaps          1
> >   USB 2.0 Extension Device Capability:
> >     bLength                 7
> >     bDescriptorType        16
> >     bDevCapabilityType      2
> >     bmAttributes   0x00000002
> >       HIRD Link Power Management (LPM) Supported
> > Device Status:     0x0001
> >   Self Powered
>
