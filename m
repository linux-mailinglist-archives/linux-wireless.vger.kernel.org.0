Return-Path: <linux-wireless+bounces-26756-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D1029B39D68
	for <lists+linux-wireless@lfdr.de>; Thu, 28 Aug 2025 14:36:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 143FC1C2543B
	for <lists+linux-wireless@lfdr.de>; Thu, 28 Aug 2025 12:36:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F06C23A9A0;
	Thu, 28 Aug 2025 12:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="jytrgjlh"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A361730C605
	for <linux-wireless@vger.kernel.org>; Thu, 28 Aug 2025 12:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756384578; cv=none; b=nha53e6N5mgdqsY7J6a0sRX1LPKoWoI/fe5qLG0RVeMeTm2lsWm5bIO610VA8lNvXWFsK5ZgjIwdcXrYBawfSiZ+hRtnfkhDGczAHxD0I44g2fLTH49eMMpVb0F7vcD3yyV7WSrFD8KDWBrIrtvaYaNqXJopg8OMrTMm52Qgg1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756384578; c=relaxed/simple;
	bh=DXv0HUkSKm1iz9gXO/5nZqNdAc3UY3D4lny9Q02cFw8=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=tH1flHg1XkkiHfi2dhzj+a+jRXhARy0KoKGz0/On2gboKhD86s7HFxPv35aSBZVbQcur9QC8dTDfRE9luWC0rMlUQSkSkWnMqE1D7ZWY+9ue5vBznOBb168cseRftQbBwvV2k53kiS0DUmN7ZzXt8ADIQK/eCIg6bM11FYaeDTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=jytrgjlh; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:To:From:Subject:Message-ID:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=DXv0HUkSKm1iz9gXO/5nZqNdAc3UY3D4lny9Q02cFw8=;
	t=1756384576; x=1757594176; b=jytrgjlhaSvTbtaft3KUpBiy5c3QkJjgyunqJ5A5hfqfLFx
	3qAFMx5Vy+oVwAQEGIkPi9MpyNdsZjp8bN3TAOtN1Wju2hQjd8vVm0CxXmqRMWqJxGnJdouq15nEa
	eT5zaBQ8DX0Rjc2Pj8o6mjcJFwlO+QRY7ruHsM6mFbH7vnixGMHUtm88vZDL9eY+IMrSQx4QqE7uZ
	2DsjSdXFcsrIdvmqKpg0ito/yQLbgnRjXazAI9UiqNqOT/5gfB88dKe1EKqk8Y5z9ceS55mbyIEzF
	uT1xXmTKaSVMPK1gvj+rpRsSUTqOsiNn86xGqrh+jeAfHP3aiCMCjs7A44LPNbug==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1urbrS-00000007YVJ-1S7Z
	for linux-wireless@vger.kernel.org;
	Thu, 28 Aug 2025 14:36:14 +0200
Message-ID: <a8bd9c4e520e0665a778c89282303431b4abadec.camel@sipsolutions.net>
Subject: Re: NPCA/DSO configuration
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-wireless@vger.kernel.org
Date: Thu, 28 Aug 2025 14:36:13 +0200
In-Reply-To: <f071f05beba11fe51f5517f3cc9890dc379273f5.camel@sipsolutions.net>
References: 
	<f071f05beba11fe51f5517f3cc9890dc379273f5.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Wed, 2025-08-27 at 18:40 +0200, Johannes Berg wrote:
> For sniffer also I guess it's just part of the chandef, which might also
> require configuring/tracking the BSS color. Even if the sniffer could
> listen on both control channels it'd still have to decide which to
> decode, unless it's actually fully dual-channel.

To elaborate a bit on this: To do sniffer the same way client does it,
you need the BSS color and NPCA non-primary control channel. The latter
is given by the chandef according the the rest of my proposal, but the
BSS color isn't. Also, the BSS color can change, so what should be
responsible for configuring it? And then maybe it shouldn't be a BSS
color but BSSID instead? Etc.

I mostly feel that this then isn't quite appropriate to put into the
nl80211/cfg80211 API for sniffer configuration, since it might vary.
We're probably going to implement it via just the BSS color in iwlwifi
and assume it doesn't change, but maybe that should just remain in
debugfs just like our AID configuration for multi-user sniffer?

Another potential sniffer might even have more hardware (or synchronize
two sniffer NICs) and be able to simultaneously receive on both the
primary and non-primary control channels, seeing more frames and also
the OBSS ones. For actually testing NPCA, this is probably required.

Another possible hardware implementation might have enough hardware
(chains) to do signal acquisition on both the primary and non-primary
control channels simultaneously, but would then have to decide which one
(# of chains and all that) which transmission to receive data, so it'd
need the BSS color again?

So I'm mostly tending towards just not having this in the sniffer for
cfg80211 level and doing something in debugfs if we need it.

However, the flip side is that two UHR stations communicating on a 320
MHz channel might send data via NPCA that even a sniffer configured to
the same 320 MHz channel couldn't see. But without BSS color
configuration it's impossible for it to see that anyway, so you'd have
to decide which stations you want to see unless there are effectively
separate sniffers ...

johannes

