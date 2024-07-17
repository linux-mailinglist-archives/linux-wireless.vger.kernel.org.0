Return-Path: <linux-wireless+bounces-10290-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8ECF5933918
	for <lists+linux-wireless@lfdr.de>; Wed, 17 Jul 2024 10:34:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 393A51F23329
	for <lists+linux-wireless@lfdr.de>; Wed, 17 Jul 2024 08:34:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46DCA2E651;
	Wed, 17 Jul 2024 08:34:17 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CC1510953
	for <linux-wireless@vger.kernel.org>; Wed, 17 Jul 2024 08:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721205257; cv=none; b=Qq1csw9EQR0tlyK+YRR09rO8L7gLHXY7JiEZ8+HFeCdzrmlcM8ohSWCRk17GbEwU/r7UyJrjf9SuCX/CaPK6BDVI+EqlQ4ruT5EWz5oIF+dMADRXn93AlnRT0UL0vBfaj0eeIiIl9rEulF94+/BHppIlwHcSlvMfVUPfGeIRW5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721205257; c=relaxed/simple;
	bh=MBDgfTZjD5OWNfYpDTKlEOJYFT0pKp4FaDY1g7taXqY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XmFg/Y272N/0FbAiAya0RVDfo5yd8SOfdlem3PZMbrjQ2iSBCNkz/tiuWljUh/hGwKvx7gnYUm+RlJLAnWVKLUQtbS3077CCiDArpZ6aAf9RcZlbfdJe02WYE9RAZkylRCka9vCtehZGR+pembZWHrIDV77nlKSLsQpa2GIk30s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <sha@pengutronix.de>)
	id 1sU072-0003NQ-To; Wed, 17 Jul 2024 10:34:12 +0200
Received: from [2a0a:edc0:2:b01:1d::c5] (helo=pty.whiteo.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <sha@pengutronix.de>)
	id 1sU072-000Af4-9A; Wed, 17 Jul 2024 10:34:12 +0200
Received: from sha by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <sha@pengutronix.de>)
	id 1sU072-0024fV-0Z;
	Wed, 17 Jul 2024 10:34:12 +0200
Date: Wed, 17 Jul 2024 10:34:12 +0200
From: Sascha Hauer <s.hauer@pengutronix.de>
To: Francesco Dolcini <francesco@dolcini.it>
Cc: Brian Norris <briannorris@chromium.org>, Kalle Valo <kvalo@kernel.org>,
	linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] wifi: mwifiex: simplify WPA flags setting
Message-ID: <ZpeCBIcLLxc2FZV5@pengutronix.de>
References: <20240716-mwifiex-wpa-psk-sha256-v1-0-05ae70f37bb3@pengutronix.de>
 <20240716-mwifiex-wpa-psk-sha256-v1-1-05ae70f37bb3@pengutronix.de>
 <20240716194826.GA85916@francesco-nb>
 <ZpdkDqJK63_a0ncW@pengutronix.de>
 <20240717080723.GB3312@francesco-nb>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240717080723.GB3312@francesco-nb>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: sha@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-wireless@vger.kernel.org

On Wed, Jul 17, 2024 at 10:07:23AM +0200, Francesco Dolcini wrote:
> On Wed, Jul 17, 2024 at 08:26:22AM +0200, Sascha Hauer wrote:
> > On Tue, Jul 16, 2024 at 09:48:26PM +0200, Francesco Dolcini wrote:
> > > On Tue, Jul 16, 2024 at 01:33:27PM +0200, Sascha Hauer wrote:
> > > > The WPA flags setting only depends on the wpa_versions bitfield and not
> > > > on the AKM suite, so move it out of the switch/case to simplify the code
> > > > a bit. No functional change intended.
> > > > 
> > > > Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> > > 
> > > Reviewed-by: Francesco Dolcini <francesco.dolcini@toradex.com>
> > > 
> > > > ---
> > > >  drivers/net/wireless/marvell/mwifiex/uap_cmd.c | 27 +++++++-------------------
> > > >  1 file changed, 7 insertions(+), 20 deletions(-)
> > > > 
> > > > diff --git a/drivers/net/wireless/marvell/mwifiex/uap_cmd.c b/drivers/net/wireless/marvell/mwifiex/uap_cmd.c
> > > > index 491e366119096..8d0cd84d27698 100644
> > > > --- a/drivers/net/wireless/marvell/mwifiex/uap_cmd.c
> > > > +++ b/drivers/net/wireless/marvell/mwifiex/uap_cmd.c
> > > > @@ -46,31 +46,18 @@ int mwifiex_set_secure_params(struct mwifiex_private *priv,
> > > >  
> > > >  	bss_config->key_mgmt_operation |= KEY_MGMT_ON_HOST;
> > > >  
> > > > +	if (params->crypto.wpa_versions & NL80211_WPA_VERSION_1)
> > > > +		bss_config->protocol = PROTOCOL_WPA;
> > > > +	if (params->crypto.wpa_versions & NL80211_WPA_VERSION_2)
> > > > +		bss_config->protocol |= PROTOCOL_WPA2;
> > > > +
> > > 
> > > I am wondering what happens if NL80211_WPA_VERSION_1 is not set, no idea
> > > what's the content of bss_config->protocol ...
> > > 
> > > in any case this is not something that you introduced, but maybe worth
> > > having a look?
> > 
> > bss_config is kzalloced in the only caller of mwifiex_set_secure_params(),
> > so bss_config->protocol is zero on entry.
> > 
> > It might be worth setting it to zero explicitly here to make the code
> > better understandable without having to look at the callers.
> 
> Thanks for looking into this, to me the change is fine as it is, up to
> you if you want to improve it this way.

I just sent a v2 including this change.

Sascha

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

