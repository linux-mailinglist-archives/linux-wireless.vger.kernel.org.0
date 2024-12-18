Return-Path: <linux-wireless+bounces-16543-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A77829F68AF
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Dec 2024 15:38:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 61C92189278B
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Dec 2024 14:38:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5722C1C5CD8;
	Wed, 18 Dec 2024 14:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="ZfC9+YfY"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 983801C5CC2;
	Wed, 18 Dec 2024 14:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734532677; cv=none; b=dkHyHHOzEse0AJQaKYDrSXmN/LmT5SXIV1lIyHwrlSGbSlKb0MDdKtIr9W1vUzuRLOq3pSm/nkW/oiAoNzLpcehNpuynsV3sDbQhz30ZCSOvTXbL8u089Y+XRdANMuZMRYp/ggZDH3lPhCeE9P5k4MTjx6YMmsw0vbRSQttvq+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734532677; c=relaxed/simple;
	bh=IVEcDsaI2OyGFENo11qRp7VorCivjH0WInGiwWFi9lY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=U5XFnoPM/BrYM/Zn0nvS+uELFY23JUEJYc9XYO+hfStGrLTn4u1CHgm/0MeXs2+jktnY7Q9vjIpdFz9ZKIsOllJqsmws3Mj1NkJWRT4yyuAeZH8JtteAFbtl74yqmgTQTkfHMLo0ZUhpbT6HjVLlmMdecF++XiIVxwynK/sT5vo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=ZfC9+YfY; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=fiuVh5AdPe50xRuXRwRW1cnMDMEhi+hjNVJMLoiSAw0=;
	t=1734532675; x=1735742275; b=ZfC9+YfYwozxw0yeQp/WYDbMDEmC2A2TdzH7G1WLn20dcJE
	T1aFZ/NmInXUv+UwAKkdMLtQiQdIokb6ei26GaPpEWp9njQ6Yp9MI5IJOdnIz9yO9l2i1+LAhR5b2
	92l9n1TVjYff3lqJ/QdjVz1hDuwohjMvHN7rFXKvjLq6SFYgL5awF9GUh26au2g35GnCnYPYGt1r+
	LnULrauAA0HyrDmidgVSUOryPJATdxKL1o3uswNO3ofDlHoA8EFnWIDxLxjEdDpwLet1xUBx+3hfs
	gPHq1uOnPichEFoIsXXkFwWjyaASdAZ2SrWrPwa6O8X2J5MgMH2VnY/1KQkZfH/A==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98)
	(envelope-from <johannes@sipsolutions.net>)
	id 1tNvBJ-00000003GOZ-3ry4;
	Wed, 18 Dec 2024 15:37:46 +0100
Message-ID: <ffe100d99b836d1cf3c63bf9570d34274e83684c.camel@sipsolutions.net>
Subject: Re: [PATCH net-next v2 7/7] netlink: specs: wireless: add a spec
 for nl80211
From: Johannes Berg <johannes@sipsolutions.net>
To: Donald Hunter <donald.hunter@gmail.com>
Cc: netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>, "David S.
 Miller"	 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni	 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	linux-wireless@vger.kernel.org, donald.hunter@redhat.com
Date: Wed, 18 Dec 2024 15:37:45 +0100
In-Reply-To: <CAD4GDZz3xSyA2zJcs-wbZa4yD-ZT90PeOLFReOcr286-nycA6g@mail.gmail.com>
References: <20241210161448.76799-1-donald.hunter@gmail.com>
	 <20241210161448.76799-8-donald.hunter@gmail.com>
	 <9c0fcee07cb7b93308a5d0185c4e74fb3cbbef1c.camel@sipsolutions.net>
	 <CAD4GDZz3xSyA2zJcs-wbZa4yD-ZT90PeOLFReOcr286-nycA6g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.2 (3.54.2-1.fc41) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Wed, 2024-12-18 at 14:32 +0000, Donald Hunter wrote:
>=20
> > > +operations:
> > > +  enum-model: directional
> > > +  list:
> > > +    -
> > > +      name: get-wiphy
> > > +      doc: |
> > > +        Get information about a wiphy or dump a list of all wiphys. =
Requests to dump get-wiphy
> > > +        should unconditionally include the split-wiphy-dump flag in =
the request.
> > > +      attribute-set: nl80211-attrs
> > > +      do:
> > > +        request:
> > > +          value: 1
> > > +          attributes:
> > > +            - wiphy
> > > +            - wdev
> > > +            - ifindex
> > > +        reply:
> > > +          value: 3
> >=20
> > could the value not reference "get-wiphy" and "new-wiphy" from the
> > command list? That might be easier to understand?
>=20
> There is currently no schema or tool support for referencing enum
> constants when defining protocol message ids. Most of the netlink
> families don't have any need for an enumeration of commands in the
> spec; nl80211 is unusual in reporting available commands.

Oh, that's what it is. I'm not sure anyone really needs that now with
the genetlink introspection, though I guess existing tools do use it.

johannes

