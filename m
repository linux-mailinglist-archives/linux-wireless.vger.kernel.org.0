Return-Path: <linux-wireless+bounces-37866-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id p8noLYKZMmpr2gUAu9opvQ
	(envelope-from <linux-wireless+bounces-37866-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 17 Jun 2026 14:56:34 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id D6167699E4C
	for <lists+linux-wireless@lfdr.de>; Wed, 17 Jun 2026 14:56:33 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=sipsolutions.net header.s=mail header.b="fvgB/gNz";
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-37866-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="linux-wireless+bounces-37866-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D9D4F3006813
	for <lists+linux-wireless@lfdr.de>; Wed, 17 Jun 2026 12:56:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A046B3EBF07;
	Wed, 17 Jun 2026 12:56:24 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C08FC3B7752;
	Wed, 17 Jun 2026 12:56:20 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781700984; cv=none; b=HL71EHKWcVw8KV9dVKQ/mx7QqPldlZqTikPGdFv7ioUJ5kwZsGCZ9hEi0c3BsnQDdHgBuetYchERspuUI+3YGLgNaGB3PLb/sibS7A3fuzv3p5615hB11cw+QRdGnOZ2FfxA2wt6SnecoO1UoYBwt0C9RfTb88TDgS1YlLNJjqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781700984; c=relaxed/simple;
	bh=4kX7Vgcf7HCZZi909HYoz8IJ7SLc9IU0Ws8WvYg36t4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=PFDUzBchTcyuT/HajIdmWyrrEXZqiwVqJgrr1AkrS79fk2i6iWUxOe1pNLMKPRC0qc6BrtKQCwz4Mf5FQY4UGxvW4r86n9EgDYWqXezi5DZZF+MX2YfJ6j0pvFAU5CsLUc2FcLO3RQ651TTtH1zDteSCXp4zCcAFxeNY7s3v42g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=permerror header.from=sipsolutions.net; spf=none smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=fvgB/gNz; arc=none smtp.client-ip=168.119.38.16
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=VA99D5bK8lnbrqdc2poWyS2qPB2HZZGsDz4JLTRMe/U=;
	t=1781700981; x=1782910581; b=fvgB/gNz/4FsaajvjT0ocSqITeDxtasaCQ1eyozZdCWVjJ8
	7etV+dYiLMk/XVLoP0iSORFx2OBp522QwCPDNF6SJesOar5LgMOINwAMYM3RxcAilefx+RqxFR1+k
	VB6nyADoRj1jl/wyYEeITmzS0HFLfBKqIs+kxS1su48F8uIrwgTKFzKsclMU0INoSSGNPs8N2Hezj
	7CR27hoYEI24dPJJlcfg+kbNMrYmxGLScWcz3L5v0YQVH1FcGhk7HlUuDBWncyYPq4tfQ7WYCRLtf
	I+N/+JQG/ezaPXoW3PDqMCNqHl/Ujx9tsC37e/QXW+IzK3aCcliAACPgH85tjDCg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1wZpoQ-00000001C8x-2nsJ;
	Wed, 17 Jun 2026 14:56:10 +0200
Message-ID: <1e656f5798a9f2f36daa00aba60d2196b2456335.camel@sipsolutions.net>
Subject: Re: [PATCH v1 1/2] overflow: Allow to sum a few arguments at once
From: Johannes Berg <johannes@sipsolutions.net>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-wireless@vger.kernel.org
Cc: Kees Cook <kees@kernel.org>, "Gustavo A. R. Silva"
 <gustavoars@kernel.org>
Date: Wed, 17 Jun 2026 14:56:09 +0200
In-Reply-To: <20260617112250.2791461-2-andriy.shevchenko@linux.intel.com>
References: <20260617112250.2791461-1-andriy.shevchenko@linux.intel.com>
	 <20260617112250.2791461-2-andriy.shevchenko@linux.intel.com>
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
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[sipsolutions.net:s=mail];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:andriy.shevchenko@linux.intel.com,m:linux-hardening@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-wireless@vger.kernel.org,m:kees@kernel.org,m:gustavoars@kernel.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	DMARC_NA(0.00)[sipsolutions.net: no valid DMARC record];
	FORGED_SENDER(0.00)[johannes@sipsolutions.net,linux-wireless@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-37866-lists,linux-wireless=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[johannes@sipsolutions.net,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[sipsolutions.net:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,sipsolutions.net:dkim,sipsolutions.net:mid,sipsolutions.net:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D6167699E4C

On Wed, 2026-06-17 at 13:12 +0200, Andy Shevchenko wrote:
> Convert size_add() to take variadic argument, so we can simplify users
> with using a macro only once.

> +#define __size_add3(addend1, addend2, addend3, addend4, ...)			\
> +	__size_add(__size_add2(addend1,  addend2, addend3), addend4)
> +#define __size_add4(addend1, addend2, addend3, addend4, addend5, ...)		\
> +	__size_add(__size_add3(addend1,  addend2, addend3, addend4), addend5)

I guess it's not going to really matter, but it would generate fewer
calls to have something more like

#define __size_add3(a1, a2, a3, a4) \
	size_add(size_add(a1, a2), size_add(a3, a4))
#define __size_add4(a1, a2, a3, a4, a5) \
	size_add(size_add(a1, a2), size_add(a3, a4, a5))

as a binary tree, rather than only cutting one off every time. Not sure
that results in hugely different code though - maybe fewer overflow
checks?

Although your version make it really completely equivalent to the
nl80211.c code, clearly it doesn't matter if all the values are "good",
and I believe the overflow behaviour means it doesn't matter for the
overflow case either?

johannes

