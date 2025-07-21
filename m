Return-Path: <linux-wireless+bounces-25765-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 34F64B0CAED
	for <lists+linux-wireless@lfdr.de>; Mon, 21 Jul 2025 21:17:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 684A7167A8E
	for <lists+linux-wireless@lfdr.de>; Mon, 21 Jul 2025 19:17:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D68712222BB;
	Mon, 21 Jul 2025 19:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="qKK35P6r"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 159BD2F32;
	Mon, 21 Jul 2025 19:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753125454; cv=none; b=V8nO1IBYuzdZdtrZlVn3wLTY6Cy20lBa78SMuTEXSTA/mAnZguNsYkI5F9R2xKBOYSL4MyCkbiVo9/TgwEKgSbnspgQovZwGB+Iugw8kvL3rEiDqOMZ9EVwvr6uEbPbMW4AVZd2B7F6coUz2mo73VbgN9assp3wIJtLWp+zvKKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753125454; c=relaxed/simple;
	bh=jFVFtR+yyBHVgIFMIRxbKdNI1fdFPpeAiVvRsqzdeUE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=EFBBZ8YEOMh7ie//X7v4kw+q+rEObwMCMGVBi+YO2l+VZQHqgTte8DlLXPCWA7WR7b951DZYTGqkTiNZbshLye9qt08TSBFHwunA99gAceNSQt573IMBYrTGnxNsTzDxaqY9ofLDAnF9horAstz9IF4BA0kzX+r8bVHx6Qn7OWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=qKK35P6r; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=jFVFtR+yyBHVgIFMIRxbKdNI1fdFPpeAiVvRsqzdeUE=;
	t=1753125453; x=1754335053; b=qKK35P6rrlXH7FPxiiv1jekfuPtcwmvCAv0JsQ3lkFqvkDO
	v5C88ejTSxu43eKNHHcJwAM1SZcculAuPeh0ICaBscXrsWzB1KVEomz5L7mHtiy1QLnXLfnVl5xLN
	taYFUzDPmru5956maohwg7mtPrfIOVmgTQjgoIJYTwrq931QMmR046um8Cyx1WLEeoB9E1ET5nwD9
	4JrYZ1JE7LTNcGYgsMIZABTvm1b8RPfautWzSDZKcqo9YhYUgQluYE221AXdzKO46FF/Vt20KZRiF
	FK96HHPxIVFie0pwf6kNC/xjC6kjroLjUcY+ADfTbJfHCiDD1QCeXrC6Kw5XVlFw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1udvd3-00000000c9j-1s4B;
	Mon, 21 Jul 2025 20:52:49 +0200
Message-ID: <3a0ad03a4dd4a201df0be07ebf9581a8efeedafc.camel@sipsolutions.net>
Subject: Re: Review of __counted_by in wireless (was Re: [PATCH wireless]
 wifi: cfg80211: remove scan request n_channels counted_by)
From: Johannes Berg <johannes@sipsolutions.net>
To: Kees Cook <kees@kernel.org>
Cc: linux-wireless@vger.kernel.org, linux-hardening@vger.kernel.org
Date: Mon, 21 Jul 2025 20:52:48 +0200
In-Reply-To: <202507210907.987737BFD@keescook>
References: 
	<20250714142130.9b0bbb7e1f07.I09112ccde72d445e11348fc2bef68942cb2ffc94@changeid>
	 <202507142200.D315742C@keescook>
	 <adb4d011c640aacb2273f81a4ad6e658ea2f52f1.camel@sipsolutions.net>
	 <202507210907.987737BFD@keescook>
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

On Mon, 2025-07-21 at 11:36 -0700, Kees Cook wrote:
> This seemed like a good project to compare my manual review against a
> review performed by the LLM I've been playing with, and it did okay. It
> missed several dynamic cases and I had to prod it into getting them
> right, and it couldn't find some allocation patterns on its own. It did
> spontaneously find the le/ge counted_by variants, which was nice. Anyway,
> here are the results...

Heh, cool, I'm glad you did that. Thanks.

[snip]

> In the review, I found 3 existing bugs, which I've set as separate
> patches now:
> https://lore.kernel.org/lkml/20250721181810.work.575-kees@kernel.org/
> https://lore.kernel.org/lkml/20250721182521.work.540-kees@kernel.org/
> https://lore.kernel.org/lkml/20250721183125.work.183-kees@kernel.org/

Right. I'm not sure I'll get those in for 6.16 still, I was really
hoping to not send more changes. I guess I'll decide today or tomorrow,
but I also haven't see any complaints about that.

> At the end of the day, with the above fixes, I think the dynamic cases
> appear safe, as they all follow basically the same pattern of allocating
> some max size and then filling/filtering the actual population of the
> array. (So I think cfg80211_scan_request is correctly used at this point,
> but I understand your desire to remove __counted_by on it.)

It's not correct, which is why I removed it now. In mac80211, we
allocate the int_scan_req and set the n_channels, but=C2=A0we can use that
request multiple times, and of course if e.g. the first use just fills a
single channel and the second use wants more than one, then it gets a
complaint from UBSAN although we allocated enough space for all the
channels the device actually has.

That case is something you can't really ever check though, it assumes
that channels are never going to be added twice and that the device
never changes the list of channels on the fly, which both semantically
makes sense so I don't think any code would ever really break it, but
it's definitely harder to reason about.

Or we could have n_chans_allocated which only makes it detect the memory
corruption part of this issue and can never do anything more than that
such as detection misuse during reading the channel list (which should
only go to n_chans_used.)

> Do you want me to send patches for the static cases to add comments or
> is that too much churn?

I may have changed my mind on that, it's easy to have a comment that
says "it never changes" but then new code comes along that does just
that and never notices the comment ... I guess I'm still not sure about
the whole thing after all this, it seems awfully hard to reason about in
many cases.

johannes

