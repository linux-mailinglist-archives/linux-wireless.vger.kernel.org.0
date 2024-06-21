Return-Path: <linux-wireless+bounces-9421-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 41C8C911F37
	for <lists+linux-wireless@lfdr.de>; Fri, 21 Jun 2024 10:48:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F02CB28AF61
	for <lists+linux-wireless@lfdr.de>; Fri, 21 Jun 2024 08:48:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 937C8168C3C;
	Fri, 21 Jun 2024 08:48:13 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1A9918E20
	for <linux-wireless@vger.kernel.org>; Fri, 21 Jun 2024 08:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718959693; cv=none; b=JISpZCYlxz+Pu0CuNZXDpDZ1H/gOGcJAysWRunbJ5jhVTE5k3pYCNxszEZWMwgHcs8R3QWCJpUlVymwd5IxYNQu/KSEsMx81AxXClpRJEU4+gGnxqat3B1bcM2AJWbOPOVznB9rkB/PjCmqyupNH0ILIJGdvoFr4f+w609PqULE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718959693; c=relaxed/simple;
	bh=XXr7POVlG9XqfsnX8LXIEzZDRsRF0W5OS4t3283AvIs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HMj+ccZJ6jcDojUhwcCfl4BzBji7nD1Y1j+U9NHRNsriscfav9t/uCAMSA7VTxFHf1Ap/j8NARx47p4WrYtPUTO1ls6m5cSG6U1R0zR9hZzfYkZHwjNJuMCphmJq9ZSOHC2jTIxgrjGCmJLKipE2bnzJ+zbcnWUsKJOqZ8VUPOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <sha@pengutronix.de>)
	id 1sKZwI-0001eE-0j; Fri, 21 Jun 2024 10:48:10 +0200
Received: from [2a0a:edc0:2:b01:1d::c5] (helo=pty.whiteo.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <sha@pengutronix.de>)
	id 1sKZwH-003u1O-7T; Fri, 21 Jun 2024 10:48:09 +0200
Received: from sha by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <sha@pengutronix.de>)
	id 1sKZwH-006JSv-0T;
	Fri, 21 Jun 2024 10:48:09 +0200
Date: Fri, 21 Jun 2024 10:48:09 +0200
From: Sascha Hauer <s.hauer@pengutronix.de>
To: Brian Norris <briannorris@chromium.org>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
	Francesco Dolcini <francesco@dolcini.it>,
	Kalle Valo <kvalo@kernel.org>, David Lin <yu-hao.lin@nxp.com>
Subject: Re: [PATCH] wifi: mwifiex: increase max_num_akm_suites
Message-ID: <ZnU-STTaTWjHViwW@pengutronix.de>
References: <20240530130156.1651174-1-s.hauer@pengutronix.de>
 <ZnRvZMQJUr4APwUU@google.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZnRvZMQJUr4APwUU@google.com>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: sha@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-wireless@vger.kernel.org

On Thu, Jun 20, 2024 at 11:05:24AM -0700, Brian Norris wrote:
> Hi Sascha,
> 
> On Thu, May 30, 2024 at 03:01:56PM +0200, Sascha Hauer wrote:
> > The maximum number of AKM suites will be set to two if not specified by
> > the driver. Set it to CFG80211_MAX_NUM_AKM_SUITES to let userspace
> > specify up to ten AKM suites in the akm_suites array.
> > 
> > Without only the first two AKM suites will be used, further ones are
> > ignored.
> > 
> > Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> > ---
> > 
> > Current wpa_supplicant/hostapd only put a maximum of two into the
> > akm_suites array as well, a patch changing this can be found here:
> > http://lists.infradead.org/pipermail/hostap/2024-May/042720.html
> 
> Thanks for the patches and research.
> 
> Possibly dumb question: what's unique about mwifiex here? Everything you
> describe above sounds applicable to all drivers, IIUC, and I don't see
> any other driver that touches max_num_akm_suites.

I asked myself the same question and I don't have an answer to it. To me
it looks like the number of akm suites is limited by the akm_suites array
size which is CFG80211_MAX_NUM_AKM_SUITES which is 10 and that could be
used for all drivers.
max_num_akm_suites is introduced to be driver specific and so I changed
it only for the driver I am currently interested in.

Sascha

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

