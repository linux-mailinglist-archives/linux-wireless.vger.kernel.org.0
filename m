Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9AD1F44DF3C
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Nov 2021 01:38:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234580AbhKLAlX convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 11 Nov 2021 19:41:23 -0500
Received: from rtits2.realtek.com ([211.75.126.72]:40331 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234489AbhKLAlW (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 11 Nov 2021 19:41:22 -0500
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 1AC0cN3C1001395, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36504.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.71/5.88) with ESMTPS id 1AC0cN3C1001395
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 12 Nov 2021 08:38:23 +0800
Received: from RTEXMBS01.realtek.com.tw (172.21.6.94) by
 RTEXH36504.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Fri, 12 Nov 2021 08:38:22 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS01.realtek.com.tw (172.21.6.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.15; Thu, 11 Nov 2021 19:38:22 -0500
Received: from RTEXMBS04.realtek.com.tw ([fe80::dc53:1026:298b:c584]) by
 RTEXMBS04.realtek.com.tw ([fe80::dc53:1026:298b:c584%5]) with mapi id
 15.01.2308.015; Fri, 12 Nov 2021 08:38:22 +0800
From:   Pkshih <pkshih@realtek.com>
To:     Takashi Iwai <tiwai@suse.de>
CC:     "kvalo@codeaurora.org" <kvalo@codeaurora.org>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "Larry.Finger@gmail.com" <Larry.Finger@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] rtw89: Fix crash by loading compressed firmware file
Thread-Topic: [PATCH] rtw89: Fix crash by loading compressed firmware file
Thread-Index: AQHX0hU7VE24GGCl002qwvOXgdMXQqv0AUsAgACX6Q///34ogIAAjK5D///UggCAAArHAIAJHR/Q///AsAAADsiKgAAn5IYA
Date:   Fri, 12 Nov 2021 00:38:21 +0000
Message-ID: <489f31a2f323487da829d67480f09b52@realtek.com>
References: <20211105071725.31539-1-tiwai@suse.de>
        <s5hpmrfgj93.wl-tiwai@suse.de>  <87zgqjqaae.fsf@codeaurora.org>
        <s5hh7crgflg.wl-tiwai@suse.de>  <87v917q8hw.fsf@codeaurora.org>
        <bd80d3b6cdc42d7818d7d5c6a5036d8188eb4a67.camel@realtek.com>
        <s5h5yt6fxpf.wl-tiwai@suse.de>  <68f61525b26f46578a62b2a54d775c17@realtek.com>
        <s5hv90z5hlh.wl-tiwai@suse.de> <s5hwnle4y00.wl-tiwai@suse.de>
In-Reply-To: <s5hwnle4y00.wl-tiwai@suse.de>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.21.69.188]
x-kse-serverinfo: RTEXMBS01.realtek.com.tw, 9
x-kse-attachmentfiltering-interceptor-info: no applicable attachment filtering
 rules found
x-kse-antivirus-interceptor-info: scan successful
x-kse-antivirus-info: =?us-ascii?Q?Clean,_bases:_2021/11/11_=3F=3F_10:30:00?=
x-kse-bulkmessagesfiltering-scan-result: protection disabled
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-KSE-ServerInfo: RTEXH36504.realtek.com.tw, 9
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-KSE-AntiSpam-Outbound-Interceptor-Info: scan successful
X-KSE-AntiSpam-Version: 5.9.20, Database issued on: 11/12/2021 00:25:28
X-KSE-AntiSpam-Status: KAS_STATUS_NOT_DETECTED
X-KSE-AntiSpam-Method: none
X-KSE-AntiSpam-Rate: 0
X-KSE-AntiSpam-Info: Lua profiles 167215 [Nov 11 2021]
X-KSE-AntiSpam-Info: Version: 5.9.20.0
X-KSE-AntiSpam-Info: Envelope from: pkshih@realtek.com
X-KSE-AntiSpam-Info: LuaCore: 465 465 eb31509370142567679dd183ac984a0cb2ee3296
X-KSE-AntiSpam-Info: {Tracking_uf_ne_domains}
X-KSE-AntiSpam-Info: {Tracking_from_domain_doesnt_match_to}
X-KSE-AntiSpam-Info: 127.0.0.199:7.1.2;bugzilla.opensuse.org:7.1.1;realtek.com:7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;lore.kernel.org:7.1.1
X-KSE-AntiSpam-Info: Rate: 0
X-KSE-AntiSpam-Info: Status: not_detected
X-KSE-AntiSpam-Info: Method: none
X-KSE-AntiSpam-Info: Auth:dkim=none
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Heuristic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 11/12/2021 00:29:00
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


> -----Original Message-----
> From: Takashi Iwai <tiwai@suse.de>
> Sent: Thursday, November 11, 2021 9:34 PM
> To: Pkshih <pkshih@realtek.com>
> Cc: kvalo@codeaurora.org; linux-wireless@vger.kernel.org; Larry.Finger@gmail.com;
> linux-kernel@vger.kernel.org
> Subject: Re: [PATCH] rtw89: Fix crash by loading compressed firmware file
> 
> On Thu, 11 Nov 2021 07:31:06 +0100,
> Takashi Iwai wrote:
> >
> > On Thu, 11 Nov 2021 03:28:09 +0100,
> > Pkshih wrote:
> > > Please check if my patch works on your platform.
> > > Thanks you.
> > >
> > > [1] https://lore.kernel.org/linux-wireless/20211111021457.13776-1-pkshih@realtek.com/T/#t
> >
> > Thanks.  I'll ask people testing those patches.
> 
> The patches have been confirmed to work.
> Feel free to put the tag
> 
> BugLink: https://bugzilla.opensuse.org/show_bug.cgi?id=1188303
> 

I have sent v2 with BugLink and Tested-by tags.
If anything is improper, please let me know.

--
Ping-Ke

