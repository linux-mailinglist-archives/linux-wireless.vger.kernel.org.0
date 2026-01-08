Return-Path: <linux-wireless+bounces-30539-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E731D04015
	for <lists+linux-wireless@lfdr.de>; Thu, 08 Jan 2026 16:48:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id AF5BD30BCA17
	for <lists+linux-wireless@lfdr.de>; Thu,  8 Jan 2026 15:35:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2E37421A0B;
	Thu,  8 Jan 2026 10:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="HI1Xe/Wm"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BB9B3D5D91;
	Thu,  8 Jan 2026 10:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767868416; cv=none; b=d9+oXsAfHiKsB5Dom5g/Qg+HTt/uXeH8gZMG4BFV0jbVEnNG+VIjQIaFp8TFOUUxpqx87AjTisgihI3r4pAJEMd5GQsduiRRWjahPUcdUvAbqFkoZklwO4j9VcmM4wTza8/cFqTdXHhAyb746xIkPiVWLHlRJW+56TqDdTAQE4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767868416; c=relaxed/simple;
	bh=wcJxSvhQuR8Ohtvh9c8ZrmAnoBDfeKQhMCSJH0GDces=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=dxmfEy4Ej8HsS93WthGDtqbf+ZELfVl45J8asQ6gfVfABzDOt5koAmUt8RSx8P+Bd2M9BRjiH0r53ciL+i7pcR8GMUsFMkrEGOMtwEiRopByzJ1oDp3qfxY9mMg7ElpZ3g+zUfwSpgZh0WMtm4vFlkvM6b64lqiPBQ2Vp1NEwIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=HI1Xe/Wm; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=P/iMwaQ/GUCProAJTtvt0w5p4KCQ9LrMsr1jgcnLhRQ=;
	t=1767868413; x=1769078013; b=HI1Xe/WmohPmRibmjFsTHuoUMiB6sHpATNjTlrRjAz9xItU
	DvBaI8KyL/Rs5Lvql+Eu7DEJyaKO37AWsvaU9rTVKdFfdf6v41y3E5ezJE9stvJlHTScDQvwJlH7o
	sHhsvxQcA8qrrj+8f/lwWeCYpqW+HpK/imzD3dWzwYLTrkcHtIorVMzk03A1KJHJkBqu49OD7KDNi
	JSESbsSxftzUkyhosoutM77jwJzMNZ65n1uWwgsp9s56ZqAVcqlAVhDOR1n0cQeDzBFblFRKr+p6t
	gQ1Klxnx0V7HurHl+XEWLDNmM/DAov3QIYURCxh1pvEuWTYyviOp+33VJrd2NTUA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1vdnKX-00000006Rk6-1AJv;
	Thu, 08 Jan 2026 11:33:25 +0100
Message-ID: <a48aad932c2c70148b273e1d32909a99977b3316.camel@sipsolutions.net>
Subject: Re: [PATCH net] wifi: avoid kernel-infoleak from struct iw_point
From: Johannes Berg <johannes@sipsolutions.net>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski
 <kuba@kernel.org>,  Paolo Abeni <pabeni@redhat.com>,
 linux-wireless@vger.kernel.org, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com,
 syzbot+bfc7323743ca6dbcc3d3@syzkaller.appspotmail.com, 
	stable@vger.kernel.org
Date: Thu, 08 Jan 2026 11:33:24 +0100
In-Reply-To: <CANn89iLxDc9viP0Pmj3uC01s46eUR2xu4XAUEo=he-M84aCf9A@mail.gmail.com> (sfid-20260108_113219_216071_25574978)
References: <20260108101927.857582-1-edumazet@google.com>
	 <851802c967b92b5ea2ce93e8577107acd43d2034.camel@sipsolutions.net>
	 <CANn89iLxDc9viP0Pmj3uC01s46eUR2xu4XAUEo=he-M84aCf9A@mail.gmail.com>
	 (sfid-20260108_113219_216071_25574978)
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Thu, 2026-01-08 at 11:32 +0100, Eric Dumazet wrote:
> On Thu, Jan 8, 2026 at 11:29=E2=80=AFAM Johannes Berg <johannes@sipsoluti=
ons.net> wrote:
> >=20
> > On Thu, 2026-01-08 at 10:19 +0000, Eric Dumazet wrote:
> > > struct iw_point has a 32bit hole on 64bit arches.
> > >=20
> > > struct iw_point {
> > >   void __user   *pointer;       /* Pointer to the data  (in user spac=
e) */
> > >   __u16         length;         /* number of fields or size in bytes =
*/
> > >   __u16         flags;          /* Optional params */
> > > };
> > >=20
> > > Make sure to zero the structure to avoid dislosing 32bits of kernel d=
ata
> > > to user space.
> >=20
> > Heh, wow. Talk about old code.
> >=20
> > > Reported-by: syzbot+bfc7323743ca6dbcc3d3@syzkaller.appspotmail.com
> > > https://lore.kernel.org/netdev/695f83f3.050a0220.1c677c.0392.GAE@goog=
le.com/T/#u
> >=20
> > Was that intentionally without Link: or some other tag?
>=20
> Somehow the Closes: prefix has been lost when I cooked the patch.
>=20
> Closes: https://lore.kernel.org/netdev/695f83f3.050a0220.1c677c.0392.GAE@=
google.com/T/#u
>=20
> Let me know if you want a V2, thanks.

I'll add it, no worries.

johannes

