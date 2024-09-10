Return-Path: <linux-wireless+bounces-12727-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E575972946
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Sep 2024 08:07:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 56186285FFB
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Sep 2024 06:07:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98C1B170A15;
	Tue, 10 Sep 2024 06:06:59 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86FAD170A26
	for <linux-wireless@vger.kernel.org>; Tue, 10 Sep 2024 06:06:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725948419; cv=none; b=Jz/eX5ratZL5OsCvzGogi0iumk8dwtqsda4GaLc6xI/rGdSdcmZ/NWpTGQhNDPYqWtbZEhtieZoy4gmeTLD0yiUn74oG/iCfKsG8j1R+Y7pwtfwv65IESAyYJ8mM7oFwpR2XT2y4HRsL7FY+swZF5DwasUKlukPnYwU8oGRJL2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725948419; c=relaxed/simple;
	bh=0u0Ic82teMPVdI77mCAypb2Gawhi8xTU7RiSGEjStsw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FCS20PxH1fq8yeQxGVq037qCWE6TsQGqxAm9GIHrsHc7iTKl5i4neUxy3eroNw/SnOk6tMF9cpO3FtI8RVXzuCnLDncOauqfesF82uQafVqoC6WItqYZUGJOtw6ZWxg0PBWnjohqpuABfBWxoSNWwcJsKSLIUmSrLL6lj5gnpco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <sha@pengutronix.de>)
	id 1snu1f-0003bB-Rv; Tue, 10 Sep 2024 08:06:55 +0200
Received: from [2a0a:edc0:2:b01:1d::c5] (helo=pty.whiteo.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <sha@pengutronix.de>)
	id 1snu1e-006pVN-VD; Tue, 10 Sep 2024 08:06:54 +0200
Received: from sha by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <sha@pengutronix.de>)
	id 1snu1e-00HWSG-2m;
	Tue, 10 Sep 2024 08:06:54 +0200
Date: Tue, 10 Sep 2024 08:06:54 +0200
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
Message-ID: <Zt_h_mW4nFWKu2SI@pengutronix.de>
References: <20240902084311.2607-1-yu-hao.lin@nxp.com>
 <ZtWHhSQlPVMekW1I@pengutronix.de>
 <PA4PR04MB9638EC10C0B656B750D922ADD1922@PA4PR04MB9638.eurprd04.prod.outlook.com>
 <Zt9blTxk88Opujsk@pengutronix.de>
 <PA4PR04MB963813D69B4D87B7147704A5D19A2@PA4PR04MB9638.eurprd04.prod.outlook.com>
 <Zt_fZEJyiCyanf7X@pengutronix.de>
 <PA4PR04MB9638C8978D9C6360A9B214E4D19A2@PA4PR04MB9638.eurprd04.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PA4PR04MB9638C8978D9C6360A9B214E4D19A2@PA4PR04MB9638.eurprd04.prod.outlook.com>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: sha@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-wireless@vger.kernel.org

