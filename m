Return-Path: <linux-wireless+bounces-20848-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 931C7A71664
	for <lists+linux-wireless@lfdr.de>; Wed, 26 Mar 2025 13:20:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0479B3A7EC5
	for <lists+linux-wireless@lfdr.de>; Wed, 26 Mar 2025 12:19:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F98A1A23AC;
	Wed, 26 Mar 2025 12:19:26 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A351D86334
	for <linux-wireless@vger.kernel.org>; Wed, 26 Mar 2025 12:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742991566; cv=none; b=l9iQJeTjMi945d2drycWV+pRLWnBXdG6TfvcUj066pLr3vqtCN6adenJqaUv746qOMCuwiK0Q6bh7nF2akmH7HUQomg1C4AVZqOxu60jB6uzRiF+YwbnWisDlxDtvut0aPS1CJAd+C9kRVcHve5BfM3jg/2iRkGCCxq+6URedSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742991566; c=relaxed/simple;
	bh=+pQHJQTJjkDnNVcI28fWpk4lJeGXB+K4md8iwOZfAtA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SuFryLCBfedt63q9B5pZvcVKnpd2TbN8V7pp/GmTw1JGb0ZYGjJQTRdSh+6r4ryOPxUCdmcac2KZRn53uoF0R77+y7yO7sB1Vuu8/YFvfuV8Ug/ApY6DSuL92rXwyLEmtG1fkRsOvLYvy49Hl/S5pG6VYrif/AFjuSe7DNFoovk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <sha@pengutronix.de>)
	id 1txPj8-0005yV-DY; Wed, 26 Mar 2025 13:19:22 +0100
Received: from pty.whiteo.stw.pengutronix.de ([2a0a:edc0:2:b01:1d::c5])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <sha@pengutronix.de>)
	id 1txPj7-001kJC-2D;
	Wed, 26 Mar 2025 13:19:22 +0100
Received: from sha by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <sha@pengutronix.de>)
	id 1txPj7-0006h7-3C;
	Wed, 26 Mar 2025 13:19:22 +0100
Date: Wed, 26 Mar 2025 13:19:21 +0100
From: Sascha Hauer <s.hauer@pengutronix.de>
To: Francesco Dolcini <francesco@dolcini.it>
Cc: Jeff Chen <jeff.chen_1@nxp.com>, tsung-hsien.hsieh@nxp.com,
	Brian Norris <briannorris@chromium.org>,
	linux-wireless@vger.kernel.org, kernel@pengutronix.de,
	David Lin <yu-hao.lin@nxp.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Stefan Roese <sr@denx.de>
Subject: Re: Future of mwifiex driver
Message-ID: <Z-PwyV3Zo5n0cWY0@pengutronix.de>
References: <Z8WM9jn1QFscWZBQ@pengutronix.de>
 <20250306101715.GA19853@francesco-nb>
 <Z8rGDTjkwKAVaREL@pengutronix.de>
 <20250319103240.GA21390@francesco-nb>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250319103240.GA21390@francesco-nb>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: sha@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-wireless@vger.kernel.org

On Wed, Mar 19, 2025 at 11:32:40AM +0100, Francesco Dolcini wrote:
> On Fri, Mar 07, 2025 at 11:10:21AM +0100, Sascha Hauer wrote:
> > On Thu, Mar 06, 2025 at 11:17:15AM +0100, Francesco Dolcini wrote:
> > > + Jeff Chen <jeff.chen_1@nxp.com>, tsung-hsien.hsieh@nxp.com
> > > + Stefan Roese <sr@denx.de>
> > > 
> > > On Mon, Mar 03, 2025 at 12:05:26PM +0100, Sascha Hauer wrote:
> > > > I am worried about the future of the mwifiex driver. NXP has an ongoing
> > > > effort of forking the driver to support their new chips, but the forked
> > > > driver lacks support for the old chips supported by the current mwifiex
> > > > driver.
> > > > 
> > > > Overall this leaves us and our customers using the mwifiex driver in a
> > > > very bad situation.  Johannes made clear that he is not going to merge a
> > > > driver that is 70% identical to the existing driver and on the other
> > > > hand the existing driver doesn't get forward due to its odd-fixes state
> > > > and the potential rise of a new driver which would render work on the
> > > > existing driver useless.
> > > 
> > > While I agree on the challenging situation, I would not call it "very
> > > bad" ... as you know there are multiple people with stake on this driver
> > > (I added SR in Cc here, that I just discovered has some interested on
> > > this).
> > > 
> > > In the short term I think that improving mwifiex driver is going to be
> > > beneficial for everybody, currently this is not going as smooth as we'd
> > > like, as you wrote and as already commented by Brian.
> > > 
> > > And the next step would be to figure out how to enable newer Wi-Fi chip
> > > solution from NXP in mainline, we all have our ideas and we are not
> > > moving forward. NXP keeps pushing for a solution that was already
> > > rejected multiple times and so far it was not successful on explaining
> > > why this is the correct way forward. Here I would agree that the
> > > situation is "very bad" at the moment.
> > 
> > I have a patch adding iw61x support to the mwifiex driver. Maybe if I
> > send that for inclusion we can get NXP  to explain to us what's actually
> > missing in this patch to properly support it.
> 
> I would have HW available to test it, and not just review the code,
> looking forward to it.

Great! I just sent the series out, you are on Cc.

Sascha

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

