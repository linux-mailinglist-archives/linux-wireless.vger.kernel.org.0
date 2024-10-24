Return-Path: <linux-wireless+bounces-14470-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E1CA49AE8E1
	for <lists+linux-wireless@lfdr.de>; Thu, 24 Oct 2024 16:32:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A54AD29365B
	for <lists+linux-wireless@lfdr.de>; Thu, 24 Oct 2024 14:32:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F7D91EABA8;
	Thu, 24 Oct 2024 14:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="Z8MJbTNg";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="YUVbWo21"
X-Original-To: linux-wireless@vger.kernel.org
Received: from flow-a5-smtp.messagingengine.com (flow-a5-smtp.messagingengine.com [103.168.172.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D6A41E8833;
	Thu, 24 Oct 2024 14:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729780144; cv=none; b=Np7ZfZQTKepoPjQgfU8kF+Cax1k741PRDqzId/0uWnoB1v4on+r+gmIDu4y6dNkGG9MJTLg5j3+SHUQ984luUkctZ3WoxAmjbSb2Bjoaq7Z1tsEMh5zkkDDvi1H1eU2IwY7XUvuUgEl3FoKUp/2LyWH5vmvP/FBSVvJgux7CEvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729780144; c=relaxed/simple;
	bh=BPpxuoNwHXM2Tm/0eyS/Gx6V03nALdwM7MFD3gwcZe4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n4VtHEPJ3eKJKCtM7HGbkWSDQkOYOdfbPBQJDQ6EAJDXH0psr+gDksAO3j2YAZ9VNYqXJlEQWMwnVfExezeD422nkpy9+YWrsGVTMw6Vm3tzvmlET48Aq2f/hGYkFvRyq2GtOevG69eeK0SQ0TrBWjfVr6YloI53Ju8bZw1DaH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=Z8MJbTNg; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=YUVbWo21; arc=none smtp.client-ip=103.168.172.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailflow.phl.internal (Postfix) with ESMTP id DCF7A200757;
	Thu, 24 Oct 2024 10:28:58 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Thu, 24 Oct 2024 10:28:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1729780138; x=
	1729783738; bh=h17D4dfNAl6deuLvvZJCZ62MfBhuYPFZyV7DGFHlp8c=; b=Z
	8MJbTNg9E5CzkYTB5br+ui0T7U8D/LjN/AuwkW9TArABrik6dyBlThM1yzIS4I71
	tppbW4ESzIsWT3S6n620aW0VYpO+FWcvvtFv3wIHkH4QNMwXv0yF+m5Tuf86EbUu
	LANEPOQQUoA26CYjMiXof4Kuewg2di3zOz+p46bl8/v3aaFf0SHcsmuYFdDqiSVL
	VwMsFazGWJJW6dxSbQWK8sHCgnDwG2fnQZ/51JNB5/TO1AnYCHu8lSSwm1XOyAXW
	09q7pwUEi/q9kXRJHRYoyEdS+bEnnszpsQGkus0Qsi0EVKi9I6K8g/wSJ54C3tru
	+KeCdZUA1WQVqTk6N+yuA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	i934648bf.fm3; t=1729780138; x=1729783738; bh=h17D4dfNAl6deuLvvZ
	JCZ62MfBhuYPFZyV7DGFHlp8c=; b=YUVbWo21mYFUYghqjI9GuieUwuJLSGzzx6
	jTts+sOmrdAuv7HDnvnOOYQznXGb2phQW7Ggea90eo12RBlNxt5Kpgbi0a/ddgAT
	acazFYI6tv5Cz16p0ma9qiBqbuGEgEfyFXhjQNSCAejlS56KvcQNwreupSkP4YxJ
	iabIOJQmG9gHChLOgKqcNCsAWL6fT3JtgMnyFbOZyL/fOGWLdUJ8Zix7wXLbsdMd
	lXgMeMZIcGnSicJhRpdSc73cR7b5EQXPpOOc7Gu68Paxsp9+NLQUXsGewI18IheV
	e88vWScj4xeh27XVIaJQM84zS/tU4UGcgqJL0v9dVoEYCltmRqyw==
X-ME-Sender: <xms:qlkaZymHB9ZP88rqhOMWZTJVLrfDORQGLsR0Y2EklquYcQEBm2jKjQ>
    <xme:qlkaZ51-ZVQemNOiBK0ZMT-wksn-0dsDqNU-q5KA7m41NB6jH16tAS4910kUPitnr
    Q93n59Q6JmY2v5wTr4>
X-ME-Received: <xmr:qlkaZwpPFPWQPByVA4Hz7iWgXdxVURowXX9oezVs3cuEHNRrndCNj39C0UMZ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdejtddgheduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtjeen
    ucfhrhhomhepufgrsghrihhnrgcuffhusghrohgtrgcuoehsugesqhhuvggrshihshhnrg
    hilhdrnhgvtheqnecuggftrfgrthhtvghrnhepuefhhfffgfffhfefueeiudegtdefhfek
    geetheegheeifffguedvuefffefgudffnecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepshgusehquhgvrghshihsnhgrihhlrdhnvghtpdhnsggp
    rhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehjohhhrghnnh
    gvshesshhiphhsohhluhhtihhonhhsrdhnvghtpdhrtghpthhtoheplhhinhhugidqfihi
    rhgvlhgvshhssehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepnhgvthguvg
    hvsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:qlkaZ2kPxGaRvAiWOh6vDZl5q_UjlbIo_TKvQEKcKuN7JTmp80akiA>
    <xmx:qlkaZw2qYmZYZF3-f7Uwtd5Oz0ypdzeJww9XKnTG7pTDm0YzaWTg3A>
    <xmx:qlkaZ9uxrMf_3bGXDhsTpeNdrAS2pRq_WT4KV4bnlJNO02OK170XsQ>
    <xmx:qlkaZ8UN1H5o76Z4FhL1gfUS6gY4PkRuIaVSZe3XnYfr55gJPL0ifg>
    <xmx:qlkaZ1-DdP9U17H-Sm33lOlgTWKa4RlIExXXfBxPkKgT_IPcBZzpqduu>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 24 Oct 2024 10:28:58 -0400 (EDT)
Date: Thu, 24 Oct 2024 16:28:55 +0200
From: Sabrina Dubroca <sd@queasysnail.net>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-wireless@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [RFC PATCH 2/2] net: convert to nla_get_*_default()
Message-ID: <ZxpZp5KYN_VofWZ0@hog>
References: <20241024131807.0a6c07355832.I3df6aac71d38a5baa1c0a03d0c7e82d4395c030e@changeid>
 <20241024131807.d5b9f6e57ede.I740beeaa2f70ebfc19bfca1045a24d6151992790@changeid>
 <6461c18e0be520b4f7ecefc910af5d8dd205bce9.camel@sipsolutions.net>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <6461c18e0be520b4f7ecefc910af5d8dd205bce9.camel@sipsolutions.net>

2024-10-24, 14:11:05 +0200, Johannes Berg wrote:
> On Thu, 2024-10-24 at 13:18 +0200, Johannes Berg wrote:
> > From: Johannes Berg <johannes.berg@intel.com>
> > 
> > This is mostly to illustrate, done with the following spatch:
> > 
> 
> And we can extend that and get bunch more:
> 
> @@
> expression attr, def;
> expression val;
> identifier fn =~ "^nla_get_.*";
> fresh identifier dfn = fn ## "_default";
> @@
> (
> -if (attr)
> -  val = fn(attr);
> -else
> -  val = def;
> +val = dfn(attr, def);
> |
> -if (!attr)
> -  val = def;
> -else
> -  val = fn(attr);
> +val = dfn(attr, def);
> |
> -val = def;
> ... where != val;
> -if (attr)
> -  val = fn(attr);
> +val = dfn(attr, def);
> |
> -if (!attr)
> -  return def;
> -return fn(attr);
> +return dfn(attr, def);
> )

Not really familiar with spatch, but I'm guessing this won't cover:
    val = attr ? getter(attr) : default;

See macsec_validate_attr in drivers/net/macsec.c for some
examples. There are also some cases where we have "if (data &&
data[IFLA_MACSEC_*])" guarding the attribute fetch
(drivers/net/macvlan.c does that too), but I guess you can't really
cover that without adding some kind of "default_with_cond" helpers.

-- 
Sabrina

