Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6013810E243
	for <lists+linux-wireless@lfdr.de>; Sun,  1 Dec 2019 15:56:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726498AbfLAO46 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 1 Dec 2019 09:56:58 -0500
Received: from wp063.webpack.hosteurope.de ([80.237.132.70]:54386 "EHLO
        wp063.webpack.hosteurope.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726393AbfLAO45 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 1 Dec 2019 09:56:57 -0500
X-Greylist: delayed 1612 seconds by postgrey-1.27 at vger.kernel.org; Sun, 01 Dec 2019 09:56:57 EST
Received: from processor.work ([89.163.132.190] helo=webmail.richenhagen.gl); authenticated
        by wp063.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1ibQEe-00038U-GJ; Sun, 01 Dec 2019 15:30:04 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Sun, 01 Dec 2019 15:30:04 +0100
From:   <linux@jusic.net>
To:     linux-wireless@vger.kernel.org
Subject: RTL8822CE IPv6 autoconfiguration not working
User-Agent: Roundcube Webmail/1.4.0
Message-ID: <f0aac1e559c2a3fa1e7eb8398ed58d46@jusic.net>
X-Sender: linux@jusic.net
X-bounce-key: webpack.hosteurope.de;linux@jusic.net;1575212217;c826eb84;
X-HE-SMSGID: 1ibQEe-00038U-GJ
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hello,

I just bought a new laptop with an Realtek RTL8822CE wireless card 
buildin. I'm using NetworkManager with its internal DHCP client. I have 
working IPv6 autoconfiguration support in my home network with 7 devices 
with different operating systems. When I plug a USB network card into 
the laptop IPv6 is configured sucessfully. But with the wireless card 
IPv6 autoconfiguration doesn't work. When I manually add an IPv6 with 
"sudo ip -6 addr add <address>/64 dev wlp1s0" I can ping IPv6 targets. 
So there seems to be an bug either in the driver or maybe in 
NetworkManager which prevents autoconfiguration from working, can 
sombody look into this? I'm glad to help and provide further 
informations or test things out.

Kind Regards
Joshua


ip addr
1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN 
group default qlen 1000
     link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
     inet 127.0.0.1/8 scope host lo
        valid_lft forever preferred_lft forever
     inet6 ::1/128 scope host
        valid_lft forever preferred_lft forever
2: wlp1s0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc mq state UP 
group default qlen 1000
     link/ether 40:5b:d8:1a:7a:a9 brd ff:ff:ff:ff:ff:ff
     inet 192.168.178.25/24 brd 192.168.178.255 scope global dynamic 
noprefixroute wlp1s0
        valid_lft 863798sec preferred_lft 863798sec
     inet6 fe80::1b8b:8c3a:b569:a882/64 scope link noprefixroute
        valid_lft forever preferred_lft forever

lspci -v
01:00.0 Network controller: Realtek Semiconductor Co., Ltd. Device c822
	Subsystem: Electronics & Telecommunications RSH Device 1e25
	Flags: bus master, fast devsel, latency 0, IRQ 71
	I/O ports at 2000 [size=256]
	Memory at c0700000 (64-bit, non-prefetchable) [size=64K]
	Capabilities: <access denied>
	Kernel driver in use: rtw_pci
	Kernel modules: rtwpci

modinfo rtwpci
filename:       
/lib/modules/5.4.0-1-MANJARO/kernel/drivers/net/wireless/realtek/rtw88/rtwpci.ko.xz
license:        Dual BSD/GPL
description:    Realtek 802.11ac wireless PCI driver
author:         Realtek Corporation
srcversion:     448C0585DF0ABCA65D336FE
alias:          pci:v000010ECd0000C822sv*sd*bc*sc*i*
alias:          pci:v000010ECd0000B822sv*sd*bc*sc*i*
depends:        mac80211,rtw88
retpoline:      Y
intree:         Y
name:           rtwpci
vermagic:       5.4.0-1-MANJARO SMP preempt mod_unload modversions
sig_id:         PKCS#7
signer:         Build time autogenerated kernel key
sig_key:        
07:5C:C8:41:DA:A5:E4:8F:79:78:39:15:5B:06:78:AC:CA:3E:5C:5F
sig_hashalgo:   sha512
signature:      
15:AA:70:FA:2F:F8:37:3B:E9:29:90:A4:3B:55:C4:F1:D4:50:4D:5F:
		D5:D9:20:4C:2C:48:6A:1D:14:6F:B5:FA:BF:61:D5:2D:F9:1B:DE:70:
		26:83:81:62:B6:2F:5C:6B:92:13:08:32:59:15:F0:42:40:64:46:13:
		3C:9F:21:A1:DD:56:E7:B3:F5:A3:66:FB:28:3B:FD:06:25:34:44:0E:
		D5:5D:98:15:1A:04:D1:08:42:71:DE:5C:A0:EC:26:90:EC:22:FD:A5:
		BA:C2:C9:14:21:63:4A:EA:06:60:AB:0F:9A:1F:AB:26:04:74:DB:2B:
		20:71:41:09:7D:85:6C:18:F1:81:59:65:62:28:79:3C:01:EA:39:93:
		A2:36:9F:63:3F:67:03:CC:5D:45:F9:1B:F8:4C:58:37:77:41:42:46:
		FD:12:80:09:68:CE:00:C2:16:2E:B1:4D:48:36:78:95:52:2E:15:27:
		6F:FA:1E:57:2D:A2:C2:4E:60:27:64:8D:1F:64:B5:A6:7A:F4:28:D3:
		59:63:09:44:E2:17:06:19:78:6B:4F:90:69:52:29:A1:A5:8E:AC:70:
		EE:9D:A6:77:59:BB:76:E7:20:FE:32:CB:AC:FF:F3:55:C2:3E:BF:60:
		35:EA:CA:7E:5E:0C:1A:46:2B:2C:88:32:1E:48:E0:18:9B:56:E4:0A:
		CB:87:98:AF:EE:F0:5A:B4:AE:80:71:16:69:CB:E8:A1:8A:7E:F2:CD:
		8F:24:40:3D:1F:05:34:E2:6C:31:A8:44:BD:57:44:BB:7B:C9:88:A2:
		36:40:B7:1B:3F:EC:6C:06:BF:1A:EB:B5:47:F1:3D:D4:06:53:DF:48:
		B8:A0:F2:89:F7:A6:E1:F6:CC:FF:D9:3D:F4:86:DE:93:C9:11:F1:4A:
		B7:AC:15:3D:18:48:A7:D6:30:4B:0C:1A:61:97:48:3B:83:B0:AE:61:
		9A:1B:E2:34:AB:BB:93:D0:5B:97:B0:CB:89:FD:0B:6D:C9:AD:B9:F0:
		CE:21:0E:40:32:D6:F2:08:15:F1:92:42:BC:BE:4B:48:58:56:6A:B6:
		21:79:B8:D6:A0:02:E7:E4:6A:B9:A1:92:37:EF:58:4D:9D:71:C5:F2:
		B0:82:03:44:51:D7:DC:AA:45:39:19:3D:17:2D:C9:94:8A:26:FC:37:
		18:31:CA:0B:17:48:E8:1C:00:E5:6D:20:E0:9D:9E:2B:39:A9:F0:FC:
		B0:E8:C8:FB:81:5B:4D:50:12:2B:87:0F:C1:66:1C:8B:91:0A:2A:8B:
		9A:98:D7:DD:48:DC:2A:19:61:31:E6:B1:32:06:42:B0:FD:BB:C9:FD:
		26:EC:9D:EA:EC:6F:30:1A:86:C5:3D:96
parm:           disable_msi:Set Y to disable MSI interrupt support 
(bool)
