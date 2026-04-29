Return-Path: <linux-wireless+bounces-35595-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EOzzFP3j8WlZlAEAu9opvQ
	(envelope-from <linux-wireless+bounces-35595-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 29 Apr 2026 12:57:01 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A17BF493412
	for <lists+linux-wireless@lfdr.de>; Wed, 29 Apr 2026 12:57:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0EFA430173A6
	for <lists+linux-wireless@lfdr.de>; Wed, 29 Apr 2026 10:55:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D0A53EF0C4;
	Wed, 29 Apr 2026 10:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vinatta.cz header.i=@vinatta.cz header.b="IE9hT5cj"
X-Original-To: linux-wireless@vger.kernel.org
Received: from vinatta.cz (vinatta.cz [37.205.8.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEE1021B9F6;
	Wed, 29 Apr 2026 10:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.205.8.231
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777460155; cv=none; b=Xc/aMmsGt0n7Y7xOyQzkR5vqQNHvaHpsnTc27VQ4BZg2XMmH0/rnA2MT0phG90aGYhDH8A0tdF+GRZLz/kANnZHmgCQw0yfvpbgmWteJHkqFBDK3akiq9kQaiqGuuBnpzDIGH/qlaloyJU7Sq452gllvQl7QRmp+RT4M9++BAMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777460155; c=relaxed/simple;
	bh=Fmly2pB3Jdw6CU7aua3Gt1Tb8FZySUz2f9Q9kbm89gQ=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:To:From:
	 References:In-Reply-To; b=DBUVpHLdJ/nXCumu94PuKK74mFfYQCvS4uvaRD84QDJqnttDLwlj1eeG/emedUX1xqTjSetk3acvzITbS7Tod5KpprduhECwTNL79WyaZ1OD7YDITZogeVqPgA2VtHd04Gf2dt/VIsp4NEhMcIcH5NCUnpNdUG+T6n3z/tby5m8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=matfyz.cz; spf=pass smtp.mailfrom=vinatta.cz; dkim=pass (2048-bit key) header.d=vinatta.cz header.i=@vinatta.cz header.b=IE9hT5cj; arc=none smtp.client-ip=37.205.8.231
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=matfyz.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vinatta.cz
DKIM-Signature: a=rsa-sha256; bh=Fmly2pB3Jdw6CU7aua3Gt1Tb8FZySUz2f9Q9kbm89gQ=;
 c=relaxed/relaxed; d=vinatta.cz;
 h=Subject:Subject:Sender:To:To:Cc:Cc:From:From:Date:Date:MIME-Version:MIME-Version:Content-Type:Content-Type:Content-Transfer-Encoding:Content-Transfer-Encoding:Reply-To:In-Reply-To:In-Reply-To:Message-Id:Message-Id:References:References:Autocrypt:Openpgp;
 i=@vinatta.cz; s=default; t=1777460123; v=1; x=1777892123;
 b=IE9hT5cjZEmIwG9IIdx+fcVqsAG5vT54+uzxwHiRxM0qxsFe8xvtdB5JsLOmQepxxwoCxtyb
 TM2YyAJJZ5UbMb5FtR5kcijOJLoblavspW1N+ZG7G3wkE5/DFWnrVyZmY0EoM2BBwceSKRh4Z4p
 vIzF+E6YexybCwcyabYmLNTEok0LHtxFh2l8fepePWj0RpUmB+J6ChmiJy5/EqCOhfhw6xb1qN3
 lP0CZiGLNO7QX/PTkLwUk9NVmRsPAgFAg5zHLuPRuOBi4mdC55z9zzj2ca/aoZvXzF6L1q0uuvF
 GxJEdCqfwVXGEGS7eiMO2CPd07ZakUhWpFIOe9f/L6ySA==
Received: by vinatta.cz (envelope-sender <karel@vinatta.cz>) with ESMTPS id
 740817af; Wed, 29 Apr 2026 12:55:23 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 29 Apr 2026 12:55:23 +0200
Message-Id: <DI5L100Q1RKO.1A68EJIPWYSRC@matfyz.cz>
Cc: "Johannes Berg" <johannes@sipsolutions.net>, "Rob Herring"
 <robh@kernel.org>, "Krzysztof Kozlowski" <krzk+dt@kernel.org>, "Conor
 Dooley" <conor+dt@kernel.org>, =?utf-8?q?Duje_Mihanovi=C4=87?=
 <duje@dujemihanovic.xyz>, "Andrew Lunn" <andrew@lunn.ch>, "Gregory Clement"
 <gregory.clement@bootlin.com>, "Sebastian Hesselbarth"
 <sebastian.hesselbarth@gmail.com>, "Ulf Hansson" <ulf.hansson@linaro.org>,
 "Frank Li" <Frank.Li@nxp.com>, <linux-wireless@vger.kernel.org>,
 <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-arm-kernel@lists.infradead.org>, <linux-mmc@vger.kernel.org>,
 <~postmarketos/upstreaming@lists.sr.ht>, <phone-devel@vger.kernel.org>,
 "Jeff Chen" <jeff.chen_1@nxp.com>, "Peng Fan" <peng.fan@nxp.com>,
 <david@ixit.cz>
Subject: Re: [DONOTAPPLY RFC PATCH v2 0/4] WiFi support for
 samsung,coreprimevelte
To: "Brian Norris" <briannorris@chromium.org>, "Francesco Dolcini"
 <francesco@dolcini.it>
From: "Karel Balej" <balejk@matfyz.cz>
References: <20251026182602.26464-1-balejk@matfyz.cz>
 <DEJL1ATTQMVE.120JV9YW59I27@matfyz.cz>
 <aSnWYS2g5slVFaSk@gaggiata.pivistrello.it>
In-Reply-To: <aSnWYS2g5slVFaSk@gaggiata.pivistrello.it>
X-Rspamd-Queue-Id: A17BF493412
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	R_DKIM_ALLOW(-0.20)[vinatta.cz:s=default];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[matfyz.cz : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-35595-lists,linux-wireless=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[22];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[sipsolutions.net,kernel.org,dujemihanovic.xyz,lunn.ch,bootlin.com,gmail.com,linaro.org,nxp.com,vger.kernel.org,lists.infradead.org,lists.sr.ht,ixit.cz];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[balejk@matfyz.cz,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[vinatta.cz:+];
	NEURAL_HAM(-0.00)[-0.998];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless,dt];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vinatta.cz:dkim]

Hello,

Francesco Dolcini, 2025-11-28T18:05:37+01:00:
> Hello Karel,
>
> On Thu, Nov 27, 2025 at 04:29:12PM +0100, Karel Balej wrote:
>> To reiterate, the firmware is generally available but is not part of
>> linux-firmware and the entire process of upstreaming the chipset support=
 is
>> stuck on that.
>
> I'll try to see if any of my contact in NXP Wi-Fi group is able to help. =
Give
> me a few days.

so I was in a long conversation over the past months with Jeff from NXP
who was very helpful and tried to arrange for the upstreaming of the
firmware. Unfortunately however, his efforts were ultimately rejected by
the internal management.

We were directed to try to reach out to NXP via the customer support
page which yielded nothing. The current situation is thus the same as a
few months ago, summarized in my quote above.

Brian, what are the options here now? Would it be possible to make an
exception and accept the patches without the firmware being in
linux-firmware? This is an old device with no mainstream audience so I
expect everyone who will want to use it will be able to supply the
firmware themselves and it would be great to not have to keep the
patches in a fork, especially when trying to build on top of them
further (such as to fix the driver-firmware incompatibilities discussed
in one of the patches of this series).

Francesco, would you perhaps still be able to help in any way?

Thank you, kind regards,
K. B.

