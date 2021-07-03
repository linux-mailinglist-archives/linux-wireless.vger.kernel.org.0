Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3860C3BAA80
	for <lists+linux-wireless@lfdr.de>; Sun,  4 Jul 2021 00:16:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229539AbhGCWTB (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 3 Jul 2021 18:19:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbhGCWTB (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 3 Jul 2021 18:19:01 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 355FCC061762
        for <linux-wireless@vger.kernel.org>; Sat,  3 Jul 2021 15:16:27 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id d25so18887389lji.7
        for <linux-wireless@vger.kernel.org>; Sat, 03 Jul 2021 15:16:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:subject:to:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=omlS3lwaZNXh47mx/Pp9o9EC1l4YgHc8ORa4P71mqOU=;
        b=F4LwwBTYoDjVZ+oPGfjbOGQb1NNDAnXm8bqBJdI16tkQi4FD62rRm1Zw3gC7XPvKtp
         BiMox8wjZ0s6Xpp7Ue6Ok7ymstVThjM+DuBgYZKURpCHiEk/t/Zqi3axpIGs2a/GUiEN
         N0Ljo7OQo4SZoc3zzReSRRbB/RINNBduDKsK9pfc8XKRzosH3/Xf2JkJTms22AtMeQ1S
         UbqCzo2+Cd0mJkM5E4xNNXWaz6mclMMFb1VjI4XEoHekXfo3atUHNEid0vORN38Gjk+r
         5OvVFkBs7l2LVnZu4pkqZKl5pWHuEwOMsWXVMx98lDYOxlODvwcmEztq4YdlTNThoMYg
         xQ+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=omlS3lwaZNXh47mx/Pp9o9EC1l4YgHc8ORa4P71mqOU=;
        b=mXezTEEBrhMqRMZz0oeJAyQY9nUzoxvMFtRBy2nbwVh+pHP49riSSKtxIXpaIV/Q1q
         0J1+pUcAYZ/JvFCVguPnwYHAH2T7rjotWtvPqZAG5EqJYnIZuTakx6EyvfKcsfpSGeol
         y4TwZBV78d2p/864EOVMLAbf4qhSD0/2ynHbmds8CaQvYZWW9BughdbLBtWRiSJYTvAW
         n8mtwYJo9r/t8p3m38e/F2jbeMUfg0esUH6N3A/tf4byUhYbnR4IxfDOvdcYyihubLvl
         iAW1MR6U5nRnLFrHZeAaiWBiK5vsEu1WOM6C/ga/lvKkRW9GKhILpiUl+Ab5PsFVDrCf
         RBLQ==
X-Gm-Message-State: AOAM531kSzqDwC6Zfc3JHqdI81sr4sggKegJTFJZ1sQuMklVq0xg5X34
        0Mdx3o/4/nbzaT8XfBAXQpEdevqJ7vk=
X-Google-Smtp-Source: ABdhPJxHJ/eHC6HfJGcgFsaDaI2EvMQ+HaA12rxXZmZ2jOpqlUmlfzhnz5dsqwA8ZEXCG2zEcu0JLQ==
X-Received: by 2002:a2e:8e26:: with SMTP id r6mr4861512ljk.313.1625350585558;
        Sat, 03 Jul 2021 15:16:25 -0700 (PDT)
Received: from localhost.localdomain (ip-194-187-74-233.konfederacka.maverick.com.pl. [194.187.74.233])
        by smtp.googlemail.com with ESMTPSA id i1sm771814ljn.40.2021.07.03.15.16.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 03 Jul 2021 15:16:24 -0700 (PDT)
From:   =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
Subject: Unstable WiFi with mt76 on MT7628AN
To:     Felix Fietkau <nbd@nbd.name>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Message-ID: <7c96d5ee-86c1-8068-1b58-40db6087a24f@gmail.com>
Date:   Sun, 4 Jul 2021 00:16:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi,

I decided to start my adventure with mt76. I bought the cheapest router
I could find: Xiaomi Mi Router 4C and installed OpenWrt 21.02-rc3 on it.

OpenWrt 21.02-rc3 contains mt76 from May:
https://git.openwrt.org/?p=openwrt/openwrt.git;a=commitdiff;h=43e4ba586336383b34698a00d4588a17b853922f

It *does not* include some later changes from June:
https://git.openwrt.org/?p=openwrt/openwrt.git;a=commitdiff;h=20f66649dda3094320e515006cd5ddc9c096ac30
(or the very latest changes).

My problem is unstable WiFi (as vague as this description is). I often
experience stalls (I can't even see beacons) and sometimes some slow
downs. I started using this device about 6 hours ago and experienced 3
or 4 traffic stops with no beacons.

WiFi can work flawlessly for an hour, e.g. this iperf2 session:
[  3]  0.0-3339.0 sec  25.3 GBytes  65.1 Mbits/sec

And another time it can suddently stop:
[  3] 54.0-55.0 sec  5.38 MBytes  45.1 Mbits/sec
[  3] 55.0-56.0 sec  5.88 MBytes  49.3 Mbits/sec
[  3] 56.0-57.0 sec  8.12 MBytes  68.2 Mbits/sec
[  3] 57.0-58.0 sec  5.12 MBytes  43.0 Mbits/sec
[  3] 58.0-59.0 sec  6.88 MBytes  57.7 Mbits/sec
[  3] 59.0-60.0 sec  7.88 MBytes  66.1 Mbits/sec
[  3] 60.0-61.0 sec  7.88 MBytes  66.1 Mbits/sec
[  3] 61.0-62.0 sec  5.04 MBytes  42.3 Mbits/sec
[  3] 62.0-63.0 sec   318 KBytes  2.61 Mbits/sec
[  3] 63.0-64.0 sec  0.00 Bytes  0.00 bits/sec
[  3] 64.0-65.0 sec  0.00 Bytes  0.00 bits/sec
[  3] 65.0-66.0 sec  0.00 Bytes  0.00 bits/sec
[  3] 66.0-67.0 sec  0.00 Bytes  0.00 bits/sec
[  3] 67.0-68.0 sec  0.00 Bytes  0.00 bits/sec
[  3] 68.0-69.0 sec  0.00 Bytes  0.00 bits/sec
[  3] 69.0-70.0 sec  0.00 Bytes  0.00 bits/sec
[  3] 70.0-71.0 sec  0.00 Bytes  0.00 bits/sec
[  3] 71.0-72.0 sec  0.00 Bytes  0.00 bits/sec
(I didn't move my AP, didn't move my STA, didn't get new STAs).

After stall as above I can't even reconnect. Most attempts fail as I
can't even see a single beacon. Sometimes I catch a single beacon and
even manage to connect but not even ping can reach my AP.

Sometimes traffic just stops for a few seconds:
[  3] 1120.0-1121.0 sec  2.88 MBytes  24.1 Mbits/sec
[  3] 1121.0-1122.0 sec  3.62 MBytes  30.4 Mbits/sec
[  3] 1122.0-1123.0 sec  1.20 MBytes  10.1 Mbits/sec
[  3] 1123.0-1124.0 sec  2.00 MBytes  16.8 Mbits/sec
[  3] 1124.0-1125.0 sec  3.12 MBytes  26.2 Mbits/sec
[  3] 1125.0-1126.0 sec  5.12 MBytes  43.0 Mbits/sec
[  3] 1126.0-1127.0 sec  4.38 MBytes  36.7 Mbits/sec
[  3] 1127.0-1128.0 sec  5.25 MBytes  44.0 Mbits/sec
[  3] 1128.0-1129.0 sec  3.49 MBytes  29.2 Mbits/sec
[  3] 1129.0-1130.0 sec   509 KBytes  4.17 Mbits/sec
[  3] 1130.0-1131.0 sec  0.00 Bytes  0.00 bits/sec
[  3] 1131.0-1132.0 sec  0.00 Bytes  0.00 bits/sec
[  3] 1132.0-1133.0 sec  0.00 Bytes  0.00 bits/sec
[  3] 1133.0-1134.0 sec  0.00 Bytes  0.00 bits/sec
[  3] 1134.0-1135.0 sec  0.00 Bytes  0.00 bits/sec
[  3] 1135.0-1136.0 sec  0.00 Bytes  0.00 bits/sec
[  3] 1136.0-1137.0 sec  0.00 Bytes  0.00 bits/sec
[  3] 1137.0-1138.0 sec  0.00 Bytes  0.00 bits/sec
[  3] 1138.0-1139.0 sec  0.00 Bytes  0.00 bits/sec
[  3] 1139.0-1140.0 sec  0.00 Bytes  0.00 bits/sec
[  3] 1140.0-1141.0 sec  0.00 Bytes  0.00 bits/sec
[  3] 1141.0-1142.0 sec  0.00 Bytes  0.00 bits/sec
[  3] 1142.0-1143.0 sec  0.00 Bytes  0.00 bits/sec
[  3] 1143.0-1144.0 sec  0.00 Bytes  0.00 bits/sec
[  3] 1144.0-1145.0 sec   128 KBytes  1.05 Mbits/sec
[  3] 1145.0-1146.0 sec  3.62 MBytes  30.4 Mbits/sec
[  3] 1146.0-1147.0 sec  4.38 MBytes  36.7 Mbits/sec
[  3] 1147.0-1148.0 sec  3.88 MBytes  32.5 Mbits/sec
[  3] 1148.0-1149.0 sec  4.50 MBytes  37.7 Mbits/sec
[  3] 1149.0-1150.0 sec  3.75 MBytes  31.5 Mbits/sec

Or slows down:
[  3] 1316.0-1317.0 sec  3.88 MBytes  32.5 Mbits/sec
[  3] 1317.0-1318.0 sec  3.00 MBytes  25.2 Mbits/sec
[  3] 1318.0-1319.0 sec  4.75 MBytes  39.8 Mbits/sec
[  3] 1319.0-1320.0 sec  3.00 MBytes  25.2 Mbits/sec
[  3] 1320.0-1321.0 sec  3.88 MBytes  32.5 Mbits/sec
[  3] 1321.0-1322.0 sec  2.95 MBytes  24.7 Mbits/sec
[  3] 1322.0-1323.0 sec  1018 KBytes  8.34 Mbits/sec
[  3] 1323.0-1324.0 sec   954 KBytes  7.82 Mbits/sec
[  3] 1324.0-1325.0 sec   827 KBytes  6.78 Mbits/sec
[  3] 1325.0-1326.0 sec   891 KBytes  7.30 Mbits/sec
[  3] 1326.0-1327.0 sec   827 KBytes  6.78 Mbits/sec
[  3] 1327.0-1328.0 sec   764 KBytes  6.26 Mbits/sec
[  3] 1328.0-1329.0 sec  1.50 MBytes  12.6 Mbits/sec
[  3] 1329.0-1330.0 sec  1.23 MBytes  10.4 Mbits/sec
[  3] 1330.0-1331.0 sec  1.18 MBytes  9.93 Mbits/sec
[  3] 1331.0-1332.0 sec  3.00 MBytes  25.2 Mbits/sec
[  3] 1332.0-1333.0 sec  2.25 MBytes  18.9 Mbits/sec
[  3] 1333.0-1334.0 sec  1.34 MBytes  11.2 Mbits/sec
[  3] 1334.0-1335.0 sec  1.24 MBytes  10.4 Mbits/sec
[  3] 1335.0-1336.0 sec  1.24 MBytes  10.4 Mbits/sec
[  3] 1336.0-1337.0 sec  1.75 MBytes  14.7 Mbits/sec
[  3] 1337.0-1338.0 sec  5.25 MBytes  44.0 Mbits/sec
[  3] 1338.0-1339.0 sec  4.38 MBytes  36.7 Mbits/sec
[  3] 1339.0-1340.0 sec  3.75 MBytes  31.5 Mbits/sec
[  3] 1340.0-1341.0 sec  3.88 MBytes  32.5 Mbits/sec

Whenever any issue occurs I don't see anything in my dmesg. Every time
it happens it affects all of my 3 STAs (notebook + 2 smartphones).

Waiting for few minutes brings things back to normal. I don't need any
hostapd restart / device reboot.

Stability problem was reported for this router multiple times by
different users. Reports go back to the October 2020 when OpenWrt
received that router support.

https://forum.openwrt.org/t/openwrt-for-xiaomi-mi-router-4c/72175/42
https://forum.openwrt.org/t/openwrt-for-xiaomi-mi-router-4c/72175/46
https://forum.openwrt.org/t/openwrt-for-xiaomi-mi-router-4c/72175/48
https://forum.openwrt.org/t/openwrt-for-xiaomi-mi-router-4c/72175/52
https://forum.openwrt.org/t/openwrt-for-xiaomi-mi-router-4c/72175/65
https://forum.openwrt.org/t/openwrt-for-xiaomi-mi-router-4c/72175/97
https://forum.openwrt.org/t/openwrt-for-xiaomi-mi-router-4c/72175/112
https://forum.openwrt.org/t/openwrt-for-xiaomi-mi-router-4c/72175/113

Is there anything I can do to help debugging / fixing this?
