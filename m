Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7EC343D4C06
	for <lists+linux-wireless@lfdr.de>; Sun, 25 Jul 2021 06:57:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229522AbhGYERO (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 25 Jul 2021 00:17:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbhGYERO (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 25 Jul 2021 00:17:14 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8DA2C061757
        for <linux-wireless@vger.kernel.org>; Sat, 24 Jul 2021 21:57:43 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id l4so6999911ljq.4
        for <linux-wireless@vger.kernel.org>; Sat, 24 Jul 2021 21:57:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:reply-to:to:date:user-agent:mime-version
         :content-transfer-encoding;
        bh=YwAcIVvAWaPcL9/vyFnFzDc4uDEvVEQ9znWV0dXgl84=;
        b=sWEO1/tY/9DTgOs2MbguqQQ85LHooZwrvlqK0AgpilOM1Qyn2aCbw5xSH3FhSgHPu3
         bZjtUn/25kP5VohPqSj5TQ7vIe4vzJJe1zKDoaQQ7xTxmuFVSHKZsPwk4AKpiq/d58pz
         IpStIBav0klNwjryT0MH/zCpm3vy16bD16RG0ohuHKWAIQKhcS9Jd+NlehbIjLoVVOQ+
         vAAo6lefUC5hnUwkFRa6MJkspaUe59EQhM5wHrEJ+xlSYR4MocaeSxBzC1MUl77PKR2c
         4R1iZKLS3PQyE4NGX+HVHnWAkzf+6Z/WqQ5XK4a8mjU6Pki/nf5dFpmN3W/VH9vzRAf2
         /tMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:reply-to:to:date
         :user-agent:mime-version:content-transfer-encoding;
        bh=YwAcIVvAWaPcL9/vyFnFzDc4uDEvVEQ9znWV0dXgl84=;
        b=WoGTxrVQRBuFW6DqxZWgDhc8Ecu0+WzCCzIUuhufgRyH50ptxBlsm5xpAsuLLxQt3g
         TdxQQQGdNvvrbgDywvE5cESLDkJYpZ9wcar+j0Ek1T+sn1FxsxE874K1Q2tOXrXMSbPt
         hvFX4l2xQa4whI3KS6DoiLkemcBCvJUNQeUjZgzemzwWes34AXMm++ZfaD3QSCs298h3
         mq+aP7Fr1Yh8m5vBF8zV208Em3ENffXG3Qt0If6sx+7fU0pKhXrbSVSmPvgOTKvgKzNs
         Xi+1oJgf3F4zb7Nms0PMSX8AXrDngdWKVbvLYYToZJXICI/U4dktyo92p8w/gyvDYwLR
         Qx0Q==
X-Gm-Message-State: AOAM531hBnAdVyAaoZPcy2uWK+68XNHXazrOeGKSrMzGEnLrcnooqKsq
        VVObyIvr6UOv0DD7V43SflJeZd08MxY9kA==
X-Google-Smtp-Source: ABdhPJwmFXQSWjhh9A4NZI6RPLzt5//0rjwFYWQchYv6dO3T+L6RPvKQzx52qlYqqZ+NFolBiE2BWw==
X-Received: by 2002:a05:651c:906:: with SMTP id e6mr8050992ljq.385.1627189061572;
        Sat, 24 Jul 2021 21:57:41 -0700 (PDT)
Received: from [192.168.0.106] (93-75-145-125.dne.volia.net. [93.75.145.125])
        by smtp.gmail.com with ESMTPSA id f6sm2663359lfu.273.2021.07.24.21.57.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Jul 2021 21:57:40 -0700 (PDT)
Message-ID: <1148e7c5bb3191e43f965c54d508db575124a990.camel@gmail.com>
Subject: [feature request] set regulatory domain per device and some other
 fixes
From:   Bogdan <bogdan.pylypenko107@gmail.com>
Reply-To: bogdan.pylypenko107@gmail.com
To:     linux-wireless@vger.kernel.org, zerochaos@gentoo.org
Date:   Sun, 25 Jul 2021 07:57:33 +0300
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.3 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi!

This document more pretty in markup viewer.

email linux-wireless@vger.kernel.org finded at https://wireless.wiki.kernel.org/en/developers/mailinglists
email zerochaos@gentoo.org finded in iw package metadata

## My system:

```
$ cat /etc/os-release | grep PRETTY_NAME=
PRETTY_NAME="Gentoo/Linux"

$ uname -r
5.13.3-gentoo-x86_64

$ eix net-wireless/iw -Ic --format '<installedversions:EQNAMEVERSION>'
=net-wireless/iw-5.9

$ equery m iw | grep Maintainer
Maintainer:  zerochaos@gentoo.org
```

### My devices:
```
$ lspci -k | grep -A2 Wireless
03:00.0 Network controller: Realtek Semiconductor Co., Ltd. RTL8822CE 802.11ac PCIe Wireless Network Adapter
 DeviceName: Realtek Wireless LAN + BT
 Subsystem: Hewlett-Packard Company RTL8822CE 802.11ac PCIe Wireless Network Adapter
 Kernel driver in use: rtw_8822ce
 Kernel modules: rtw88_8822ce

$ lsusb | grep Wireless
Bus 003 Device 012: ID 148f:7601 Ralink Technology, Corp. MT7601U Wireless Adapter
$ lsusb -s 03.012 -t | grep -i "Dev 12"
 |__ Port 1: Dev 12, If 0, Class=Vendor Specific Class, Driver=mt7601u, 480M
```

### Kernel drivers:
```
$ zgrep -i rtw88 /proc/config.gz
CONFIG_RTW88=m
CONFIG_RTW88_CORE=m
CONFIG_RTW88_PCI=m
CONFIG_RTW88_8822C=m
# CONFIG_RTW88_8822BE is not set
CONFIG_RTW88_8822CE=m
# CONFIG_RTW88_8723DE is not set
# CONFIG_RTW88_8821CE is not set
# CONFIG_RTW88_DEBUG is not set
# CONFIG_RTW88_DEBUGFS is not set

$ zgrep 7601 /proc/config.gz
CONFIG_MT7601U=m
```

### Device names:
```
$ iw dev | grep -A1 phy
phy#1
        Interface wlan1
--
phy#0
        Interface wlan0

$ iw list | grep Wiphy
Wiphy phy1
Wiphy phy0
```

### Quick resolution:
```
<dev>   <phy>  <driver>     <type>
wlan0 - phy0 - rtw_8822ce - M.2 (PCIe) adapter
wlan1 - phy1 - mt7601u    - USB dongle
```

## Problem #1 - iw tool has no commands to set regulatory domain per device
I want to set regulatory domain (CRDA) only for device wlan1, not globally for all devices wlan0 & wlan1, but iw support configuring regulatory domain only globally:
```
$ iw | grep reg
 reg reload
 phy <phyname> reg get
 reg get
 reg set <ISO/IEC 3166-1 alpha2>
```

## Problem #2 - iw tool output incorrectly list of devices
iw lists only global section and section for inbound wlan0 (phy#0) device.
Device wlan1 (phy1) not listed in second command.
```
$ iw list | grep Wiphy
Wiphy phy1
Wiphy phy0
$ iw reg get | grep phy
phy#0
```

## Problem #3 - iw tool say phy names in two different forms
This command input phy name in "phy0" form, but output in "phy#0" form.
```
$ iw list | grep Wiphy
Wiphy phy1
Wiphy phy0
$ iw dev | grep "^phy"
phy#1
phy#0
$ iw phy phy0 reg get | grep phy
phy#0
```

## Problem #4 - iw tool set globally configured regulatory domain only for external adapter

### Unset regulatroy domain globally:
```
$ sudo iw reg set 00

$ iw reg get
global
country 00: DFS-UNSET
 (2402 - 2472 @ 40), (N/A, 20), (N/A)
 (2457 - 2482 @ 20), (N/A, 20), (N/A), AUTO-BW, PASSIVE-SCAN
 (2474 - 2494 @ 20), (N/A, 20), (N/A), NO-OFDM, PASSIVE-SCAN
 (5170 - 5250 @ 80), (N/A, 20), (N/A), AUTO-BW, PASSIVE-SCAN
 (5250 - 5330 @ 80), (N/A, 20), (0 ms), DFS, AUTO-BW, PASSIVE-SCAN
 (5490 - 5730 @ 160), (N/A, 20), (0 ms), DFS, PASSIVE-SCAN
 (5735 - 5835 @ 80), (N/A, 20), (N/A), PASSIVE-SCAN
 (57240 - 63720 @ 2160), (N/A, 0), (N/A)

phy#0
country 00: DFS-UNSET
 (2402 - 2472 @ 40), (N/A, 20), (N/A)
 (2457 - 2482 @ 20), (N/A, 20), (N/A), AUTO-BW, PASSIVE-SCAN
 (2474 - 2494 @ 20), (N/A, 20), (N/A), NO-OFDM, PASSIVE-SCAN
 (5170 - 5250 @ 80), (N/A, 20), (N/A), AUTO-BW, PASSIVE-SCAN
 (5250 - 5330 @ 80), (N/A, 20), (0 ms), DFS, AUTO-BW, PASSIVE-SCAN
 (5490 - 5730 @ 160), (N/A, 20), (0 ms), DFS, PASSIVE-SCAN
 (5735 - 5835 @ 80), (N/A, 20), (N/A), PASSIVE-SCAN
 (57240 - 63720 @ 2160), (N/A, 0), (N/A)

$ iw phy phy0 reg get
phy#0
country 00: DFS-UNSET
 (2402 - 2472 @ 40), (N/A, 20), (N/A)
 (2457 - 2482 @ 20), (N/A, 20), (N/A), AUTO-BW, PASSIVE-SCAN
 (2474 - 2494 @ 20), (N/A, 20), (N/A), NO-OFDM, PASSIVE-SCAN
 (5170 - 5250 @ 80), (N/A, 20), (N/A), AUTO-BW, PASSIVE-SCAN
 (5250 - 5330 @ 80), (N/A, 20), (0 ms), DFS, AUTO-BW, PASSIVE-SCAN
 (5490 - 5730 @ 160), (N/A, 20), (0 ms), DFS, PASSIVE-SCAN
 (5735 - 5835 @ 80), (N/A, 20), (N/A), PASSIVE-SCAN
 (57240 - 63720 @ 2160), (N/A, 0), (N/A

$ iw phy phy1 reg get
phy#1
country 00: DFS-UNSET
 (2402 - 2472 @ 40), (N/A, 20), (N/A)
 (2457 - 2482 @ 20), (N/A, 20), (N/A), AUTO-BW, PASSIVE-SCAN
 (2474 - 2494 @ 20), (N/A, 20), (N/A), NO-OFDM, PASSIVE-SCAN
 (5170 - 5250 @ 80), (N/A, 20), (N/A), AUTO-BW, PASSIVE-SCAN
 (5250 - 5330 @ 80), (N/A, 20), (0 ms), DFS, AUTO-BW, PASSIVE-SCAN
 (5490 - 5730 @ 160), (N/A, 20), (0 ms), DFS, PASSIVE-SCAN
 (5735 - 5835 @ 80), (N/A, 20), (N/A), PASSIVE-SCAN
 (57240 - 63720 @ 2160), (N/A, 0), (N/A)
```


### Set regulatroy domain for country BR:
```
$ sudo iw reg set BR

$ iw reg get
global
country BR: DFS-FCC
 (2402 - 2482 @ 40), (N/A, 20), (N/A)
 (5170 - 5250 @ 80), (N/A, 17), (N/A), AUTO-BW
 (5250 - 5330 @ 80), (N/A, 24), (0 ms), DFS, AUTO-BW
 (5490 - 5730 @ 160), (N/A, 24), (0 ms), DFS
 (5735 - 5835 @ 80), (N/A, 30), (N/A)

phy#0
country 00: DFS-UNSET
 (2402 - 2472 @ 40), (N/A, 20), (N/A)
 (2457 - 2482 @ 20), (N/A, 20), (N/A), AUTO-BW, PASSIVE-SCAN
 (2474 - 2494 @ 20), (N/A, 20), (N/A), NO-OFDM, PASSIVE-SCAN
 (5170 - 5250 @ 80), (N/A, 20), (N/A), AUTO-BW, PASSIVE-SCAN
 (5250 - 5330 @ 80), (N/A, 20), (0 ms), DFS, AUTO-BW, PASSIVE-SCAN
 (5490 - 5730 @ 160), (N/A, 20), (0 ms), DFS, PASSIVE-SCAN
 (5735 - 5835 @ 80), (N/A, 20), (N/A), PASSIVE-SCAN
 (57240 - 63720 @ 2160), (N/A, 0), (N/A)

$ iw phy phy0 reg get
phy#0
country 00: DFS-UNSET
 (2402 - 2472 @ 40), (N/A, 20), (N/A)
 (2457 - 2482 @ 20), (N/A, 20), (N/A), AUTO-BW, PASSIVE-SCAN
 (2474 - 2494 @ 20), (N/A, 20), (N/A), NO-OFDM, PASSIVE-SCAN
 (5170 - 5250 @ 80), (N/A, 20), (N/A), AUTO-BW, PASSIVE-SCAN
 (5250 - 5330 @ 80), (N/A, 20), (0 ms), DFS, AUTO-BW, PASSIVE-SCAN
 (5490 - 5730 @ 160), (N/A, 20), (0 ms), DFS, PASSIVE-SCAN
 (5735 - 5835 @ 80), (N/A, 20), (N/A), PASSIVE-SCAN
 (57240 - 63720 @ 2160), (N/A, 0), (N/A)

$ iw phy phy1 reg get
global
country BR: DFS-FCC
 (2402 - 2482 @ 40), (N/A, 20), (N/A)
 (5170 - 5250 @ 80), (N/A, 17), (N/A), AUTO-BW
 (5250 - 5330 @ 80), (N/A, 24), (0 ms), DFS, AUTO-BW
 (5490 - 5730 @ 160), (N/A, 24), (0 ms), DFS
 (5735 - 5835 @ 80), (N/A, 30), (N/A)
```

## Feature requests
### 1) Normalize phy names format
I want to see phy names in "iw reg get" outputs in form, correct as phy name for iw input.
E.g.: if I see "phy#0" string as physical interface name in "iw reg get" output, then iw must accept "phy#0" string as correct physical interface name in "iw phy <phyname> reg get" input:
```
$ iw phy phy0 reg get | grep phy
phy#0
$ iw phy phy#0 reg get
command failed: No such file or directory (-2)
```
I prefer to use phy names without "#" prefix for phy number - in unique form with 'iw list | grep Wiphy' command.

### 2) Fix "iw reg" command to show all devices
"iw reg" command must show all devices, listed in "iw list".

### 3) Fix "iw reg" command to set regulatory domain really for all devices
Global variant of "iw reg set <COUNTRY>" command must set regulatory domain really for all devices.

### 4) Add command to set regulatory domain per phy by phy name
Example:
```
iw phy0 reg set BR
```

### 4) Add command to set regulatory domain per phy by device name
Example:
```
iw dev wlan0 reg set BR
```
Inside iw, device name "wlan0" transformed to his phy name "phy0", and regulatory domain configured to those "phy0" physical interface.



