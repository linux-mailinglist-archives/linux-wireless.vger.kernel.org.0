Return-Path: <linux-wireless+bounces-11947-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 820FE95EAB8
	for <lists+linux-wireless@lfdr.de>; Mon, 26 Aug 2024 09:43:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E6A92896E3
	for <lists+linux-wireless@lfdr.de>; Mon, 26 Aug 2024 07:43:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE343139CE9;
	Mon, 26 Aug 2024 07:43:05 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47A7785654
	for <linux-wireless@vger.kernel.org>; Mon, 26 Aug 2024 07:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724658185; cv=none; b=U3RtUHH0BjQsqzBdfWv4m88osJED+CXR8PMmgyth0XKh8gVAGh5yWobHzC6wI/Y3ZeEhu7/oIqC7gv9+8/m7yxy1vwWGEVgEsu2hQiGIWDQjwmSnxMuwXErJ37eWqxnzwCcFZwFbCpDhGsUOp2bVdnzomUWzUvF6JkdrgX5UT/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724658185; c=relaxed/simple;
	bh=UuFnM833sZHAtd5I23V8mgAJ7A1r9IgMzyY+EAQUmlU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P0t1Xe1OEBhWeuMlUg4RrOS9p/CA6KssPjOgsfrF0ysxU0MREwgn5MJyNlgM0M8aHfmZY4Cg6NFDaffnrNiZI8HWnvXp4TPlpcqueW3YnG8GA6mAGuZ3jelAvPACN2sH0xC6KGn09RB5nFZpnYyiHB5e6YZPssu5+I7c5SDhRS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <sha@pengutronix.de>)
	id 1siUNS-0006LC-ET; Mon, 26 Aug 2024 09:43:02 +0200
Received: from [2a0a:edc0:2:b01:1d::c5] (helo=pty.whiteo.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <sha@pengutronix.de>)
	id 1siUNR-0038OV-JG; Mon, 26 Aug 2024 09:43:01 +0200
Received: from sha by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <sha@pengutronix.de>)
	id 1siUNR-006xYj-1Z;
	Mon, 26 Aug 2024 09:43:01 +0200
Date: Mon, 26 Aug 2024 09:43:01 +0200
From: Sascha Hauer <s.hauer@pengutronix.de>
To: Francesco Dolcini <francesco@dolcini.it>
Cc: David Lin <yu-hao.lin@nxp.com>, linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org, kvalo@kernel.org,
	johannes@sipsolutions.net, briannorris@chromium.org,
	tsung-hsien.hsieh@nxp.com, kernel@pengutronix.de
Subject: Re: [PATCH v2 00/43] wifi: nxpwifi: create nxpwifi to support iw61x
Message-ID: <ZswyBSyDC8it95Zt@pengutronix.de>
References: <20240809094533.1660-1-yu-hao.lin@nxp.com>
 <Zsc1efkBHDXdZtfJ@pengutronix.de>
 <20240824134839.GA21315@francesco-nb>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240824134839.GA21315@francesco-nb>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: sha@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-wireless@vger.kernel.org

On Sat, Aug 24, 2024 at 03:48:39PM +0200, Francesco Dolcini wrote:
> On Thu, Aug 22, 2024 at 02:56:25PM +0200, Sascha Hauer wrote:
> > On Fri, Aug 09, 2024 at 05:44:50PM +0800, David Lin wrote:
> > > This series adds support for IW61x which is a new family of 2.4/5 GHz
> > > dual-band 1x1 Wi-Fi 6, Bluetooth/Bluetooth Low Energy 5.2 and 15.4
> > > tri-radio single chip by NXP. These devices support 20/40/80MHz
> > > single spatial stream in both STA and AP mode. Communication to the
> > > IW61x is done via SDIO interface
> > > 
> > > This driver is a derivative of existing Mwifiex [1] and based on similar
> > > full-MAC architecture [2]. It has been tested with i.MX8M Mini evaluation
> > > kits in both AP and STA mode.
> > > 
> > > All code passes sparse and checkpatch
> > > 
> > > Data sheet (require registration):
> > > https://www.nxp.com/products/wireless-connectivity/wi-fi-plus-bluetooth-
> > > plus-802-15-4/2-4-5-ghz-dual-band-1x1-wi-fi-6-802-11ax-plus-bluetooth-5-
> > > 4-plus-802-15-4-tri-radio-solution:IW612
> > > 
> > > Known gaps to be addressed in the following patches,
> > >   - Enable 11ax capabilities. This initial patch support up to 11ac.
> > >   - Support DFS channel. This initial patch doesn't support DFS channel in
> > >     both AP/STA mode.
> > > 
> > > This patch is presented as a request for comment with the intention of being
> > > made into a patch after initial feedbacks are addressed
> > > 
> > > [1] We had considered adding IW61x to mwifiex driver, however due to
> > >     FW architecture, host command interface and supported features are
> > >     significantly different, we have to create the new nxpwifi driver.
> > >     Subsequent NXP chipsets will be added and sustained in this new driver.
> > 
> > I added IW61x support to the mwifiex driver and besides the VDLL
> > handling which must be added I didn't notice any differences. There
> > might be other differences, but I doubt that these can't be integrated
> > into the mwifiex driver.
> 
> Maybe you can share an RFC patch with what you currently have available
> to support IW61x within the current mwifiex driver?

I just did, see:

https://lore.kernel.org/linux-wireless/20240826072648.167004-1-s.hauer@pengutronix.de/

Sascha

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

