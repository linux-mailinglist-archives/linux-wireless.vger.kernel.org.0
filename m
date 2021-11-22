Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E71CC458767
	for <lists+linux-wireless@lfdr.de>; Mon, 22 Nov 2021 01:23:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231676AbhKVA0P convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 21 Nov 2021 19:26:15 -0500
Received: from rtits2.realtek.com ([211.75.126.72]:56193 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229884AbhKVA0P (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 21 Nov 2021 19:26:15 -0500
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 1AM0MmdwE030630, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36503.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.71/5.88) with ESMTPS id 1AM0MmdwE030630
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 22 Nov 2021 08:22:48 +0800
Received: from RTEXMBS06.realtek.com.tw (172.21.6.99) by
 RTEXH36503.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.15; Mon, 22 Nov 2021 08:22:48 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS06.realtek.com.tw (172.21.6.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Mon, 22 Nov 2021 08:22:47 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::dc53:1026:298b:c584]) by
 RTEXMBS04.realtek.com.tw ([fe80::dc53:1026:298b:c584%5]) with mapi id
 15.01.2308.015; Mon, 22 Nov 2021 08:22:47 +0800
From:   Pkshih <pkshih@realtek.com>
To:     Takashi Iwai <tiwai@suse.de>, Kalle Valo <kvalo@codeaurora.org>
CC:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "Larry.Finger@lwfinger.net" <Larry.Finger@lwfinger.net>
Subject: RE: [PATCH v3 0/3] rtw89: fix crash when loading firmware file on certain platforms
Thread-Topic: [PATCH v3 0/3] rtw89: fix crash when loading firmware file on
 certain platforms
Thread-Index: AQHX3Qi9VlLpDo0hUk+a9uqnP2yaTawKwZli//+YzQCABFlhQA==
Date:   Mon, 22 Nov 2021 00:22:47 +0000
Message-ID: <3f7bced126cb496bb759d495d024d74d@realtek.com>
References: <20211119054512.10620-1-pkshih@realtek.com>
        <87ee7cwdsr.fsf@tynnyri.adurom.net> <s5h7dd4fdup.wl-tiwai@suse.de>
In-Reply-To: <s5h7dd4fdup.wl-tiwai@suse.de>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.21.69.188]
x-kse-serverinfo: RTEXMBS06.realtek.com.tw, 9
x-kse-attachmentfiltering-interceptor-info: no applicable attachment filtering
 rules found
x-kse-antivirus-interceptor-info: scan successful
x-kse-antivirus-info: =?us-ascii?Q?Clean,_bases:_2021/11/21_=3F=3F_10:15:00?=
x-kse-bulkmessagesfiltering-scan-result: protection disabled
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-KSE-ServerInfo: RTEXH36503.realtek.com.tw, 9
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-KSE-AntiSpam-Outbound-Interceptor-Info: scan successful
X-KSE-AntiSpam-Version: 5.9.20, Database issued on: 11/21/2021 23:59:12
X-KSE-AntiSpam-Status: KAS_STATUS_NOT_DETECTED
X-KSE-AntiSpam-Method: none
X-KSE-AntiSpam-Rate: 0
X-KSE-AntiSpam-Info: Lua profiles 167391 [Nov 21 2021]
X-KSE-AntiSpam-Info: Version: 5.9.20.0
X-KSE-AntiSpam-Info: Envelope from: pkshih@realtek.com
X-KSE-AntiSpam-Info: LuaCore: 465 465 eb31509370142567679dd183ac984a0cb2ee3296
X-KSE-AntiSpam-Info: {Tracking_from_domain_doesnt_match_to}
X-KSE-AntiSpam-Info: d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;realtek.com:7.1.1;127.0.0.199:7.1.2
X-KSE-AntiSpam-Info: Rate: 0
X-KSE-AntiSpam-Info: Status: not_detected
X-KSE-AntiSpam-Info: Method: none
X-KSE-AntiSpam-Info: Auth:dkim=none
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Heuristic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 11/22/2021 00:02:00
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


> -----Original Message-----
> From: Takashi Iwai <tiwai@suse.de>
> Sent: Friday, November 19, 2021 9:57 PM
> To: Kalle Valo <kvalo@codeaurora.org>
> Cc: Pkshih <pkshih@realtek.com>; linux-wireless@vger.kernel.org; tiwai@suse.de;
> Larry.Finger@lwfinger.net
> Subject: Re: [PATCH v3 0/3] rtw89: fix crash when loading firmware file on certain platforms
> 
> On Fri, 19 Nov 2021 13:05:56 +0100,
> Kalle Valo wrote:
> >
> > Ping-Ke Shih <pkshih@realtek.com> writes:
> >
> > > First patch is to avoid writing "partition size" on read-only firmware
> > > buffer, so it has to fix the crash.
> > > The later two patches are used to make the semantics clear, but they don't
> > > change the logic at all.
> > >
> > > I hope at least first patch can be taken into 5.16-rc, so people can avoid
> > > this crash.
> >
> > My plan is to take patch 1 to wireless-drivers. And, after patch 1
> > trickles down to wireless-drivers-next, patch 2-3 to
> > wireless-drivers-next. Sounds good to everyone?
> 
> Yes, sounds like a good plan.
> 

I also agree with your plan.

--
Ping-Ke

