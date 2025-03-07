Return-Path: <linux-wireless+bounces-19992-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F1CA8A56438
	for <lists+linux-wireless@lfdr.de>; Fri,  7 Mar 2025 10:47:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BBCD13AED49
	for <lists+linux-wireless@lfdr.de>; Fri,  7 Mar 2025 09:47:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBB2220C46C;
	Fri,  7 Mar 2025 09:47:21 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AB5A1EDA10
	for <linux-wireless@vger.kernel.org>; Fri,  7 Mar 2025 09:47:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741340841; cv=none; b=FT5S7FDSIah8mKUTpeqhFMuV4R0vY8mwehFW/X+LKcGDIKjMMUSCrBg/VXey19LvjWpbu06rmSgA/qF2N86jq31Q+Ii+xOH0H7Zk3UpxYAYsU7A+cwdoG3HSewc5kQS8redhLFWEuJGXMalpqZ24Rl8Y9BR8+lYMcgOaZz9cRIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741340841; c=relaxed/simple;
	bh=92nkMmAVYP7zX5gKkAp6xwPsdaBgiZRMK8Xb+OeG7r0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UWCymkZjhSZVkulFmrNGjnFI4zts1BH9/Iv+gDsLFbI9NurL5QiBbd4+sofhZoetleCS/vGpVjWM9bDlxnZNe+SI23VjPIzqTWmsaJ6IUuzAfinzDxInrj1rQRFBPmNA+HFZScmk5jwUijMW6Ei08vwXy6yAzPdPlrFMfGXUpl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <sha@pengutronix.de>)
	id 1tqUIO-0003FP-He; Fri, 07 Mar 2025 10:47:08 +0100
Received: from pty.whiteo.stw.pengutronix.de ([2a0a:edc0:2:b01:1d::c5])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <sha@pengutronix.de>)
	id 1tqUIO-004SpX-0b;
	Fri, 07 Mar 2025 10:47:08 +0100
Received: from sha by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <sha@pengutronix.de>)
	id 1tqUIO-000S6D-0F;
	Fri, 07 Mar 2025 10:47:08 +0100
Date: Fri, 7 Mar 2025 10:47:08 +0100
From: Sascha Hauer <s.hauer@pengutronix.de>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: Brian Norris <briannorris@chromium.org>, linux-wireless@vger.kernel.org,
	Francesco Dolcini <francesco@dolcini.it>, kernel@pengutronix.de,
	David Lin <yu-hao.lin@nxp.com>
Subject: Re: Future of mwifiex driver
Message-ID: <Z8rAnAgDb7f_xhMp@pengutronix.de>
References: <Z8WM9jn1QFscWZBQ@pengutronix.de>
 <Z8ZbJYmxgnvd7Q1O@google.com>
 <2587f323fe19b33d2e9ec49bdc3979f71b9c0ba0.camel@sipsolutions.net>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2587f323fe19b33d2e9ec49bdc3979f71b9c0ba0.camel@sipsolutions.net>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: sha@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-wireless@vger.kernel.org

On Fri, Mar 07, 2025 at 09:48:13AM +0100, Johannes Berg wrote:
> Hi all,
> 
> Sorry I didn't reply earlier - I was dragging my feet, but also didn't
> really know if I can add anything beyond what I already wrote.
> 
> 
> On Mon, 2025-03-03 at 17:45 -0800, Brian Norris wrote:
> > Hi Sascha,
> > 
> > On Mon, Mar 03, 2025 at 12:05:26PM +0100, Sascha Hauer wrote:
> > > I am worried about the future of the mwifiex driver. NXP has an ongoing
> > > effort of forking the driver to support their new chips, but the forked
> > > driver lacks support for the old chips supported by the current mwifiex
> > > driver.
> > [...] 
> > > I have a series here [1] doing some cleanup work which I'd still like to
> > > get forward.
> > [...]
> > > [1] https://lore.kernel.org/linux-wireless/87ldwyumvq.fsf@kernel.org/
> > 
> > I'll apologize for that one stalling out a bit. IIRC, 11 of 12 patches
> > looked great, but I got stuck on the "fix MAC address handling" patch,
> > because it's a lot tougher to guarantee it doesn't break some use cases
> > while fixing things. But really, it's probably mostly a bandwidth thing
> > for me, as I really don't have many cycles to spend on things (and
> > especially when it gets beyond "obvious cleanup" and requires
> > substantial testing and/or reasoning).
> 
> I guess that means could also partially resend the series, and get 11 of
> the 12 in? I see the MAC address handling is first, but a cursory look
> suggests that at least not all of the other would have a hard dependency
> on it.

OK, I'll respin the series without the MAC address patch. Next I'll have
another look at the MAC address patch and see if I can improve it
further and send this as a separate patch.

> > 4. A key difference between #3 and mwifiex is, like you say, that
> >    mwifiex has a pretty low quality baseline. If I were maintaining it
> >    from the beginning, I probably wouldn't have accepted it.
> 
> Indeed, the above is _definitely_ not true for mwifiex/nxpwifi. I've
> effectively proven in the other thread that it's just a straight up copy
> without any modernisation etc. If there had actually been a real reason
> to not work with the same code base, then that might have made sense -
> perhaps with some library code split out.
> 
> But copying an old crappy driver for the sake of "we don't want to
> maintain an old crappy driver" is a really bad argument to make?!

Thanks for your clear words. For me that means that I can put more
effort into the mwifiex driver without risking that it becomes obsolete
soon.

Sascha

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

