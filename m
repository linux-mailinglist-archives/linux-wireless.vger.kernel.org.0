Return-Path: <linux-wireless+bounces-12253-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AE894965C87
	for <lists+linux-wireless@lfdr.de>; Fri, 30 Aug 2024 11:18:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A7AB81F22E7D
	for <lists+linux-wireless@lfdr.de>; Fri, 30 Aug 2024 09:18:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11EBE16D317;
	Fri, 30 Aug 2024 09:18:42 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AAEF13AD2B
	for <linux-wireless@vger.kernel.org>; Fri, 30 Aug 2024 09:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725009522; cv=none; b=BavwrnSk6I7r1SPWmZTXerxHNNOPYyGK7GKjigU4rOdTkJrqqSB3BOnUfZUMQKhR1PuM7YMU5S40IjaUm/zQpMjcQbzGFjaj14VfIHN9LPS08PKIqp1uPCktwDvt9SUE4I8htzGEE9k2LeNUsARjZiCnvhjVgtoLTPMpPEdobKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725009522; c=relaxed/simple;
	bh=kKP1fFg9gv0oI21wlGGlNLshkZ5h492NZYtUZ+2Omvs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q4QgaAFUJi+IN8eRAaNXtezKJFp6Q9D+BRgem2LTlPsUggzjPa3h7mPnq2YcYPZNRomdJnhEDctx3lL5zSzlES+xRzUpsHWK+VM1RbasvHPMXkQzYDPjlSQHntLPbIbNXndaS25N8vNNPEBstQ4uu/Ko7dzeWlEdfMEsQ67EhfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <sha@pengutronix.de>)
	id 1sjxm6-0004PD-El; Fri, 30 Aug 2024 11:18:34 +0200
Received: from [2a0a:edc0:2:b01:1d::c5] (helo=pty.whiteo.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <sha@pengutronix.de>)
	id 1sjxm5-0047KX-E7; Fri, 30 Aug 2024 11:18:33 +0200
Received: from sha by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <sha@pengutronix.de>)
	id 1sjxm5-00ESSw-14;
	Fri, 30 Aug 2024 11:18:33 +0200
Date: Fri, 30 Aug 2024 11:18:33 +0200
From: Sascha Hauer <s.hauer@pengutronix.de>
To: Francesco Dolcini <francesco@dolcini.it>
Cc: David Lin <yu-hao.lin@nxp.com>, linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org, briannorris@chromium.org,
	kvalo@kernel.org, tsung-hsien.hsieh@nxp.com
Subject: Re: [PATCH] wifi: mwifiex: avoid AP and STA running on different
 channel
Message-ID: <ZtGOaTAEpLgD_z0W@pengutronix.de>
References: <20240830030630.825818-1-yu-hao.lin@nxp.com>
 <ZtF-dgrx28yZKG2O@gaggiata.pivistrello.it>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZtF-dgrx28yZKG2O@gaggiata.pivistrello.it>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: sha@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-wireless@vger.kernel.org

On Fri, Aug 30, 2024 at 10:10:30AM +0200, Francesco Dolcini wrote:
> +Sascha, that just sent a patch to handle the same issue.
> 
> On Fri, Aug 30, 2024 at 11:06:30AM +0800, David Lin wrote:
> > Current firmware doesn't support AP and STA running on different
> > channels simultaneously.
> > FW crash would occur in such case.
> > This patch avoids the issue by disabling AP and STA to run on
> > different channels.
> 
> Is this a generic issue of specific of some firmware version? Asking since the
> driver as you know is supporting multiple Wi-Fi device.

The driver does, unfortunately the hardware does not.

I learned this the hard way. When an accesspoint is running on uap0 and
you want to connect to an accesspoint on mlan0 then it won't work when
that accesspoint is on a different channel.

Likewise, when you are creating an accesspoint on uap0 using channel A
and another one on channel B then you'll notice that both accesspoints
will end up using channel A.

It took me a while to find that out. In the end I found the same channel
check in the nxpwifi driver.

Sascha

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

