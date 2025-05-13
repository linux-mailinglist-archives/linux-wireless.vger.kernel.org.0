Return-Path: <linux-wireless+bounces-22924-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72C82AB5B6E
	for <lists+linux-wireless@lfdr.de>; Tue, 13 May 2025 19:36:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B65113A2547
	for <lists+linux-wireless@lfdr.de>; Tue, 13 May 2025 17:36:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85FBA1A304A;
	Tue, 13 May 2025 17:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jfarr.cc header.i=@jfarr.cc header.b="NYnumwho";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="sOUuVfQh"
X-Original-To: linux-wireless@vger.kernel.org
Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C91A1F4E48
	for <linux-wireless@vger.kernel.org>; Tue, 13 May 2025 17:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747157786; cv=none; b=hYy1jIQ6m1U/GYJuzlwkBDHrIoQpRD2+5CZEyw5WUrdhzt3PN+TRo3ZDx7WVcni/ful2/zvXzRanfc3KD3Sl/aPR9pxOh2Jkmdp2GEjikfwTqHdld5kqTeEHO8ZC1s4TkWtV0BWDhOEefIAFMOHHZWDV8kg+LfA553YhPlkOWzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747157786; c=relaxed/simple;
	bh=PgmzWU3vGhiMxMiclcxCdfSbGxlIXUYNJN6POMrhA8s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tsiP7UiGwSZipRsa5KndOyG830KkD001x0UnT9h8zykm6jWd8XK9VeuprCwYN+j0EBYcDBXusrVSJyjo3IEj5OwE+JEP5JBF4UFjfFrcVKVUgWrL/fOTVT4sRkK8pLVHPuBT+utioOckiE6u6RKTyl1MOtvJGTnRRFlIBFWQvwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jfarr.cc; spf=pass smtp.mailfrom=jfarr.cc; dkim=pass (2048-bit key) header.d=jfarr.cc header.i=@jfarr.cc header.b=NYnumwho; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=sOUuVfQh; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jfarr.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jfarr.cc
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 61115114011F;
	Tue, 13 May 2025 13:36:23 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Tue, 13 May 2025 13:36:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jfarr.cc; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1747157783; x=1747244183; bh=LpzNABHmL5
	Zjco+ZbpKKoQaGsbMkjsuAkFchwuOP5CQ=; b=NYnumwhoWOlb/L6IEh9yAKKcT1
	HQucJRsqt5u7oRbvyt2bbhefWOEhW0Y9WZSqHHBVuZHv4FAth4KCg3947WEz4S+X
	Iwu6kJ4VhBYf7JKqMH6gw6pOEvkuRBd8cnf+y3+2rYoggQd7taX8sojdnjtn7I7r
	2hL6vTGkHewqj/MaDgsD4tqFCUM18rrO/V3BrBpjE3DWhnhB3VTFhMLLQZqKb1Mr
	DyH99ktN+imP3RuzzQ3O/BIkRHQiQogxiMU4SkGlQI94xLCcoxyjxT/H/ll8kId9
	VYbPKhbiCu5wRXd9ZQTiUx4MEVmGB39yiH1rxzydxj07Ikh+7y+kRlZGRT/w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1747157783; x=1747244183; bh=LpzNABHmL5Zjco+ZbpKKoQaGsbMkjsuAkFc
	hwuOP5CQ=; b=sOUuVfQh1lRbo+fPIOrw19ph7fbW+ZAoyEP5wF0BnZCDbXcwZBC
	E7alstmpmtSyvF4SMKyUSUVHYGnKjT6U1xxNHbR90OFaFX7ih/Kb9Fepfh+9NWXp
	D31S8ZzbwhX0E89Oh2LrjgxU4B4rXthA+1IAxV2kW9dGmDUIVpwk+kdjYgDoIGZu
	5wtts2/l0lKodoF5Y3Jli6fwSehyZ2A+FwbeDTnE/tXhNiG5BiAQO5NDh3MThvH9
	LTGbmecb8xWeVZo2syM3Qwhhn0N3mWA80o2j6d6ogpBDf1B3/zEaIwZdeYHO+pOR
	P4mZT+Uk33EUIlSajo83cYwxGTI5UvHuEsw==
X-ME-Sender: <xms:FoMjaBjL7zi5YbFsZ4nHWIEexHhVpltYrMBFapqow1W3FMSdwDsbaA>
    <xme:FoMjaGAlpwCZ7UHysrkVm-wV4KqY0XnrVPZh4vpqVZGP1_L4SX8IGSx0pRjE1FDXS
    _00GR-gyty-bVctYHo>
