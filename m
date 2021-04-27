Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40A1D36C13D
	for <lists+linux-wireless@lfdr.de>; Tue, 27 Apr 2021 10:54:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230325AbhD0Iyp (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 27 Apr 2021 04:54:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbhD0Iyo (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 27 Apr 2021 04:54:44 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 004F5C061574
        for <linux-wireless@vger.kernel.org>; Tue, 27 Apr 2021 01:54:01 -0700 (PDT)
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.94)
        (envelope-from <johannes@sipsolutions.net>)
        id 1lbJTk-000d6L-09; Tue, 27 Apr 2021 10:54:00 +0200
Message-ID: <aad26597fc709dd67bf010b60590120148bc16c6.camel@sipsolutions.net>
Subject: Re: [PATCH] staging: rtl8723bs: fix monitor netdev
 register/unregister
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Greg KH <greg@kroah.com>
Cc:     linux-wireless@vger.kernel.org, linux-staging@lists.linux.dev,
        Harald Arnesen <harald@skogtun.org>
Date:   Tue, 27 Apr 2021 10:53:58 +0200
In-Reply-To: <YIeuW57v5/qPwlzY@kroah.com>
References: <20210426212801.3d902cc9e6f4.Ie0b1e0c545920c61400a4b7d0f384ea61feb645a@changeid>
         <YIeuW57v5/qPwlzY@kroah.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.4 (3.38.4-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-malware-bazaar: not-scanned
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Tue, 2021-04-27 at 08:25 +0200, Greg KH wrote:
> 
> > +++ b/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c
> > @@ -2579,7 +2579,7 @@ static int rtw_cfg80211_add_monitor_if(struct adapter *padapter, char *name, str
> >  	mon_wdev->iftype = NL80211_IFTYPE_MONITOR;
> >  	mon_ndev->ieee80211_ptr = mon_wdev;
> > 
> > -	ret = register_netdevice(mon_ndev);
> > +	ret = cfg80211_register_netdevice(mon_ndev);
> 
> Is this now a requirement for all wireless drivers?

Yes and no. It must only be called from within a "please add an
interface" method. Otherwise, register_netdevice() must still be called.

> If so, do other drivers/staging/ drivers need to also be fixed up?

Not as far as I can tell, this is the only wireless staging driver that
even calls register_netdevice(). Not sure why I missed this, I had
audited all of those calls across the tree. But looking a second time
always shows more I guess, sorry about that.

There's another call to register_netdevice() here but I don't think
that's affected, however, it's obviously utterly broken in the first
place:

        if (!rtnl_is_locked())
                unregister_netdev(cur_pnetdev);
        else
                unregister_netdevice(cur_pnetdev);

*sigh*.

> I'm guessing this will be going through the wireless tree, so:
> 
> Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

I don't care much, since unfortunately it's already too late and the
breakage is released in 5.12. I'll pick it up through my tree since I
broke it (and probably should add a Cc stable tag.)

johannes

