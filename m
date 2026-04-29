Return-Path: <linux-wireless+bounces-35596-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0DkUHgzq8WmalQEAu9opvQ
	(envelope-from <linux-wireless+bounces-35596-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 29 Apr 2026 13:22:52 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 32CB1493724
	for <lists+linux-wireless@lfdr.de>; Wed, 29 Apr 2026 13:22:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id F262A300614A
	for <lists+linux-wireless@lfdr.de>; Wed, 29 Apr 2026 11:22:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6692C3F0A98;
	Wed, 29 Apr 2026 11:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b="wvEc/G6m"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C01E7175A81;
	Wed, 29 Apr 2026 11:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.194.8.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777461760; cv=none; b=ehGHuSWMM3CFYDm71iV25c2EVZEuFgGiRwFOziAz63MiZf9TxjcfMJpB+/+TN1nDpVj/3zf78Ti5jnAYLoX12SGQHGq+HoHTaK3DpFWr/Gf2blQK988rNddFpTfSlhsDXTmcfpPm/2XC1DvByGfdg2Cfba++S8VoCNOZbo3My1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777461760; c=relaxed/simple;
	bh=nM00K1yCTGWbLJ67CLFAJLSKUSfe1ahbLuQbeMdnPGg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZpP5nS0MyMDWwmiexFNGAPdIAyIkGgoFIHKztNe6XqiIHmeqLEocerF7oZWigsS053/lRJpYRoIqzUAjZ/Q9o0eAYg0sw2vNQtPmGNzPtS7SF+u25vLRXBuy171twthZ+wXHC0g1qnam6D05tr2ihQXfEi6oJcFqB4bbhegsED4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it; spf=pass smtp.mailfrom=dolcini.it; dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b=wvEc/G6m; arc=none smtp.client-ip=217.194.8.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Received: from francesco-nb (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
	by mail11.truemail.it (Postfix) with ESMTPA id 6607C22850;
	Wed, 29 Apr 2026 13:22:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1777461754;
	bh=nM00K1yCTGWbLJ67CLFAJLSKUSfe1ahbLuQbeMdnPGg=; h=From:To:Subject;
	b=wvEc/G6mjBE0GxM4bzoHZxQsbtrNL6QfVqrpNXiJgj2hb4jmIBOjrMSDhj60KFiyx
	 B12XCyED6SS4fMNsRpXPB5tMRVDX92AngCp8liFagKw35mNqFJiemKeJK+ZMBeLGwZ
	 X4u7CVL3qsNsThc1gr6U7bC3+gYI5dk3yJ/0hwgXCz+6+Srjfu5l/r89DAl1mE0QeI
	 REAYWN5VZH3QzxUnIx24Bstqhc/FLR8MBs+0rYBMAY9znW8lPQ7B5bnQTEvoTK3bWQ
	 b/3XkBTlpQq3tvVtsUOFt0rcHjSp+N6n3kkb9k932QfMll9U9D2BqNP8sAezcnpV2g
	 FAr2AjoEa2Zmw==
Date: Wed, 29 Apr 2026 13:22:32 +0200
From: Francesco Dolcini <francesco@dolcini.it>
To: Karel Balej <balejk@matfyz.cz>
Cc: Brian Norris <briannorris@chromium.org>,
	Francesco Dolcini <francesco@dolcini.it>,
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
Message-ID: <20260429112232.GD17033@francesco-nb>
References: <20251026182602.26464-1-balejk@matfyz.cz>
 <DEJL1ATTQMVE.120JV9YW59I27@matfyz.cz>
 <aSnWYS2g5slVFaSk@gaggiata.pivistrello.it>
 <DI5L100Q1RKO.1A68EJIPWYSRC@matfyz.cz>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DI5L100Q1RKO.1A68EJIPWYSRC@matfyz.cz>
X-Rspamd-Queue-Id: 32CB1493724
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[dolcini.it,none];
	R_DKIM_ALLOW(-0.20)[dolcini.it:s=default];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-35596-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[23];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[chromium.org,dolcini.it,sipsolutions.net,kernel.org,dujemihanovic.xyz,lunn.ch,bootlin.com,gmail.com,linaro.org,nxp.com,vger.kernel.org,lists.infradead.org,lists.sr.ht,ixit.cz];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[francesco@dolcini.it,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[dolcini.it:+];
	TAGGED_RCPT(0.00)[linux-wireless,dt];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]

Hello Karel,

On Wed, Apr 29, 2026 at 12:55:23PM +0200, Karel Balej wrote:
> without the firmware being in linux-firmware?

What's the license of this firmware? Am I wrong saying that if
the license allows it, you could just send a patch to have it integrated
to the linux-firmware repository? Is there any history or documentation
on the topic (please apologize if this is a well known topic, just
answer RTFM if this is the case).

I read a couple of days ago that for example the firmwares for the
various Apple arm64 laptop cannot be redistributed and every single
individual that wants to use those needs to extract those from their
system.

All of that seems just a legal matter, and IANAL ...

Francesco



