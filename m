Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A4F9A113A7F
	for <lists+linux-wireless@lfdr.de>; Thu,  5 Dec 2019 04:36:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728539AbfLEDg3 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 4 Dec 2019 22:36:29 -0500
Received: from rtits2.realtek.com ([211.75.126.72]:56698 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728490AbfLEDg3 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 4 Dec 2019 22:36:29 -0500
Authenticated-By: 
X-SpamFilter-By: BOX Solutions SpamTrap 5.62 with qID xB53aI75009433, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (RTITCAS12.realtek.com.tw[172.21.6.16])
        by rtits2.realtek.com.tw (8.15.2/2.57/5.78) with ESMTPS id xB53aI75009433
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 5 Dec 2019 11:36:19 +0800
Received: from RTEXDAG01.realtek.com.tw (172.21.6.100) by
 RTITCAS12.realtek.com.tw (172.21.6.16) with Microsoft SMTP Server (TLS) id
 14.3.468.0; Thu, 5 Dec 2019 11:36:18 +0800
Received: from RTEXMB04.realtek.com.tw (172.21.6.97) by
 RTEXDAG01.realtek.com.tw (172.21.6.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Thu, 5 Dec 2019 11:36:18 +0800
Received: from RTEXMB04.realtek.com.tw ([fe80::7d15:f8ee:cfc7:88ce]) by
 RTEXMB04.realtek.com.tw ([fe80::7d15:f8ee:cfc7:88ce%6]) with mapi id
 15.01.1779.005; Thu, 5 Dec 2019 11:36:18 +0800
From:   Tony Chuang <yhchuang@realtek.com>
To:     "linux@jusic.net" <linux@jusic.net>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: RTL8822CE IPv6 autoconfiguration not working
Thread-Topic: RTL8822CE IPv6 autoconfiguration not working
Thread-Index: AQHVqFeWgmjllZPQVk+Ms5UKcM7zDKeq6Qwg
Date:   Thu, 5 Dec 2019 03:36:18 +0000
Message-ID: <e58983606ddb4d3c81f4d8bb27171da8@realtek.com>
References: <f0aac1e559c2a3fa1e7eb8398ed58d46@jusic.net>
In-Reply-To: <f0aac1e559c2a3fa1e7eb8398ed58d46@jusic.net>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.21.68.183]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

> Subject: RTL8822CE IPv6 autoconfiguration not working
> 
> Hello,
> 
> I just bought a new laptop with an Realtek RTL8822CE wireless card
> buildin. I'm using NetworkManager with its internal DHCP client. I have
> working IPv6 autoconfiguration support in my home network with 7 devices
> with different operating systems. When I plug a USB network card into
> the laptop IPv6 is configured sucessfully. But with the wireless card
> IPv6 autoconfiguration doesn't work. When I manually add an IPv6 with
> "sudo ip -6 addr add <address>/64 dev wlp1s0" I can ping IPv6 targets.
> So there seems to be an bug either in the driver or maybe in
> NetworkManager which prevents autoconfiguration from working, can
> sombody look into this? I'm glad to help and provide further
> informations or test things out.
> 
> Kind Regards
> Joshua
> 
> 
> ip addr
> 1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state
> UNKNOWN
> group default qlen 1000
>      link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
>      inet 127.0.0.1/8 scope host lo
>         valid_lft forever preferred_lft forever
>      inet6 ::1/128 scope host
>         valid_lft forever preferred_lft forever
> 2: wlp1s0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc mq
> state UP
> group default qlen 1000
>      link/ether 40:5b:d8:1a:7a:a9 brd ff:ff:ff:ff:ff:ff
>      inet 192.168.178.25/24 brd 192.168.178.255 scope global dynamic
> noprefixroute wlp1s0
>         valid_lft 863798sec preferred_lft 863798sec
>      inet6 fe80::1b8b:8c3a:b569:a882/64 scope link noprefixroute
>         valid_lft forever preferred_lft forever
> 
> lspci -v
> 01:00.0 Network controller: Realtek Semiconductor Co., Ltd. Device c822
> 	Subsystem: Electronics & Telecommunications RSH Device 1e25
> 	Flags: bus master, fast devsel, latency 0, IRQ 71
> 	I/O ports at 2000 [size=256]
> 	Memory at c0700000 (64-bit, non-prefetchable) [size=64K]
> 	Capabilities: <access denied>
> 	Kernel driver in use: rtw_pci
> 	Kernel modules: rtwpci
> 

I am not sure if this is driver-related problem, but I think you can try to
tcpdump and see where the autoconfiguration failed.
And I am not an expert of IPv6, but if there is any issue with the driver I
can help you.

Yan-Hsuan
