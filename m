Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3460143F45B
	for <lists+linux-wireless@lfdr.de>; Fri, 29 Oct 2021 03:30:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231365AbhJ2BdL convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 28 Oct 2021 21:33:11 -0400
Received: from rtits2.realtek.com ([211.75.126.72]:43185 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231269AbhJ2BdL (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 28 Oct 2021 21:33:11 -0400
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 19T1UZwmC008333, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36503.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.71/5.88) with ESMTPS id 19T1UZwmC008333
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 29 Oct 2021 09:30:35 +0800
Received: from RTEXDAG02.realtek.com.tw (172.21.6.101) by
 RTEXH36503.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.15; Fri, 29 Oct 2021 09:30:35 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXDAG02.realtek.com.tw (172.21.6.101) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Fri, 29 Oct 2021 09:30:34 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::dc53:1026:298b:c584]) by
 RTEXMBS04.realtek.com.tw ([fe80::dc53:1026:298b:c584%5]) with mapi id
 15.01.2308.015; Fri, 29 Oct 2021 09:30:34 +0800
From:   Pkshih <pkshih@realtek.com>
To:     Brian Norris <briannorris@chromium.org>
CC:     "kvalo@codeaurora.org" <kvalo@codeaurora.org>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        Kevin Yang <kevin_yang@realtek.com>
Subject: RE: [PATCH 1/2] rtw89: update tx power limit/limit_ru tables to R54
Thread-Topic: [PATCH 1/2] rtw89: update tx power limit/limit_ru tables to R54
Thread-Index: AQHXy9ebZBrW4JMwI0O6HEkKfS62rqvoaLkAgADIZdA=
Date:   Fri, 29 Oct 2021 01:30:34 +0000
Message-ID: <cbbc33c377be42c18b850d0322ad22af@realtek.com>
References: <20211028084054.12962-1-pkshih@realtek.com>
 <YXsW2K1BWQjX1w4x@google.com>
In-Reply-To: <YXsW2K1BWQjX1w4x@google.com>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.21.69.188]
x-kse-serverinfo: RTEXDAG02.realtek.com.tw, 9
x-kse-attachmentfiltering-interceptor-info: no applicable attachment filtering
 rules found
x-kse-antivirus-interceptor-info: scan successful
x-kse-antivirus-info: =?us-ascii?Q?Clean,_bases:_2021/10/28_=3F=3F_05:55:00?=
x-kse-bulkmessagesfiltering-scan-result: protection disabled
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-KSE-ServerInfo: RTEXH36503.realtek.com.tw, 9
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-KSE-AntiSpam-Outbound-Interceptor-Info: scan successful
X-KSE-AntiSpam-Version: 5.9.20, Database issued on: 10/29/2021 01:14:45
X-KSE-AntiSpam-Status: KAS_STATUS_NOT_DETECTED
X-KSE-AntiSpam-Method: none
X-KSE-AntiSpam-Rate: 0
X-KSE-AntiSpam-Info: Lua profiles 166975 [Oct 28 2021]
X-KSE-AntiSpam-Info: Version: 5.9.20.0
X-KSE-AntiSpam-Info: Envelope from: pkshih@realtek.com
X-KSE-AntiSpam-Info: LuaCore: 465 465 eb31509370142567679dd183ac984a0cb2ee3296
X-KSE-AntiSpam-Info: {Tracking_from_domain_doesnt_match_to}
X-KSE-AntiSpam-Info: d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;127.0.0.199:7.1.2;realtek.com:7.1.1
X-KSE-AntiSpam-Info: Rate: 0
X-KSE-AntiSpam-Info: Status: not_detected
X-KSE-AntiSpam-Info: Method: none
X-KSE-AntiSpam-Info: Auth:dkim=none
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Heuristic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 10/29/2021 01:18:00
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


