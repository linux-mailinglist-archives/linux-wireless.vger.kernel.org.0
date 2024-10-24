Return-Path: <linux-wireless+bounces-14475-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B88D19AEA2A
	for <lists+linux-wireless@lfdr.de>; Thu, 24 Oct 2024 17:17:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 58FDB2812BB
	for <lists+linux-wireless@lfdr.de>; Thu, 24 Oct 2024 15:17:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2C9615884A;
	Thu, 24 Oct 2024 15:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="XT8CZztd";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="eZLxLzo4"
X-Original-To: linux-wireless@vger.kernel.org
Received: from flow-a6-smtp.messagingengine.com (flow-a6-smtp.messagingengine.com [103.168.172.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C645B15C128;
	Thu, 24 Oct 2024 15:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729783065; cv=none; b=PFAHMNeLTbN9kW4LtOwSAjTCLIXriYe1j3xvl2tAlwp9N0I9ogl6rBjOdw7K6Uf+QaMpoIjD49wERZY4Klagy4cFqSsYxiMgOsbOGTy5OXZBeg0UNWDmJM2HrtrsPXbnpVu5QT5llZx2lSg/gM8i8JqS+cSsf+3ObWEXAtp5VIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729783065; c=relaxed/simple;
	bh=mn8rv5H6V6i6dIVV5+82E/q+te6TZMiEXrbsvUxukPg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=haUeDAUgWLyro1kYWYjk2cmvQvD6u2+XODE2Wzb5xORafxAK0/WwYoiuc410hCEzJRTg+pcIEpCsZTKgCmRUPrYMvjDkaNkj+dEWQaZIGHz/Q8nNWDIsuJ+O3eknZy0RTlmG3puBqhxUcebTildfae/7AiTDie5a3llj7HF4oQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=XT8CZztd; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=eZLxLzo4; arc=none smtp.client-ip=103.168.172.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailflow.phl.internal (Postfix) with ESMTP id A5B0220046C;
	Thu, 24 Oct 2024 11:17:40 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-12.internal (MEProxy); Thu, 24 Oct 2024 11:17:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm1;
	 t=1729783060; x=1729786660; bh=3mTh/jC95PAKP3GIfBnLn3LeLI7GjRF8
	ZhSGr3+52GQ=; b=XT8CZztdUM2sTLLcPUom3kV4mtZqo47i7TShMous2kv1VX/I
	UQFKOg8Vh+8EvYmuWCFmmbbBt9GFKvf1py/FkSGrLDuAWPIBLW6kK4smcpoNNUww
	Mm1oYbe7PyhCJotX73PWGBqiaNBqH+Qnb1lTnr8Zz3/rlz4ycSRjn6O22U0XB7n5
	VK1m7FqNbXoS/z/tI7MDFfRtNSH0L2G43eIG+pXwcTarSQP7FOzCPiPCxMbV8YQ5
	Ptm6MevU0RHilmFDtyjQimdnKzLtG0FryN2ipDX8BYAAyVsetaPr7aZy2XJ5CiDD
	YUHh7gs9YYXiXXkOSjHLzsdmTYZSz0fy+FkTLQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=i934648bf.fm3; t=
	1729783060; x=1729786660; bh=3mTh/jC95PAKP3GIfBnLn3LeLI7GjRF8ZhS
	Gr3+52GQ=; b=eZLxLzo4YcnZJmpx5VlsnFx/mj9hOuUdxhSmwgjtkZWX1htDQPh
	4X2pqC+bPYGGej1wKDFFrDQa/sKBCCW9X6ujX98fbjBquYh5aE6H0tKvEk/Wt4cA
	w8LrnEJsGOWKivsz9ru7zVVIAtVqDuCq4BQ/vk6MWHL4PpX9S1GinLyJX3/nih+P
	JTYIR+ZzvL7jQRoLMJiKYqemv1r9GQt3hZYaWIjB176WEL+Dra+Q6btpVou9VBcj
	pGNkp+QO9j5HeA1leiK/+0zsYRbDhJYgwPzRPk5joArspHtNFD0Oe3DxZ3WpQogR
	nP/JeIjLo2Ps/8v98ZZkGixN35fVyEoZkxA==
X-ME-Sender: <xms:FGUaZ1V2OmlajPHLCm1BU-V3gN0ehHQYXoMl6m5Nr5s6dqfH9NOH-A>
    <xme:FGUaZ1nchmi8p9gWT11bN8Y6hl2PwYhqedZ8eUjks83EDPUXPN2WQbUASO2RfHLPE
    q-mjotXt_YvNYXq_E0>
X-ME-Received: <xmr:FGUaZxYg0PKmab5v5f0Abifp0XnfeHxH4xYhazS4XtYDNNnxClPIyHuckLqt>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdejtddgieduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggugfgjsehtkeertddttdej
    necuhfhrohhmpefurggsrhhinhgrucffuhgsrhhotggruceoshgusehquhgvrghshihsnh
    grihhlrdhnvghtqeenucggtffrrghtthgvrhhnpefgvdegieetffefvdfguddtleegiefh
    geeuheetveevgeevjeduleefffeiheelvdenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpehsugesqhhuvggrshihshhnrghilhdrnhgvthdpnhgs
    pghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepjhhohhgrnh
    hnvghssehsihhpshholhhuthhiohhnshdrnhgvthdprhgtphhtthhopehlihhnuhigqdif
    ihhrvghlvghsshesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehnvghtug
    gvvhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:FGUaZ4XZnEyrSV7pfPx09R0ubG7XPpHXT94DvCPPHcgu10uApHfn0g>
    <xmx:FGUaZ_nfFaO6c_MVX60r_ST34oFPLOmV42iB5fFD0-VRfnKQV4hJtw>
    <xmx:FGUaZ1ev_P8tg9Hnqc-IVl5jScnon-6FBht39-hI0UBYio48CxEpfA>
    <xmx:FGUaZ5Fj8IywP3YiW9JR2mDHbjzzVdId0C8ibiLZ9F_rlxAE1i12Ww>
    <xmx:FGUaZ-vpPAZtXShPdmMEmu6CKN2zsrAQuVAPxMk5PzPFK72K4WbPx0Vz>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 24 Oct 2024 11:17:39 -0400 (EDT)
Date: Thu, 24 Oct 2024 17:17:38 +0200
From: Sabrina Dubroca <sd@queasysnail.net>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-wireless@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [RFC PATCH 2/2] net: convert to nla_get_*_default()
Message-ID: <ZxplEne_oHXQycnc@hog>
References: <20241024131807.0a6c07355832.I3df6aac71d38a5baa1c0a03d0c7e82d4395c030e@changeid>
 <20241024131807.d5b9f6e57ede.I740beeaa2f70ebfc19bfca1045a24d6151992790@changeid>
 <8fabb6e5a2eda8c3bd7ca0bccc3e7804ad27bbad.camel@sipsolutions.net>
 <ZxpeL7S2GZeJOiQw@hog>
 <2e3b106585cebbb579c0d5cca33737623765ded7.camel@sipsolutions.net>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2e3b106585cebbb579c0d5cca33737623765ded7.camel@sipsolutions.net>

2024-10-24, 16:52:00 +0200, Johannes Berg wrote:
> On Thu, 2024-10-24 at 16:48 +0200, Sabrina Dubroca wrote:
> > 
> > If nla_get_*_default was a macro (generating an "attr ? getter :
> > default" expression) you wouldn't have that problem I think, 
> 
> Hmm. Perhaps. In the conditional operator (?:) they're subject to
> integer promotion though

Is it?

    #define nla_get_u16_default(attr, d) (attr ? nla_get_u16(attr) : d)
    int v = nla_get_u16_default(NULL, -1);

seems to put the correct value into v.
(but -ENOFOOD and -ELOWCOFFEE here, so I don't trust this quick test
much :))

>, I wonder if that could cause some subtle issue
> too especially if nla_get_u*() is used with signed variables?

The issue in that example is pretty subtle and I'm fairly sure people
are going to mess up :/
But I'm not attached to that macro I just suggested, it's just a
thought.

> > but you
> > couldn't nicely generate all the helpers with MAKE_NLA_GET_DEFAULT
> > anymore.
> 
> Right, that too.
> 
> I think it's probably better to just review them, and only commit the
> obvious ones originally?

Well, this one looked reasonable too. I'm not convinced reviewers are
going to catch those problems. Or authors of new code using those
_default helpers from the start.

-- 
Sabrina

