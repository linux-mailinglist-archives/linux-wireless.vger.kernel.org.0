Return-Path: <linux-wireless+bounces-8498-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 90F888FBC90
	for <lists+linux-wireless@lfdr.de>; Tue,  4 Jun 2024 21:30:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2C539B23D18
	for <lists+linux-wireless@lfdr.de>; Tue,  4 Jun 2024 19:30:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 915C114B95C;
	Tue,  4 Jun 2024 19:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="NHYIEzd4"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E95E8149E00;
	Tue,  4 Jun 2024 19:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717529416; cv=none; b=BTrSY0qM1Fc6FfvoipTd+8UHoqkZymbIBRjKmI5C0dJfTdLNdvqZKB0mjlp0MOZW2Xgn+H+GSnBMqrG/GKzMhuBFnCSO8gKnqKZB5/qO7HiWes3UZ6VjguL4z6OmZireg6FN9oxMCk6UnRwMU1I3nKrEMM4k9tS6G0olX2i7tJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717529416; c=relaxed/simple;
	bh=ndt5DjQLSxNaMRiN5lWMogKV1y5Mo8iJXJhz3aNywNU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=m6I0JCSFywjzslM1h2a99G8MT20dN5rV/k+j8S1Gx3hyMAO9CQY5TCbrm7nb1X8ZEplJxcT/AXzTN6FXaYg5Kx76rUqthsrwIYaWUZ98YNEuGTbA/YiTP6gpC8TgFldFIOXTlIOl+9T8Oq/m7bW/TP8S1r0lFBrDBv8NRr63i7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=NHYIEzd4; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=SjfoPtdjADSbT41zcd4TQ1qMWoklnCAhWIpkfEJKm1Q=;
	t=1717529413; x=1718739013; b=NHYIEzd4h3I05y9SHIkqwUaFy9wL1RY6nRwgO9qhjGoJ+BO
	t3M8Aut/gyFurhcII4Mt8BeKGpoXn+23NPH5h39ijQ6o9UyCZWDg3gpcOCqGZowklzPIgCboDwVgC
	SNH4ASHQtOy824JkeZ09TjFb2USBCXUmFB1xCETtykWO3Kv2kMfkWNsOXqfOK2MXNxB7U3+ljjz7L
	2OxVz2Ig+rPOArLKKVkQap2OFJbA1tDUkfVC+kGWLfLoyDHUMZ15kuS3VbDMJ7Lc8L8x2rGQAbFVn
	LTzKndGgFR6hzfl/BgjPhUxAd2houkv1MeRQAhAmb4dki1gNW5WKseWGGkb8nr4Q==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1sEZr5-0000000CoV1-2UFL;
	Tue, 04 Jun 2024 21:30:00 +0200
Message-ID: <ab59089feac4cfbc1d681fcaa4a828ca13088ce1.camel@sipsolutions.net>
Subject: Re: [PATCH v2] wifi: mac80211: Avoid address calculations via out
 of bounds array indexing
From: Johannes Berg <johannes@sipsolutions.net>
To: Kenton Groombridge <concord@gentoo.org>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com,  linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
  linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, Kees Cook
 <keescook@chromium.org>
Date: Tue, 04 Jun 2024 21:29:57 +0200
In-Reply-To: <cx2oet5b5lavjywcbf7u4c32krtoglvt3xbe2sxac55e36iibw@lrd5iuhtxz2g>
References: <20240517145420.8891-1-concord@gentoo.org>
	 <d1fea590e53cb1b00dc64f4f8a4c8aec84610401.camel@sipsolutions.net>
	 <cx2oet5b5lavjywcbf7u4c32krtoglvt3xbe2sxac55e36iibw@lrd5iuhtxz2g>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Tue, 2024-06-04 at 14:53 -0400, Kenton Groombridge wrote:
> On 24/05/29 04:54PM, Johannes Berg wrote:
> > On Fri, 2024-05-17 at 10:54 -0400, Kenton Groombridge wrote:
> > > req->n_channels must be set before req->channels[] can be used.
> > >=20
> >=20
> > I don't know why, but this patch breaks a number of hwsim test cases.
> >=20
> > https://w1.fi/cgit/hostap/tree/tests/hwsim/
> >=20
> > johannes
>=20
> Pardon my absence.
>=20
> I'm also not sure why these tests are failing. Unless I'm missing
> something, the runtime behavior of these code paths shouldn't have
> changed significantly.
>=20

Looking at your patch again, this seems wrong?

> +				local->hw_scan_req->req.channels[*n_chans++] =3D
>  							req->channels[i];
>=20

This will increment n_chans rather than *n_chans, no?

johannes

