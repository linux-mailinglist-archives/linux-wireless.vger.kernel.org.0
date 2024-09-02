Return-Path: <linux-wireless+bounces-12337-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F969968883
	for <lists+linux-wireless@lfdr.de>; Mon,  2 Sep 2024 15:11:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 448E61C2253F
	for <lists+linux-wireless@lfdr.de>; Mon,  2 Sep 2024 13:11:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 819882570;
	Mon,  2 Sep 2024 13:11:33 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21A4F1D175E
	for <linux-wireless@vger.kernel.org>; Mon,  2 Sep 2024 13:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725282693; cv=none; b=NHJka198KAgSqZR4nbvKg65Xpn1I1HAo7pQDJFntJMT43an0vHFvpB/qzAvj7kQzc3TmGJqC3JRYqVlpCuHb5DsXIw2dMg94HfuM48oWJPxjmj5bBzUsT1DroPlhVyb4fYDAZTYkg21SSAEnD86jm8uxyOdyE9ZA7r1pA2NTaO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725282693; c=relaxed/simple;
	bh=wNCiw8vcHy2HPstOIpjJ6c6HntN2pNs48vgt4jsXRiY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Bm6zSpCKtCseF1qdD53tqkBKBSzYw7zVASkG9D0TvTvMfdj80XjF7C4fkLZ6VFP3nY8TyO9vfHadKy57E7NNkTy6VlZNYMe0AyYzO0ZHWNR6rKeYBYvB/KC4k6tklI/7CYJvLjuwhdPsmmNczuVVArOrXPh2GFwuCvDKS+LB51Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <sha@pengutronix.de>)
	id 1sl6q5-0001oO-QF; Mon, 02 Sep 2024 15:11:25 +0200
Received: from [2a0a:edc0:2:b01:1d::c5] (helo=pty.whiteo.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <sha@pengutronix.de>)
	id 1sl6q4-004uYQ-Ph; Mon, 02 Sep 2024 15:11:24 +0200
Received: from sha by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <sha@pengutronix.de>)
	id 1sl6q4-002Zvg-2B;
	Mon, 02 Sep 2024 15:11:24 +0200
Date: Mon, 2 Sep 2024 15:11:24 +0200
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
Message-ID: <ZtW5fFocfr9_WgGD@pengutronix.de>
References: <20240826072648.167004-1-s.hauer@pengutronix.de>
 <PA4PR04MB9638016F363BFF87D62B70D1D1922@PA4PR04MB9638.eurprd04.prod.outlook.com>
 <ZtVd3__wfm6EOOgH@pengutronix.de>
 <PA4PR04MB9638CF45263E713203A53EF7D1922@PA4PR04MB9638.eurprd04.prod.outlook.com>
 <ZtVtPJSsIr9eIFWv@pengutronix.de>
 <PA4PR04MB9638ED8FA48E352F7246127AD1922@PA4PR04MB9638.eurprd04.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PA4PR04MB9638ED8FA48E352F7246127AD1922@PA4PR04MB9638.eurprd04.prod.outlook.com>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: sha@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-wireless@vger.kernel.org

