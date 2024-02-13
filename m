Return-Path: <linux-wireless+bounces-3522-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0432C852D82
	for <lists+linux-wireless@lfdr.de>; Tue, 13 Feb 2024 11:09:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 981081F2C520
	for <lists+linux-wireless@lfdr.de>; Tue, 13 Feb 2024 10:09:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AA532230C;
	Tue, 13 Feb 2024 10:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="WFcHG3zr"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 699E324A08;
	Tue, 13 Feb 2024 10:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707818975; cv=none; b=b9Ppv+OtLfpXgGUEf9mWDrCigrAV2vC3m4/8bNT/U/RptnXUPBtSN9MJ/pLbMx86/C0/8eDZIQX2CfMRoyv5e/fBBQqlEZoD6xZxRsxWvo7nuUOc3Eq7fuwoX18kCFXK1dw90xcUQSZCvojRKWCDVkOpJbGLZamEtDSvFTslts0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707818975; c=relaxed/simple;
	bh=LiOYI1K3YgzkKFtY6MA2COogzXP05kMB0V4dcfLu6W8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=TIzFSccj7z30UNOx9+tn+aP7WDw+2lBgF5tcLOwaty2xCEOVTLyMlh6qJOv+N0TIoPXfT09j7ISB8ztrlLPtiPTbJb4ZDrz/Nku+YOK31TOuFgqGO1dsucip1qO2DyBki1ZxZFdbb0ZrSq0UNC7cxFtbOSBPJ6dkb40JO7DsHEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=WFcHG3zr; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=LiOYI1K3YgzkKFtY6MA2COogzXP05kMB0V4dcfLu6W8=;
	t=1707818974; x=1709028574; b=WFcHG3zrfBsw7fp/HX4Lh7/Zhw/4iGP0epgjMJIVmpCph0p
	l/R5N65DRiTA+hW6e5jIJfOx3akPhlvTM3vI1SfmixAw6ClJnj4//mlagu2HErkbt98E4Y+Zgrprv
	2wRIle89gfnIPfW9R2nYjZFWXJVdVUkX7QnV7v26/NchmCMQnulXnOKUP92s2roCPXM7THIjkCft0
	nfA7Eo/8C5kC1FniYiXCiPv8+ezvp2uzfU8792VZ5iPx6oeAC+9Q0ZOfDQquk4oVYybfa+sEu6YFU
	0F0q+b6OxcD/zjWghYM0z1UAUBMezvAzzVCdxM3RNKG1XXfOzkQXOrUIZlTrDB4g==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1rZpjH-00000007bOe-3vbD;
	Tue, 13 Feb 2024 11:09:32 +0100
Message-ID: <b00c3b53cd740e998163f84511ee05dc3051ce8b.camel@sipsolutions.net>
Subject: Re: [PATCH 1/1] wifi: nl80211: Add support for plumbing SAE groups
 to driver
From: Johannes Berg <johannes@sipsolutions.net>
To: Arend van Spriel <arend.vanspriel@broadcom.com>, Kalle Valo
	 <kvalo@kernel.org>, Vinayak Yadawad <vinayak.yadawad@broadcom.com>
Cc: linux-wireless@vger.kernel.org, jithu.jance@broadcom.com, 
	netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>
Date: Tue, 13 Feb 2024 11:09:30 +0100
In-Reply-To: <b4d44fb5-78e5-4408-a108-2c3d340b090e@broadcom.com>
References: 
	<309965e8ef4d220053ca7e6bd34393f892ea1bb8.1707486287.git.vinayak.yadawad@broadcom.com>
	 <87mss6f8jh.fsf@kernel.org>
	 <2c38eaed47808a076b6986412f92bb955b0599c3.camel@sipsolutions.net>
	 <b4d44fb5-78e5-4408-a108-2c3d340b090e@broadcom.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3 (3.50.3-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Tue, 2024-02-13 at 10:42 +0100, Arend van Spriel wrote:
> > So looks to me like Broadcom doesn't want its (real) drivers to work in
> > upstream, so I guess we really ought to just stop accommodating for the=
m
> > in the wireless stack... This only works if we collaborate, and I've
> > said this before: I can't maintain something well that I cannot see (an=
d
> > possibly change) the user(s) of.
>=20
> Understood and you are right. The brcm80211 drivers, which are not less=
=20
> real ;-) , were a side-project to serve a certain group of customers.=20

It's a real driver, fair enough. But yeah, you do get the sense that
whatever it is, it really "was" and "isn't" any more.

> Unfortunately it never became the main driver for Broadcom. Cypress did=
=20
> invest in brcmfmac, but we know how that went since Infineon took over.=
=20
> Maybe they will upstream the ifxfmac driver [1] some day but I have no=
=20
> high hopes on that.

That doesn't even look super awful, they could probably drop it into
staging as is ...

But that'd mean somebody actually cares, which really seems to be the
problem.

But since clearly there's no incentive for anyone here in this game to
upstream anything to start with, I also don't see why I should give more
incentive to _not_ upstream things by accommodating non-upstream drivers
in the upstream wifi stack...

So I'm dropping this patch, Broadcom can decide what they want first,
but you can't have both upstream and non-upstream together.

And for the record, I'm very happy that you have and still are
maintaining this driver as far as it's come.

johannes

