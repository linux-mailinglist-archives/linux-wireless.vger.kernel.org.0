Return-Path: <linux-wireless+bounces-34514-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wIY7N9X21Wn4/gcAu9opvQ
	(envelope-from <linux-wireless+bounces-34514-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 08 Apr 2026 08:33:57 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 749203B7997
	for <lists+linux-wireless@lfdr.de>; Wed, 08 Apr 2026 08:33:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E8522301DCF3
	for <lists+linux-wireless@lfdr.de>; Wed,  8 Apr 2026 06:32:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D36FA36492F;
	Wed,  8 Apr 2026 06:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="jFyNkaEH"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FCA26FC5;
	Wed,  8 Apr 2026 06:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775629943; cv=none; b=B5B9KhxyK+GmKd3+/igj9td9KBujPyWFVi//JEih+H8F3dXViKIVI99dEe/30Jwv+wp9hmRLn+DpHK64n86Jhx5EYrj+7l3C7gJrGXDxtaEQWquUx4+VFdLwTXXbZkLHB0KRNfwkfaYxa/M5xyrcDOqLV7CpcbHW0pV0RDXDiE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775629943; c=relaxed/simple;
	bh=y0U1YymDvuLRSRtEIBGryoOLWjw2XisH2jCc1liRc64=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=IY9CLw3O4irQXmTOWSulsKQiiq2h/MMq/QS3wAU75j1fEhUs5uQYEcslUZ3rF7o1md/s5ITEsSn1epPmfV83iEfrRN1zy899w9V1vLBZHHy4+FuKUYV34rQr71HDZtopIhbtEhgaVGH1BrQpyBDIGDG4hohIZWfnRM5VtyvBpcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=jFyNkaEH; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=Vr5qHol94EshMxk6RxBk8lw10HECb8JwIBrhRs7aliM=;
	t=1775629942; x=1776839542; b=jFyNkaEHZT3H5tjM9B6z3pQF778eKKHVRYI8TkvwOLxMubr
	ntSOd/2yba5Hzl8EmDdsDiLaAVmowQ4KbreAiZi6FfNgUwhP+hKvejzCxALd+NjXW4SnfLyKdolB4
	fOtC9HGiEPb8u7eziDyS6LIRYqvK+//RGOuw7rPrKQfMddFqH/UxhNc0QDy/VQ2z5o+BfjwFxQ074
	WPMbRzoa3cHMxF8a79M5iJDhiXhBBPJAD1Hg0nPMXwAqiH+1RKraztQsWalrDd51JGXv0ytcLqOZB
	Adl/TPjXPEE4vKYHr/WmBBVE/qPIwN33GUlXm0uPZGIqLUtK2DlspeqWZcYsoVMg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1wAMSS-0000000E1ZI-43c2;
	Wed, 08 Apr 2026 08:32:13 +0200
Message-ID: <56798292be29f3e76e88c837d41eff0cb9f8b36a.camel@sipsolutions.net>
Subject: Re: [PATCH wireless-next v2 0/6] Consolidate Michael MIC code into
 cfg80211
From: Johannes Berg <johannes@sipsolutions.net>
To: Eric Biggers <ebiggers@kernel.org>, linux-wireless@vger.kernel.org
Cc: linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org, Herbert Xu
	 <herbert@gondor.apana.org.au>
Date: Wed, 08 Apr 2026 08:32:12 +0200
In-Reply-To: <20260408030651.80336-1-ebiggers@kernel.org>
References: <20260408030651.80336-1-ebiggers@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[sipsolutions.net:s=mail];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-34514-lists,linux-wireless=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[sipsolutions.net:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[johannes@sipsolutions.net,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,sipsolutions.net:dkim,sipsolutions.net:mid]
X-Rspamd-Queue-Id: 749203B7997
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, 2026-04-07 at 20:06 -0700, Eric Biggers wrote:
>=20
> Changed in v2:
>=20
>     - Added preparatory patch to fix a bisection hazard.
>=20
>     - Moved michael_mic() to cfg80211 so that ipw2x00 doesn't have to
>       start depending on mac80211.

Thanks.

>     - Adjusted the 'fips_enabled' error messages, and updated the commit
>       messages to clarify that ath11k and ath12k don't actually work at
>       all in FIPS mode but that these patches don't aim to fix that.

:)

> Eric Biggers (6):
>   wifi: ipw2x00: Rename michael_mic() to libipw_michael_mic()
>   wifi: mac80211, cfg80211: Export michael_mic() and move it to cfg80211
>   wifi: ath11k: Use michael_mic() from cfg80211
>   wifi: ath12k: Use michael_mic() from cfg80211
>   wifi: ipw2x00: Use michael_mic() from cfg80211
>   crypto: Remove michael_mic from crypto_shash API

So five out of six patches are wireless, should I apply the crypto one
too?

johannes

