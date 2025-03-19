Return-Path: <linux-wireless+bounces-20551-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ABACAA6899D
	for <lists+linux-wireless@lfdr.de>; Wed, 19 Mar 2025 11:32:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1C99F176E3F
	for <lists+linux-wireless@lfdr.de>; Wed, 19 Mar 2025 10:32:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83FB92066DA;
	Wed, 19 Mar 2025 10:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b="gTnXr36f"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B42A71C84D8
	for <linux-wireless@vger.kernel.org>; Wed, 19 Mar 2025 10:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.194.8.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742380369; cv=none; b=JGXSXe68UG5/2dOJR9E4imRRi9YnxtBS+hhXHO+zjrSbdI4HJSIJK3BIfhYDGS7zhBoLOdHZAt4xGTZ6eJX8nBCK+NCwBA+ietRxpopgYIl3e/NV6vrCbM6KPbu3f9sO6hIZLIHd8o1wjHnGfm1QmFY4QK39PRcY8Ni/5z10mYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742380369; c=relaxed/simple;
	bh=EyKu1GRMHHHkeHbzj9prH6F0ZcSiR75hC0bSERc6ieU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uKOOkPXCGtVCSCTc7pBSEZGGdhuwT5C1aW2avpUe/PYaAc1GzFZsxhSKt1eHuX+E6G6Gfiv8OBvzkTP0uMiYnMkV/uijvKYkXhCUN6zGpS/xrjsT66YHQMDZVm2G52JxXEXWKGQ7gc3zOt8kiGDn2F8vJnvUafPyzPH54Vzrif4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it; spf=pass smtp.mailfrom=dolcini.it; dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b=gTnXr36f; arc=none smtp.client-ip=217.194.8.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Received: from francesco-nb (31-10-206-125.static.upc.ch [31.10.206.125])
	by mail11.truemail.it (Postfix) with ESMTPA id 308781F842;
	Wed, 19 Mar 2025 11:32:44 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1742380364;
	bh=8xJPuXWBtnG1ePsRuOyQYAQwH+niFJ/ACBBCpmimWmw=; h=From:To:Subject;
	b=gTnXr36fwmP3gNRQ1ArANfSfZ5pc2ApM6/pZo4iJdPtS/GT/EmKM9PXik2ia7I5xN
	 JVVWKslzMkTTJRYT5+63+vmKy2EtueghJDHjyxi907/HWyd2+Ad/V7yGQcxAqF+U7X
	 1Bia5dfyZJRvm61PpfnThGJKRKrztfb5dSRR9+JKjN7+QA3mfwryV30kHPHgP4xF0T
	 SPKkTRckOIjkwJnIo4Vmy2H+HFqG4WfuvFsriOXnu+TSd4t5TliOHP+Dk+BI1aBS2E
	 nxPTimCowKVvmugAVE8vGNvK/1TmXlRCK4bue/W1ZtbW4l0qcoHLT6cKqOpDvTx6HJ
	 s3w1v2Hd4DSGg==
Date: Wed, 19 Mar 2025 11:32:40 +0100
From: Francesco Dolcini <francesco@dolcini.it>
To: Sascha Hauer <s.hauer@pengutronix.de>
Cc: Francesco Dolcini <francesco@dolcini.it>,
	linux-wireless@vger.kernel.org, David Lin <yu-hao.lin@nxp.com>,
	Brian Norris <briannorris@chromium.org>,
	Johannes Berg <johannes@sipsolutions.net>, kernel@pengutronix.de,
	Jeff Chen <jeff.chen_1@nxp.com>, tsung-hsien.hsieh@nxp.com,
	Stefan Roese <sr@denx.de>
Subject: Re: Future of mwifiex driver
Message-ID: <20250319103240.GA21390@francesco-nb>
References: <Z8WM9jn1QFscWZBQ@pengutronix.de>
 <20250306101715.GA19853@francesco-nb>
 <Z8rGDTjkwKAVaREL@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z8rGDTjkwKAVaREL@pengutronix.de>

On Fri, Mar 07, 2025 at 11:10:21AM +0100, Sascha Hauer wrote:
> On Thu, Mar 06, 2025 at 11:17:15AM +0100, Francesco Dolcini wrote:
> > + Jeff Chen <jeff.chen_1@nxp.com>, tsung-hsien.hsieh@nxp.com
> > + Stefan Roese <sr@denx.de>
> > 
> > On Mon, Mar 03, 2025 at 12:05:26PM +0100, Sascha Hauer wrote:
> > > I am worried about the future of the mwifiex driver. NXP has an ongoing
> > > effort of forking the driver to support their new chips, but the forked
> > > driver lacks support for the old chips supported by the current mwifiex
> > > driver.
> > > 
> > > Overall this leaves us and our customers using the mwifiex driver in a
> > > very bad situation.  Johannes made clear that he is not going to merge a
> > > driver that is 70% identical to the existing driver and on the other
> > > hand the existing driver doesn't get forward due to its odd-fixes state
> > > and the potential rise of a new driver which would render work on the
> > > existing driver useless.
> > 
> > While I agree on the challenging situation, I would not call it "very
> > bad" ... as you know there are multiple people with stake on this driver
> > (I added SR in Cc here, that I just discovered has some interested on
> > this).
> > 
> > In the short term I think that improving mwifiex driver is going to be
> > beneficial for everybody, currently this is not going as smooth as we'd
> > like, as you wrote and as already commented by Brian.
> > 
> > And the next step would be to figure out how to enable newer Wi-Fi chip
> > solution from NXP in mainline, we all have our ideas and we are not
> > moving forward. NXP keeps pushing for a solution that was already
> > rejected multiple times and so far it was not successful on explaining
> > why this is the correct way forward. Here I would agree that the
> > situation is "very bad" at the moment.
> 
> I have a patch adding iw61x support to the mwifiex driver. Maybe if I
> send that for inclusion we can get NXP  to explain to us what's actually
> missing in this patch to properly support it.

I would have HW available to test it, and not just review the code,
looking forward to it.

Francesco


