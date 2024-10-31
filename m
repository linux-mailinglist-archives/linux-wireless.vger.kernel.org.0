Return-Path: <linux-wireless+bounces-14773-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C4829B78FA
	for <lists+linux-wireless@lfdr.de>; Thu, 31 Oct 2024 11:47:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8E0761C21D6D
	for <lists+linux-wireless@lfdr.de>; Thu, 31 Oct 2024 10:47:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 171C0148832;
	Thu, 31 Oct 2024 10:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="OYBzVpyS"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CCDB14659B
	for <linux-wireless@vger.kernel.org>; Thu, 31 Oct 2024 10:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730371671; cv=none; b=DRDO9kxuEugCGUbw498yWEffw7rIzoA82RVr66jKgzt40bcMmHmylm7QpnqCm0EDb9mbmiN0ib5Va8NcMcCg8hg5f6yewNwAtSBhdRhjxhmt4EZ9kczla6mniMG9LW4wDzrScIGZfLYd4v70kvYQB5vdIZXiU9F/tq4N8qK2jfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730371671; c=relaxed/simple;
	bh=Dl8hdDnBmAY1nRSMxM8dTCsNcNJfOb9j7hsGPdHbtO4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XK7cXF4ODvNje1+zN1aS2urPq4pTJNiEnqQ2gzEA6hjc6i9hJKQgDQooh11Df4bTehOo/J/QfvBHR8ib+tk/9syhbfmRBiC7K7Ym9aQKvk6lv7x6HZxfWgxcabWjxPs+j0LhQrwHxZqGYgyTZZhJF+Exah1QnWcrLyCGAOzZJm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=OYBzVpyS; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=Dl8hdDnBmAY1nRSMxM8dTCsNcNJfOb9j7hsGPdHbtO4=;
	t=1730371669; x=1731581269; b=OYBzVpySe8ARMN/oAkFMVMoWCsk8xgNNgpgZqHY+fUPUwnf
	GldJ+qWDxlGjObWybJMgkTs43ZqR77kfHK08r7kOOT0QJgWXO6PJJpkVgzdQGGcOpThmO6T9PH835
	mQL6kb9CwDYFCWelgHp3IbeIgyfgJfQdok1scPjYP0swoDSptDHvGiosjbaD8IwYxc3C13LYHIh8Z
	vTFSpd3IbPY8NFDy6vfz3O3mkbQ6rx7BTzZLhJneyxz3DxPTFgHl+QuqtfJRXO243/GZ7/JNbeRon
	UmPztlyKrRq7cDof6Vhz88f3CvuCv2kZlYwtCqFU9+7yT9l1kWTG6wWMJ/8qGvcA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98)
	(envelope-from <johannes@sipsolutions.net>)
	id 1t6SiH-0000000APAw-1SY6;
	Thu, 31 Oct 2024 11:47:37 +0100
Message-ID: <f6ec91977050f6a1f08d995b4e36ef4067ad3de2.camel@sipsolutions.net>
Subject: Re: [PATCH] wifi: cfg80211: Correctly handle Medium Synchronization
 Delay
From: Johannes Berg <johannes@sipsolutions.net>
To: Benjamin Berg <benjamin@sipsolutions.net>, Lingbo Kong
	 <quic_lingbok@quicinc.com>, ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
Date: Thu, 31 Oct 2024 11:47:35 +0100
In-Reply-To: <b07102047bf2f076c090948b1a06ae4f22a881ff.camel@sipsolutions.net>
References: <20241030025515.16004-1-quic_lingbok@quicinc.com>
	 <e56621b7a8b229f726d644ffde7b98ba0c11b06b.camel@sipsolutions.net>
	 <3a74f2f1-fd9f-46a5-87c1-fdc0235a50e5@quicinc.com>
	 <b07102047bf2f076c090948b1a06ae4f22a881ff.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-2.fc40) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Thu, 2024-10-31 at 10:25 +0100, Benjamin Berg wrote:
>=20
> Right, which does seem to imply that a non-NSTR AP can very well set a
> Medium Delay Synchronization.

Yes, we also pass it to the firmware in iwlwifi, so definitely.

> > Regarding the statement =E2=80=9CCould it be that this is intended to b=
e used by=20
> > NSTR APs only,=E2=80=9D I did not find any explicit indication in the s=
pec that=20
> > the multi-link probe response carrying the medium sync delay subfield i=
s=20
> > solely applicable to NSTR APs.
> >=20
> > Additionally, do you have any suggestions on how to address this issue?=
=F0=9F=99=82
>=20
> Not really. I don't grasp the intention of the specification here. But
> if an AP may include the field in an ML Probe Response, then we
> obviously cannot rely on the value to be consistent.
>=20
> Seems to me that the option to remove the check is still the best way
> forward right now.

Agree, let's just remove it - Lingbo do you want to send a patch?

We should probably compare "extended MLD capabilities and ops" though,
haha.

johannes

