Return-Path: <linux-wireless+bounces-12737-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 09136972C29
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Sep 2024 10:31:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 12065B20C6C
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Sep 2024 08:31:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC03917BB07;
	Tue, 10 Sep 2024 08:31:37 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB4C5149E00
	for <linux-wireless@vger.kernel.org>; Tue, 10 Sep 2024 08:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725957097; cv=none; b=ZXMh6cXrFapYgF4t2ChJMnGvIU81/0Di9nECHXdQNsZfBrxZzshKOItxjJR8ruavHbBqNLJ5bBR9nB3Mum3HZOahn3mC/4uofAv/fS5GleEu93f503Am25xjbGne/Wm8vvL6Uo6Rb52RCQfo+NoEClaipgZAu5OUJLi5JiKhp84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725957097; c=relaxed/simple;
	bh=DwV2m+UVX+/4uCR9wGnXZWYetO13I6dvNsIEeR/zeZ8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oFsLo99IRljQ63EcczqrekMiuiPvch9HH7rRGO1owxS3z6DK0KQH5CcOqw0VYozGsC4xI3N7JuZXCXkE27+jvLTRvMkGRf4ztbLmv7oCHCsGQrUtHFBWcWmtSvrIWbLCCBxcEMy7bWXW0kDm8iPV9ncxgjCGaau0ERl4gyGiaz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <sha@pengutronix.de>)
	id 1snwHe-0008GL-1X; Tue, 10 Sep 2024 10:31:34 +0200
Received: from [2a0a:edc0:2:b01:1d::c5] (helo=pty.whiteo.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <sha@pengutronix.de>)
	id 1snwHd-006qtv-5j; Tue, 10 Sep 2024 10:31:33 +0200
Received: from sha by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <sha@pengutronix.de>)
	id 1snwHd-00HYBe-0G;
	Tue, 10 Sep 2024 10:31:33 +0200
Date: Tue, 10 Sep 2024 10:31:33 +0200
From: Sascha Hauer <s.hauer@pengutronix.de>
To: David Lin <yu-hao.lin@nxp.com>
Cc: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"briannorris@chromium.org" <briannorris@chromium.org>,
	"kvalo@kernel.org" <kvalo@kernel.org>,
	"francesco@dolcini.it" <francesco@dolcini.it>,
	Pete Hsieh <tsung-hsien.hsieh@nxp.com>
Subject: Re: [EXT] Re: [PATCH v2] wifi: mwifiex: avoid AP and STA running on
 different channel
Message-ID: <ZuAD5fKyKgHPFN8s@pengutronix.de>
References: <20240902084311.2607-1-yu-hao.lin@nxp.com>
 <Zt9jFpyptX_ftH-p@pengutronix.de>
 <PA4PR04MB9638EA984DB5F2FDAEA3B873D19A2@PA4PR04MB9638.eurprd04.prod.outlook.com>
 <Zt_8gwj6GnV_yZ1Z@pengutronix.de>
 <PA4PR04MB963850587C41FF78F4244E3AD19A2@PA4PR04MB9638.eurprd04.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PA4PR04MB963850587C41FF78F4244E3AD19A2@PA4PR04MB9638.eurprd04.prod.outlook.com>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: sha@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-wireless@vger.kernel.org