On Mon, Sep 02, 2024 at 08:00:58AM +0000, David Lin wrote:
> > From: Sascha Hauer <s.hauer@pengutronix.de>
> > Sent: Monday, September 2, 2024 3:46 PM
> > To: David Lin <yu-hao.lin@nxp.com>
> > Cc: Francesco Dolcini <francesco@dolcini.it>; Calvin Owens
> > <calvin@wbinvd.org>; Brian Norris <briannorris@chromium.org>; Kalle Valo
> > <kvalo@kernel.org>; linux-wireless@vger.kernel.org;
> > linux-kernel@vger.kernel.org; kernel@pengutronix.de
> > Subject: Re: [EXT] [RFC PATCH 0/4] mwifiex: add support for iw61x
> > 
> > Caution: This is an external email. Please take care when clicking links or
> > opening attachments. When in doubt, report the message using the 'Report
> > this email' button
> > 
> > 
> > On Mon, Sep 02, 2024 at 06:54:07AM +0000, David Lin wrote:
> > > > From: Sascha Hauer <s.hauer@pengutronix.de>
> > > > Sent: Monday, September 2, 2024 2:41 PM
> > > > To: David Lin <yu-hao.lin@nxp.com>
> > > > Cc: Francesco Dolcini <francesco@dolcini.it>; Calvin Owens
> > > > <calvin@wbinvd.org>; Brian Norris <briannorris@chromium.org>; Kalle
> > > > Valo <kvalo@kernel.org>; linux-wireless@vger.kernel.org;
> > > > linux-kernel@vger.kernel.org; kernel@pengutronix.de
> > > > Subject: Re: [EXT] [RFC PATCH 0/4] mwifiex: add support for iw61x
> > > >
> > > > Caution: This is an external email. Please take care when clicking
> > > > links or opening attachments. When in doubt, report the message
> > > > using the 'Report this email' button
> > > >
> > > >
> > > > On Mon, Sep 02, 2024 at 02:24:53AM +0000, David Lin wrote:
> > > > > > From: Sascha Hauer <s.hauer@pengutronix.de>
> > > > > > Sent: Monday, August 26, 2024 3:27 PM
> > > > > > To: Francesco Dolcini <francesco@dolcini.it>
> > > > > > Cc: Calvin Owens <calvin@wbinvd.org>; Brian Norris
> > > > > > <briannorris@chromium.org>; Kalle Valo <kvalo@kernel.org>; David
> > > > > > Lin <yu-hao.lin@nxp.com>; linux-wireless@vger.kernel.org;
> > > > > > linux-kernel@vger.kernel.org; kernel@pengutronix.de; Sascha
> > > > > > Hauer <s.hauer@pengutronix.de>
> > > > > > Subject: [EXT] [RFC PATCH 0/4] mwifiex: add support for iw61x
> > > > > >
> > > > > > Caution: This is an external email. Please take care when
> > > > > > clicking links or opening attachments. When in doubt, report the
> > > > > > message using the 'Report this email' button
> > > > > >
> > > > > >
> > > > > > This series adds support for the iw61x chips to the mwifiex driver.
> > > > > > There are a few things to address, hence the RFC status. See the
> > > > > > commit messages for details. The series is based on
> > wireless-next/main.
> > > > > >
> > > > > > I am sending this now since people requested it here [1], but as
> > > > > > it's out now feel free to leave your comments to the issues
> > > > > > mentioned (or others I haven't mentioned ;)
> > > > > >
> > > > > > [1]
> > > > > > https://lo/
> > > > > >
> > > >
> > re.kern%2F&data=05%7C02%7Cyu-hao.lin%40nxp.com%7C6125c51da3704fe10
> > > > a5
> > > > > >
> > > >
> > a08dccb1a24ef%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C6386
> > > > 08560
> > > > > >
> > > >
> > 383160951%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV
> > > > 2luMz
> > > > > >
> > > >
> > IiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C0%7C%7C%7C&sdata=jfQ6FQimPpwr
> > > > nwUo
> > > > > > OCEhmpSadtrb15ymGiif%2B1UCdG0%3D&reserved=0
> > > > > >
> > > >
> > el.org%2Fall%2F20240809094533.1660-1-yu-hao.lin%40nxp.com%2F&data=05
> > > > > >
> > > >
> > %7C02%7Cyu-hao.lin%40nxp.com%7C184ab4fed58647150f8508dcc5a0789a%7
> > > > > >
> > > >
> > C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C638602540229716119%
> > > > > >
> > > >
> > 7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJB
> > > > > >
> > > >
> > TiI6Ik1haWwiLCJXVCI6Mn0%3D%7C0%7C%7C%7C&sdata=cACBHxaQvcOqu6ri
> > > > > > BoAlZDONRlGQ4j5DcglEV9T%2BpYU%3D&reserved=0
> > > > > >
> > > > > > Sascha
> > > > > >
> > > > > >
> > > > > > Sascha Hauer (4):
> > > > > >   wifi: mwifiex: release firmware at remove time
> > > > > >   wifi: mwifiex: handle VDLL
> > > > > >   wifi: mwifiex: wait longer for SDIO card status
> > > > > >   mwifiex: add iw61x support
> > > > > >
> > > > > >  drivers/net/wireless/marvell/mwifiex/cmdevt.c | 86
> > > > +++++++++++++++++++
> > > > > >  drivers/net/wireless/marvell/mwifiex/fw.h     | 16 ++++
> > > > > >  drivers/net/wireless/marvell/mwifiex/main.c   |  9 +-
> > > > > >  drivers/net/wireless/marvell/mwifiex/main.h   |  4 +
> > > > > >  drivers/net/wireless/marvell/mwifiex/sdio.c   | 81
> > ++++++++++++++++-
> > > > > >  drivers/net/wireless/marvell/mwifiex/sdio.h   |  3 +
> > > > > >  .../net/wireless/marvell/mwifiex/sta_event.c  |  4
> > > > > > +  .../net/wireless/marvell/mwifiex/uap_event.c  |  4 +
> > > > > >  include/linux/mmc/sdio_ids.h                  |  3 +
> > > > > >  9 files changed, 205 insertions(+), 5 deletions(-)
> > > > > >
> > > > > > --
> > > > > > 2.39.2
> > > > >
> > > > > I think you ported VDLL related code from nxpwifi and you also
> > > > > traced our private/downstream MXM driver.
> > > >
> > > > I ported it from this repository:
> > > >
> > > > https://eur01.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgi
> > > >
> > thub.co%2F&data=05%7C02%7Cyu-hao.lin%40nxp.com%7C9f55bf357ece47645
> > 0b
> > > >
> > 708dccb234dae%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C6386
> > 08599
> > > >
> > 700151625%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV
> > 2luMz
> > > >
> > IiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C0%7C%7C%7C&sdata=OLf3OfFX7R%
> > 2BT3V
> > > > gWtcsqlls%2FI3ceY8r3bewwYy8bAes%3D&reserved=0
> > > >
> > m%2Fnxp-imx%2Fmwifiex-iw612.git&data=05%7C02%7Cyu-hao.lin%40nxp.co
> > > >
> > m%7C6125c51da3704fe10a5a08dccb1a24ef%7C686ea1d3bc2b4c6fa92cd99c5
> > > >
> > c301635%7C0%7C0%7C638608560383172495%7CUnknown%7CTWFpbGZsb3d
> > > >
> > 8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3
> > > >
> > D%7C0%7C%7C%7C&sdata=5TgI0r4u2I9Pi1FATJx32Ubn7ufmbYsBR1XkpQLAIyQ
> > > > %3D&reserved=0
> > > >
> > > > Is that the one you are referring to as MXM driver?
> > > >
> > >
> > > Yes.
> > >
> > > > > If this is the case, I think you should know nxpwifi already
> > > > > cleaned up the porting VDLL code from MXM driver.
> > > > > I check your patch quickly. You ported the new SDIO data type
> > > > > (MWIFIEX_TYPE_VDLL) from nxpwifi, but you did not port the code to
> > > > > support this new data type from nxpwifi. In other word, you did
> > > > > not test your patch before submission (same as some of your patches).
> > > >
> > > > I did test it. It works with the iw61x as well as older chips. There
> > > > are likely details I haven't tested, but it generally works. If
> > > > there are details I should test additionally please let me know.
> > > >
> > > > >
> > > > > Another thing is that this new SDIO data type should be handled
> > > > > carefully with other existed SDIO data type.
> > > > >
> > > > > Nxpwifi only supports new SDIO mode, so the modification to
> > > > > support NXPWIFI_TYPE_VDLL can be clean and simple. If you want to
> > > > > port the code to Mwifiex, there is no one-to-one modification of the
> > code.
> > > > >
> > > > > Another important thing is that you should consider if your
> > > > > modifications will affect existed devices or not.
> > > > > You need to check if you should check firmware version or chip
> > > > > type before adding some code.
> > > >
> > > > The VDLL code I added for the iw61x only reacts to the
> > > > EVENT_VDLL_IND event. So as long as a firmware doesn't send such an
> > > > event nothing is changed with this patch, and I haven't seen an older chip
> > sending a VDLL event.
> > > >
> > >
> > > How about IW61x? As I mentioned before, if you test IW61x on DFS
> > > channel, command timeout will happen.  Without correct VDLL porting,
> > > you will encounter command timeout in some other test cases. But
> > > testing on DFS channel will be easier to reproduce the issue.
> > 
> > The VDLL support in the downstream driver supports a case when a VDLL
> > event comes in while a command is being sent. I catched this with this
> > test:
> > 
> >         if (adapter->cmd_sent) {
> >                 mwifiex_dbg(adapter, MSG, "%s: adapter is busy\n",
> > __func__);
> >                 return -EBUSY;
> >         }
> > 
> > The downstream driver defers handling of the VDLL event to the main process
> > in this case. I haven't implemented this case in my patch because I wasn't able
> > to trigger it, but is this the case you are referring to?
> > 
> 
> Not only this code segment. In fact, you did not add VDLL data patch support to sdio.c.
> If you try to add the code and do test, you will know what is missing in your code.

Could you point me to the code you mean?

Sascha

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

