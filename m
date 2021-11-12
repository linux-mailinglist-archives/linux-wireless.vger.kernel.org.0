Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2522D44E207
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Nov 2021 07:44:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231713AbhKLGrN convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 12 Nov 2021 01:47:13 -0500
Received: from rtits2.realtek.com ([211.75.126.72]:43257 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230259AbhKLGrM (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 12 Nov 2021 01:47:12 -0500
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 1AC6i6KY1015536, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36503.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.71/5.88) with ESMTPS id 1AC6i6KY1015536
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 12 Nov 2021 14:44:06 +0800
Received: from RTEXMBS03.realtek.com.tw (172.21.6.96) by
 RTEXH36503.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.15; Fri, 12 Nov 2021 14:44:06 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS03.realtek.com.tw (172.21.6.96) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.15; Fri, 12 Nov 2021 01:44:05 -0500
Received: from RTEXMBS04.realtek.com.tw ([fe80::dc53:1026:298b:c584]) by
 RTEXMBS04.realtek.com.tw ([fe80::dc53:1026:298b:c584%5]) with mapi id
 15.01.2308.015; Fri, 12 Nov 2021 14:44:05 +0800
From:   Pkshih <pkshih@realtek.com>
To:     Kalle Valo <kvalo@codeaurora.org>
CC:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "tiwai@suse.de" <tiwai@suse.de>,
        "Larry.Finger@lwfinger.net" <Larry.Finger@lwfinger.net>
Subject: RE: [PATCH v2 0/3] rtw89: fix crash when loading firmware file on certain platforms
Thread-Topic: [PATCH v2 0/3] rtw89: fix crash when loading firmware file on
 certain platforms
Thread-Index: AQHX11024Jwy1imW20KpLRdx5tgINKv/azF8gAABjUA=
Date:   Fri, 12 Nov 2021 06:44:05 +0000
Message-ID: <212f57d1a4344aaf9bc418c6971ff6d8@realtek.com>
References: <20211112003453.5073-1-pkshih@realtek.com>
 <878rxtnbj3.fsf@codeaurora.org>
In-Reply-To: <878rxtnbj3.fsf@codeaurora.org>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.21.69.188]
x-kse-serverinfo: RTEXMBS03.realtek.com.tw, 9
x-kse-attachmentfiltering-interceptor-info: no applicable attachment filtering
 rules found
x-kse-antivirus-interceptor-info: scan successful
x-kse-antivirus-info: =?us-ascii?Q?Clean,_bases:_2021/11/12_=3F=3F_03:52:00?=
x-kse-bulkmessagesfiltering-scan-result: protection disabled
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-KSE-ServerInfo: RTEXH36503.realtek.com.tw, 9
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-KSE-AntiSpam-Outbound-Interceptor-Info: scan successful
X-KSE-AntiSpam-Version: 5.9.20, Database issued on: 11/12/2021 06:22:59
X-KSE-AntiSpam-Status: KAS_STATUS_NOT_DETECTED
X-KSE-AntiSpam-Method: none
X-KSE-AntiSpam-Rate: 0
X-KSE-AntiSpam-Info: Lua profiles 167215 [Nov 11 2021]
X-KSE-AntiSpam-Info: Version: 5.9.20.0
X-KSE-AntiSpam-Info: Envelope from: pkshih@realtek.com
X-KSE-AntiSpam-Info: LuaCore: 465 465 eb31509370142567679dd183ac984a0cb2ee3296
X-KSE-AntiSpam-Info: {Tracking_from_domain_doesnt_match_to}
X-KSE-AntiSpam-Info: realtek.com:7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;127.0.0.199:7.1.2
X-KSE-AntiSpam-Info: Rate: 0
X-KSE-AntiSpam-Info: Status: not_detected
X-KSE-AntiSpam-Info: Method: none
X-KSE-AntiSpam-Info: Auth:dkim=none
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Heuristic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 11/12/2021 06:25:00
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


> -----Original Message-----
> From: kvalo=codeaurora.org@mg.codeaurora.org <kvalo=codeaurora.org@mg.codeaurora.org> On Behalf Of Kalle
> Valo
> Sent: Friday, November 12, 2021 2:17 PM
> To: Pkshih <pkshih@realtek.com>
> Cc: linux-wireless@vger.kernel.org; tiwai@suse.de; Larry.Finger@lwfinger.net
> Subject: Re: [PATCH v2 0/3] rtw89: fix crash when loading firmware file on certain platforms
> 
> Ping-Ke Shih <pkshih@realtek.com> writes:
> 
> > First patch is to avoid writing "partition size" on read-only firmware
> > buffer, so it has to fix the crash.
> > The later two patches are used to make the semantics clear, but they don't
> > change the logic at all.
> >
> > I hope at least first patch can be taken into 5.16-rc, so people can avoid
> > this crash.
> >
> > v2: Add Buglink and Tested-by tags.
> >
> > Ping-Ke Shih (3):
> >   rtw89: update partition size of firmware header on skb->data
> >   rtw89: add const in the cast of le32_get_bits()
> >   rtw89: use inline function instead macro to set H2C and CAM
> >
> >  drivers/net/wireless/realtek/rtw89/cam.h  |  468 ++++--
> >  drivers/net/wireless/realtek/rtw89/fw.c   |    2 +-
> >  drivers/net/wireless/realtek/rtw89/fw.h   | 1768 ++++++++++++---------
> >  drivers/net/wireless/realtek/rtw89/txrx.h |   46 +-
> >  4 files changed, 1370 insertions(+), 914 deletions(-)
> 
> Patch 1 should definitely go to wireless-drivers to fix the crash. But
> I'm not sure about patches 2-3, they are quite large, and more like
> cleanup than fixes, so wireless-drivers-next sounds more approriate to
> me. But I can't decide, any thoughts on this?

Without patches 2-3, "future" hotfixes may be hard to merge, but
I don't know if it will happen. My question is how I can deal with
hotfix that can't auto merge; maybe, I can prepare separate patch,
correct? If so, I think we can only take patch 1 to wireless-drivers.

--
Ping-Ke

