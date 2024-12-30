Return-Path: <linux-wireless+bounces-16901-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9318E9FE3A7
	for <lists+linux-wireless@lfdr.de>; Mon, 30 Dec 2024 09:22:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7FD73188276E
	for <lists+linux-wireless@lfdr.de>; Mon, 30 Dec 2024 08:22:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7A7B199EAF;
	Mon, 30 Dec 2024 08:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="ag6IOxpK"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D53CEAD2;
	Mon, 30 Dec 2024 08:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735546971; cv=none; b=nC3BwxLFs+WBzxtyj1vHfaJTKCEr/2ofLFIj05EGYG8TamxolS1fIMTKIOEa2SBpXhePvZ3javJRCaDOxMHTxLHFsSvQztryNZ4iv/7AypWpqRnnTv18sx4W8KwmQFTaSd7sCVTt5bbn/benHCcD4Sw91M6Ry0p3blkRb4OHC7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735546971; c=relaxed/simple;
	bh=iib8E9w1MGsW1BZY46xcGKAWVKaSwK/OAEP04UJUNbY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=lcdKbktEgEpbxTj0slW+T0jjrz+blbcMZRPSa69Np7N2cizNgkzE10cT3qW1kapHyene6pzkcmyLte9OqD/yplROpgJAa+VECexd7E3q25wAyYrrpkTpcfTOq7tj2Dj9iXrdXZqUHR2UqgA4DitFZZIt973bKmaxzlRqBN1SN/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=ag6IOxpK; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=hKke8sGGINCImp0epVWbfl1Lh5lnzQ6cg5cR2+VSiCI=;
	t=1735546970; x=1736756570; b=ag6IOxpKG3UksFLNBmoDVVEWWFCWKgQR+HE1ZhnI/skFHYK
	lLWM2/iC0LF+o/LtduQGcWAI8wGtr40hi+uKSot+DTLDiHauVLszu+ynIVb0XqT4Un2hrwlH0aMRH
	l4sQ5VtzwVuGyTJLW3DMIqeow++9Sx5ZUEfjNKgjLv1GnpQEBnqBUb9cEg3KI6AoT1qP6uVK3jmzI
	+IHFailEk6BEcnfd1QhgjLoURYzkvqNUGqSRR7fNer0J2YiGXeHaA3Ut9sZYEClyKnRgJV/bxdpmK
	kn2Ug01pnCWbHLlZCR6hDYexIv+WV/fqipa447DnwFY89pWY1Z9dhqHUFpy3Nnkg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98)
	(envelope-from <johannes@sipsolutions.net>)
	id 1tSB2k-0000000FtmF-0Qhn;
	Mon, 30 Dec 2024 09:22:30 +0100
Message-ID: <b811d4af6a634d61389dfefacd49853c0e77f1d7.camel@sipsolutions.net>
Subject: Re: [PATCH] net: ethernet: toshiba: ps3_gelic_wireless: Remove
 driver using deprecated API wext
From: Johannes Berg <johannes@sipsolutions.net>
To: Philipp Hortmann <philipp.g.hortmann@gmail.com>, Andrew Lunn	
 <andrew+netdev@lunn.ch>, "David S . Miller" <davem@davemloft.net>, Eric
 Dumazet	 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni	 <pabeni@redhat.com>, Geoff Levand <geoff@infradead.org>, Simon
 Horman	 <horms@kernel.org>, Alexander Lobakin
 <aleksander.lobakin@intel.com>, 	netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: Kalle Valo <kvalo@kernel.org>, Alexandre Belloni	
 <alexandre.belloni@bootlin.com>, Claudiu Beznea <claudiu.beznea@tuxon.dev>,
  Geert Uytterhoeven <geert@linux-m68k.org>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Jeff Johnson	 <quic_jjohnson@quicinc.com>,
 Larry Finger <Larry.Finger@lwfinger.net>,  Nicolas Ferre
 <nicolas.ferre@microchip.com>, Pavel Machek <pavel@ucw.cz>, Stanislaw
 Gruszka <stf_xl@wp.pl>,  Gregory Greenman <gregory.greenman@intel.com>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, 
	linux-staging@lists.linux.dev, linux-wireless@vger.kernel.org, Arnd
 Bergmann	 <arnd@arndb.de>, Stefan Lippers-Hollmann <s.l-h@gmx.de>
Date: Mon, 30 Dec 2024 09:22:28 +0100
In-Reply-To: <20241224080755.194508-1-philipp.g.hortmann@gmail.com>
References: <20241224080755.194508-1-philipp.g.hortmann@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.2 (3.54.2-1.fc41) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Tue, 2024-12-24 at 09:07 +0100, Philipp Hortmann wrote:
> Driver was contributed in 2008.
>=20
> The following reasons lead to the removal:
> - This driver generates maintenance workload for itself and for API wext

So I've been wondering, why are you so concerned about this? And in
particular, more concerned about it than the people actually doing the
maintenance? :)

We got here because I removed a *staging* driver that was in the way of
some wext cleanups, but that had a thousand other reasons to never go
anywhere anyway.

> - wext is deprecated and only used by two wireless drivers in
>   mainline kernel

true

> - no progress changing to mac80211

It fundamentally cannot be converted to mac80211, it has a whole
different model. In fact it cannot even be converted to cfg80211 because
some APIs it uses just never existed there, and likely never will.

> Tested a rebased version of this patch on the Playstation 3. Used
> T2 Linux with Kernel 6.12.5 to test the Ethernet connection.
>=20

Arguably that's a pretty strong argument for *not* removing it, if it's
actually relatively simple today to bring up the latest kernel on a PS3.

johannes

