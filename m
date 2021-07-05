Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E038D3BB4F6
	for <lists+linux-wireless@lfdr.de>; Mon,  5 Jul 2021 03:43:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229713AbhGEBpI convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 4 Jul 2021 21:45:08 -0400
Received: from rtits2.realtek.com ([211.75.126.72]:35363 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229681AbhGEBpI (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 4 Jul 2021 21:45:08 -0400
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 1651gT9P1018663, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36502.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.71/5.88) with ESMTPS id 1651gT9P1018663
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 5 Jul 2021 09:42:29 +0800
Received: from RTEXMBS01.realtek.com.tw (172.21.6.94) by
 RTEXH36502.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Mon, 5 Jul 2021 09:42:28 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS01.realtek.com.tw (172.21.6.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Mon, 5 Jul 2021 09:42:28 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::a0a3:e64a:34ad:fe28]) by
 RTEXMBS04.realtek.com.tw ([fe80::a0a3:e64a:34ad:fe28%5]) with mapi id
 15.01.2106.013; Mon, 5 Jul 2021 09:42:28 +0800
From:   Pkshih <pkshih@realtek.com>
To:     Doug Brewer <brewerdoug@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: rtw89: product id 0xa85a support on Linux?
Thread-Topic: rtw89: product id 0xa85a support on Linux?
Thread-Index: AQHXcOLAdohydq+1T0GLKHM79Zro1KszmvQA
Date:   Mon, 5 Jul 2021 01:42:27 +0000
Message-ID: <8e844938463c470d9669247227db9c30@realtek.com>
References: <20210704143510.GA5787@www.com>
In-Reply-To: <20210704143510.GA5787@www.com>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.21.69.146]
x-kse-serverinfo: RTEXMBS01.realtek.com.tw, 9
x-kse-attachmentfiltering-interceptor-info: no applicable attachment filtering
 rules found
x-kse-antivirus-interceptor-info: scan successful
x-kse-antivirus-info: =?us-ascii?Q?Clean,_bases:_2021/7/4_=3F=3F_10:00:00?=
x-kse-bulkmessagesfiltering-scan-result: protection disabled
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-KSE-ServerInfo: RTEXH36502.realtek.com.tw, 9
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-KSE-AntiSpam-Outbound-Interceptor-Info: scan successful
X-KSE-AntiSpam-Version: 5.9.20, Database issued on: 07/05/2021 01:25:32
X-KSE-AntiSpam-Status: KAS_STATUS_NOT_DETECTED
X-KSE-AntiSpam-Method: none
X-KSE-AntiSpam-Rate: 0
X-KSE-AntiSpam-Info: Lua profiles 164827 [Jul 05 2021]
X-KSE-AntiSpam-Info: Version: 5.9.20.0
X-KSE-AntiSpam-Info: Envelope from: pkshih@realtek.com
X-KSE-AntiSpam-Info: LuaCore: 448 448 71fb1b37213ce9a885768d4012c46ac449c77b17
X-KSE-AntiSpam-Info: {Tracking_from_exist}
X-KSE-AntiSpam-Info: {Tracking_uf_ne_domains}
X-KSE-AntiSpam-Info: {Tracking_from_domain_doesnt_match_to}
X-KSE-AntiSpam-Info: d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;127.0.0.199:7.1.2;realtek.com:7.1.1
X-KSE-AntiSpam-Info: Rate: 0
X-KSE-AntiSpam-Info: Status: not_detected
X-KSE-AntiSpam-Info: Method: none
X-KSE-AntiSpam-Info: Auth:dkim=none
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Heuristic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 07/05/2021 01:27:00
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


> -----Original Message-----
> From: Doug Brewer [mailto:brewerdoug@gmail.com]
> Sent: Sunday, July 04, 2021 10:35 PM
> To: linux-wireless@vger.kernel.org
> Subject: rtw89: product id 0xa85a support on Linux?
> 
> Hello,
> 
> The HP Laptop 15s-eq2028ur have a Realtek 802.11ax device. lspci -n shows
> 
> 01:00.0 Network controller [0280]: Realtek Semiconductor Co., Ltd. Device [10ec:
> a85a]
> 
> I tried pkshih's rtw89 patchsets [1] and added PID to rtw89_pci_id_table.
> Scanning works but cannot connect to access points.
> dmesg shows like (hiding MAC address):
> 
> rtw89_pci 0000:01:00.0: Firmware version 0.13.8.0, cmd version 0, type 1
> rtw89_pci 0000:01:00.0: Firmware version 0.13.8.0, cmd version 0, type 3
> rtw89_pci 0000:01:00.0: chip rfe_type is 1
> wlan0: authenticate with xx:xx:xx:xx:xx:xx
> wlan0: send auth to xx:xx:xx:xx:xx:xx (try 1/3)
> wlan0: authenticated
> wlan0: associate with xx:xx:xx:xx:xx:xx (try 1/3)
> wlan0: RX AssocResp from xx:xx:xx:xx:xx:xx (capab=0x411 status=0 aid=1)
> wlan0: associated
> rtw89_pci 0000:01:00.0: c2h reg timeout
> rtw89_pci 0000:01:00.0: FW does not process h2c registers
> rtw89_pci 0000:01:00.0: timed out to flush queues
> 
> rtw89 will be the driver to support this wifi model? Thanks.
> 

The ID 0xa85a is a variant of 8852AE, and rtw89 will support it later.
I'll provide you a patch when I have a draft implementation.

--
Ping-Ke

