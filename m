Return-Path: <linux-wireless+bounces-11742-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF3CF959AB5
	for <lists+linux-wireless@lfdr.de>; Wed, 21 Aug 2024 13:51:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 920812812A0
	for <lists+linux-wireless@lfdr.de>; Wed, 21 Aug 2024 11:51:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96BD31662F8;
	Wed, 21 Aug 2024 11:33:23 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3807C155307
	for <linux-wireless@vger.kernel.org>; Wed, 21 Aug 2024 11:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724240003; cv=none; b=slFlhTOzdyIANQAvwRYujKpq0hHuGHppsXj/2Zh3mnnb5fCN+FEeqTh+mt8429A8aSnPQSqA77xdye/LNaZpVovKbE0mlSCh7kZXLC5Q0JMGtXbS+RmmpRpwP4GoM2s0f8yX9LTJNZZX4NI5x2uXy4i4tBYle5YunU0c1UIdfwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724240003; c=relaxed/simple;
	bh=HhmDhHLFWbrm9gNwj7yxa11vICPIvCxKsV9cs46JC9o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Wo6bP8lOH8cN9PtZnds8tyiWYsBk4It86+qaGFXDh7LiUBDxVF2CnATn2CiKLpjbxTv2KZJNBa4FCYz5Dc6M7K0Qd4MTNywFyhqctV4zLUvk93+ECm+ZZvSOpqYyWeu1SrdeZnSQmgk6rJFzN2nZRW/p5U/6kds6pBLnSxnbdxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <sha@pengutronix.de>)
	id 1sgjaY-0006LO-EH; Wed, 21 Aug 2024 13:33:18 +0200
Received: from [2a0a:edc0:2:b01:1d::c5] (helo=pty.whiteo.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <sha@pengutronix.de>)
	id 1sgjaY-001zwn-0m; Wed, 21 Aug 2024 13:33:18 +0200
Received: from sha by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <sha@pengutronix.de>)
	id 1sgjaX-00FVWO-2y;
	Wed, 21 Aug 2024 13:33:17 +0200
Date: Wed, 21 Aug 2024 13:33:17 +0200
From: Sascha Hauer <s.hauer@pengutronix.de>
To: Francesco Dolcini <francesco@dolcini.it>
Cc: Brian Norris <briannorris@chromium.org>, Kalle Valo <kvalo@kernel.org>,
	linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel@pengutronix.de
Subject: Re: [PATCH 00/31] wifi: mwifiex: cleanup driver
Message-ID: <ZsXQfQQkdVk3HKjG@pengutronix.de>
References: <20240820-mwifiex-cleanup-v1-0-320d8de4a4b7@pengutronix.de>
 <1B5E3131-0595-47A8-BB8E-14B7B6C3FA7F@dolcini.it>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1B5E3131-0595-47A8-BB8E-14B7B6C3FA7F@dolcini.it>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: sha@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-wireless@vger.kernel.org

On Tue, Aug 20, 2024 at 03:34:12PM +0200, Francesco Dolcini wrote:
> Hello Sasha,
> thanks for the patches.
> 
> Il 20 agosto 2024 13:55:25 CEST, Sascha Hauer <s.hauer@pengutronix.de> ha scritto:
> >This series has a bunch of cleanup and bugfix patches for the mwifiex
> >driver
> 
> 
> > 24 files changed, 365 insertions(+), 729 deletions(-)
> 
> I had a quick look at the series, and it looks fine to me, I'll try to
> have a proper look in the next couple of weeks. What I wonder is
> what's the risk of introducing some subtle bugs because of firmware
> differences, what device/firmware combination were you able to test?

I tested this on a SD8978 aka iw416 SDIO card.

I just tested this on a IW61x SDIO card (mainline support for this one
still in my queue) and it didn't work, I'll investigate.

Other than that I also have a PCIe card I'll test this on next time.

I don't know there firmware versions currently, but I used the latest
ones available in linux-firmware.

Sascha

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

