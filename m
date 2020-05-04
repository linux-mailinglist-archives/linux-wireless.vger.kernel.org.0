Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 122A51C34A3
	for <lists+linux-wireless@lfdr.de>; Mon,  4 May 2020 10:38:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728273AbgEDIi4 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 4 May 2020 04:38:56 -0400
Received: from rtits2.realtek.com ([211.75.126.72]:43859 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726445AbgEDIiz (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 4 May 2020 04:38:55 -0400
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.69 with qID 0448cePjB005287, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexmb06.realtek.com.tw[172.21.6.99])
        by rtits2.realtek.com.tw (8.15.2/2.66/5.86) with ESMTPS id 0448cePjB005287
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 4 May 2020 16:38:40 +0800
Received: from RTEXMB04.realtek.com.tw (172.21.6.97) by
 RTEXMB06.realtek.com.tw (172.21.6.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Mon, 4 May 2020 16:38:39 +0800
Received: from RTEXMB04.realtek.com.tw ([fe80::8001:f5f5:a41e:f8d4]) by
 RTEXMB04.realtek.com.tw ([fe80::8001:f5f5:a41e:f8d4%3]) with mapi id
 15.01.1779.005; Mon, 4 May 2020 16:38:39 +0800
From:   Tony Chuang <yhchuang@realtek.com>
To:     Kalle Valo <kvalo@codeaurora.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
CC:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        Pkshih <pkshih@realtek.com>
Subject: RE: [PATCH v3 5/8] rtw88: 8723d: 11N chips don't support LDPC
Thread-Topic: [PATCH v3 5/8] rtw88: 8723d: 11N chips don't support LDPC
Thread-Index: AQHWHgyQMqCUEkg1Tk2+cl6WpckpnaiQ+S4AgACXe8GABhHrIA==
Date:   Mon, 4 May 2020 08:38:39 +0000
Message-ID: <dac4c39d3f4648d6b018913f26644fe8@realtek.com>
References: <20200429095656.19315-1-yhchuang@realtek.com>
        <20200429095656.19315-6-yhchuang@realtek.com>
        <20200430105418.v3s5obb3skhv4732@linutronix.de>
 <877dxxkx0z.fsf@codeaurora.org>
In-Reply-To: <877dxxkx0z.fsf@codeaurora.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.21.68.175]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

> Sebastian Andrzej Siewior <bigeasy@linutronix.de> writes:
> 
> > On 2020-04-29 17:56:53 [+0800], yhchuang@realtek.com wrote:
> >> --- a/drivers/net/wireless/realtek/rtw88/main.c
> >> +++ b/drivers/net/wireless/realtek/rtw88/main.c
> >> @@ -933,7 +933,7 @@ static void rtw_init_ht_cap(struct rtw_dev
> *rtwdev,
> >>  	ht_cap->cap = 0;
> >>  	ht_cap->cap |= IEEE80211_HT_CAP_SGI_20 |
> >>  			IEEE80211_HT_CAP_MAX_AMSDU |
> >> -			IEEE80211_HT_CAP_LDPC_CODING |
> >> +			(rtw_chip_wcpu_11ac(rtwdev) ?
> IEEE80211_HT_CAP_LDPC_CODING : 0) |
> >>  			(1 << IEEE80211_HT_CAP_RX_STBC_SHIFT);
> >
> > What about
> >
> >  	ht_cap->cap = IEEE80211_HT_CAP_SGI_20 |
> >  			IEEE80211_HT_CAP_MAX_AMSDU |
> >  			(1 << IEEE80211_HT_CAP_RX_STBC_SHIFT);
> > 	if (rtw_chip_wcpu_11ac(rtwdev))
> > 			ht_cap->cap |= IEEE80211_HT_CAP_LDPC_CODING;
> > instead?
> 
> Yes, that's much better. I even missed the '?' operator in my own review
> as it was not that visible.
> 

Will fix that in v4, thanks.

Yen-Hsuan
