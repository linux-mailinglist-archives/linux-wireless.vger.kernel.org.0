Return-Path: <linux-wireless+bounces-35628-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aAJiKQwM8mkynQEAu9opvQ
	(envelope-from <linux-wireless+bounces-35628-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 29 Apr 2026 15:47:56 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 476D5495160
	for <lists+linux-wireless@lfdr.de>; Wed, 29 Apr 2026 15:47:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DD2E03098144
	for <lists+linux-wireless@lfdr.de>; Wed, 29 Apr 2026 13:42:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD52F401A2A;
	Wed, 29 Apr 2026 13:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b="tAezjJF2"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F2FD3FE667;
	Wed, 29 Apr 2026 13:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.194.8.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777470023; cv=none; b=I66kcZfELtPISjrnu9Trpi4K+uX7/thNHrBliglmgEwZgzbBSe56Oa6pO1DuSv6+S4KNvxIjCQfDeINqn32S2rYyaM7wC+vLVAJ3+D8aj8TNPd28N1D0RHUUwzHLFLCWHdy3gAEjTY9RJGzJvHon9LzVrTT3Qnm5a9ThcZJ3fSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777470023; c=relaxed/simple;
	bh=ubA9OYFNJvf2zxEAbK0cumXlbYJQl0x/+LIO+/dpBqo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tu2vbRj7CxB2UXQldfbnV1tRJqdElUr+chJQNRsDKxqZMBpWnyA2FRNVaPOB209dKRu/2VKLHKbwX95MQjwLlDPfKQwhBxzI+geIVfD18GKZCglqEperrGX1y4X+2sOTsgolOz9a/YNimnf2u6CLjOBDQE18BnTghuOU8veYIYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it; spf=pass smtp.mailfrom=dolcini.it; dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b=tAezjJF2; arc=none smtp.client-ip=217.194.8.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Received: from francesco-nb (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
	by mail11.truemail.it (Postfix) with ESMTPA id A054F22BA3;
	Wed, 29 Apr 2026 15:40:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1777470015;
	bh=wbdghP89407ki72C54bZEEXFY2jq+D9w1Aq8ZiLnoZw=; h=From:To:Subject;
	b=tAezjJF24BF4hg11VMQFul5zOsbu6N1rm0cj6pHYem2jSptlxX6CHhVV9lTNJvnU5
	 /0C9M5TyXuezBAZPtd6OYF5NgcNCmoQIimB5W6oVTanbpzAPfcdOVlMrad5D02Eokv
	 eZ3rBhmRnqJLrbtrHLD0hXoVM5Eto+AlnIFVQxLNevkxhfz1B2edLbzo2kKwvPSqXv
	 A4/Jf+0gf1vYElZBZy9E9m5PgcNIxEOIBluMP6SZFV44Rq/pHbj1ljvZcddF7Pf44J
	 jNzTpLh0RlzHjl+IO8nhiJ/HcUEqAaO+ZgwVB2y8ezTL8whQ8S7ieVkksU+zQYfJUC
	 gpTf7+FWWcnrg==
Date: Wed, 29 Apr 2026 15:40:11 +0200
From: Francesco Dolcini <francesco@dolcini.it>
To: Karel Balej <balejk@matfyz.cz>
Cc: Francesco Dolcini <francesco@dolcini.it>,
	Brian Norris <briannorris@chromium.org>,
	Johannes Berg <johannes@sipsolutions.net>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Duje =?utf-8?Q?Mihanovi=C4=87?= <duje@dujemihanovic.xyz>,
	Andrew Lunn <andrew@lunn.ch>,
	Gregory Clement <gregory.clement@bootlin.com>,
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
	Ulf Hansson <ulf.hansson@linaro.org>, Frank Li <Frank.Li@nxp.com>,
	linux-wireless@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mmc@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
	phone-devel@vger.kernel.org, Jeff Chen <jeff.chen_1@nxp.com>,
	Peng Fan <peng.fan@nxp.com>, david@ixit.cz
Subject: Re: [DONOTAPPLY RFC PATCH v2 0/4] WiFi support for
 samsung,coreprimevelte
Message-ID: <20260429134011.GA73482@francesco-nb>
References: <20251026182602.26464-1-balejk@matfyz.cz>
 <DEJL1ATTQMVE.120JV9YW59I27@matfyz.cz>
 <aSnWYS2g5slVFaSk@gaggiata.pivistrello.it>
 <DI5L100Q1RKO.1A68EJIPWYSRC@matfyz.cz>
 <20260429112232.GD17033@francesco-nb>
 <DI5O432AFZVX.3VGKJP31AZX97@matfyz.cz>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DI5O432AFZVX.3VGKJP31AZX97@matfyz.cz>
X-Rspamd-Queue-Id: 476D5495160
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[dolcini.it,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[dolcini.it:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-35628-lists,linux-wireless=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[dolcini.it,chromium.org,sipsolutions.net,kernel.org,dujemihanovic.xyz,lunn.ch,bootlin.com,gmail.com,linaro.org,nxp.com,vger.kernel.org,lists.infradead.org,lists.sr.ht,ixit.cz];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[23];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[francesco@dolcini.it,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[dolcini.it:+];
	TAGGED_RCPT(0.00)[linux-wireless,dt];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[]

On Wed, Apr 29, 2026 at 03:20:28PM +0200, Karel Balej wrote:
> Francesco Dolcini, 2026-04-29T13:22:32+02:00:
> > On Wed, Apr 29, 2026 at 12:55:23PM +0200, Karel Balej wrote:
> >> without the firmware being in linux-firmware?
> >
> > What's the license of this firmware? Am I wrong saying that if
> > the license allows it, you could just send a patch to have it integrated
> > to the linux-firmware repository? Is there any history or documentation
> > on the topic (please apologize if this is a well known topic, just
> > answer RTFM if this is the case).
> 
> that's one of the issues, the license is not specified explicitly
> anywhere as far as I know.
That's enough to be blocked.

> As far as I know, even if I was to submit the firmware myself, it would
> still require a sign-off from someone from NXP [1].

And this is clearly there to avoid situation that are problematic from
a legal point of view.

I do not see any way forward without NXP.

Francesco

> [1] https://git.kernel.org/pub/scm/linux/kernel/git/firmware/linux-firmware.git/about/#signed-off-by-requirement

