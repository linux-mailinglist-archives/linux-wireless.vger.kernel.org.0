Return-Path: <linux-wireless+bounces-23172-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B13F2ABD21B
	for <lists+linux-wireless@lfdr.de>; Tue, 20 May 2025 10:36:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 994C97AC419
	for <lists+linux-wireless@lfdr.de>; Tue, 20 May 2025 08:35:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A424212FB7;
	Tue, 20 May 2025 08:36:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="Ku+Eph+9"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A179021CC48
	for <linux-wireless@vger.kernel.org>; Tue, 20 May 2025 08:36:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747730205; cv=none; b=R99LEvMsG8vrdgkKsK/lLoBbgjUgU66BfnHVlbcjhl57S76z6NVR/MbMu7xgdujxjtCgMum0MLg4ceQ0pCsferTcydE9+OgmemzBXDRpZkiuGi3MIxBGMYi+gTKIdVXn/idik/QBEDZHrX7qfdSuUGcSH6gUmtGBzpVfCfSYiwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747730205; c=relaxed/simple;
	bh=MZPvg3Ynji32q0uvpW3ijSSgKiUOG0VLcPxeyEXy4d4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=B66QWQArkvx3vsOoFlLeEWVhOWAzfABPVm8YUDYHDD3bbIOfWykGkl9lNbqXrjLnGr10m8/tcsPXUODa5Okrkhrhi9mQj4ODTrKLnQwHUjOpodOusLETCslzQkk+scy1n7b0xSCIxwShg/T8U4WjQHyBhATCMoL22+0PZ2iWBeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=Ku+Eph+9; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=keV/abDRj4pAIs66OLto54KFFMfQz8LZm9zTGohMrbQ=;
	t=1747730203; x=1748939803; b=Ku+Eph+9Dm6yV5U0KecV1Oyie9xtrJHiYS5LxnbI+VAQVqr
	tcHeAba765RYd6See75MDY7Ps7ou4bz2YUaPI4wNGT6NPp3SqQQU0ZPOTLTntOqStBKfCA0iDZlHE
	yrkalprjNJlY/KJI5dWTBOGLi6s2uvscEcSIzjZ4pOmaNXaaklP9ER+VmgyMvRJZjoYL66WvzUNZt
	4mSYIUIWnzoWPCWDopHemAS4UVE8a2gIdQSM43Wb9i8uDR2V37sdCo3qXHOwQH7q345K61dSm7McY
	8F/bFxcb+RQoJB4/NzRisjkwMXhDAiSSVtFDkUaCk5ADViD/1/lT4/AkEnu4oQZA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1uHISe-0000000Ap74-1t16;
	Tue, 20 May 2025 10:36:32 +0200
Message-ID: <ff2c4100a53e14c0e7c226b4d20f11a72fca3308.camel@sipsolutions.net>
Subject: Re: [PATCH wireless-next v8 03/10] wifi: cfg80211: extend to embed
 link level statistics in NL message
From: Johannes Berg <johannes@sipsolutions.net>
To: Sarika Sharma <quic_sarishar@quicinc.com>
Cc: linux-wireless@vger.kernel.org
Date: Tue, 20 May 2025 10:36:31 +0200
In-Reply-To: <999eb0ee-f49b-4ea8-93e6-78e3c2fe5e8c@quicinc.com>
References: <20250515054904.1214096-1-quic_sarishar@quicinc.com>
	 <20250515054904.1214096-4-quic_sarishar@quicinc.com>
	 <16406ee04378160b2f9cc8f4ff5a233c45be2e94.camel@sipsolutions.net>
	 <999eb0ee-f49b-4ea8-93e6-78e3c2fe5e8c@quicinc.com>
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

On Thu, 2025-05-15 at 22:28 +0530, Sarika Sharma wrote:
>=20
> Yes, this is needed when we don't really want to report the pertid at=20
> MLO level( as currently pertid is one of links data(deflink) for MLO).

I'm not sure it makes sense at all. Why would we have mac80211 provide
some data that we then discard immediately? Maybe we can

 if (WARN_ON(pertid_data)) {
    kfree(pertid_data);
    pertid_data =3D NULL;
 }

for userspace consistency, but I think we should really avoid doing work
to create data that doesn't make sense and isn't needed.

johannes


