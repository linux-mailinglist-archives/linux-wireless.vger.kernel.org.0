Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4369215A3CD
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Feb 2020 09:48:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728698AbgBLIsH convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 12 Feb 2020 03:48:07 -0500
Received: from rtits2.realtek.com ([211.75.126.72]:48527 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728562AbgBLIsH (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 12 Feb 2020 03:48:07 -0500
Authenticated-By: 
X-SpamFilter-By: BOX Solutions SpamTrap 5.62 with qID 01C8lvQx021175, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (RTEXMB06.realtek.com.tw[172.21.6.99])
        by rtits2.realtek.com.tw (8.15.2/2.57/5.78) with ESMTPS id 01C8lvQx021175
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 12 Feb 2020 16:47:57 +0800
Received: from RTEXMB01.realtek.com.tw (172.21.6.94) by
 RTEXMB06.realtek.com.tw (172.21.6.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Wed, 12 Feb 2020 16:47:57 +0800
Received: from RTEXMB04.realtek.com.tw (172.21.6.97) by
 RTEXMB01.realtek.com.tw (172.21.6.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Wed, 12 Feb 2020 16:47:56 +0800
Received: from RTEXMB04.realtek.com.tw ([fe80::d9c5:a079:495e:b999]) by
 RTEXMB04.realtek.com.tw ([fe80::d9c5:a079:495e:b999%6]) with mapi id
 15.01.1779.005; Wed, 12 Feb 2020 16:47:56 +0800
From:   Tony Chuang <yhchuang@realtek.com>
To:     Kalle Valo <kvalo@codeaurora.org>
CC:     Chris Chiu <chiu@endlessm.com>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        Brian Norris <briannorris@chromium.org>,
        Andy Huang <tehuang@realtek.com>
Subject: RE: [PATCH v3 1/2] rtw88: add regulatory process strategy for different chipset
Thread-Topic: [PATCH v3 1/2] rtw88: add regulatory process strategy for
 different chipset
Thread-Index: AQHViMFAaPadjXgXtE6wjez3nesvPqdqOC0AgDbp6YCAALavM4B2Fwfw
Date:   Wed, 12 Feb 2020 08:47:56 +0000
Message-ID: <4cd295d1d1b143d7879050c3bb14bf97@realtek.com>
References: <20191022101229.26044-1-yhchuang@realtek.com>
        <20191022101229.26044-2-yhchuang@realtek.com>
        <CAB4CAwf9vanVf7JA5ZD52Yn-ngtEkA6S6YqhUZssXaLsHYio1w@mail.gmail.com>
        <f93341159e4342479e646e49ec2ab8d2@realtek.com>
 <0101016eb59d3246-c013abc9-4fbf-4825-9780-a85cff3f43d2-000000@us-west-2.amazonses.com>
In-Reply-To: <0101016eb59d3246-c013abc9-4fbf-4825-9780-a85cff3f43d2-000000@us-west-2.amazonses.com>
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

> Tony Chuang <yhchuang@realtek.com> writes:
> 
> >> -----Original Message-----
> >> From: Chris Chiu [mailto:chiu@endlessm.com]
> >> Sent: Friday, October 25, 2019 11:54 AM
> >> To: Tony Chuang
> >> Cc: Kalle Valo; linux-wireless; Brian Norris
> >> Subject: Re: [PATCH v3 1/2] rtw88: add regulatory process strategy for
> >> different chipset
> >>
> >> On Tue, Oct 22, 2019 at 6:12 PM <yhchuang@realtek.com> wrote:
> >> >
> >> > From: Tzu-En Huang <tehuang@realtek.com>
> >> >
> >> > There are two kinds of country/regulatory efuse settings
> >> > for Realtek's chipset, one is worldwide and the other is
> >> > a specific country. For both settings, REGULATORY_STRICT_REG
> >> > will be set, telling stack that devices original regulatory is
> >> > the superset of any further settings.
> >> >
> >> > For the chipset with the country setting being a specific
> >> > country, Realtek does not apply any new regulatory setting
> >> > notifiers to the card.
> >> >
> >> > For the chipset with a worldwide regulatory setting,
> >> > Realtek's custom worldwide regulatory setting will be
> >> > provided via wiphy_apply_custom_regulatory().
> >> > And if a new regulatory notification is set by
> >> > NL80211_REGDOM_SET_BY_COUNTRY_IE, the new setting will be
> >> > applied to the card.
> >> >
> >> > Signed-off-by: Tzu-En Huang <tehuang@realtek.com>
> >> > Signed-off-by: Yan-Hsuan Chuang <yhchuang@realtek.com>
> >> Reviewed-by: Chris Chiu <chiu@endlessm.com>
> >>
> >> Looks good to me.
> >>
> >> Chris
> >
> > Gentle ping of this patch set :)
> 
> This is on my queue. I just want to investigate this in detail and
> haven't found enough free time to do that.
> 

Is there anyone else wants to comment on it?
Appreciate if there's any suggestions.
Thanks!

Yan-Hsuan
