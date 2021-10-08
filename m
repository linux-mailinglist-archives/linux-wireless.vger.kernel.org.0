Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47EDB42638D
	for <lists+linux-wireless@lfdr.de>; Fri,  8 Oct 2021 06:11:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230013AbhJHENE convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 8 Oct 2021 00:13:04 -0400
Received: from rtits2.realtek.com ([211.75.126.72]:44359 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbhJHEND (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 8 Oct 2021 00:13:03 -0400
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 1984B5lpC009228, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36503.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.71/5.88) with ESMTPS id 1984B5lpC009228
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 8 Oct 2021 12:11:05 +0800
Received: from RTEXMBS03.realtek.com.tw (172.21.6.96) by
 RTEXH36503.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Fri, 8 Oct 2021 12:11:04 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS03.realtek.com.tw (172.21.6.96) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Fri, 8 Oct 2021 12:11:03 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::cdd5:82a3:e854:7098]) by
 RTEXMBS04.realtek.com.tw ([fe80::cdd5:82a3:e854:7098%5]) with mapi id
 15.01.2106.013; Fri, 8 Oct 2021 12:11:03 +0800
From:   Pkshih <pkshih@realtek.com>
To:     Kalle Valo <kvalo@codeaurora.org>
CC:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: [PATCH v6 00/24] rtw89: add Realtek 802.11ax driver
Thread-Topic: [PATCH v6 00/24] rtw89: add Realtek 802.11ax driver
Thread-Index: AQHXlXz6iS5M0zbbfkSyaj358Nztiqu+mXDngAQPmeCAAYZwOYAEmYxw
Date:   Fri, 8 Oct 2021 04:11:03 +0000
Message-ID: <b59b709da12e4c938745eddd73efeec7@realtek.com>
References: <20210820043538.12424-1-pkshih@realtek.com>
        <8735pkiu0t.fsf@codeaurora.org>
        <9b54e3c321a4414cbae62616d8a913f4@realtek.com>
 <877desggrm.fsf@codeaurora.org>
In-Reply-To: <877desggrm.fsf@codeaurora.org>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.21.69.188]
x-kse-serverinfo: RTEXMBS03.realtek.com.tw, 9
x-kse-attachmentfiltering-interceptor-info: no applicable attachment filtering
 rules found
x-kse-antivirus-interceptor-info: scan successful
x-kse-antivirus-info: =?us-ascii?Q?Clean,_bases:_2021/10/8_=3F=3F_02:36:00?=
x-kse-bulkmessagesfiltering-scan-result: protection disabled
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-KSE-ServerInfo: RTEXH36503.realtek.com.tw, 9
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-KSE-AntiSpam-Outbound-Interceptor-Info: scan successful
X-KSE-AntiSpam-Version: 5.9.20, Database issued on: 10/08/2021 03:53:37
X-KSE-AntiSpam-Status: KAS_STATUS_NOT_DETECTED
X-KSE-AntiSpam-Method: none
X-KSE-AntiSpam-Rate: 0
X-KSE-AntiSpam-Info: Lua profiles 166592 [Oct 07 2021]
X-KSE-AntiSpam-Info: Version: 5.9.20.0
X-KSE-AntiSpam-Info: Envelope from: pkshih@realtek.com
X-KSE-AntiSpam-Info: LuaCore: 463 463 5854868460de3f0d8e8c0a4df98aeb05fb764a09
X-KSE-AntiSpam-Info: {Tracking_from_domain_doesnt_match_to}
X-KSE-AntiSpam-Info: realtek.com:7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;127.0.0.199:7.1.2
X-KSE-AntiSpam-Info: Rate: 0
X-KSE-AntiSpam-Info: Status: not_detected
X-KSE-AntiSpam-Info: Method: none
X-KSE-AntiSpam-Info: Auth:dkim=none
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Heuristic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 10/08/2021 03:56:00
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


> -----Original Message-----
> From: kvalo=codeaurora.org@mg.codeaurora.org <kvalo=codeaurora.org@mg.codeaurora.org> On
> Behalf Of Kalle Valo
> Sent: Tuesday, October 5, 2021 1:52 PM
> To: Pkshih <pkshih@realtek.com>
> Cc: linux-wireless@vger.kernel.org
> Subject: Re: [PATCH v6 00/24] rtw89: add Realtek 802.11ax driver
> 
> Pkshih <pkshih@realtek.com> writes:
> 
> >> The community has been testing this driver already, right?
> >
> > As Larry mentioned, end users use this driver. Since bugs found in v6,
> > we have fixed them and driver is under QA. I plan to have that fixes in v7
> > released this week.
> >
> > This version will also include fixes of your comments.
> > Does it work to you?
> 
> Sounds good to me. I hope the changes in v7 will be small in size,
> bigger changes (especially new features) is better to do after the
> driver is applied to wireless-drivers-next.
> 

I have fixed this driver according to all of your comments, so I
don't reply the comments one by one. If this doesn't work to you,
please let me know.

--
Ping-Ke

