Return-Path: <linux-wireless+bounces-21995-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F34CBA9AE88
	for <lists+linux-wireless@lfdr.de>; Thu, 24 Apr 2025 15:10:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 87EB49A1AF9
	for <lists+linux-wireless@lfdr.de>; Thu, 24 Apr 2025 13:09:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C322B27BF61;
	Thu, 24 Apr 2025 13:08:26 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3772838382
	for <linux-wireless@vger.kernel.org>; Thu, 24 Apr 2025 13:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745500106; cv=none; b=HkH4C5nTclXsXhVr/tYCCYwrgD+o1z3PnNl5J9KskkTJfyBzMUcx3vgPNpjT6uKJiP4zEud2am/QliUilm748es0NU8peF5jkE0CUMxRSSkaABFL3Ewr53tb3UZxDoMbqnJ0cLsTsJTYi9wvpAZSCjVLyivn7URcfFpzFlEuNqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745500106; c=relaxed/simple;
	bh=iYbzoO4iRXpvQaPVdZ1hK8L32zP603kVCbkbydkR24w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aiNu46cVNr4Zt+5c0tmBCGTvkarOfo9TRjjsJXZIbssCSTjj+j7mJmJoZsqujwTC63YN4e7+3w133pn2Zvl4w+U+2vS6bZjVQBWkRC6ry79WmsHUkLEauaoklKPIv1fn72dkYcuIaV8BXn7pjRTrTyd12Teh5PecSLh5vrztvv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <sha@pengutronix.de>)
	id 1u7wJQ-0005Q3-Hm; Thu, 24 Apr 2025 15:08:20 +0200
Received: from pty.whiteo.stw.pengutronix.de ([2a0a:edc0:2:b01:1d::c5])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <sha@pengutronix.de>)
	id 1u7wJQ-001t1E-0A;
	Thu, 24 Apr 2025 15:08:20 +0200
Received: from sha by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <sha@pengutronix.de>)
	id 1u7wJP-001Mvv-31;
	Thu, 24 Apr 2025 15:08:19 +0200
Date: Thu, 24 Apr 2025 15:08:19 +0200
From: Sascha Hauer <s.hauer@pengutronix.de>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: Brian Norris <briannorris@chromium.org>,
	Francesco Dolcini <francesco@dolcini.it>,
	linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel@pengutronix.de,
	Francesco Dolcini <francesco.dolcini@toradex.com>
Subject: Re: [PATCH v2 0/4] wifi: mwifiex: drop asynchronous init waiting code
Message-ID: <aAo3wy5cv8T1eZ-V@pengutronix.de>
References: <20250423-mwifiex-drop-asynchronous-init-v2-0-1bb951073a06@pengutronix.de>
 <09abc0efe32d29387c745f364871271ae9177627.camel@sipsolutions.net>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <09abc0efe32d29387c745f364871271ae9177627.camel@sipsolutions.net>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: sha@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-wireless@vger.kernel.org

On Wed, Apr 23, 2025 at 03:42:32PM +0200, Johannes Berg wrote:
> On Wed, 2025-04-23 at 10:21 +0200, Sascha Hauer wrote:
> > This is a spin-off from my mwifiex cleanup series. I have split the
> > original single patch into a series which hopefully makes the changes
> > easier to follow and verify.
> > 
> 
> I'm applying this, but I removed a now unused variable in the first
> patch that you only removed in the third. I guess that comment might've
> gone into the wrong patch too.
> 
> Please, everyone, especially when resubmitting look at patchwork first,
> there's a reason I put the bot there :)

As an occasional WiFi developer I wasn't aware of this. Now that I am
I'll look there next time.

Thanks for fixing.

Sascha

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