On Tue, Sep 10, 2024 at 08:19:59AM +0000, David Lin wrote:
> > From: Sascha Hauer <s.hauer@pengutronix.de>
> > Sent: Tuesday, September 10, 2024 4:00 PM
> > To: David Lin <yu-hao.lin@nxp.com>
> > Cc: linux-wireless@vger.kernel.org; linux-kernel@vger.kernel.org;
> > briannorris@chromium.org; kvalo@kernel.org; francesco@dolcini.it; Pete
> > Hsieh <tsung-hsien.hsieh@nxp.com>
> > Subject: Re: [EXT] Re: [PATCH v2] wifi: mwifiex: avoid AP and STA running on
> > different channel
> > 
> > Caution: This is an external email. Please take care when clicking links or
> > opening attachments. When in doubt, report the message using the 'Report
> > this email' button
> > 
> > 
> > On Tue, Sep 10, 2024 at 01:52:02AM +0000, David Lin wrote:
> > > > From: Sascha Hauer <s.hauer@pengutronix.de>
> > > > Sent: Tuesday, September 10, 2024 5:05 AM
> > > > To: David Lin <yu-hao.lin@nxp.com>
> > > > Cc: linux-wireless@vger.kernel.org; linux-kernel@vger.kernel.org;
> > > > briannorris@chromium.org; kvalo@kernel.org; francesco@dolcini.it;
> > > > Pete Hsieh <tsung-hsien.hsieh@nxp.com>
> > > > Subject: [EXT] Re: [PATCH v2] wifi: mwifiex: avoid AP and STA
> > > > running on different channel
> > > >
> > > > Caution: This is an external email. Please take care when clicking
> > > > links or opening attachments. When in doubt, report the message
> > > > using the 'Report this email' button
> > > >
> > > >
> > > > On Mon, Sep 02, 2024 at 04:43:11PM +0800, David Lin wrote:
> > > > > Current firmware doesn't support AP and STA running on different
> > > > > channels simultaneously.
> > > > > FW crash would occur in such case.
> > > > > This patch avoids the issue by disabling AP and STA to run on
> > > > > different channels.
> > > > >
> > > > > Signed-off-by: David Lin <yu-hao.lin@nxp.com>
> > > > > ---
> > > > >
> > > > > v2:
> > > > >    - clean up code.
> > > > >
> > > > > ---
> > > > >  .../net/wireless/marvell/mwifiex/cfg80211.c   | 17 ++++---
> > > > >  drivers/net/wireless/marvell/mwifiex/util.c   | 44
> > +++++++++++++++++++
> > > > >  drivers/net/wireless/marvell/mwifiex/util.h   | 13 ++++++
> > > > >  3 files changed, 69 insertions(+), 5 deletions(-)
> > > > >
> > > > > diff --git a/drivers/net/wireless/marvell/mwifiex/cfg80211.c
> > > > > b/drivers/net/wireless/marvell/mwifiex/cfg80211.c
> > > > > index 722ead51e912..3dbcab463445 100644
> > > > > --- a/drivers/net/wireless/marvell/mwifiex/cfg80211.c
> > > > > +++ b/drivers/net/wireless/marvell/mwifiex/cfg80211.c
> > > > > @@ -781,11 +781,9 @@ mwifiex_cfg80211_set_wiphy_params(struct
> > > > > wiphy
> > > > *wiphy, u32 changed)
> > > > >               break;
> > > > >
> > > > >       case MWIFIEX_BSS_ROLE_STA:
> > > > > -             if (priv->media_connected) {
> > > > > -                     mwifiex_dbg(adapter, ERROR,
> > > > > -                                 "cannot change wiphy params
> > > > when connected");
> > > > > -                     return -EINVAL;
> > > > > -             }
> > > > > +             if (priv->media_connected)
> > > > > +                     break;
> > > >
> > > > This hunk seems unrelated to this patch. If this is needed then it
> > > > deserves an extra patch along with an explanation why this is necessary.
> > > >
> > > > Sascha
> > > >
> > >
> > > Without this hunk, AP and STA can't run on the same channel if some
> > > wiphy parameters are setting.
> > 
> > Ok, I now see where you are aiming at. Here's the problematic function:
> > 
> > > static int
> > > mwifiex_cfg80211_set_wiphy_params(struct wiphy *wiphy, u32 changed) {
> > >       ...
> > >
> > >       priv = mwifiex_get_priv(adapter, MWIFIEX_BSS_ROLE_ANY);
> > >
> > >       switch (priv->bss_role) {
> > >       case MWIFIEX_BSS_ROLE_UAP:
> > >               if (priv->bss_started) {
> > >                       mwifiex_dbg(adapter, ERROR,
> > >                                   "cannot change wiphy params
> > when bss started");
> > >                       return -EINVAL;
> > >               }
> > >
> > >               ...
> > >               mwifiex_send_cmd(priv,
> > HostCmd_CMD_UAP_SYS_CONFIG, ...);
> > >
> > >               break;
> > >       case MWIFIEX_BSS_ROLE_STA:
> > >               if (priv->media_connected) {
> > >                       mwifiex_dbg(adapter, ERROR,
> > >                                   "cannot change wiphy params
> > when connected");
> > >                       return -EINVAL;
> > >               }
> > >
> > >               ...
> > >               mwifiex_send_cmd(priv,
> > HostCmd_CMD_802_11_SNMP_MIB,
> > > ...);
> > >
> > >               break;
> > >       }
> > >
> > >       return 0;
> > > }
> > 
> > This function is for setting wiphy params like rts_threshold and others.
> > 
> > mwifiex_get_priv(adapter, MWIFIEX_BSS_ROLE_ANY) returns the first priv
> > which by default is in station mode. Now if you start priv0 in station mode,
> > then afterwards start priv1 in AP mode *and* have rts_threshold = xy in your
> > config, then you run into the "cannot change wiphy params when connected"
> > case.
> > 
> > I really wonder if the settings done in this function are per priv or per adapter.
> > Is there one rts_threshold setting in a mwifiex chip or are there multiple (per
> > vif/priv)?
> > 
> > If it's a global setting, then why are we interested in the media_connected
> > state of one specific priv? Shouldn't we check all privs?
> > 
> > If it's a setting per priv, then why do we choose the same priv everytime in this
> > function?
> > 
> > Either way, this function looks fishy and changing it should be done with an
> > explanation, just dropping the error message and returning success is not
> > enough.
> > 
> > Sascha
> > 
> > --
> 
> O.K. I will add comment in patch v3.

Really I hoped that you could clarify a bit how this function works and
answer some of the questions I raised above. That could help us to get
a better driver over time. The same code is in the nxpwifi driver as
well, so it's not only a matter of which driver we decide to maintain
in the future.

Sascha

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

