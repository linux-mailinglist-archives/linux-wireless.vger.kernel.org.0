Return-Path: <linux-wireless+bounces-8792-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 44995903C8D
	for <lists+linux-wireless@lfdr.de>; Tue, 11 Jun 2024 14:58:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D6FC928262B
	for <lists+linux-wireless@lfdr.de>; Tue, 11 Jun 2024 12:58:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFD3A17BB1B;
	Tue, 11 Jun 2024 12:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="jP4KDBWo"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DF9817A931
	for <linux-wireless@vger.kernel.org>; Tue, 11 Jun 2024 12:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718110729; cv=none; b=KhdMwX1o0hRBVvDZQi6x6FDcp2aQ+vWHtxXaLszgXfamna1GR84jCIwB77IUw/VNWDxNovcCBsiS/kOL5+yVi/OG9lF++Va3Ur9musiswm6hVCGLdhWQmUiniDHHtsGJ/xuTm36oVtnXH3XcALgt/2yuQVOt1mdUrS62gETbGwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718110729; c=relaxed/simple;
	bh=u9qWm6HZOQIGaDIV3D+ojbtCr+odb7QangR7mwVp4SE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qnokavlRIe8qlFs1wfuafmGXTksipMpl5H974exOx23QUVbrhzby9g7IG4WfUfBpdWpitSjabi9pHqHtFqALxKbQOMlLeFi3dmVlMaxeQRu8y/2vcMbjsZIbK0zgR2IWFUszXCCJeTOSzdF+6WnNO1FgnEKOvpO5pVFuf0E0zQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=jP4KDBWo; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=u9qWm6HZOQIGaDIV3D+ojbtCr+odb7QangR7mwVp4SE=;
	t=1718110728; x=1719320328; b=jP4KDBWoz3ebhq+bgDtjORqb/kGEbhKG+6YsnAye0SKShf3
	7jI29qncgkAWG14U1OFR5KPoS4a/JZaX9IaRZrMPd740G8MjgjWVy2EYYagn9C45tatPAnWiHtTd0
	yFPha6kdxtkqCkTjbBJXAvDsKU2fMWaIL9m3GtLrj9Awb5HbHKc7/57kIWjluZsqNMEtv0zced4cj
	hr1Yqyp9t5eLqvyCES7QlLArYW8SDv/anCOasTaVFDZlB6xoEooQDbqbhLXNS4LDU7Crm1kVEOQO5
	JODWINO9lwoudElI+v1V7bcWnJD04Y2DLwtVewmiGuwGCBHMF9nk3CIxij4ADnIQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1sH15I-00000008dLw-2nUC;
	Tue, 11 Jun 2024 14:58:44 +0200
Message-ID: <bf445f8aa320858124368a210b5cb86a9613b44b.camel@sipsolutions.net>
Subject: Re: wifi: mac80211: unencrypted message in 4-way handshake
From: Johannes Berg <johannes@sipsolutions.net>
To: "Sperling, Tobias" <Tobias.Sperling@Softing.com>, 
 "linux-wireless@vger.kernel.org"
	 <linux-wireless@vger.kernel.org>
Cc: "Le Suire, Michael" <Michael.Suire@Softing.com>, "pkshih@realtek.com"
	 <pkshih@realtek.com>
Date: Tue, 11 Jun 2024 14:58:44 +0200
In-Reply-To: <BE1P281MB242075CF50BF71257D14F955EFC72@BE1P281MB2420.DEUP281.PROD.OUTLOOK.COM>
References: 
	<BE1P281MB24208AB02DAEACAE9AF4B5C5EFC62@BE1P281MB2420.DEUP281.PROD.OUTLOOK.COM>
	 <BE1P281MB2420DA2C6AFF94E525306302EFC62@BE1P281MB2420.DEUP281.PROD.OUTLOOK.COM>
	 <6bdbcae5cfedccc507426bde60fe86e72212ca5a.camel@sipsolutions.net>
	 <BE1P281MB242075CF50BF71257D14F955EFC72@BE1P281MB2420.DEUP281.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.2 (3.52.2-1.fc40) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Tue, 2024-06-11 at 12:36 +0000, Sperling, Tobias wrote:
> > > recently we moved from a 4.9 kernel to 5.4 kernel
> >=20
> > =F0=9F=A4=AF=EF=B8=8F
>=20
> :D
> >=20
> > > Do you have some hints where to look at to solve the issue?
> >=20
> > No, way too old.
>=20
> That's why we also tried it with kernel 6.6, where we faced the same issu=
e. So I'd
> appreciate hints for kernel 6.6 (or probably later), too. :)

Yeah but even moving 4.9->6.6 is a huge range, even bigger :)

> > Take a look at supplicant logs in how it behaves differently, I guess.
> >=20
> > The only thing that comes to mind is that *maybe* the eapol-over-nl8021=
1
> > path gets used (different kernels) and that has different behaviour in
> > wpa_s, but honestly, no idea.
>=20
> Thanks, will have a look there.

I would certainly hope that wpa_s uses that path on the new kernel. It
wasn't in 4.9, pretty sure.

johannes
>=20

