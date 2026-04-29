Return-Path: <linux-wireless+bounces-35639-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oMmFOF5Q8mlGpgEAu9opvQ
	(envelope-from <linux-wireless+bounces-35639-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 29 Apr 2026 20:39:26 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CB44A499393
	for <lists+linux-wireless@lfdr.de>; Wed, 29 Apr 2026 20:39:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D8593301A168
	for <lists+linux-wireless@lfdr.de>; Wed, 29 Apr 2026 18:36:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 959A241C313;
	Wed, 29 Apr 2026 18:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vinatta.cz header.i=@vinatta.cz header.b="sjExcYGf"
X-Original-To: linux-wireless@vger.kernel.org
Received: from vinatta.cz (vinatta.cz [37.205.8.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8104137E2F8;
	Wed, 29 Apr 2026 18:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.205.8.231
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777487812; cv=none; b=NAKup9Tr1WhfPoTM+J4IDNtj4Pvrwp8HPSL3W50wkdmhECra7njczNTr0PKIV5ClZ48zvRA55914dIXoB+NsH3eWCihjyJKTuioNmuqHfXXd2bNi3psOmMAYyhf087rP0rfr0dQBS7Ib9xLEnU2LOLRr5cCgoj8X5CdhDmeolec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777487812; c=relaxed/simple;
	bh=UaKL1VITGxGKAwtbx/cCauZTVexmzreqjwsha7+HCvw=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:To:From:
	 References:In-Reply-To; b=tfDIKL3wMtI5JN+xScEb+P7OlMwoCQkCc0KPrPkF1O7X5Hbx3il6mEGgyU85h3wMC5zHNRbcHHxE1JmELTY/LkvH3BzJ62ag81I9rXs15s2HkfzZ6RbXDQyDHE7r2RZIzTwNuOvgLaSxkBajyKX89TkqMEPPQIHdoSxbMv3an1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=matfyz.cz; spf=pass smtp.mailfrom=vinatta.cz; dkim=pass (2048-bit key) header.d=vinatta.cz header.i=@vinatta.cz header.b=sjExcYGf; arc=none smtp.client-ip=37.205.8.231
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=matfyz.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vinatta.cz
DKIM-Signature: a=rsa-sha256; bh=UaKL1VITGxGKAwtbx/cCauZTVexmzreqjwsha7+HCvw=;
 c=relaxed/relaxed; d=vinatta.cz;
 h=Subject:Subject:Sender:To:To:Cc:Cc:From:From:Date:Date:MIME-Version:MIME-Version:Content-Type:Content-Type:Content-Transfer-Encoding:Content-Transfer-Encoding:Reply-To:In-Reply-To:In-Reply-To:Message-Id:Message-Id:References:References:Autocrypt:Openpgp;
 i=@vinatta.cz; s=default; t=1777487786; v=1; x=1777919786;
 b=sjExcYGfSBa/pQLBcc/Y8CfPVNF1lRhd4ybKJ1qIB2T+LFZQR6E0kXI/k07g9Bdc6mKf0tVp
 Vu6SQxAbaZxOjrbujqb5MYda9E+oVkecOARdLpMfRX0ItiRfKoHSLwYNCpkVNIBF5urXUt5ISyd
 WxtKxwG6zIboC430MwLQp4oSmR+Jun1vL6mfiiFhWN1DTEt9JcEWPXnKA92Lg9Fb1k1jopDPNV9
 n7ROIzxHCXcDSLkdEPQDsDs+3f7ohcbMijRpsF5OngqzFtdXX6JESgJ9fC53NUyNyC9CL5HvHsF
 eAJs9FaBOw2pvSImfkK6oicWWkljST0nba1KWwY7tNP1w==
Received: by vinatta.cz (envelope-sender <karel@vinatta.cz>) with ESMTPS id
 9f7750af; Wed, 29 Apr 2026 20:36:26 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 29 Apr 2026 20:36:26 +0200
Message-Id: <DI5UU03J2IU3.61E7OU85TZJH@matfyz.cz>
Cc: "Francesco Dolcini" <francesco@dolcini.it>, "Johannes Berg"
 <johannes@sipsolutions.net>, "Rob Herring" <robh@kernel.org>, "Krzysztof
 Kozlowski" <krzk+dt@kernel.org>, "Conor Dooley" <conor+dt@kernel.org>,
 =?utf-8?q?Duje_Mihanovi=C4=87?= <duje@dujemihanovic.xyz>, "Andrew Lunn"
 <andrew@lunn.ch>, "Gregory Clement" <gregory.clement@bootlin.com>,
 "Sebastian Hesselbarth" <sebastian.hesselbarth@gmail.com>, "Ulf Hansson"
 <ulf.hansson@linaro.org>, "Frank Li" <Frank.Li@nxp.com>,
 <linux-wireless@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
 <linux-mmc@vger.kernel.org>, <~postmarketos/upstreaming@lists.sr.ht>,
 <phone-devel@vger.kernel.org>, "Jeff Chen" <jeff.chen_1@nxp.com>, "Peng
 Fan" <peng.fan@nxp.com>, <david@ixit.cz>
Subject: Re: [DONOTAPPLY RFC PATCH v2 0/4] WiFi support for
 samsung,coreprimevelte
To: "Brian Norris" <briannorris@chromium.org>
From: "Karel Balej" <balejk@matfyz.cz>
References: <20251026182602.26464-1-balejk@matfyz.cz>
 <DEJL1ATTQMVE.120JV9YW59I27@matfyz.cz>
 <aSnWYS2g5slVFaSk@gaggiata.pivistrello.it>
 <DI5L100Q1RKO.1A68EJIPWYSRC@matfyz.cz> <afI8y70U7wFT_07h@google.com>
In-Reply-To: <afI8y70U7wFT_07h@google.com>
X-Rspamd-Queue-Id: CB44A499393
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	R_DKIM_ALLOW(-0.20)[vinatta.cz:s=default];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[matfyz.cz : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-35639-lists,linux-wireless=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[22];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[dolcini.it,sipsolutions.net,kernel.org,dujemihanovic.xyz,lunn.ch,bootlin.com,gmail.com,linaro.org,nxp.com,vger.kernel.org,lists.infradead.org,lists.sr.ht,ixit.cz];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[balejk@matfyz.cz,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[vinatta.cz:+];
	NEURAL_HAM(-0.00)[-0.998];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless,dt];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,vinatta.cz:dkim]

Brian Norris, 2026-04-29T10:15:55-07:00:
>> and it would be great to not have to keep the
>> patches in a fork, especially when trying to build on top of them
>> further (such as to fix the driver-firmware incompatibilities discussed
>> in one of the patches of this series).
>
> Patch 3 is a different story. At the moment, it's definitely not
> acceptable. But I tried to provide hints about how you can write proper
> FW compatibility logic. I'm still not optimistic that'll be easy and
> maintainable, and we still reserve the right to reject patches if they
> make things unmaintainable.

I was referring to the original patches here, I would of course modify
the compability patch according to your feedback, I just didn't want to
invest the effort into that when it wasn't and still isn't clear if it
will ever be possible to upstream it.

I'm curious to hear from Johannes now then.

Thank you for the information,
Karel

