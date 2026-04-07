Return-Path: <linux-wireless+bounces-34443-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wFiAERGk1GmkwAcAu9opvQ
	(envelope-from <linux-wireless+bounces-34443-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 07 Apr 2026 08:28:33 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DAD873AA460
	for <lists+linux-wireless@lfdr.de>; Tue, 07 Apr 2026 08:28:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 221BF3007B8D
	for <lists+linux-wireless@lfdr.de>; Tue,  7 Apr 2026 06:28:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFC7A386C26;
	Tue,  7 Apr 2026 06:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="WPpqtNq0"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E75CA38657A;
	Tue,  7 Apr 2026 06:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775543309; cv=none; b=JpA7yAE57HqiiwQPnAybRexSpw93Nn/POMvfxjoJcDH0ZdRcDmZBN3PKdF4gBHrpr/O8r96Rcp1f079QC95rftishEB2NkcwcS9XGoc18WWMf1F1BUI+AT9a9cBFsoByIuZgVw/krAMSqHhDfzTQJrCRJMpDH8Uajnu4u6ZrEHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775543309; c=relaxed/simple;
	bh=upBaE4cGbmF50cumJBR5qxyds0bnpS/2O8LmwmYLWVA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ErRXLelU3HgzaPyQTL3O7ECr9OJ8LWbWN9q9SZCw6SeJp5vTlj2/YZdJNl7GPImc4gKL82CjHWBY9u2sFSA3Fm1qKEfWxS4QpcI/mwBPKYLT0ioOwiEyrYXRjNLcb6BrwcFGyZ/aRFmx8cJA8Bp4BhrewSy3M9nx+FNpdaqMYCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=WPpqtNq0; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=zM25rvTHQ4j/fFzxXC/W2rgL+pkGK3S3whdzkHXc+eE=;
	t=1775543307; x=1776752907; b=WPpqtNq0ur1YvyGWhmbmdAP3Cr1FxyNhb2hQFVPIja/mR0F
	NDNmYbbO/DN+iUEsxnucFPN/qJK5eNYAmhpjSiUIKOi1AT7ntV75laFQUoAoFCL4QHBQwNcaUqB71
	/i2BKQnH6FpLbMHf2QdM4RDTKalBPELarU0BtR5VcbJwEkNURRUU2X8rDXCKMds9+svwwFQez6x0/
	Hfo3Jnf5rm5BexJOpFn/X7TP2HOSWttLnDszw4S2Fpgg24j4Rg1cCx/4OZKPwHeQlToQKUX7M4DiH
	dzCgQx8lZOKLYvs8qVDxiUOQzMrXVh1mCJ4mWubes2UzaFkvveu80LvdSGocp9Fw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1w9zvB-0000000C3Qk-3aKc;
	Tue, 07 Apr 2026 08:28:22 +0200
Message-ID: <b4a8265d1814eb63be9a64ab4581439829f22fb0.camel@sipsolutions.net>
Subject: Re: [PATCH wireless-next 0/6] Consolidate Michael MIC code into
 mac80211
From: Johannes Berg <johannes@sipsolutions.net>
To: Christoph Hellwig <hch@infradead.org>, Eric Biggers <ebiggers@kernel.org>
Cc: linux-wireless@vger.kernel.org, linux-crypto@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Herbert Xu <herbert@gondor.apana.org.au>
Date: Tue, 07 Apr 2026 08:28:20 +0200
In-Reply-To: <adSjHlfi15v_U62B@infradead.org>
References: <20260405052734.130368-1-ebiggers@kernel.org>
	 <7f69d6e6c2057858eda5c65ec77be44d72c6ac78.camel@sipsolutions.net>
	 <20260407061508.GA7934@sol> <adSjHlfi15v_U62B@infradead.org>
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
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[sipsolutions.net,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[sipsolutions.net:s=mail];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-34443-lists,linux-wireless=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[sipsolutions.net:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[johannes@sipsolutions.net,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sipsolutions.net:dkim,sipsolutions.net:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: DAD873AA460
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, 2026-04-06 at 23:24 -0700, Christoph Hellwig wrote:
> On Mon, Apr 06, 2026 at 11:15:08PM -0700, Eric Biggers wrote:
> > Just to clarify, mac80211 already contains the michael_mic() function.
> > And every driver that needs Michael MIC already depends on mac80211
> > except for ipw2x00.  So bloat-wise I assumed it's probably better to
> > make that one driver depend on mac80211, rather than make every driver
> > pull in the Michael MIC code (by moving it from mac80211 to cfg80211).
> > But if you prefer that the code be in cfg80211 we can do it that way.
>=20
> To me the most sensible thing would be to have a separate module for
> the code.  If you don't want to expose it too widely for understandable
> reasons, keep the module in net/wireless/.
>=20
Maybe, but that'd probably be more overhead than anything else? The
text+data is 725 bytes (on x86-64).

johannes

