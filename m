Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 697D318F107
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Mar 2020 09:41:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727587AbgCWIlO convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 23 Mar 2020 04:41:14 -0400
Received: from rtits2.realtek.com ([211.75.126.72]:57544 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727477AbgCWIlO (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 23 Mar 2020 04:41:14 -0400
Authenticated-By: 
X-SpamFilter-By: BOX Solutions SpamTrap 5.62 with qID 02N8f6RW000592, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (RTEXMB06.realtek.com.tw[172.21.6.99])
        by rtits2.realtek.com.tw (8.15.2/2.57/5.78) with ESMTPS id 02N8f6RW000592
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 23 Mar 2020 16:41:06 +0800
Received: from RTEXDAG01.realtek.com.tw (172.21.6.100) by
 RTEXMB06.realtek.com.tw (172.21.6.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Mon, 23 Mar 2020 16:41:06 +0800
Received: from RTEXMB04.realtek.com.tw (172.21.6.97) by
 RTEXDAG01.realtek.com.tw (172.21.6.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Mon, 23 Mar 2020 16:41:06 +0800
Received: from RTEXMB04.realtek.com.tw ([fe80::d9c5:a079:495e:b999]) by
 RTEXMB04.realtek.com.tw ([fe80::d9c5:a079:495e:b999%6]) with mapi id
 15.01.1779.005; Mon, 23 Mar 2020 16:41:06 +0800
From:   Andy Huang <tehuang@realtek.com>
To:     Brian Norris <briannorris@chromium.org>,
        Tony Chuang <yhchuang@realtek.com>
CC:     "kvalo@codeaurora.org" <kvalo@codeaurora.org>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: [PATCH v5 1/2] rtw88: add regulatory process strategy for different chipset
Thread-Topic: [PATCH v5 1/2] rtw88: add regulatory process strategy for
 different chipset
Thread-Index: AQHV+OpgY5V9hxNNkkODhgd1sW65nKhRtBGAgAQw2LA=
Date:   Mon, 23 Mar 2020 08:41:05 +0000
Message-ID: <84a3e219774c48b5a976c0cb9392af51@realtek.com>
References: <20200313034918.22222-1-yhchuang@realtek.com>
 <20200313034918.22222-2-yhchuang@realtek.com>
 <20200321001645.GA16851@google.com>
In-Reply-To: <20200321001645.GA16851@google.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.21.69.231]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

> 
> Hi,
> 
> On Fri, Mar 13, 2020 at 11:49:17AM +0800, yhchuang@realtek.com wrote:
> > diff --git a/drivers/net/wireless/realtek/rtw88/main.c
> b/drivers/net/wireless/realtek/rtw88/main.c
> > index 2f73820cd9ba..635d9964beaa 100644
> > --- a/drivers/net/wireless/realtek/rtw88/main.c
> > +++ b/drivers/net/wireless/realtek/rtw88/main.c
> > @@ -1510,8 +1510,10 @@ int rtw_register_hw(struct rtw_dev *rtwdev,
> struct ieee80211_hw *hw)
> >  		return ret;
> >  	}
> >
> > -	if (regulatory_hint(hw->wiphy, rtwdev->regd.alpha2))
> > -		rtw_err(rtwdev, "regulatory_hint fail\n");
> > +	if (!rtwdev->efuse.country_worldwide) {
> > +		if (regulatory_hint(hw->wiphy, rtwdev->efuse.country_code))
> > +			rtw_err(rtwdev, "regulatory_hint fail\n");
>  Might as well log the error code, whlie you're at it?
> 
> > +	}
> >
> >  	rtw_debugfs_init(rtwdev);
> >
> 
> > diff --git a/drivers/net/wireless/realtek/rtw88/regd.c
> b/drivers/net/wireless/realtek/rtw88/regd.c
> > index 69744dd65968..500a02b97a9c 100644
> > --- a/drivers/net/wireless/realtek/rtw88/regd.c
> > +++ b/drivers/net/wireless/realtek/rtw88/regd.c
> > @@ -7,6 +7,18 @@
> >  #include "debug.h"
> >  #include "phy.h"
> >
> > +static const struct ieee80211_regdomain rtw88_world_regdom = {
> > +	.n_reg_rules = 5,
> > +	.alpha2 =  "99",
> > +	.reg_rules = {
> > +		REG_RULE(2412 - 10, 2462 + 10, 40, 0, 20, 0),
> > +		REG_RULE(2467 - 10, 2484 + 10, 40, 0, 20, NL80211_RRF_NO_IR),
> > +		REG_RULE(5180 - 10, 5240 + 10, 80, 0, 20, NL80211_RRF_NO_IR),
> > +		REG_RULE(5260 - 10, 5700 + 10, 80, 0, 20,
> > +			 NL80211_RRF_NO_IR | NL80211_RRF_DFS),
> > +		REG_RULE(5745 - 10, 5825 + 10, 80, 0, 20, NL80211_RRF_NO_IR),
> > +	}
> > +};
> 
> These rules look substantially identical to the default world rules
> specified in the standard regdb, except for the fact that you're missing
> the NO-ODFM part of this band:
> 
>         # Channel 14. Only JP enables this and for 802.11b only
>         (2474 - 2494 @ 20), (20), NO-IR, NO-OFDM
> 
> So, why do you need to specify a custom one?

It's because the channel plan from USER could be violated when connect
to an 802.11d AP, if we use the stack's worldwide. When the kernel scans,
some of the passive channels could become active, and then the stack will
intersect the channel plans because REGULATORY_STRICT_REG has been set.
If stack's worldwide is used, the result of intersecting will come out with a
channel plan that the passive channels became active. But if we use custom
worldwide, it won't happen, the passive channels will remain passive.

However, after our discussion, we think it's acceptable to follow 802.11d
setting and discard the USER setting, so we will send a fixed patch.

> 
> ...
> 
> >  static int rtw_regd_notifier_apply(struct rtw_dev *rtwdev,
> >  				   struct wiphy *wiphy,
> >  				   struct regulatory_request *request)
> >  {
> > -	if (request->initiator == NL80211_REGDOM_SET_BY_USER)
> > +	if (request->initiator == NL80211_REGDOM_SET_BY_DRIVER)
> > +		return -EINVAL;
> > +	if (request->initiator == NL80211_REGDOM_SET_BY_USER &&
> > +	    !IS_ENABLED(CONFIG_RTW88_REGD_USER_REG_HINTS))
> > +		return -EINVAL;
> > +	if (request->initiator == NL80211_REGDOM_SET_BY_COUNTRY_IE &&
> > +	    !rtw_regd_is_ww(&rtwdev->regd))
> > +		return -EINVAL;
> > +	if (request->initiator == NL80211_REGDOM_SET_BY_CORE &&
> > +	    !rtwdev->efuse.country_worldwide) {
> > +		rtwdev->regd =
> > +			rtw_regd_find_reg_by_name(rtwdev->efuse.country_code);
> >  		return 0;
> > +	}
> 
> None of these errors actually go anywhere; if you were planning to
> ignore these, shouldn't they be surfaced somewhere? Or can't these be
> encoded in your regulatory policy instead? Like
> REGULATORY_COUNTRY_IE_IGNORE, for one.
> 
> And as with your WOWLAN implementation: if there's no way to surface
> errors, you should at least log something.

We'll fix it.

Tzu-En

> 
> Brian
> 
> >  	rtwdev->regd = rtw_regd_find_reg_by_name(request->alpha2);
> >  	rtw_regd_apply_world_flags(wiphy, request->initiator);
> >
> 
> 
