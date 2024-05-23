Return-Path: <linux-wireless+bounces-7992-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 315DC8CCF63
	for <lists+linux-wireless@lfdr.de>; Thu, 23 May 2024 11:36:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 62DFA1C22435
	for <lists+linux-wireless@lfdr.de>; Thu, 23 May 2024 09:36:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA58513D27F;
	Thu, 23 May 2024 09:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="hgobShxP"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D227D78C8B;
	Thu, 23 May 2024 09:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716456957; cv=none; b=sLqAxP5KHhe9HEXz/ZDWhlsNF+gUnk5VVDaYaO4wa4ym0eFCsJMzJTEYPjlIScnrS0Usqxv+Q+lqHfVaSnjJ7zA7gIbkeT+9q+eXFRAfKsxFswww2lLxjg3FbkUClSwS9UYU6qZRzi+cZblw6OyxDbucL+rQLxEb0cgwmrVYykQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716456957; c=relaxed/simple;
	bh=Ej4YT5rpVB1ypIhlhK6rTDQom/xOPRyn2nshuXUXznk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=tAhC7x1P6Pqh6S6b7vjy3W/fc16d48FpPSVSFMdQCHm7dRBEYLHcMs7Ckdb0AX1NLX6QUPX7Vd0O8P9e0vLhM7qBF3Iy4oM0AlzA6KU67jyB0BBCcClf9o3Cn6A+8GdTN9IzVVKMNJWlET5fgd+zgYKcyYikMSwKDFRGWLYHqQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=hgobShxP; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=Ej4YT5rpVB1ypIhlhK6rTDQom/xOPRyn2nshuXUXznk=;
	t=1716456954; x=1717666554; b=hgobShxP6k60ykh8Bkf7EUm35b9QlQRKb+oKT19ZO1CSHfU
	FSISCcR0sLIM5wLMjLLuOtBEA+IHkAPdRFeRiyQ380yAqcSb1tZrDHGp7/63sDRfJV9Quedw4DW8x
	hxT8IxJA0H1byj3vUzbr80FD3RplvVkdL9zMgU6kL/mGGwKxSAWOZC0Ubhl1h/sUEr4FfIArVgQ47
	wCj21XqotL28cBDIt8N7MCLRITZ3540dUMPD25EWY9Nzfaj5PiUCnJUwNVL6d2IshihOXqQTmy6Ns
	Wo593ps4vqC+tYtG9t1zxjSAKfBVDPzZgsF7B8jDHMhujatcT748BFj3Z4YvV+jQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1sA4rL-00000005t78-0pdJ;
	Thu, 23 May 2024 11:35:39 +0200
Message-ID: <9fca4c0d496eb731f571cd8eacd409b9a9e61dae.camel@sipsolutions.net>
Subject: Re: [PATCH v2] wifi: mac80211: Avoid address calculations via out
 of bounds array indexing
From: Johannes Berg <johannes@sipsolutions.net>
To: Simon Horman <horms@kernel.org>, Kenton Groombridge <concord@gentoo.org>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com,  linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
  linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, Kees Cook
 <keescook@chromium.org>
Date: Thu, 23 May 2024 11:35:37 +0200
In-Reply-To: <20240517204532.GC475595@kernel.org>
References: <20240517145420.8891-1-concord@gentoo.org>
	 <20240517204532.GC475595@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Fri, 2024-05-17 at 21:45 +0100, Simon Horman wrote:
>=20
> FWWIW, it seems unfortunate to me that the __counted_by field (n_channels=
)
> is set some distance away from the allocation of the flex-array (channels=
)
> whose bounds it checks. It seems it would be pretty easy for a bug in the
> code being updated here to result in an overrun.
>=20

In a way, this is a more general problem, this allocates the max we know
we might need, but then filter it down. It'd have to iterate twice to
actually allocate the "correct" size, but then you could still have bugs
by having different filter conditions in the two loops ...

Don't see any good solutions to this kind of code?

johannes

