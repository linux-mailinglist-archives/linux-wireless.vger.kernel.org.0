Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55A2B3ECC22
	for <lists+linux-wireless@lfdr.de>; Mon, 16 Aug 2021 02:45:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231719AbhHPAqV convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 15 Aug 2021 20:46:21 -0400
Received: from rtits2.realtek.com ([211.75.126.72]:46212 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230124AbhHPAqU (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 15 Aug 2021 20:46:20 -0400
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 17G0jeVH3019827, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36502.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.71/5.88) with ESMTPS id 17G0jeVH3019827
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 16 Aug 2021 08:45:40 +0800
Received: from RTEXMBS05.realtek.com.tw (172.21.6.98) by
 RTEXH36502.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Mon, 16 Aug 2021 08:45:39 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS05.realtek.com.tw (172.21.6.98) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Mon, 16 Aug 2021 08:45:38 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::cdd5:82a3:e854:7098]) by
 RTEXMBS04.realtek.com.tw ([fe80::cdd5:82a3:e854:7098%5]) with mapi id
 15.01.2106.013; Mon, 16 Aug 2021 08:45:38 +0800
From:   Pkshih <pkshih@realtek.com>
To:     Pkshih <pkshih@realtek.com>, Jan Reusch <jan@jreusch.de>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: Difficulty connecting to AP using rtw89
Thread-Topic: Difficulty connecting to AP using rtw89
Thread-Index: AQHXedzEvSHwSXSC2EGxNTyUmGxj/atE4CcwgABoiACAARvNsIAAARaAgAM0tpCAHOxcgIAER3XAgAqsXPA=
Date:   Mon, 16 Aug 2021 00:45:38 +0000
Message-ID: <5996f62cd8594a4d98490a8ad76a61a7@realtek.com>
References: <2551f3d4aff248e29118a2c6339e4d96@realtek.com>
 <YQ2ZHTCCzbXil+9Y@akk.org> <3b903f001e13429d81cb12d78b396ce5@realtek.com>
In-Reply-To: <3b903f001e13429d81cb12d78b396ce5@realtek.com>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.21.69.146]
x-kse-serverinfo: RTEXMBS05.realtek.com.tw, 9
x-kse-attachmentfiltering-interceptor-info: no applicable attachment filtering
 rules found
x-kse-antivirus-interceptor-info: scan successful
x-kse-antivirus-info: =?us-ascii?Q?Clean,_bases:_2021/8/15_=3F=3F_03:30:00?=
x-kse-bulkmessagesfiltering-scan-result: protection disabled
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-KSE-ServerInfo: RTEXH36502.realtek.com.tw, 9
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-KSE-AntiSpam-Outbound-Interceptor-Info: scan successful
X-KSE-AntiSpam-Version: 5.9.20, Database issued on: 08/16/2021 00:33:18
X-KSE-AntiSpam-Status: KAS_STATUS_NOT_DETECTED
X-KSE-AntiSpam-Method: none
X-KSE-AntiSpam-Rate: 30
X-KSE-AntiSpam-Info: Lua profiles 165565 [Aug 16 2021]
X-KSE-AntiSpam-Info: Version: 5.9.20.0
X-KSE-AntiSpam-Info: Envelope from: pkshih@realtek.com
X-KSE-AntiSpam-Info: LuaCore: 454 454 39c6e442fd417993330528e7f9d13ac1bf7fdf8c
X-KSE-AntiSpam-Info: {Prob_susp_to_in_reply, in_rep}
X-KSE-AntiSpam-Info: {Tracking_uf_ne_domains}
X-KSE-AntiSpam-Info: d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;realtek.com:7.1.1;github.com:7.1.1;127.0.0.199:7.1.2
X-KSE-AntiSpam-Info: Rate: 30
X-KSE-AntiSpam-Info: Status: not_detected
X-KSE-AntiSpam-Info: Method: none
X-KSE-AntiSpam-Info: Auth:dkim=none
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Heuristic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 08/16/2021 00:35:00
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


> -----Original Message-----
> From: Pkshih [mailto:pkshih@realtek.com]
> Sent: Monday, August 09, 2021 1:52 PM
> To: Jan Reusch; linux-wireless@vger.kernel.org
> Subject: RE: Difficulty connecting to AP using rtw89
> 
> > -----Original Message-----
> > From: Jan Reusch [mailto:jan@jreusch.de]
> > Sent: Saturday, August 07, 2021 4:19 AM
> > To: linux-wireless@vger.kernel.org; Pkshih
> > Subject: RE: Difficulty connecting to AP using rtw89
> >
> > Hey hey
> > Hope this works and gets sorted right, i had to manually set the
> > in-reply-to header.
> >
> > I'm one of the people having problems with ipv6 and the rtw89 driver.
> > i've tested it with the debian bullseye kernel and vanilla 5.13 from
> > kernel.org
> >
> > It's about a Realtek 8852 in a Thinkpad E14 Gen2 (amd).
> >
> > > > The driver handles L2 things only, but IPv6 that is L3 that we don't
> > > > have special deal.
> > > > Could I know the problem you met?
> >
> > Yep that was also my first reaction 1:1, but it's 100% repdoducible.
> > Ethernet connection works, i get an v4 adress and an v6 one (SLAAC), it
> > works flawlessly with an USB wifi stick, but the integrated wifi only
> > gets the link local ipv6 address,  an ipv4 one but nothing more.
> > I've tried to dump router advertisements, but none of them pop up. (As
> > soon as i attach the ethernet cable/usb wifi stick they're there...)
> 
> Could you provide your dump of USB wifi stick and rtw89?
> If possible, I'd like to have tcpdump of interfaces locally and sniffer
> packets in the air. Then, I can check the good and bad cases, and check
> if any transmitting data is eaten by rtw89.
> 

With Jan's help, we get this fixed.
This fix will be included in next submission recently. If people want this
fix right now, please checkout Larry's GitHub https://github.com/lwfinger/rtw89

Ping-Ke

