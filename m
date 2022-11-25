Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DECBE637FBE
	for <lists+linux-wireless@lfdr.de>; Thu, 24 Nov 2022 20:41:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229479AbiKXTl1 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 24 Nov 2022 14:41:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbiKXTl1 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 24 Nov 2022 14:41:27 -0500
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3B3F742F4
        for <linux-wireless@vger.kernel.org>; Thu, 24 Nov 2022 11:41:24 -0800 (PST)
Received: by mail-lj1-x22d.google.com with SMTP id d3so3005244ljl.1
        for <linux-wireless@vger.kernel.org>; Thu, 24 Nov 2022 11:41:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=lbUNRv/ESSSOOb8WWlAC7KZ2luDcut9jnFGCvFEfWYk=;
        b=ZnWc37bx2jR7PTBrOUGKA3xqndL3cZcob3pM/zT0Rq7qc4+k5d2rDm4An0elVV9DbE
         NVsY4mH0A5VZIsF+M2HTGlM0gtIGabN0EJGwkj9nEDi6xsszEDXp8rfIxNAmqhHx2ms/
         AxuVEPUNh6A/ZJt/9YRGbnGbhb+cIcxGD6+gIKR79hykgyBlDLIxjrjN+L8y3962UlgK
         Q6afZaOBQm8KvrLqp36MCbpaE0yAGsbhWiTWg58FRvwBjYv/nYZXk124L+w6DieLzbaM
         8LCsLGnlYnJzRb4xf5zU7l17P+4Hqc2CFjXW6BwVjgnN45KVT8PhXDqvMXZvh9qwMhJH
         40CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lbUNRv/ESSSOOb8WWlAC7KZ2luDcut9jnFGCvFEfWYk=;
        b=L+/9lbqKqnL3cFdtA5xOZ9z4z8jpd8UJn4RSLNSg62fgxP5t8AT66NWDoQ0qbM/3yk
         K1gM8edEctUgDvLSxwKzafPZlXX79AiTSQMfp4+M+LoW8g/CmMzqhp8NPmImKyw8wmL2
         B10jyWWO5FczoOk/cdCcnGzL1rwcST3qzvFgKbOTDAjhuS0JpwS6YU/hU0Mfi3k5GI0V
         jt5F+3sVcDXJ4Lkj5wmnyIDXhfUDrAcVs9WcdVHDtCeZEz3pL5JPmWZmEuaqPSP7swx4
         iY5P9UyJHYqCNlfdoHKoQgXwC9TrneLn6pkQNWX/Q7uHbm9SHvi455O/UNbK1h4H5vfp
         bVTQ==
X-Gm-Message-State: ANoB5pn54/h2Ofxy9i8hQhEpGeMyjzziKtDZeGMpLBbUV7ycoxmQkADv
        s3uqLRqTgN4IoqOy2Xy2WekpQiBFGdagqhJqrKVrFOCh/sEJjQ==
X-Google-Smtp-Source: AA0mqf5qwTLUSq9Z9hUmFwJgC1P086bjom5VKvDTO7Hv9GMv/mOmolwk8rEeLV24LRCefXiIsOnNwsbepaznxV5rGEw=
X-Received: by 2002:a2e:a594:0:b0:277:4150:b560 with SMTP id
 m20-20020a2ea594000000b002774150b560mr5332847ljp.299.1669318883083; Thu, 24
 Nov 2022 11:41:23 -0800 (PST)
MIME-Version: 1.0
From:   Ioannis Barkas <jnyb.de@gmail.com>
Date:   Fri, 25 Nov 2022 21:40:12 +0200
Message-ID: <CADUzMVYz8zJ13cunSKbtKrArsiSCr2m5k7QuwsP0nvyuVLrK6Q@mail.gmail.com>
Subject: TL-WN823N Realtek WPA3 SSID connection problem #9
To:     linux-wireless@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=1.1 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_12_24,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hello,

I have tested various USB devices and all worked except the TL-WN823N.
This device has never worked and we have 2 of them.

On Ubuntu boot I get:
[ 1208.638541] usb 1-1: RTL8192EU rev B (SMIC) 2T2R, TX queues 3,
WiFi=1, BT=0, GPS=0, HI PA=0
[ 1208.638553] usb 1-1: RTL8192EU MAC: d4:6e:0e:**:**:**
[ 1208.638560] usb 1-1: rtl8xxxu: Loading firmware rtlwifi/rtl8192eu_nic.bin
[ 1208.641483] usb 1-1: Firmware revision 19.0 (signature 0x92e1)
[ 1209.735452] usbcore: registered new interface driver rtl8xxxu

