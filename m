Return-Path: <linux-wireless+bounces-21921-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1574BA98D73
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Apr 2025 16:44:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2BA1C189C805
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Apr 2025 14:45:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3902E27F73E;
	Wed, 23 Apr 2025 14:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="lGcvvfHZ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD210139566
	for <linux-wireless@vger.kernel.org>; Wed, 23 Apr 2025 14:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745419490; cv=none; b=HABqr6rgp4zo/WeMzxZqr9pMD3wgb6GmcGrHyTiJUqs18o3J18vsBPFwxL1mTogjouccydIRkfg9rTv99JpJ+b8uBdX4R02QWlOxqtlbrPNWNPE8ijZt/nVjCJ1Cgn7Nwus2dY7yYywUSJhFDivZm+A8z80eSDznJv5ZUudU77A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745419490; c=relaxed/simple;
	bh=nLwM7nERfawXEL/8kxapZa0BpY3xmhW6FqgVtsqbpl4=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=kaPb8TGzT2gxoV5UP800qvwYKKmfGRPgKag6ZPw1D5URuLc/ISo4U/L6RzlqRyJprgFO5sPL0meUINXh5FSEkuhpKBbtTH0fXP+Gho/XD5Ks6I+MdGB2uO6iALjnlrv2pwxC5gfYqTwexzH6IeZvdAexKpJLk3jj+5ZSj0Zl1Fk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=lGcvvfHZ; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:To:From:Subject:Message-ID:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=nLwM7nERfawXEL/8kxapZa0BpY3xmhW6FqgVtsqbpl4=;
	t=1745419488; x=1746629088; b=lGcvvfHZsRavNiaXen4NJTFpXsHPNiyIh96J0UXCxGkizB1
	na6V9N1zTsvWGOJgLFfHO0gFZW4RIZvWwoXs4MgPEd+A0naE+of/UQuBWL06KIRY7SpAR0T5A4tQ9
	xS3qiGEB2lInzTjIbLi5GkWPjZGRC4oZjc00wIcIEENAqG9O8atKkY+VOs+pn1YPacneYuIGRSgck
	viledo3LoxPbGFaB8VR4gZX+qBmSHvIx4dXGWgPJS7wkyin64MM1N5kBStuh3+2aqKFi9PBF6hvsN
	3itN5u4KDrOfNMSectC0bagGhZ/OBVHb46/ComwNb16ME/gs/9q/QJBp02wd3LZA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.1)
	(envelope-from <johannes@sipsolutions.net>)
	id 1u7bLC-0000000EkxG-03O9;
	Wed, 23 Apr 2025 16:44:46 +0200
Message-ID: <5872dd78f2f947b27f3851e3f425677a2ddcf6d4.camel@sipsolutions.net>
Subject: Re: [PATCH iw] iw: print HE mcs correctly when mcs_len
From: Johannes Berg <johannes@sipsolutions.net>
To: Janusz Dziedzic <janusz.dziedzic@gmail.com>, 
	linux-wireless@vger.kernel.org
Date: Wed, 23 Apr 2025 16:44:45 +0200
In-Reply-To: <0c995a29d73a99084add34ef2b56b0fe673578c4.camel@sipsolutions.net>
References: <20250413160455.158335-1-janusz.dziedzic@gmail.com>
	 <0c995a29d73a99084add34ef2b56b0fe673578c4.camel@sipsolutions.net>
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

On Wed, 2025-04-23 at 16:43 +0200, Johannes Berg wrote:
> On Sun, 2025-04-13 at 18:03 +0200, Janusz Dziedzic wrote:
> > Print HE mcs correctly when lower layer
> > report correct/real mcs length.
> >=20
>=20
> I applied some other HE related patches and this didn't apply any more.
> Please check/rebase.
>=20

In some way though this also means your kernel patch _did_ introduce a
userspace regression, so I'm not entirely sure why we should do it at
all?

johannes

