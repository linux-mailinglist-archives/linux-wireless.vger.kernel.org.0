Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B0EB312BFC
	for <lists+linux-wireless@lfdr.de>; Fri,  3 May 2019 13:05:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727394AbfECLFx convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 3 May 2019 07:05:53 -0400
Received: from rtits2.realtek.com ([211.75.126.72]:36214 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726396AbfECLFx (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 3 May 2019 07:05:53 -0400
Authenticated-By: 
X-SpamFilter-By: BOX Solutions SpamTrap 5.62 with qID x43B5ndf018172, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtitcasv02.realtek.com.tw[172.21.6.19])
        by rtits2.realtek.com.tw (8.15.2/2.57/5.78) with ESMTPS id x43B5ndf018172
        (version=TLSv1 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
        Fri, 3 May 2019 19:05:50 +0800
Received: from RTITMBSVM04.realtek.com.tw ([fe80::e404:880:2ef1:1aa1]) by
 RTITCASV02.realtek.com.tw ([::1]) with mapi id 14.03.0439.000; Fri, 3 May
 2019 19:05:49 +0800
From:   Tony Chuang <yhchuang@realtek.com>
To:     Kalle Valo <kvalo@codeaurora.org>
CC:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: [PATCH 1/6] rtw88: add license for Makefile
Thread-Topic: [PATCH 1/6] rtw88: add license for Makefile
Thread-Index: AQHVAZ/WZJ9XpmcMBUWyGKsw+K299aZZPNgw
Date:   Fri, 3 May 2019 11:05:48 +0000
Message-ID: <F7CD281DE3E379468C6D07993EA72F84D17E8698@RTITMBSVM04.realtek.com.tw>
References: <1556879502-16211-1-git-send-email-yhchuang@realtek.com>
        <1556879502-16211-2-git-send-email-yhchuang@realtek.com>
 <87v9yrkdfj.fsf@kamboji.qca.qualcomm.com>
In-Reply-To: <87v9yrkdfj.fsf@kamboji.qca.qualcomm.com>
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

> Subject: Re: [PATCH 1/6] rtw88: add license for Makefile
> 
> <yhchuang@realtek.com> writes:
> 
> > From: Yan-Hsuan Chuang <yhchuang@realtek.com>
> >
> > Add missing license for Makefile
> >
> > Signed-off-by: Yan-Hsuan Chuang <yhchuang@realtek.com>
> > ---
> >  drivers/net/wireless/realtek/rtw88/Makefile | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/drivers/net/wireless/realtek/rtw88/Makefile
> b/drivers/net/wireless/realtek/rtw88/Makefile
> > index da5e36e..74cd066 100644
> > --- a/drivers/net/wireless/realtek/rtw88/Makefile
> > +++ b/drivers/net/wireless/realtek/rtw88/Makefile
> > @@ -1,3 +1,5 @@
> > +# SPDX-License-Identifier: GPL-2.0
> 
> Other files in the driver are "GPL-2.0 OR BSD-3-Clause", why not
> Makefile? I prefer that the whole driver has the same license, keeps
> things simple.
> 
> --
> Kalle Valo
> 

You are right, different license is strange.
Will add it in v2, thanks.

Yan-Hsuan
