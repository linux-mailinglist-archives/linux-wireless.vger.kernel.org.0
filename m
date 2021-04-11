Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CEAC35B6A6
	for <lists+linux-wireless@lfdr.de>; Sun, 11 Apr 2021 20:55:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235972AbhDKSzq (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 11 Apr 2021 14:55:46 -0400
Received: from mx3.molgen.mpg.de ([141.14.17.11]:34723 "EHLO mx1.molgen.mpg.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S235261AbhDKSzq (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 11 Apr 2021 14:55:46 -0400
Received: from [192.168.0.2] (ip5f5aef24.dynamic.kabel-deutschland.de [95.90.239.36])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: pmenzel)
        by mx.molgen.mpg.de (Postfix) with ESMTPSA id 894FB206473C4;
        Sun, 11 Apr 2021 20:55:28 +0200 (CEST)
To:     linux-wireless@vger.kernel.org, b43-dev@lists.infradead.org
From:   Paul Menzel <pmenzel@molgen.mpg.de>
Subject: b43: probe of bcma0:1 failed with error -524
Message-ID: <e97229b0-27e5-83a2-aa89-550dfddbeb23@molgen.mpg.de>
Date:   Sun, 11 Apr 2021 20:55:28 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Dear Linux folks,


On an Acer TravelMate 5735Z, Linux’ b43 driver logs a probe error.

```
[    0.000000] Linux version 5.10.0-5-amd64 
(debian-kernel@lists.debian.org) (gcc-10 (Debian 10.2.1-6) 10.2.1 
20210110, GNU ld (GNU Binutils for Debian) 2.35.2) #1 SMP Debian 
5.10.26-1 (2021-03-27)
[…]
[    0.000000] DMI: Acer TravelMate 5735Z/BA51_MV, BIOS V1.14 07/26/2011
[…]
[    5.301664] Support for cores revisions 0x17 and 0x18 disabled by 
module param allhwsupport=0. Try b43.allhwsupport=1
[    5.301682] b43: probe of bcma0:1 failed with error -524
[    5.303510] Broadcom 43xx driver loaded [ Features: PNLS ]
[    5.316266] fbcon: i915drmfb (fb0) is primary device
[    5.318422] videodev: Linux video capture interface: v2.00
[    5.323240] usbcore: registered new interface driver uas
[    5.325700] ums-realtek 3-5:1.0: USB Mass Storage device detected
[    5.378133] scsi host4: usb-storage 3-5:1.0
[    5.378328] usbcore: registered new interface driver ums-realtek
[    5.387582] brcmsmac bcma0:1: mfg 4bf core 812 rev 23 class 0 irq 17
[    5.388489] ieee80211 phy0: Selected rate control algorithm 'minstrel_ht'
[    5.425813] battery: ACPI: Battery Slot [BAT0] (battery present)
[    5.467879] tg3 0000:05:00.0 enp5s0: Link is down
[    5.491758] uvcvideo: Found UVC 1.00 device 1.3M WebCam (04f2:b1d8)
[    5.527025] input: 1.3M WebCam: 1.3M WebCam as 
/devices/pci0000:00/0000:00:1d.7/usb3/3-4/3-4:1.0/input/input14
[    5.527478] usbcore: registered new interface driver uvcvideo
[    5.527479] USB Video Class driver (1.1.1)
[    5.532356] brcmsmac bcma0:1: firmware: direct-loading firmware 
brcm/bcm43xx-0.fw
[    5.532709] brcmsmac bcma0:1: firmware: direct-loading firmware 
brcm/bcm43xx_hdr-0.fw
[    5.586551] brcmsmac bcma0:1: brcms_ops_bss_info_changed: qos 
enabled: false (implement)
[    5.586561] brcmsmac bcma0:1: brcms_ops_config: change power-save 
mode: false (implement)
[    5.920575] brcmsmac bcma0:1: brcms_ops_bss_info_changed: qos 
enabled: false (implement)
[    5.920583] brcmsmac bcma0:1: brcms_ops_config: change power-save 
mode: false (implement)
[…]
```

The wireless device works, and it looks like it’s using the driver 
brcmsmac. Should the b43 driver be involved for the device here? Though 
I do not know what error -524 is exactly.


Kind regards,

Paul
