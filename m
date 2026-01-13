Return-Path: <linux-wireless+bounces-30753-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7711CD19FED
	for <lists+linux-wireless@lfdr.de>; Tue, 13 Jan 2026 16:46:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 1D20C3021A6D
	for <lists+linux-wireless@lfdr.de>; Tue, 13 Jan 2026 15:38:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC2743933F3;
	Tue, 13 Jan 2026 15:38:23 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail.lysator.liu.se (mail.lysator.liu.se [130.236.254.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68798313E05
	for <linux-wireless@vger.kernel.org>; Tue, 13 Jan 2026 15:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.236.254.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768318703; cv=none; b=TRfcr0u5NgFzXMyNBoMvA8DPebbqWxaqT4Kth3uprymO5l6XHESvMnByyxvwYchLcacvyuW/pM1sB9EXXks0qSmCon7Y6GLGUkTz45dvoqCmPFU9M8FaG+oF3ZywvIuawXC1QCPkWQdOkgbCCHUnGfNhOwHcVOfponG+j5eg4wI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768318703; c=relaxed/simple;
	bh=O2LAo1bo4x4filf6TYObaRxRrIH63OH9CGWB3XDFfiY=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=ah9CeWqsVTEVoK7Lso0TW93y5KkfPXKrSD+2eImqmd5hdI1LGTh8RnTEADS++x4os9q+9GX8dBVDGc2IfPTlRkN+8lGyL6gROVbdWZJy21xAesxcmZhcPcq9pNrsqop7wFye4Ux4ZFnl1i9kTq/wsp57DzIy7CkPW72sqN+kZVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lysator.liu.se; spf=pass smtp.mailfrom=lysator.liu.se; arc=none smtp.client-ip=130.236.254.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lysator.liu.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lysator.liu.se
Received: from mail.lysator.liu.se (localhost [127.0.0.1])
	by mail.lysator.liu.se (Postfix) with ESMTP id AC4045729
	for <linux-wireless@vger.kernel.org>; Tue, 13 Jan 2026 16:38:19 +0100 (CET)
Received: by mail.lysator.liu.se (Postfix, from userid 1004)
	id A12515814; Tue, 13 Jan 2026 16:38:19 +0100 (CET)
X-Spam-Level: 
X-Spam-Score: -1.0
Received: from sara (h-62-63-215-216.A163.priv.bahnhof.se [62.63.215.216])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by mail.lysator.liu.se (Postfix) with ESMTPSA id 6AC485812;
	Tue, 13 Jan 2026 16:38:18 +0100 (CET)
Date: Tue, 13 Jan 2026 16:38:18 +0100 (CET)
From: =?UTF-8?Q?Peter_=C3=85strand?= <astrand@lysator.liu.se>
To: Johannes Berg <johannes@sipsolutions.net>
cc: linux-wireless@vger.kernel.org
Subject: Re: [RFC PATCH] wifi: wlcore: allocated packets tracking mechanism
 may get broken
In-Reply-To: <b2dcb04fc0a26eb46ef146fcbfc92a0823b320d1.camel@sipsolutions.net>
Message-ID: <742d3c8e-3731-7e2c-bb66-d2f4fdce7adf@lysator.liu.se>
References: <476e02ce-4592-b08a-fcc9-c1b151500bb9@lysator.liu.se>   (sfid-20251228_170449_364924_53B203D7) <838a14637a5c134761ae75b600008396333ae95a.camel@sipsolutions.net>  <3bc7166c-7076-0d98-a45c-c993049621ca@lysator.liu.se>  (sfid-20260113_153847_078773_40BD5239)
 <b2dcb04fc0a26eb46ef146fcbfc92a0823b320d1.camel@sipsolutions.net>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Virus-Scanned: ClamAV using ClamSMTP

> > > >  It is observed that at some scenarios, the best effort queue
> > > >  that should always show positive or 0 count, may show negative. This cause
> > > >  the best effort queue to look full to the network stack and thus causing the
> > > >  network stack to push less packets than to other QoS queues. It would cause
> > > >  specific WFA tests like 5.2.27 to fail.
> > > 
> > > [snip]
> > > 
> > > It seems to me that we probably wouldn't _intentionally_ transmit frames
> > > with a mismatched AC/TID mapping, so is the patch just being lazy to
> > > overwrite it rather than figure out why it happened?
> > 
> > Yes, agree. I guess the question is if such mismatch can be prevented by 
> > the kernel? Since wl18xx firmware is closed.
> 
> Oh, it's transmit, so it's coming from higher layers of the kernel.
> Which is why I'm saying this, working around firmware in the driver
> would seems like the only choice, but working around mac80211 in the
> driver seems odd, unless perhaps we can show that's something that it
> does intentionally for other drivers.

Thanks. Since the patch was created for kernel 4.19.38, it could be a 
workaround for a bug which has been fixed long ago. I think we can drop 
this patch then.

Br,
Peter

