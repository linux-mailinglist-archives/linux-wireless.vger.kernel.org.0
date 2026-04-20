Return-Path: <linux-wireless+bounces-35020-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EKe1Advo5WlkpAEAu9opvQ
	(envelope-from <linux-wireless+bounces-35020-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Apr 2026 10:50:35 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 1554042876D
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Apr 2026 10:50:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D1C293016B3F
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Apr 2026 08:43:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3837388E5B;
	Mon, 20 Apr 2026 08:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="uz6d47vl"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77578388E55;
	Mon, 20 Apr 2026 08:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776674619; cv=none; b=kGQs4234L4fCf8yQNyZdu8p5bYDhQ7HOKr2rU3SHWvDdCgU77z/zxBcdNNNZa7QLm2Ts+HJe/1CbmrNIksguVpyjRHSuRP9WxuXFRPlvmlNq3mk9dqB3dLDLgBaoKefsgz41RYC4IH8tDpbKuWRLDA2G5QHF4Ko3fRX/s+a77zg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776674619; c=relaxed/simple;
	bh=SiMpNsxuTqKdP4Nz+xuM9/8Xeay8LMcqJNpsrYjeZvo=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=MwUlJmGID/IQqY6F6R9bKeg7P6mQTbBo2yJ3IeLovFrJD7wGi8ys4aDp5lgMfgRCAANXW7UNJ6gys7H7fjHg9e9DoTBY8o9Yygypd2VL5KeKciptYVK9zRK80Steym1FQxS8dFxEJVecCPc0x0xzMvi3lCd0b9gXVbEy/rRJV7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=uz6d47vl; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:To:From:Subject:Message-ID:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=VfLK/SrgHChF08QO9elV83WJzRM3AfcVpMSg5MkeJSI=;
	t=1776674618; x=1777884218; b=uz6d47vlZu5MiuflER/yHSzrX8EkzBYciv1iUjxdWThoUMj
	UyEY8FdDdMF/yXwO/CLvGBGluRn1OCaK8c08rFXkgAd1y1dpw2IHO0ZEBgl5Jt6b+Cnvu4WT4BYdn
	y8UcFTgKf58lQtLv44ddAQ1dcFN8QeMyX0DDa19qSR1jG85ObfSrEHANTPIPtgmm3eYSwqzHJk43U
	gpe2uUWhwH5deEBcSlrhDpvhaUWmTEVP/onWiv2KP0GEMSY7Y3ggdd11SyYxVLCZSwOMemyM/jVy/
	T3K+rvDX3nsFqL6odOlU+aQe9G6wTS+wFl6izpoIQLkHBx8cO7f/RLypSO4xQtow==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1wEkDn-00000002Jm3-1bMo;
	Mon, 20 Apr 2026 10:43:11 +0200
Message-ID: <6170788fcab2ec835597e3d7411928d36850c20a.camel@sipsolutions.net>
Subject: Re: [PATCH 1/9] bitfield: add FIELD_GET_SIGNED()
From: Johannes Berg <johannes@sipsolutions.net>
To: Yury Norov <ynorov@nvidia.com>, Thomas Gleixner <tglx@kernel.org>, Ingo
 Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen	
 <dave.hansen@linux.intel.com>, x86@kernel.org, "H. Peter Anvin"
 <hpa@zytor.com>,  Andy Lutomirski	 <luto@kernel.org>, Peter Zijlstra
 <peterz@infradead.org>, Jonathan Cameron	 <jic23@kernel.org>, David Lechner
 <dlechner@baylibre.com>, Nuno =?ISO-8859-1?Q?S=E1?=	 <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, Ping-Ke Shih	 <pkshih@realtek.com>,
 Richard Cochran <richardcochran@gmail.com>, Andrew Lunn	
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet	 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni	 <pabeni@redhat.com>, Alexandre Belloni
 <alexandre.belloni@bootlin.com>, Yury Norov <yury.norov@gmail.com>, Rasmus
 Villemoes <linux@rasmusvillemoes.dk>, Hans de Goede	 <hansg@kernel.org>,
 Linus Walleij <linusw@kernel.org>, Sakari Ailus	
 <sakari.ailus@linux.intel.com>, Salah Triki <salah.triki@gmail.com>, Achim
 Gratz <Achim.Gratz@Stromeko.DE>, Ben Collins <bcollins@watter.com>, 
	linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org, 
	linux-wireless@vger.kernel.org, netdev@vger.kernel.org, 
	linux-rtc@vger.kernel.org
Date: Mon, 20 Apr 2026 10:43:08 +0200
In-Reply-To: <20260417173621.368914-2-ynorov@nvidia.com>
References: <20260417173621.368914-1-ynorov@nvidia.com>
	 <20260417173621.368914-2-ynorov@nvidia.com>
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
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[sipsolutions.net,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[sipsolutions.net:s=mail];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	URIBL_MULTI_FAIL(0.00)[sipsolutions.net:server fail,sin.lore.kernel.org:server fail];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-35020-lists,linux-wireless=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[nvidia.com,kernel.org,redhat.com,alien8.de,linux.intel.com,zytor.com,infradead.org,baylibre.com,analog.com,realtek.com,gmail.com,lunn.ch,davemloft.net,google.com,bootlin.com,rasmusvillemoes.dk,Stromeko.DE,watter.com,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[34];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[johannes@sipsolutions.net,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[sipsolutions.net:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless,netdev];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sipsolutions.net:dkim,sipsolutions.net:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 1554042876D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, 2026-04-17 at 13:36 -0400, Yury Norov wrote:
> The bitfields are designed in assumption that fields contain unsigned
> integer values, thus extracting the values from the field implies
> zero-extending.
>=20
> Some drivers need to sign-extend their fields, and currently do it like:
>=20
> 	dc_re +=3D sign_extend32(FIELD_GET(0xfff000, tmp), 11);
> 	dc_im +=3D sign_extend32(FIELD_GET(0xfff, tmp), 11);

That's indeed pretty awful...


> +#define FIELD_GET_SIGNED(mask, reg)					\
>=20

[...]

I (personally) tend to prefer the "__MAKE_OP" versions (*_get_bits()
etc.), in particular because WiFi and firmware interfaces deal a lot
with fixed endian fields.

Any chance it'd be simple to generate u32_get_bits_signed() etc.? Could
be especially useful for le32_get_bits_signed() for example, to have the
endian conversion built-in unlike FIELD_GET_SIGNED().

johannes

