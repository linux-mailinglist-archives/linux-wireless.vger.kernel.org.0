Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF7242208C1
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Jul 2020 11:29:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729850AbgGOJ36 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 15 Jul 2020 05:29:58 -0400
Received: from rtits2.realtek.com ([211.75.126.72]:36674 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728030AbgGOJ36 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 15 Jul 2020 05:29:58 -0400
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.69 with qID 06F9TbatE031502, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexmb06.realtek.com.tw[172.21.6.99])
        by rtits2.realtek.com.tw (8.15.2/2.66/5.86) with ESMTPS id 06F9TbatE031502
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 15 Jul 2020 17:29:37 +0800
Received: from RTEXDAG02.realtek.com.tw (172.21.6.101) by
 RTEXMB06.realtek.com.tw (172.21.6.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Wed, 15 Jul 2020 17:29:37 +0800
Received: from RTEXMB04.realtek.com.tw (172.21.6.97) by
 RTEXDAG02.realtek.com.tw (172.21.6.101) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Wed, 15 Jul 2020 17:29:37 +0800
Received: from RTEXMB04.realtek.com.tw ([fe80::941:6388:7d34:5c44]) by
 RTEXMB04.realtek.com.tw ([fe80::941:6388:7d34:5c44%3]) with mapi id
 15.01.1779.005; Wed, 15 Jul 2020 17:29:36 +0800
From:   Tony Chuang <yhchuang@realtek.com>
To:     Kalle Valo <kvalo@codeaurora.org>
CC:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "Andy Huang" <tehuang@realtek.com>,
        "bigeasy@linutronix.de" <bigeasy@linutronix.de>
Subject: RE: [PATCH v2 1/5] rtw88: 8821c: add cck pd settings
Thread-Topic: [PATCH v2 1/5] rtw88: 8821c: add cck pd settings
Thread-Index: AQHWOYtRD71I+Ahoxkq6+QOyVgHuQakIlweHgAAKoiA=
Date:   Wed, 15 Jul 2020 09:29:36 +0000
Message-ID: <ca638be51df9459e85d7e6b65082a56b@realtek.com>
References: <20200603094218.19942-1-yhchuang@realtek.com>
        <20200603094218.19942-2-yhchuang@realtek.com>
 <87r1tdb1qw.fsf@tynnyri.adurom.net>
In-Reply-To: <87r1tdb1qw.fsf@tynnyri.adurom.net>
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

> <yhchuang@realtek.com> writes:
> 
> > From: Tzu-En Huang <tehuang@realtek.com>
> >
> > CCK PD can reduce the number of false alarm of the CCK rates.
> > It dynamically adjusts the power threshold and CS ratio.
> > The values are compared to the values of the previous level, if
> > the level is changed, set new values of power threshold and CS
> > ratio.
> >
> > Implement rtw_chip_ops::cck_pd_set() for 8821c.
> >
> > Signed-off-by: Tzu-En Huang <tehuang@realtek.com>
> > Signed-off-by: Yan-Hsuan Chuang <yhchuang@realtek.com>
> 
> [...]
> 
> > --- a/drivers/net/wireless/realtek/rtw88/rtw8821c.c
> > +++ b/drivers/net/wireless/realtek/rtw88/rtw8821c.c
> > @@ -102,6 +102,7 @@ static void rtw8821c_phy_set_param(struct rtw_dev
> *rtwdev)
> >  	rtwdev->chip->ch_param[2] = rtw_read32_mask(rtwdev, REG_TXFILTER,
> MASKDWORD);
> >
> >  	rtw_phy_init(rtwdev);
> > +	rtwdev->dm_info.cck_pd_default = rtw_read8(rtwdev, REG_CSRATIO) &
> 0x1f;
> >  }
> >
> >  static int rtw8821c_mac_init(struct rtw_dev *rtwdev)
> > @@ -596,6 +597,29 @@ static void rtw8821c_phy_calibration(struct
> rtw_dev *rtwdev)
> >  	rtw8821c_do_iqk(rtwdev);
> >  }
> >
> > +static void rtw8821c_phy_cck_pd_set(struct rtw_dev *rtwdev, u8 new_lvl)
> > +{
> > +	struct rtw_dm_info *dm_info = &rtwdev->dm_info;
> > +	u8 pd[CCK_PD_LV_MAX] = {3, 7, 13, 13, 13};
> > +
> > +	if (dm_info->min_rssi > 60) {
> > +		new_lvl = 4;
> > +		pd[4] = 0x1d;
> > +		goto set_cck_pd;
> > +	}
> > +
> > +	if (dm_info->cck_pd_lv[RTW_CHANNEL_WIDTH_20][RF_PATH_A] ==
> new_lvl)
> > +		return;
> > +
> > +	dm_info->cck_fa_avg = CCK_FA_AVG_RESET;
> > +
> > +set_cck_pd:
> > +	dm_info->cck_pd_lv[RTW_CHANNEL_WIDTH_20][RF_PATH_A] = new_lvl;
> > +	rtw_write32_mask(rtwdev, REG_PWRTH, 0x3f0000, pd[new_lvl]);
> > +	rtw_write32_mask(rtwdev, REG_PWRTH2, 0x1f0000,
> > +			 dm_info->cck_pd_default + new_lvl * 2);
> > +}
> 
> I'm starting to see the trend of using magic values in rtw88 on the rise
> again. Please be careful with this, the source code should not be full
> of undocument values. In some special cases (eg calibration data etc)
> using undocumented values is ok, but most of cases should have proper
> defines for documenting what's happening.
> 

I'll take care of that, many thanks.

Yen-Hsuan
