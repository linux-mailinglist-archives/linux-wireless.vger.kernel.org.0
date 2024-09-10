Return-Path: <linux-wireless+bounces-12729-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 473F0972A80
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Sep 2024 09:22:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 850C3B20C25
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Sep 2024 07:22:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BA5417C7C1;
	Tue, 10 Sep 2024 07:22:00 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57A0617C21E
	for <linux-wireless@vger.kernel.org>; Tue, 10 Sep 2024 07:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725952920; cv=none; b=WZo5l7GtGtJQbyMKWLOMO+v0fwbkPUCkmGAG2Th5/7QO7RzlZdrbf8hfBACndi0tCJgXckFu4jLynIu5gl3mcbkyu2APl7lh2bEeqSNkLKYReuWSQmnmb0A9yw1HlbXzWxMuBYIOtAlYySrJm6D+ymhATMJZ1zTKFBWqAOL4u6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725952920; c=relaxed/simple;
	bh=17DHh29SsA69a1qIaeiNMQW6bO89LXYqE99pBAZHW6k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Iyp1Ymcfmi2v2xLKWwiUoKUHZTGebO8ndXeeYY7es82M+6KZD9+ZhF8Kg520Wdk3FOkP/rQGyjOmlhlOtS61pxnjM9Ubxd3fX9mQiZn7JpKo8bPhTMaN6W2ap95tMndy6KFSBe1+f7SLEZBqqOEiuhzYJRjV1BUGV2pjh05ILIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <sha@pengutronix.de>)
	id 1snvCG-0005TO-MW; Tue, 10 Sep 2024 09:21:56 +0200
Received: from [2a0a:edc0:2:b01:1d::c5] (helo=pty.whiteo.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <sha@pengutronix.de>)
	id 1snvCF-006qDs-LD; Tue, 10 Sep 2024 09:21:55 +0200
Received: from sha by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <sha@pengutronix.de>)
	id 1snvCF-00HXL3-1l;
	Tue, 10 Sep 2024 09:21:55 +0200
Date: Tue, 10 Sep 2024 09:21:55 +0200
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
Message-ID: <Zt_zkxGsY2X-8-4z@pengutronix.de>
References: <20240902084311.2607-1-yu-hao.lin@nxp.com>
 <ZtWHhSQlPVMekW1I@pengutronix.de>
 <PA4PR04MB9638EC10C0B656B750D922ADD1922@PA4PR04MB9638.eurprd04.prod.outlook.com>
 <Zt9blTxk88Opujsk@pengutronix.de>
 <PA4PR04MB963813D69B4D87B7147704A5D19A2@PA4PR04MB9638.eurprd04.prod.outlook.com>
 <Zt_fZEJyiCyanf7X@pengutronix.de>
 <PA4PR04MB9638C8978D9C6360A9B214E4D19A2@PA4PR04MB9638.eurprd04.prod.outlook.com>
 <Zt_h_mW4nFWKu2SI@pengutronix.de>
 <PA4PR04MB96389B2CC16060957878D0D3D19A2@PA4PR04MB9638.eurprd04.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PA4PR04MB96389B2CC16060957878D0D3D19A2@PA4PR04MB9638.eurprd04.prod.outlook.com>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: sha@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-wireless@vger.kernel.org

On Tue, Sep 10, 2024 at 06:18:57AM +0000, David Lin wrote:
> > > > > > With DRCS support enabled AP and STA actually can run on
> > > > > > different channels with the current code. You are breaking this
> > > > > > scenario with this
> > > > patch.
> > > > > >
> > > > > > Sascha
> > > > > >
> > > > >
> > > > > DRCS will be checked in the future.
> > > >
> > > > By future you mean v3 of this patch?
> > > >
> > > > Sascha
> > > >
> > >
> > > No schedule now.
> > 
> > I am getting confused now. You want us to abandon my patch in favour of yours,
> > but you have no plans to update your patch to avoid a regression that you
> > introduce with your patch?
> > 
> > Sascha
> > 
> 
> My patch resolves the same issue as your patch. But your patch can't
> let AP and STA run on the same channel if some wiphy parameters are
> set.
> 
> I wonder did you test your patch?

I finally see what you mean with "some wiphy parameters are set".
I did test my patch and I didn't run into this issue, because I haven't
set anything like rts_threshold in my config.

Nevertheless what I am trying to tell you in this thread is: Your patch
introduces a regression and needs an update.

It's not about my patch or your patch, both are currently not suitable
for inclusion and the question is: will you update your patch?

Sascha

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

