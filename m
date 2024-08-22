Return-Path: <linux-wireless+bounces-11804-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A8E9495B57B
	for <lists+linux-wireless@lfdr.de>; Thu, 22 Aug 2024 14:56:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D97B01C23378
	for <lists+linux-wireless@lfdr.de>; Thu, 22 Aug 2024 12:56:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B1401C9DDB;
	Thu, 22 Aug 2024 12:56:31 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 716CB1C9429
	for <linux-wireless@vger.kernel.org>; Thu, 22 Aug 2024 12:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724331390; cv=none; b=rpmfiJUff+mWnjeAPjTzhY0sKYpbHmPnZMXZMzur63IutZHYyXCtjoKXNgJTmsQ/19ojODg58kNy6ZZKrFYb7dV6VRPsWmFdgzAp6pnxc7yp/pXn+pO6ACJryMsRwySjmLFO22qXDUKTWodHa5LGHILX2vQvU/79LcCR/jok2e4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724331390; c=relaxed/simple;
	bh=VvngIUKtbPcRiyndIMGrmlcDBJTAHeu5snYICi/jOIU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o+UB1MU16SU6KqssH1uCCywMiZfU0G2mmclpknUWIlJYfQIo1GhiHipWkaWKCbcErigkHK0JT47WHRe993DrXPJvYBRzufwe3pYtEDGRSRcRrkrwHUnrAvgks3BlhPBRU94sxhXtChgJ6fQnlJawDRj4D6fo+AkKMwoju/4Oevg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <sha@pengutronix.de>)
	id 1sh7MY-00051F-O0; Thu, 22 Aug 2024 14:56:26 +0200
Received: from [2a0a:edc0:0:1101:1d::28] (helo=dude02.red.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <sha@pengutronix.de>)
	id 1sh7MX-002Fme-Rr; Thu, 22 Aug 2024 14:56:25 +0200
Received: from sha by dude02.red.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <sha@pengutronix.de>)
	id 1sh7MX-007vXj-2Y;
	Thu, 22 Aug 2024 14:56:25 +0200
Date: Thu, 22 Aug 2024 14:56:25 +0200
From: Sascha Hauer <s.hauer@pengutronix.de>
To: David Lin <yu-hao.lin@nxp.com>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
	kvalo@kernel.org, johannes@sipsolutions.net,
	briannorris@chromium.org, francesco@dolcini.it,
	tsung-hsien.hsieh@nxp.com, kernel@pengutronix.de
Subject: Re: [PATCH v2 00/43] wifi: nxpwifi: create nxpwifi to support iw61x
Message-ID: <Zsc1efkBHDXdZtfJ@pengutronix.de>
References: <20240809094533.1660-1-yu-hao.lin@nxp.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240809094533.1660-1-yu-hao.lin@nxp.com>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: sha@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-wireless@vger.kernel.org

On Fri, Aug 09, 2024 at 05:44:50PM +0800, David Lin wrote:
> This series adds support for IW61x which is a new family of 2.4/5 GHz
> dual-band 1x1 Wi-Fi 6, Bluetooth/Bluetooth Low Energy 5.2 and 15.4
> tri-radio single chip by NXP. These devices support 20/40/80MHz
> single spatial stream in both STA and AP mode. Communication to the
> IW61x is done via SDIO interface
> 
> This driver is a derivative of existing Mwifiex [1] and based on similar
> full-MAC architecture [2]. It has been tested with i.MX8M Mini evaluation
> kits in both AP and STA mode.
> 
> All code passes sparse and checkpatch
> 
> Data sheet (require registration):
> https://www.nxp.com/products/wireless-connectivity/wi-fi-plus-bluetooth-
> plus-802-15-4/2-4-5-ghz-dual-band-1x1-wi-fi-6-802-11ax-plus-bluetooth-5-
> 4-plus-802-15-4-tri-radio-solution:IW612
> 
> Known gaps to be addressed in the following patches,
>   - Enable 11ax capabilities. This initial patch support up to 11ac.
>   - Support DFS channel. This initial patch doesn't support DFS channel in
>     both AP/STA mode.
> 
> This patch is presented as a request for comment with the intention of being
> made into a patch after initial feedbacks are addressed
> 
> [1] We had considered adding IW61x to mwifiex driver, however due to
>     FW architecture, host command interface and supported features are
>     significantly different, we have to create the new nxpwifi driver.
>     Subsequent NXP chipsets will be added and sustained in this new driver.

I added IW61x support to the mwifiex driver and besides the VDLL
handling which must be added I didn't notice any differences. There
might be other differences, but I doubt that these can't be integrated
into the mwifiex driver.

Honestly I don't think adding a new driver is a good ideai, given how big
wifi drivers are and how limited the review bandwidth is.

What we'll end up with is that we'll receive the same patches for both
drivers, or worse, only for one driver while the other stays unpatched.

I even found some of the bugs and deficiencies I am just fixing for the
mwifiex driver in the nxpwifi driver as well. So please direct your
effort to improving the existing driver rather than putting more burden
to the maintainers by adding a new driver. I am sure this is the faster
path to get the necessary changes upstream, plus users of the mwifiex
driver will profit from these changes as well.

Of course I don't have to decide this. The wifi maintainer(s) will have
the final word, but these are my 2 cents on this topic.

Sascha


-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

