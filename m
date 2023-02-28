Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54B8A6A50C4
	for <lists+linux-wireless@lfdr.de>; Tue, 28 Feb 2023 02:38:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229677AbjB1Bi3 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 27 Feb 2023 20:38:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229590AbjB1Bi2 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 27 Feb 2023 20:38:28 -0500
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F3979745
        for <linux-wireless@vger.kernel.org>; Mon, 27 Feb 2023 17:38:26 -0800 (PST)
Received: (Authenticated sender: c@jia.je)
        by mail.gandi.net (Postfix) with ESMTPSA id C93E0FF802;
        Tue, 28 Feb 2023 01:38:22 +0000 (UTC)
Message-ID: <29f3b49d-25dd-fc17-a09c-31c277666cdc@jia.je>
Date:   Tue, 28 Feb 2023 09:38:19 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.8.0
Subject: Re: [PATCH] wifi: rtl8xxxu: Support new chip RTL8710BU aka RTL8188GU
Content-Language: en-US
To:     Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc:     Jes Sorensen <Jes.Sorensen@gmail.com>,
        Ping-Ke Shih <pkshih@realtek.com>
References: <5a9a264d-a59b-0d91-04f0-e5b38e6aaea0@gmail.com>
 <39b1a27a-9514-a0ed-6bca-3ccd620c8b33@jia.je>
 <b8e6be05-b70c-a8a2-291f-c148145b9643@gmail.com>
From:   Jiajie Chen <c@jia.je>
In-Reply-To: <b8e6be05-b70c-a8a2-291f-c148145b9643@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


On 2023/2/27 20:30, Bitterblue Smith wrote:
> On 27/02/2023 11:18, Jiajie Chen wrote:
>> Nice job, tested with three USB dongles with RTL8188GU chipset. Comments below.
>>
> Cool! Are the chips made by UMC or SMIC? See this line in dmesg:
> usb 1-2: RTL8710BU rev A (SMIC) romver 1, 1T1R, TX queues 3, WiFi=1, BT=0, GPS=0, HI PA=0
>
They are all made by SMIC:

EDUP EP-N8566

[39672.643323] usb 3-1.4: new high-speed USB device number 15 using xhci_hcd
[39672.744277] usb 3-1.4: New USB device found, idVendor=0bda, 
idProduct=b711, bcdDevice= 2.00
[39672.744288] usb 3-1.4: New USB device strings: Mfr=1, Product=2, 
SerialNumber=3
[39672.744292] usb 3-1.4: Product: 802.11n WLAN Adapter
[39672.744294] usb 3-1.4: Manufacturer: Realtek
[39672.744297] usb 3-1.4: SerialNumber: 00E04CB82101
[39672.763531] usb 3-1.4: RTL8710BU rev A (SMIC) romver 1, 1T1R, TX 
queues 3, WiFi=1, BT=0, GPS=0, HI PA=0
[39672.763534] usb 3-1.4: RTL8710BU MAC: xx:xx:xx:xx:xx:xx
[39672.763535] usb 3-1.4: rtl8xxxu: Loading firmware rtlwifi/rtl8710bufw.bin
[39672.763559] usb 3-1.4: Firmware revision 16.0 (signature 0x10b1)
[39672.765248] usb 3-1.4: Firmware is already running, resetting the MCU.

Mercury MW150US v2

[39688.892911] usb 3-1.3: RTL8710BU rev A (SMIC) romver 1, 1T1R, TX 
queues 3, WiFi=1, BT=0, GPS=0, HI PA=0

Tenda W311MI

[39702.424956] usb 3-1.2: RTL8710BU rev A (SMIC) romver 1, 1T1R, TX 
queues 3, WiFi=1, BT=0, GPS=0, HI PA=0


