Return-Path: <linux-wireless+bounces-32616-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +OGhKY+aqmmbUQEAu9opvQ
	(envelope-from <linux-wireless+bounces-32616-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 06 Mar 2026 10:12:47 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E96C21DADC
	for <lists+linux-wireless@lfdr.de>; Fri, 06 Mar 2026 10:12:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 50152305F328
	for <lists+linux-wireless@lfdr.de>; Fri,  6 Mar 2026 09:11:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3081A33E373;
	Fri,  6 Mar 2026 09:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="foXfQfVx"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0384E33CEA8;
	Fri,  6 Mar 2026 09:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772788267; cv=none; b=PMyWHzLIFVWYzm8tjEzlMrL/mlNcMKqCGnwNOYX9vlYUiqPRn6GsY/su3aepoI2vtqI1GUgW4z7Nn4fb8w2Y1MfwqlQrziu+98Z8t4tkF+Zzut8ttPwtTDzrplYQ/An1/udwg1nRFedOueUNvkGtXVT8rm6L+GMAZ5aRsWSSxdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772788267; c=relaxed/simple;
	bh=g1kAOCpVb0nqnfFwob7cAoZvHH7efWPeeqXtxQ4qqks=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=LjsD45HzkTsIdm40/cNWOPbFMCrXdcqOfZdO0mTatIl0uvp2H8+mWqreNWYjaAi4QHJJVsfQbUEeMo2Ej9SNqMClrADLO/8f+itoEi8Hhhbv9ymfh+Mz11zFi8IdhxlkcOHb67AgVmFLtsgE2+SQ+6yPMm5RmNhidmc8zGQ/zck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=foXfQfVx; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=g1kAOCpVb0nqnfFwob7cAoZvHH7efWPeeqXtxQ4qqks=;
	t=1772788266; x=1773997866; b=foXfQfVxulszZwMe8uB1aiQOGUExtDXaQWvH5sdAwX7ldP8
	bLDXdToYdqVZ6mYij2NGW9yBzYs4uaJ/CaZsEIo0x2fkRBfZ5uYNiRrnfS67SKMzjVexnpk2bktxm
	uemCNH6WVoHLnBtqM+gv2H65vBvUOQ4HpziGo6+HL/DbDm6yb93GywVb2r7LgDezK8vJwAfw9nuiT
	3rHQjcVWikm7yTNj0UeEaR4s0rkMtKnAgHgou4tqUVPwgX7m/E4hNMmck3Gk5VtDY1bKBSEwhrYeC
	3Si8rdrvPHFzobizg6IXungBOSTU+Y6n5wKoKzKaqQ6FI5QRVMxK28VIiXnMxe7A==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1vyRD5-0000000A0KJ-3DYc;
	Fri, 06 Mar 2026 10:11:03 +0100
Message-ID: <746513b5657fd20a99bf9ea5324a73f05339d54b.camel@sipsolutions.net>
Subject: Re: [PATCH wireless-next 26/35] wifi: mm81x: add usb.c
From: Johannes Berg <johannes@sipsolutions.net>
To: Lachlan Hodges <lachlan.hodges@morsemicro.com>, Dan Callaghan
	 <dan.callaghan@morsemicro.com>, Arien Judge <arien.judge@morsemicro.com>
Cc: ayman.grais@morsemicro.com, linux-wireless@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Date: Fri, 06 Mar 2026 10:11:03 +0100
In-Reply-To: <20260227041108.66508-27-lachlan.hodges@morsemicro.com> (sfid-20260227_051435_755383_46821891)
References: <20260227041108.66508-1-lachlan.hodges@morsemicro.com>
	 <20260227041108.66508-27-lachlan.hodges@morsemicro.com>
	 (sfid-20260227_051435_755383_46821891)
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
X-Rspamd-Queue-Id: 1E96C21DADC
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[sipsolutions.net,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[sipsolutions.net:s=mail];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-32616-lists,linux-wireless=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[sipsolutions.net:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[johannes@sipsolutions.net,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,sipsolutions.net:dkim,sipsolutions.net:mid]
X-Rspamd-Action: no action

On Fri, 2026-02-27 at 15:10 +1100, Lachlan Hodges wrote:
>=20
> +/*
> + * See https://www.kernel.org/doc/html/v5.15/driver-api/usb/error-codes.=
html

Seems a bit odd to refer to an ancient version on the web rather than
just Documentation/driver-api/usb/error-codes.rst?

johannes

