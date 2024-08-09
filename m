Return-Path: <linux-wireless+bounces-11175-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EA9E94CD08
	for <lists+linux-wireless@lfdr.de>; Fri,  9 Aug 2024 11:13:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1C1E71F21BF6
	for <lists+linux-wireless@lfdr.de>; Fri,  9 Aug 2024 09:13:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE0DF18FDC9;
	Fri,  9 Aug 2024 09:13:04 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7428618FC8D
	for <linux-wireless@vger.kernel.org>; Fri,  9 Aug 2024 09:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723194784; cv=none; b=Z0blBgv8qGQyOv/B7LJQNe8MRS7sSPtlhCFq6FaTgAxF4l5btIa/2U1OgD5OSMay2LXo3Rs9rjohgoSFr6Mzm5mfPi62nwIu/t48zrsj2K45Au88qC8bSJppFY6ODgawKMbPo7CXCLHVispZzW0nVlDkyftEDM7bcqIF6yu/bTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723194784; c=relaxed/simple;
	bh=e4DNm1/lJ7U+4PWb6B02i+0u5KN8oACNjU3d7VFKIIQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ntceGrIc0zNCTfzlA0YuQ5uyHbdfall00hMwSVQSuM8hk2Hr5alUyLtg8Gyg8hWAKNnSJ8CqhBz8Cn2FFd5sDLJY+LK82f9Rg8E3GzEpnMarfJmOOxWgqCR4SeJYNk0SI6AExIfWcHVWq3+RUJTzwCQ2ptv0fV+cffFPRabYVW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <sha@pengutronix.de>)
	id 1scLfl-0002QM-Mo; Fri, 09 Aug 2024 11:12:33 +0200
Received: from [2a0a:edc0:2:b01:1d::c5] (helo=pty.whiteo.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <sha@pengutronix.de>)
	id 1scLfk-005dED-Dg; Fri, 09 Aug 2024 11:12:32 +0200
Received: from sha by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <sha@pengutronix.de>)
	id 1scLfk-00Al7G-0x;
	Fri, 09 Aug 2024 11:12:32 +0200
Date: Fri, 9 Aug 2024 11:12:32 +0200
From: Sascha Hauer <s.hauer@pengutronix.de>
To: Ping-Ke Shih <pkshih@realtek.com>
Cc: Brian Norris <briannorris@chromium.org>,
	Francesco Dolcini <francesco@dolcini.it>,
	Kalle Valo <kvalo@kernel.org>,
	Yogesh Ashok Powar <yogeshp@marvell.com>,
	Bing Zhao <bzhao@marvell.com>,
	"John W. Linville" <linville@tuxdriver.com>,
	Amitkumar Karwar <akarwar@marvell.com>,
	Avinash Patil <patila@marvell.com>,
	Kiran Divekar <dkiran@marvell.com>,
	"linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"kernel@pengutronix.de" <kernel@pengutronix.de>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH] mwifiex: duplicate static structs used in driver
 instances
Message-ID: <ZrXdgIJe6U4sJJwU@pengutronix.de>
References: <20240809-mwifiex-duplicate-static-structs-v1-1-6837b903b1a4@pengutronix.de>
 <4021e822699b44939f6a4731290e2627@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4021e822699b44939f6a4731290e2627@realtek.com>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: sha@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-wireless@vger.kernel.org

On Fri, Aug 09, 2024 at 08:49:32AM +0000, Ping-Ke Shih wrote:
> Sascha Hauer <s.hauer@pengutronix.de> wrote:
> > +       wiphy->bands[NL80211_BAND_2GHZ] = devm_kmemdup(adapter->dev,
> > +                                                      &mwifiex_band_2ghz,
> > +                                                      sizeof(mwifiex_band_2ghz),
> > +                                                      GFP_KERNEL);
> 
> It seems like you forget to free the duplicate memory somewhere?

It's freed automatically when adapter->dev is released, see the various
devm_* functions

Sascha


-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

