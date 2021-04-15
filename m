Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADA5C3600CA
	for <lists+linux-wireless@lfdr.de>; Thu, 15 Apr 2021 06:06:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229881AbhDOEGW convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 15 Apr 2021 00:06:22 -0400
Received: from rtits2.realtek.com ([211.75.126.72]:32796 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229838AbhDOEGU (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 15 Apr 2021 00:06:20 -0400
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 13F45oPzA028585, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36502.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.71/5.88) with ESMTPS id 13F45oPzA028585
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 15 Apr 2021 12:05:50 +0800
Received: from RTEXMBS05.realtek.com.tw (172.21.6.98) by
 RTEXH36502.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Thu, 15 Apr 2021 12:05:48 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS05.realtek.com.tw (172.21.6.98) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Thu, 15 Apr 2021 12:05:47 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::1d8:ba7d:61ca:bd74]) by
 RTEXMBS04.realtek.com.tw ([fe80::1d8:ba7d:61ca:bd74%5]) with mapi id
 15.01.2106.013; Thu, 15 Apr 2021 12:05:47 +0800
From:   Pkshih <pkshih@realtek.com>
To:     Kalle Valo <kvalo@codeaurora.org>
CC:     "tony0620emma@gmail.com" <tony0620emma@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        DeanKu <ku920601@realtek.com>,
        Bernie Huang <phhuang@realtek.com>,
        Shaofu <shaofu@realtek.com>,
        Steven Ting <steventing@realtek.com>,
        Kevin Yang <kevin_yang@realtek.com>
Subject: RE: [PATCH 2/7] rtw88: follow the AP basic rates for tx mgmt frame
Thread-Topic: [PATCH 2/7] rtw88: follow the AP basic rates for tx mgmt frame
Thread-Index: AQHXHILhha+rxT9tC0u1Umog2SASfaquqNkAgAF+yYCAAMJ9gIAENaow
Date:   Thu, 15 Apr 2021 04:05:47 +0000
Message-ID: <bd370e998b324aa18dd479e550841b99@realtek.com>
References: <20210319054218.3319-3-pkshih@realtek.com>
        <20210411092102.40EE7C43461@smtp.codeaurora.org>
        <632d2ab7679145eab8e1f498b9b12ceb@realtek.com>
 <87r1jflo7p.fsf@codeaurora.org>
In-Reply-To: <87r1jflo7p.fsf@codeaurora.org>
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
> Sent: Monday, April 12, 2021 7:47 PM
> To: Pkshih
> Cc: tony0620emma@gmail.com; linux-wireless@vger.kernel.org; DeanKu; Bernie Huang; Shaofu; Steven Ting;
> Kevin Yang
> Subject: Re: [PATCH 2/7] rtw88: follow the AP basic rates for tx mgmt frame
> 
> Pkshih <pkshih@realtek.com> writes:
> 
> >> -----Original Message-----
> >> From: kvalo=codeaurora.org@mg.codeaurora.org
> >> [mailto:kvalo=codeaurora.org@mg.codeaurora.org] On
> >> Behalf Of Kalle Valo
> >> Sent: Sunday, April 11, 2021 5:21 PM
> >> To: Pkshih
> >> Cc: tony0620emma@gmail.com; linux-wireless@vger.kernel.org; DeanKu;
> >> Bernie Huang; Shaofu; Steven Ting;
> >> Kevin Yang
> >> Subject: Re: [PATCH 2/7] rtw88: follow the AP basic rates for tx mgmt frame
> >>
> >> Ping-Ke Shih <pkshih@realtek.com> wrote:
> >>
> >> > From: Shao-Fu Cheng <shaofu@realtek.com>
> >> >
> >> > By default the driver uses the 1M and 6M rate for managemnt frames
> >> > in 2G and 5G bands respectively. But when the basic rates is configured
> >> > from the mac80211, we need to send the management frames according the
> >> > basic rates.
> >> >
> >> > This commit makes the driver use the lowest basic rates to send
> >> > the management frames and a debufs entry to enable/disable force to use
> >> > the lowest rate 1M/6M for 2.4G/5G bands.
> >> >
> >> > obtain current setting
> >> > cat /sys/kernel/debug/ieee80211/phyX/rtw88/basic_rates
> >> >
> >> > force lowest rate:
> >> > echo 1 > /sys/kernel/debug/ieee80211/phyX/rtw88/basic_rates
> >> >
> >> > Signed-off-by: Shao-Fu Cheng <shaofu@realtek.com>
> >> > Signed-off-by: Yu-Yen Ting <steventing@realtek.com>
> >> > Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
> >>
> >> Why is a debugfs interface needed?
> >>
> >
> > By default, driver follows AP's basic rates that may be 24M and above, and
> > does association with 24M rate. If AP is far away, it may be hard to communicate
> > with 24M rate. Therefore, we add a debugfs to allow driver to send management
> > frames with low rate 6M or 1M.
> 
> debugfs is for R&D level testing and debugging, not normal user
> configuration. To me it looks like something like that should be in
> nl80211.
> 

I do not expect that the users could configure the basic rate for station by
the normal way such as nl80211. This debugfs is for debugging purpose,
not for normal user.

--
Ping-Ke

