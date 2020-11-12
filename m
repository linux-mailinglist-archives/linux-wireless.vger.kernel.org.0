Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99C5E2AFE80
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Nov 2020 06:38:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728752AbgKLFif convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 12 Nov 2020 00:38:35 -0500
Received: from rtits2.realtek.com ([211.75.126.72]:58394 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726003AbgKLCXP (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 11 Nov 2020 21:23:15 -0500
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 0AC2N7GK0009087, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexmb01.realtek.com.tw[172.21.6.94])
        by rtits2.realtek.com.tw (8.15.2/2.70/5.88) with ESMTPS id 0AC2N7GK0009087
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 12 Nov 2020 10:23:07 +0800
Received: from RTEXMB04.realtek.com.tw (172.21.6.97) by
 RTEXMB01.realtek.com.tw (172.21.6.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2044.4; Thu, 12 Nov 2020 10:23:07 +0800
Received: from RTEXMB04.realtek.com.tw ([fe80::89f7:e6c3:b043:15fa]) by
 RTEXMB04.realtek.com.tw ([fe80::89f7:e6c3:b043:15fa%3]) with mapi id
 15.01.2044.006; Thu, 12 Nov 2020 10:23:07 +0800
From:   Pkshih <pkshih@realtek.com>
To:     Kalle Valo <kvalo@codeaurora.org>
CC:     "tony0620emma@gmail.com" <tony0620emma@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: [PATCH 01/11] rtw88: coex: update TDMA settings for different beacon interval
Thread-Topic: [PATCH 01/11] rtw88: coex: update TDMA settings for different
 beacon interval
Thread-Index: AQHWt9GARAC8xlVteECrQVdFVsADCanCm0QOgAEp/VA=
Date:   Thu, 12 Nov 2020 02:23:06 +0000
Message-ID: <9fe8d921ef744cd3bb0f51bdc1f83ad8@realtek.com>
References: <20201111022108.9834-1-pkshih@realtek.com>
        <20201111022108.9834-2-pkshih@realtek.com>
 <875z6ccmwu.fsf@codeaurora.org>
In-Reply-To: <875z6ccmwu.fsf@codeaurora.org>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.21.69.213]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org



> -----Original Message-----
> From: kvalo=codeaurora.org@mg.codeaurora.org [mailto:kvalo=codeaurora.org@mg.codeaurora.org] On
> Behalf Of Kalle Valo
> Sent: Wednesday, November 11, 2020 4:34 PM
> To: Pkshih
> Cc: tony0620emma@gmail.com; linux-wireless@vger.kernel.org
> Subject: Re: [PATCH 01/11] rtw88: coex: update TDMA settings for different beacon interval
> 
> <pkshih@realtek.com> writes:
> 
> > From: Ching-Te Ku <ku920601@realtek.com>
> >
> > Add considering for different WLAN beacon interval in coexistence
> > mechanism.
> > Because the WLAN beacon period may be not 100 ms, so it's necessary
> > to consider any beacon period and set timer according to the interval.
> >
> > Signed-off-by: Ching-Te Ku <ku920601@realtek.com>
> > Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
> 
> [...]
> 
> > +	} else if (tbtt_interval < 80 && tbtt_interval > 0) {
> > +		para[1] = (100 / tbtt_interval);
> > +
> > +		if (100 % tbtt_interval != 0)
> > +			para[1] = para[1] + 1;
> > +
> > +		para[1] = para[1] & 0x3f;
> > +	} else if (tbtt_interval >= 180) {
> > +		para[1] = (tbtt_interval / 100);
> > +
> > +		if (tbtt_interval % 100 <= 80)
> > +			para[1] = para[1] - 1;
> > +
> > +		para[1] = para[1] & 0x3f;
> > +		para[1] = para[1] | 0x80;
> 
> Magic numbers 0x3f and 0x80, GENMASK() & FIELD_PREP() is the modern way
> to handle bitmasks like these. And there's also the operator '|='
> 

I'll give proper names and use suggested macros it in v2. Thank you.

---
Ping-Ke


