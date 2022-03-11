Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2ABD4D566B
	for <lists+linux-wireless@lfdr.de>; Fri, 11 Mar 2022 01:16:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345155AbiCKAR5 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 10 Mar 2022 19:17:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238512AbiCKARv (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 10 Mar 2022 19:17:51 -0500
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F533A418B
        for <linux-wireless@vger.kernel.org>; Thu, 10 Mar 2022 16:16:47 -0800 (PST)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 22B0GWwnC023318, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36504.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.71/5.88) with ESMTPS id 22B0GWwnC023318
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 11 Mar 2022 08:16:32 +0800
Received: from RTEXDAG02.realtek.com.tw (172.21.6.101) by
 RTEXH36504.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Fri, 11 Mar 2022 08:16:32 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXDAG02.realtek.com.tw (172.21.6.101) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Fri, 11 Mar 2022 08:16:32 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::41d7:1d2e:78a6:ff34]) by
 RTEXMBS04.realtek.com.tw ([fe80::41d7:1d2e:78a6:ff34%5]) with mapi id
 15.01.2308.021; Fri, 11 Mar 2022 08:16:32 +0800
From:   Pkshih <pkshih@realtek.com>
To:     Kalle Valo <kvalo@kernel.org>
CC:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: [PATCH v2 10/13] rtw89: 8852c: add chip::dle_mem
Thread-Topic: [PATCH v2 10/13] rtw89: 8852c: add chip::dle_mem
Thread-Index: AQHYMel58D0tDcRNR0iUJvBaflFq76y41oUIgAB+D1A=
Date:   Fri, 11 Mar 2022 00:16:32 +0000
Message-ID: <391619879a4e44b6a95cb8ae08b88752@realtek.com>
References: <20220307060457.56789-1-pkshih@realtek.com>
        <20220307060457.56789-11-pkshih@realtek.com> <87k0d1rcfn.fsf@kernel.org>
In-Reply-To: <87k0d1rcfn.fsf@kernel.org>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.21.69.188]
x-kse-serverinfo: RTEXDAG02.realtek.com.tw, 9
x-kse-attachmentfiltering-interceptor-info: no applicable attachment filtering
 rules found
x-kse-antivirus-interceptor-info: scan successful
x-kse-antivirus-info: =?us-ascii?Q?Clean,_bases:_2022/3/10_=3F=3F_05:14:00?=
x-kse-bulkmessagesfiltering-scan-result: protection disabled
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-KSE-ServerInfo: RTEXH36504.realtek.com.tw, 9
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


> -----Original Message-----
> From: Kalle Valo <kvalo@kernel.org>
> Sent: Friday, March 11, 2022 12:38 AM
> To: Pkshih <pkshih@realtek.com>
> Cc: linux-wireless@vger.kernel.org
> Subject: Re: [PATCH v2 10/13] rtw89: 8852c: add chip::dle_mem
> 
> Ping-Ke Shih <pkshih@realtek.com> writes:
> 
> > These tables are used to configure hardware buffer size according to
> > operating mode.
> >
> > Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
> > ---
> >  drivers/net/wireless/realtek/rtw89/core.h     |  1 +
> >  drivers/net/wireless/realtek/rtw89/mac.c      | 62 +++++++++++++++++++
> >  drivers/net/wireless/realtek/rtw89/mac.h      | 10 +++
> >  drivers/net/wireless/realtek/rtw89/reg.h      |  1 +
> >  drivers/net/wireless/realtek/rtw89/rtw8852c.c | 12 ++++
> >  5 files changed, 86 insertions(+)
> >
> > diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
> > index 2dc19b530db62..207ac7e605691 100644
> > --- a/drivers/net/wireless/realtek/rtw89/core.h
> > +++ b/drivers/net/wireless/realtek/rtw89/core.h
> > @@ -2168,6 +2168,7 @@ struct rtw89_ple_quota {
> >  	u16 bb_rpt;
> >  	u16 wd_rel;
> >  	u16 cpu_io;
> > +	u16 tx_rpt;
> >  };
> >
> >  struct rtw89_dle_mem {
> > diff --git a/drivers/net/wireless/realtek/rtw89/mac.c b/drivers/net/wireless/realtek/rtw89/mac.c
> > index df657df6b1493..0081cfbfea042 100644
> > --- a/drivers/net/wireless/realtek/rtw89/mac.c
> > +++ b/drivers/net/wireless/realtek/rtw89/mac.c
> > @@ -1183,6 +1183,18 @@ const struct rtw89_dle_size rtw89_wde_size4 = {
> >  };
> >  EXPORT_SYMBOL(rtw89_wde_size4);
> >
> > +/* 8852C DLFW */
> > +const struct rtw89_dle_size rtw89_wde_size18 = {
> > +	RTW89_WDE_PG_64, 0, 2048,
> > +};
> > +EXPORT_SYMBOL(rtw89_wde_size18);
> > +
> > +/* 8852C PCIE SCC */
> > +const struct rtw89_dle_size rtw89_wde_size19 = {
> > +	RTW89_WDE_PG_64, 3328, 0,
> > +};
> > +EXPORT_SYMBOL(rtw89_wde_size19);
> > +
> >  /* PCIE */
> >  const struct rtw89_dle_size rtw89_ple_size0 = {
> >  	RTW89_PLE_PG_128, 1520, 16,
> > @@ -1195,6 +1207,18 @@ const struct rtw89_dle_size rtw89_ple_size4 = {
> >  };
> >  EXPORT_SYMBOL(rtw89_ple_size4);
> >
> > +/* 8852C DLFW */
> > +const struct rtw89_dle_size rtw89_ple_size18 = {
> > +	RTW89_PLE_PG_128, 2544, 16,
> > +};
> > +EXPORT_SYMBOL(rtw89_ple_size18);
> > +
> > +/* 8852C PCIE SCC */
> > +const struct rtw89_dle_size rtw89_ple_size19 = {
> > +	RTW89_PLE_PG_128, 1904, 16,
> > +};
> > +EXPORT_SYMBOL(rtw89_ple_size19);
> 
> How much memory does does one EXPORT_SYMBOL() take? There are a lot of
> symbols exported now, and some of them have just four values. Wouldn't
> it make more sense to have only one exported structure which contains
> all the smaller structures?
> 
> You could consider this as a separate cleanup.
> 

An export symbol costs 40 bytes:

original:
   text    data     bss     dec     hex filename
  46165    1386       0   47551    b9bf mac.o

remove one export symbol:
   text    data     bss     dec     hex filename
  46133    1378       0   47511    b997 mac.o

I will cleanup them as your suggestion, and pay attention to further patches.
Thank you.

--
Ping-Ke

