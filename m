Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 102CD12BF8
	for <lists+linux-wireless@lfdr.de>; Fri,  3 May 2019 13:04:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727413AbfECLEP convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 3 May 2019 07:04:15 -0400
Received: from rtits2.realtek.com ([211.75.126.72]:35483 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726396AbfECLEP (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 3 May 2019 07:04:15 -0400
Authenticated-By: 
X-SpamFilter-By: BOX Solutions SpamTrap 5.62 with qID x43B4AhQ017891, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtitcas12.realtek.com.tw[172.21.6.16])
        by rtits2.realtek.com.tw (8.15.2/2.57/5.78) with ESMTPS id x43B4AhQ017891
        (version=TLSv1 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
        Fri, 3 May 2019 19:04:10 +0800
Received: from RTITMBSVM04.realtek.com.tw ([fe80::e404:880:2ef1:1aa1]) by
 RTITCAS12.realtek.com.tw ([::1]) with mapi id 14.03.0439.000; Fri, 3 May 2019
 19:04:10 +0800
From:   Tony Chuang <yhchuang@realtek.com>
To:     Kalle Valo <kvalo@codeaurora.org>
CC:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: [PATCH 6/6] rtw88: more descriptions about LPS
Thread-Topic: [PATCH 6/6] rtw88: more descriptions about LPS
Thread-Index: AQHVAZ+MkxFW2+aB7EKJRq8nT7XPpKZZPHUw
Date:   Fri, 3 May 2019 11:04:09 +0000
Message-ID: <F7CD281DE3E379468C6D07993EA72F84D17E865B@RTITMBSVM04.realtek.com.tw>
References: <1556879502-16211-1-git-send-email-yhchuang@realtek.com>
        <1556879502-16211-7-git-send-email-yhchuang@realtek.com>
 <87zho3kdiy.fsf@kamboji.qca.qualcomm.com>
In-Reply-To: <87zho3kdiy.fsf@kamboji.qca.qualcomm.com>
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

> Subject: Re: [PATCH 6/6] rtw88: more descriptions about LPS
> 
> <yhchuang@realtek.com> writes:
> 
> > From: Yan-Hsuan Chuang <yhchuang@realtek.com>
> >
> > The LPS represents Leisure Power Save. When enabled, firmware will be in
> > charge of turning radio off between beacons. Also firmware should turn
> > on the radio when beacon is coming, and the data queued should be
> > transmitted in TBTT period.
> >
> > Signed-off-by: Yan-Hsuan Chuang <yhchuang@realtek.com>
> > ---
> >  drivers/net/wireless/realtek/rtw88/main.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/net/wireless/realtek/rtw88/main.c
> > b/drivers/net/wireless/realtek/rtw88/main.c
> > index f447361..6953013 100644
> > --- a/drivers/net/wireless/realtek/rtw88/main.c
> > +++ b/drivers/net/wireless/realtek/rtw88/main.c
> > @@ -20,7 +20,7 @@ EXPORT_SYMBOL(rtw_debug_mask);
> >  module_param_named(support_lps, rtw_fw_support_lps, bool, 0644);
> >  module_param_named(debug_mask, rtw_debug_mask, uint, 0644);
> >
> > -MODULE_PARM_DESC(support_lps, "Set Y to enable LPS support");
> > +MODULE_PARM_DESC(support_lps, "Set Y to enable Leisure Power Save
> > support, turn radio off between beacons");
> 
> I think it would help to add:
> 
> ", to turn radio off between beacons"
> 

Looks better, will include it in v2.
Thanks.

Yan-Hsuan
