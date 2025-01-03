Return-Path: <linux-wireless+bounces-17039-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C2C1A00702
	for <lists+linux-wireless@lfdr.de>; Fri,  3 Jan 2025 10:33:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F45D3A422E
	for <lists+linux-wireless@lfdr.de>; Fri,  3 Jan 2025 09:32:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F8401E5710;
	Fri,  3 Jan 2025 09:32:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="L3+R9bOl"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9206C1E47DB;
	Fri,  3 Jan 2025 09:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735896759; cv=none; b=UV3HES+mNkfyJSvEkL7WcU0BwsLCGMyHuNsCjrAotLgHo1w7tZlk49w8smSTMS5ABpdMyPia8lRCGUuc23hyFM4xzdqNoTO/ijysDfcpGx3GOye7XIAjmMD8fRDoG2pieYh9FNfUreJHvTIR/Mk60puWcIj5JjQOW2oSzto6R0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735896759; c=relaxed/simple;
	bh=ns/LDV0S2a9mmpzFjocIineirzbQRti0e980RrsKsG4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KGxgrAcbluqOL3Dh1MPuaZi0LuDN6vwNffbnXOua2wU9INhfsH9Rlxc8roOhDkRcbni5D4e6CJ91VxcrzQdDM79Kjjhi+CM3NalnVxUPWZNdUut1yMPhnOZoXvKN08v02/+sb9guHwyrpqdQxNTWzrEXXhwW47ysDzvnS/kEBX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=L3+R9bOl; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=ns/LDV0S2a9mmpzFjocIineirzbQRti0e980RrsKsG4=;
	t=1735896757; x=1737106357; b=L3+R9bOlNJTYB+5VvWLH0RGuT+yEmWwRkbhsY62ENdnGBEM
	A4FvOrOllAIszTSzpBPhTlKjbHA+TsdKLz/t5aZFQUv3THUv8YYHdD+KZh0fEjAruVwdgn0ng4bRH
	IeMxv47pGgKJ1KWL+PqbatLtkRBpCrpTaY1yhW6Y1uwaSE3Ncu0Gyg7c5qb7cXhzEsSoSrtP5DoN9
	YKLncFVO8iVLA+hu8+YufuTp/wXN8QQi+alFQQXtObf6N3HA9JKabBoXGBefDrnz2obyjlBItEK4c
	F3fuZVx+7FK+2XkGBKj1O8Liri36afF1ps+xteW5fNNz5CgD9t7p8QDsHf7BXx0Q==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98)
	(envelope-from <johannes@sipsolutions.net>)
	id 1tTe2O-00000002St6-2Pxg;
	Fri, 03 Jan 2025 10:32:12 +0100
Message-ID: <eaa12e5d58cb61b5a8acda7e889d4c4549bacc79.camel@sipsolutions.net>
Subject: Re: [PATCH] net: ethernet: toshiba: ps3_gelic_wireless: Remove
 driver using deprecated API wext
From: Johannes Berg <johannes@sipsolutions.net>
To: Geert Uytterhoeven <geert@linux-m68k.org>, David Woodhouse
	 <dwmw2@infradead.org>
Cc: Philipp Hortmann <philipp.g.hortmann@gmail.com>, Andrew Lunn	
 <andrew+netdev@lunn.ch>, "David S . Miller" <davem@davemloft.net>, Eric
 Dumazet	 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni	 <pabeni@redhat.com>, Geoff Levand <geoff@infradead.org>, Simon
 Horman	 <horms@kernel.org>, Alexander Lobakin
 <aleksander.lobakin@intel.com>, 	netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Kalle Valo <kvalo@kernel.org>,  Alexandre
 Belloni <alexandre.belloni@bootlin.com>, Claudiu Beznea
 <claudiu.beznea@tuxon.dev>, Greg Kroah-Hartman	
 <gregkh@linuxfoundation.org>, Jeff Johnson <quic_jjohnson@quicinc.com>, 
 Larry Finger <Larry.Finger@lwfinger.net>, Nicolas Ferre
 <nicolas.ferre@microchip.com>, Pavel Machek	 <pavel@ucw.cz>, Stanislaw
 Gruszka <stf_xl@wp.pl>, linuxppc-dev	 <linuxppc-dev@lists.ozlabs.org>,
 linux-staging@lists.linux.dev, 	linux-wireless@vger.kernel.org, Arnd
 Bergmann <arnd@arndb.de>, Stefan Lippers-Hollmann	 <s.l-h@gmx.de>,
 Christoph Hellwig <hch@lst.de>
Date: Fri, 03 Jan 2025 10:32:11 +0100
In-Reply-To: <CAMuHMdXPSK-6_bMoiJyAsV4nhfW7HytZpOpf7Odg-4YKYNZfEA@mail.gmail.com>
References: <20241224080755.194508-1-philipp.g.hortmann@gmail.com>
	 <b811d4af6a634d61389dfefacd49853c0e77f1d7.camel@sipsolutions.net>
	 <39256db9-3d73-4e86-a49b-300dfd670212@gmail.com>
	 <CAMuHMdVGdpVqkdvoFxu84YgBh_0fsAKeBhWFEg+nDyGLwbruig@mail.gmail.com>
	 <11ae0b7362284d4828021068b05b38a280a9cee5.camel@infradead.org>
	 <CAMuHMdXPSK-6_bMoiJyAsV4nhfW7HytZpOpf7Odg-4YKYNZfEA@mail.gmail.com>
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

On Fri, 2025-01-03 at 10:25 +0100, Geert Uytterhoeven wrote:
>=20
> I was also considering it from the side of the wireless access point:
> if you have to provide an non-secure access point just for your PS3,

It supports WPA2/PSK (~2004) which is plenty secure. It's not "non-
secure", it's just "not secure per WPA3 (2018) standard". Many other
drivers in tree don't support WPA3 for one reason or the other (mostly
lack of management frame protection support.)

johannes

