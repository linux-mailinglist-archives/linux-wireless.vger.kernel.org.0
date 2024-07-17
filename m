Return-Path: <linux-wireless+bounces-10284-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 594219336FE
	for <lists+linux-wireless@lfdr.de>; Wed, 17 Jul 2024 08:26:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8AB0B1C2090A
	for <lists+linux-wireless@lfdr.de>; Wed, 17 Jul 2024 06:26:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A257B12B6C;
	Wed, 17 Jul 2024 06:26:28 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ADCB12E48
	for <linux-wireless@vger.kernel.org>; Wed, 17 Jul 2024 06:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721197588; cv=none; b=dj0xit7o/sgr5vi/TgCuu0HCwC1v7pYAJgAKR8fzY5DNvljQebu4voJU1Z5WY+yAIWLQow0zBmZDtnCPfXcfd3rwMZBycMuopeJNDM86HnY6xqwfeR6koQp+iHSUTcsAJqQCvz6VQEdrgmXCoNtSkhf7I2Q/H+iFjPu9bkKQ4L0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721197588; c=relaxed/simple;
	bh=x0AKMoZUBDBo20leKTYdtGaRJKtvDiirN9eJUat42nc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Yeq8LsxDyJ3T1BiwNUMCpDugWiDU3iyKCvO107knLR3JbEtTG3SndDdPQ4GKJUbE9ZC74a+yg753MNK0unX/IEACIxEe7rAIBEToXKhEUpBccsFplwYYaQQQsNPan8hGF/nDT07a1K9BOs3YQUjYouef+xfgeETHtLcVO1om0zA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <sha@pengutronix.de>)
	id 1sTy7L-0003ns-Bc; Wed, 17 Jul 2024 08:26:23 +0200
Received: from [2a0a:edc0:2:b01:1d::c5] (helo=pty.whiteo.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <sha@pengutronix.de>)
	id 1sTy7K-0009PE-T7; Wed, 17 Jul 2024 08:26:22 +0200
Received: from sha by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <sha@pengutronix.de>)
	id 1sTy7K-001vf0-2Y;
	Wed, 17 Jul 2024 08:26:22 +0200
Date: Wed, 17 Jul 2024 08:26:22 +0200
From: Sascha Hauer <s.hauer@pengutronix.de>
To: Francesco Dolcini <francesco@dolcini.it>
Cc: Brian Norris <briannorris@chromium.org>, Kalle Valo <kvalo@kernel.org>,
	linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] wifi: mwifiex: simplify WPA flags setting
Message-ID: <ZpdkDqJK63_a0ncW@pengutronix.de>
References: <20240716-mwifiex-wpa-psk-sha256-v1-0-05ae70f37bb3@pengutronix.de>
 <20240716-mwifiex-wpa-psk-sha256-v1-1-05ae70f37bb3@pengutronix.de>
 <20240716194826.GA85916@francesco-nb>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240716194826.GA85916@francesco-nb>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: sha@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-wireless@vger.kernel.org

On Tue, Jul 16, 2024 at 09:48:26PM +0200, Francesco Dolcini wrote:
> Hello Sasha,
> thanks for your patch.
> 
> On Tue, Jul 16, 2024 at 01:33:27PM +0200, Sascha Hauer wrote:
> > The WPA flags setting only depends on the wpa_versions bitfield and not
> > on the AKM suite, so move it out of the switch/case to simplify the code
> > a bit. No functional change intended.
> > 
> > Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> 
> Reviewed-by: Francesco Dolcini <francesco.dolcini@toradex.com>
> 
> > ---
> >  drivers/net/wireless/marvell/mwifiex/uap_cmd.c | 27 +++++++-------------------
> >  1 file changed, 7 insertions(+), 20 deletions(-)
> > 
> > diff --git a/drivers/net/wireless/marvell/mwifiex/uap_cmd.c b/drivers/net/wireless/marvell/mwifiex/uap_cmd.c
> > index 491e366119096..8d0cd84d27698 100644
> > --- a/drivers/net/wireless/marvell/mwifiex/uap_cmd.c
> > +++ b/drivers/net/wireless/marvell/mwifiex/uap_cmd.c
> > @@ -46,31 +46,18 @@ int mwifiex_set_secure_params(struct mwifiex_private *priv,
> >  
> >  	bss_config->key_mgmt_operation |= KEY_MGMT_ON_HOST;
> >  
> > +	if (params->crypto.wpa_versions & NL80211_WPA_VERSION_1)
> > +		bss_config->protocol = PROTOCOL_WPA;
> > +	if (params->crypto.wpa_versions & NL80211_WPA_VERSION_2)
> > +		bss_config->protocol |= PROTOCOL_WPA2;
> > +
> 
> I am wondering what happens if NL80211_WPA_VERSION_1 is not set, no idea
> what's the content of bss_config->protocol ...
> 
> in any case this is not something that you introduced, but maybe worth
> having a look?

bss_config is kzalloced in the only caller of mwifiex_set_secure_params(),
so bss_config->protocol is zero on entry.

It might be worth setting it to zero explicitly here to make the code
better understandable without having to look at the callers.

Sascha

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