X-ME-Received: <xmr:FoMjaBGCnx7v9nZ90_LPvywCclANTo8iNnx0FXqVQXZcCX1Gu9NHIeJhYiI48Y8Vb_prCSsvueUBOtGfpHzSoIqJ7EnR>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeftdegjedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnegfrhhlucfvnfffucdludehmdenucfjughrpeffhffvvefu
    kfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeflrghnucfjvghnughrihhkucfhrg
    hrrhcuoehkvghrnhgvlhesjhhfrghrrhdrtggtqeenucggtffrrghtthgvrhhnpeeivedu
    keeuvedtgfeigfelgeffieffffeikeduudeuueehveehjeekjedulefhudenucffohhmrg
    hinhepshhiphhsohhluhhtihhonhhsrdhnvghtnecuvehluhhsthgvrhfuihiivgeptden
    ucfrrghrrghmpehmrghilhhfrhhomhepkhgvrhhnvghlsehjfhgrrhhrrdgttgdpnhgspg
    hrtghpthhtohepiedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepjhhohhgrnhhn
    vghssehsihhpshholhhuthhiohhnshdrnhgvthdprhgtphhtthhopehprhgvshhtfihojh
    esghhmrghilhdrtghomhdprhgtphhtthhopehlihhnuhigqdifihhrvghlvghsshesvhhg
    vghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehmihhrihgrmhdrrhgrtghhvghlrd
    hkohhrvghnsghlihhtsehinhhtvghlrdgtohhmpdhrtghpthhtohepihifugeslhhishht
    shdrlhhinhhugidruggvvhdprhgtphhtthhopeguvghnkhgvnhiisehgmhgrihhlrdgtoh
    hm
X-ME-Proxy: <xmx:FoMjaGQTVUNy39JyJNBbsNCIPE0FrGe9AUa0f5biBv4AODa4TDDyaA>
    <xmx:FoMjaOzdGO8eqiJBZgfoGC-aeJQgxlPbnqkHzDjt6w5TYSn6P_tJBA>
    <xmx:FoMjaM4hb-OcjGqFznd1va6W-olp7RbtoIvH6STmdOaEo5Y0AjNDwA>
    <xmx:FoMjaDwKNu_TOF3gmRNG3xpoA8iQnelfJeNlUJ2qTm6O2u6Z853cMQ>
    <xmx:F4MjaH6GpA5FHt-1i4VQPwV3HAJs2z0ujCr3j3ze6YOXT_Bb7CFiXU5Z>
Feedback-ID: i01d149f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 13 May 2025 13:36:21 -0400 (EDT)
Date: Tue, 13 May 2025 19:36:19 +0200
From: Jan Hendrik Farr <kernel@jfarr.cc>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: James Prestwood <prestwoj@gmail.com>, linux-wireless@vger.kernel.org,
	Miri Korenblit <miriam.rachel.korenblit@intel.com>,
	iwd@lists.linux.dev, Denis Kenzior <denkenz@gmail.com>
Subject: Re: wifi: iwlwifi: SAE fails when AP sends confirm before STA
Message-ID: <aCODE231NMCQ48xu@archlinux>
References: <aB4HC8Iaa6wR5dj7@archlinux>
 <15943a1f-0e5d-4705-b8ef-3f22fa3fe672@gmail.com>
 <aB4hMsBfyawYatoj@archlinux>
 <902daf8802c723d72fff0155cd0638848ce1bc7f.camel@sipsolutions.net>
 <aB5onavenLymR-QJ@archlinux>
 <8a1c5172bc0fd9d2a33522294d1a2a4c4ceb313a.camel@sipsolutions.net>
 <aCMtCCYtNNl4dL5Q@archlinux>
 <e1b26ee842bc60cfa939874f467a03531871807e.camel@sipsolutions.net>
 <aCN0Tjwu-yS2mzi_@archlinux>
 <047456d40bc42248a6ba1b76d630d5d82b857bf1.camel@sipsolutions.net>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <047456d40bc42248a6ba1b76d630d5d82b857bf1.camel@sipsolutions.net>

On 13 19:07:30, Johannes Berg wrote:
> On Tue, 2025-05-13 at 18:33 +0200, Jan Hendrik Farr wrote:
> > > I don't think this is really the right fix, but it might help:
> > > https://p.sipsolutions.net/e852565303ad878b.txt
> > 
> > Unfortunately this does not fix it.
> > 
> > Attached another capture (and trace, etc) 
> 
> Hm. Yeah, I missed the second path that goes there in this case ...
> 
> https://p.sipsolutions.net/0c145f72fdec3cf5.txt

This work!

Interestingly though, now the order is always:
1. client commit
2. AP commit
3. client confirm
4. AP confirm

It is now only ~5.3 ms between AP commit and client confirm vs
~21.2 ms before.

Do you have an explanation why this patch would change the timing?

So this test doesn't proof that it would work with the order the other way
around. Maybe I should try making iwd sleep while generating the commit.

Best Regards
Jan

> 
> johannes

