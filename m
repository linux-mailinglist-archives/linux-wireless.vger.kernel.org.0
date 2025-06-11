Return-Path: <linux-wireless+bounces-23986-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4854FAD501F
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Jun 2025 11:38:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F0AAE7A58EF
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Jun 2025 09:37:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D6392609C2;
	Wed, 11 Jun 2025 09:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="VJ2BzTGQ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 829D7226CFD;
	Wed, 11 Jun 2025 09:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749634558; cv=none; b=IIpDJQEwyElnVK0lcGMxPzmsSNR19W88Di6S+brUt2RicUkwwhA8jVAPn3a6Y+hVSlaNBNFLzaUXN4i1ies+nwwJFGCLcQvYLSvUXupdUn3x79RDgrzjuikFBkSzJ7nY3ROWnscwHf92FPXySwiXRbeapn+L21dUIM35Xdl8Vew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749634558; c=relaxed/simple;
	bh=PHp28NdvUeBD3fbfZq5M9v31nFQcf4Q3prt6y5YxJh8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bKWMb64NIuNFwXn1d+lDzQrJI0BpiEnVpZ7hjnuEcBh+0Uzob96Tl+8lIhij4QqtGWvNpomp+DzTEYz2KbtvijXiyaOuD2xKOi/OvxEsp6bu07D4T5AGcIpIlmo+O9QneASPK0BTIIEwOp/kyTXNPN+/PoMXdfDN1vXjtBz1bGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=VJ2BzTGQ; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=PHp28NdvUeBD3fbfZq5M9v31nFQcf4Q3prt6y5YxJh8=;
	t=1749634557; x=1750844157; b=VJ2BzTGQEghgQPZFmrEHAiSFBVse2ElWL7DmMvTzj8BIQ3c
	/SepwkteovkgWKhV2X6inzVfVAB8Y+8LnwVk9iv9CXzRigaPP+rr/TkIPJH55E5G0kIzJf7A5FMl7
	2LqDzxJCWBk8gDIivqdnAqgW3lamAT0Th5JgMUDjCtho+hgJnOmvRRKgsx1GQbrltdyrCjEbvgA9X
	Iy3+pssxytS4agymJhOoZzHzyvY/Yw3B9FGN5HhFOGoRYjQevdgyDyzm+dcTiax98+IU96qnbD81t
	OwRbc8ENRbHbKKZnuUjJ6PIvhmP1Xf7BYGw6bl/X+MuoPiUw/9v3F9umqCkLzZ+g==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1uPHrk-00000001iBw-17kH;
	Wed, 11 Jun 2025 11:35:30 +0200
Message-ID: <13332646e4c8b028504f6a7ec4a2aa9530c519f1.camel@sipsolutions.net>
Subject: Re: [PATCH] wifi: zd1211rw: Fix potential data race in
 zd_mac_tx_to_dev()
From: Johannes Berg <johannes@sipsolutions.net>
To: Daniil Dulov <d.dulov@aladdin.ru>
Cc: Kees Cook <kees@kernel.org>, Emmanuel Grumbach
 <emmanuel.grumbach@intel.com>,  Miri Korenblit
 <miriam.rachel.korenblit@intel.com>, "John W. Linville"
 <linville@tuxdriver.com>, Daniel Drake	 <dsd@gentoo.org>,
 linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org, 
	lvc-project@linuxtesting.org
Date: Wed, 11 Jun 2025 11:35:18 +0200
In-Reply-To: <20250604101356.6292-1-d.dulov@aladdin.ru>
References: <20250604101356.6292-1-d.dulov@aladdin.ru>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

Hi,

So ... I have no idea why you're CC'ing all kinds of people who never
had anything to do with this driver, or haven't worked on WiFi in like a
decade or so ... Please don't. Even I should've been CC'ed with a
different address, at most.

I also have no idea who's maintaining this driver now though, if anyone.
I have hardware if someone wants it ;-)

> In order to avoid potential data races and leading dereference of a NULL
> pointer, acquire the queue lock before any work with the queue is done an=
d
> replace all skb_* calls with their lockless version.

You should explain why the locking changes are OK.

johannes

