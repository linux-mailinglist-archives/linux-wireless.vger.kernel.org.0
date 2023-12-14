Return-Path: <linux-wireless+bounces-796-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DFC781310D
	for <lists+linux-wireless@lfdr.de>; Thu, 14 Dec 2023 14:13:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ACECF283139
	for <lists+linux-wireless@lfdr.de>; Thu, 14 Dec 2023 13:13:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E6925380B;
	Thu, 14 Dec 2023 13:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="fdyqlP/X"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:242:246e::2])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61FF598
	for <linux-wireless@vger.kernel.org>; Thu, 14 Dec 2023 05:13:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=4AiPauWUi0ChdOBQScOytBHEebDUoedjiYB9gzw0gHU=;
	t=1702559626; x=1703769226; b=fdyqlP/XELL7WXTFuzJWZ4ZwkvZerxNffIrZuWbtFSCzCz9
	DBejbpPFJnzn3eIy0aJGm2UaiDob0b9tjkam6nYFcSk2gI1EveKZiSbMuyGL5eQgDSLeHqhYi5ogG
	UHekOHfdpoOZ/L8or4W1HyxPCjNoWNj9otUbbilNrfRLBCRwFbE2V4Q1vO0LKHI4e4rPMvOe62R8q
	lHNYdYlOzfIRUirQc5P0/0FT0G11lZ2qfe80QmpAlCE9SNWbe4fq0/3lodLLZqVYJT1AiZseyqGsq
	433AqUur8ZCMbxzEN4xTXDl0RfIvGn/Rd49SzdLmdULNuPxumwYDuhOaBbGyNnIQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1rDlX1-0000000AqXN-3FmS;
	Thu, 14 Dec 2023 14:13:40 +0100
Message-ID: <9d2e0cc7ec292a7a1ea26c43ada305f40bc22829.camel@sipsolutions.net>
Subject: Re: [PATCH] wifi: cfg80211: fix bss rbn double erase issue
From: Johannes Berg <johannes@sipsolutions.net>
To: Jiazi Li <jqqlijiazi@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>,  Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Jiazi Li <jiazi.li@transsion.com>,
 linux-wireless@vger.kernel.org
Date: Thu, 14 Dec 2023 14:13:38 +0100
In-Reply-To: <20231026013528.GA24122@Jiazi.Li>
References: <20231025103304.22082-1-jiazi.li@transsion.com>
	 <b1358d256500d5bb6b3bbc312673c24b54b3674e.camel@sipsolutions.net>
	 <20231026013528.GA24122@Jiazi.Li>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.2 (3.50.2-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

> >=20
> > Ok that's bad - so you hit the WARN_ON there? How that? We should fix
> > that too?
> >=20
> Yes, hit this WARN_ON in the test of direct connection between mobile
> phones and PC. Here is the log:
> [ 2741.982362] -----------[ cut here ]-----------
> [ 2741.982446] WARNING: CPU: 6 PID: 2175 at net/wireless/scan.c:1496 cfg8=
0211_update_assoc_bss_entry+0x350/0x378 [cfg80211]

Right, so you can reproduce that - can you find a fix for it?

> I don't know why this is happening yet.

OK ...

We have some basic kunit infrastructure, maybe you can work out
something there.

> > > this bss->rbn will continue to hold
> > > expired data, such as __rd_parent_color.
> >=20
> > Does that matter in any way?
> >=20
> It caused a null pointer issue in rb_erase:

Well, OK, so the thing isn't about it holding a color or 'expired' data
or whatever, it's about it being still on the rbtree, no?

> > > And this bss still in rdev->bss_list, maybe double erase in
> > > __cfg80211_bss_expire later.
> > > Double erase a rbtree node(with expired parent and color data) maybe
> > > corrupt rbtree, so add a in_rbtree flag to fix this issue.
> >=20
> > This seems overly complex - couldn't we just remove it from the list to=
o
> > or something? It's already a case that "should never happen" so ... not
> > sure we need to do something "good"?
> >=20
> Will remove it from list when re-insert fail cause confusion in it's
> refcount? Which could lead to leakage or use-after-free?
> >=20

It's a warn-on anyway, better we leak it than crash?

johannes

