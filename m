Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6FEFEE2E84
	for <lists+linux-wireless@lfdr.de>; Thu, 24 Oct 2019 12:14:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393347AbfJXKOG convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 24 Oct 2019 06:14:06 -0400
Received: from rtits2.realtek.com ([211.75.126.72]:53523 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393328AbfJXKOG (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 24 Oct 2019 06:14:06 -0400
Authenticated-By: 
X-SpamFilter-By: BOX Solutions SpamTrap 5.62 with qID x9OAE0d5016626, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (RTITCASV02.realtek.com.tw[172.21.6.19])
        by rtits2.realtek.com.tw (8.15.2/2.57/5.78) with ESMTPS id x9OAE0d5016626
        (version=TLSv1 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
        Thu, 24 Oct 2019 18:14:00 +0800
Received: from RTITMBSVM04.realtek.com.tw ([fe80::e404:880:2ef1:1aa1]) by
 RTITCASV02.realtek.com.tw ([::1]) with mapi id 14.03.0468.000; Thu, 24 Oct
 2019 18:14:00 +0800
From:   Tony Chuang <yhchuang@realtek.com>
To:     Kalle Valo <kvalo@codeaurora.org>
CC:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: [PATCH] rtw88: fix GENMASK_ULL for u64
Thread-Topic: [PATCH] rtw88: fix GENMASK_ULL for u64
Thread-Index: AQHVikxJCyqXv3HRNU+F6JfFe6i286dpkRaTgAABnAA=
Date:   Thu, 24 Oct 2019 10:13:59 +0000
Message-ID: <F7CD281DE3E379468C6D07993EA72F84D190F29C@RTITMBSVM04.realtek.com.tw>
References: <20191024091948.10569-1-yhchuang@realtek.com>
 <87ftjie9t3.fsf@tynnyri.adurom.net>
In-Reply-To: <87ftjie9t3.fsf@tynnyri.adurom.net>
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

> Subject: Re: [PATCH] rtw88: fix GENMASK_ULL for u64
> 
> <yhchuang@realtek.com> writes:
> 
> > From: Yan-Hsuan Chuang <yhchuang@realtek.com>
> >
> > This fixes compile warning:
> >
> >     In file included from include/linux/bitops.h:5:0,
> >                      from include/linux/kernel.h:12,
> >                      from include/asm-generic/bug.h:19,
> >                      from arch/mips/include/asm/bug.h:42,
> >                      from include/linux/bug.h:5,
> >                      from include/net/mac80211.h:16,
> >                      from
> drivers/net/wireless/realtek/rtw88/main.h:8,
> >                      from
> drivers/net/wireless/realtek/rtw88/main.c:5:
> >     drivers/net/wireless/realtek/rtw88/main.c: In function
> 'rtw_update_rate_mask':
> >       include/linux/bits.h:23:11: warning: right shift count is negative
> >       [-Wshift-count-negative]
> >        (~UL(0) >> (BITS_PER_LONG - 1 - (h))))
> >                ^
> >     drivers/net/wireless/realtek/rtw88/main.c:622:17: note: in expansion
> of macro 'GENMASK'
> >       u64 cfg_mask = GENMASK(63, 0);
> >                      ^~~~~~~
> >
> > Fixes: f39e9bd49a3d ("rtw88: add set_bitrate_mask support")
> > Signed-off-by: Yan-Hsuan Chuang <yhchuang@realtek.com>
> 
> I'll add:
> 
> Reported-by: kbuild test robot <lkp@intel.com>
> 

Yes, please add it, I forgot about it.
Thanks

Yan-Hsuan
