Return-Path: <linux-wireless+bounces-14143-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 315299A1C9B
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Oct 2024 10:10:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 95BE61F27213
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Oct 2024 08:10:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3295F1D79B4;
	Thu, 17 Oct 2024 08:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="c1Vu56Og"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D5F71D7E47;
	Thu, 17 Oct 2024 08:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729152372; cv=none; b=ZaDhi+hs9T/FgS3qv26jZ7iEh/EJEBp81j0fWhbbHQl7NCl+3WemT9d1cormpXpfldh9f9rjWaTb5Dp44qLZS3RVQfV3ErYiH1jZvWraek4A8772PMU4mCwOykVrp63ZTqsBknGwT1Sg2hWWqhMH0Xf4oo9ggLhDyJnNBdlnWI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729152372; c=relaxed/simple;
	bh=6pcCCpe8Vn1r9JfblpBBw9bgqc9ZlKKQPhCtJn1Um0Y=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=QQlVUY7JHMPc6hJ+IqurV2/y6xSYlPiqBJizwTbwiBLr7X7OFSPrXspxOcfUVoo2fSGBcRxHDt94EWYVSMV4UwIfwLEUFs/XQQ2EV6KFZYqOw5NedZ+nhTqOQhAAvuSvB2ZoymuhxXw092VM8zRHtwDnvVdlW/IVBsDm8Eko47U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=c1Vu56Og; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=6pcCCpe8Vn1r9JfblpBBw9bgqc9ZlKKQPhCtJn1Um0Y=;
	t=1729152370; x=1730361970; b=c1Vu56OgEaxDf7Qfh4ZopfRvWW8sges9Cb+nrrmdpZBlmaY
	WcbZ81ZKdpp84huy4g77r5oc1EOfP7PVPyjRME2FmuDa/lWSjuvUNxXTrOS99iS2YPlbYmzyj7rns
	q20/ytY+DYHhA81x5ssOY5QrwJIv7MW1t+G2Dj9NEH74FWl2YEerI0RveRzT4X+VrBhJi+PDH+1Qx
	1yE30Q1vkPOfLjPCUk2zrBJ5vjzKN54GCkJdGWC4jZ1MeKRygKYtZK8ykiimPlaRHfLW4PjGFnz+4
	4a4xIBW9vWcOMXwzFk87RXSFG5jv3pCHzLbqq9j5c+A+8d/mHJ/3rm5Iecf5CliQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98)
	(envelope-from <johannes@sipsolutions.net>)
	id 1t1LWI-0000000Dnhb-3AtF;
	Thu, 17 Oct 2024 10:06:06 +0200
Message-ID: <a4e27207087bc94ce120a1e1c54742f97c9ad046.camel@sipsolutions.net>
Subject: Re: [PATCH v1 wl-next 1/3] wifi: wext: Move wext_nlevents to
 net->gen[].
From: Johannes Berg <johannes@sipsolutions.net>
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: alexandre.ferrieux@gmail.com, kuni1840@gmail.com, 
	linux-wireless@vger.kernel.org, netdev@vger.kernel.org
Date: Thu, 17 Oct 2024 10:06:06 +0200
In-Reply-To: <20241016235850.29495-1-kuniyu@amazon.com>
References: 
	<f677361da9e1e4bb032e62301255ab705252e016.camel@sipsolutions.net>
	 <20241016235850.29495-1-kuniyu@amazon.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Wed, 2024-10-16 at 16:58 -0700, Kuniyuki Iwashima wrote:
>=20
> Btw, why WEXT cannot be module ?

TBH, I don't remember well. I feel like I may have tried ~20 years ago,
but hit issues, and just made the built-in parts minimal. Might've been
we didn't have net->gen yet (did we? I don't recall), but I wouldn't be
surprised if there are other issues with it as well with ioctl linkage
and /proc and whatever else it does.

Not sure it's worth trying, WEXT really ought to be on the way out now,
and with WiFi7 (and higher) devices it's completely disabled.



Btw, if you really wanted to, I suspect you _could_ use net->gen[], make
the .size only a pointer size and then allocate the real data only if a
wireless capable device shows up in the namespace? Then that'd actually
be a win (vs. the other discussion we just had above) since wireless
devices are probably almost never in a netns. Not sure you'd be able to
easily free it when the last wifi capable devices leaves a netns, but
that probably also doesn't matter.

I don't know though how much the size of the netns matters for the
scalability issue you have in mind, seems the O(N) time behaviour here
is more problematic than a handful of bytes.

johannes

