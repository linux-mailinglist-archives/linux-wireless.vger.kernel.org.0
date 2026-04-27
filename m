Return-Path: <linux-wireless+bounces-35345-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QOEbBOMw72mb8wAAu9opvQ
	(envelope-from <linux-wireless+bounces-35345-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 27 Apr 2026 11:48:19 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8775647020C
	for <lists+linux-wireless@lfdr.de>; Mon, 27 Apr 2026 11:48:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F25C1303E2D4
	for <lists+linux-wireless@lfdr.de>; Mon, 27 Apr 2026 09:43:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58C9D3B388A;
	Mon, 27 Apr 2026 09:43:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="hGdyTeF0"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C4A13B2FF1
	for <linux-wireless@vger.kernel.org>; Mon, 27 Apr 2026 09:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777283039; cv=none; b=Z+/XfyijM/QkDksD6DoFYYnoNYx/kum5uvlhN7FcTFEBndzvxCDZa/7gpoo0omeh/br2Kqak0v2i30XEIzmgLdkQp2HWH1kMt9oR8wZjTzLlI46Ujf6IS9EAnc5yjeVOCgB7hc1PepcAqTwsHYwaKfLad3oPCW9brh9zUiPCOAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777283039; c=relaxed/simple;
	bh=33+9t1jhMiYZPc3ly2RiQ/ZjiZ8xzUC/3A474qGSitY=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=MiruM3nCLmhsO2f4M8yJuYPAyQ7nvMV5/V9GuBWtEXuolo8ll6EDC7vURehcQmeVDPf++yqNmRyY0AWes4215VtlO1/U/8clcivGsdHvhM+bS5YrEXzgjA4L4nbJGbBKIkSG0iX4f/EzOPAJAsKCszDuGVoZFabBW1rPGiqn1tg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=permerror header.from=sipsolutions.net; spf=none smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=hGdyTeF0; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=permerror header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:To:From:Subject:Message-ID:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=33+9t1jhMiYZPc3ly2RiQ/ZjiZ8xzUC/3A474qGSitY=;
	t=1777283037; x=1778492637; b=hGdyTeF0xTRexFaAqvB5wOfq/1ZUhc+jF8KXaodgMt23fcq
	Q15e7q72X0iNzSTaTxmXfiuBOWiDxduodVz69pabx/Bf4c2Qvkvf8TDKCY3GmX4upg26WsMlj12MP
	gkCSgAJAhi/myv5j/MdF4YtuUPfnwnPCQI3XPaQLmUpzxiLRBVjGFXRK99aU9O1VSM2vRk0G8mzpI
	Y2LuTtBxUvPFEw1/mGuMJaHZUG52QVZgZnBQT7ccqo1ckhfT4TwId8UFQxzDkwWDbSdEV8YffOEfi
	Zw1Ya/Jc6ZwuFSW04Yg4s8774q8AUUKMWjKTncBbpKEnXoGZuLAdlVNquc4P2xaw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1wHIVO-0000000Ep1z-4A9R;
	Mon, 27 Apr 2026 11:43:55 +0200
Message-ID: <1672e78507b643f4610265f018ccddcb141ee726.camel@sipsolutions.net>
Subject: Re: [PATCH] iw: Makefile: support out-of-tree builds
From: Johannes Berg <johannes@sipsolutions.net>
To: Maxin John <maxin.john@gmail.com>, linux-wireless@vger.kernel.org
Date: Mon, 27 Apr 2026 11:43:54 +0200
In-Reply-To: <20260423113154.1070521-1-maxin.john@gmail.com> (sfid-20260423_133158_126940_B575589B)
References: <20260423113154.1070521-1-maxin.john@gmail.com>
	 (sfid-20260423_133158_126940_B575589B)
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
X-Rspamd-Queue-Id: 8775647020C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[sipsolutions.net:s=mail];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org];
	DMARC_NA(0.00)[sipsolutions.net: no valid DMARC record];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-35345-lists,linux-wireless=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[johannes@sipsolutions.net,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[sipsolutions.net:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sipsolutions.net:dkim,sipsolutions.net:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

On Thu, 2026-04-23 at 14:31 +0300, Maxin John wrote:
> Enable out-of-tree builds without modifying the source tree.
> Out-of-tree builds are required by build frameworks such as OpenEmbedded.

You should probably say how this is intended to be used, clearly not in
the O=3D way that the kernel has, for example.
=20
> +SRCDIR :=3D $(dir $(lastword $(MAKEFILE_LIST)))

That doesn't work if there's whitespace anywhere along the path.

> +CPPFLAGS +=3D -I$(SRCDIR)
> +CPPFLAGS +=3D -I.

The "-I." seems questionable since you evidently intend to have "."
*not* be the source dir?


Overall it might be simpler to actually do it with the kernel-style O=3D
so you just need to change all the outputs, rather than all the inputs?

johannes