When I attempt to connect at a 2,4GHz WPA3 SSID this is what I get:
[ 1502.319954] wlxd46e0eeba0f4: authenticate with c6:27:28:**:**:**
[ 1502.332105] wlxd46e0eeba0f4: send auth to c6:27:28:**:**:** (try 1/3)
[ 1502.476159] wlxd46e0eeba0f4: authenticate with c6:27:28:**:**:**
[ 1502.476181] wlxd46e0eeba0f4: send auth to c6:27:28:**:**:** (try 1/3)
[ 1502.587356] wlxd46e0eeba0f4: authenticated
[ 1502.589113] wlxd46e0eeba0f4: associate with c6:27:28:**:**:** (try 1/3)
[ 1502.593773] wlxd46e0eeba0f4: RX AssocResp from c6:27:28:**:**:**
(capab=0x1431 status=0 aid=16)
[ 1502.595559] usb 1-1: rtl8xxxu_bss_info_changed: HT supported
[ 1502.597222] wlxd46e0eeba0f4: associated
[ 1502.743847] wlxd46e0eeba0f4: deauthenticating from
c6:27:28:**:**:** by local choice (Reason: 1=UNSPECIFIED)

To make things worse, I accidentally inserted it in a USB 1.1 port on
my AMD test PC and it could not even connect to a combo 2,4GHz WPA2,3
SSID:
[ 1001.681485] wlxd46e0eeba0f4: authenticate with c6:27:28:**:**:**
[ 1001.703190] wlxd46e0eeba0f4: send auth to c6:27:28:**:**:** (try 1/3)
[ 1001.904265] wlxd46e0eeba0f4: send auth to c6:27:28:**:**:** (try 2/3)
[ 1002.108231] wlxd46e0eeba0f4: send auth to c6:27:28:**:**:** (try 3/3)
[ 1002.312262] wlxd46e0eeba0f4: authentication with c6:27:28:**:**:** timed out
[ 1013.501401] wlxd46e0eeba0f4: authenticate with c6:27:28:**:**:**
[ 1013.523483] wlxd46e0eeba0f4: send auth to c6:27:28:**:**:** (try 1/3)
[ 1013.724276] wlxd46e0eeba0f4: send auth to c6:27:28:**:**:** (try 2/3)
[ 1013.928271] wlxd46e0eeba0f4: send auth to c6:27:28:**:**:** (try 3/3)
[ 1014.132282] wlxd46e0eeba0f4: authentication with c6:27:28:**:**:** timed out
[ 1027.230375] wlxd46e0eeba0f4: authenticate with c6:27:28:**:**:**
[ 1027.242103] wlxd46e0eeba0f4: send auth to c6:27:28:**:**:** (try 1/3)
[ 1027.444258] wlxd46e0eeba0f4: send auth to c6:27:28:**:**:** (try 2/3)
[ 1027.648271] wlxd46e0eeba0f4: send auth to c6:27:28:**:**:** (try 3/3)
[ 1027.852237] wlxd46e0eeba0f4: authentication with c6:27:28:**:**:** timed out

On USB 2.0 port the problem with WPA2,3 SSID was resolved. Is it
possible to set a flag so that the driver will bail out if the device
is on a USB 1.1 port? The truth is that the maximum speed it reached
was way below the 12Mb of USB 1.1 so it should not have a problem but
in practise it does...

 This is the device:
Device Descriptor:
  bLength                18
  bDescriptorType         1
  bcdUSB               2.10
  bDeviceClass            0
  bDeviceSubClass         0
  bDeviceProtocol         0
  bMaxPacketSize0        64
  idVendor           0x2357 TP-Link
  idProduct          0x0109 TL-WN823N v2/v3 [Realtek RTL8192EU]
  bcdDevice            2.00
  iManufacturer           1 Realtek
  iProduct                2 802.11n NIC
  iSerial                 3 00**********
  bNumConfigurations      1
  Configuration Descriptor:
    bLength                 9
    bDescriptorType         2
    wTotalLength       0x0035
    bNumInterfaces          1
    bConfigurationValue     1
    iConfiguration          0
    bmAttributes         0xe0
      Self Powered
      Remote Wakeup
    MaxPower              500mA
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        0
      bAlternateSetting       0
      bNumEndpoints           5
      bInterfaceClass       255 Vendor Specific Class
      bInterfaceSubClass    255 Vendor Specific Subclass
      bInterfaceProtocol    255 Vendor Specific Protocol
      iInterface              2 802.11n NIC
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x84  EP 4 IN
        bmAttributes            2
          Transfer Type            Bulk
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0200  1x 512 bytes
        bInterval               0
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x05  EP 5 OUT
        bmAttributes            2
          Transfer Type            Bulk
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0200  1x 512 bytes
        bInterval               0
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x06  EP 6 OUT
        bmAttributes            2
          Transfer Type            Bulk
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0200  1x 512 bytes
        bInterval               0
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x87  EP 7 IN
        bmAttributes            3
          Transfer Type            Interrupt
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0040  1x 64 bytes
        bInterval               3
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x08  EP 8 OUT
        bmAttributes            2
          Transfer Type            Bulk
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0200  1x 512 bytes
        bInterval               0
Binary Object Store Descriptor:
  bLength                 5
  bDescriptorType        15
  wTotalLength       0x000c
  bNumDeviceCaps          1
  USB 2.0 Extension Device Capability:
    bLength                 7
    bDescriptorType        16
    bDevCapabilityType      2
    bmAttributes   0x00000002
      HIRD Link Power Management (LPM) Supported
Device Status:     0x0001
  Self Powered
