Return-Path: <linux-wireless+bounces-22923-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E99BAB5AC2
	for <lists+linux-wireless@lfdr.de>; Tue, 13 May 2025 19:07:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3604517692D
	for <lists+linux-wireless@lfdr.de>; Tue, 13 May 2025 17:07:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A101C24E01D;
	Tue, 13 May 2025 17:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="l/Zr46Af"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC8EC28D8CE;
	Tue, 13 May 2025 17:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747156056; cv=none; b=jeQcFQ1lvQ9MnhIVe5fiYFttT8gSESCH7fTLV/rSdxlLCDft/00d64lrwyD7e+ylVETm+K/dNouza71A11FL2kebbblcgBYunDsudbc4iVyGXACKrAakJjNOkaNdbKDSk3ROjkpw0l9ZRXgnuSjiU1VpxV6NU9F6luOF4RFr9rY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747156056; c=relaxed/simple;
	bh=vDUZjWeWHLqCetWnREWRg5lhCR+xRx+vJP0hH5NNni4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=YTyuQepmGnDDK1SZTU+aLawpVrL8vvNeQWKfuLgbZE9TuCTeQu9U2ze6HSEvi+QrFp4ufyzo0PMxJ3Znk7u/mpiRoQNd2WoD/pxwdxaKYpVwar/K8k05/Fo50w2vhclINFEfV3gRBtRHH6LbDY/o1HQU02kWxAsIKrybB2Un7qc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=l/Zr46Af; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=vDUZjWeWHLqCetWnREWRg5lhCR+xRx+vJP0hH5NNni4=;
	t=1747156055; x=1748365655; b=l/Zr46Af9V5xnHSRPpy8FH62wj5SAd+bD4MoLQSTmTAAioS
	P6bKZBJRolSYVwNiMjtECrUAgjCc7cefxo78Zlq+9Op4p2g0qK9NBOstCkI0ALmQBIqXdBzObAkWY
	/DHuop4CAnr5Ogfb58vTwHGGynoI5JWCxDS1JKmM6mImEL7TPLqu00XTr2JryiBindiuTodCk0kMf
	ah47bEX231fNg+jJHcb3YhuHp0i0r0QxyxDo6ACxb8QNN8Akm2olxH/MO3/49qqn/17kp+coMT+Ut
	FdLZChtbyD0FI9e4bpFIZaMlkH1RemZGSWFFpWEGfHQT1EleSY0pHeAOW+9hiEcA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.1)
	(envelope-from <johannes@sipsolutions.net>)
	id 1uEt6J-000000063UD-1Vlv;
	Tue, 13 May 2025 19:07:31 +0200
Message-ID: <047456d40bc42248a6ba1b76d630d5d82b857bf1.camel@sipsolutions.net>
Subject: Re: wifi: iwlwifi: SAE fails when AP sends confirm before STA
From: Johannes Berg <johannes@sipsolutions.net>
To: Jan Hendrik Farr <kernel@jfarr.cc>
Cc: James Prestwood <prestwoj@gmail.com>, linux-wireless@vger.kernel.org, 
 Miri Korenblit <miriam.rachel.korenblit@intel.com>, iwd@lists.linux.dev,
 Denis Kenzior <denkenz@gmail.com>
Date: Tue, 13 May 2025 19:07:30 +0200
In-Reply-To: <aCN0Tjwu-yS2mzi_@archlinux>
References: <aB30Ea2kRG24LINR@archlinux>
	 <4ffbeb94-ac19-4437-9d98-24981fe6c240@gmail.com>
	 <aB4HC8Iaa6wR5dj7@archlinux>
	 <15943a1f-0e5d-4705-b8ef-3f22fa3fe672@gmail.com>
	 <aB4hMsBfyawYatoj@archlinux>
	 <902daf8802c723d72fff0155cd0638848ce1bc7f.camel@sipsolutions.net>
	 <aB5onavenLymR-QJ@archlinux>
	 <8a1c5172bc0fd9d2a33522294d1a2a4c4ceb313a.camel@sipsolutions.net>
	 <aCMtCCYtNNl4dL5Q@archlinux>
	 <e1b26ee842bc60cfa939874f467a03531871807e.camel@sipsolutions.net>
	 <aCN0Tjwu-yS2mzi_@archlinux>
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

On Tue, 2025-05-13 at 18:33 +0200, Jan Hendrik Farr wrote:
> > I don't think this is really the right fix, but it might help:
> > https://p.sipsolutions.net/e852565303ad878b.txt
>=20
> Unfortunately this does not fix it.
>=20
> Attached another capture (and trace, etc)=20

Hm. Yeah, I missed the second path that goes there in this case ...

https://p.sipsolutions.net/0c145f72fdec3cf5.txt

johannes

