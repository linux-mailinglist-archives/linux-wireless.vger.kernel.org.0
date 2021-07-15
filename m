Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 815863C96C9
	for <lists+linux-wireless@lfdr.de>; Thu, 15 Jul 2021 05:59:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231436AbhGOECq (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 15 Jul 2021 00:02:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbhGOECp (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 15 Jul 2021 00:02:45 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 695C3C06175F
        for <linux-wireless@vger.kernel.org>; Wed, 14 Jul 2021 20:59:53 -0700 (PDT)
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1m3sXL-0002Rc-Ru; Thu, 15 Jul 2021 05:59:47 +0200
Received: from ore by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ore@pengutronix.de>)
        id 1m3sXK-0005EO-SP; Thu, 15 Jul 2021 05:59:46 +0200
Date:   Thu, 15 Jul 2021 05:59:46 +0200
From:   Oleksij Rempel <o.rempel@pengutronix.de>
To:     Pkshih <pkshih@realtek.com>
Cc:     "kvalo@codeaurora.org" <kvalo@codeaurora.org>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH 14/24] rtw89: 8852a: add 8852a RFK files
Message-ID: <20210715035946.7l4gldk32mdcahk4@pengutronix.de>
References: <20210618064625.14131-1-pkshih@realtek.com>
 <20210618064625.14131-15-pkshih@realtek.com>
 <20210709174112.GC2099@pengutronix.de>
 <b752f356a4ee482ca21db867dc7254b2@realtek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <b752f356a4ee482ca21db867dc7254b2@realtek.com>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-IRC:  #ptxdist @freenode
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-Uptime: 05:59:23 up 224 days, 18:05, 35 users,  load average: 0.00, 0.03,
 0.00
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-wireless@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Thu, Jul 15, 2021 at 03:33:47AM +0000, Pkshih wrote:
> 
> > -----Original Message-----
> > From: Pkshih
> > Sent: Monday, July 12, 2021 2:24 PM
> > To: 'Oleksij Rempel'
> > Cc: kvalo@codeaurora.org; linux-wireless@vger.kernel.org
> > Subject: RE: [PATCH 14/24] rtw89: 8852a: add 8852a RFK files
> > 
> 
> [...]
> 
> > 
> > > > +	rtw89_debug(rtwdev, RTW89_DBG_TSSI, "[TSSI] %s: phy=%d\n",
> > > > +		    __func__, phy);
> > > > +
> > > > +	if (!rtwdev->is_tssi_mode[RF_PATH_A])
> > > > +		return;
> > > > +	if (!rtwdev->is_tssi_mode[RF_PATH_B])
> > > > +		return;
> > > > +
> > > > +	_tssi_disable(rtwdev, phy);
> > > > +
> > > > +	for (i = RF_PATH_A; i < RF_PATH_NUM_8852A; i++) {
> > > > +		_tssi_rf_setting(rtwdev, phy, i);
> > > > +		_tssi_set_sys(rtwdev, phy);
> > > > +		_tssi_set_tmeter_tbl(rtwdev, phy, i);
> > > > +		_tssi_pak(rtwdev, phy, i);
> > > > +	}
> > > > +
> > > > +	_tssi_enable(rtwdev, phy);
> > > > +	_tssi_set_efuse_to_de(rtwdev, phy);
> > > > +}
> > > > +
> > > > +void rtw8852a_tssi_track(struct rtw89_dev *rtwdev)
> > > > +{
> > > > +	_tssi_track(rtwdev);
> > > > +}
> > >
> > > rtw8852a_tssi_track() is not used
> > >
> > 
> > I'll check TSSI owner.
> > Will remove it if we don't need it, or call it if necessary.
> > 
> 
> I have confirmed with TSSI owner; we'll call it from rtw8852a_rfk_track().
> Thanks for the catch.

Sounds good :)

Regards,
Oleksij
-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
