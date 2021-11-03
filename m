Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8A70443AFC
	for <lists+linux-wireless@lfdr.de>; Wed,  3 Nov 2021 02:24:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233306AbhKCB0r convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 2 Nov 2021 21:26:47 -0400
Received: from rtits2.realtek.com ([211.75.126.72]:59347 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233317AbhKCB0q (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 2 Nov 2021 21:26:46 -0400
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 1A31O42f8015384, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36503.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.71/5.88) with ESMTPS id 1A31O42f8015384
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 3 Nov 2021 09:24:04 +0800
Received: from RTEXDAG01.realtek.com.tw (172.21.6.100) by
 RTEXH36503.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.15; Wed, 3 Nov 2021 09:24:03 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXDAG01.realtek.com.tw (172.21.6.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Tue, 2 Nov 2021 18:24:03 -0700
Received: from RTEXMBS04.realtek.com.tw ([fe80::dc53:1026:298b:c584]) by
 RTEXMBS04.realtek.com.tw ([fe80::dc53:1026:298b:c584%5]) with mapi id
 15.01.2308.015; Wed, 3 Nov 2021 09:24:03 +0800
From:   Pkshih <pkshih@realtek.com>
To:     Brian Norris <briannorris@chromium.org>
CC:     "kvalo@codeaurora.org" <kvalo@codeaurora.org>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        Kevin Yang <kevin_yang@realtek.com>
Subject: RE: [PATCH v2 1/4] rtw89: fill regd field of limit/limit_ru tables by enum
Thread-Topic: [PATCH v2 1/4] rtw89: fill regd field of limit/limit_ru tables
 by enum
Thread-Index: AQHXzwOajHVMZnCB6EeVLK2byOm5l6vu+H+AgAIHHdA=
Date:   Wed, 3 Nov 2021 01:24:03 +0000
Message-ID: <fa8da20fa061418089571e2fcbc84b1e@realtek.com>
References: <20211101093106.28848-1-pkshih@realtek.com>
 <20211101093106.28848-2-pkshih@realtek.com> <YYCdQwCo3E8hH4c3@google.com>
In-Reply-To: <YYCdQwCo3E8hH4c3@google.com>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.21.69.188]
x-kse-serverinfo: RTEXDAG01.realtek.com.tw, 9
x-kse-attachmentfiltering-interceptor-info: no applicable attachment filtering
 rules found
x-kse-antivirus-interceptor-info: scan successful
x-kse-antivirus-info: =?us-ascii?Q?Clean,_bases:_2021/11/2_=3F=3F_10:50:00?=
x-kse-bulkmessagesfiltering-scan-result: protection disabled
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-KSE-ServerInfo: RTEXH36503.realtek.com.tw, 9
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-KSE-AntiSpam-Outbound-Interceptor-Info: scan successful
X-KSE-AntiSpam-Version: 5.9.20, Database issued on: 11/03/2021 01:03:30
X-KSE-AntiSpam-Status: KAS_STATUS_NOT_DETECTED
X-KSE-AntiSpam-Method: none
X-KSE-AntiSpam-Rate: 0
X-KSE-AntiSpam-Info: Lua profiles 167068 [Nov 03 2021]
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
X-KSE-Antiphishing-Bases: 11/03/2021 01:07:00
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


> -----Original Message-----
> From: Brian Norris <briannorris@chromium.org>
> Sent: Tuesday, November 2, 2021 10:07 AM
> To: Pkshih <pkshih@realtek.com>
> Cc: kvalo@codeaurora.org; linux-wireless@vger.kernel.org; Kevin Yang <kevin_yang@realtek.com>
> Subject: Re: [PATCH v2 1/4] rtw89: fill regd field of limit/limit_ru tables by enum
> 
> On Mon, Nov 01, 2021 at 05:31:03PM +0800, Ping-Ke Shih wrote:
> > From: Zong-Zhe Yang <kevin_yang@realtek.com>
> >
> > This modification just replaces the number filled in the regd field
> > with the corresponding enum. No assignment of a value in a table is
> > changed. Doing this first is because the follow-up patches may adjust
> > the order of enum declarations.
> >
> > Signed-off-by: Zong-Zhe Yang <kevin_yang@realtek.com>
> > Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
> > ---
> >  .../wireless/realtek/rtw89/rtw8852a_table.c   | 10458 ++++++++--------
> >  1 file changed, 5229 insertions(+), 5229 deletions(-)
> >
> > diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852a_table.c
> b/drivers/net/wireless/realtek/rtw89/rtw8852a_table.c
> > index 3a4fe7207420..c7ebeed043c5 100644
> > --- a/drivers/net/wireless/realtek/rtw89/rtw8852a_table.c
> > +++ b/drivers/net/wireless/realtek/rtw89/rtw8852a_table.c
> > @@ -43384,5248 +43384,5248 @@ static const u8 _txpwr_track_delta_swingidx_2g_cck_a_p[] = {
> >  const s8 rtw89_8852a_txpwr_lmt_2g[RTW89_2G_BW_NUM][RTW89_NTX_NUM]
> >  				 [RTW89_RS_LMT_NUM][RTW89_BF_NUM]
> >  				 [RTW89_REGD_NUM][RTW89_2G_CH_NUM] = {
> > -	[0][0][0][0][0][0] = 56,
> 
> FWIW, these transformations worked out for me:
> 
> Reviewed-by: Brian Norris <briannorris@chromium.org>
> 
> These files are still enormous though, which an enormous amount of
> repetition. I can't help but think there's a better way to do these
> things. For instance, if there's a repeated/shared pattern, one could
> just save that array once, and generate the repeated copies at runtime.
> Or instead of exposing an enormous const array directly to the "core",
> add some kind of abstraction function, where the function can perform
> more custom (and presumably more targeted, with less duplication?) logic
> to determine the answer.
> 

Our RF team measure the combinations of output power one by one for each
regulatory domain, so I think there is no a rule or pattern to generate
one from another one.

More, if we convert it to a reduced table and use the table, it will
be hard to align with our internal tables. Even, it becomes harder
to understand the patch if we "compress" the table in some ways.

I will discuss with our RF team if we can have any improvement of the size,
but still readable.

--
Ping-Ke

