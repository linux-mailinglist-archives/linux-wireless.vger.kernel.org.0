Return-Path: <linux-wireless+bounces-12701-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF3F9972389
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Sep 2024 22:21:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6D456B22389
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Sep 2024 20:21:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFFB818C31;
	Mon,  9 Sep 2024 20:21:47 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D21717C9F6
	for <linux-wireless@vger.kernel.org>; Mon,  9 Sep 2024 20:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725913307; cv=none; b=QUSnGY3lEbIwM8QU/tzQUk26uYHCsOweCR/9ZSEFkGzjizZK8T6Ig5MTyBOs6/WBcr58PMyvSnKsAG0LEwonJ37wxLSnD10avF7AHQq2qXPDyLf6PDb7G27UP0spxEv7v3+sr6FmkqXcBf6zjAm5E8h/KuwzeYTlVzNX/nOSb3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725913307; c=relaxed/simple;
	bh=pEcSv5TEJSjaS/fkoKMzRHtpJ3SH1Vlx2aomcgik2Pk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r7MJU65T0xjsrHevn2VHhtfWjLvr6sFRgKoUmuT7NtDjwbgAg0GXg9LRDyg4AB9A7qcLPQDKkIZ3QX80DW0UXOeYmR09WXyYthvHGpGU6guVeFqPaFP5XOTiFU3KUUfpXWOlyiuJo91FbIoB+HO89+GR7fxUZ/isCioYlEWqthc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <sha@pengutronix.de>)
	id 1snktK-0001hO-Ai; Mon, 09 Sep 2024 22:21:42 +0200
Received: from [2a0a:edc0:2:b01:1d::c5] (helo=pty.whiteo.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <sha@pengutronix.de>)
	id 1snktJ-006jbb-SO; Mon, 09 Sep 2024 22:21:41 +0200
Received: from sha by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <sha@pengutronix.de>)
	id 1snktJ-00FoMH-2V;
	Mon, 09 Sep 2024 22:21:41 +0200
Date: Mon, 9 Sep 2024 22:21:41 +0200
From: Sascha Hauer <s.hauer@pengutronix.de>
To: Francesco Dolcini <francesco@dolcini.it>
Cc: Brian Norris <briannorris@chromium.org>, Kalle Valo <kvalo@kernel.org>,
	linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 11/12] wifi: mwifiex: move common settings out of
 switch/case
Message-ID: <Zt9Y1fe-Q9cHY_s5@pengutronix.de>
References: <20240826-mwifiex-cleanup-1-v1-0-56e6f8e056ec@pengutronix.de>
 <20240826-mwifiex-cleanup-1-v1-11-56e6f8e056ec@pengutronix.de>
 <Zt8rv-nOERIac4T9@gaggiata.pivistrello.it>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zt8rv-nOERIac4T9@gaggiata.pivistrello.it>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: sha@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-wireless@vger.kernel.org

On Mon, Sep 09, 2024 at 07:09:19PM +0200, Francesco Dolcini wrote:
> On Mon, Aug 26, 2024 at 01:01:32PM +0200, Sascha Hauer wrote:
> > In mwifiex_add_virtual_intf() several settings done in a switch/case
> > are the same in all cases. Move them out of the switch/case to
> > deduplicate the code.
> > 
> > Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> > ---
> >  drivers/net/wireless/marvell/mwifiex/cfg80211.c | 16 +++++-----------
> >  1 file changed, 5 insertions(+), 11 deletions(-)
> > 
> > diff --git a/drivers/net/wireless/marvell/mwifiex/cfg80211.c b/drivers/net/wireless/marvell/mwifiex/cfg80211.c
> > index 8746943c17788..2ce54a3fc32f8 100644
> > --- a/drivers/net/wireless/marvell/mwifiex/cfg80211.c
> > +++ b/drivers/net/wireless/marvell/mwifiex/cfg80211.c
> > @@ -3005,7 +3005,6 @@ struct wireless_dev *mwifiex_add_virtual_intf(struct wiphy *wiphy,
> >  			return ERR_PTR(-EFAULT);
> >  		}
> >  
> > -		priv->wdev.wiphy = wiphy;
> >  		priv->wdev.iftype = NL80211_IFTYPE_STATION;
> >  
> >  		if (type == NL80211_IFTYPE_UNSPECIFIED)
> > @@ -3014,8 +3013,6 @@ struct wireless_dev *mwifiex_add_virtual_intf(struct wiphy *wiphy,
> >  			priv->bss_mode = type;
> >  
> >  		priv->bss_type = MWIFIEX_BSS_TYPE_STA;
> > -		priv->frame_type = MWIFIEX_DATA_FRAME_TYPE_ETH_II;
> > -		priv->bss_priority = 0;
> >  		priv->bss_role = MWIFIEX_BSS_ROLE_STA;
> >  
> >  		break;
> > @@ -3035,14 +3032,10 @@ struct wireless_dev *mwifiex_add_virtual_intf(struct wiphy *wiphy,
> >  			return ERR_PTR(-EFAULT);
> >  		}
> >  
> > -		priv->wdev.wiphy = wiphy;
> >  		priv->wdev.iftype = NL80211_IFTYPE_AP;
> >  
> >  		priv->bss_type = MWIFIEX_BSS_TYPE_UAP;
> > -		priv->frame_type = MWIFIEX_DATA_FRAME_TYPE_ETH_II;
> > -		priv->bss_priority = 0;
> >  		priv->bss_role = MWIFIEX_BSS_ROLE_UAP;
> > -		priv->bss_started = 0;
> >  		priv->bss_mode = type;
> >  
> >  		break;
> > @@ -3062,7 +3055,6 @@ struct wireless_dev *mwifiex_add_virtual_intf(struct wiphy *wiphy,
> >  			return ERR_PTR(-EFAULT);
> >  		}
> >  
> > -		priv->wdev.wiphy = wiphy;
> >  		/* At start-up, wpa_supplicant tries to change the interface
> >  		 * to NL80211_IFTYPE_STATION if it is not managed mode.
> >  		 */
> > @@ -3075,10 +3067,7 @@ struct wireless_dev *mwifiex_add_virtual_intf(struct wiphy *wiphy,
> >  		 */
> >  		priv->bss_type = MWIFIEX_BSS_TYPE_P2P;
> >  
> > -		priv->frame_type = MWIFIEX_DATA_FRAME_TYPE_ETH_II;
> > -		priv->bss_priority = 0;
> >  		priv->bss_role = MWIFIEX_BSS_ROLE_STA;
> > -		priv->bss_started = 0;
> >  
> >  		if (mwifiex_cfg80211_init_p2p_client(priv)) {
> >  			memset(&priv->wdev, 0, sizeof(priv->wdev));
> > @@ -3092,6 +3081,11 @@ struct wireless_dev *mwifiex_add_virtual_intf(struct wiphy *wiphy,
> >  		return ERR_PTR(-EINVAL);
> >  	}
> >  
> > +	priv->wdev.wiphy = wiphy;
> > +	priv->bss_priority = 0;
> > +	priv->bss_started = 0;
> 
> This was not set before in all the 3 cases. Irrelevant? Worth checking and/or
> mentioning in the commit message?

bss_started is only used in AP mode, its value is irrelevant in station
or adhoc mode. I'll add that to the commit message.

Sascha

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

