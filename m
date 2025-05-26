Return-Path: <linux-wireless+bounces-23420-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AD7EFAC3D4F
	for <lists+linux-wireless@lfdr.de>; Mon, 26 May 2025 11:50:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 582F61897EC3
	for <lists+linux-wireless@lfdr.de>; Mon, 26 May 2025 09:51:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05A241F12F8;
	Mon, 26 May 2025 09:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="Cpq9DXU1"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 735F17082D;
	Mon, 26 May 2025 09:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748253053; cv=none; b=uwJQ+5sSvGj3Eb/Vg6i5bLKtTpvM6PTJVf43TeHSymB3g0WtiJmCou2HIDDOqrKFA6mfOR+1INkH73Pvky+DLKsNwArcuIhgKWZWBaWP0Q2kTtDdEFF2wVHaO0Aw9V2toVbQmg/loIna2hPmg8BdHKinLt5xvZw3ktg+qb93qz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748253053; c=relaxed/simple;
	bh=t2ubYiqdftxCDqzVBmNQBW9WReC+IfxBbcIKEfqhE1E=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KsgcInI/H98nRdYCFhyquNvBlX/NIdAwu4As03FW7aqFh2fxyHccO8MZkh3TCLWpJtLX5jtcZBzAl/9XRXssJ/phf7IHQQzggUHymLbwSvWqpYEEv5i2EfXiyi1H4+tyzPMn2bauULz4jN/ylMR7rh2H8qUE37OpLmuGSCTAuVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=Cpq9DXU1; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=Pp9M8rm11d6AqqIgnHkzbzKTazYlGYJ9/XRhfkBgNcE=;
	t=1748253052; x=1749462652; b=Cpq9DXU1a32Pm9D5860bGoBztMC7Bd7+xawSB55FCoT7P4G
	OnQMaOgm6KNsEGzSNKPCAyW/C93KfY5cP2rndq7T5H4FRrW6I7nXEUSKxjWJgQ7qc7rXkYLIS3a/m
	g9xcHnO3J53ub0hxA5OdjdJNH4rd39oUpPp5jJBC3/Nq4UDUAjrw4gb+O94RkPSM9svRUwyVhM4uB
	qMSmZv9iBS9ExDIynmjOQXlydW16TQWYss70jvMp8liBQ6yrWf3UDPD8me2x5bfRmDdi4B2M0JGHU
	txIsBAqvugXbzS4eonRo82fTbRSdewktKIGXzFKr37jBsT0bc4hv5//NRHLinhaw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1uJUTo-0000000Df4h-2NfI;
	Mon, 26 May 2025 11:50:48 +0200
Message-ID: <2137c5905fc87e80698e6578ebf360be6d899f6f.camel@sipsolutions.net>
Subject: Re: [PATCH v2] mac80211: Add null pointer check for
 ieee80211_link_get_chanctx()
From: Johannes Berg <johannes@sipsolutions.net>
To: Greg KH <greg@kroah.com>, Wentao Liang <vulab@iscas.ac.cn>
Cc: luciano.coelho@intel.com, linux-wireless@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Date: Mon, 26 May 2025 11:50:47 +0200
In-Reply-To: <2025052614-spring-ether-8d09@gregkh>
References: <20250526091903.587-1-vulab@iscas.ac.cn>
	 <2025052614-spring-ether-8d09@gregkh>
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

On Mon, 2025-05-26 at 11:44 +0200, Greg KH wrote:
>=20
> >  			old_ctx =3D ieee80211_link_get_chanctx(link);
> > +			if (WARN_ON(!old_ctx)) {
>=20
> You just caused the machine to crash and reboot on billions of Linux
> systems if this ever is triggered.  So please never do that :(

I still very much disagree with you and _will_ keep adding warnings to
the wireless stack. This would be one of those places where it's totally
warranted, because it's actually impossible that this happens, for it to
something else would have to be changed to go wrong in how this is
called, for example.

Also, it already crashes anyway if it were NULL.

(And also, the poor patch submitter has no idea what you were talking
about.)

johannes

