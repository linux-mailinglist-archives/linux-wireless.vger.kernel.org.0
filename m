Return-Path: <linux-wireless+bounces-30748-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C22E8D19911
	for <lists+linux-wireless@lfdr.de>; Tue, 13 Jan 2026 15:44:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A381C300949C
	for <lists+linux-wireless@lfdr.de>; Tue, 13 Jan 2026 14:44:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF6C32BF3F3;
	Tue, 13 Jan 2026 14:44:46 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail.lysator.liu.se (mail.lysator.liu.se [130.236.254.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF3C225A2DE
	for <linux-wireless@vger.kernel.org>; Tue, 13 Jan 2026 14:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.236.254.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768315486; cv=none; b=S1R5r8b94druRCEh8+7nb6fKp1SM/ODjsWp5vuIttyL8adlKjbIYJG8pdCHpkz3f9iLdjs2f1DHVyR6mG4QVQRey9ehMVHIsVkSOuHX57SvY89HfBrrZ/vkWLODQm1TG4O1cOmdPoRMvQAVj5P2VXhAS3WsikT25Qzlo6clqetY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768315486; c=relaxed/simple;
	bh=uASyRrMcFZoAQwmEdsKgDYi7SwkJ0tsCtFR++f6M16Y=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=p8sJ+L7hD6XYJT0Hz/gX+0z8EUS6cSLIkZBwkFEoyYRCmzjkWn4oDDEvt8kWVI9VkMXUebBkiJA8GUSOlVQ43SZunY9YqqMIiMvILVuSKrWNh7633X07fEZiVGC6mdd09Va+mMU9klgTbIPeQmtHdrFM3qrhKfkoUoA4BewRt/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lysator.liu.se; spf=pass smtp.mailfrom=lysator.liu.se; arc=none smtp.client-ip=130.236.254.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lysator.liu.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lysator.liu.se
Received: from mail.lysator.liu.se (localhost [127.0.0.1])
	by mail.lysator.liu.se (Postfix) with ESMTP id 8478D5419
	for <linux-wireless@vger.kernel.org>; Tue, 13 Jan 2026 15:38:45 +0100 (CET)
Received: by mail.lysator.liu.se (Postfix, from userid 1004)
	id 77D0952C0; Tue, 13 Jan 2026 15:38:45 +0100 (CET)
X-Spam-Level: 
X-Spam-Score: -1.0
Received: from sara (h-62-63-215-216.A163.priv.bahnhof.se [62.63.215.216])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by mail.lysator.liu.se (Postfix) with ESMTPSA id 6720052BE;
	Tue, 13 Jan 2026 15:38:42 +0100 (CET)
Date: Tue, 13 Jan 2026 15:38:42 +0100 (CET)
From: =?UTF-8?Q?Peter_=C3=85strand?= <astrand@lysator.liu.se>
To: Johannes Berg <johannes@sipsolutions.net>
cc: linux-wireless@vger.kernel.org
Subject: Re: [RFC PATCH] wifi: wlcore: allocated packets tracking mechanism
 may get broken
In-Reply-To: <838a14637a5c134761ae75b600008396333ae95a.camel@sipsolutions.net>
Message-ID: <3bc7166c-7076-0d98-a45c-c993049621ca@lysator.liu.se>
References: <476e02ce-4592-b08a-fcc9-c1b151500bb9@lysator.liu.se>  (sfid-20251228_170449_364924_53B203D7) <838a14637a5c134761ae75b600008396333ae95a.camel@sipsolutions.net>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1427281282-1768315122=:16459"
X-Virus-Scanned: ClamAV using ClamSMTP

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1427281282-1768315122=:16459
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT


On Thu, 8 Jan 2026, Johannes Berg wrote:

> On Sun, 2025-12-28 at 16:54 +0100, Peter Åstrand wrote:
> > According to 
> > https://git.ti.com/cgit/wilink8-wlan/build-utilites/commit/?h=r8.9&id=a2ee50aa5190ed3b334373d6cd09b1bff56ffcf7 
> > the patch below should be used with firmware 8.9.1.0.2 . Does it make 
> > sense to include this in upstream kernel? I cannot really say if it 
> > improves stability or not: I don't have the possibility to run WFA test 
> > 5.2.27, and I am still seing issues with firmware 8.9.1.0.2 and 6.6 kernel 
> > (with all 80211 fixes). Testing of this patch with older wl18xx firmware 
> > is ongoing. 
> > 
> > 
> > From ac0695f9bf6810ae91cd0e441199102f0c16e507 Mon Sep 17 00:00:00 2001
> > From: Itzhak <shlomii@ti.com>
> > Date: Thu, 28 Dec 2023 08:47:58 +0200
> > Subject: [PATCH 25/27] allocated packets tracking mechanism may get broken
> > 
> >  It is observed that at some scenarios, the best effort queue
> >  that should always show positive or 0 count, may show negative. This cause
> >  the best effort queue to look full to the network stack and thus causing the
> >  network stack to push less packets than to other QoS queues. It would cause
> >  specific WFA tests like 5.2.27 to fail.
> 
> [snip]
> 
> It seems to me that we probably wouldn't _intentionally_ transmit frames
> with a mismatched AC/TID mapping, so is the patch just being lazy to
> overwrite it rather than figure out why it happened?

Yes, agree. I guess the question is if such mismatch can be prevented by 
the kernel? Since wl18xx firmware is closed.

Perhaps that wl1271_debug should be changed to wl1271_warning at least? 

Br,
Peter
--8323329-1427281282-1768315122=:16459--

