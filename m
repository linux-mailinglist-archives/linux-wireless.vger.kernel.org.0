Return-Path: <linux-wireless+bounces-12725-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BB4AA97290D
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Sep 2024 07:56:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ED27D1C23D9A
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Sep 2024 05:56:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E9CB170A1B;
	Tue, 10 Sep 2024 05:55:55 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12F3516BE0D
	for <linux-wireless@vger.kernel.org>; Tue, 10 Sep 2024 05:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725947755; cv=none; b=E/jwvyrJg6IB09HOJGdOpQcwUhcrekglSwpfq/HvKLqLSGjjEc/i3pAAMpVLYA5gv/aAc31NxZCUHLdrZ/4KmG5AqAzd+PAWWa1b9T5Bopez6zWDLjDdJk8HayTGG9VG+oiahRxK3ioPCJFCXX7fTGA4vrgAMzuihefI1ZuZOXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725947755; c=relaxed/simple;
	bh=Ho4ZzCdLVym7iH2NjL0Cr3mj1YvTC1wvKFr2o0rQ0Y0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eQDQv4WcAqijXeACqK5B81xzI31jc/chMp9R+Hb6AYw+6fpyvoE1Br1GbFScVdxcMddMpzdz/Z1b2jeIp5Yo6aYzeo/PGNrDalxUy44pmPgTdhoNARo9xZw0Z6gvWa+pdGjcd9MADu3nfcF5UeshBLaB9ov9OxicxOHF6PulGOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <sha@pengutronix.de>)
	id 1sntqv-0007am-IB; Tue, 10 Sep 2024 07:55:49 +0200
Received: from [2a0a:edc0:2:b01:1d::c5] (helo=pty.whiteo.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <sha@pengutronix.de>)
	id 1sntqu-006pDf-Gj; Tue, 10 Sep 2024 07:55:48 +0200
Received: from sha by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <sha@pengutronix.de>)
	id 1sntqu-00HW9M-1L;
	Tue, 10 Sep 2024 07:55:48 +0200
Date: Tue, 10 Sep 2024 07:55:48 +0200
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
Message-ID: <Zt_fZEJyiCyanf7X@pengutronix.de>
References: <20240902084311.2607-1-yu-hao.lin@nxp.com>
 <ZtWHhSQlPVMekW1I@pengutronix.de>
 <PA4PR04MB9638EC10C0B656B750D922ADD1922@PA4PR04MB9638.eurprd04.prod.outlook.com>
 <Zt9blTxk88Opujsk@pengutronix.de>
 <PA4PR04MB963813D69B4D87B7147704A5D19A2@PA4PR04MB9638.eurprd04.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PA4PR04MB963813D69B4D87B7147704A5D19A2@PA4PR04MB9638.eurprd04.prod.outlook.com>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: sha@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-wireless@vger.kernel.org

On Tue, Sep 10, 2024 at 01:55:14AM +0000, David Lin wrote:
> > From: Sascha Hauer <s.hauer@pengutronix.de>
> > Sent: Tuesday, September 10, 2024 4:33 AM
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
> > On Mon, Sep 02, 2024 at 10:35:01AM +0000, David Lin wrote:
> > > > From: Sascha Hauer <s.hauer@pengutronix.de>
> > > > Sent: Monday, September 2, 2024 5:38 PM
> > > > To: David Lin <yu-hao.lin@nxp.com>
> > > > Cc: linux-wireless@vger.kernel.org; linux-kernel@vger.kernel.org;
> > > > briannorris@chromium.org; kvalo@kernel.org; francesco@dolcini.it;
> > > > Pete Hsieh <tsung-hsien.hsieh@nxp.com>
> > > > Subject: [EXT] Re: [PATCH v2] wifi: mwifiex: avoid AP and STA
> > > > running on different channel
> > > >
> > > > On Mon, Sep 02, 2024 at 04:43:11PM +0800, David Lin wrote:
> > > > > Current firmware doesn't support AP and STA running on different
> > > > > channels simultaneously.
> > > >
> > > > As mentioned here:
> > > >
> > > > https://eur01.safelinks.protection.outlook.com/?url=https%3A%2F%2Flo
> > > >
> > re.kern%2F&data=05%7C02%7Cyu-hao.lin%40nxp.com%7C7712df39ac37414fd
> > a7
> > > >
> > e08dcd10eac35%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C6386
> > 15108
> > > >
> > 157502805%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV
> > 2luMz
> > > >
> > IiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C0%7C%7C%7C&sdata=URNJPJE17iRY
> > Tu4i
> > > > rx7eQAC97tE5OE6a4kUfjUwuaVU%3D&reserved=0
> > > >
> > el.org%2Fall%2FZtGnWC7SPHt7Vbbp%40pengutronix.de%2F&data=05%7C02%
> > > >
> > 7Cyu-hao.lin%40nxp.com%7Cce9b7d4e417c41113c7d08dccb32fc49%7C686ea
> > > >
> > 1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C638608667089710854%7CUnkn
> > > >
> > own%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1h
> > > >
> > aWwiLCJXVCI6Mn0%3D%7C0%7C%7C%7C&sdata=nMZO565xCUO%2BwxD4tIfi
> > > > w6cGyYrinaEsi7XLfqyxgXg%3D&reserved=0
> > > >
> > > > AP and STA can indeed have different channels when DRCS is enabled,
> > > > so I think you have to check this in your patch.
> > > >
> > > > Maybe the same question here again: Wouldn't it make sense to enable
> > > > DRCS by default?
> > > >
> > > > Sascha
> > > >
> > >
> > > I will look into DRCS support later after current tasks on hand.
> > > This patch is a quick fix to avoid firmware crash in the specific scenario.
> > 
> > With DRCS support enabled AP and STA actually can run on different channels
> > with the current code. You are breaking this scenario with this patch.
> > 
> > Sascha
> > 
> 
> DRCS will be checked in the future.

By future you mean v3 of this patch?

Sascha

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

