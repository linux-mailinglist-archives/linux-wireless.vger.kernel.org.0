Return-Path: <linux-wireless+bounces-35508-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8PYoItvt8Gn9bAEAu9opvQ
	(envelope-from <linux-wireless+bounces-35508-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 28 Apr 2026 19:26:51 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ABB3489E9F
	for <lists+linux-wireless@lfdr.de>; Tue, 28 Apr 2026 19:26:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 45A253007F57
	for <lists+linux-wireless@lfdr.de>; Tue, 28 Apr 2026 17:18:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8262C33D6F8;
	Tue, 28 Apr 2026 17:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="HSGvve7k"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C5AC2D73A6
	for <linux-wireless@vger.kernel.org>; Tue, 28 Apr 2026 17:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777396718; cv=none; b=Pe7G8hjvZcR7yTAwTwh18skEM7zz2c1zl2zR0X9FHYhBvLILn9SrWyta6uNkWqyDXCWNd5ybn2DRMXS4R3vi1tg561CA3EvWwLcvzs05vq/HYt2BsELYAsLJSImfD5wwJQCZFV7dLAoEx4HaJR9IkezgCc1XubLP/OYn5OAQD7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777396718; c=relaxed/simple;
	bh=cCMHaeOZfeVIlgHCixdIf+pkdlAkra7/O8Ey0OifD+o=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=G0m3OO1HSuakSui0ijCAAwY/2I5dW5hJ0KNZ0xhs+TEWGVuOp3HHcB8HEn4DBWXeTx4FlT4l+OzTbVPjZAAU8IG7ACNDhtZ2JppwI4Ld89Gf+pQfrm0uDpb/+SpMxTZ223MYKzrqHY78pcVzxdYRtexKNEFgsIhtvX5OPLmTQ18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=permerror header.from=sipsolutions.net; spf=none smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=HSGvve7k; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=permerror header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=nIl+DSEzd37rA0Lvy34OOfo3qRh/kl30zRIJFIyaIdA=;
	t=1777396716; x=1778606316; b=HSGvve7kzfcyVDy3AJd+FxYgKiSxXLbWTLKwRNOwu5+uwpL
	deFQdChs4YHbr0gXlq9xgCuAML3r/nTabpqTUlR0H8y0F+CutpPAblT7OuE1q/vw0WVz51N64cdKJ
	yrymx4+Ueahth0YCncDRvurROHCTogpjOYGjgj96w6ziNkSN76Arwprh4mXKmUXQZ6QrAKwDU+T3F
	nyE+E4GRXdr5FWpafqTIlo3LFsUW+c6EwjKy5H09UkZn+GEuFV+l/zte5nNE2BLsi9himK32H/2KF
	+TI/mpd7qcg94JIKntnCdXFUzqr33N6va8En0CIL0284HvDq1d7jDwlTQox4dPNw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1wHm4v-00000000xnQ-0ehW;
	Tue, 28 Apr 2026 19:18:33 +0200
Message-ID: <d283177dcb103834969df55290fda3120c000f5c.camel@sipsolutions.net>
Subject: Re: [PATCH] iw: Makefile: support out-of-tree builds
From: Johannes Berg <johannes@sipsolutions.net>
To: Maxin John <maxin.john@gmail.com>
Cc: linux-wireless@vger.kernel.org
Date: Tue, 28 Apr 2026 19:18:32 +0200
In-Reply-To: <afDqaQc-Vxoz3OEL@Thor.home> (sfid-20260428_191213_746464_F0BF06E9)
References: <20260423113154.1070521-1-maxin.john@gmail.com>
	 <1672e78507b643f4610265f018ccddcb141ee726.camel@sipsolutions.net>
	 <afDqaQc-Vxoz3OEL@Thor.home> (sfid-20260428_191213_746464_F0BF06E9)
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
X-Rspamd-Queue-Id: 1ABB3489E9F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[sipsolutions.net:s=mail];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWO(0.00)[2];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[sipsolutions.net: no valid DMARC record];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	TAGGED_FROM(0.00)[bounces-35508-lists,linux-wireless=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[johannes@sipsolutions.net,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[sipsolutions.net:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

On Tue, 2026-04-28 at 20:12 +0300, Maxin John wrote:
>=20
> > > +CPPFLAGS +=3D -I.
> >=20
> > The "-I." seems questionable since you evidently intend to have "."
> > *not* be the source dir?
>=20
> The -I. was intended to ensure that generated files such as
> nl80211-commands.inc, which are produced in the build directory,
>  remain discoverable by the compiler. Agree that it doesn't look right
> and I will update it.=20

Oh, I guess that makes sense, maybe just add a comment? But that's after
guessing you somehow intend to call 'make -f ../src/Makefile' or
something, which seems a little odd to me?

johannes

