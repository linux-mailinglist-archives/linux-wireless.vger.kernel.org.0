Return-Path: <linux-wireless+bounces-10285-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7ACBF933881
	for <lists+linux-wireless@lfdr.de>; Wed, 17 Jul 2024 10:07:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2BD1A1F22A27
	for <lists+linux-wireless@lfdr.de>; Wed, 17 Jul 2024 08:07:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A2D3210E4;
	Wed, 17 Jul 2024 08:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b="f3SrOmit"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FA951CFB2;
	Wed, 17 Jul 2024 08:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.194.8.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721203652; cv=none; b=Cwv0tTzmqLpYdCwtNrMifFFOLBDPTWdZwOReRS7QFnRWDQxQWbEmU4JWzy4k+3E84DomC2HUemoPAIrRX9dDHonzdNR3rwtfcTX3anz2Zt9vEOWaTG4o+5f1pCBINP4/4nLmTCW/XqR5O6MJBKuGhQ5MIRNGK5/0qVBB/HqnF3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721203652; c=relaxed/simple;
	bh=SiWXbwwNoXHiMKBB89gYG1XRfZLJ4H76huUnddKDHKk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VOBN+o9XCVpkbdHax4wdEhMd8PnSZ+lzePYxG515uPGjU38hDrcP9IAPbZ+XoQRNnFYA36ff/rqpf3MZLKLHZ5hnPhJ0vLIVEixFqLU4gKfQyAk3rh2tog1O7kpVF6MYzdGg9VhKPQ1LBv7ClZNvqj3N/aYp5YQMKgmh2X5pUPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it; spf=pass smtp.mailfrom=dolcini.it; dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b=f3SrOmit; arc=none smtp.client-ip=217.194.8.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Received: from francesco-nb (31-10-206-125.static.upc.ch [31.10.206.125])
	by mail11.truemail.it (Postfix) with ESMTPA id A5ACC1F9E7;
	Wed, 17 Jul 2024 10:07:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1721203644;
	bh=vLQMPlC02JQSQqaWVs2IcoBB8RNijQnBdINp4CaZiO0=; h=From:To:Subject;
	b=f3SrOmitVOSamXNWvhYLDo2+TzvqZmKpnp6O0vR1UmdXgYQHWGV+/lfZ2998Shyd0
	 agcEuAWSRwWHCu0ec9LEriYC6BqsY1VhQj9hdzVbGISRO00Qj55J2BgTI5PtzluF90
	 5497DpNpkC4BUV4p+GKC/mUtvNIPZDmhVq6SHO8SV7Acuov7b8/QexpLTqrIkWcCgR
	 ywMqPXbIxxWnhPnaYO7XED44B0e7Ok55Otv35wujvsgoCwx8lYgv2aNbjuuHQZU5wF
	 nAbyahzTLNttJihLhpe6MzUE1qeyDjKatugezCeo/eMt008skSl/9PQbjs3xfrDKI8
	 dDJZLNZfc+xdA==
Date: Wed, 17 Jul 2024 10:07:23 +0200
From: Francesco Dolcini <francesco@dolcini.it>
To: Sascha Hauer <s.hauer@pengutronix.de>
Cc: Francesco Dolcini <francesco@dolcini.it>,
	Brian Norris <briannorris@chromium.org>,
	Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] wifi: mwifiex: simplify WPA flags setting
Message-ID: <20240717080723.GB3312@francesco-nb>
References: <20240716-mwifiex-wpa-psk-sha256-v1-0-05ae70f37bb3@pengutronix.de>
 <20240716-mwifiex-wpa-psk-sha256-v1-1-05ae70f37bb3@pengutronix.de>
 <20240716194826.GA85916@francesco-nb>
 <ZpdkDqJK63_a0ncW@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZpdkDqJK63_a0ncW@pengutronix.de>

On Wed, Jul 17, 2024 at 08:26:22AM +0200, Sascha Hauer wrote:
> On Tue, Jul 16, 2024 at 09:48:26PM +0200, Francesco Dolcini wrote:
> > On Tue, Jul 16, 2024 at 01:33:27PM +0200, Sascha Hauer wrote:
> > > The WPA flags setting only depends on the wpa_versions bitfield and not
> > > on the AKM suite, so move it out of the switch/case to simplify the code
> > > a bit. No functional change intended.
> > > 
> > > Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> > 
> > Reviewed-by: Francesco Dolcini <francesco.dolcini@toradex.com>
> > 
> > > ---
> > >  drivers/net/wireless/marvell/mwifiex/uap_cmd.c | 27 +++++++-------------------
> > >  1 file changed, 7 insertions(+), 20 deletions(-)
> > > 
> > > diff --git a/drivers/net/wireless/marvell/mwifiex/uap_cmd.c b/drivers/net/wireless/marvell/mwifiex/uap_cmd.c
> > > index 491e366119096..8d0cd84d27698 100644
> > > --- a/drivers/net/wireless/marvell/mwifiex/uap_cmd.c
> > > +++ b/drivers/net/wireless/marvell/mwifiex/uap_cmd.c
> > > @@ -46,31 +46,18 @@ int mwifiex_set_secure_params(struct mwifiex_private *priv,
> > >  
> > >  	bss_config->key_mgmt_operation |= KEY_MGMT_ON_HOST;
> > >  
> > > +	if (params->crypto.wpa_versions & NL80211_WPA_VERSION_1)
> > > +		bss_config->protocol = PROTOCOL_WPA;
> > > +	if (params->crypto.wpa_versions & NL80211_WPA_VERSION_2)
> > > +		bss_config->protocol |= PROTOCOL_WPA2;
> > > +
> > 
> > I am wondering what happens if NL80211_WPA_VERSION_1 is not set, no idea
> > what's the content of bss_config->protocol ...
> > 
> > in any case this is not something that you introduced, but maybe worth
> > having a look?
> 
> bss_config is kzalloced in the only caller of mwifiex_set_secure_params(),
> so bss_config->protocol is zero on entry.
> 
> It might be worth setting it to zero explicitly here to make the code
> better understandable without having to look at the callers.

Thanks for looking into this, to me the change is fine as it is, up to
you if you want to improve it this way.

Francesco


