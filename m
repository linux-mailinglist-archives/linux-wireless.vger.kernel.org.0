Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A0E94E397B
	for <lists+linux-wireless@lfdr.de>; Tue, 22 Mar 2022 08:19:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237345AbiCVHTW convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 22 Mar 2022 03:19:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237356AbiCVHTW (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 22 Mar 2022 03:19:22 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B1AB63BEB
        for <linux-wireless@vger.kernel.org>; Tue, 22 Mar 2022 00:17:52 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 22M7Hjc66001813, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36504.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.71/5.88) with ESMTPS id 22M7Hjc66001813
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 22 Mar 2022 15:17:45 +0800
Received: from RTEXMBS05.realtek.com.tw (172.21.6.98) by
 RTEXH36504.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Tue, 22 Mar 2022 15:17:44 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS05.realtek.com.tw (172.21.6.98) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Tue, 22 Mar 2022 00:17:44 -0700
Received: from RTEXMBS04.realtek.com.tw ([fe80::41d7:1d2e:78a6:ff34]) by
 RTEXMBS04.realtek.com.tw ([fe80::41d7:1d2e:78a6:ff34%5]) with mapi id
 15.01.2308.021; Tue, 22 Mar 2022 15:17:44 +0800
From:   Pkshih <pkshih@realtek.com>
To:     Stefan K <shadow_7@gmx.net>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: rtw89: unstable connection
Thread-Topic: rtw89: unstable connection
Thread-Index: AQHYPRok8gD20x9bsU6oG/M1WzUcY6zK7kDA
Date:   Tue, 22 Mar 2022 07:17:44 +0000
Message-ID: <c9ff4269e3864ee4bd437a40678a9e5f@realtek.com>
References: <2127068.tFZMq15b3B@t460-skr>
In-Reply-To: <2127068.tFZMq15b3B@t460-skr>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.21.69.188]
x-kse-serverinfo: RTEXMBS05.realtek.com.tw, 9
x-kse-attachmentfiltering-interceptor-info: no applicable attachment filtering
 rules found
x-kse-antivirus-interceptor-info: scan successful
x-kse-antivirus-info: =?us-ascii?Q?Clean,_bases:_2022/3/22_=3F=3F_06:19:00?=
x-kse-bulkmessagesfiltering-scan-result: protection disabled
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-KSE-ServerInfo: RTEXH36504.realtek.com.tw, 9
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi 

> -----Original Message-----
> From: Stefan K <shadow_7@gmx.net>
> Sent: Monday, March 21, 2022 7:52 PM
> To: linux-wireless@vger.kernel.org
> Subject: rtw89: unstable connection
> 
> Hello,
> 
> I got an new Laptop (Lenovo T14 Gen2 AMD) and it has RTL8852AE chip, it can connect to WiFi, but its very
> slow and unstable:
> --- 8.8.8.8 ping statistics ---
> 100 packets transmitted, 60 received, 60% packet loss, time 99514ms
> rtt min/avg/max/mdev = 578.297/4515.244/10612.149/2763.037 ms, pipe 11
> 
> I'm running on Debian bullseye with backport Kernel Linux 5.16.0-0.bpo.3-amd64
> 
> I reported this on github (https://github.com/lwfinger/rtw89/issues/133) and I added the following (as
> recommended):
> cat /etc/modprobe.d/50-rtw89.conf
> options rtw89_pci disable_aspm_l1=y disable_aspm_l1ss=y
> 

In additional to above options, please also add below option:

   options rtw89_core disable_ps_mode=y

Then, do cold reboot, or shutdown/power-on would be good.

> [ 1532.499712] rtw89_pci 0000:03:00.0:  [FWBB][WARN][CMW] No specific sta connect
> [ 1532.600273] rtw89_pci 0000:03:00.0:  [FWBB][WARN][CMW] No specific sta connect
> [ 1532.700650] rtw89_pci 0000:03:00.0:  [FWBB][WARN][CMW] No specific sta connect

This log shows that you use old firmware, please copy the latest firmware
to /lib/firmware/rtw89/. After applying the firmware, kernel log will show

rtw89_8852ae 0000:03:00.0: Firmware version 0.13.36.0, cmd version 0, type 1
rtw89_8852ae 0000:03:00.0: Firmware version 0.13.36.0, cmd version 0, type 3

--
Ping-Ke

