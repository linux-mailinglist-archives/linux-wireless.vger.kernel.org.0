Return-Path: <linux-wireless+bounces-19993-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E38EA564B1
	for <lists+linux-wireless@lfdr.de>; Fri,  7 Mar 2025 11:10:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 61669188A435
	for <lists+linux-wireless@lfdr.de>; Fri,  7 Mar 2025 10:10:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50C7C20D4FD;
	Fri,  7 Mar 2025 10:10:27 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60EB220DD50
	for <linux-wireless@vger.kernel.org>; Fri,  7 Mar 2025 10:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741342227; cv=none; b=mRQvdQpRyI03NDMh8CmGKbt5c1NdYtbzcMCEBXds+2lPJivD5b4ei+CRH0+nAdWwpbRwwpnTpYYPIPuL0KV39TKvljH9bvNB5FFHIn4IxHuBcEyH2OO7mkLFw7eGduDUefVkcun4jolVCYr7mlrswb6v9xLmD0uHM7kZr1/O1UQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741342227; c=relaxed/simple;
	bh=7Pstve0mAUr7eMVdFG/Tq73GVnmf4PPnRq7UUxm3NgA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W+IfToMbZ1OPb6A94dKL70tv4JNyISmYGC5G6JOlglTwVKzWIt2M2aVCTKOv2yZMPjyessztEoNXrOvyxbZerO0jnlHEuFMKcBQgFNuzOVmiFSQGVgwv0m1JoLL886vlw/tJsOKG0+RNrDIcnA+VUIrLeJDPdZK7KQe6SsuZnqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <sha@pengutronix.de>)
	id 1tqUer-0007ck-Qj; Fri, 07 Mar 2025 11:10:21 +0100
Received: from pty.whiteo.stw.pengutronix.de ([2a0a:edc0:2:b01:1d::c5])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <sha@pengutronix.de>)
	id 1tqUer-004T8P-1f;
	Fri, 07 Mar 2025 11:10:21 +0100
Received: from sha by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <sha@pengutronix.de>)
	id 1tqUer-000SdI-1K;
	Fri, 07 Mar 2025 11:10:21 +0100
Date: Fri, 7 Mar 2025 11:10:21 +0100
From: Sascha Hauer <s.hauer@pengutronix.de>
To: Francesco Dolcini <francesco@dolcini.it>
Cc: linux-wireless@vger.kernel.org, David Lin <yu-hao.lin@nxp.com>,
	Brian Norris <briannorris@chromium.org>,
	Johannes Berg <johannes@sipsolutions.net>, kernel@pengutronix.de,
	Jeff Chen <jeff.chen_1@nxp.com>, tsung-hsien.hsieh@nxp.com,
	Stefan Roese <sr@denx.de>
Subject: Re: Future of mwifiex driver
Message-ID: <Z8rGDTjkwKAVaREL@pengutronix.de>
References: <Z8WM9jn1QFscWZBQ@pengutronix.de>
 <20250306101715.GA19853@francesco-nb>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250306101715.GA19853@francesco-nb>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: sha@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-wireless@vger.kernel.org

On Thu, Mar 06, 2025 at 11:17:15AM +0100, Francesco Dolcini wrote:
> + Jeff Chen <jeff.chen_1@nxp.com>, tsung-hsien.hsieh@nxp.com
> + Stefan Roese <sr@denx.de>
> 
> Hello Sascha,
> 
> On Mon, Mar 03, 2025 at 12:05:26PM +0100, Sascha Hauer wrote:
> > I am worried about the future of the mwifiex driver. NXP has an ongoing
> > effort of forking the driver to support their new chips, but the forked
> > driver lacks support for the old chips supported by the current mwifiex
> > driver.
> > 
> > Overall this leaves us and our customers using the mwifiex driver in a
> > very bad situation.  Johannes made clear that he is not going to merge a
> > driver that is 70% identical to the existing driver and on the other
> > hand the existing driver doesn't get forward due to its odd-fixes state
> > and the potential rise of a new driver which would render work on the
> > existing driver useless.
> 
> While I agree on the challenging situation, I would not call it "very
> bad" ... as you know there are multiple people with stake on this driver
> (I added SR in Cc here, that I just discovered has some interested on
> this).
> 
> In the short term I think that improving mwifiex driver is going to be
> beneficial for everybody, currently this is not going as smooth as we'd
> like, as you wrote and as already commented by Brian.
> 
> And the next step would be to figure out how to enable newer Wi-Fi chip
> solution from NXP in mainline, we all have our ideas and we are not
> moving forward. NXP keeps pushing for a solution that was already
> rejected multiple times and so far it was not successful on explaining
> why this is the correct way forward. Here I would agree that the
> situation is "very bad" at the moment.

I have a patch adding iw61x support to the mwifiex driver. Maybe if I
send that for inclusion we can get NXP  to explain to us what's actually
missing in this patch to properly support it.

> 
> 
> > I think part of the solution should be that we start cleaning up the
> > mwifiex driver
> 
> Ack. I would suggest that we focus on this. I can help with some
> review/test (as partially done in the past), but I cannot commit to
> actively work on much more than that as of now.

Ok, I'll continue with my series then and skip the MAC address patch if
that's what blocking it.

Sascha

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