> -----Original Message-----
> From: Brian Norris <briannorris@chromium.org>
> Sent: Friday, October 29, 2021 5:32 AM
> To: Pkshih <pkshih@realtek.com>
> Cc: kvalo@codeaurora.org; linux-wireless@vger.kernel.org; Kevin Yang <kevin_yang@realtek.com>
> Subject: Re: [PATCH 1/2] rtw89: update tx power limit/limit_ru tables to R54
> 
> Hi,
> 
> On Thu, Oct 28, 2021 at 04:40:53PM +0800, Ping-Ke Shih wrote:
> > From: Zong-Zhe Yang <kevin_yang@realtek.com>
> >
> > Support QATAR in rtw89_regulation_type and reorder the enum.
> > Update tx power limit table and tx power limit_ru table to configure QATAR
> > and adjust indexes to align rtw89_regulation_type enum.
> >
> > Besides, if an unassigned entry of limit/limit_ru tables is read,
> > return the corresponding WW value for the unconfigured case.
> >
> > Signed-off-by: Zong-Zhe Yang <kevin_yang@realtek.com>
> > Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
> > ---
> >  drivers/net/wireless/realtek/rtw89/core.h     |    9 +-
> >  drivers/net/wireless/realtek/rtw89/phy.c      |   12 +
> >  .../wireless/realtek/rtw89/rtw8852a_table.c   | 5199 +++++++++++------
> >  3 files changed, 3488 insertions(+), 1732 deletions(-)
> >
> > diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
> > index c2885e4dd882..3729abda04f9 100644
> > --- a/drivers/net/wireless/realtek/rtw89/core.h
> > +++ b/drivers/net/wireless/realtek/rtw89/core.h
> > @@ -411,12 +411,13 @@ enum rtw89_regulation_type {
> >  	RTW89_NA	= 4,
> >  	RTW89_IC	= 5,
> >  	RTW89_KCC	= 6,
> > -	RTW89_NCC	= 7,
> > -	RTW89_CHILE	= 8,
> > -	RTW89_ACMA	= 9,
> > -	RTW89_MEXICO	= 10,
> > +	RTW89_ACMA	= 7,
> > +	RTW89_NCC	= 8,
> > +	RTW89_MEXICO	= 9,
> > +	RTW89_CHILE	= 10,
> >  	RTW89_UKRAINE	= 11,
> >  	RTW89_CN	= 12,
> > +	RTW89_QATAR	= 13,
> >  	RTW89_REGD_NUM,
> >  };
> >
> > diff --git a/drivers/net/wireless/realtek/rtw89/phy.c b/drivers/net/wireless/realtek/rtw89/phy.c
> > index ab134856baac..0620ef02e275 100644
> > --- a/drivers/net/wireless/realtek/rtw89/phy.c
> > +++ b/drivers/net/wireless/realtek/rtw89/phy.c
> 
> > diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852a_table.c
> b/drivers/net/wireless/realtek/rtw89/rtw8852a_table.c
> > index 3a4fe7207420..6a61549ffac7 100644
> > --- a/drivers/net/wireless/realtek/rtw89/rtw8852a_table.c
> > +++ b/drivers/net/wireless/realtek/rtw89/rtw8852a_table.c
> > @@ -43556,1346 +43556,1850 @@ const s8 rtw89_8852a_txpwr_lmt_2g[RTW89_2G_BW_NUM][RTW89_NTX_NUM]
> >  	[0][0][0][0][1][0] = 56,
> >  	[0][0][0][0][3][0] = 68,
> >  	[0][0][0][0][5][0] = 76,
> > -	[0][0][0][0][6][0] = 56,
> > -	[0][0][0][0][9][0] = 56,
> > -	[0][0][0][0][8][0] = 60,
> > +	[0][0][0][0][6][0] = 76,
> > +	[0][0][0][0][7][0] = 56,
> > +	[0][0][0][0][10][0] = 60,
> ...
> 
> If one of these colums is based on an enum, you should probably *use*
> the enum in the table. Then this patch would probably much much smaller,
> and it would be clear what parts are changes and what parts are just
> renumbering...
> 
> I'd suggest splitting this into at least one more patch, where the first
> patch should replace all the magic numbers (0..12) with the appropriate
> rtw89_regulation_type values.
> 

Got it. 
Thanks for the suggestion. We'll do it.

--
Ping-Ke

