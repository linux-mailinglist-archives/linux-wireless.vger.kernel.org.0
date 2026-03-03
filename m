Return-Path: <linux-wireless+bounces-32380-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iHLrLb2JpmkZRAAAu9opvQ
	(envelope-from <linux-wireless+bounces-32380-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 03 Mar 2026 08:11:57 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id B3BA91EA032
	for <lists+linux-wireless@lfdr.de>; Tue, 03 Mar 2026 08:11:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 8D0B33010739
	for <lists+linux-wireless@lfdr.de>; Tue,  3 Mar 2026 07:11:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4995373BF4;
	Tue,  3 Mar 2026 07:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="lv5xDSMO"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC39D2E8DEB
	for <linux-wireless@vger.kernel.org>; Tue,  3 Mar 2026 07:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772521910; cv=none; b=SVpwmw35m1ftyrwFI7XNPR/5zq7CzLzZk34J0aOvcpWdCu/i5rstQXHTcmYLJDqs91r9z9+u+JGQ34hHQ/IIxNtX3MopOQkiuVlnMvjKIpJ0rD5EZ6JGf/0qKoS2toj01wGzTeldtqkt8axu8e+qrkeZP22FnSwnvj/zmVdii7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772521910; c=relaxed/simple;
	bh=WHvEtYeTQIf4zcp+zCFD2EoIoZIrcqDyB5mTVg2hF1Y=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=JKE8dBOso/ViEYzGA6do5+vYkE8m+OifxwQucojOQbvzpvuqR1r7dTyTNvtFHSmcW38tBRiPw0my+N1blOiAnCgmDVSHJmNREawRO6eNzWj9jtRYkkwXi5HRWbtpyUFpdV0/FzUfhViMz5u3F7cLAnBAb6HJ5y6Z2Jr0WCx7pvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=lv5xDSMO; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=WHvEtYeTQIf4zcp+zCFD2EoIoZIrcqDyB5mTVg2hF1Y=;
	t=1772521909; x=1773731509; b=lv5xDSMOpqfo2BRfaKKMzrqn1tZwMhHfGHLrOH+y9za1AbO
	2tW0LZzyagV0dAqKOPZepUw+MOyL9uh+bPZl+2JMAb+U7xEk8uJ3CCtYDtYY7UpSsosdgxl0LKMZF
	/VsdM+BYJPU7pkylZAxWF3nzgrV5QfBVQJ7N2eU7ywnqoVSeuUtngs0GtD9TFicljO2xdHEx6h8+s
	fxMgGktnMftKfHFBWbEfm9satCpxQ6XszxRXS5wYL5R29MVqbTRnm4+RuTP+XQG5bq+dCm1go4UVu
	/rqeIBS0lesv1sWLqPaRPwSZ1X1baisjcQP/PWIC603zsQhZmxJAfM2ZABo2EJeg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1vxJv1-00000006y9G-0y8H;
	Tue, 03 Mar 2026 08:11:47 +0100
Message-ID: <30a8c050a4a6d2e533d7e1e215397951d557310c.camel@sipsolutions.net>
Subject: Re: bot results missing in patchwork
From: Johannes Berg <johannes@sipsolutions.net>
To: Lachlan Hodges <lachlan.hodges@morsemicro.com>
Cc: linux-wireless@vger.kernel.org
Date: Tue, 03 Mar 2026 08:11:46 +0100
In-Reply-To: <gyknl3egpibklu52jcunn3jdzqkcd6zv765jgxnezzcxs2xqq2@rip2yhlyfjdy> (sfid-20260303_031304_576048_67D962B7)
References: 
	<2edc78e3581a11c18189b1ac5ee95b0600586f82.camel@sipsolutions.net>
	 <a3e5e4a8a8d147e4b77b02b479844f4a9c0cbd8d.camel@sipsolutions.net>
	 <gyknl3egpibklu52jcunn3jdzqkcd6zv765jgxnezzcxs2xqq2@rip2yhlyfjdy>
	 (sfid-20260303_031304_576048_67D962B7)
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
X-Rspamd-Queue-Id: B3BA91EA032
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[sipsolutions.net,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[sipsolutions.net:s=mail];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-32380-lists,linux-wireless=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[sipsolutions.net:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[johannes@sipsolutions.net,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,sipsolutions.net:dkim,sipsolutions.net:mid]
X-Rspamd-Action: no action

On Tue, 2026-03-03 at 13:12 +1100, Lachlan Hodges wrote:
> On Thu, Feb 05, 2026 at 05:32:43PM +0100, Johannes Berg wrote:
> > On Thu, 2026-02-05 at 11:28 +0100, Johannes Berg wrote:
> > > Hi,
> > >=20
> > > Just noticed now that evidently when I did some server shuffling
> > > yesterday I lost the job that uploads the results to patchwork...
> > >=20
> > > I can't fix it right now, so for now just wanted to say that it's
> > > missing and that I'm aware. I'll get it fixed soon.
> >=20
> > Should be good now. And because I mixed up the new config and made it
> > link to https://..., I actually gave it a key and certificate now so
> > that actually works.
>=20
> You are probably aware - but looks like the bot is broken again since
> around the ~24th.

I actually wasn't, thanks for the heads-up. Looks like it lost DNS for a
second, and then didn't recover. I've kicked it, so it should start
processing things.

johannes

