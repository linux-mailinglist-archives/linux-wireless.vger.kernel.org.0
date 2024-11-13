Return-Path: <linux-wireless+bounces-15270-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 295039C74B1
	for <lists+linux-wireless@lfdr.de>; Wed, 13 Nov 2024 15:45:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E3855283C78
	for <lists+linux-wireless@lfdr.de>; Wed, 13 Nov 2024 14:45:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71D171DFD8C;
	Wed, 13 Nov 2024 14:44:39 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCD251EF956
	for <linux-wireless@vger.kernel.org>; Wed, 13 Nov 2024 14:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731509079; cv=none; b=dBSRspdRnoH2cTRYh4AFJccjP5MVvzDe1cKYURLCkl1W+xXXkSxCV2UdSk3TUNjFlqqNbFYHkq1yko1kCPkrOH5+bdTh3a+4Ai5ogZjNH+G7IUICf9O+cgNk0HHfeciukLSuv1a2fdStm4A7tB3vV/ID72+M3Pkew+FclcuYyvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731509079; c=relaxed/simple;
	bh=ckSeqNZkTzZoc8tNAlJMv3QaS0XCMd5+YScgBG0e10Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gX5jADmnUAuS1aNZH6ryHBW4BtY1WzMLF0x6pNBZvNyLADgEDBRapGAe0Ptmbz2lBAC/bisvXw68JyPQnJKQg4RnnA+d4hrRIklY5q8lUcWHf0rgDINGerkJd3B2ctQRkpbK+TC5eEq0mNcvZka+mo6BFXV1YHxSQUEEtf+ProU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <sha@pengutronix.de>)
	id 1tBEbd-0007tl-30; Wed, 13 Nov 2024 15:44:29 +0100
Received: from pty.whiteo.stw.pengutronix.de ([2a0a:edc0:2:b01:1d::c5])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <sha@pengutronix.de>)
	id 1tBEbc-000air-1W;
	Wed, 13 Nov 2024 15:44:28 +0100
Received: from sha by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <sha@pengutronix.de>)
	id 1tBEbc-009iom-1D;
	Wed, 13 Nov 2024 15:44:28 +0100
Date: Wed, 13 Nov 2024 15:44:28 +0100
From: Sascha Hauer <s.hauer@pengutronix.de>
To: Brian Norris <briannorris@chromium.org>
Cc: Francesco Dolcini <francesco@dolcini.it>, Kalle Valo <kvalo@kernel.org>,
	linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
	David Lin <yu-hao.lin@nxp.com>, kernel@pengutronix.de,
	stable@vger.kernel.org
Subject: Re: [PATCH v2 02/12] wifi: mwifiex: fix MAC address handling
Message-ID: <ZzS7TKwPC1uxqzbg@pengutronix.de>
References: <20240918-mwifiex-cleanup-1-v2-0-2d0597187d3c@pengutronix.de>
 <20240918-mwifiex-cleanup-1-v2-2-2d0597187d3c@pengutronix.de>
 <ZwB3FCdpL85yA2Si@google.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZwB3FCdpL85yA2Si@google.com>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: sha@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-wireless@vger.kernel.org

Hi Brian,

It's been a while, but I'd like to get this forward now.

On Fri, Oct 04, 2024 at 04:15:32PM -0700, Brian Norris wrote:
> I think I'm generally supportive of the direction this changes things,
> but I'm a bit hesitant about two things:
> 1. the potential user-visible changes and
> 2. the linux-stable backport (Cc stable below)
> 
> For 1: MAC addresses are important in some contexts, and this might
> significantly change the addresses that devices get in practice. Such
> users might not really care about the weird details of when the address
> incremented; but they *probably* care that a certain sequence of "boot
> device; run hostapd with <foo> config file" produces the same address.
> 
> Also, I'm not sure I know enough of the implications of potential
> over-use of the locally administered bit. Are there significant
> downsides to it (aside from the simple fact that it's a different
> address)?

Not that I know of, but that doesn't mean much.

> 
> And I see that you rightly don't know how many addresses are actually
> reserved, but I have an educated guess that it's not just 1.

Even if there are more addresses reserved, we don't know which these
are, see below.

> For one,
> this driver used to default-create 3 interfaces:
> 1211c961170c mwifiex: do not create AP and P2P interfaces upon driver loading
> 
> and when we stopped doing that, we still kept support for a module
> parameter for the old way:
> 0013c7cebed6 mwifiex: module load parameter for interface creation
> 
> Perhaps these "initial" interfaces should at least be allowed permanent
> addresses?

I started up a board with the downstream driver. It comes up with these
MAC addresses:

wlp1s0    Link encap:Ethernet  HWaddr 34:6F:24:4E:E0:3D
uap0      Link encap:Ethernet  HWaddr 36:6F:24:4E:E1:3D
wfd0      Link encap:Ethernet  HWaddr 36:6F:24:4E:E0:3D

The permanent address from EEPROM is 34:6F:24:4E:E0:3D which is
used for wlp1s0. For the other addresses the locally admistered bit is
set (34 -> 36). Here's the corresponding code:

	if (priv->bss_type == MLAN_BSS_TYPE_WIFIDIRECT) {
		if (priv->bss_virtual) {
			...
		} else {
			priv->current_addr[0] |= 0x02;
		}
	}

	if (priv->bss_type != MLAN_BSS_TYPE_WIFIDIRECT) {
		if (priv->bss_index) {
			priv->current_addr[0] |= 0x02;
			priv->current_addr[4] += priv->bss_index;
		}
	}

See https://github.com/nxp-imx/mwifiex/blob/lf-6.6.3_1.0.0/mxm_wifiex/wlan_src/mlinux/moal_main.c#L8383

Note this behaviour was changed in the driver in a0835444f1
("mxm_wifiex: update to mxm5x17344.p1 release"). Before that the driver
has just done a priv->current_addr[4] += priv->bss_index without
setting the locally admistered bit. Of course the commit message
says nothing about the reasons for this change.

The downstream driver puts the bss_num (or bss_index) into different
bits than the upstream driver does. It uses current_addr[4] whereas the
upstream driver uses current_addr[5]. So even when there's more than
one MAC address reserved for one chip, both drivers disagree on which
addresses these are.

Given that, I think our safest bet is to always set the locally
admistered bit for derived MAC addresses.

> 
> So anyway, I don't really know for sure the right answer, but I want to
> log my concerns, in case you had more thoughts on backward
> compatibility.
> 
> And given all the uncertainty above, I'm extra hesitant about
> backporting likely-user-visible changes to stable (#2).

I can remove the stable tag if makes you feel more comfortable.

Sascha

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

