Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E34ED2CFF33
	for <lists+linux-wireless@lfdr.de>; Sat,  5 Dec 2020 22:26:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725933AbgLEV0G (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 5 Dec 2020 16:26:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725270AbgLEV0G (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 5 Dec 2020 16:26:06 -0500
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C56F2C0613CF
        for <linux-wireless@vger.kernel.org>; Sat,  5 Dec 2020 13:25:25 -0800 (PST)
Received: by mail-pj1-x1044.google.com with SMTP id p21so5335249pjv.0
        for <linux-wireless@vger.kernel.org>; Sat, 05 Dec 2020 13:25:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=reply-to:from:to:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=3SZBDw5m8t2KONrJh2qkAzkbvzRa7Ic4EhZmiycSNFU=;
        b=qEkA0Yqito4SIVLYLXO6+S7Ox0BophYbfhlQFrXcShiuK/3xjaOlKUpJ6whWctNxDj
         11JGk3/71O08H2I0ObAGtMqLwogpPC2rOIFn8E/ZvFOMvdMlwiG1eCI4qWHCzEVrT5sm
         czk/bJbeIcZRWEVFUsdcf8aHiK3AAZvYLAdP7+jDcN4YXB9qY7X0DViqEJMZuj8Z61d7
         A/GMD524nOe2U8E+6/sTzOOJC8xggYmNoycnq6JzytHLx89nnq4lDN/dnbF8om3zECfG
         lhHp1utzkEMw1c607pEg9KEMNHGCFbOc6irLRIsT2zBzz/SbFP5b7+NDN5FNAmSCKd7o
         II5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:from:to:subject:message-id:date
         :user-agent:mime-version:content-language:content-transfer-encoding;
        bh=3SZBDw5m8t2KONrJh2qkAzkbvzRa7Ic4EhZmiycSNFU=;
        b=OkkIZBKAfKgz2DoVffNgKvO6SkOdD4hV7WPEQYUWT+3hDxlHb2vDJ+OAvLVX3EFMoz
         ibHB1kofSKUje92KHMv4V9nqY80nEo0os0Id/p2CAC0FShgx2V4dXozTtPlazInTxKjK
         1FuRW1SS4tagnd/Ln8Dtr49ciPK/jLU4Z4CenwCKuRutPopx3FzPdMGaFowfVbnC0cxG
         uOvzXV32hW+GBk3DOc2fXyxi40DuRqJbpHl7UyOzWbZ5zAvduhoZUear6V5NluzAayJg
         7+rdtEWOtCOkm9lLZW48PGMj6PFLrtBOwhqnIqdbAUv4LrPy4pzZsPbz9968xbVueMOW
         +0EQ==
X-Gm-Message-State: AOAM531z9JaQ2BG158IKf9Ag3Pe+gmHNn+ARkRrwZkMUrdJYIvGUhVV9
        kn9HVcEs4vX6if6RFYJ+p0dZZqDyO1Q=
X-Google-Smtp-Source: ABdhPJwhLMI5+vRh+uyTHEG2CveiIZwHXe+Q6sM4YFVDLRtHUJmbnh1torGrlRHrS0+Rl1eR7xbWFg==
X-Received: by 2002:a17:902:ee53:b029:da:4c68:2795 with SMTP id 19-20020a170902ee53b02900da4c682795mr9225891plo.7.1607203524911;
        Sat, 05 Dec 2020 13:25:24 -0800 (PST)
Received: from mua.localhost (99-7-172-215.lightspeed.snmtca.sbcglobal.net. [99.7.172.215])
        by smtp.gmail.com with ESMTPSA id w5sm2580308pfw.66.2020.12.05.13.25.24
        for <linux-wireless@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 05 Dec 2020 13:25:24 -0800 (PST)
Reply-To: pgnet.dev@gmail.com
From:   PGNet Dev <pgnet.dev@gmail.com>
To:     linux-wireless@vger.kernel.org
Subject: wifi dongle connected to USB/pci card, seen in hardware, but no wl*
 device created; udev, driver, &/or config?
Message-ID: <95c76758-485b-aad4-62d2-95ce24f1108c@gmail.com>
Date:   Sat, 5 Dec 2020 13:25:23 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

hi,


I've got an older desktop running Fedora32 with

	uname -rm
		5.9.11-100.fc32.x86_64 x86_64

I've plugged a wifi dongle into a multiport USB3 pci card,
  

	lspci | grep "USB 3"
		02:00.0 USB controller: Fresco Logic FL1100 USB 3.0 Host Controller (rev 10)


On boot, the wifi hardware's seen

	dmesg
		...
		[    2.639873] systemd[1]: Starting udev Kernel Device Manager...
		[    2.643850] usb 8-4: New USB device found, idVendor=0bda, idProduct=b812, bcdDevice= 2.10
		[    2.643853] usb 8-4: New USB device strings: Mfr=1, Product=2, SerialNumber=3
		[    2.643854] usb 8-4: Product: 802.11ac NIC
		[    2.643855] usb 8-4: Manufacturer: Realtek
		[    2.643856] usb 8-4: SerialNumber: 123456
		[    2.682834] systemd[1]: Started udev Kernel Device Manager.
		...

	lsusb | grep 008
		Bus 008 Device 003: ID 0bda:b812 Realtek Semiconductor Corp. RTL88x2bu [AC1200 Techkey]
		Bus 008 Device 002: ID 2109:2812 VIA Labs, Inc. VL812 Hub
		Bus 008 Device 001: ID 1d6b:0002 Linux Foundation 2.0 root hub

but hardware check for wlan/wlp* device, returns empty

	iw list
		(empty)

	hwinfo --wlan
		(empty)

in more detail,

	hwinfo

the device is 'there', but unclassified

	...
	72: USB 00.0: 0000 Unclassified device
	[Created at usb.122]
	Unique ID: +4pb.2IcWyDScHM3
	Parent ID: FZIx.tisqRJYDXEC
	SysFS ID: /devices/pci0000:00/0000:00:04.0/0000:02:00.0/usb8/8-4/8-4:1.0
	SysFS BusID: 8-4:1.0
	Hardware Class: unknown
	Model: "Realtek 802.11ac NIC"
	Hotplug: USB
	Vendor: usb 0x0bda "Realtek Semiconductor Corp."
	Device: usb 0xb812 "802.11ac NIC"
	Revision: "2.10"
	Serial ID: "123456"
	Speed: 480 Mbps
	Module Alias: "usb:v0BDApB812d0210dc00dsc00dp00icFFiscFFipFFin00"
	Config Status: cfg=new, avail=yes, need=no, active=unknown
	Attached to: #71 (Hub)
	...


existing default udev rules aren't creating a wlan device; I'd expected that they would ...

To get the device created -- when attached to the pci card -- is udev the right mechanism?

I'm not clear if the problem here is udev, driver &/or my config.

IF udev, what specific rule would create a USB network device for the dongle, either with a wlp* auto-name, or if need be, "wlan0"?

Or, what else needs be done to init the wl* dev?


