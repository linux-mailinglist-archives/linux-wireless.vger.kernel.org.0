Return-Path: <linux-wireless+bounces-11964-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9798295EE55
	for <lists+linux-wireless@lfdr.de>; Mon, 26 Aug 2024 12:17:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1987C1F22E38
	for <lists+linux-wireless@lfdr.de>; Mon, 26 Aug 2024 10:17:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B459814900F;
	Mon, 26 Aug 2024 10:17:32 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D4F514830F
	for <linux-wireless@vger.kernel.org>; Mon, 26 Aug 2024 10:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724667452; cv=none; b=bWBGrJx/AmZ1VUrDnxyLdR6tda4m8fg9LFU4hDvZi2oKaLSUuAfi4bzTrlwjVijDYG8wtVGoEYT8Nzj137KHSG4P71gr0rt98WFCaKPcbStji1vipbg81aTl425XRRZC3sXIVIPq4Y+MirNtN+j9bPsG+1vZaElLS/4S1yEkOfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724667452; c=relaxed/simple;
	bh=+1sSYTJpR0WMXuTFjr+JO8ZWGztuKrRMT2yUDdMrNi0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ShTUyXeOSGTslcT7rbRHVC/peQP+WajzLarVz6u0CwtfQfp8sSOBuEc3ashI/oQW2qzoiJ8Ch/5zeffVCulOvqm15jJuBzgKLcnHRA4p6uFZsnmfqihmFV9GUBkviY9MVJz4Sy0ZDbTOzwhk0MU4wPXJW6xH/6jWZrpdgAsFUSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <sha@pengutronix.de>)
	id 1siWmp-0007gb-3w; Mon, 26 Aug 2024 12:17:23 +0200
Received: from [2a0a:edc0:2:b01:1d::c5] (helo=pty.whiteo.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <sha@pengutronix.de>)
	id 1siWmo-003AFu-A3; Mon, 26 Aug 2024 12:17:22 +0200
Received: from sha by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <sha@pengutronix.de>)
	id 1siWmo-0072PO-0e;
	Mon, 26 Aug 2024 12:17:22 +0200
Date: Mon, 26 Aug 2024 12:17:22 +0200
From: Sascha Hauer <s.hauer@pengutronix.de>
To: David Lin <yu-hao.lin@nxp.com>
Cc: Brian Norris <briannorris@chromium.org>,
	Francesco Dolcini <francesco@dolcini.it>,
	Kalle Valo <kvalo@kernel.org>,
	"linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"kernel@pengutronix.de" <kernel@pengutronix.de>,
	Pete Hsieh <tsung-hsien.hsieh@nxp.com>
Subject: Re: [EXT] [PATCH 10/31] wifi: mwifiex: fix indention
Message-ID: <ZsxWMgqgUfRXro0Q@pengutronix.de>
References: <20240820-mwifiex-cleanup-v1-0-320d8de4a4b7@pengutronix.de>
 <20240820-mwifiex-cleanup-v1-10-320d8de4a4b7@pengutronix.de>
 <PA4PR04MB96382C0635603A51371C0E23D18F2@PA4PR04MB9638.eurprd04.prod.outlook.com>
 <ZsxM198_t04j6OMo@pengutronix.de>
 <PA4PR04MB96386A441739C4D35683512FD18B2@PA4PR04MB9638.eurprd04.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PA4PR04MB96386A441739C4D35683512FD18B2@PA4PR04MB9638.eurprd04.prod.outlook.com>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: sha@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-wireless@vger.kernel.org

