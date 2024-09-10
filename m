Return-Path: <linux-wireless+bounces-12733-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 166CA972BA6
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Sep 2024 10:11:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA872289CC2
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Sep 2024 08:11:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3E0418953C;
	Tue, 10 Sep 2024 08:07:50 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1040317D372
	for <linux-wireless@vger.kernel.org>; Tue, 10 Sep 2024 08:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725955670; cv=none; b=tcvlAhPbV6M6A5aIduTEmIe5hhcG6U7HBiN1oiZUjCVEmkSJ1BB6uSG/5upzf6Tk82tVV175Lz3hBAqghn6B6Lvp+k4e3NlXfWhpCmQMEN/UHbvcsoBRHcZ43PpXgGtWFnzELxcNy0BKO2yz8XkQaaAFjFLctoQA/UIKzPLHw5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725955670; c=relaxed/simple;
	bh=BKkT3RJmcj3E+Mdk3g6XAbSxZHyYge7jhjGkMX7RO/Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iNsARuyaLk33vmMU778MN7s/fiU6/rDI9DBXGCGsLkmiosx18ze3EUBs5/Yzy/T3Y/dSrgR9jRgI6aZe4yDB5eeVbsYwjk7zcLvonbacdF6O0OfxOsV/5vQ6EfOWhOI7Sw0/sH917PYlUGL6klCZ7S+duMbEcQBnQhq1JCByZBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <sha@pengutronix.de>)
	id 1snvud-0006vM-Be; Tue, 10 Sep 2024 10:07:47 +0200
Received: from [2a0a:edc0:2:b01:1d::c5] (helo=pty.whiteo.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <sha@pengutronix.de>)
	id 1snvuc-006qbo-Ga; Tue, 10 Sep 2024 10:07:46 +0200
Received: from sha by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <sha@pengutronix.de>)
	id 1snvuc-00HXnH-1K;
	Tue, 10 Sep 2024 10:07:46 +0200
Date: Tue, 10 Sep 2024 10:07:46 +0200
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
Message-ID: <Zt_-Uo7AyMmrnXnJ@pengutronix.de>
References: <ZtWHhSQlPVMekW1I@pengutronix.de>
 <PA4PR04MB9638EC10C0B656B750D922ADD1922@PA4PR04MB9638.eurprd04.prod.outlook.com>
 <Zt9blTxk88Opujsk@pengutronix.de>
 <PA4PR04MB963813D69B4D87B7147704A5D19A2@PA4PR04MB9638.eurprd04.prod.outlook.com>
 <Zt_fZEJyiCyanf7X@pengutronix.de>
 <PA4PR04MB9638C8978D9C6360A9B214E4D19A2@PA4PR04MB9638.eurprd04.prod.outlook.com>
 <Zt_h_mW4nFWKu2SI@pengutronix.de>
 <PA4PR04MB96389B2CC16060957878D0D3D19A2@PA4PR04MB9638.eurprd04.prod.outlook.com>
 <Zt_zkxGsY2X-8-4z@pengutronix.de>
 <PA4PR04MB9638D57A9623D1B33C802EF9D19A2@PA4PR04MB9638.eurprd04.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PA4PR04MB9638D57A9623D1B33C802EF9D19A2@PA4PR04MB9638.eurprd04.prod.outlook.com>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: sha@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-wireless@vger.kernel.org

On Tue, Sep 10, 2024 at 07:28:29AM +0000, David Lin wrote:
> > From: Sascha Hauer <s.hauer@pengutronix.de>
> > Sent: Tuesday, September 10, 2024 3:22 PM
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
> > On Tue, Sep 10, 2024 at 06:18:57AM +0000, David Lin wrote:
> > > > > > > > With DRCS support enabled AP and STA actually can run on
> > > > > > > > different channels with the current code. You are breaking
> > > > > > > > this scenario with this
> > > > > > patch.
> > > > > > > >
> > > > > > > > Sascha
> > > > > > > >
> > > > > > >
> > > > > > > DRCS will be checked in the future.
> > > > > >
> > > > > > By future you mean v3 of this patch?
> > > > > >
> > > > > > Sascha
> > > > > >
> > > > >
> > > > > No schedule now.
> > > >
> > > > I am getting confused now. You want us to abandon my patch in favour
> > > > of yours, but you have no plans to update your patch to avoid a
> > > > regression that you introduce with your patch?
> > > >
> > > > Sascha
> > > >
> > >
> > > My patch resolves the same issue as your patch. But your patch can't
> > > let AP and STA run on the same channel if some wiphy parameters are
> > > set.
> > >
> > > I wonder did you test your patch?
> > 
> > I finally see what you mean with "some wiphy parameters are set".
> > I did test my patch and I didn't run into this issue, because I haven't set
> > anything like rts_threshold in my config.
> > 
> > Nevertheless what I am trying to tell you in this thread is: Your patch
> > introduces a regression and needs an update.
> > 
> > It's not about my patch or your patch, both are currently not suitable for
> > inclusion and the question is: will you update your patch?
> > 
> > Sascha
> > 
> 
> Without DRCS, this patch can avoid firmware crash and this is the
> current plan for Mwifiex.  It won't affect any existing features.

What I am trying to tell you: Your patch fixes one thing and breaks
another.

The current mwifiex driver *does* support DRCS when enabled with the
drcs=1 module parameter. With DRCS enabled the current driver *can*
successfully run an Accesspoint on one channel and a station on another
channel. You are breaking this with your patch.

Your mwifiex_is_channel_setting_allowable() needs this:

        if (adapter->drcs_enabled)
		return true;

Sascha

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

