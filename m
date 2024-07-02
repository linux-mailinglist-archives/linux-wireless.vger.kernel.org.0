Return-Path: <linux-wireless+bounces-9878-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 05E5C924960
	for <lists+linux-wireless@lfdr.de>; Tue,  2 Jul 2024 22:36:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9C9E31F2585D
	for <lists+linux-wireless@lfdr.de>; Tue,  2 Jul 2024 20:36:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8ECEB201240;
	Tue,  2 Jul 2024 20:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b="XkVKP/b2"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3C681B5813;
	Tue,  2 Jul 2024 20:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.194.8.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719952586; cv=none; b=pORLUThgmyIDUzFezev0QPGFyKvw4pjZvdklYCu3vxA/1vZMjAEXRvSWKI4sPNZv99Yd1AbquZkrIDDcZC5hRCHGCD1Dj64+4y8WwQf4Bf8gpLdgrkKZ+MLe2s9SWe8pMMpBse1TnzsefAdPm89yAnzhTg5oafQzo7GLqbNVIEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719952586; c=relaxed/simple;
	bh=fU6QB0c2BhPUuTvaotCPVlYPbG03zz2VzDAibykSQVY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XACKWpJ+5GmNvcnRW07e/1VSSdrjKsA5eNC2wjVH6y9fZDR0HjG1Hcq1dm9d7jMBBfJ52o4O+/WuneZ8S561JIcH9bcJ5VpEN+MPA9mgiLq6L8xNcTskULlQNDJCXVMX5Ub6XdAZY3lRHkl4Ma8lyEswN6L7hMYmmf00Bh6ypQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it; spf=pass smtp.mailfrom=dolcini.it; dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b=XkVKP/b2; arc=none smtp.client-ip=217.194.8.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Received: from gaggiata.pivistrello.it (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
	by mail11.truemail.it (Postfix) with ESMTPA id 240641FA45;
	Tue,  2 Jul 2024 22:36:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1719952572;
	bh=ZXe+KkBs0kQAU6JmIvsQQGOuG1bRuJ3nAHLgU7aN2Hg=;
	h=Received:From:To:Subject;
	b=XkVKP/b2pAxAdGNmE8Amk/CmhEz58H92Y9yTsfs3ZLdrbKLm1q+dS4up0tUiScBNY
	 4g/b/rhZCy1ePO517TnC5TzcD63AOqL3NdSJtztrJ+n4p1zOQitbwZH634JUiTVJr0
	 hr2KiobBuxs4KTRVqMeVnrL8DD/bRb20rDxY6yX6kqmK8RDTCzuDM/i0Md6/puZWhL
	 XK/AfJXBbgHdvWhbHZAl+Bx/du6V80WLThUvCHAzMfLCJE1fxKRNbthPB9ulSmzKHu
	 d6DxK0p16LQGlOTyh35e0eX6uRMss68nq1eZXnIlFHDqQZx2bPjN4xswhWtwGUEF3+
	 ZtqTg5qhEz3PQ==
Received: by gaggiata.pivistrello.it (Postfix, from userid 1000)
	id CB6BF7F918; Tue,  2 Jul 2024 22:36:11 +0200 (CEST)
Date: Tue, 2 Jul 2024 22:36:11 +0200
From: Francesco Dolcini <francesco@dolcini.it>
To: Sascha Hauer <s.hauer@pengutronix.de>
Cc: Francesco Dolcini <francesco@dolcini.it>,
	Brian Norris <briannorris@chromium.org>,
	Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org, David Lin <yu-hao.lin@nxp.com>
Subject: Re: [PATCH] [RFC] mwifiex: Fix NULL pointer deref
Message-ID: <ZoRku6FmNA8d8lkR@gaggiata.pivistrello.it>
References: <20240619070824.537856-1-s.hauer@pengutronix.de>
 <87wmmll5mf.fsf@kernel.org>
 <ZnSHcZttq79cJS3l@google.com>
 <ZnVCzx3-pvbcYQLm@pengutronix.de>
 <ZnmcvsXZHnQ36auI@gaggiata.pivistrello.it>
 <ZoQBYMRLVAwM0O0j@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZoQBYMRLVAwM0O0j@pengutronix.de>

On Tue, Jul 02, 2024 at 03:32:16PM +0200, Sascha Hauer wrote:
> On Mon, Jun 24, 2024 at 06:20:14PM +0200, Francesco Dolcini wrote:
> > On Fri, Jun 21, 2024 at 11:07:27AM +0200, Sascha Hauer wrote:

...

> > > 
> > > From 3357963821294ff7de26259a154a1cb5bab760cb Mon Sep 17 00:00:00 2001
> > > From: Sascha Hauer <s.hauer@pengutronix.de>
> > > Date: Tue, 18 Jun 2024 12:20:20 +0200
> > > Subject: [PATCH] mwifiex: Do not return unused priv in
> > >  mwifiex_get_priv_by_id()
> > > 
> > > mwifiex_get_priv_by_id() returns the priv pointer corresponding to the
> > > bss_num and bss_type, but without checking if the priv is actually
> > > currently in use.
> > > Unused priv pointers do not have a wiphy attached to them which can lead
> > > to NULL pointer dereferences further down the callstack.
> > > Fix this by returning only used priv pointers which have priv->bss_mode
> > > set to something else than NL80211_IFTYPE_UNSPECIFIED.
> > > 
> > > Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>

Reviewed-by: Francesco Dolcini <francesco.dolcini@toradex.com>

I guess you should send it as a proper patch?


...

> > I am just wondering if this might have anything to do with
> > commit a17b9f590f6e ("wifi: mwifiex: Fix interface type change"), maybe you have already looked into it?
> 
> It looks somehow related. I just gave it a try and it at least doesn't
> fix my issue.

thanks for trying it out.


Francesco


