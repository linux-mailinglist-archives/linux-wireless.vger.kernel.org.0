Return-Path: <linux-wireless+bounces-35617-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yEKMBOwG8mkimwEAu9opvQ
	(envelope-from <linux-wireless+bounces-35617-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 29 Apr 2026 15:26:04 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A6D26494C46
	for <lists+linux-wireless@lfdr.de>; Wed, 29 Apr 2026 15:25:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C96C3303AF24
	for <lists+linux-wireless@lfdr.de>; Wed, 29 Apr 2026 13:21:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E45D3FCB1C;
	Wed, 29 Apr 2026 13:21:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vinatta.cz header.i=@vinatta.cz header.b="IyM+Dn02"
X-Original-To: linux-wireless@vger.kernel.org
Received: from vinatta.cz (vinatta.cz [37.205.8.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39AE83FBEC2;
	Wed, 29 Apr 2026 13:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.205.8.231
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777468866; cv=none; b=d0hKgX3Iv80FDr3i0E6TF4AnRlNvy4y9EtCMKy/2/Uj7GqzqzEdeSjMLugddMbrjHPgiVeZtm9svRAkXnwBSnAKWVlWudoyWQiaI8J1bJfo60QelXB6w2XHP+LAJbGE27nSj9um2dW0MgyYjR1ZFI2njbvFGbdOUfaLnbDMyYCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777468866; c=relaxed/simple;
	bh=xqRqdqb9cql00b3xqlZ9Qf54W2TCp7JZjtSRq3okoys=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:To:From:
	 References:In-Reply-To; b=l1t8UcFwRIgWJP9/HjfE1rUWx+3HZBlHFONSca6gCkj92EEutu8TrXvKVhsF2aHyS6N4kuM6LNsJBkQW1mW58KvhrNAMb1kBV1KtJwS0pdQ5gvxgjSGso1p5vEhizqdO+v2A1rHwqYb/pGuHJ+FUd5Ez27Dz+0hOactjYwjnrco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=matfyz.cz; spf=pass smtp.mailfrom=vinatta.cz; dkim=pass (2048-bit key) header.d=vinatta.cz header.i=@vinatta.cz header.b=IyM+Dn02; arc=none smtp.client-ip=37.205.8.231
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=matfyz.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vinatta.cz
DKIM-Signature: a=rsa-sha256; bh=xqRqdqb9cql00b3xqlZ9Qf54W2TCp7JZjtSRq3okoys=;
 c=relaxed/relaxed; d=vinatta.cz;
 h=Subject:Subject:Sender:To:To:Cc:Cc:From:From:Date:Date:MIME-Version:MIME-Version:Content-Type:Content-Type:Content-Transfer-Encoding:Content-Transfer-Encoding:Reply-To:In-Reply-To:In-Reply-To:Message-Id:Message-Id:References:References:Autocrypt:Openpgp;
 i=@vinatta.cz; s=default; t=1777468828; v=1; x=1777900828;
 b=IyM+Dn02OPnovfHH7qNxVHpRW3lq/vYVi8gIZcW4AH7D2xne9s+wetiIl+wxpJE6OZFyTOkm
 RguW5ARTHy3psH4xEHq1wSvuu9pVbbBnDs7WkbnysjUgPn2Zn3tjG/vwTwPw6Jzk8QNkZajEwln
 bEnKo/NHeCiP3dxeqdMa/VD2iYAHYg6eNe9oGnLxh+poF0IoDqoQFGNVA00lFNXMxn6Ic/jt0CK
 fy6UDDHUSrkQHQ1sajzCK6X3Ek3xAf3QWRyeapcFtUvNGmSxGuNDfAOtcZFgdBCEUkHi/u1pIh5
 7MIEt8s/hY14nWI79pi1zTXz57/0aOCSnp6eLVR7s/6cQ==
Received: by vinatta.cz (envelope-sender <karel@vinatta.cz>) with ESMTPS id
 2b91500b; Wed, 29 Apr 2026 15:20:28 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 29 Apr 2026 15:20:28 +0200
Message-Id: <DI5O432AFZVX.3VGKJP31AZX97@matfyz.cz>
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
In-Reply-To: <20260429112232.GD17033@francesco-nb>
X-Rspamd-Queue-Id: A6D26494C46
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[vinatta.cz:s=default];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[matfyz.cz : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-35617-lists,linux-wireless=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.995];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless,dt];
	RCPT_COUNT_TWELVE(0.00)[22];
	TO_DN_SOME(0.00)[]

Hello, Francesco,

Francesco Dolcini, 2026-04-29T13:22:32+02:00:
> On Wed, Apr 29, 2026 at 12:55:23PM +0200, Karel Balej wrote:
>> without the firmware being in linux-firmware?
>
> What's the license of this firmware? Am I wrong saying that if
> the license allows it, you could just send a patch to have it integrated
> to the linux-firmware repository? Is there any history or documentation
> on the topic (please apologize if this is a well known topic, just
> answer RTFM if this is the case).

that's one of the issues, the license is not specified explicitly
anywhere as far as I know. Likely it is the same as the other Marvell
blobs already in linux-firmware (the mrvl directory), but we don't know
for sure.

As far as I know, even if I was to submit the firmware myself, it would
still require a sign-off from someone from NXP [1].

> I read a couple of days ago that for example the firmwares for the
> various Apple arm64 laptop cannot be redistributed and every single
> individual that wants to use those needs to extract those from their
> system.

Are those blobs loaded by the mainline kernel? If so, it would be the
same situation as I'm proposing here I believe.

> All of that seems just a legal matter, and IANAL ...

It is.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/firmware/linux-firmware=
.git/about/#signed-off-by-requirement

Karel

