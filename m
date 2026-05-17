Return-Path: <linux-wireless+bounces-36552-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id tZzjGjV9CWqVcQQAu9opvQ
	(envelope-from <linux-wireless+bounces-36552-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sun, 17 May 2026 10:32:53 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DC74F55FFA5
	for <lists+linux-wireless@lfdr.de>; Sun, 17 May 2026 10:32:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 785ED3009149
	for <lists+linux-wireless@lfdr.de>; Sun, 17 May 2026 08:32:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E47DE345CCE;
	Sun, 17 May 2026 08:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vinatta.cz header.i=@vinatta.cz header.b="PMO/+ude"
X-Original-To: linux-wireless@vger.kernel.org
Received: from vinatta.cz (vinatta.cz [37.205.8.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AED7B36AF6;
	Sun, 17 May 2026 08:32:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.205.8.231
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779006769; cv=none; b=Xl/6miQSGPYNW7Ox07HFGBnLJpwMUnx5rXc8xrTIsPsrsBc4hyK1/62DZ0mH9VXUfk1Q5yzZS0h/5faw+ZevPFkG+ueJtV+dlrH7JpkQLs8pGMs80HK2R9k0/4xPpd1CtTYm92h6YWxyVeEOkKtuuWedipPl67O6hhfL4XT/8KU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779006769; c=relaxed/simple;
	bh=OxaLP5J/GZlEF9ERJgv3Nk5LgC1koMIzY2yYzqkHqo0=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:To:From:
	 References:In-Reply-To; b=tgV0fNw/TrQSa7Pn6fprKnoNMIZ4GCn69huMOT8To+hcxEU9nhAJUxt49rjp4e7xuyq8XBnp/gxfzgsMY79/b4lNhjAyrn127+Q+gCLMvFNtywjRCtu7ekFL4VU10DRJLstaftSQ8KlY6KkEGunQqsTRUQdOy+1Z+126nQv5HpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=matfyz.cz; spf=pass smtp.mailfrom=vinatta.cz; dkim=pass (2048-bit key) header.d=vinatta.cz header.i=@vinatta.cz header.b=PMO/+ude; arc=none smtp.client-ip=37.205.8.231
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=matfyz.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vinatta.cz
DKIM-Signature: a=rsa-sha256; bh=OxaLP5J/GZlEF9ERJgv3Nk5LgC1koMIzY2yYzqkHqo0=;
 c=relaxed/relaxed; d=vinatta.cz;
 h=Subject:Subject:Sender:To:To:Cc:Cc:From:From:Date:Date:MIME-Version:MIME-Version:Content-Type:Content-Type:Content-Transfer-Encoding:Content-Transfer-Encoding:Reply-To:In-Reply-To:In-Reply-To:Message-Id:Message-Id:References:References:Autocrypt:Openpgp;
 i=@vinatta.cz; s=default; t=1779005699; v=1; x=1779437699;
 b=PMO/+udeo7XzeJ8ziq0fMVnhQ+lOkfiqksINzGQTUTMbfUvnCquMjhKwC3iwPY69pXYaTPBr
 0sYDtwXBrRrnzTxUb9iMiyQ1fWScUadCw1gNsRPnH3MAf89gDDidD+fIjXGtKdtEbyaylXRkjb4
 KAqHsz2O73Xe2rKMmCUWIhfn6x0SyvfnJuJubOJMAZyWwgoOn7RAC9RN8hQjUIlP9S8R6bWfN0p
 gslmcWbFPc1rV0XGiUzGb/CTfDGc+N/Z2rK0l6C+Yi008AthGl+Yt8jxLtjvtzfoUe37i/vEH38
 XEL331//YH1DNuli4G5ud92X6UHMl0ipgir8EUdNwZs0w==
Received: by vinatta.cz (envelope-sender <karel@vinatta.cz>) with ESMTPS id
 6a5c1ecf; Sun, 17 May 2026 10:14:59 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sun, 17 May 2026 10:14:58 +0200
Message-Id: <DIKSVZCAQES1.35I4QY11LBVNV@matfyz.cz>
Cc: "Brian Norris" <briannorris@chromium.org>, "Francesco Dolcini"
 <francesco@dolcini.it>, "Rob Herring" <robh@kernel.org>, "Krzysztof
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
To: "Johannes Berg" <johannes@sipsolutions.net>
From: "Karel Balej" <balejk@matfyz.cz>
References: <20251026182602.26464-1-balejk@matfyz.cz>
 <DEJL1ATTQMVE.120JV9YW59I27@matfyz.cz>
 <aSnWYS2g5slVFaSk@gaggiata.pivistrello.it>
 <DI5L100Q1RKO.1A68EJIPWYSRC@matfyz.cz>
In-Reply-To: <DI5L100Q1RKO.1A68EJIPWYSRC@matfyz.cz>
X-Rspamd-Queue-Id: DC74F55FFA5
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	R_DKIM_ALLOW(-0.20)[vinatta.cz:s=default];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[matfyz.cz : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-36552-lists,linux-wireless=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[22];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[chromium.org,dolcini.it,kernel.org,dujemihanovic.xyz,lunn.ch,bootlin.com,gmail.com,linaro.org,nxp.com,vger.kernel.org,lists.infradead.org,lists.sr.ht,ixit.cz];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[balejk@matfyz.cz,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[vinatta.cz:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless,dt];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vinatta.cz:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

Johannes,

Karel Balej, 2026-04-29T12:55:23+02:00:
> Brian, what are the options here now? Would it be possible to make an
> exception and accept the patches without the firmware being in
> linux-firmware? This is an old device with no mainstream audience so I
> expect everyone who will want to use it will be able to supply the
> firmware themselves and it would be great to not have to keep the
> patches in a fork, especially when trying to build on top of them
> further (such as to fix the driver-firmware incompatibilities discussed
> in one of the patches of this series).

would you please let us know whether there is any chance an exception
could be made for this chip regarding the firmware or whether there is
any other way to upstream the support?

Thank you and best regards,
Karel

