Return-Path: <linux-wireless+bounces-19702-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98872A4BD7B
	for <lists+linux-wireless@lfdr.de>; Mon,  3 Mar 2025 12:08:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DAA6B164245
	for <lists+linux-wireless@lfdr.de>; Mon,  3 Mar 2025 11:05:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DB591F0E28;
	Mon,  3 Mar 2025 11:05:31 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABCAD3FFD
	for <linux-wireless@vger.kernel.org>; Mon,  3 Mar 2025 11:05:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740999931; cv=none; b=bTXhTPOuyKzBIAx9G5HLa8rp2WtOuKWJvoXFmXCddhBqj8/eMHs8PjJscTMKbORkDVZ95DTFNacV7akvpo8o5AJYOgX7k3mgaBzxZmZjoZY63AUwfUFRWGGsgcGZpjIAQ+eCUDxrgl8iwbIZlNBagjex/M11KsXd53RDfSVAJCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740999931; c=relaxed/simple;
	bh=IYNG7ZSxm+gJJKaOYzuYWh7ZU9GnGeB3lvFCEd27NYo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=moiIS4wIkY+HnmjlyARrjULqJqHfqp9FFmqKvVz2M6deJJhxKUsLCEFEJ9b9AP6HzoE/YAc2lYUaPIvRKFV5A9Uw6YSXWeKX1sgGWhlnWREHNQCZaXfAD7F1rbWSGZWngmw5czhSNSa1UM7Oy/lQsZoUeSXRjCtxadODM1Nv1Ms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <sha@pengutronix.de>)
	id 1tp3by-0002ly-SI; Mon, 03 Mar 2025 12:05:26 +0100
Received: from pty.whiteo.stw.pengutronix.de ([2a0a:edc0:2:b01:1d::c5])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <sha@pengutronix.de>)
	id 1tp3by-003mXq-1B;
	Mon, 03 Mar 2025 12:05:26 +0100
Received: from sha by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <sha@pengutronix.de>)
	id 1tp3by-00AiGo-0p;
	Mon, 03 Mar 2025 12:05:26 +0100
Date: Mon, 3 Mar 2025 12:05:26 +0100
From: Sascha Hauer <s.hauer@pengutronix.de>
To: linux-wireless@vger.kernel.org
Cc: David Lin <yu-hao.lin@nxp.com>, Brian Norris <briannorris@chromium.org>,
	Francesco Dolcini <francesco@dolcini.it>,
	Johannes Berg <johannes@sipsolutions.net>, kernel@pengutronix.de
Subject: Future of mwifiex driver
Message-ID: <Z8WM9jn1QFscWZBQ@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: sha@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-wireless@vger.kernel.org

I am worried about the future of the mwifiex driver. NXP has an ongoing
effort of forking the driver to support their new chips, but the forked
driver lacks support for the old chips supported by the current mwifiex
driver.

Overall this leaves us and our customers using the mwifiex driver in a
very bad situation.  Johannes made clear that he is not going to merge a
driver that is 70% identical to the existing driver and on the other
hand the existing driver doesn't get forward due to its odd-fixes state
and the potential rise of a new driver which would render work on the
existing driver useless.

I think part of the solution should be that we start cleaning up the
mwifiex driver so that at one point it could

a) be a robust base for a fork, or
b) make the fork unnecessary

This would help people using the mwifiex driver to get a better support
for their hardware.  It would also help NXP by splitting the necessary
changes into easier swallowable parts that are actually reviewable.
Should we really need a fork at some point then much of the review would
have already been done.

I have a series here [1] doing some cleanup work which I'd still like to
get forward.  Johannes made some remarks in [2] and [3] on which parts
of the driver need cleanup. Some more things for cleanup can also be
found in the forked driver code.

I am willing to put more work into the driver in creating and also
reviewing and testing patches, but I would need some path forward for
the driver and I think this needs a commitment from NXP to take the
detour over the mwifiex driver to get their stuff upstream.

Any thoughts?

[1] https://lore.kernel.org/linux-wireless/87ldwyumvq.fsf@kernel.org/
[2] https://lore.kernel.org/lkml/57ff2078632d8f14ca73c8307dc43585b3d09f50.camel@sipsolutions.net/#r
[2] https://lore.kernel.org/lkml/5f5c42585e168e252a5fa3f43325aaa360f6d27a.camel@sipsolutions.net/

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

