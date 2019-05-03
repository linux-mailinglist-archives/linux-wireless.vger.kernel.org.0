Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8A9B212C42
	for <lists+linux-wireless@lfdr.de>; Fri,  3 May 2019 13:23:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726969AbfECLXB convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 3 May 2019 07:23:01 -0400
Received: from rtits2.realtek.com ([211.75.126.72]:44309 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726372AbfECLXB (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 3 May 2019 07:23:01 -0400
Authenticated-By: 
X-SpamFilter-By: BOX Solutions SpamTrap 5.62 with qID x43BMuJf028780, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtitcasv02.realtek.com.tw[172.21.6.19])
        by rtits2.realtek.com.tw (8.15.2/2.57/5.78) with ESMTPS id x43BMuJf028780
        (version=TLSv1 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
        Fri, 3 May 2019 19:22:57 +0800
Received: from RTITMBSVM04.realtek.com.tw ([fe80::e404:880:2ef1:1aa1]) by
 RTITCASV02.realtek.com.tw ([::1]) with mapi id 14.03.0439.000; Fri, 3 May
 2019 19:22:56 +0800
From:   Tony Chuang <yhchuang@realtek.com>
To:     Kalle Valo <kvalo@codeaurora.org>
CC:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: [PATCH 5/6] rtw88: mac: remove dangerous while (1)
Thread-Topic: [PATCH 5/6] rtw88: mac: remove dangerous while (1)
Thread-Index: AQHVAaBWc+Obl4OrnkWOg3YkXAd45KZZQRVA
Date:   Fri, 3 May 2019 11:22:56 +0000
Message-ID: <F7CD281DE3E379468C6D07993EA72F84D17E871A@RTITMBSVM04.realtek.com.tw>
References: <1556879502-16211-1-git-send-email-yhchuang@realtek.com>
        <1556879502-16211-6-git-send-email-yhchuang@realtek.com>
 <87r29fkd9k.fsf@kamboji.qca.qualcomm.com>
In-Reply-To: <87r29fkd9k.fsf@kamboji.qca.qualcomm.com>
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

> Subject: Re: [PATCH 5/6] rtw88: mac: remove dangerous while (1)
> 
> <yhchuang@realtek.com> writes:
> 
> > From: Yan-Hsuan Chuang <yhchuang@realtek.com>
> >
> > Not to use while (1) to parse power sequence commands in an array.
> > Put the statement (when cmd is not NULL) instead to make the loop stop
> > when the next fetched command is NULL.
> >
> > Signed-off-by: Yan-Hsuan Chuang <yhchuang@realtek.com>
> > ---
> >  drivers/net/wireless/realtek/rtw88/mac.c | 9 +++------
> >  1 file changed, 3 insertions(+), 6 deletions(-)
> >
> > diff --git a/drivers/net/wireless/realtek/rtw88/mac.c
> b/drivers/net/wireless/realtek/rtw88/mac.c
> > index 25a923b..7487b2e 100644
> > --- a/drivers/net/wireless/realtek/rtw88/mac.c
> > +++ b/drivers/net/wireless/realtek/rtw88/mac.c
> > @@ -203,17 +203,14 @@ static int rtw_pwr_seq_parser(struct rtw_dev
> *rtwdev,
> >  		return -EINVAL;
> >  	}
> >
> > -	do {
> > -		cmd = cmd_seq[idx];
> > -		if (!cmd)
> > -			break;
> > -
> > +	while ((cmd = cmd_seq[idx])) {
> >  		ret = rtw_sub_pwr_seq_parser(rtwdev, intf_mask, cut_mask, cmd);
> >  		if (ret)
> >  			return -EBUSY;
> >
> > +		/* fetch next command */
> >  		idx++;
> > -	} while (1);
> > +	};
> 
> I dount see how this is any better, with a suitable bug you can still
> have a neverending loop, right? I was thinking more something like this:
> 
> count = 100;
> do {
>     ....
> } while (count--);
> 
> That way the won't be more than 100 loops no matter how many bugs there
> are :) Of course I have no idea what would be a good value for count.
> 

To make this totally safe, I think we need to re-write the power seq parsing code.
I think I should drop this patch, and write a better code later.

And also re-write the polling command, to remove the while (1).

Yan-Hsuan
