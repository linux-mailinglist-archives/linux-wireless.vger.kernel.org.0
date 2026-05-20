Return-Path: <linux-wireless+bounces-36733-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IDzxAksqDmpq6gUAu9opvQ
	(envelope-from <linux-wireless+bounces-36733-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 20 May 2026 23:40:27 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B550A59B2EC
	for <lists+linux-wireless@lfdr.de>; Wed, 20 May 2026 23:40:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0A60F3060950
	for <lists+linux-wireless@lfdr.de>; Wed, 20 May 2026 21:40:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBA6A3955F0;
	Wed, 20 May 2026 21:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="T4Ip8HFK"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E806739F17F;
	Wed, 20 May 2026 21:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779313209; cv=none; b=dofH3HtUnG2kDDEAKfIbpurZyxpaMuVSTOTU/Ha0ddUPs5RHxwOhMGmkj1XQliHbOqDOMw4bt+0J7vGIW3AMLboL2f3FbnoGdD0UqW5+8KCoQommno3InTb3E+lt18PnU5L4KyHlQnpuoaKZuW03GZfRl3Q4nGivtf6PPfJVkI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779313209; c=relaxed/simple;
	bh=0t78VNT3MDuLej6QDJZbgndGGVnTNJPx4/DHHRVrdJ4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=J/Nz5A4bdQL9g6iJh7C1ftKs1F7tY2sEOoFo84XfSfvFZxmwsrKQHFadzZ4U0s9OV5cJHN6Mu2Ffykpz49tl7SfCHndEne5Cc/3kxHgBmGlcjl6myX3bYIgzO0+Q9DaL30RmqcLLp03V2X0XlzsZgp73auyrYFdXG5Yz1sml/nQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=permerror header.from=sipsolutions.net; spf=none smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=T4Ip8HFK; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=permerror header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=0t78VNT3MDuLej6QDJZbgndGGVnTNJPx4/DHHRVrdJ4=;
	t=1779313208; x=1780522808; b=T4Ip8HFK+PQmwWuwHRO7aFuDMO+ieWc6xHvP/Nqj8yLfKgO
	Wxq0L19IKJ1+XOK3peOesIGCR9zpEsR4RipIOlPhiFqIlrPMrDAxogRQQXTnIsnYtMnvzsm5NIFcx
	BmYafn427MFoG7uc9kl7MYI6XZnpvL4XehYLtlIp/xU3OadA3Uk96C5Y/mLNGaAg3jD1OXKi7n+YT
	neFlFmDI3T6ApVyO6hZaQvSw6REqd2zSDghVc5mw2b0zJB7I959oPmu6dlHHNuHjSCiAstIVlgfuv
	DOKCelH4C+wQkKXsccFeTT4UDcQ9H6ivF7VTrjXvf5ThxXfXdCX5VZHLZXmJ6e9w==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1wPode-0000000AvjQ-04At;
	Wed, 20 May 2026 23:39:38 +0200
Message-ID: <01692b53456bfaa98778f3f1ab2a906bc25bad04.camel@sipsolutions.net>
Subject: Re: [PATCH 09/10] [v6 omap] ARM: dts: omap2: add stlc4560
 spi-wireless node
From: Johannes Berg <johannes@sipsolutions.net>
To: Arnd Bergmann <arnd@kernel.org>, linux-gpio@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Christian
 Lamparter <chunkeey@googlemail.com>, Aaro Koskinen <aaro.koskinen@iki.fi>,
 Andreas Kemnade	 <andreas@kemnade.info>, Kevin Hilman
 <khilman@baylibre.com>, Roger Quadros	 <rogerq@kernel.org>, Tony Lindgren
 <tony@atomide.com>, Thomas Bogendoerfer	 <tsbogend@alpha.franken.de>, John
 Paul Adrian Glaubitz	 <glaubitz@physik.fu-berlin.de>, Thomas Gleixner
 <tglx@kernel.org>, Ingo Molnar	 <mingo@redhat.com>, Borislav Petkov
 <bp@alien8.de>, Dave Hansen	 <dave.hansen@linux.intel.com>, x86@kernel.org,
 "H. Peter Anvin" <hpa@zytor.com>,  Linus Walleij <linusw@kernel.org>,
 Bartosz Golaszewski <brgl@kernel.org>, Dmitry Torokhov	
 <dmitry.torokhov@gmail.com>, Lee Jones <lee@kernel.org>, Pavel Machek	
 <pavel@kernel.org>, Matti Vaittinen <mazziesaccount@gmail.com>, Florian
 Fainelli <florian.fainelli@broadcom.com>, Jonas Gorski
 <jonas.gorski@gmail.com>, Andrew Lunn	 <andrew@lunn.ch>, Vladimir Oltean
 <olteanv@gmail.com>, "David S. Miller"	 <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski	 <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, 	linux-wireless@vger.kernel.org,
 linux-omap@vger.kernel.org, 	linux-arm-kernel@lists.infradead.org,
 linux-mips@vger.kernel.org, 	linux-sh@vger.kernel.org,
 linux-input@vger.kernel.org, 	linux-leds@vger.kernel.org,
 netdev@vger.kernel.org, Krzysztof Kozlowski	 <krzk@kernel.org>
Date: Wed, 20 May 2026 23:39:36 +0200
In-Reply-To: <20260520183815.2510387-10-arnd@kernel.org>
References: <20260520183815.2510387-1-arnd@kernel.org>
	 <20260520183815.2510387-10-arnd@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[sipsolutions.net:s=mail];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	TAGGED_FROM(0.00)[bounces-36733-lists,linux-wireless=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[41];
	DMARC_NA(0.00)[sipsolutions.net: no valid DMARC record];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[sipsolutions.net:+];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[johannes@sipsolutions.net,linux-wireless@vger.kernel.org];
	FREEMAIL_CC(0.00)[vger.kernel.org,arndb.de,googlemail.com,iki.fi,kemnade.info,baylibre.com,kernel.org,atomide.com,alpha.franken.de,physik.fu-berlin.de,redhat.com,alien8.de,linux.intel.com,zytor.com,gmail.com,broadcom.com,lunn.ch,davemloft.net,google.com,lists.infradead.org];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sipsolutions.net:mid,sipsolutions.net:dkim]
X-Rspamd-Queue-Id: B550A59B2EC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, 2026-05-20 at 20:38 +0200, Arnd Bergmann wrote:
>=20
> v1 through v5: adaptations that correspond to the binding updates

FWIW, I had just applied v5 of these three patches today, but didn't
send out a pull request yet. I'll do that tomorrow morning.

johannes

