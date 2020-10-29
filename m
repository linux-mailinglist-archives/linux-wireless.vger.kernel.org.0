Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82C0129F3E0
	for <lists+linux-wireless@lfdr.de>; Thu, 29 Oct 2020 19:12:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725841AbgJ2SMd (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 29 Oct 2020 14:12:33 -0400
Received: from 10.mo177.mail-out.ovh.net ([46.105.73.133]:33227 "EHLO
        10.mo177.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725747AbgJ2SMc (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 29 Oct 2020 14:12:32 -0400
X-Greylist: delayed 2398 seconds by postgrey-1.27 at vger.kernel.org; Thu, 29 Oct 2020 14:12:30 EDT
Received: from player746.ha.ovh.net (unknown [10.108.42.23])
        by mo177.mail-out.ovh.net (Postfix) with ESMTP id F13AE14439D
        for <linux-wireless@vger.kernel.org>; Thu, 29 Oct 2020 17:53:37 +0100 (CET)
Received: from webmining-systems.com (lfbn-idf1-1-284-37.w86-195.abo.wanadoo.fr [86.195.122.37])
        (Authenticated sender: info@webmining-systems.com)
        by player746.ha.ovh.net (Postfix) with ESMTPSA id 9D96B17B9798D
        for <linux-wireless@vger.kernel.org>; Thu, 29 Oct 2020 16:53:37 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass (GARM-97G002cb71d9ba-7a27-4482-8c95-7b8197e55ce7,
                    C82B0129A97CC3678E441CABB490FEB73E31324D) smtp.auth=info@webmining-systems.com
From:   Michal TOMA <michaltoma@sicoop.com>
To:     linux-wireless@vger.kernel.org
Subject: rtw_8821ce driver in kernel 5.9.1: wifi module inactive
Date:   Thu, 29 Oct 2020 17:47:28 +0100
Message-ID: <6173742.tiux6Xeah1@linux-9g0r.site>
Organization: SICOOP
User-Agent: KMail/4.10.5 (Linux/3.7.10-1.45-desktop; KDE/4.10.5; x86_64; ; )
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Ovh-Tracer-Id: 17550809226005658052
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: 0
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedujedrleefgdelfecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecunecujfgurhephffvufffkfhofggggfgtsehtufertddtiedvnecuhfhrohhmpefoihgthhgrlhcuvffqofetuceomhhitghhrghlthhomhgrsehsihgtohhophdrtghomheqnecuggftrfgrthhtvghrnhepgeehfeelieekhefhleehkefhteejffejkeeuvddvvdevveffjeeugeefkeffkedvnecukfhppedtrddtrddtrddtpdekiedrudelhedruddvvddrfeejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmohguvgepshhmthhpqdhouhhtpdhhvghlohepphhlrgihvghrjeegiedrhhgrrdhovhhhrdhnvghtpdhinhgvtheptddrtddrtddrtddpmhgrihhlfhhrohhmpehmihgthhgrlhhtohhmrgesshhitghoohhprdgtohhmpdhrtghpthhtoheplhhinhhugidqfihirhgvlhgvshhssehvghgvrhdrkhgvrhhnvghlrdhorhhg
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi,

On OpenSuse Tumbleweed rtw_8821ce driver breaks wifi.

-> uname -a
Linux Host-001 5.9.1-1-default #1 SMP Mon Oct 26 07:02:23 UTC 2020 (435e92d) x86_64 x86_64 x86_64 GNU/Linux

/sbin/lspci -nnk | grep -iA3 net
07:00.0 Network controller [0280]: Realtek Semiconductor Co., Ltd. RTL8821CE 802.11ac PCIe Wireless Network Adapter [10ec:c821]
        Subsystem: Lenovo Device [17aa:c024]
        Kernel driver in use: rtw_8821ce
        Kernel modules: rtw88_8821ce, wl
08:00.0 Ethernet controller [0200]: Realtek Semiconductor Co., Ltd. RTL8111/8168/8411 PCI Express Gigabit Ethernet Controller [10ec:8168] (rev 10)
        Subsystem: Lenovo Device [17aa:38cf]
        Kernel driver in use: r8168
        Kernel modules: r8169, r8168


->cat /proc/net/wireless 
Inter-| sta-|   Quality        |   Discarded packets               | Missed | WE
 face | tus | link level noise |  nwid  crypt   frag  retry   misc | beacon | 22


->iwconfig wlp7s0
wlp7s0    IEEE 802.11  ESSID:off/any  
          Mode:Managed  Access Point: Not-Associated   Tx-Power=20 dBm   
          Retry short limit:7   RTS thr:off   Fragment thr:off
          Encryption key:off
          Power Management:off

->iwlist wlp7s0 scan
wlp7s0    No scan results


->rfkill list 
0: ideapad_wlan: Wireless LAN
        Soft blocked: no
        Hard blocked: no
1: ideapad_bluetooth: Bluetooth
        Soft blocked: yes
        Hard blocked: no
2: hci0: Bluetooth
        Soft blocked: yes
        Hard blocked: no
3: phy0: Wireless LAN
        Soft blocked: no
        Hard blocked: no


->dmesg | grep 8821
[    7.075396] rtw_8821ce 0000:07:00.0: Firmware version 24.5.0, H2C version 12
[    7.764587] rtw_8821ce 0000:07:00.0 wlp7s0: renamed from wlan0
[    8.354754] rtw_8821ce 0000:07:00.0: start vif 28:39:26:ab:b4:5d on port 0
[    8.358871] rtw_8821ce 0000:07:00.0: stop vif 28:39:26:ab:b4:5d on port 0
[    8.874899] rtw_8821ce 0000:07:00.0: start vif e2:57:07:37:e3:1e on port 0
[  421.023270] rtw_8821ce 0000:07:00.0: stop vif e2:57:07:37:e3:1e on port 0
[  421.543601] rtw_8821ce 0000:07:00.0: start vif fe:92:51:d5:45:b5 on port 0
[  833.018457] rtw_8821ce 0000:07:00.0: stop vif fe:92:51:d5:45:b5 on port 0
[  833.540507] rtw_8821ce 0000:07:00.0: start vif 0e:7e:da:5f:c3:0d on port 0
[ 1245.043076] rtw_8821ce 0000:07:00.0: stop vif 0e:7e:da:5f:c3:0d on port 0
[ 1245.565253] rtw_8821ce 0000:07:00.0: start vif be:74:9e:7b:ed:4b on port 0
And confinues likes this indefinitely


->lshw -C network
  *-network                 
       description: Wireless interface
       product: RTL8821CE 802.11ac PCIe Wireless Network Adapter
       vendor: Realtek Semiconductor Co., Ltd.
       physical id: 0
       bus info: pci@0000:07:00.0
       logical name: wlp7s0
       version: 00
       serial: be:1c:8a:79:49:d6
       width: 64 bits
       clock: 33MHz
       capabilities: pm msi pciexpress bus_master cap_list ethernet physical wireless
       configuration: broadcast=yes driver=rtw_8821ce driverversion=5.9.1-1-default firmware=N/A latency=0 link=no multicast=yes wireless=IEEE 802.11
       resources: irq:142 ioport:4000(size=256) memory:a4300000-a430ffff
  *-network
       description: Ethernet interface
       product: RTL8111/8168/8411 PCI Express Gigabit Ethernet Controller
       vendor: Realtek Semiconductor Co., Ltd.
       physical id: 0
       bus info: pci@0000:08:00.0
       logical name: enp8s0
       version: 10
       serial: f8:75:a4:08:eb:06
       size: 1Gbit/s
       capacity: 1Gbit/s
       width: 64 bits
       clock: 33MHz
       capabilities: pm msi pciexpress msix vpd bus_master cap_list ethernet physical tp 10bt 10bt-fd 100bt 100bt-fd 1000bt-fd autonegotiation
       configuration: autonegotiation=on broadcast=yes driver=r8168 driverversion=8.048.03-NAPI duplex=full ip=192.168.1.3 latency=0 link=yes multicast=yes port=twisted pair speed=1Gbit/s
       resources: irq:140 ioport:3000(size=256) memory:a4204000-a4204fff memory:a4200000-a4203fff


Happy to provide more information if needed.

Michal
