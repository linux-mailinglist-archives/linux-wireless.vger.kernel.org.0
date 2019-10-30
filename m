Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EDFD3EA3DB
	for <lists+linux-wireless@lfdr.de>; Wed, 30 Oct 2019 20:10:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726922AbfJ3TKZ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 30 Oct 2019 15:10:25 -0400
Received: from mail-oi1-f170.google.com ([209.85.167.170]:33188 "EHLO
        mail-oi1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726325AbfJ3TKZ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 30 Oct 2019 15:10:25 -0400
Received: by mail-oi1-f170.google.com with SMTP id m193so2998758oig.0;
        Wed, 30 Oct 2019 12:10:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=9zBGeuRJAsojTp30lVr3SleNVsHIFJC9n4Zs2QOF5Ic=;
        b=sfX29vsHuA1eKJmwTZRoNYdUH4pMY2Cn/t5BIxFNf3JvjVAmjSTgyopVxQfBhzYqYR
         vAGlCgDR/jjIqDPDIzzGHdufNr2j9AzR0DRwxMndRuOzKzf2h0wsD+DERt0Mwp9A7cX8
         kGd7UjrGjUxqYEM8yDUEIrgMfqYrwUt339HY4bfJDBuu0Zv3OqpOKByVMqTolh2C8aJB
         uLZomxZ7n4exoNmhZRDSx8R3RGCURor/Ghlc+8nm0+idBXdYssZRAmFNmkxvvI1NlRlC
         ov8qpCz1MSKNV3t9wUxNFTYCL5e5sFwoHVnGMy4zNvACZQvKz7fvmQ08RSqNVaTFNrub
         NXew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=9zBGeuRJAsojTp30lVr3SleNVsHIFJC9n4Zs2QOF5Ic=;
        b=V2RcjtZEOUapbQZQOZz8EQnNBNFLeQcx5eHYd+9Tz8N1KR+cvXDLxX8SUZF3a70olp
         ZJc1UmZ37pswG35qziOQKLTmNWRno51Acl4IYpvDKjCdOwDZBm6MJVGxIWWMsg4NnXLm
         vnljOv0Z3dYogVtsz5on7wxZWDhTnqUCYS1O5BVlluwh6GkF7vkSDwlvlAzgumvq7Jxq
         XUwM42wGQ4bcA4NNZRsbfSlvcWWZqefVdFqotKOhDRksxBTV7VPhhff7oQNuIFri9iyX
         m8i4JQA26R6BpPt1d96TYzpkvR0BzXm0kWL2Wb4LpbYpwZj7gjyzLzQB4NT8sEIB1HDh
         uJIQ==
X-Gm-Message-State: APjAAAWIMH81W8ll7Txra7CbAv7OaEL+vOmnLG3k+QE2IrcIS4QOTuKz
        AnxDgZDCefrskoX2tG3nQRMOnHk4Bqu/mCTT3tT26/5w
X-Google-Smtp-Source: APXvYqwaJOu5wK8jhgwKH6DaGOvP7nmFWAgZFOuafCnQXcRhkRfgMHpJwZV74LJ20/RU8SMT1/2eUtaMSbfr8qmNcmA=
X-Received: by 2002:a54:448b:: with SMTP id v11mr656445oiv.155.1572462623555;
 Wed, 30 Oct 2019 12:10:23 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:7511:0:0:0:0:0 with HTTP; Wed, 30 Oct 2019 12:10:23
 -0700 (PDT)
From:   Tom Psyborg <pozega.tomislav@gmail.com>
Date:   Wed, 30 Oct 2019 20:10:23 +0100
Message-ID: <CAKR_QVLhy3qNni4Pgvn1Mi6jOM28r-RQ3AZQXXAbbgkm-d56EA@mail.gmail.com>
Subject: ath3k patch file not found
To:     linux-wireless <linux-wireless@vger.kernel.org>
Cc:     linux-firmware <linux-firmware@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi

After loading QCA9880 card on my laptop I noticed it has bluetooth
capabilities, lsusb identifies it as AR3012 BT4.0.

It is unable to start, according to message, due to missing patch file:

Bluetooth: Patch file not found ar3k/AthrBT_0x41010000.dfu

Anyone can tell how to obtain the related patch files, or is there a
way to modify existing ones to fit this device?

Here is complete lsusb output:

Bus 001 Device 003: ID 0cf3:3004 Atheros Communications, Inc. AR3012
Bluetooth 4.0
Device Descriptor:
  bLength                18
  bDescriptorType         1
  bcdUSB               1.10
  bDeviceClass          224 Wireless
  bDeviceSubClass         1 Radio Frequency
  bDeviceProtocol         1 Bluetooth
  bMaxPacketSize0        64
  idVendor           0x0cf3 Atheros Communications, Inc.
  idProduct          0x3004 AR3012 Bluetooth 4.0
  bcdDevice            0.01
  iManufacturer           0
  iProduct                0
  iSerial                 0
  bNumConfigurations      1
  Configuration Descriptor:
    bLength                 9
    bDescriptorType         2
    wTotalLength          177
    bNumInterfaces          2
    bConfigurationValue     1
    iConfiguration          0
    bmAttributes         0xe0
      Self Powered
      Remote Wakeup
    MaxPower              100mA
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        0
      bAlternateSetting       0
      bNumEndpoints           3
      bInterfaceClass       224 Wireless
      bInterfaceSubClass      1 Radio Frequency
      bInterfaceProtocol      1 Bluetooth
      iInterface              0
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x81  EP 1 IN
        bmAttributes            3
          Transfer Type            Interrupt
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0010  1x 16 bytes
        bInterval               1
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x82  EP 2 IN
        bmAttributes            2
          Transfer Type            Bulk
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0040  1x 64 bytes
        bInterval               1
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x02  EP 2 OUT
        bmAttributes            2
          Transfer Type            Bulk
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0040  1x 64 bytes
        bInterval               1
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        1
      bAlternateSetting       0
      bNumEndpoints           2
      bInterfaceClass       224 Wireless
      bInterfaceSubClass      1 Radio Frequency
      bInterfaceProtocol      1 Bluetooth
      iInterface              0
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x83  EP 3 IN
        bmAttributes            1
          Transfer Type            Isochronous
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0000  1x 0 bytes
        bInterval               1
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x03  EP 3 OUT
        bmAttributes            1
          Transfer Type            Isochronous
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0000  1x 0 bytes
        bInterval               1
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        1
      bAlternateSetting       1
      bNumEndpoints           2
      bInterfaceClass       224 Wireless
      bInterfaceSubClass      1 Radio Frequency
      bInterfaceProtocol      1 Bluetooth
      iInterface              0
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x83  EP 3 IN
        bmAttributes            1
          Transfer Type            Isochronous
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0009  1x 9 bytes
        bInterval               1
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x03  EP 3 OUT
        bmAttributes            1
          Transfer Type            Isochronous
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0009  1x 9 bytes
        bInterval               1
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        1
      bAlternateSetting       2
      bNumEndpoints           2
      bInterfaceClass       224 Wireless
      bInterfaceSubClass      1 Radio Frequency
      bInterfaceProtocol      1 Bluetooth
      iInterface              0
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x83  EP 3 IN
        bmAttributes            1
          Transfer Type            Isochronous
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0011  1x 17 bytes
        bInterval               1
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x03  EP 3 OUT
        bmAttributes            1
          Transfer Type            Isochronous
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0011  1x 17 bytes
        bInterval               1
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        1
      bAlternateSetting       3
      bNumEndpoints           2
      bInterfaceClass       224 Wireless
      bInterfaceSubClass      1 Radio Frequency
      bInterfaceProtocol      1 Bluetooth
      iInterface              0
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x83  EP 3 IN
        bmAttributes            1
          Transfer Type            Isochronous
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0019  1x 25 bytes
        bInterval               1
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x03  EP 3 OUT
        bmAttributes            1
          Transfer Type            Isochronous
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0019  1x 25 bytes
        bInterval               1
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        1
      bAlternateSetting       4
      bNumEndpoints           2
      bInterfaceClass       224 Wireless
      bInterfaceSubClass      1 Radio Frequency
      bInterfaceProtocol      1 Bluetooth
      iInterface              0
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x83  EP 3 IN
        bmAttributes            1
          Transfer Type            Isochronous
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0021  1x 33 bytes
        bInterval               1
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x03  EP 3 OUT
        bmAttributes            1
          Transfer Type            Isochronous
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0021  1x 33 bytes
        bInterval               1
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        1
      bAlternateSetting       5
      bNumEndpoints           2
      bInterfaceClass       224 Wireless
      bInterfaceSubClass      1 Radio Frequency
      bInterfaceProtocol      1 Bluetooth
      iInterface              0
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x83  EP 3 IN
        bmAttributes            1
          Transfer Type            Isochronous
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0031  1x 49 bytes
        bInterval               1
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x03  EP 3 OUT
        bmAttributes            1
          Transfer Type            Isochronous
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0031  1x 49 bytes
        bInterval               1
Device Status:     0x0003
  Self Powered
  Remote Wakeup Enabled
