Return-Path: <linux-wireless+bounces-17102-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E9561A02035
	for <lists+linux-wireless@lfdr.de>; Mon,  6 Jan 2025 09:06:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8F2B6161CF9
	for <lists+linux-wireless@lfdr.de>; Mon,  6 Jan 2025 08:06:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EB021D63F6;
	Mon,  6 Jan 2025 08:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="lBSlYloT"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D32451D79A0;
	Mon,  6 Jan 2025 08:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736150812; cv=none; b=f+ZmZuL6Weqeqn4Wj0eRKokNxrRngXqZv6yI8YXPVq20aXaVY0eie+GTKvntWazxjoBmFVcp4Vfiy9C/p4H2T5VBqx4bEVKRlQfScTDRXdyKTM5AynOKwfNbeIRMXWb6pOaBfFlGgYWZnf/0YL9aUv5WGkYn654L8oyWlkcYy68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736150812; c=relaxed/simple;
	bh=UOjMZRVKEF8pAw+QVhlAmTbkMlSLTFrv44rO0QDuaHI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=T3dC2XibmBGdIkJyIPEbDWGllWBw42PP7uJC25EqiTziJF3Ay+usHKd7glmDssejVxqozPd+1sbuiYcv3WIncRQi/4K1srIjL8Zwm7aZaT777BNke/FiWKdyh2gT6UNtzreeddAKJfmULK2Ky5RwM9hPLiYfO5yHGrMoIspMu/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=lBSlYloT; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=UOjMZRVKEF8pAw+QVhlAmTbkMlSLTFrv44rO0QDuaHI=;
	t=1736150810; x=1737360410; b=lBSlYloTtX2e7qVzJsCoI3iCmBY0n5hs76jC1EHEMmN0YVY
	orXZT/8dxZWBL9fSlNjEWy+ZiykiVEpx44v1lMdyeQP6FlnVZn0cjcXksAYtDQuQzgynyrWGP3Ooy
	Usdmnie6KopLxPq/GvpVgZXzGKjelskAj6sIqjleshvhUO0gFESOWFm+O/k/qTd7lS6pPAGlToivp
	epdXbOCll/jaLfdPgTufFC9oz5pE0tcr3OJrk46tQoNOV4I9GPSKYIMEIV2jRtxnos6GmTeoRKqGO
	izhnp1+5Vk91VPG2BrMoLgzR3yUVmQtygoIDiHa0lwSwuyrdnPfZvzV4/D45DJpg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98)
	(envelope-from <johannes@sipsolutions.net>)
	id 1tUi7e-00000005muW-0BHU;
	Mon, 06 Jan 2025 09:06:02 +0100
Message-ID: <edc31a6341e810e23c342f1e90776a3e764c4924.camel@sipsolutions.net>
Subject: Re: [PATCH] net: ethernet: toshiba: ps3_gelic_wireless: Remove
 driver using deprecated API wext
From: Johannes Berg <johannes@sipsolutions.net>
To: Arnd Bergmann <arnd@arndb.de>, Philipp Hortmann	
 <philipp.g.hortmann@gmail.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>,  Paolo Abeni <pabeni@redhat.com>, Geoff
 Levand <geoff@infradead.org>, Simon Horman <horms@kernel.org>,  Alexander
 Lobakin <aleksander.lobakin@intel.com>, Netdev <netdev@vger.kernel.org>,
 linux-kernel@vger.kernel.org
Cc: Kalle Valo <kvalo@kernel.org>, Alexandre Belloni	
 <alexandre.belloni@bootlin.com>, Claudiu Beznea <claudiu.beznea@tuxon.dev>,
  Geert Uytterhoeven <geert@linux-m68k.org>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Jeff Johnson	 <quic_jjohnson@quicinc.com>,
 Larry Finger <Larry.Finger@lwfinger.net>,  Nicolas Ferre
 <nicolas.ferre@microchip.com>, Pavel Machek <pavel@ucw.cz>, Stanislaw
 Gruszka <stf_xl@wp.pl>,  Gregory Greenman <gregory.greenman@intel.com>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, 
	linux-staging@lists.linux.dev, linux-wireless@vger.kernel.org, Stefan
 Lippers-Hollmann	 <s.l-h@gmx.de>
Date: Mon, 06 Jan 2025 09:06:00 +0100
In-Reply-To: <cecd584c-46c0-4c0b-b3fb-b5cee4bbfd12@app.fastmail.com>
References: <20241224080755.194508-1-philipp.g.hortmann@gmail.com>
	 <b811d4af6a634d61389dfefacd49853c0e77f1d7.camel@sipsolutions.net>
	 <39256db9-3d73-4e86-a49b-300dfd670212@gmail.com>
	 <8414fd0c552de87b3471468665f7fc540b9bfa69.camel@sipsolutions.net>
	 <cecd584c-46c0-4c0b-b3fb-b5cee4bbfd12@app.fastmail.com>
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

On Sat, 2025-01-04 at 05:15 +0100, Arnd Bergmann wrote:
>=20
> I would assume that once removing CFG80211_WEXT becomes an option, we
> can just put the remaining parts of net/wireless/wext-*.c into both
> ps3_gelic and ipw2x00, duplicating and then simplifying the
> implementation. As far as I can tell, there is very little that is
> actually shared between the two anyway.

Indeed.

Note that net/wireless/wext-{core,proc,priv}.c are not even related to
CFG80211_WEXT (wext-{compat,sme}.c are), and just form the core wext
code that can be treated completely orthogonal and independent of
cfg80211. This driver doesn't even use CFG80211_WEXT code at all.

johannes

