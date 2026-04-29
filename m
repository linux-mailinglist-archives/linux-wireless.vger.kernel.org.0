Return-Path: <linux-wireless+bounces-35631-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YPohASEM8mkynQEAu9opvQ
	(envelope-from <linux-wireless+bounces-35631-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 29 Apr 2026 15:48:17 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AE61495198
	for <lists+linux-wireless@lfdr.de>; Wed, 29 Apr 2026 15:48:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D6F18303FF2F
	for <lists+linux-wireless@lfdr.de>; Wed, 29 Apr 2026 13:47:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15F87282F38;
	Wed, 29 Apr 2026 13:47:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vinatta.cz header.i=@vinatta.cz header.b="otnTPg6u"
X-Original-To: linux-wireless@vger.kernel.org
Received: from vinatta.cz (vinatta.cz [37.205.8.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 230C2282F3F;
	Wed, 29 Apr 2026 13:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.205.8.231
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777470457; cv=none; b=JNf5ccxLEWHeEfK8isga5V43kPum9kUm1/8SbEZ+/3kHNWSEoEuf/GyJErcwbCTZmQxx5bPPbk+aZA2I420FdE3iKPXbD3NXrqKgMwuIIHr4B/GR88kzIG/RRMI9C/jjwoqhudRbC96BeLAl8nZOwGberaCbiOEgu++4TIuqFa0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777470457; c=relaxed/simple;
	bh=JyD9N6Ij95cqvpxxFh8VLzH49Q7Wi4pb3Y7hHvQF+04=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:To:From:
	 References:In-Reply-To; b=GmUWIfFUjcfH3OuUpuIB+0mil82f98vESjYCAq5gVPI/NglSE0N4qdomHuS7Lp+S4FwggEAX5aEJ1R0WrNRNSvFkldg/gaDBAQuMz4aYLard5S9WGf/eqUydFBMYCPCZmhkiDN26keeayyorBQABUQyTGurbqQ9vCVdyAZLuzE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=matfyz.cz; spf=pass smtp.mailfrom=vinatta.cz; dkim=pass (2048-bit key) header.d=vinatta.cz header.i=@vinatta.cz header.b=otnTPg6u; arc=none smtp.client-ip=37.205.8.231
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=matfyz.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vinatta.cz
DKIM-Signature: a=rsa-sha256; bh=JyD9N6Ij95cqvpxxFh8VLzH49Q7Wi4pb3Y7hHvQF+04=;
 c=relaxed/relaxed; d=vinatta.cz;
 h=Subject:Subject:Sender:To:To:Cc:Cc:From:From:Date:Date:MIME-Version:MIME-Version:Content-Type:Content-Type:Content-Transfer-Encoding:Content-Transfer-Encoding:Reply-To:In-Reply-To:In-Reply-To:Message-Id:Message-Id:References:References:Autocrypt:Openpgp;
 i=@vinatta.cz; s=default; t=1777470441; v=1; x=1777902441;
 b=otnTPg6uWq6gqFJy+vqFLMal46yT3ld3zQMamAvKUdZNveA8sXWIOYrKljpaBQIm2pKBRxOp
 Z7aqLUy5+aRbozH9NDZTGgUEHkv2rF1yN+kBW1kZ5LpL9CXEWiFfkBh5K+M4J3vnGxtUTG6cOt0
 UlmpHs8LBi4DI4NK7eB5m24ct93WS17ksuNiCPGDck9MASiQ7EWZp5bwi77T11vZafLInah4v7s
 DMM4ezsEfhvVJTbUOQGnaRd6SRJyORfmfpcQkIhjTP86FdYYzIHC27ANPEUHp485MEMfSO8wqss
 OxlVl2pApd+gEAzqaUe6EYmUgTZhcXlnywFzGlezkTt4A==
Received: by vinatta.cz (envelope-sender <karel@vinatta.cz>) with ESMTPS id
 b6cf7064; Wed, 29 Apr 2026 15:47:21 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 29 Apr 2026 15:47:21 +0200
Message-Id: <DI5OONVN1JRZ.1UD6VZEVZNUXV@matfyz.cz>
Cc: "Brian Norris" <briannorris@chromium.org>, "Johannes Berg"
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
To: "Francesco Dolcini" <francesco@dolcini.it>
From: "Karel Balej" <balejk@matfyz.cz>
References: <20251026182602.26464-1-balejk@matfyz.cz>
 <DEJL1ATTQMVE.120JV9YW59I27@matfyz.cz>
 <aSnWYS2g5slVFaSk@gaggiata.pivistrello.it>
 <DI5L100Q1RKO.1A68EJIPWYSRC@matfyz.cz>
 <20260429112232.GD17033@francesco-nb>
 <DI5O432AFZVX.3VGKJP31AZX97@matfyz.cz>
 <20260429134011.GA73482@francesco-nb>
In-Reply-To: <20260429134011.GA73482@francesco-nb>
X-Rspamd-Queue-Id: 8AE61495198
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[vinatta.cz:s=default];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[matfyz.cz : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-35631-lists,linux-wireless=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[chromium.org,sipsolutions.net,kernel.org,dujemihanovic.xyz,lunn.ch,bootlin.com,gmail.com,linaro.org,nxp.com,vger.kernel.org,lists.infradead.org,lists.sr.ht,ixit.cz];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[balejk@matfyz.cz,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[vinatta.cz:+];
	NEURAL_HAM(-0.00)[-0.998];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless,dt];
	RCPT_COUNT_TWELVE(0.00)[22];
	TO_DN_SOME(0.00)[]

Francesco Dolcini, 2026-04-29T15:40:11+02:00:
> I do not see any way forward without NXP.

Probably not for the firmware, no. That's why I'm asking Brian if it
would be possible to get the kernel support in without it as in the
Apple case, or whether there are any other options.

Karel

