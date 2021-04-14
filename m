Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5424635F18C
	for <lists+linux-wireless@lfdr.de>; Wed, 14 Apr 2021 12:37:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233847AbhDNKh4 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 14 Apr 2021 06:37:56 -0400
Received: from 6.mo179.mail-out.ovh.net ([46.105.56.76]:58008 "EHLO
        6.mo179.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232235AbhDNKhz (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 14 Apr 2021 06:37:55 -0400
X-Greylist: delayed 2399 seconds by postgrey-1.27 at vger.kernel.org; Wed, 14 Apr 2021 06:37:55 EDT
Received: from player799.ha.ovh.net (unknown [10.110.115.149])
        by mo179.mail-out.ovh.net (Postfix) with ESMTP id 2061C195C90
        for <linux-wireless@vger.kernel.org>; Wed, 14 Apr 2021 11:19:09 +0200 (CEST)
Received: from webmining-systems.com (lfbn-idf1-1-6-174.w82-124.abo.wanadoo.fr [82.124.102.174])
        (Authenticated sender: info@webmining-systems.com)
        by player799.ha.ovh.net (Postfix) with ESMTPSA id D21C61D137508
        for <linux-wireless@vger.kernel.org>; Wed, 14 Apr 2021 09:19:08 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass (GARM-101G00481503b9e-726f-47ae-9c98-5ba0560b3fd4,
                    A50448BECFF887ADF2A79382723AE2F805D580F3) smtp.auth=info@webmining-systems.com
X-OVh-ClientIp: 82.124.102.174
From:   Michal TOMA <michaltoma@sicoop.com>
To:     linux-wireless@vger.kernel.org
Subject: [Bug report] - RTL8821CE 802.11ac PCIe Wireless Network Adapter - Not handled properly by the rtw_8821ce dirver on Kernel 5.11.11
Date:   Wed, 14 Apr 2021 11:12:43 +0200
Message-ID: <2562248.KvEgbkE9EU@linux-9g0r.site>
Organization: SICOOP
User-Agent: KMail/4.10.5 (Linux/3.7.10-1.45-desktop; KDE/4.10.5; x86_64; ; )
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Ovh-Tracer-Id: 12937715832628722116
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: 0
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduledrudeluddgudehucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucenucfjughrpefhvffufffkohgfggfgtgesthfuredttdeivdenucfhrhhomhepofhitghhrghlucfvqffotecuoehmihgthhgrlhhtohhmrgesshhitghoohhprdgtohhmqeenucggtffrrghtthgvrhhnpeegheefleeikeehhfelheekhfetjeffjeekuedvvddvveevffejueegfeekffekvdenucfkpheptddrtddrtddrtddpkedvrdduvdegrddutddvrddujeegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmohguvgepshhmthhpqdhouhhtpdhhvghlohepphhlrgihvghrjeelledrhhgrrdhovhhhrdhnvghtpdhinhgvtheptddrtddrtddrtddpmhgrihhlfhhrohhmpehmihgthhgrlhhtohhmrgesshhitghoohhprdgtohhmpdhrtghpthhtoheplhhinhhugidqfihirhgvlhgvshhssehvghgvrhdrkhgvrhhnvghlrdhorhhg
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

The RTL8821CE driver doesn't work on several recent kernels (probably since 
5.9).


journalctl -b | grep rtw
avril 10 14:18:41 localhost kernel: rtw_8821ce 0000:07:00.0: Firmware version 24.8.0, H2C version 12
avril 10 14:18:41 localhost NetworkManager[682]: <info>  [1618057121.6199] rfkill2: found Wi-Fi radio killswitch (at /sys/devices/pci0000:00/0000:00:1d.4/0000:07:00.0/ieee80211/phy0/rfkill2) (driver rtw_8821ce)
avril 10 14:18:41 localhost kernel: rtw_8821ce 0000:07:00.0 wlp7s0: renamed from wlan0
avril 10 14:18:42 localhost kernel: rtw_8821ce 0000:07:00.0: start vif 28:39:26:ab:b4:5d on port 0
avril 10 14:18:42 localhost kernel: rtw_8821ce 0000:07:00.0: stop vif 28:39:26:ab:b4:5d on port 0
avril 10 14:18:42 localhost kernel: rtw_8821ce 0000:07:00.0: start vif 5a:f0:11:63:85:65 on port 0
avril 10 14:25:35 Host-001 kernel: rtw_8821ce 0000:07:00.0: stop vif 5a:f0:11:63:85:65 on port 0
avril 10 14:25:35 Host-001 kernel: rtw_8821ce 0000:07:00.0: start vif 32:45:38:02:34:09 on port 0
avril 10 14:32:28 Host-001 kernel: rtw_8821ce 0000:07:00.0: stop vif 32:45:38:02:34:09 on port 0
avril 10 14:32:28 Host-001 kernel: rtw_8821ce 0000:07:00.0: start vif c2:5c:03:32:bc:19 on port 0
avril 10 14:39:21 Host-001 kernel: rtw_8821ce 0000:07:00.0: stop vif c2:5c:03:32:bc:19 on port 0
avril 10 14:39:21 Host-001 kernel: rtw_8821ce 0000:07:00.0: start vif de:9c:ac:b2:58:ae on port 0
avril 10 14:46:14 Host-001 kernel: rtw_8821ce 0000:07:00.0: stop vif de:9c:ac:b2:58:ae on port 0
avril 10 14:46:14 Host-001 kernel: rtw_8821ce 0000:07:00.0: start vif 46:5c:c2:91:f8:7f on port 0
...
And continues like this indefinitely

uname -a
Linux Host-001 5.11.11-1-default #1 SMP Tue Mar 30 17:57:52 UTC 2021 (dbc4a02) x86_64 x86_64 x86_64 GNU/Linux


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
