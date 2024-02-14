Return-Path: <linux-wireless+bounces-3600-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DAD08553C3
	for <lists+linux-wireless@lfdr.de>; Wed, 14 Feb 2024 21:12:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2B907B24BEA
	for <lists+linux-wireless@lfdr.de>; Wed, 14 Feb 2024 20:12:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E069013DB9F;
	Wed, 14 Feb 2024 20:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="SGHHNmPH"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80B216A002
	for <linux-wireless@vger.kernel.org>; Wed, 14 Feb 2024 20:12:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707941545; cv=none; b=qp+SW4+SNmjYoAhd5PXtAaGgeo0+nKt+7f+ADHgCTrzQPYmxdbmWOsh7avXUTCMQnOhnAitAghBUZjISN5cMxbQN6WSi9cKkwS48UfchVjdZBFTu6a1hpDXqficIpJkW102t66x2pRtshutS/s5JBMGmOL5s5h3Cel7DSAbi1LA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707941545; c=relaxed/simple;
	bh=4xF3X7oBNv1mPclCUOQCHhen4hRRRJ258CYBxvZnjwU=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=YRJ7li+BDsqFpb9MC11shALyz7+QKvpavz04UMA112+hXRHB23kj711LONtpOIFaQPCmD40nnv/lwx1LRSRAsJrYb34kXDQFf5zcJJD/EmZfsfWwcbdVwjZ6B7+t64msCvUL7xH+7cDx3jgCPXqWj28Qh7JRH2J1CZltZMzKPus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=SGHHNmPH; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:To:From:Subject:Message-ID:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=4xF3X7oBNv1mPclCUOQCHhen4hRRRJ258CYBxvZnjwU=;
	t=1707941543; x=1709151143; b=SGHHNmPHZ2ErWDsXDSqavcWtWHSmhLuRP5mRJDDF6KG1z3s
	wLfQjBJU2+bDCQ81PjZewf7u3f1n/edLGmZ0wR1kHesUKw/8SZUajt4HJqiaBLGfxqSuJG0mxO6iB
	rMFN/6hRpLZg284Qs7lH1b19pr6fAi9qNHD1GJPT9DxEh0pGFzZxPOHvFI6rBM3JEpisfYAwOemz4
	reqf66LrBgY6xusfoX2sclBjUIswVUrVuurBKfKTGn1Nz0E6rGE8klF3oWYoSMeR4tmGL18q6qpdd
	PBZfW0ygNHxMopQgKMrMriBPn44YbSOFysKW0ZF6hrg2E71xYKw6qr0WVGfvpNmQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1raLcC-00000009MmJ-3Olq;
	Wed, 14 Feb 2024 21:12:21 +0100
Message-ID: <d8f742a13ad4d299ec23545ee29248989e1b3da5.camel@sipsolutions.net>
Subject: Re: brcmfmac AP mode
From: Johannes Berg <johannes@sipsolutions.net>
To: James Prestwood <prestwoj@gmail.com>, KeithG <ys3al35l@gmail.com>, 
	linux-wireless@vger.kernel.org
Date: Wed, 14 Feb 2024 21:12:19 +0100
In-Reply-To: <4eda39b4-3b16-4f01-a241-50409d34ce33@gmail.com>
References: 
	<CAG17S_MOiC43F2wXMG-Y6nQgitZQJs18jESQJrX+aC6=MQb6ew@mail.gmail.com>
	 <e0825627-4652-4c5a-ae29-33c270a38bc0@gmail.com>
	 <311c594bddde32bacd45acbfa6f40fa7670e51c6.camel@sipsolutions.net>
	 <4eda39b4-3b16-4f01-a241-50409d34ce33@gmail.com>
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


> > In any case, you could argue that starting AP and client and then
> > scanning is pretty much _asking_ for trouble.
>=20
> Yes I suspected as much. It seems some firmware is just better at this=
=20
> than others.

Sure, that makes sense. Beacons are important, you could schedule (non-
passive) scans between them, and ... yeah you're going to lose frames,
but perhaps not the connection as likely.

> There is one use case there that I believe Kieth is=20
> targeting and that is new device onboarding which I'm sure your familiar=
=20
> with as just about every "smart" device uses it. Where the new devices=
=20
> starts an AP and your phone/App connects and provides credentials to the=
=20
> "real" network.=C2=A0

:)
I always fight with that because typically it wants to transfer the
network credentials from my phone (and be on the same network), but many
devices I don't want to be on the same network ;-)

> The tricky part is having the new device scan for=20
> available networks while it has a client connected. Some drivers support=
=20
> AP scanning which maybe is really what should be used for this? Maybe=20
> that is optimized to actually work.

That really depends how it's implemented, I wouldn't necessarily say
that "AP scanning" is really better. It's still a crutch.

> I guess I'll also ask, what _is_ the target use case for STA + AP=20
> interfaces running concurrently? If scanning is unreliable then=20
> connecting would also be most likely? so what can you actually do here?

You don't _have_ to be scanning on the station all the time if all you
care about is being connected to some other AP? But yeah, it's not all
_that_ useful to have that combination ... and yet I guess people want
it and want to live with the limitations. Especially if firmware is
better than what seems to be the case here.

I dunno. I don't think we support this combination for our devices, but
then again we only really support very limited AP mode.

johannes

