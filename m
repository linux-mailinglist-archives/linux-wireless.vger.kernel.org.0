Return-Path: <linux-wireless+bounces-15859-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 575519E1D36
	for <lists+linux-wireless@lfdr.de>; Tue,  3 Dec 2024 14:13:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 30977164CF9
	for <lists+linux-wireless@lfdr.de>; Tue,  3 Dec 2024 13:12:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47ED61EE00D;
	Tue,  3 Dec 2024 13:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="MPrtTakm"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B13AB1EBFE8;
	Tue,  3 Dec 2024 13:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733231567; cv=none; b=ZQL440y5Eu6kKKsMJPUnzd5ECV85+7iYHn3rTTswdt/+yZrSBeWY9eVZZt6GGnSu3pSyXMFT/iilehO0R1PDk0m1XzTp7VW/4MgKAPIUszKr8qIR1PI4uhbc7kT34b7hbejbwMOW71M+kyHcdSwtFuwtmugHI+EY9mgZtUYDfGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733231567; c=relaxed/simple;
	bh=QJziG7X74GgHVl2ql4Vu0/nF4cGbAAabOABs/e+a1wc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=DySS/3+rn32XaT97HtG/0ifGgb2yrU1BUdL2o+AfdmrH28bTLTYGlg6zN5niccLGosxm8CSjKx4TUnQLizLSTXRiwfXUFeNfleCAYoHxbvvOWBmFVC6ZbPFDQ/focc9dA4Ou/TXhfwJixIkuYowltPW0C38k4H7HqLf3dZrKpV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=MPrtTakm; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=cNGdsyPceoWUuL8xZ5WGAkLHDFlCSCqGdg6aJ6Nosq8=;
	t=1733231565; x=1734441165; b=MPrtTakmtCwPoDv9Mqc+ZXDV2t+ktFvuGFJ8f2JzlL2kIEQ
	U/3/rCySdV7N1unbzyvKOMfYWtyqqXZDcE6vbEVsOObOiILQXGBr2VYQfw2WL7LfPw873jfsdw7z5
	KJejoxBy1s3ngyAu+KxktCblJjy/CinrVCsJZ0v8tsaHp3aNTe5XT49NezX2KUpeKgMg9xjPWAE7U
	ufEK5NYEMTPeAHb2vsYJ5h7IE24a5y6S8X7NaUG8Z9knKJgtNCCr+7Ex2a4hu4xUc2OeotCELFvFj
	LwyuF0UechCS34Yc+1EgBfP1any0MthysgYqVJZY6ziQ24TiGfGMj3jVs/uJVG0A==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98)
	(envelope-from <johannes@sipsolutions.net>)
	id 1tIShe-00000002Trb-3mai;
	Tue, 03 Dec 2024 14:12:35 +0100
Message-ID: <016ba49a8b072f89fc4340341be166e26cc1b9a8.camel@sipsolutions.net>
Subject: Re: [PATCH net-next v1 7/7] netlink: specs: wireless: add a spec
 for nl80211
From: Johannes Berg <johannes@sipsolutions.net>
To: Donald Hunter <donald.hunter@gmail.com>, netdev@vger.kernel.org, Jakub
 Kicinski <kuba@kernel.org>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon
 Horman <horms@kernel.org>, linux-wireless@vger.kernel.org
Cc: donald.hunter@redhat.com
Date: Tue, 03 Dec 2024 14:12:34 +0100
In-Reply-To: <20241203130655.45293-8-donald.hunter@gmail.com>
References: <20241203130655.45293-1-donald.hunter@gmail.com>
	 <20241203130655.45293-8-donald.hunter@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-2.fc40) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Tue, 2024-12-03 at 13:06 +0000, Donald Hunter wrote:
> Add a rudimentary YNL spec for nl80211 that covers get-wiphy and
> get-interface.

OK, that says what it's doing, but why?

Also, I don't know how we will maintain this if it's not tied to any
kernel code. What do you suggest? Do you want to just maintain it
following the nl80211.h spec all the time?

> +operations:
> +  enum-model: directional
> +  list:
> +    -
> +      name: get-wiphy
> +      doc: Get information about a wiphy or dump a list of all wiphys
> +      attribute-set: nl80211-attrs
> +      do:
> +        request:
> +          value: 1
> +          attributes:
> +            - wiphy
> +        reply:
> +          value: 3
> +      dump:
> +        request:
> +          attributes:
> +            - wiphy
>=20

This already seems wrong - dump wiphy really should unconditionally
include NL80211_ATTR_SPLIT_WIPHY_DUMP these days.

johannes

