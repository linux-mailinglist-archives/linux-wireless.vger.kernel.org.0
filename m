Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BEA1736C16E
	for <lists+linux-wireless@lfdr.de>; Tue, 27 Apr 2021 11:03:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235144AbhD0JET (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 27 Apr 2021 05:04:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:53934 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235133AbhD0JES (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 27 Apr 2021 05:04:18 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8944761107;
        Tue, 27 Apr 2021 09:03:34 +0000 (UTC)
Date:   Tue, 27 Apr 2021 11:03:32 +0200
From:   Greg KH <greg@kroah.com>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless@vger.kernel.org, linux-staging@lists.linux.dev,
        Harald Arnesen <harald@skogtun.org>
Subject: Re: [PATCH] staging: rtl8723bs: fix monitor netdev
 register/unregister
Message-ID: <YIfTZKtMcMAB2e4k@kroah.com>
References: <20210426212801.3d902cc9e6f4.Ie0b1e0c545920c61400a4b7d0f384ea61feb645a@changeid>
 <YIeuW57v5/qPwlzY@kroah.com>
 <aad26597fc709dd67bf010b60590120148bc16c6.camel@sipsolutions.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aad26597fc709dd67bf010b60590120148bc16c6.camel@sipsolutions.net>
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Tue, Apr 27, 2021 at 10:53:58AM +0200, Johannes Berg wrote:
> On Tue, 2021-04-27 at 08:25 +0200, Greg KH wrote:
> > 
> > > +++ b/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c
> > > @@ -2579,7 +2579,7 @@ static int rtw_cfg80211_add_monitor_if(struct adapter *padapter, char *name, str
> > >  	mon_wdev->iftype = NL80211_IFTYPE_MONITOR;
> > >  	mon_ndev->ieee80211_ptr = mon_wdev;
> > > 
> > > -	ret = register_netdevice(mon_ndev);
> > > +	ret = cfg80211_register_netdevice(mon_ndev);
> > 
> > Is this now a requirement for all wireless drivers?
> 
> Yes and no. It must only be called from within a "please add an
> interface" method. Otherwise, register_netdevice() must still be called.
> 
> > If so, do other drivers/staging/ drivers need to also be fixed up?
> 
> Not as far as I can tell, this is the only wireless staging driver that
> even calls register_netdevice(). Not sure why I missed this, I had
> audited all of those calls across the tree. But looking a second time
> always shows more I guess, sorry about that.
> 
> There's another call to register_netdevice() here but I don't think
> that's affected, however, it's obviously utterly broken in the first
> place:
> 
>         if (!rtnl_is_locked())
>                 unregister_netdev(cur_pnetdev);
>         else
>                 unregister_netdevice(cur_pnetdev);
> 
> *sigh*.

Sorry, these staging wireless drivers are really getting annoying.
Maybe I need to turn an intern onto them to just get them fixed up and
out of here to be a 'real' driver.

> > I'm guessing this will be going through the wireless tree, so:
> > 
> > Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> 
> I don't care much, since unfortunately it's already too late and the
> breakage is released in 5.12. I'll pick it up through my tree since I
> broke it (and probably should add a Cc stable tag.)

Great, thanks for taking it that way and doing this fix, much
appreciated.

greg k-h
