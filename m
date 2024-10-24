Return-Path: <linux-wireless+bounces-14473-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B8D6B9AE940
	for <lists+linux-wireless@lfdr.de>; Thu, 24 Oct 2024 16:48:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 708EC1F22AEB
	for <lists+linux-wireless@lfdr.de>; Thu, 24 Oct 2024 14:48:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CAD61E0487;
	Thu, 24 Oct 2024 14:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="xIU63Dmc";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="QQkeSf3J"
X-Original-To: linux-wireless@vger.kernel.org
Received: from flow-a6-smtp.messagingengine.com (flow-a6-smtp.messagingengine.com [103.168.172.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F16981D90A4;
	Thu, 24 Oct 2024 14:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729781303; cv=none; b=EphniO+KMl/Ok2qP9aR16P2utMooDCkLVhJwVCn8fm1WsyqN2oh/TYtD+kDj+BqvAmi93EUhrcKNTuUMJt5pcZABy92wwSf6BdJG8RW5WyBpBF3L77sqWe4VCHMNkIKSKG3FXnD7IEG7dv6X998MPO+3mqfnxq7VHYWdhuLh1pQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729781303; c=relaxed/simple;
	bh=WuEEkOjImF2gVovl1Xp7x2cEou/FVfZjHknFfYo7g1c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TEInUGVwGvMV6i7T8/gYiVXODRye1M9cDn4l65qtQZOtVFPRU8bZYu+flbSK+8Rex9MgWWYRnEOTuXF/CiOmGWJmu11I4EE0Sr4pQ7lVg9ysjd4C5QgXErc0629/nHt21dvvVHnnS4QZrwu2CTNkakriwUjFFxYUVv6q0O+gDb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=xIU63Dmc; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=QQkeSf3J; arc=none smtp.client-ip=103.168.172.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailflow.phl.internal (Postfix) with ESMTP id BF8C22007D3;
	Thu, 24 Oct 2024 10:48:17 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Thu, 24 Oct 2024 10:48:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1729781297; x=
	1729784897; bh=fzgbiUrTzurH1jwSPR4Xd3z8A+nJ9YBDq45NBHk0YFs=; b=x
	IU63Dmc9eH4+BJ8PtoAGVXecQHJduGS4KpD9pdgrybjDv2c9lB3JHcZcYttL5l/j
	OLGQnWfckx+RJsp8GzwuQEGjOVs6SXI49T5XpQchI7VH3LenAMPcY5IRFUJ5S9OH
	yMauAhQ6n8XrF2EObeICGBRIQfseRwtnjoQqAAnHgtGH4pJvum2s0/QMFbNF6/oq
	786mDxpcZKjbDWDSWrDvmtwmBpsRZKEZWWZUg1UWsGlGEeSpZXUIFnQGDUVYtJC6
	2TDn+LEEx4wm3ieqwWHxqQ6wnpkl94+StOT1BI0kZ8wlC8IutHlkuF2b2krYt1o2
	mLUSHetGfWnwTQcfZkivw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	i934648bf.fm3; t=1729781297; x=1729784897; bh=fzgbiUrTzurH1jwSPR
	4Xd3z8A+nJ9YBDq45NBHk0YFs=; b=QQkeSf3JQO4TUknovH5BedtjsL1fCGzmTY
	Jq3h6bIhGIY3mSX3qXgnqK2nTqOcV3guNRsqvN8cD0mHBuuLhOxxa69qTkdB0isl
	1X+sq8qCPWMlrRO97kG0Yt6mDPMekJqdHr8DevTqXQrNB6nMHw1hPw8EucCjP3Bo
	nzd04xeOIg1v1J23kEvY4PEtMGTZviUr9OUh6ZptX+rDH2LhIiZCyXjcvN8xohUU
	nny82wgwEULtRBb9p/6mUsKpv9XlCs4Rh8s16RP3ufsh9qjNYkx4L1c0U9SPISxL
	HPmwnpOWitHhHsnuuJP4z2oTtq5q3LlEeZqKO9VOX8Dtj+nQICsQ==
X-ME-Sender: <xms:MV4aZ_NowoXnJ6jypqxKHJFS7Op4opI8GMpStqasuIETqsDujKnm6A>
    <xme:MV4aZ58dC2AbRS8LobqZywK17nCMja_IN-sCHJ4uVXsOTrswIK3fqqcG4w6xj73Jt
    58HtzXz8dNcZxCR454>
X-ME-Received: <xmr:MV4aZ-TOTAnnMJyscJJXLjFZX_TZQ_5Ae2VXHpNncIf0SfZernlQsPrVDW56>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdejtddgheehucetufdoteggodetrfdotf
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
X-ME-Proxy: <xmx:MV4aZztbqK5RIpZOdjBxH-HN7tFDaXzHeXf79eXeT-QvuD-TRq0oTg>
    <xmx:MV4aZ3eeTSA94WOwj05UsG6c_umfeTHrT-TwyTPlbipVtxxfA7vS6w>
    <xmx:MV4aZ_3-BUYrSzRsd1Quc2nF0JOUkBQLaEN6DFAJcKMiQU0Rj4M59A>
    <xmx:MV4aZz9xfh12-CUjP9g2IlIOnP5awsQSFLzPNi2qFbn2SbSsbhaFww>
    <xmx:MV4aZ3lkp5I8fs2w9SN7rEIY7TRkkFGSr7E1GSHe4ZLXz0VIn8SJ1YCl>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 24 Oct 2024 10:48:17 -0400 (EDT)
Date: Thu, 24 Oct 2024 16:48:15 +0200
From: Sabrina Dubroca <sd@queasysnail.net>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-wireless@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [RFC PATCH 2/2] net: convert to nla_get_*_default()
Message-ID: <ZxpeL7S2GZeJOiQw@hog>
References: <20241024131807.0a6c07355832.I3df6aac71d38a5baa1c0a03d0c7e82d4395c030e@changeid>
 <20241024131807.d5b9f6e57ede.I740beeaa2f70ebfc19bfca1045a24d6151992790@changeid>
 <8fabb6e5a2eda8c3bd7ca0bccc3e7804ad27bbad.camel@sipsolutions.net>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <8fabb6e5a2eda8c3bd7ca0bccc3e7804ad27bbad.camel@sipsolutions.net>

2024-10-24, 15:41:59 +0200, Johannes Berg wrote:
> 
> Also just realized that some of the conversions are wrong, e.g.
> 
> > @@ -7378,17 +7375,11 @@ static int nl80211_set_station(struct sk_buff *skb, struct genl_info *info)
> >  	if (info->attrs[NL80211_ATTR_VLAN_ID])
> >  		params.vlan_id = nla_get_u16(info->attrs[NL80211_ATTR_VLAN_ID]);
> >  
> > -	if (info->attrs[NL80211_ATTR_STA_LISTEN_INTERVAL])
> > -		params.listen_interval =
> > -		     nla_get_u16(info->attrs[NL80211_ATTR_STA_LISTEN_INTERVAL]);
> > -	else
> > -		params.listen_interval = -1;
> > +	params.listen_interval = nla_get_u16_default(info->attrs[NL80211_ATTR_STA_LISTEN_INTERVAL],
> > +						     -1);
> 
> 
> this one clearly is.

Ouch, and really easy to miss while reviewing.

If nla_get_*_default was a macro (generating an "attr ? getter :
default" expression) you wouldn't have that problem I think, but you
couldn't nicely generate all the helpers with MAKE_NLA_GET_DEFAULT
anymore.

-- 
Sabrina

