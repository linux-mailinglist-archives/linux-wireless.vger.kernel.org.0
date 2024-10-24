Return-Path: <linux-wireless+bounces-14474-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5340D9AE95D
	for <lists+linux-wireless@lfdr.de>; Thu, 24 Oct 2024 16:52:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 06ADC1F22BC0
	for <lists+linux-wireless@lfdr.de>; Thu, 24 Oct 2024 14:52:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 092CC1DD0E6;
	Thu, 24 Oct 2024 14:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="O5FupnhY"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32E101B6CE2;
	Thu, 24 Oct 2024 14:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729781525; cv=none; b=nftpjOJ5O846/ZXhROwrV8vqS0v+nGw/hLuOL3C9a95Ge/3YFFK+nClqSen2VvuOdkzusAfbSjFqZ9dPuAK1Q5DxI/LmMHzrc4UZIGyLzE+lEqzXo6UjOSBkm7R6IbpDF9h+8i+OC6IbiRfhheB/ELMjVNpteCSuEtCRNeV2wjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729781525; c=relaxed/simple;
	bh=3SlR/dxAnj6bdMujLTwkkc9jweGNW26YP4jnX30v1xo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jlj/ROf6u/zuseMPAdDXGtbEjN9jgmTfOQ0t6WKmC3mhZzFMRoMSqPu3lXifsSJNLOvfMyoN0pF1Zm/ZjaEAd6oxGH6Go35p2xYgz58BxqyOpR89DLUYzLPIVzTg7XTfzBJGcrr/hxh2dkpwuy7fGgB4mwqBTD1HVQJl0qkijTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=O5FupnhY; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=3SlR/dxAnj6bdMujLTwkkc9jweGNW26YP4jnX30v1xo=;
	t=1729781524; x=1730991124; b=O5FupnhYOwjkEnsbCLac3wVVuo9989HaUuDt4vMp9wrQHkv
	Y7Kjx+QyIU33JJyi12B0EU15H72j8BeP0K5ikLZdtJ84l4cHfz470060iawsRAD6Yd2AmLCTTVi/0
	Oe8MhE1sR7qgz2jqD7/OgUCBhRXXHMKV79eYjl98IT+3LCDpyU6FX39wJzyhbrHKiRyRVf68XENVM
	ZIonAzhQdjZ1PtT/4kliuBuqXYoRPg6MKUq4XxUXb9ciIX5r/WSk+ETdBgVCN1R2qHtdBcfd6blgf
	0P9Pt5EpaUa55EKsvtOD5/LKcW39Yxusf5feT/kzKrN7S2z/ZW04e96AiZmxxHzQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98)
	(envelope-from <johannes@sipsolutions.net>)
	id 1t3zBw-00000003h72-3h6E;
	Thu, 24 Oct 2024 16:52:01 +0200
Message-ID: <2e3b106585cebbb579c0d5cca33737623765ded7.camel@sipsolutions.net>
Subject: Re: [RFC PATCH 2/2] net: convert to nla_get_*_default()
From: Johannes Berg <johannes@sipsolutions.net>
To: Sabrina Dubroca <sd@queasysnail.net>
Cc: linux-wireless@vger.kernel.org, netdev@vger.kernel.org
Date: Thu, 24 Oct 2024 16:52:00 +0200
In-Reply-To: <ZxpeL7S2GZeJOiQw@hog>
References: 
	<20241024131807.0a6c07355832.I3df6aac71d38a5baa1c0a03d0c7e82d4395c030e@changeid>
	 <20241024131807.d5b9f6e57ede.I740beeaa2f70ebfc19bfca1045a24d6151992790@changeid>
	 <8fabb6e5a2eda8c3bd7ca0bccc3e7804ad27bbad.camel@sipsolutions.net>
	 <ZxpeL7S2GZeJOiQw@hog>
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

On Thu, 2024-10-24 at 16:48 +0200, Sabrina Dubroca wrote:
>=20
> If nla_get_*_default was a macro (generating an "attr ? getter :
> default" expression) you wouldn't have that problem I think,=C2=A0

Hmm. Perhaps. In the conditional operator (?:) they're subject to
integer promotion though, I wonder if that could cause some subtle issue
too especially if nla_get_u*() is used with signed variables?

> but you
> couldn't nicely generate all the helpers with MAKE_NLA_GET_DEFAULT
> anymore.

Right, that too.

I think it's probably better to just review them, and only commit the
obvious ones originally?

johannes

