Return-Path: <linux-wireless+bounces-14472-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C7FD9AE91B
	for <lists+linux-wireless@lfdr.de>; Thu, 24 Oct 2024 16:40:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BB62D1F22FC5
	for <lists+linux-wireless@lfdr.de>; Thu, 24 Oct 2024 14:40:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97FA91E7671;
	Thu, 24 Oct 2024 14:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="liB0S2Jd"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 844E71E25FA;
	Thu, 24 Oct 2024 14:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729780832; cv=none; b=GUbinJUjDr0NjrJxMonJAWB010vshHxWgK1OEVVRRfqEcJbSKa7DcIH0Y1AcXgeLUEE0bYGcJgWG+MMeTb23HFdDCilPDM2kgOGpUqtiQz06OV5cVU8aR5xfm0Qiv3P7X5OV4J+yLiFyfbqLgtv5PeLLJ30HxjA2hK8GzN3+Kmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729780832; c=relaxed/simple;
	bh=fVd42WbfRzjS6ydI6ogRHGRgpdkPXpk/Hc+Kw3w1tO8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=cWHOJtPnkTuM4EwyM1GvX3SKN1KzuSzlXzlry2NHAYdlsE5+6y0q/wpHxCbvD7U3BhRg3Q4l5VB1Eaj54VHTZz3JegLE4fNQFHbuwkl99bsebIAR977Bv3hBihdDgQQ9GIju4PTKbwlBql+HdLoPt6v9dv3EVdi3H9utG3/bZPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=liB0S2Jd; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=MxCoj/lvNLxMbeO6sh+u3qi/VmplAERZhgWjGQhey+0=;
	t=1729780830; x=1730990430; b=liB0S2JdTZ9IgL/rYFxbrCHnfEnhVc2/ZDPF55uIb0jmkxv
	rDKA+7Nl/6BtE6ujD8SgpBLFmivJIl+9qYLUJuiEVbfViXrRTVz/gk/HIQ7h/DeupPHTrcveHIS8z
	sUxptLT23MKAK/ZDEcaSDcyOd35kgC4gzXeFd0b92ew9iXioFJGXY/m+wq0flBNI+Yhvkh72S2tD/
	ijgVIWAdkUuF7uJ6l5PUbiCi6jVQ3w6JSyZ+LZbwrT6HQQAh5b9Q77x+ZBoQUTzVyy0mQOf2pGxNL
	RXD90r66/T1O9gDJgjEzOO1S5THa3WDmHKonbMynZx7c4aEdk99mBFAT8dPtGaNQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98)
	(envelope-from <johannes@sipsolutions.net>)
	id 1t3z0m-00000003gn5-0YkT;
	Thu, 24 Oct 2024 16:40:28 +0200
Message-ID: <5bbf371c2c62925eb3cd1794dfaf1bdfcb7fb9bd.camel@sipsolutions.net>
Subject: Re: [RFC PATCH 2/2] net: convert to nla_get_*_default()
From: Johannes Berg <johannes@sipsolutions.net>
To: Sabrina Dubroca <sd@queasysnail.net>
Cc: linux-wireless@vger.kernel.org, netdev@vger.kernel.org
Date: Thu, 24 Oct 2024 16:40:27 +0200
In-Reply-To: <170542c319f6b38330a3029f1f35594b8154763e.camel@sipsolutions.net>
References: 
	<20241024131807.0a6c07355832.I3df6aac71d38a5baa1c0a03d0c7e82d4395c030e@changeid>
	 <20241024131807.d5b9f6e57ede.I740beeaa2f70ebfc19bfca1045a24d6151992790@changeid>
	 <6461c18e0be520b4f7ecefc910af5d8dd205bce9.camel@sipsolutions.net>
	 <ZxpZp5KYN_VofWZ0@hog>
	 <170542c319f6b38330a3029f1f35594b8154763e.camel@sipsolutions.net>
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

On Thu, 2024-10-24 at 16:31 +0200, Johannes Berg wrote:
> On Thu, 2024-10-24 at 16:28 +0200, Sabrina Dubroca wrote:
> >=20
> >=20
> > Not really familiar with spatch, but I'm guessing this won't cover:
> >     val =3D attr ? getter(attr) : default;
>=20
> True, we could add
>=20
> -val =3D attr ? fn(attr) : def;
> +val =3D dfn(attr);
>=20

There are about 50 of those :) thanks!

johannes

