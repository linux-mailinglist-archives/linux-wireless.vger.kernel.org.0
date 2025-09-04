Return-Path: <linux-wireless+bounces-27008-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DCF73B43A5F
	for <lists+linux-wireless@lfdr.de>; Thu,  4 Sep 2025 13:40:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 15287562D64
	for <lists+linux-wireless@lfdr.de>; Thu,  4 Sep 2025 11:40:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E5B32ED170;
	Thu,  4 Sep 2025 11:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="R3B8G7As"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0BC32F998E;
	Thu,  4 Sep 2025 11:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756985996; cv=none; b=VDyRG+4l3BhvJiCAciQQrf+s7civ4LVhzQOxckHMrp1Gn4xqi5yPOFIbrQnzFepw3lzkI5LpivN17C809gLyzfih0Ge829VO0NQ+jNP5wScI1oJ1+hI+s0MHfvoVlSC0OocxoYxw1p83auUbz96w7OOGfcgpn064AxIzHGuirFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756985996; c=relaxed/simple;
	bh=qzSb4XUnXE0Z3Hw7JSrtLP4whWoATEU8SE43VYpoE4c=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=WQ1RazsHw+EooLfkHCmfb2BFEB5JXcQyQCr0P2w4J7/smCHsN+Kl6WXioRvD36O6riWc1FWuOgULkzJCOfZAHl35008Q9HqHUYS7mZd0/MoN+7auPSGpcLso8HM3hkb8tu2Baj3qgYGkcJfO5laEyaG4O1BKdnBzUBR2kOvlkF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=R3B8G7As; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=qzSb4XUnXE0Z3Hw7JSrtLP4whWoATEU8SE43VYpoE4c=;
	t=1756985994; x=1758195594; b=R3B8G7AsMP9qAzeS62L3xpVBnSkgfuxvkzotJ6F9xTTeH+x
	Yl8v1LJSG/gzukMr4Cuo6z+lJ/d5tKKFN20UifPnPWlDxkasp8RLW5shq/z3Be7lhRFcT0rgOq/oW
	KUUKYQWr+cdNX7oLk7/JX2btL/bCAr8e6B7wdeDjLQgMbqNI3pCpaDxP4x8cwC59zM7T0bW1sO+Qn
	smcjDm3HBlfTLXkSxDwXJ3Z5cm5BjIOYrg7popWXLxtWczKH11CbWtqeI+Q538NIFVXx2PjAqA5a+
	hKkXXC/uTTmBBqzJrHUv/kpfumgFE3rmzUuS63mMA4eb6zplISS6E7rdV6HnOB/g==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1uu8Jk-0000000E7Ev-0dab;
	Thu, 04 Sep 2025 13:39:52 +0200
Message-ID: <88ecbc3ffcd33e88af23b746ec8b032d1f414824.camel@sipsolutions.net>
Subject: Re: [PATCH v5 00/22] wifi: nxpwifi: create nxpwifi to support iw61x
From: Johannes Berg <johannes@sipsolutions.net>
To: Jeff Chen <jeff.chen_1@nxp.com>, linux-wireless@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, briannorris@chromium.org, 
	francesco@dolcini.it, tsung-hsien.hsieh@nxp.com, s.hauer@pengutronix.de, 
	brian.hsu@nxp.com
Date: Thu, 04 Sep 2025 13:39:50 +0200
In-Reply-To: <20250804154018.3563834-1-jeff.chen_1@nxp.com>
References: <20250804154018.3563834-1-jeff.chen_1@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Mon, 2025-08-04 at 23:39 +0800, Jeff Chen wrote:
> This series adds a new full-MAC Wi-Fi driver `nxpwifi` to support NXP IW6=
1x
> chip family.

Anyway the other reason I was commenting - when it's merged it should
just be a single patch, I think? So maybe provide a cover letter with a
commit message suitable for the entire driver and Signed-off-by? Not
sure how I should really handle this, tbh, but I guess that works.

johannes

