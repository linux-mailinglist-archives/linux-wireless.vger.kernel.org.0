Return-Path: <linux-wireless+bounces-12705-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CCFDF9723C0
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Sep 2024 22:33:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 23284B22443
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Sep 2024 20:33:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73CEF18A6AB;
	Mon,  9 Sep 2024 20:33:30 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 655BE189F45
	for <linux-wireless@vger.kernel.org>; Mon,  9 Sep 2024 20:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725914010; cv=none; b=fITKMTHvY5IR1AvwTEABIYSEb/cmu+b6IC+k0beufgn4oxh0QuH3E1Wku9g51epMpo8+LxZzXvuDRJ7PDz6o7yutnA+K4Rz53fL802wh7S6C9Y7KdAeWLszdnjGwFB7I7A3afgPXbNdRjrKbmeMnmIH6dHdfC/+bG8KikcVmVf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725914010; c=relaxed/simple;
	bh=VGLIIRn1nVAec8poWKYBfG+HxzfdtU61H0cDNFIcwGI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NJZZtanI1+K1mFL8qsXYGetzp90owxgH5/XCWnMq3b/y4G+qhDBa4+x1BEdvt82rJSh7z7X+QQPJ35iZSUHd4IziPak2l/yizjea5C+FVjNnjO7zq8WRzc8M6jikKoJWDgU8nT/MDD2r80s8B36zuctnfvEvw7NRUp1/2fBvm6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <sha@pengutronix.de>)
	id 1snl4g-0002X6-Ns; Mon, 09 Sep 2024 22:33:26 +0200
Received: from [2a0a:edc0:2:b01:1d::c5] (helo=pty.whiteo.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <sha@pengutronix.de>)
	id 1snl4f-006jgi-Ug; Mon, 09 Sep 2024 22:33:25 +0200
Received: from sha by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <sha@pengutronix.de>)
	id 1snl4f-00FoVQ-2j;
	Mon, 09 Sep 2024 22:33:25 +0200
Date: Mon, 9 Sep 2024 22:33:25 +0200
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
Message-ID: <Zt9blTxk88Opujsk@pengutronix.de>
References: <20240902084311.2607-1-yu-hao.lin@nxp.com>
 <ZtWHhSQlPVMekW1I@pengutronix.de>
 <PA4PR04MB9638EC10C0B656B750D922ADD1922@PA4PR04MB9638.eurprd04.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PA4PR04MB9638EC10C0B656B750D922ADD1922@PA4PR04MB9638.eurprd04.prod.outlook.com>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: sha@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-wireless@vger.kernel.org

On Mon, Sep 02, 2024 at 10:35:01AM +0000, David Lin wrote:
> > From: Sascha Hauer <s.hauer@pengutronix.de>
> > Sent: Monday, September 2, 2024 5:38 PM
> > To: David Lin <yu-hao.lin@nxp.com>
> > Cc: linux-wireless@vger.kernel.org; linux-kernel@vger.kernel.org;
> > briannorris@chromium.org; kvalo@kernel.org; francesco@dolcini.it; Pete
> > Hsieh <tsung-hsien.hsieh@nxp.com>
> > Subject: [EXT] Re: [PATCH v2] wifi: mwifiex: avoid AP and STA running on
> > different channel
> >
> > On Mon, Sep 02, 2024 at 04:43:11PM +0800, David Lin wrote:
> > > Current firmware doesn't support AP and STA running on different
> > > channels simultaneously.
> >
> > As mentioned here:
> >
> > https://lore.kern/
> > el.org%2Fall%2FZtGnWC7SPHt7Vbbp%40pengutronix.de%2F&data=05%7C02%
> > 7Cyu-hao.lin%40nxp.com%7Cce9b7d4e417c41113c7d08dccb32fc49%7C686ea
> > 1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C638608667089710854%7CUnkn
> > own%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1h
> > aWwiLCJXVCI6Mn0%3D%7C0%7C%7C%7C&sdata=nMZO565xCUO%2BwxD4tIfi
> > w6cGyYrinaEsi7XLfqyxgXg%3D&reserved=0
> >
> > AP and STA can indeed have different channels when DRCS is enabled, so I
> > think you have to check this in your patch.
> >
> > Maybe the same question here again: Wouldn't it make sense to enable DRCS
> > by default?
> >
> > Sascha
> >
> 
> I will look into DRCS support later after current tasks on hand.
> This patch is a quick fix to avoid firmware crash in the specific scenario.

With DRCS support enabled AP and STA actually can run on different
channels with the current code. You are breaking this scenario with this
patch.

Sascha

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

