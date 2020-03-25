Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F2BE6191F90
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Mar 2020 04:11:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727275AbgCYDLk convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 24 Mar 2020 23:11:40 -0400
Received: from rtits2.realtek.com ([211.75.126.72]:52167 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727253AbgCYDLk (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 24 Mar 2020 23:11:40 -0400
Authenticated-By: 
X-SpamFilter-By: BOX Solutions SpamTrap 5.62 with qID 02P3BWYm015188, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (RTEXMB06.realtek.com.tw[172.21.6.99])
        by rtits2.realtek.com.tw (8.15.2/2.57/5.78) with ESMTPS id 02P3BWYm015188
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 25 Mar 2020 11:11:33 +0800
Received: from RTEXMB04.realtek.com.tw (172.21.6.97) by
 RTEXMB06.realtek.com.tw (172.21.6.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Wed, 25 Mar 2020 11:11:32 +0800
Received: from RTEXMB04.realtek.com.tw ([fe80::d9c5:a079:495e:b999]) by
 RTEXMB04.realtek.com.tw ([fe80::d9c5:a079:495e:b999%6]) with mapi id
 15.01.1779.005; Wed, 25 Mar 2020 11:11:32 +0800
From:   Andy Huang <tehuang@realtek.com>
To:     Brian Norris <briannorris@chromium.org>,
        Tony Chuang <yhchuang@realtek.com>
CC:     "kvalo@codeaurora.org" <kvalo@codeaurora.org>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: [PATCH v6 1/2] rtw88: add regulatory process strategy for different chipset
Thread-Topic: [PATCH v6 1/2] rtw88: add regulatory process strategy for
 different chipset
Thread-Index: AQHWAbEl1VdHuwtD6ECbbBug2CjJDahXb1KAgAEZeTA=
Date:   Wed, 25 Mar 2020 03:11:32 +0000
Message-ID: <c17c6e7243e642679a38854e6e6cda96@realtek.com>
References: <20200324075216.22553-1-yhchuang@realtek.com>
 <20200324075216.22553-2-yhchuang@realtek.com>
 <20200324165105.GA99185@google.com>
In-Reply-To: <20200324165105.GA99185@google.com>
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
> On Tue, Mar 24, 2020 at 03:52:15PM +0800, yhchuang@realtek.com wrote:
> > --- a/drivers/net/wireless/realtek/rtw88/Kconfig
> > +++ b/drivers/net/wireless/realtek/rtw88/Kconfig
> > @@ -52,4 +52,14 @@ config RTW88_DEBUGFS
> >
> >  	  If unsure, say Y to simplify debug problems
> >
> > +config RTW88_REGD_USER_REG_HINTS
> > +	bool "Realtek rtw88 user regulatory hints"
> > +	depends on RTW88_CORE
> > +	default n
> > +	help
> > +	  Enable regulatoy user hints
> > +
> > +	  If unsure, say N. This should only be allowed on distributions
> > +	  that need this to correct the regulatory.
> > +
> 
> I'm still not sure why rtw88 needs this, and nobody else does. I read 

I think in Atheros driver, ATH_REG_DYNAMIC_USER_REG_HINTS config serves
the same purpose.

> your commit message, but that doesn't sound like something that belongs
> in a single driver still.
> 

As our previous commit message claims, it is due to FCC publication 594280
statement, "In particular, users must not be relied on to set a country code or
location code to ensure compliance".

> >  endif
> > diff --git a/drivers/net/wireless/realtek/rtw88/main.c
> b/drivers/net/wireless/realtek/rtw88/main.c
> > index 7640e97706f5..5d43bef91a3c 100644
> > --- a/drivers/net/wireless/realtek/rtw88/main.c
> > +++ b/drivers/net/wireless/realtek/rtw88/main.c
> > @@ -1501,8 +1501,9 @@ int rtw_register_hw(struct rtw_dev *rtwdev,
> struct ieee80211_hw *hw)
> >  		return ret;
> >  	}
> >
> > -	if (regulatory_hint(hw->wiphy, rtwdev->regd.alpha2))
> > -		rtw_err(rtwdev, "regulatory_hint fail\n");
> > +	ret = regulatory_hint(hw->wiphy, rtwdev->efuse.country_code);
> > +	if (ret)
> > +		rtw_warn(rtwdev, "failed to hint regulatory: %d\n", ret);
> 
> I don't think this is what you want; you had it right in previous
> revisions:
> 
> 	if (!rtwdev->efuse.country_worldwide) {
> 		if (regulatory_hint(hw->wiphy, rtwdev->efuse.country_code))
> 			rtw_err( ... );
> 	}
> 
> Without the 'country_worlwide' check, you start "hinting" (even on
> worldwide chips) that you really wanted "country" 00 only, and so we
> *never* adapt to more strict country settings. That's not how world-wide
> settings are supposed to work.
> 

It doesn't mean that we want country 00 only, we will get country notifies
from stack, and we will apply it if we accept it. We don't want stack to change
the channel plan for us.
And this is also related to RTW88_REGD_USER_REG_HINTS config, since we
do not want stack to change the channel plan set from user space without
this config.

> >
> >  	rtw_debugfs_init(rtwdev);
> >
> > diff --git a/drivers/net/wireless/realtek/rtw88/regd.c
> b/drivers/net/wireless/realtek/rtw88/regd.c
> > index 69744dd65968..4cc1234bfb9a 100644
> > --- a/drivers/net/wireless/realtek/rtw88/regd.c
> > +++ b/drivers/net/wireless/realtek/rtw88/regd.c
> >  static int rtw_regd_notifier_apply(struct rtw_dev *rtwdev,
> >  				   struct wiphy *wiphy,
> >  				   struct regulatory_request *request)
> >  {
> > -	if (request->initiator == NL80211_REGDOM_SET_BY_USER)
> > +	if (request->initiator == NL80211_REGDOM_SET_BY_DRIVER)
> 
> Why are you ignoring SET_BY_DRIVER? That's what happens when (a few
> lines up) you call regulatory_hint(). At a minimum, that doesn't deserve
> a loud error print when we "fail" this function -- you should handle it
> properly.
> 
> Brian

Since the notification with NL80211_REGDOM_SET_BY_DRIVER flag might
comes from an another chipset's regulatory_hint().

Tzu-En

> 
> > +		return -ENOTSUPP;
> > +
> > +	if (request->initiator == NL80211_REGDOM_SET_BY_USER &&
> > +	    !IS_ENABLED(CONFIG_RTW88_REGD_USER_REG_HINTS))
> > +		return -EPERM;
> > +
> > +	if (request->initiator == NL80211_REGDOM_SET_BY_CORE) {
> > +		char *country_code;
> > +
> > +		/* return to the efuse setting */
> > +		country_code = rtwdev->efuse.country_code;
> > +		rtwdev->regd = rtw_regd_find_reg_by_name(country_code);
> >  		return 0;
> > +	}
> > +
> >  	rtwdev->regd = rtw_regd_find_reg_by_name(request->alpha2);
> >  	rtw_regd_apply_world_flags(wiphy, request->initiator);
> >
> 
> ------Please consider the environment before printing this e-mail.
