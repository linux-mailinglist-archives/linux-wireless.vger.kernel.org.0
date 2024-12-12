Return-Path: <linux-wireless+bounces-16296-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 567219EE16D
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Dec 2024 09:37:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AA1722834E2
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Dec 2024 08:37:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7055920B21D;
	Thu, 12 Dec 2024 08:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="OKyAkVcX"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAC92259496;
	Thu, 12 Dec 2024 08:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733992621; cv=none; b=pEUn3IlYG7q9QK7+RECtucw3vHIpO8PFgVqxdwbraf2+nrCK7CNhemnjMji5WRcgpAXEWvW+9xX1RR+dcFPxQ0mQrucpMcOhkS4ft63uO3G733yeOS+4kDaOZlXGNgHDShJm2YiyCyJc/apQ43aAzLVknf8/dHN/u7ldYcl/UgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733992621; c=relaxed/simple;
	bh=PXyVToHgBZ/irKQmsyPqluV5a2VOI0+6VtqRCyOuRFM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=EgCAzJh8q9iUIipZ5QUjhqunHhMGISX3mnHJWpnV5dAD4XScB+RDhnNjz7/Wu68JUj2aJFXv5VfYQKPayET6CFY2EQCiJa/iDBIdrHwycitgdQzrLVe4zmqUnEcTrI8CWsMzNnlQBgRfaiHVq3MNLFjdVtDM7e6BZuYczC7dg8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=OKyAkVcX; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=7KbY6Zm7XQ1HcYK2xy67X3utVVHXapQSwU7xM6Ao3ts=;
	t=1733992619; x=1735202219; b=OKyAkVcXuTfq+ll47hOf6g+oNu1uGjFmZeRtWj40pG9gBco
	sQ1ODSppw98u9+B05zDqFyNbfj4MBGIWIXPqLzY3sizBdQCdLhjyjhESyP1lSZl4OoQO4tJ/bsCM2
	w7ESiel9ijvp0mdbOF1urNQgA0kUzZScl+tNWFmz5RAfSj7X1XUC6KLWTKrahTh+KsCQ8hzARzVWk
	QWpGBqnlJ1R7pXY76rYqV+AndrFB8mxUa4vtf2oj7lfAnuQoyDUSO2wUwvfYUWlkdgSMzqcR6z2s1
	9NOVIdKGYl7oclw41eSrfdfDMUAJQ1w5ZOe99lMZNDwSh7USowBcdBel9Y9M3NJg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98)
	(envelope-from <johannes@sipsolutions.net>)
	id 1tLegp-0000000EMJI-0P4Z;
	Thu, 12 Dec 2024 09:36:55 +0100
Message-ID: <9c0fcee07cb7b93308a5d0185c4e74fb3cbbef1c.camel@sipsolutions.net>
Subject: Re: [PATCH net-next v2 7/7] netlink: specs: wireless: add a spec
 for nl80211
From: Johannes Berg <johannes@sipsolutions.net>
To: Donald Hunter <donald.hunter@gmail.com>, netdev@vger.kernel.org, Jakub
 Kicinski <kuba@kernel.org>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet	 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon
 Horman	 <horms@kernel.org>, linux-wireless@vger.kernel.org
Cc: donald.hunter@redhat.com
Date: Thu, 12 Dec 2024 09:36:54 +0100
In-Reply-To: <20241210161448.76799-8-donald.hunter@gmail.com>
References: <20241210161448.76799-1-donald.hunter@gmail.com>
	 <20241210161448.76799-8-donald.hunter@gmail.com>
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

On Tue, 2024-12-10 at 16:14 +0000, Donald Hunter wrote:
>=20
> +  -
> +    name: wlan-cipher-suites
> +    type: enum

I'm not sure exactly what this does, but I'm not sure 'enum' is the
right way to think about it. Pretty much every number (OUI + subvalue)
could be valid here, if the driver advertises support for it and you
have a supplicant that understands it.

> +  -
> +    name: wiphy-bands
> +    attributes:
> +      -
> +        name: 2ghz
> +        doc: 2.4 GHz ISM band
> +        value: 0
> +        type: nest
> +        nested-attributes: band-attrs
> +      -
> +        name: 5ghz
> +        doc: around 5 GHz band (4.9 - 5.7 GHz)
> +        type: nest
> +        nested-attributes: band-attrs
> +      -
> +        name: 60ghz
> +        doc: around 60 GHz band (58.32 - 69.12 GHz)
> +        type: binary

This (and s1g/lc) should also nest, with the same attributes? There
should be no structural difference between the bands, even if most of
the values are only used/valid for some of the bands.

> +operations:
> +  enum-model: directional
> +  list:
> +    -
> +      name: get-wiphy
> +      doc: |
> +        Get information about a wiphy or dump a list of all wiphys. Requ=
ests to dump get-wiphy
> +        should unconditionally include the split-wiphy-dump flag in the =
request.
> +      attribute-set: nl80211-attrs
> +      do:
> +        request:
> +          value: 1
> +          attributes:
> +            - wiphy
> +            - wdev
> +            - ifindex
> +        reply:
> +          value: 3

could the value not reference "get-wiphy" and "new-wiphy" from the
command list? That might be easier to understand?

johannes

