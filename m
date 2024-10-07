Return-Path: <linux-wireless+bounces-13619-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E445993509
	for <lists+linux-wireless@lfdr.de>; Mon,  7 Oct 2024 19:30:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 221CE284885
	for <lists+linux-wireless@lfdr.de>; Mon,  7 Oct 2024 17:30:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1ACF1DD878;
	Mon,  7 Oct 2024 17:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="GYPAHP7k"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F37E17740;
	Mon,  7 Oct 2024 17:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728322211; cv=none; b=geZB3FScdYr2dmlbl/l76kDAHol81a1TXuPwD2GJDVaibwNOyhQuBnFMX65PCnAsctuM5WxdvEYomfm+MZk0V2QdZWZIpUTKFU7RQbgYnZ5vPBr+Sva5rYTrt2VTT4jSoPFhLDyLmQ2I2mAyjwWvjW5LRTW5ksRQyfZjqBPXDzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728322211; c=relaxed/simple;
	bh=KExhS6quS1V4EUyu0mZRHKERFsQ/vsL1TLj4EjRdFGI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=St8CIDXhftnlBODZHXiErNArYB61XiacAZfOdAHTi66UtDglQE+H8QcxuDAYZ6zllNVRVzaRh9YF8MQcAHLlt+vbIVuYNb/UfagRIzANFA9pE8m9h6AX5wTluCBMeqj04OR47S/LHyRLh++fP5/6nSBn5X78ELkbpy93jK00IN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=GYPAHP7k; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=DZ5PBbvmh600KyglS3wsWLHfo8lfLmkNDgy5pOUZEGs=;
	t=1728322210; x=1729531810; b=GYPAHP7kuM5HFqo4lAxSvdmHBy8h/qd9eQG3b63T9lw68JW
	K17Pn34NxbySmKSKOQw0xzVKkcfMXGLrTAAgJeMz5Rz4FHTwwknGWg1+R0MsHSnwgye34YKP9do6G
	6OpVWK4043MqZtJOwQQ0tEwved213LvJzVX+CDkdLG7XEgPIL6/TKdclW9MKnHWLlml/CzBOTUuUJ
	ZicUlEDj019Ob0r+w0sLW1VUwDu85pCAQSEtXyjRP7sDl6y7+TfTAwydE6WhFU9maKCX6Ek9ajdz3
	Yry2+gjoAG9XW4zj3wcilj7b7LoPA5bE4GM4oMCqOeKBoYj2CviL2gvq0yS0aoZw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98)
	(envelope-from <johannes@sipsolutions.net>)
	id 1sxrYZ-00000003Soc-2SRY;
	Mon, 07 Oct 2024 19:30:03 +0200
Message-ID: <bad9e220ad3d2625d23b3d7230d6876aa726dd78.camel@sipsolutions.net>
Subject: Re: [PATCH RFC net 1/2] MAINTAINERS: consistently exclude wireless
 files from NETWORKING [GENERAL]
From: Johannes Berg <johannes@sipsolutions.net>
To: Simon Horman <horms@kernel.org>, Kalle Valo <kvalo@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>,  Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 linux-kernel@vger.kernel.org,  linux-wireless@vger.kernel.org,
 netdev@vger.kernel.org
Date: Mon, 07 Oct 2024 19:30:02 +0200
In-Reply-To: <20241007141305.GD32733@kernel.org>
References: <20241004-maint-net-hdrs-v1-0-41fd555aacc5@kernel.org>
	 <20241004-maint-net-hdrs-v1-1-41fd555aacc5@kernel.org>
	 <87setb7us5.fsf@kernel.org> <20241007141305.GD32733@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Mon, 2024-10-07 at 15:13 +0100, Simon Horman wrote:
> On Fri, Oct 04, 2024 at 06:27:38PM +0300, Kalle Valo wrote:
> > Simon Horman <horms@kernel.org> writes:
> >=20
> > > We already exclude wireless drivers from the netdev@ traffic, to
> > > delegate it to linux-wireless@, and avoid overwhelming netdev@.
> > >=20
> > > Many of the following wireless-related sections MAINTAINERS
> > > are already not included in the NETWORKING [GENERAL] section.
> > > For consistency, exclude those that are.
> > >=20
> > > * 802.11 (including CFG80211/NL80211)
> > > * MAC80211
> > > * RFKILL
> > >=20
> > > Signed-off-by: Simon Horman <horms@kernel.org>
> > > ---
> > >  MAINTAINERS | 11 +++++++++++
> > >  1 file changed, 11 insertions(+)
> > >=20
> > > diff --git a/MAINTAINERS b/MAINTAINERS
> > > index c27f3190737f..ea3ea2c0d3fa 100644
> > > --- a/MAINTAINERS
> > > +++ b/MAINTAINERS
> > > @@ -16197,8 +16197,19 @@ F:	lib/random32.c
> > >  F:	net/
> > >  F:	tools/net/
> > >  F:	tools/testing/selftests/net/
> > > +X:	Documentation/networking/mac80211-injection.rst
> > > +X:	Documentation/networking/mac80211_hwsim/
> > > +X:	Documentation/networking/regulatory.rst
> > > +X:	include/net/cfg80211.h
> > > +X:	include/net/ieee80211_radiotap.h
> > > +X:	include/net/iw_handler.h
> > > +X:	include/net/mac80211.h
> > > +X:	include/net/wext.h
> >=20
> > Should we add also lib80211.h?
>=20
> Thanks, I missed that one. Perhaps it should have:
>=20
> * An F: entry in the MAC80211

I suppose it should rather be in the 802.11 entry rather than the
MAC80211 one. I don't like the code anyway, but it's there for now :)

johannes

