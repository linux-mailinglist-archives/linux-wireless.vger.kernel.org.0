Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 930174425A6
	for <lists+linux-wireless@lfdr.de>; Tue,  2 Nov 2021 03:29:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229612AbhKBCbw convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 1 Nov 2021 22:31:52 -0400
Received: from rtits2.realtek.com ([211.75.126.72]:49590 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbhKBCbv (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 1 Nov 2021 22:31:51 -0400
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 1A22TAk04032299, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36503.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.71/5.88) with ESMTPS id 1A22TAk04032299
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 2 Nov 2021 10:29:10 +0800
Received: from RTEXMBS06.realtek.com.tw (172.21.6.99) by
 RTEXH36503.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.15; Tue, 2 Nov 2021 10:29:07 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS06.realtek.com.tw (172.21.6.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.15; Tue, 2 Nov 2021 10:29:07 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::dc53:1026:298b:c584]) by
 RTEXMBS04.realtek.com.tw ([fe80::dc53:1026:298b:c584%5]) with mapi id
 15.01.2308.015; Tue, 2 Nov 2021 10:29:07 +0800
From:   Pkshih <pkshih@realtek.com>
To:     Kalle Valo <kvalo@codeaurora.org>,
        Brian Norris <briannorris@chromium.org>
CC:     "tony0620emma@gmail.com" <tony0620emma@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "steventing@realtek.com" <steventing@realtek.com>
Subject: RE: [PATCH v2 2/2] rtw88: add debugfs to force lowest basic rate
Thread-Topic: [PATCH v2 2/2] rtw88: add debugfs to force lowest basic rate
Thread-Index: AQHXNyRAk4gBeAyeS0qjcLM9a2bOoqsPNd6AgOB7deSAAQLDgA==
Date:   Tue, 2 Nov 2021 02:29:06 +0000
Message-ID: <655e0265105d43488ce19b471fe2fc22@realtek.com>
References: <20210422030413.9738-1-pkshih@realtek.com>
        <20210422030413.9738-2-pkshih@realtek.com>      <YMPqT8VH5alHQXXA@google.com>
 <87k0hs2l9i.fsf@codeaurora.org>
In-Reply-To: <87k0hs2l9i.fsf@codeaurora.org>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.21.69.188]
x-kse-serverinfo: RTEXMBS06.realtek.com.tw, 9
x-kse-attachmentfiltering-interceptor-info: no applicable attachment filtering
 rules found
x-kse-antivirus-interceptor-info: scan successful
x-kse-antivirus-info: =?us-ascii?Q?Clean,_bases:_2021/11/2_=3F=3F_12:42:00?=
x-kse-bulkmessagesfiltering-scan-result: protection disabled
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-KSE-ServerInfo: RTEXH36503.realtek.com.tw, 9
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-KSE-AntiSpam-Outbound-Interceptor-Info: scan successful
X-KSE-AntiSpam-Version: 5.9.20, Database issued on: 11/02/2021 02:06:56
X-KSE-AntiSpam-Status: KAS_STATUS_NOT_DETECTED
X-KSE-AntiSpam-Method: none
X-KSE-AntiSpam-Rate: 0
X-KSE-AntiSpam-Info: Lua profiles 167045 [Nov 01 2021]
X-KSE-AntiSpam-Info: Version: 5.9.20.0
X-KSE-AntiSpam-Info: Envelope from: pkshih@realtek.com
X-KSE-AntiSpam-Info: LuaCore: 465 465 eb31509370142567679dd183ac984a0cb2ee3296
X-KSE-AntiSpam-Info: {Tracking_uf_ne_domains}
X-KSE-AntiSpam-Info: {Tracking_from_domain_doesnt_match_to}
X-KSE-AntiSpam-Info: realtek.com:7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;127.0.0.199:7.1.2;patchwork.kernel.org:7.1.1;lore.kernel.org:7.1.1
X-KSE-AntiSpam-Info: Rate: 0
X-KSE-AntiSpam-Info: Status: not_detected
X-KSE-AntiSpam-Info: Method: none
X-KSE-AntiSpam-Info: Auth:dkim=none
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Heuristic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 11/02/2021 02:10:00
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


> -----Original Message-----
> From: kvalo=codeaurora.org@mg.codeaurora.org <kvalo=codeaurora.org@mg.codeaurora.org> On Behalf Of Kalle
> Valo
> Sent: Monday, November 1, 2021 7:01 PM
> To: Brian Norris <briannorris@chromium.org>
> Cc: Pkshih <pkshih@realtek.com>; tony0620emma@gmail.com; linux-wireless@vger.kernel.org;
> steventing@realtek.com
> Subject: Re: [PATCH v2 2/2] rtw88: add debugfs to force lowest basic rate
> 
> (replying to an old thread:
> 
> https://patchwork.kernel.org/project/linux-wireless/patch/20210422030413.9738-2-pkshih@realtek.com/ )
> 
> 
> Brian Norris <briannorris@chromium.org> writes:
> 
> > On Thu, Apr 22, 2021 at 11:04:13AM +0800, Ping-Ke Shih wrote:
> >> From: Yu-Yen Ting <steventing@realtek.com>
> >>
> >> The management frame with high rate e.g. 24M may not be transmitted
> >> smoothly in long range environment.
> >> Add a debugfs to force to use the lowest basic rate
> >> in order to debug the reachability of transmitting management frame.
> >>
> >> obtain current setting
> >> cat /sys/kernel/debug/ieee80211/phyX/rtw88/basic_rates
> >>
> >> force lowest rate:
> >> echo 1 > /sys/kernel/debug/ieee80211/phyX/rtw88/basic_rates
> >>
> >> Signed-off-by: Yu-Yen Ting <steventing@realtek.com>
> >> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
> >
> > I believe some initial objection to this was because it was unclear if
> > this is for "production" use (e.g., recommending distros to play with
> > this) or for debugging. I'll admit, I requested the feature for patch 1,
> > because I've seen that for those networks where people *do* configure
> > odd Basic Rates, they intend for stations to follow those, and not use
> > the lowest (and most airtime-hogging) rates.
> >
> > And I can say, I don't see why distributions should be turning that back
> > off. If the Basic Rates setting is wrong, then the that's up to the
> > network admin to fix.
> >
> > All that is to say: I agree that this patch is purely for debugging, as
> > stated, and that it belongs in debugfs. I also maintain a distribution,
> > and I don't plan on using this beyond debugging.
> >
> > Therefore:
> >
> > Reviewed-by: Brian Norris <briannorris@chromium.org>
> 
> Ok, fair enough as long as this will not end up normal users using it. I
> still would prefer to have extensive bitrate handling via nl80211 but
> clearly it's not going anywhere.
> 
> But could the debugfs filename be more descriptive, for example
> force_basic_rates or something like that?
> 

OK. Use 'force_lowest_basic_rate' by v3 [1].

[1] https://lore.kernel.org/linux-wireless/20211102022454.10944-1-pkshih@realtek.com/T/#t

--
Ping-Ke