On Mon, Aug 26, 2024 at 09:48:38AM +0000, David Lin wrote:
> > From: Sascha Hauer <s.hauer@pengutronix.de>
> > Sent: Monday, August 26, 2024 5:37 PM
> > To: David Lin <yu-hao.lin@nxp.com>
> > Cc: Brian Norris <briannorris@chromium.org>; Francesco Dolcini
> > <francesco@dolcini.it>; Kalle Valo <kvalo@kernel.org>;
> > linux-wireless@vger.kernel.org; linux-kernel@vger.kernel.org;
> > kernel@pengutronix.de
> > Subject: Re: [EXT] [PATCH 10/31] wifi: mwifiex: fix indention
> > 
> > Caution: This is an external email. Please take care when clicking links or
> > opening attachments. When in doubt, report the message using the 'Report
> > this email' button
> > 
> > 
> > On Thu, Aug 22, 2024 at 09:36:29AM +0000, David Lin wrote:
> > > > From: Sascha Hauer <s.hauer@pengutronix.de>
> > > > Sent: Tuesday, August 20, 2024 7:56 PM
> > > > To: Brian Norris <briannorris@chromium.org>; Francesco Dolcini
> > > > <francesco@dolcini.it>; Kalle Valo <kvalo@kernel.org>
> > > > Cc: linux-wireless@vger.kernel.org; linux-kernel@vger.kernel.org;
> > > > kernel@pengutronix.de; Sascha Hauer <s.hauer@pengutronix.de>
> > > > Subject: [EXT] [PATCH 10/31] wifi: mwifiex: fix indention
> > > >
> > > > Align multiline if() under the opening brace.
> > > >
> > > > Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> > > > ---
> > > >  drivers/net/wireless/marvell/mwifiex/wmm.c | 12 ++++++------
> > > >  1 file changed, 6 insertions(+), 6 deletions(-)
> > > >
> > > > diff --git a/drivers/net/wireless/marvell/mwifiex/wmm.c
> > > > b/drivers/net/wireless/marvell/mwifiex/wmm.c
> > > > index bcb61dab7dc86..1b1222c73728f 100644
> > > > --- a/drivers/net/wireless/marvell/mwifiex/wmm.c
> > > > +++ b/drivers/net/wireless/marvell/mwifiex/wmm.c
> > > > @@ -1428,13 +1428,13 @@ mwifiex_dequeue_tx_packet(struct
> > > > mwifiex_adapter *adapter)
> > > >         }
> > > >
> > > >         if (!ptr->is_11n_enabled ||
> > > > -               ptr->ba_status ||
> > > > -               priv->wps.session_enable) {
> > > > +           ptr->ba_status ||
> > > > +           priv->wps.session_enable) {
> > > >                 if (ptr->is_11n_enabled &&
> > > > -                       ptr->ba_status &&
> > > > -                       ptr->amsdu_in_ampdu &&
> > > > -                       mwifiex_is_amsdu_allowed(priv, tid) &&
> > > > -                       mwifiex_is_11n_aggragation_possible(priv,
> > ptr,
> > > > +                   ptr->ba_status &&
> > > > +                   ptr->amsdu_in_ampdu &&
> > > > +                   mwifiex_is_amsdu_allowed(priv, tid) &&
> > > > +                   mwifiex_is_11n_aggragation_possible(priv, ptr,
> > > >
> > > > adapter->tx_buf_size))
> > > >                         mwifiex_11n_aggregate_pkt(priv, ptr,
> > ptr_index);
> > > >                         /* ra_list_spinlock has been freed in
> > > >
> > > > --
> > > > 2.39.2
> > > >
> > >
> > > I wonder we still need patch for indent issue here? If so I am sure we
> > > will need a bunch of similar patches which I don't think really help
> > > improve mwifiex quality
> > >
> > > Actually in its successor Nxpwifi (currently under review), we have
> > > cleaned up all indent, and checkpatch errors/warnings/checks.
> > 
> > BTW you advertised nxpwifi not as a successor to mwifiex, but as the driver to
> > be used for new chips. This means we still have to deal with the mwifiex driver
> > in the future to support the old chips, so even if nxpwifi is merged it still makes
> > sense to clean up mwifiex.
> > 
> > Sascha
> > 
> 
> Just like what I listed for the errors/warning/checks of Mwifiex running with checkpatch.
> Mwifiex has so many issues. As the driver will only support legacy devices and the state of
> it is "Odd fixes", It is better to fix really bugs of Mwifiex instead of cleanup it.

The way you use "legacy" is from a silicon vendors perspective. Many
real users only start to use a chip when it's already legacy for the
silicon vendor.

Sascha

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

