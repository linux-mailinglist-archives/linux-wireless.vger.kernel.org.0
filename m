Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCDFC36BF3A
	for <lists+linux-wireless@lfdr.de>; Tue, 27 Apr 2021 08:25:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229977AbhD0G0T (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 27 Apr 2021 02:26:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:37774 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229578AbhD0G0T (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 27 Apr 2021 02:26:19 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 11F85613BF;
        Tue, 27 Apr 2021 06:25:35 +0000 (UTC)
Date:   Tue, 27 Apr 2021 08:25:31 +0200
From:   Greg KH <greg@kroah.com>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless@vger.kernel.org, linux-staging@lists.linux.dev,
        Harald Arnesen <harald@skogtun.org>,
        Johannes Berg <johannes.berg@intel.com>
Subject: Re: [PATCH] staging: rtl8723bs: fix monitor netdev
 register/unregister
Message-ID: <YIeuW57v5/qPwlzY@kroah.com>
References: <20210426212801.3d902cc9e6f4.Ie0b1e0c545920c61400a4b7d0f384ea61feb645a@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210426212801.3d902cc9e6f4.Ie0b1e0c545920c61400a4b7d0f384ea61feb645a@changeid>
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Mon, Apr 26, 2021 at 09:28:02PM +0200, Johannes Berg wrote:
> From: Johannes Berg <johannes.berg@intel.com>
> 
> Due to the locking changes and callbacks happening inside
> cfg80211, we need to use cfg80211 versions of the register
> and unregister functions if called within cfg80211 methods,
> otherwise deadlocks occur.
> 
> Fixes: a05829a7222e ("cfg80211: avoid holding the RTNL when calling the driver")
> Signed-off-by: Johannes Berg <johannes.berg@intel.com>
> ---
>  drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c b/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c
> index ff164a8c8679..0619a7510e83 100644
> --- a/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c
> +++ b/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c
> @@ -2579,7 +2579,7 @@ static int rtw_cfg80211_add_monitor_if(struct adapter *padapter, char *name, str
>  	mon_wdev->iftype = NL80211_IFTYPE_MONITOR;
>  	mon_ndev->ieee80211_ptr = mon_wdev;
>  
> -	ret = register_netdevice(mon_ndev);
> +	ret = cfg80211_register_netdevice(mon_ndev);

Is this now a requirement for all wireless drivers?

If so, do other drivers/staging/ drivers need to also be fixed up?

I'm guessing this will be going through the wireless tree, so:

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

thanks,

greg k-h
