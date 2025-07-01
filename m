Return-Path: <linux-wireless+bounces-24725-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 31F9AAEF61C
	for <lists+linux-wireless@lfdr.de>; Tue,  1 Jul 2025 13:07:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 157943AF511
	for <lists+linux-wireless@lfdr.de>; Tue,  1 Jul 2025 11:06:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8622270579;
	Tue,  1 Jul 2025 11:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="v2DiUrVz"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5170E23185E;
	Tue,  1 Jul 2025 11:06:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751368014; cv=none; b=Bwdo5qr7btRffKJB01kcPcZ6OnYT+dTGeujo9GT93zpj+yalYMDYy+DBt+RmCMprbnvd5L3b7m8L69l8qeBCL00XlSbEpTxsdfLetFxQbgnKePWKwWexUipsLe4PIuNg3lA2kHK+kjWLoPRcsasARViRTBp1RG5qGZBdsOgSfww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751368014; c=relaxed/simple;
	bh=ch8rmZW0C5CiGXt2M3zLaPifKAaE9CqIGZusfMCbRic=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=WAcpz8EoeB76szBB+vkwQopokN2g62WWVuvhPJEhr542TUBNKrD0JCHXOp8xrKKNTxHVXsGk5W1Acuwu7FQcREADCNHTpUT7UKYNLZl7MYGJwpN4bRnAizRAoahq59LV9YUcZzbr6KBjRHpSbXS6c2astvDPgj+cZREpXezi4Z4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=v2DiUrVz; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=2U0iMkfr1aZU35nLWrIQMlyrU651eqYDp0UZC1bQLwo=;
	t=1751368013; x=1752577613; b=v2DiUrVzl+vEt14uj83Cbz3+OQAlqGFZ8LbHB8MFKcof9vI
	kh4EXDeDBzYqiqP3uNFvRw263VmUwsy6XB10RXiUjzkOxmof8GjZVXqqCyQTyNzPUOi82AFjN4oJg
	1C7WRBbR9hMcoPPGvCX2yykP+gpNcT8pzz5da2q+DFmr0vmumPuNZPUtYb1IXIfdePUcFTOQLRQiQ
	EP5IfyOAzp2KVDcgjlwDgW8e34RthQlbfoul+6X1oIkMG+kbKEPNLvpiy+VYm0oYUufEjAa+R460E
	7UppuhlhcENZPxJn+BC4tGfnLvP+NH7OEkQ20F8F5XQcCUdVwf9etQ3pAr4b+jEg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1uWYp5-00000002iG2-0UND;
	Tue, 01 Jul 2025 13:06:47 +0200
Message-ID: <0004f9e5eb62f9ccad3dec52ebc935bfec42c949.camel@sipsolutions.net>
Subject: Re: [PATCH v5] wifi: cfg80211: move away from using a fake platform
 device
From: Johannes Berg <johannes@sipsolutions.net>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	linux-kernel@vger.kernel.org
Cc: linux-wireless@vger.kernel.org
Date: Tue, 01 Jul 2025 13:06:46 +0200
In-Reply-To: <2025070116-growing-skeptic-494c@gregkh>
References: <2025070116-growing-skeptic-494c@gregkh>
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

On Tue, 2025-07-01 at 12:56 +0200, Greg Kroah-Hartman wrote:
> Downloading regulatory "firmware" needs a device to hang off of, and so
> a platform device seemed like the simplest way to do this.  Now that we
> have a faux device interface, use that instead as this "regulatory
> device" is not anything resembling a platform device at all.
>=20
> Cc: Johannes Berg <johannes@sipsolutions.net>
> Cc: <linux-wireless@vger.kernel.org>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
> v5: - rebase against 6.16-rc4 and actually cc: the relevant maintainers
>       and mailing lists this time, doh!

I did wonder for a second why it's v5 and I never saw it ;-)

>  int __init regulatory_init(void)
>  {
> -	reg_pdev =3D platform_device_register_simple("regulatory", 0, NULL, 0);
> -	if (IS_ERR(reg_pdev))
> -		return PTR_ERR(reg_pdev);
> +	reg_fdev =3D faux_device_create("regulatory", NULL, NULL);
> +	if (!reg_fdev)
> +		return -ENODEV;

Is that really -ENODEV rather than say -ENOMEM? Having a hard time
imagining how a faux device creation would end up failing in any other
case, there's no underlying device to bind to, after all? :)

Anyway, that's not really all that relevant. I assume you want me to
merge it through wireless-next, since we have faux.h in the tree now?

johannes

