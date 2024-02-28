Return-Path: <linux-wireless+bounces-4177-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AA8986AC36
	for <lists+linux-wireless@lfdr.de>; Wed, 28 Feb 2024 11:31:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0B3571F27735
	for <lists+linux-wireless@lfdr.de>; Wed, 28 Feb 2024 10:31:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A070F62A18;
	Wed, 28 Feb 2024 10:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="fD+Edg63"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF4FD629F7
	for <linux-wireless@vger.kernel.org>; Wed, 28 Feb 2024 10:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709116256; cv=none; b=t/TpgBBso6YxJrfpXSQ68uGqRPDiCJxIEbSd94d/gpB2rAoobHSPAvymY8GyPIIGdvQgGxOiJQba3FZ/cDwZuke2eZGsbFQr5KDsenF02hnh2zdhL/2kv6sLJ+p7Q6Detu+Ge2Kedn+hDxJmq1MEkqJeKbSMBllFT/x4cZ5CBhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709116256; c=relaxed/simple;
	bh=wZKglSwW/Dl5UckaCJImCCZvqzT3o8CQoqyoAfHfCns=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=a1HRyuxl8HmEreB86oZvnajjszwcN/Bn3Se44VO2spBl8abx5/yqNptAWAEiMQ4MbB6AxiEqFyoMvLbMwNIR9puYQghNZCx56FZC3lMUxJi2meom+RHiPpfxkleHfMA9Y9pJNAXIYqaci7Pxxc+0YAnJNnhpxqaxFgiqQ5souTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=fD+Edg63; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:To:From:Subject:Message-ID:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=wZKglSwW/Dl5UckaCJImCCZvqzT3o8CQoqyoAfHfCns=;
	t=1709116253; x=1710325853; b=fD+Edg638wwDTKQsbQRCE3w5NI6XeGFNvivSiTDOGGRfZMz
	7ZDZD9KZBEPN4I1HlNMvJ75bPI81KBheVZOn21F8EiLP7lAqv1Kb/F/a4vawE5xKkFO0+iV0LPAQy
	C15CI2KoY1gzGxiUhhYmr90NzQnd/FCZUpRGLRnIxehZMLz9TzBEvh4mezInbYC8dgleZMbakmYBz
	5axVIcqSuCz/bsWf6dIWgnrrQB+M44rKiOnu+k2NkVpkwrXgXydhETTJXky/aKvWmzW077mODl41y
	GPzSaOcqJYgKAhJv3oVCLsDMN4vU2rm9sHbl25tAOGKfgcGzFxrBOMDYmlzS2OTQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1rfHD3-0000000C4QM-0WlO;
	Wed, 28 Feb 2024 11:30:45 +0100
Message-ID: <795b376aa2c9112527cf135a5176f01c6af69ade.camel@sipsolutions.net>
Subject: Re: "iwlwifi: probe of 0000:00:14.3 failed with error -22"
From: Johannes Berg <johannes@sipsolutions.net>
To: Harald Dunkel <harald.dunkel@aixigo.com>, linux-wireless@vger.kernel.org
Date: Wed, 28 Feb 2024 11:30:44 +0100
In-Reply-To: <b9b2224a-f021-483a-8606-6aed94c5f6f9@aixigo.com>
References: <dd1e2440-bb05-48d7-9f68-29bae758110d@aixigo.com>
	 <9edf7003715cfdda3c794f3adbaeac5f36ada8ee.camel@sipsolutions.net>
	 <b9b2224a-f021-483a-8606-6aed94c5f6f9@aixigo.com>
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

On Wed, 2024-02-28 at 11:23 +0100, Harald Dunkel wrote:

> It used to work with the same kernel.

OK.

> This is what we get for the new (6.5.10, Debian backports) kernel now:

But that'd mean it's working - or are you saying that's a different
machine?

> [Tue Feb 27 09:44:51 2024] iwlwifi 0000:00:14.3: enabling device (0000 ->=
 0002)
> [Tue Feb 27 09:44:51 2024] iwlwifi 0000:00:14.3: Detected crf-id 0x130050=
4, cnv-id 0x80400 wfpm id 0x80000030
> [Tue Feb 27 09:44:51 2024] iwlwifi 0000:00:14.3: PCI dev 51f1/0074, rev=
=3D0x370, rfid=3D0x10a100

This seems to work, has a proper PCI ID, and shows a different RF ID?

You previously showed

iwlwifi: No config found for PCI dev 51f1/0000, rev=3D0x370, rfid=3D0x1010c=
000

So I think it'd still be interesting to know this line from the system
that doesn't work any more, to see if it really was _exactly_ the same,
as this before and changed, or whatever happened.


> > If you really have subdevice ID 0000 then something went wrong and you
> > have a blank OTP (now), which seems very strange.
> >=20
> > This is an integrated NIC where part of the NIC is integrated into the
> > platform, and other parts are on the companion RF (CRF), so could also
> > be that the CRF module isn't seated well any more in the slot and it
> > just cannot access the data properly?
> >=20
>=20
> You mean there could be a problem with the wifi card not being plugged in
> properly? We will check when my colleague is in the office.

Yes, that's what I mean.

Note the "wifi card" is just the CRF module in this case, much of the
wifi is already built into the platform/SoC. The M.2 form factor card
that you have in it isn't the PCIe device that shows up in Linux, it's
just the radio module etc. So that not being connected properly might
explain a situation like this, not sure though.

johannes

