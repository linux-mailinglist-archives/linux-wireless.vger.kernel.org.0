Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3FB0C1BD577
	for <lists+linux-wireless@lfdr.de>; Wed, 29 Apr 2020 09:13:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726478AbgD2HNa convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 29 Apr 2020 03:13:30 -0400
Received: from rtits2.realtek.com ([211.75.126.72]:39014 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726366AbgD2HNa (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 29 Apr 2020 03:13:30 -0400
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.69 with qID 03T7DMQc8005035, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexmb06.realtek.com.tw[172.21.6.99])
        by rtits2.realtek.com.tw (8.15.2/2.66/5.86) with ESMTPS id 03T7DMQc8005035
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 29 Apr 2020 15:13:22 +0800
Received: from RTEXMB01.realtek.com.tw (172.21.6.94) by
 RTEXMB06.realtek.com.tw (172.21.6.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Wed, 29 Apr 2020 15:13:22 +0800
Received: from RTEXMB04.realtek.com.tw (172.21.6.97) by
 RTEXMB01.realtek.com.tw (172.21.6.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Wed, 29 Apr 2020 15:13:21 +0800
Received: from RTEXMB04.realtek.com.tw ([fe80::8001:f5f5:a41e:f8d4]) by
 RTEXMB04.realtek.com.tw ([fe80::8001:f5f5:a41e:f8d4%3]) with mapi id
 15.01.1779.005; Wed, 29 Apr 2020 15:13:21 +0800
From:   Tony Chuang <yhchuang@realtek.com>
To:     Kalle Valo <kvalo@codeaurora.org>
CC:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        Pkshih <pkshih@realtek.com>
Subject: RE: [PATCH v2 3/8] rtw88: 8723d: Add set_channel
Thread-Topic: [PATCH v2 3/8] rtw88: 8723d: Add set_channel
Thread-Index: AQHWGWr/SzzM/n2vAkSP4sbUz4c2yqiMeo3kgAM9ltA=
Date:   Wed, 29 Apr 2020 07:13:21 +0000
Message-ID: <1238dd4f76f04646b0321de9ff1ef4e1@realtek.com>
References: <20200423123022.10176-1-yhchuang@realtek.com>
        <20200423123022.10176-4-yhchuang@realtek.com>
 <87sggpiiwe.fsf@tynnyri.adurom.net>
In-Reply-To: <87sggpiiwe.fsf@tynnyri.adurom.net>
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

Kalle Valo <kvalo@codeaurora.org> writes:

> <yhchuang@realtek.com> writes:
> 
> > From: Ping-Ke Shih <pkshih@realtek.com>
> >
> > Set MAC/BB/RF register according to specified channel. The function
> > rtw_set_channel_mac() is used to set MAC registers, but 8723D only need
> > some of them.
> >
> > For channel 14, we need to set different CCK DFIR values, so restore the
> > values when channel 1 to 13 is selected.
> >
> > Spur calibration is needed in channel 13 and 14, and we do notch if spur
> > is over threshold.
> >
> > Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
> > Signed-off-by: Yan-Hsuan Chuang <yhchuang@realtek.com>
> 
> [...]
> 
> > --- a/drivers/net/wireless/realtek/rtw88/rtw8723d.c
> > +++ b/drivers/net/wireless/realtek/rtw88/rtw8723d.c
> > @@ -287,6 +287,190 @@ static void rtw8723d_query_rx_desc(struct
> rtw_dev *rtwdev, u8 *rx_desc,
> >  	rtw_rx_fill_rx_status(rtwdev, pkt_stat, hdr, rx_status, phy_status);
> >  }
> >
> > +static
> > +bool rtw8723d_check_spur_ov_thres(struct rtw_dev *rtwdev, u8 channel,
> u32 thres)
> > +{
> > +#define DIS_3WIRE	0xccf000c0
> > +#define EN_3WIRE	0xccc000c0
> > +#define START_PSD	0x400000
> > +#define FREQ_CH13	0xFCCD
> > +#define FREQ_CH14	0xFF9A
> 
> Why this style of adding defines within a function? You use it in
> multiple functions in this patch.
> 
> The normal upstream style is to have these kind of values defined in a
> .h file somewhere.
> 

Thought they are used just for the function, but yes, should put them
into rtw8723d.h or something like that :)

Yen-Hsuan