On Tue, Sep 10, 2024 at 05:56:58AM +0000, David Lin wrote:
> > From: Sascha Hauer <s.hauer@pengutronix.de>
> > Sent: Tuesday, September 10, 2024 1:56 PM
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
> > On Tue, Sep 10, 2024 at 01:55:14AM +0000, David Lin wrote:
> > > > From: Sascha Hauer <s.hauer@pengutronix.de>
> > > > Sent: Tuesday, September 10, 2024 4:33 AM
> > > > To: David Lin <yu-hao.lin@nxp.com>
> > > > Cc: linux-wireless@vger.kernel.org; linux-kernel@vger.kernel.org;
> > > > briannorris@chromium.org; kvalo@kernel.org; francesco@dolcini.it;
> > > > Pete Hsieh <tsung-hsien.hsieh@nxp.com>
> > > > Subject: Re: [EXT] Re: [PATCH v2] wifi: mwifiex: avoid AP and STA
> > > > running on different channel
> > > >
> > > > Caution: This is an external email. Please take care when clicking
> > > > links or opening attachments. When in doubt, report the message
> > > > using the 'Report this email' button
> > > >
> > > >
> > > > On Mon, Sep 02, 2024 at 10:35:01AM +0000, David Lin wrote:
> > > > > > From: Sascha Hauer <s.hauer@pengutronix.de>
> > > > > > Sent: Monday, September 2, 2024 5:38 PM
> > > > > > To: David Lin <yu-hao.lin@nxp.com>
> > > > > > Cc: linux-wireless@vger.kernel.org;
> > > > > > linux-kernel@vger.kernel.org; briannorris@chromium.org;
> > > > > > kvalo@kernel.org; francesco@dolcini.it; Pete Hsieh
> > > > > > <tsung-hsien.hsieh@nxp.com>
> > > > > > Subject: [EXT] Re: [PATCH v2] wifi: mwifiex: avoid AP and STA
> > > > > > running on different channel
> > > > > >
> > > > > > On Mon, Sep 02, 2024 at 04:43:11PM +0800, David Lin wrote:
> > > > > > > Current firmware doesn't support AP and STA running on
> > > > > > > different channels simultaneously.
> > > > > >
> > > > > > As mentioned here:
> > > > > >
> > > > > > https://eur01.safelinks.protection.outlook.com/?url=https%3A%2F%
> > > > > >
> > 2Flo%2F&data=05%7C02%7Cyu-hao.lin%40nxp.com%7Cd0a1e3797a0d4acd7a
> > > > > >
> > 9c08dcd15d3ddb%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C638
> > 6
> > > > > >
> > 15445620612026%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJ
> > QI
> > > > > >
> > joiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C0%7C%7C%7C&sdata=5yC
> > > > > > jjIqxpV%2BJxlPdrCH0gRTQ%2FCQZKr%2FDc0S1cjkaIA8%3D&reserved=0
> > > > > >
> > > >
> > re.kern%2F&data=05%7C02%7Cyu-hao.lin%40nxp.com%7C7712df39ac37414fd
> > > > a7
> > > > > >
> > > >
> > e08dcd10eac35%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C6386
> > > > 15108
> > > > > >
> > > >
> > 157502805%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV
> > > > 2luMz
> > > > > >
> > > >
> > IiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C0%7C%7C%7C&sdata=URNJPJE17iRY
> > > > Tu4i
> > > > > > rx7eQAC97tE5OE6a4kUfjUwuaVU%3D&reserved=0
> > > > > >
> > > >
> > el.org%2Fall%2FZtGnWC7SPHt7Vbbp%40pengutronix.de%2F&data=05%7C02%
> > > > > >
> > > >
> > 7Cyu-hao.lin%40nxp.com%7Cce9b7d4e417c41113c7d08dccb32fc49%7C686ea
> > > > > >
> > > >
> > 1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C638608667089710854%7CUnkn
> > > > > >
> > > >
> > own%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1h
> > > > > >
> > > >
> > aWwiLCJXVCI6Mn0%3D%7C0%7C%7C%7C&sdata=nMZO565xCUO%2BwxD4tIfi
> > > > > > w6cGyYrinaEsi7XLfqyxgXg%3D&reserved=0
> > > > > >
> > > > > > AP and STA can indeed have different channels when DRCS is
> > > > > > enabled, so I think you have to check this in your patch.
> > > > > >
> > > > > > Maybe the same question here again: Wouldn't it make sense to
> > > > > > enable DRCS by default?
> > > > > >
> > > > > > Sascha
> > > > > >
> > > > >
> > > > > I will look into DRCS support later after current tasks on hand.
> > > > > This patch is a quick fix to avoid firmware crash in the specific scenario.
> > > >
> > > > With DRCS support enabled AP and STA actually can run on different
> > > > channels with the current code. You are breaking this scenario with this
> > patch.
> > > >
> > > > Sascha
> > > >
> > >
> > > DRCS will be checked in the future.
> > 
> > By future you mean v3 of this patch?
> > 
> > Sascha
> > 
> 
> No schedule now.

I am getting confused now. You want us to abandon my patch in favour of
yours, but you have no plans to update your patch to avoid a regression
that you introduce with your patch?

Sascha

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

