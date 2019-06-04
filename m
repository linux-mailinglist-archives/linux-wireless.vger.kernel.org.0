Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 61812341A2
	for <lists+linux-wireless@lfdr.de>; Tue,  4 Jun 2019 10:18:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726934AbfFDISv convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 4 Jun 2019 04:18:51 -0400
Received: from rtits2.realtek.com ([211.75.126.72]:50275 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726732AbfFDISv (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 4 Jun 2019 04:18:51 -0400
Authenticated-By: 
X-SpamFilter-By: BOX Solutions SpamTrap 5.62 with qID x548IaOX019946, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtitcasv01.realtek.com.tw[172.21.6.18])
        by rtits2.realtek.com.tw (8.15.2/2.57/5.78) with ESMTPS id x548IaOX019946
        (version=TLSv1 cipher=AES256-SHA bits=256 verify=NOT);
        Tue, 4 Jun 2019 16:18:36 +0800
Received: from RTITMBSVM04.realtek.com.tw ([fe80::e404:880:2ef1:1aa1]) by
 RTITCASV01.realtek.com.tw ([::1]) with mapi id 14.03.0439.000; Tue, 4 Jun
 2019 16:18:35 +0800
From:   Tony Chuang <yhchuang@realtek.com>
To:     Joe Perches <joe@perches.com>,
        "kvalo@codeaurora.org" <kvalo@codeaurora.org>
CC:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: [PATCH 11/11] rtw88: debug: dump tx power indexes in use
Thread-Topic: [PATCH 11/11] rtw88: debug: dump tx power indexes in use
Thread-Index: AQHVFfPUdYk/ZiyYCUumG1g5tKAANqaG5yaAgARIvzA=
Date:   Tue, 4 Jun 2019 08:18:35 +0000
Message-ID: <F7CD281DE3E379468C6D07993EA72F84D17FED3E@RTITMBSVM04.realtek.com.tw>
References: <1559116487-5244-1-git-send-email-yhchuang@realtek.com>
         <1559116487-5244-12-git-send-email-yhchuang@realtek.com>
 <39d56df83cc8de95969c6ba3003d8101caedc045.camel@perches.com>
In-Reply-To: <39d56df83cc8de95969c6ba3003d8101caedc045.camel@perches.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.21.68.183]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

> Subject: Re: [PATCH 11/11] rtw88: debug: dump tx power indexes in use
> 
> On Wed, 2019-05-29 at 15:54 +0800, yhchuang@realtek.com wrote:
> > From: Zong-Zhe Yang <kevin_yang@realtek.com>
> >
> > Add a read entry in debugfs to dump current tx power
> > indexes in use for each path and each rate section.
> > The corresponding power bases, power by rate, and
> > power limit are also included.
> >
> > Signed-off-by: Zong-Zhe Yang <kevin_yang@realtek.com>
> > Signed-off-by: Yan-Hsuan Chuang <yhchuang@realtek.com>
> > ---
> >  drivers/net/wireless/realtek/rtw88/debug.c | 112
> +++++++++++++++++++++++++++++
> >  1 file changed, 112 insertions(+)
> >
> > diff --git a/drivers/net/wireless/realtek/rtw88/debug.c
> b/drivers/net/wireless/realtek/rtw88/debug.c
> > index f0ae260..ee2937c2 100644
> > --- a/drivers/net/wireless/realtek/rtw88/debug.c
> > +++ b/drivers/net/wireless/realtek/rtw88/debug.c
> > @@ -8,6 +8,7 @@
> >  #include "sec.h"
> >  #include "fw.h"
> >  #include "debug.h"
> > +#include "phy.h"
> >
> >  #ifdef CONFIG_RTW88_DEBUGFS
> >
> > @@ -460,6 +461,112 @@ static int rtw_debug_get_rf_dump(struct seq_file
> *m, void *v)
> >  	return 0;
> >  }
> >
> > +static void rtw_print_cck_rate_txt(struct seq_file *m, u8 rate)
> > +{
> > +	static const char * const
> > +	cck_rate[] = {"1M", "2M", "5.5M", "11M"};
> > +	u8 idx = rate - DESC_RATE1M;
> > +
> > +	seq_printf(m, "%5s%-5s", "CCK_", cck_rate[idx]);
> 
> Why use %5s instead of just embedding the prefix directly?
> Also why use %5s at all when the length is 4?
> 
> I think it'd be more sensible as:
> 
> 	seq_printf(m, " CCK_%-5s", cck_rate[idx]);
> 

Ok, it is better.
Will send a v2 later :)
Thanks

Yan-Hsuan
