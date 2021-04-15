Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD1FB360146
	for <lists+linux-wireless@lfdr.de>; Thu, 15 Apr 2021 07:02:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229560AbhDOFCo convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 15 Apr 2021 01:02:44 -0400
Received: from rtits2.realtek.com ([211.75.126.72]:35125 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbhDOFCl (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 15 Apr 2021 01:02:41 -0400
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 13F52Db14003421, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36502.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.71/5.88) with ESMTPS id 13F52Db14003421
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 15 Apr 2021 13:02:13 +0800
Received: from RTEXMBS05.realtek.com.tw (172.21.6.98) by
 RTEXH36502.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Thu, 15 Apr 2021 13:02:13 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS05.realtek.com.tw (172.21.6.98) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Thu, 15 Apr 2021 13:02:12 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::1d8:ba7d:61ca:bd74]) by
 RTEXMBS04.realtek.com.tw ([fe80::1d8:ba7d:61ca:bd74%5]) with mapi id
 15.01.2106.013; Thu, 15 Apr 2021 13:02:12 +0800
From:   Pkshih <pkshih@realtek.com>
To:     Kalle Valo <kvalo@codeaurora.org>
CC:     "tony0620emma@gmail.com" <tony0620emma@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        DeanKu <ku920601@realtek.com>,
        Bernie Huang <phhuang@realtek.com>,
        Shaofu <shaofu@realtek.com>,
        Steven Ting <steventing@realtek.com>,
        Kevin Yang <kevin_yang@realtek.com>
Subject: RE: [PATCH 6/7] rtw88: 8822c: add CFO tracking
Thread-Topic: [PATCH 6/7] rtw88: 8822c: add CFO tracking
Thread-Index: AQHXHILi0rb6HTLCKkSAH1awbttUrqquqISAgAF/I4CAAMLRsIAERSFg
Date:   Thu, 15 Apr 2021 05:02:12 +0000
Message-ID: <49d0f6a9ac4441b7bad71467ce502d01@realtek.com>
References: <20210319054218.3319-7-pkshih@realtek.com>
        <20210411091951.2B01AC433CA@smtp.codeaurora.org>
        <6ea1eb17f2a64fd0954b9d4060da12f0@realtek.com>
 <87mtu3lo62.fsf@codeaurora.org>
In-Reply-To: <87mtu3lo62.fsf@codeaurora.org>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.21.69.146]
x-kse-serverinfo: RTEXMBS05.realtek.com.tw, 9
x-kse-antivirus-interceptor-info: scan successful
x-kse-antivirus-info: =?us-ascii?Q?Clean,_bases:_2021/4/14_=3F=3F_10:00:00?=
x-kse-attachment-filter-triggered-rules: Clean
x-kse-attachment-filter-triggered-filters: Clean
x-kse-bulkmessagesfiltering-scan-result: protection disabled
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-KSE-AntiSpam-Outbound-Interceptor-Info: scan successful
X-KSE-AntiSpam-Version: 5.9.20, Database issued on: 04/15/2021 00:46:16
X-KSE-AntiSpam-Status: KAS_STATUS_NOT_DETECTED
X-KSE-AntiSpam-Method: none
X-KSE-AntiSpam-Rate: 0
X-KSE-AntiSpam-Info: Lua profiles 163123 [Apr 14 2021]
X-KSE-AntiSpam-Info: Version: 5.9.20.0
X-KSE-AntiSpam-Info: Envelope from: pkshih@realtek.com
X-KSE-AntiSpam-Info: LuaCore: 442 442 b985cb57763b61d2a20abb585d5d4cc10c315b09
X-KSE-AntiSpam-Info: {Tracking_uf_ne_domains}
X-KSE-AntiSpam-Info: {Tracking_from_domain_doesnt_match_to}
X-KSE-AntiSpam-Info: Rate: 0
X-KSE-AntiSpam-Info: Status: not_detected
X-KSE-AntiSpam-Info: Method: none
X-KSE-AntiSpam-Info: Auth:dkim=none
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Heuristic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 04/15/2021 00:48:00
X-KSE-ServerInfo: RTEXH36502.realtek.com.tw, 9
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-KSE-AntiSpam-Outbound-Interceptor-Info: scan successful
X-KSE-AntiSpam-Version: 5.9.20, Database issued on: 04/15/2021 00:46:16
X-KSE-AntiSpam-Status: KAS_STATUS_NOT_DETECTED
X-KSE-AntiSpam-Method: none
X-KSE-AntiSpam-Rate: 0
X-KSE-AntiSpam-Info: Lua profiles 163123 [Apr 14 2021]
X-KSE-AntiSpam-Info: Version: 5.9.20.0
X-KSE-AntiSpam-Info: Envelope from: pkshih@realtek.com
X-KSE-AntiSpam-Info: LuaCore: 442 442 b985cb57763b61d2a20abb585d5d4cc10c315b09
X-KSE-AntiSpam-Info: {Tracking_uf_ne_domains}
X-KSE-AntiSpam-Info: {Tracking_from_domain_doesnt_match_to}
X-KSE-AntiSpam-Info: Rate: 0
X-KSE-AntiSpam-Info: Status: not_detected
X-KSE-AntiSpam-Info: Method: none
X-KSE-AntiSpam-Info: Auth:dkim=none
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Heuristic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 04/15/2021 00:48:00
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


> -----Original Message-----
> From: kvalo=codeaurora.org@mg.codeaurora.org [mailto:kvalo=codeaurora.org@mg.codeaurora.org] On
> Behalf Of Kalle Valo
> Sent: Monday, April 12, 2021 7:48 PM
> To: Pkshih
> Cc: tony0620emma@gmail.com; linux-wireless@vger.kernel.org; DeanKu; Bernie Huang; Shaofu; Steven Ting;
> Kevin Yang
> Subject: Re: [PATCH 6/7] rtw88: 8822c: add CFO tracking
> 
> Pkshih <pkshih@realtek.com> writes:
> 
> >> -----Original Message-----
> >> From: kvalo=codeaurora.org@mg.codeaurora.org
> >> [mailto:kvalo=codeaurora.org@mg.codeaurora.org] On
> >> Behalf Of Kalle Valo
> >> Sent: Sunday, April 11, 2021 5:20 PM
> >> To: Pkshih
> >> Cc: tony0620emma@gmail.com; linux-wireless@vger.kernel.org; DeanKu;
> >> Bernie Huang; Shaofu; Steven Ting;
> >> Kevin Yang
> >> Subject: Re: [PATCH 6/7] rtw88: 8822c: add CFO tracking
> >>
> >> Ping-Ke Shih <pkshih@realtek.com> wrote:
> >>
> >> > From: Po-Hao Huang <phhuang@realtek.com>
> >> >
> >> > Add CFO tracking mechanism to mitigate the effect of oscillator
> >> > frequency discrepancy.
> >> >
> >> > Signed-off-by: Po-Hao Huang <phhuang@realtek.com>
> >> > Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
> >>
> >> What's CFO? I need to understand the commit log, so please write it so that any
> >> engineer working with wireless understands it.
> >>
> >
> > CFO tracking, which stands for central frequency offset tracking, is used to
> > adjust oscillator to align central frequency of connected AP. Then, we can
> > have better performance.
> >
> > Should I resend this patch to explain CFO?
> 
> Yes, please send a new version with an updated commit log.
> 

A single patch is sent:

https://lore.kernel.org/linux-wireless/20210415045913.16097-1-pkshih@realtek.com/T/#u

--
Ping-Ke


