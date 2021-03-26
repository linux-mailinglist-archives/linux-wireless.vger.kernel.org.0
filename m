Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2CAF034AA8D
	for <lists+linux-wireless@lfdr.de>; Fri, 26 Mar 2021 15:53:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230174AbhCZOwf (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 26 Mar 2021 10:52:35 -0400
Received: from 8.mo4.mail-out.ovh.net ([188.165.33.112]:60392 "EHLO
        8.mo4.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230016AbhCZOwS (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 26 Mar 2021 10:52:18 -0400
X-Greylist: delayed 8958 seconds by postgrey-1.27 at vger.kernel.org; Fri, 26 Mar 2021 10:52:17 EDT
Received: from player687.ha.ovh.net (unknown [10.110.171.136])
        by mo4.mail-out.ovh.net (Postfix) with ESMTP id 2937D26F94C
        for <linux-wireless@vger.kernel.org>; Fri, 26 Mar 2021 13:22:52 +0100 (CET)
Received: from webmining-systems.com (lfbn-idf1-1-6-174.w82-124.abo.wanadoo.fr [82.124.102.174])
        (Authenticated sender: info@webmining-systems.com)
        by player687.ha.ovh.net (Postfix) with ESMTPSA id BB7061C6FE9AF
        for <linux-wireless@vger.kernel.org>; Fri, 26 Mar 2021 12:22:51 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass (GARM-96R0011fb5e9c4-6d78-4f19-bbd9-dc0b98e190ea,
                    AFE5C79B1FAA7D1EDF7C32D036EF214F06ADB4CD) smtp.auth=info@webmining-systems.com
X-OVh-ClientIp: 82.124.102.174
From:   Michal TOMA <michaltoma@sicoop.com>
To:     linux-wireless@vger.kernel.org
Subject: RTL8821CE 802.11ac PCIe Wireless Network Adapter - Not handled properly by the rtw_8821ce dirver on Kernel 5.11.6-1
Date:   Fri, 26 Mar 2021 13:16:25 +0100
Message-ID: <2846955.Y2WTrdj9rP@linux-9g0r.site>
Organization: SICOOP
User-Agent: KMail/4.10.5 (Linux/3.7.10-1.45-desktop; KDE/4.10.5; x86_64; ; )
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Ovh-Tracer-Id: 15139694574004615620
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: 0
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduledrudehvddggeduucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucenucfjughrpefhvffufffkohgfggfgtgesthfuredttdeivdenucfhrhhomhepofhitghhrghlucfvqffotecuoehmihgthhgrlhhtohhmrgesshhitghoohhprdgtohhmqeenucggtffrrghtthgvrhhnpeegheefleeikeehhfelheekhfetjeffjeekuedvvddvveevffejueegfeekffekvdenucfkpheptddrtddrtddrtddpkedvrdduvdegrddutddvrddujeegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmohguvgepshhmthhpqdhouhhtpdhhvghlohepphhlrgihvghrieekjedrhhgrrdhovhhhrdhnvghtpdhinhgvtheptddrtddrtddrtddpmhgrihhlfhhrohhmpehmihgthhgrlhhtohhmrgesshhitghoohhprdgtohhmpdhrtghpthhtoheplhhinhhugidqfihirhgvlhgvshhssehvghgvrhdrkhgvrhhnvghlrdhorhhg
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

The RTL8821CE driver doesn't work on several recent kernels (probably since 
5.9).


journalctl -b | grep 8821
mars 19 22:49:13 localhost kernel: rtw_8821ce 0000:07:00.0: Firmware version 
24.8.0, H2C version 12
mars 19 22:49:13 localhost NetworkManager[639]: <info>  [1616190553.7766] 
rfkill2: found Wi-Fi radio killswitch (at 
/sys/devices/pci0000:00/0000:00:1d.4/0000:07:00.0/ieee80211/phy0/rfkill2) 
(driver rtw_8821ce)
mars 19 22:49:13 localhost kernel: rtw_8821ce 0000:07:00.0 wlp7s0: renamed 
from wlan0
mars 19 22:49:14 localhost kernel: rtw_8821ce 0000:07:00.0: start vif 
28:39:26:ab:b4:5d on port 0
mars 19 22:49:14 localhost kernel: rtw_8821ce 0000:07:00.0: stop vif 
28:39:26:ab:b4:5d on port 0
mars 19 22:49:14 localhost kernel: rtw_8821ce 0000:07:00.0: start vif 
7a:36:c4:26:1d:f1 on port 0
mars 19 22:56:07 linux.local kernel: rtw_8821ce 0000:07:00.0: stop vif 
7a:36:c4:26:1d:f1 on port 0
mars 19 22:56:07 linux.local kernel: rtw_8821ce 0000:07:00.0: start vif 
c2:a0:c3:48:17:58 on port 0
mars 19 23:03:00 linux.local kernel: rtw_8821ce 0000:07:00.0: stop vif 
c2:a0:c3:48:17:58 on port 0
mars 19 23:03:00 linux.local kernel: rtw_8821ce 0000:07:00.0: start vif 
ae:92:06:47:50:83 on port 0
mars 19 23:09:52 linux.local kernel: rtw_8821ce 0000:07:00.0: stop vif 
ae:92:06:47:50:83 on port 0
...
And continues like this indefinitely

uname -a
Linux linux.local 5.11.6-1-default #1 SMP Thu Mar 11 16:11:36 UTC 2021 
(7358b30) x86_64 x86_64 x86_64 GNU/Linux

rfkill list 
0: ideapad_wlan: Wireless LAN
        Soft blocked: no
        Hard blocked: no
1: ideapad_bluetooth: Bluetooth
        Soft blocked: no
        Hard blocked: no
2: phy0: Wireless LAN
        Soft blocked: no
        Hard blocked: no

