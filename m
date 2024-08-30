Return-Path: <linux-wireless+bounces-12259-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 40C3F96606F
	for <lists+linux-wireless@lfdr.de>; Fri, 30 Aug 2024 13:17:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 44EB9B21316
	for <lists+linux-wireless@lfdr.de>; Fri, 30 Aug 2024 11:16:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1540719149F;
	Fri, 30 Aug 2024 11:13:41 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5538185B51
	for <linux-wireless@vger.kernel.org>; Fri, 30 Aug 2024 11:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725016421; cv=none; b=h+sHtVOMcMwb4GWDNhInB11Fo56ShG8L0kLBwecrHUpMOettzPB30g4bBtYvQ+3Jy55kgHBS700x0t2ZCQVp9kj+w4JDQLfFGKxkwNdmnptszyPFM/vMYwFz8ZLbvrl0uXNh8JZwIOJZzlONwqNS55X+nF+B9HsLnvrfSQ1sK4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725016421; c=relaxed/simple;
	bh=lUYyE45mJjv2VLnD0HvoF/Y9zPhSrHhh71skB2OoaOY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p/w0zBKZxKrPLJnzSmVUa5NqsI118WLodkFk/f+GDeOxnU0Q81Eul5oemw2pnRSqB93N/yItO4LCTf3nWL8lK3XgJfu0bcCMlm7CgROoVQwYwZYZgl9z1l59b+atoqT/jiDNSJiXzLY4p58zRjDcTHUS9e3kRLaSSdI/M4d+ZvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <sha@pengutronix.de>)
	id 1sjzZQ-0002Y9-6N; Fri, 30 Aug 2024 13:13:36 +0200
Received: from [2a0a:edc0:2:b01:1d::c5] (helo=pty.whiteo.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <sha@pengutronix.de>)
	id 1sjzZP-0048Sj-6r; Fri, 30 Aug 2024 13:13:35 +0200
Received: from sha by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <sha@pengutronix.de>)
	id 1sjzZP-00ETte-0K;
	Fri, 30 Aug 2024 13:13:35 +0200
Date: Fri, 30 Aug 2024 13:13:35 +0200
From: Sascha Hauer <s.hauer@pengutronix.de>
To: David Lin <yu-hao.lin@nxp.com>
Cc: Francesco Dolcini <francesco@dolcini.it>,
	"linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"briannorris@chromium.org" <briannorris@chromium.org>,
	"kvalo@kernel.org" <kvalo@kernel.org>,
	Pete Hsieh <tsung-hsien.hsieh@nxp.com>
Subject: Re: [EXT] Re: [PATCH] wifi: mwifiex: avoid AP and STA running on
 different channel
Message-ID: <ZtGpX6dZQo3oywwT@pengutronix.de>
References: <20240830030630.825818-1-yu-hao.lin@nxp.com>
 <ZtF-dgrx28yZKG2O@gaggiata.pivistrello.it>
 <ZtGOaTAEpLgD_z0W@pengutronix.de>
 <PA4PR04MB963862022F22E473CD559310D1972@PA4PR04MB9638.eurprd04.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PA4PR04MB963862022F22E473CD559310D1972@PA4PR04MB9638.eurprd04.prod.outlook.com>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: sha@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-wireless@vger.kernel.org

On Fri, Aug 30, 2024 at 10:58:50AM +0000, David Lin wrote:
> > From: Sascha Hauer <s.hauer@pengutronix.de>
> > Sent: Friday, August 30, 2024 5:19 PM
> > To: Francesco Dolcini <francesco@dolcini.it>
> > Cc: David Lin <yu-hao.lin@nxp.com>; linux-wireless@vger.kernel.org;
> > linux-kernel@vger.kernel.org; briannorris@chromium.org; kvalo@kernel.org;
> > Pete Hsieh <tsung-hsien.hsieh@nxp.com>
> > Subject: [EXT] Re: [PATCH] wifi: mwifiex: avoid AP and STA running on
> > different channel
> > 
> > On Fri, Aug 30, 2024 at 10:10:30AM +0200, Francesco Dolcini wrote:
> > > +Sascha, that just sent a patch to handle the same issue.
> > >
> > > On Fri, Aug 30, 2024 at 11:06:30AM +0800, David Lin wrote:
> > > > Current firmware doesn't support AP and STA running on different
> > > > channels simultaneously.
> > > > FW crash would occur in such case.
> > > > This patch avoids the issue by disabling AP and STA to run on
> > > > different channels.
> > >
> > > Is this a generic issue of specific of some firmware version? Asking
> > > since the driver as you know is supporting multiple Wi-Fi device.
> > 
> > The driver does, unfortunately the hardware does not.
> > 
> > I learned this the hard way. When an accesspoint is running on uap0 and
> > you want to connect to an accesspoint on mlan0 then it won't work when
> > that accesspoint is on a different channel.
> > 
> > Likewise, when you are creating an accesspoint on uap0 using channel A and
> > another one on channel B then you'll notice that both accesspoints will end
> > up using channel A.
> > 
> > It took me a while to find that out. In the end I found the same channel
> > check in the nxpwifi driver.
> > 
> > Sascha
> > 
> 
> Yes, this patch is backported from nxpwifi (same as another patch for AP DFS mode).
> Because Mwifiex supports connect/disconnect and separate auth/assoc, I think I will
> clean up the code and create patch v2 later.

Gna, I didn't notice that I haven't answered to my own patch, but to
your patch addressing the same problem a few hours later ;)

Sascha

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

