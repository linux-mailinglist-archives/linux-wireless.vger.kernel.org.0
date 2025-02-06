Return-Path: <linux-wireless+bounces-18590-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47BC0A2A4E1
	for <lists+linux-wireless@lfdr.de>; Thu,  6 Feb 2025 10:43:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CEAAE161AD5
	for <lists+linux-wireless@lfdr.de>; Thu,  6 Feb 2025 09:43:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B13AE22616E;
	Thu,  6 Feb 2025 09:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="nrZL80hW"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3293C22617B;
	Thu,  6 Feb 2025 09:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738835033; cv=none; b=ShK9YdxqKBhkCPY7ZZf4ppVa8BsaTOkR+hmECFiLo/MkM4tW8+qBCWfzxFWODgUABDNmJaJ4s7z+yL4WfsVcHuhjbRJfVUZOtZgj5/QmOjJPJ4ifUF/vfYn+O2CQGYoLfSuTKfBJpmvL/sYEP4Yr9GWcq8abXLufODjFWDKEhFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738835033; c=relaxed/simple;
	bh=2CU6rKQgBTkyUVzxGZ9/le6oQKbbkmeFxvB2o8HLihI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ByYljq0/vXH6e917kQD2tNsi95QFZqvxzJDYakmWolITZAIwd1L4RRiTX8auAi+x+gVsw54ufjjRERNO33PU2MCKINLf7FQOdUtLwFY7c92+FFH21f2DB/VhNtqWnn0SPIC4FQUkTrSproDvNULDc9UMigpW0j4cvOF7DD9GPYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=nrZL80hW; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=JXGiHZytgRX1Kr+OdP27bjmtvwbFEVk2dhAHOxPhcJU=;
	t=1738835032; x=1740044632; b=nrZL80hW6NkCC9agpYpqbqK7h4u/ALkM9jdATCpwBBgiMsc
	UCBJbai03Zi5wfrkKsBxp0CUwiDn4sVCMzoehAI3RbQ4f85ZG4oing0kQXAPTWclxK9CcAjQY+O9x
	rEaNw9x5BHtD/Cy8tkvOHlP0Dhpj2sqmD+LYI7EoUQeDr/hR5csQjYxHG0ltR0jcvfZICkzDMJ+cl
	bxmoJ8flCbU0hguSxdw9BJSvMnPlRoYzbFHcEijrNMrMCxUwH6TEee66jNTIZIaB3f11Yg/pbB9eA
	7BN+zgsZwikAXr5AThr338Z6GAbKT37cY8WXjszHH63tML5/qjRDAAd1r4rUzgUQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98)
	(envelope-from <johannes@sipsolutions.net>)
	id 1tfyQE-00000004xio-1RnR;
	Thu, 06 Feb 2025 10:43:46 +0100
Message-ID: <da75ef6287d00bf5d1200118bd48d46d11d45607.camel@sipsolutions.net>
Subject: Re: [PATCH net-next v3 10/10] netlink: specs: wireless: add a spec
 for nl80211
From: Johannes Berg <johannes@sipsolutions.net>
To: Donald Hunter <donald.hunter@gmail.com>, netdev@vger.kernel.org, Jakub
 Kicinski <kuba@kernel.org>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet	 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon
 Horman	 <horms@kernel.org>, linux-wireless@vger.kernel.org
Cc: donald.hunter@redhat.com
Date: Thu, 06 Feb 2025 10:43:45 +0100
In-Reply-To: <20250206092658.1383-11-donald.hunter@gmail.com>
References: <20250206092658.1383-1-donald.hunter@gmail.com>
	 <20250206092658.1383-11-donald.hunter@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Thu, 2025-02-06 at 09:26 +0000, Donald Hunter wrote:
>=20
> +    name: feature-flags
> +    type: flags
> +    entries:
> +      - sk-tx-status
> +      - ht-ibss

Oi, I'd really hoped you auto-generated that even with a one-off sed
script or so, but:

> +      - ds-param-set-ie-in-probes
> +      - wfa-tpc-ie-in-proves

typo?

johannes

