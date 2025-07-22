Return-Path: <linux-wireless+bounces-25839-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 59B57B0D535
	for <lists+linux-wireless@lfdr.de>; Tue, 22 Jul 2025 11:02:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 419091883753
	for <lists+linux-wireless@lfdr.de>; Tue, 22 Jul 2025 09:02:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2770D189F5C;
	Tue, 22 Jul 2025 09:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="CmrPUwYE"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A13CEAC6
	for <linux-wireless@vger.kernel.org>; Tue, 22 Jul 2025 09:02:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753174947; cv=none; b=l9XEZYbDu7az5BzI/VxzeqHEWkEcgZyN/xF/DaD5+e02bgGm+63uCs7yLG8gDribkYvjNdBz7N3t1PJSKGoFxzLps2AFLmf1z1nYcX1gDwLSagmGvolHAhHrL4lrzTTGRC7H7pRFFqWDjvVNiQRik1MKG5zshygbIJNbkzHAPl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753174947; c=relaxed/simple;
	bh=f1pRPCDjY7jHFwB3CITIH4/eizoha/GNGdjsyU+AVdU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=JeytlMb560WrBWRvc+PiX9M66i6hY0+z0j2LuYUBBjIQS5g/reGhPQtkV2nEJWEmB1aR9YvGl2PppNXmhTVo7rdydj3UKy6oiUk3ENztUKhmxHIoSYyegnNhvqZaJRGDC7/TScivEeIjqqPTAgfE5D1MFX0/QIRPzUIX6RHtHZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=CmrPUwYE; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=wf6/aa6WLd50MVLaQ7m2dWMPAg4/Ls2y+su3d8rDlE4=;
	t=1753174945; x=1754384545; b=CmrPUwYECNd+WvWJ7CFqwEf4ghCV8UNWCYDPP5FIIrL2TGM
	Cukc8JVMtEKvo8w+ErLXorFWmq2/ozVRotziHEOoEZQDrTZbkFkcEtZXxa+sB1WRzdO5dmAda9nzG
	K3Q2UvLuwbMcgWLYIhBjDI6Fy1VN6QLytXRE6F8MDq1juyp+QbMjMvucFegeFccmGqYvxkmvFsB5m
	tNOZQBo2n4pz5VJmqsprnb8umrOJMP5T6SFqVqZPMQIiOtQyiUAFrPLF2cMA4WyuqlsCj0Y5EGBw4
	71N/hocET4tSOkJ8+g8L8pHmRFBCbz/c9GvqbIGOPUpKsXT71z4lNRgKVuQnhByg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1ue8tC-00000001qhc-0dkm;
	Tue, 22 Jul 2025 11:02:22 +0200
Message-ID: <1db07eb608ee4345c70fe135dfbe6fc19e17cdf2.camel@sipsolutions.net>
Subject: Re: [PATCH] wifi: mac80211: fix unassigned variable access
From: Johannes Berg <johannes@sipsolutions.net>
To: Antonio Quartulli <antonio@mandelbit.com>, linux-wireless@vger.kernel.org
Cc: Maharaja Kennadyrajan <maharaja.kennadyrajan@oss.qualcomm.com>
Date: Tue, 22 Jul 2025 11:02:21 +0200
In-Reply-To: <2e3aa500-989b-4acf-b6f8-9ee200e67cca@mandelbit.com> (sfid-20250722_110026_114297_7F9F7184)
References: <20250721211736.29269-1-antonio@mandelbit.com>
	 <cdfcd722e1f8527809d89e13484bcb25d3e74947.camel@sipsolutions.net>
	 <2e3aa500-989b-4acf-b6f8-9ee200e67cca@mandelbit.com>
	 (sfid-20250722_110026_114297_7F9F7184)
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Tue, 2025-07-22 at 11:00 +0200, Antonio Quartulli wrote:
> > So I think if anything we should worry about the
> >=20
> >                  if (time_is_after_jiffies(timeout) &&
> >                      time_after(timeout, latest_timeout))
> >                          latest_timeout =3D timeout;
> >=20
> > comparison, but for that just unconditionally setting it to 0 is really
> > the wrong thing to do, since it means you compare to an arbitrary time
> > zero here?
>=20
> We are looking for the maximum timeout, so using 0 (minimum possible=20
> value) as base line should be what we want, no?
>=20
> [note: I am assuming 0 is not a possible timeout value]

That assumption is wrong, in fact jiffies starts at a slightly negative
value (about 5 minutes?) so that a few minutes after boot the time goes
to the perfectly valid value zero. And on HZ=3D1000 32-bit systems, this
situation of course reappears every ~49.7 days.
>=20
> Alternatively, we can just skip evaluating time_after() when=20
> latest_timeout is 0.

But then we'd also have to set it to 1 if a timeout value is actually 0.

johannes

