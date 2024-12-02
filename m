Return-Path: <linux-wireless+bounces-15834-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 91DF89E0746
	for <lists+linux-wireless@lfdr.de>; Mon,  2 Dec 2024 16:41:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5810428453B
	for <lists+linux-wireless@lfdr.de>; Mon,  2 Dec 2024 15:41:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A931209681;
	Mon,  2 Dec 2024 15:41:12 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E608D209F42
	for <linux-wireless@vger.kernel.org>; Mon,  2 Dec 2024 15:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733154072; cv=none; b=MUk2s88jTSuOQFNgtC11g2KER6cBXV7R0Viiy2johTQbpmSkh1O1N3d9+2B39eIxp0tIBW/iuT2GLgnk7UsknedaZLuCpMIaCRA2LUQXM4tw9ANWEgVTWMdo2eQaCfKLlEq46HvAzlcd4r60OG4WBp5Aw3tbxUQWpR2cevupahg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733154072; c=relaxed/simple;
	bh=NfX2Pis5zW8FIY0ASt6R4GF+eolhjYGoOTlMuW0kmpo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SUxyOMY3AJy3JY6i21UzFF8octDQSW3TgdtvroKQNAEhxzr75bNrrDo3XosELSG5npRArpDSwnj7btaOxSIEUkNKWX5EOtIilB4BcdDTiViAM0eJr8Vx19XNtsLLKOykurdQ/1vNSXoX3Cu1qRDgY1iDP6wPQ4ocsX6MJgESg2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <sha@pengutronix.de>)
	id 1tI8Xm-0001eK-EZ; Mon, 02 Dec 2024 16:41:02 +0100
Received: from pty.whiteo.stw.pengutronix.de ([2a0a:edc0:2:b01:1d::c5])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <sha@pengutronix.de>)
	id 1tI8Xl-001JzE-0g;
	Mon, 02 Dec 2024 16:41:01 +0100
Received: from sha by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <sha@pengutronix.de>)
	id 1tI8Xl-00Acqz-2p;
	Mon, 02 Dec 2024 16:41:01 +0100
Date: Mon, 2 Dec 2024 16:41:01 +0100
From: Sascha Hauer <s.hauer@pengutronix.de>
To: Kalle Valo <kvalo@kernel.org>
Cc: Brian Norris <briannorris@chromium.org>,
	Francesco Dolcini <francesco@dolcini.it>,
	linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
	David Lin <yu-hao.lin@nxp.com>, kernel@pengutronix.de,
	Francesco Dolcini <francesco.dolcini@toradex.com>
Subject: Re: [PATCH v3 00/12] mwifiex: two fixes and cleanup
Message-ID: <Z03VDfTImax7lu_p@pengutronix.de>
References: <20241202-mwifiex-cleanup-1-v3-0-317a6ce0dd5b@pengutronix.de>
 <87ldwyumvq.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87ldwyumvq.fsf@kernel.org>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: sha@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-wireless@vger.kernel.org

On Mon, Dec 02, 2024 at 05:26:33PM +0200, Kalle Valo wrote:
> Sascha Hauer <s.hauer@pengutronix.de> writes:
> 
> > These are a few patches broken out from [1]. Kalle requested to limit
> > the number of patches per series to approximately 12 and Francesco to
> > move the fixes to the front of the series, so here we go.
> >
> > First two patches are fixes. First one is for host mlme support which
> > currently is in wireless-next, so no stable tag needed, second one has a
> > stable tag.
> 
> Are you sure? Apparently we didn't take any patches to wireless-next
> during this merge window (ie. last two weeks), so everything which is in
> wireless-next should be in v6.13-rc1, unless I'm missing something of
> course. Not a problem for me but wanted to point out anyway.

Forget this last sentence, I should have removed it. It was true for v1
of this series. 01/12 is already applied as 0d7c2194f17c7 ("wifi: mwifiex:
add missing locking for cfg80211 calls") and I should have dropped that
patch from this series.

Sascha

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

