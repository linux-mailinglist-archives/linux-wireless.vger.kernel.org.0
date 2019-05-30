Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 073D62F70B
	for <lists+linux-wireless@lfdr.de>; Thu, 30 May 2019 07:15:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726308AbfE3FPq convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 30 May 2019 01:15:46 -0400
Received: from rtits2.realtek.com ([211.75.126.72]:55134 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725961AbfE3FPq (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 30 May 2019 01:15:46 -0400
Authenticated-By: 
X-SpamFilter-By: BOX Solutions SpamTrap 5.62 with qID x4U5Fa4O000718, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtitcasv02.realtek.com.tw[172.21.6.19])
        by rtits2.realtek.com.tw (8.15.2/2.57/5.78) with ESMTPS id x4U5Fa4O000718
        (version=TLSv1 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
        Thu, 30 May 2019 13:15:36 +0800
Received: from RTITMBSVM04.realtek.com.tw ([fe80::e404:880:2ef1:1aa1]) by
 RTITCASV02.realtek.com.tw ([::1]) with mapi id 14.03.0439.000; Thu, 30 May
 2019 13:15:36 +0800
From:   Tony Chuang <yhchuang@realtek.com>
To:     Kalle Valo <kvalo@codeaurora.org>
CC:     Larry Finger <Larry.Finger@lwfinger.net>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: [PATCH 01/11] rtw88: resolve order of tx power setting routines
Thread-Topic: [PATCH 01/11] rtw88: resolve order of tx power setting routines
Thread-Index: AQHVFqYVj7cTtmsick2V2quSGI+CHaaDH0NQ
Date:   Thu, 30 May 2019 05:15:35 +0000
Message-ID: <F7CD281DE3E379468C6D07993EA72F84D17FAD63@RTITMBSVM04.realtek.com.tw>
References: <1559116487-5244-1-git-send-email-yhchuang@realtek.com>
        <1559116487-5244-2-git-send-email-yhchuang@realtek.com>
        <f5bd9ab0-c32c-dcc6-9451-09e6b7f50a96@lwfinger.net>
        <F7CD281DE3E379468C6D07993EA72F84D17FABBF@RTITMBSVM04.realtek.com.tw>
        <87v9xspmfd.fsf@codeaurora.org>
        <F7CD281DE3E379468C6D07993EA72F84D17FAD0F@RTITMBSVM04.realtek.com.tw>
 <87r28gplw5.fsf@codeaurora.org>
In-Reply-To: <87r28gplw5.fsf@codeaurora.org>
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



> -----Original Message-----
> From: Kalle Valo [mailto:kvalo@codeaurora.org]
> Sent: Thursday, May 30, 2019 1:11 PM
> To: Tony Chuang
> Cc: Larry Finger; linux-wireless@vger.kernel.org
> Subject: Re: [PATCH 01/11] rtw88: resolve order of tx power setting routines
> 
> Tony Chuang <yhchuang@realtek.com> writes:
> 
> >> > These patches are based on
> >> >
> >> >
> >>
> https://kernel.googlesource.com/pub/scm/linux/kernel/git/kvalo/wireless-dr
> >> ivers
> >> > branch master
> >> >
> >> > commit 6aca09771db4277a78853d6ac680d8d5f0d915e3
> >> > Author: YueHaibing <yuehaibing@huawei.com>
> >> > Date:   Sat May 4 18:32:24 2019 +0800
> >> >
> >> >     rtw88: Make some symbols static
> >> >
> >> >
> >> > It should apply, did I miss something?
> >>
> >> I keep the bar high and take to wireless-drivers only patches which fix
> >> important, user visible problems. Everything else goes to
> >> wireless-drivers-next. So you should use wireless-drivers-next as the
> >> baseline for all regular patches.
> >
> > But this series has dependency with " rtw88: Make some symbols static"
> 
> This is exactly why I keep the bar high for patches going to
> wireless-drivers :) These depencies and conflicts are just too time
> consuming otherwise.
> 
> > Or you can handle it
> 
> Unfortunately not, as I made a mistake when fast-forwarding
> wireless-drivers and I cannot merge wireless-drivers into
> wireles-drivers-next right now. So you just need to wait for the
> depencies to trickle down to w-d-next, that will take few weeks.

It means that I just need to wait for the patches in w-d to go to w-d-next?
So I don't need to resend them, just wait and you can merge this.

Yan-Hsuan
