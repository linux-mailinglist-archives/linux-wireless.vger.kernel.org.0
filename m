Return-Path: <linux-wireless+bounces-20858-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FFABA71C24
	for <lists+linux-wireless@lfdr.de>; Wed, 26 Mar 2025 17:46:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9BBDF160B87
	for <lists+linux-wireless@lfdr.de>; Wed, 26 Mar 2025 16:46:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43178145FE0;
	Wed, 26 Mar 2025 16:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="adKQB/uT"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B896215852F
	for <linux-wireless@vger.kernel.org>; Wed, 26 Mar 2025 16:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743007598; cv=none; b=S+mc6KZN989o4Sl08fBla1iQxIHj+QuYF2al9ZVeXIWOBk3iYEeVWjT6r24xKObDvd5rDG4rFxz9J4c+lMNKHEwlGpo3pvnPjQzz91ND1U6NC32eRrNw2XcXQzLnIwOGHst6ETUKYLqDUPSHL3UtBQ5ZWtETqvsJJ34OrJW3KBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743007598; c=relaxed/simple;
	bh=Zx0HXa9RL0u0uPXDPhlZEygNceZiulO8lGZOe7odBnc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=cYFm/NH0Mw1TQU4ok7/4D3Poc6FLOzvh4Gufs+CeUOANAKhFJ832VLunsQkDpn/n3+5qVEUKDF6bLPPOL6dDT5g8Rn+/bWPfSKRttzTDGi/SaxwhKlJt2tRqlusy+VK2nANZml1v6GIpMP69Cjf4B7T8Wsy2uoCpJpEVRvucQv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=adKQB/uT; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=/mBxizgf40BB6Ylij6E4j90qXYxt5HwGPGIMnbON7+U=;
	t=1743007596; x=1744217196; b=adKQB/uT1HKOVoMj6dRfG8GYvYCL85AUiBaoBywoR2/+glX
	9lkBN5broQpWD8UVm9ah+AC3zd2xFX8E2umiCIV16m845t5XwwG/E+ImRNqCO+hUb/tMxAEqaSOur
	RyImfSbXqYm8brWfkDFcqY2b45IhaytpDT0uV07HwRr9VSbgpQTaxjoVYHlLSWWjxq83C5echYg2l
	3Rvi7k+booss9njWBnVE+tKwf6tHfnvB6ZT+H7/tUycMASVwIAMYGbMUMPbY6H/vKE0hzYMi7Xykk
	sppnIvqeVEDbXj/E0MqDggAtKGHUHHpr2hsRlzJkktx/fRdJyA4hUNRUWtTaYkfQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98)
	(envelope-from <johannes@sipsolutions.net>)
	id 1txTth-00000006JaK-1fRJ;
	Wed, 26 Mar 2025 17:46:33 +0100
Message-ID: <7e4058cf8346ad75b93a932141801b42e4cd63e7.camel@sipsolutions.net>
Subject: Re: [PATCH wireless v2] wifi: rework MAINTAINERS entries a bit
From: Johannes Berg <johannes@sipsolutions.net>
To: Jeff Johnson <jeff.johnson@oss.qualcomm.com>, 
	linux-wireless@vger.kernel.org
Cc: Johan Hovold <johan+linaro@kernel.org>
Date: Wed, 26 Mar 2025 17:46:32 +0100
In-Reply-To: <f703bb34-45f8-4f8b-b940-72428efa3c46@oss.qualcomm.com>
References: 
	<20250306092831.f7fdfe7df7b2.I7c86da443038af32e9bcbaa5f53b1e4128a0d1f9@changeid>
	 <085bfa6c-cad5-43cf-9432-811b744da506@oss.qualcomm.com>
	 <6ef5049a68157bae0e121f48afc1d872a25087f7.camel@sipsolutions.net>
	 <f703bb34-45f8-4f8b-b940-72428efa3c46@oss.qualcomm.com>
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

On Wed, 2025-03-26 at 09:45 -0700, Jeff Johnson wrote:
> On 3/26/2025 8:55 AM, Johannes Berg wrote:
> > On Wed, 2025-03-26 at 08:49 -0700, Jeff Johnson wrote:
> > >=20
> > > This patch has the unfortunate side-effect that get_maintainer.pl (an=
d b4) no
> > > longer add linux-wireless to ath* patches, and hence they no longer s=
how up in
> > > https://patchwork.kernel.org/project/linux-wireless/list/.
> > >=20
> >=20
> > Oops. I _wanted_ that entry to no longer match so I don't get CC'ed on
> > everything ... I guess we need to add L: entries to all the things I
> > X:'ed. I sort of thought that might be there anyway, but I see that's
> > not the case for everything ... below change perhaps?
> >=20
> > johannes
> >=20
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index d19627afa652..09bd9827f318 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -3655,11 +3655,11 @@ T:	git git://github.com/AlbanBedel/linux
> >  F:	Documentation/devicetree/bindings/phy/phy-ath79-usb.txt
> >  F:	drivers/phy/qualcomm/phy-ath79-usb.c
> > =20
> > -ATHEROS ATH GENERIC UTILITIES
> > +ATHEROS ATH WIRELESS UTILITIES AND DRIVERS
> >  M:	Jeff Johnson <jjohnson@kernel.org>
> >  L:	linux-wireless@vger.kernel.org
> >  S:	Supported
> > -F:	drivers/net/wireless/ath/*
> > +F:	drivers/net/wireless/ath/
>=20
> unfortunately the ath* specific entries will override so I think we need:

Hmm, really? Seems that if that were the case I wouldn't have been CC'ed
on every ath*k patch?

johannes

