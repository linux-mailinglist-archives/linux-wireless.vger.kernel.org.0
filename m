Return-Path: <linux-wireless+bounces-11172-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C740994CC18
	for <lists+linux-wireless@lfdr.de>; Fri,  9 Aug 2024 10:23:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 91CA1B240DA
	for <lists+linux-wireless@lfdr.de>; Fri,  9 Aug 2024 08:23:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 394F618DF6F;
	Fri,  9 Aug 2024 08:23:39 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B698A18E04E
	for <linux-wireless@vger.kernel.org>; Fri,  9 Aug 2024 08:23:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723191819; cv=none; b=losOdivR7be1hRdEtVqXZMn8Y5ceVuBFk04sXkz2W5Xe2xbAL2naVePLyKLfjfk7k++FIJcIwGrvHvw7D22oM2wnsdOJqZKeapPvr9/Uv3N3DlpcUSx6YagMEXJqNtYLYb2X4iLXZIRFbo5/txgb32Op9GF74KUVnFPKbUJgzk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723191819; c=relaxed/simple;
	bh=No9zsEOOt5jN+jtC6WUt3ray/MqdMRvbuCF2qSdC1WY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YQnwQePuC+TQ/SVYw1Yf7Vn/7kN1FeAZzoP17Cq40xK3rU1BaJymFGJs5FwjhI8csIlGUdhxzxr3A/nxs/XhF0oKT6j22uqQkkdxhJkwgXVedrfgujDmOS6QVp8e4GdoeZGEgQNKKiH90YXd48F7+FKo6t9d7udbkYNuKVoHoJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <sha@pengutronix.de>)
	id 1scKuA-0006lg-NL; Fri, 09 Aug 2024 10:23:22 +0200
Received: from [2a0a:edc0:2:b01:1d::c5] (helo=pty.whiteo.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <sha@pengutronix.de>)
	id 1scKu9-005cU3-LJ; Fri, 09 Aug 2024 10:23:21 +0200
Received: from sha by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <sha@pengutronix.de>)
	id 1scKu9-00Ajnc-1l;
	Fri, 09 Aug 2024 10:23:21 +0200
Date: Fri, 9 Aug 2024 10:23:21 +0200
From: Sascha Hauer <s.hauer@pengutronix.de>
To: Kalle Valo <kvalo@kernel.org>
Cc: Brian Norris <briannorris@chromium.org>,
	Francesco Dolcini <francesco@dolcini.it>,
	Yogesh Ashok Powar <yogeshp@marvell.com>,
	Bing Zhao <bzhao@marvell.com>,
	"John W. Linville" <linville@tuxdriver.com>,
	Amitkumar Karwar <akarwar@marvell.com>,
	Avinash Patil <patila@marvell.com>,
	Kiran Divekar <dkiran@marvell.com>, linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel@pengutronix.de,
	stable@vger.kernel.org
Subject: Re: [PATCH] mwifiex: duplicate static structs used in driver
 instances
Message-ID: <ZrXR-VCQWnO8nMGe@pengutronix.de>
References: <20240809-mwifiex-duplicate-static-structs-v1-1-6837b903b1a4@pengutronix.de>
 <875xsai043.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <875xsai043.fsf@kernel.org>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: sha@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-wireless@vger.kernel.org

On Fri, Aug 09, 2024 at 11:14:36AM +0300, Kalle Valo wrote:
> Sascha Hauer <s.hauer@pengutronix.de> writes:
> 
> > mwifiex_band_2ghz and mwifiex_band_5ghz are statically allocated, but
> > used and modified in driver instances. Duplicate them before using
> > them in driver instances so that different driver instances do not
> > influence each other.
> >
> > This was observed on a board which has one PCIe and one SDIO mwifiex
> > adapter. It blew up in mwifiex_setup_ht_caps(). This was called with
> > the statically allocated struct which is modified in this function.
> >
> > Cc: stable@vger.kernel.org
> > Fixes: d6bffe8bb520 ("mwifiex: support for creation of AP interface")
> > Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> 
> Should this go to wireless tree for v6.11?

Yes, that would be great.

> 
> "wifi:" missing in subject but I can add that, no need to resend because
> of this.

Ok, thanks. I'll keep that in mind for the next patches.

Sascha

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

