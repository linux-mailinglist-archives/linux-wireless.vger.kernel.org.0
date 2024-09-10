Return-Path: <linux-wireless+bounces-12732-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B4F2972B55
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Sep 2024 10:00:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9F28F1C241C6
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Sep 2024 08:00:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF7CB18594B;
	Tue, 10 Sep 2024 08:00:10 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51922184535
	for <linux-wireless@vger.kernel.org>; Tue, 10 Sep 2024 08:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725955210; cv=none; b=HgTP9Ibt6E723zlzw2LSdNW7+NysEAu1Gzzwg1kiQ27FvC7H83Eflxf5n+MzpeNoYYaMNTtTWEhrUGKHdnmjyCClX31TwnUTtPSVkv6OGWK516UF6n+XMkfiAKT+VxVaKCeJ+lIAf5fNn5ckOep9Tx1EFKo5UefQKz9bevAoi2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725955210; c=relaxed/simple;
	bh=ytAmbQ1x+TiIm5oeXyvdBICN/MBkFuOTui8/cLRy3XY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B839chWV+yNoLSAVhpgSqA36HX1GQzhzHMup9dW8v8H91W061ApZVNhPHLcHwTPbCT8Z4IraspP5ECC5Sf2ogYoMUAQcVjlivq+aPIQh4crE5PjNSFt02yHwPRsHLVdAgvY8zNHZD42byuISld2DdWG6OA0pTBtAPOszT9lAmHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <sha@pengutronix.de>)
	id 1snvnA-00039d-Lp; Tue, 10 Sep 2024 10:00:04 +0200
Received: from [2a0a:edc0:2:b01:1d::c5] (helo=pty.whiteo.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <sha@pengutronix.de>)
	id 1snvn9-006qUF-Rh; Tue, 10 Sep 2024 10:00:03 +0200
Received: from sha by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <sha@pengutronix.de>)
	id 1snvn9-00HXhP-2Q;
	Tue, 10 Sep 2024 10:00:03 +0200
Date: Tue, 10 Sep 2024 10:00:03 +0200
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
Message-ID: <Zt_8gwj6GnV_yZ1Z@pengutronix.de>
References: <20240902084311.2607-1-yu-hao.lin@nxp.com>
 <Zt9jFpyptX_ftH-p@pengutronix.de>
 <PA4PR04MB9638EA984DB5F2FDAEA3B873D19A2@PA4PR04MB9638.eurprd04.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PA4PR04MB9638EA984DB5F2FDAEA3B873D19A2@PA4PR04MB9638.eurprd04.prod.outlook.com>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: sha@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-wireless@vger.kernel.org

On Tue, Sep 10, 2024 at 01:52:02AM +0000, David Lin wrote:
> > From: Sascha Hauer <s.hauer@pengutronix.de>
> > Sent: Tuesday, September 10, 2024 5:05 AM
> > To: David Lin <yu-hao.lin@nxp.com>
> > Cc: linux-wireless@vger.kernel.org; linux-kernel@vger.kernel.org;
> > briannorris@chromium.org; kvalo@kernel.org; francesco@dolcini.it; Pete
> > Hsieh <tsung-hsien.hsieh@nxp.com>
> > Subject: [EXT] Re: [PATCH v2] wifi: mwifiex: avoid AP and STA running on
> > different channel
> > 
> > Caution: This is an external email. Please take care when clicking links or
> > opening attachments. When in doubt, report the message using the 'Report
> > this email' button
> > 
> > 
> > On Mon, Sep 02, 2024 at 04:43:11PM +0800, David Lin wrote:
> > > Current firmware doesn't support AP and STA running on different
> > > channels simultaneously.
> > > FW crash would occur in such case.
> > > This patch avoids the issue by disabling AP and STA to run on
> > > different channels.
> > >
> > > Signed-off-by: David Lin <yu-hao.lin@nxp.com>
> > > ---
> > >
> > > v2:
> > >    - clean up code.
> > >
> > > ---
> > >  .../net/wireless/marvell/mwifiex/cfg80211.c   | 17 ++++---
> > >  drivers/net/wireless/marvell/mwifiex/util.c   | 44 +++++++++++++++++++
> > >  drivers/net/wireless/marvell/mwifiex/util.h   | 13 ++++++
> > >  3 files changed, 69 insertions(+), 5 deletions(-)
> > >
> > > diff --git a/drivers/net/wireless/marvell/mwifiex/cfg80211.c
> > > b/drivers/net/wireless/marvell/mwifiex/cfg80211.c
> > > index 722ead51e912..3dbcab463445 100644
> > > --- a/drivers/net/wireless/marvell/mwifiex/cfg80211.c
> > > +++ b/drivers/net/wireless/marvell/mwifiex/cfg80211.c
> > > @@ -781,11 +781,9 @@ mwifiex_cfg80211_set_wiphy_params(struct wiphy
> > *wiphy, u32 changed)
> > >               break;
> > >
> > >       case MWIFIEX_BSS_ROLE_STA:
> > > -             if (priv->media_connected) {
> > > -                     mwifiex_dbg(adapter, ERROR,
> > > -                                 "cannot change wiphy params
> > when connected");
> > > -                     return -EINVAL;
> > > -             }
> > > +             if (priv->media_connected)
> > > +                     break;
> > 
> > This hunk seems unrelated to this patch. If this is needed then it deserves an
> > extra patch along with an explanation why this is necessary.
> > 
> > Sascha
> > 
> 
> Without this hunk, AP and STA can't run on the same channel if some
> wiphy parameters are setting.

Ok, I now see where you are aiming at. Here's the problematic function:

> static int
> mwifiex_cfg80211_set_wiphy_params(struct wiphy *wiphy, u32 changed)
> {
> 	...
> 
> 	priv = mwifiex_get_priv(adapter, MWIFIEX_BSS_ROLE_ANY);
> 
> 	switch (priv->bss_role) {
> 	case MWIFIEX_BSS_ROLE_UAP:
> 		if (priv->bss_started) {
> 			mwifiex_dbg(adapter, ERROR,
> 				    "cannot change wiphy params when bss started");
> 			return -EINVAL;
> 		}
> 
> 		...
> 		mwifiex_send_cmd(priv, HostCmd_CMD_UAP_SYS_CONFIG, ...);
> 
> 		break;
> 	case MWIFIEX_BSS_ROLE_STA:
> 		if (priv->media_connected) {
> 			mwifiex_dbg(adapter, ERROR,
> 				    "cannot change wiphy params when connected");
> 			return -EINVAL;
> 		}
> 
> 		...
> 		mwifiex_send_cmd(priv, HostCmd_CMD_802_11_SNMP_MIB, ...);
> 
> 		break;
> 	}
> 
> 	return 0;
> }

This function is for setting wiphy params like rts_threshold and others.

mwifiex_get_priv(adapter, MWIFIEX_BSS_ROLE_ANY) returns the first
priv which by default is in station mode. Now if you start priv0 in
station mode, then afterwards start priv1 in AP mode *and* have
rts_threshold = xy in your config, then you run into the
"cannot change wiphy params when connected" case.

I really wonder if the settings done in this function are per priv or
per adapter. Is there one rts_threshold setting in a mwifiex chip or are
there multiple (per vif/priv)?

If it's a global setting, then why are we interested in the
media_connected state of one specific priv? Shouldn't we check all
privs?

If it's a setting per priv, then why do we choose the same priv
everytime in this function?

Either way, this function looks fishy and changing it should be done
with an explanation, just dropping the error message and returning
success is not enough.

Sascha

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

