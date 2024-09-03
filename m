Return-Path: <linux-wireless+bounces-12361-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D1B79693B3
	for <lists+linux-wireless@lfdr.de>; Tue,  3 Sep 2024 08:33:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0AC47284542
	for <lists+linux-wireless@lfdr.de>; Tue,  3 Sep 2024 06:33:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E2EE2E3EB;
	Tue,  3 Sep 2024 06:33:16 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58E7A1D0DE6
	for <linux-wireless@vger.kernel.org>; Tue,  3 Sep 2024 06:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725345195; cv=none; b=MLWsiklL9ZLhb/mt/0ELejlz0Ps6/TXHreqtaArYlhRRorPAkv5BnchnSSjUzS6DnggVgQT/8XxfX+AyXzVi3okP55i2Ff734gGJSKibe5ZVBXPPbAVcuH1SqngTZweUHHmxSK7RCPSJxIU+IK85WSwt9mIW30ibkf4fVqE7PI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725345195; c=relaxed/simple;
	bh=bWTYGSEkN+qEPafiZXabnURnos5QBjb8WnYA9NzgsqY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e33PaPyTDMNN2Rol2JotbNIVM4fjf+tg5zsE6Tvkeck4Equ1wp46rvISrbgDz3E42UPMnz5T54LVXp2HWPcpTDxASAevBbjjBDfuhEA0YS1wEWHd3UM3SHr7MW3L9FAbj3i9gzkWWlFxuB8PB/kDQaw2u1dcZN+m2TiG4G+8Wy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <sha@pengutronix.de>)
	id 1slN65-0002jB-HH; Tue, 03 Sep 2024 08:33:01 +0200
Received: from [2a0a:edc0:2:b01:1d::c5] (helo=pty.whiteo.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <sha@pengutronix.de>)
	id 1slN64-0057Lz-5G; Tue, 03 Sep 2024 08:33:00 +0200
Received: from sha by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <sha@pengutronix.de>)
	id 1slN64-004Lui-08;
	Tue, 03 Sep 2024 08:33:00 +0200
Date: Tue, 3 Sep 2024 08:33:00 +0200
From: Sascha Hauer <s.hauer@pengutronix.de>
To: David Lin <yu-hao.lin@nxp.com>
Cc: Francesco Dolcini <francesco@dolcini.it>,
	Calvin Owens <calvin@wbinvd.org>,
	Brian Norris <briannorris@chromium.org>,
	Kalle Valo <kvalo@kernel.org>,
	"linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"kernel@pengutronix.de" <kernel@pengutronix.de>
Subject: Re: [EXT] [RFC PATCH 0/4] mwifiex: add support for iw61x
Message-ID: <ZtatnHp_7FBSSpko@pengutronix.de>
References: <20240826072648.167004-1-s.hauer@pengutronix.de>
 <PA4PR04MB9638016F363BFF87D62B70D1D1922@PA4PR04MB9638.eurprd04.prod.outlook.com>
 <ZtVd3__wfm6EOOgH@pengutronix.de>
 <PA4PR04MB9638CF45263E713203A53EF7D1922@PA4PR04MB9638.eurprd04.prod.outlook.com>
 <ZtVtPJSsIr9eIFWv@pengutronix.de>
 <PA4PR04MB9638ED8FA48E352F7246127AD1922@PA4PR04MB9638.eurprd04.prod.outlook.com>
 <ZtW5fFocfr9_WgGD@pengutronix.de>
 <PA4PR04MB963814F85BBA6DD39F516469D1932@PA4PR04MB9638.eurprd04.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PA4PR04MB963814F85BBA6DD39F516469D1932@PA4PR04MB9638.eurprd04.prod.outlook.com>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: sha@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-wireless@vger.kernel.org

On Tue, Sep 03, 2024 at 01:51:46AM +0000, David Lin wrote:
> > From: Sascha Hauer <s.hauer@pengutronix.de>
> > Sent: Monday, September 2, 2024 9:11 PM
> > To: David Lin <yu-hao.lin@nxp.com>
> > Cc: Francesco Dolcini <francesco@dolcini.it>; Calvin Owens
> > <calvin@wbinvd.org>; Brian Norris <briannorris@chromium.org>; Kalle Valo
> > <kvalo@kernel.org>; linux-wireless@vger.kernel.org;
> > linux-kernel@vger.kernel.org; kernel@pengutronix.de
> > Subject: Re: [EXT] [RFC PATCH 0/4] mwifiex: add support for iw61x
> > 
> > > > > > > >
> > > > > > > > Sascha
> > > > > > > >
> > > > > > > >
> > > > > > > > Sascha Hauer (4):
> > > > > > > >   wifi: mwifiex: release firmware at remove time
> > > > > > > >   wifi: mwifiex: handle VDLL
> > > > > > > >   wifi: mwifiex: wait longer for SDIO card status
> > > > > > > >   mwifiex: add iw61x support
> > > > > > > >
> > > > > > > >  drivers/net/wireless/marvell/mwifiex/cmdevt.c | 86
> > > > > > +++++++++++++++++++
> > > > > > > >  drivers/net/wireless/marvell/mwifiex/fw.h     | 16 ++++
> > > > > > > >  drivers/net/wireless/marvell/mwifiex/main.c   |  9 +-
> > > > > > > >  drivers/net/wireless/marvell/mwifiex/main.h   |  4 +
> > > > > > > >  drivers/net/wireless/marvell/mwifiex/sdio.c   | 81
> > > > ++++++++++++++++-
> > > > > > > >  drivers/net/wireless/marvell/mwifiex/sdio.h   |  3 +
> > > > > > > >  .../net/wireless/marvell/mwifiex/sta_event.c  |  4
> > > > > > > > +  .../net/wireless/marvell/mwifiex/uap_event.c  |  4 +
> > > > > > > >  include/linux/mmc/sdio_ids.h                  |  3 +
> > > > > > > >  9 files changed, 205 insertions(+), 5 deletions(-)
> > > > > > > >
> > > > > > > > --
> > > > The VDLL support in the downstream driver supports a case when a
> > > > VDLL event comes in while a command is being sent. I catched this
> > > > with this
> > > > test:
> > > >
> > > >         if (adapter->cmd_sent) {
> > > >                 mwifiex_dbg(adapter, MSG, "%s: adapter is busy\n",
> > > > __func__);
> > > >                 return -EBUSY;
> > > >         }
> > > >
> > > > The downstream driver defers handling of the VDLL event to the main
> > > > process in this case. I haven't implemented this case in my patch
> > > > because I wasn't able to trigger it, but is this the case you are referring to?
> > > >
> > >
> > > Not only this code segment. In fact, you did not add VDLL data patch support
> > to sdio.c.
> > > If you try to add the code and do test, you will know what is missing in your
> > code.
> > 
> > Could you point me to the code you mean?
> > 
> > Sascha
> > 
> 
> I only know the porting VDLL code in nxpwifi.

Yes, and I asked for a pointer to that code, some function name, or
file/line or whatever, because I looked at the nxpwifi driver and don't
know what you mean with "VDLL data patch support" in sdio.c.

Sascha

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

