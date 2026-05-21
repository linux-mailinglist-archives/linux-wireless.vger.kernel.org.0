Return-Path: <linux-wireless+bounces-36747-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6Mi3Hpe4DmrBBgYAu9opvQ
	(envelope-from <linux-wireless+bounces-36747-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 21 May 2026 09:47:35 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id ED6665A0556
	for <lists+linux-wireless@lfdr.de>; Thu, 21 May 2026 09:47:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id ABF723010512
	for <lists+linux-wireless@lfdr.de>; Thu, 21 May 2026 07:42:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA6EB3815DD;
	Thu, 21 May 2026 07:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="Pq+j39XW"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39EB4369970
	for <linux-wireless@vger.kernel.org>; Thu, 21 May 2026 07:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779349338; cv=none; b=kAoxbw7ceFkqlxywlHVrNT3+aDVAfHjjopjovUtha4/k+dfbw1NequcNyRmKUKTg1ppUc4XBRLbbJMgMk2FwBms6RaB2k7s12HxqHrnM9yGQH7O9UdNsiUv8Vh6rMo4BWLbTu1tuXPHSj5JlPnApXzuHHYHMsjMfyYYulfSd9as=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779349338; c=relaxed/simple;
	bh=bbbekLEXB21vfPPsg+kVFH8yLE8eQtodALMDIboQk9E=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=DDllUXPiaZaaPehVuLHmC/F238qvqRXphIlab7JGjvU7vIjuKhZClec1FbHFVDM034Cx0dpWM5Of4iW2dQMgEUHwRDE7alUDP7GPn7HYDFTX+pP9Bh1D6qWDyfB/d+9gtTSwuws2RJK+U9nnUVEr5J7c9Do09BVdcTxC24SllvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=permerror header.from=sipsolutions.net; spf=none smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=Pq+j39XW; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=permerror header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:To:From:Subject:Message-ID:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=muTAy6l9Ne10LTT0s5OukQkIoUOvif+5b1Gnk9FHhGg=;
	t=1779349337; x=1780558937; b=Pq+j39XWyZiAOKi30yNOYjCO6sRFV02z66jKzNVgqR5h81D
	e3vvcuxvd9zxoBjnJP5cV3+5Ql2bPpzJQa2Rk47DQ94nHF3ExdKeFvWtq9O7q1UaxrrRGhTWZnKfs
	xlohtHz0Jnm6yDD09YyILRuKihovg60cImwh3O7A1MRgAhfMYtO4lJPMXpFZMBaRitrNmc627NOyA
	BJW8nwtOUvIQsVjXlOZoTT8MFjDzn1I3pwTJfFUNkUiRTX37FopCU6j11BXlJq/V39h6xJBAViVPh
	GirbdP4voPQSBtERPN1PzbdX1DDVbDztR4Z+uJCZVN4tUPULpcwnU1jWoxnAQfRw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1wPy2o-0000000BoZq-0NWB;
	Thu, 21 May 2026 09:42:14 +0200
Message-ID: <bf2081a986eccd28378b4019b2968c15e6659b7f.camel@sipsolutions.net>
Subject: Re: [PATCH v6 1/6] wifi: mac80211: Use struct instead of macro for
 PREQ frame
From: Johannes Berg <johannes@sipsolutions.net>
To: Ping-Ke Shih <pkshih@realtek.com>, Masashi Honma
 <masashi.honma@gmail.com>,  "linux-wireless@vger.kernel.org"	
 <linux-wireless@vger.kernel.org>
Date: Thu, 21 May 2026 09:42:09 +0200
In-Reply-To: <7e1aac3afd714d448e5bfba4a9a113b0@realtek.com>
References: <20260515233839.86829-1-masashi.honma@gmail.com>
		 <965eff7ec3b928f093f7891e4307ec4e4a080ac4.camel@sipsolutions.net>
		 <d2c051127e384a918ff014da02e37e1e@realtek.com>
		 (sfid-20260521_024301_935117_BC310192) <93ab81b4fb7130a4d4e1048581d886568086fe24.camel@sipsolutions.net>
	 <7e1aac3afd714d448e5bfba4a9a113b0@realtek.com>
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
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[sipsolutions.net:s=mail];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[realtek.com,gmail.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-36747-lists,linux-wireless=lfdr.de];
	TO_DN_SOME(0.00)[];
	DMARC_NA(0.00)[sipsolutions.net: no valid DMARC record];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[johannes@sipsolutions.net,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[sipsolutions.net:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,sipsolutions.net:email,sipsolutions.net:mid,sipsolutions.net:dkim]
X-Rspamd-Queue-Id: ED6665A0556
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, 2026-05-21 at 07:38 +0000, Ping-Ke Shih wrote:
> Johannes Berg <johannes@sipsolutions.net> wrote:
> > The point is that __packed forces the compiler to emit code that doesn'=
t
> > rely on alignment.
>=20
> I was not aware that __packed is a hint of unalignment to compiler.
> I learned. :)

Yes. Note it goes further:

> In my tests with arm-gcc compiler, I did a special case:=20
>=20
> struct foo {
> 	int a;
> 	char b;
> } __packed;
>=20
> int bar(struct foo *foo)
> {
> 	return foo->a;
> }
>=20
> It is obviously aligned (offset =3D 0), so I guessed arm-gcc can generate
> a single load instruction, but actually it doesn't (even with -O3).

No, it cannot, because in addition it has to assume the pointer 'foo'
itself has no alignment. We use this a lot too, since a struct like your
'struct foo' could be in a frame element where we don't know what came
before it while parsing the elements, so we don't know that 'foo' has
any alignment.

The reasons are related to what happens when you have a

	struct foo array[N];

I think, because then __packed means there's no padding at the end of
'struct foo' either, and array[1] is a completely unaligned pointer.

So no, the compiler couldn't assume alignment even for fields that look
aligned within 'struct foo'.

johannes

