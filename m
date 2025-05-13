Return-Path: <linux-wireless+bounces-22925-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DDA9EAB5B8F
	for <lists+linux-wireless@lfdr.de>; Tue, 13 May 2025 19:46:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 878F71B45B6A
	for <lists+linux-wireless@lfdr.de>; Tue, 13 May 2025 17:46:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4597189912;
	Tue, 13 May 2025 17:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="T6j7EKUH"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 470CD1531D5;
	Tue, 13 May 2025 17:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747158359; cv=none; b=DR3uOY3aXNrg3w8UVGqZbOY/Yfo3E3Nz2cNtG9aTTXtwhsMVo7/guLe91qDVrnTg6KTXnC7kpRXlKj57CZbYYvTjQt4HmwIANmu37ikiIa5sw7TfD+KcMzbZsumznurqB7c88xe0VIDzn1l6AeOwBMRgJQeF3B0IiuCE65KMljs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747158359; c=relaxed/simple;
	bh=1XOQTp+0YYkOZ5SBuurGRq6gH8ETScAcs52cc9KyQIY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=UncwF8ZvQ29ZjJM/sSjs7dCiVOz+8YHGZ59D3oQcQOD/OqCRqCkO+lkHpA7xVRYelQs5yVog21qUCG9ucz7mjnH2dYYn0wV31c/r5IBH2yJICxTDIdk5qIgSy2xicqLVeD53TlZOk1HVXIWTpNMnD3bZnPEmynjYuWlZuT7UqVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=T6j7EKUH; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=1XOQTp+0YYkOZ5SBuurGRq6gH8ETScAcs52cc9KyQIY=;
	t=1747158358; x=1748367958; b=T6j7EKUHEUWvLKv4gm1iZW3Vm1IVXjeHvFZfRY/spVKViGj
	EqyTNTyKeHZFzPFDOeAtJHfVt/urOKqklRrb3KdLADzBd/Rk/o3tXUrPmkknFJ1Vgn6ceVmQOIU6N
	J/G9qc9eYNdOTSx4wjqY9ixqzRf6/rUjwZEbHfnDjcXpTNPqejCDfuIjDuVx6cBXQQA4YvfngnxyE
	SsK1i75BB7eLeO0Z+O+gepK2r5birf/MUFKywYIOodWuvi8nelFGPQIkd98aHVuhp/CdojZRkt9Qq
	8t0ry+3oMbBa5IfbcFCY26iRb5w5yBCEfWsKd+ztV8TaOY0kz/iQDvbGzq1/TrJA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.1)
	(envelope-from <johannes@sipsolutions.net>)
	id 1uEthN-000000067w7-0NQN;
	Tue, 13 May 2025 19:45:50 +0200
Message-ID: <1a6ee5fb05b32e290fc45e66af4b7dc719f06ed8.camel@sipsolutions.net>
Subject: Re: wifi: iwlwifi: SAE fails when AP sends confirm before STA
From: Johannes Berg <johannes@sipsolutions.net>
To: Jan Hendrik Farr <kernel@jfarr.cc>
Cc: James Prestwood <prestwoj@gmail.com>, linux-wireless@vger.kernel.org, 
 Miri Korenblit <miriam.rachel.korenblit@intel.com>, iwd@lists.linux.dev,
 Denis Kenzior <denkenz@gmail.com>
Date: Tue, 13 May 2025 19:45:45 +0200
In-Reply-To: <aCODE231NMCQ48xu@archlinux>
References: <aB4HC8Iaa6wR5dj7@archlinux>
	 <15943a1f-0e5d-4705-b8ef-3f22fa3fe672@gmail.com>
	 <aB4hMsBfyawYatoj@archlinux>
	 <902daf8802c723d72fff0155cd0638848ce1bc7f.camel@sipsolutions.net>
	 <aB5onavenLymR-QJ@archlinux>
	 <8a1c5172bc0fd9d2a33522294d1a2a4c4ceb313a.camel@sipsolutions.net>
	 <aCMtCCYtNNl4dL5Q@archlinux>
	 <e1b26ee842bc60cfa939874f467a03531871807e.camel@sipsolutions.net>
	 <aCN0Tjwu-yS2mzi_@archlinux>
	 <047456d40bc42248a6ba1b76d630d5d82b857bf1.camel@sipsolutions.net>
	 <aCODE231NMCQ48xu@archlinux>
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

On Tue, 2025-05-13 at 19:36 +0200, Jan Hendrik Farr wrote:
> >=20
> > Hm. Yeah, I missed the second path that goes there in this case ...
> >=20
> > https://p.sipsolutions.net/0c145f72fdec3cf5.txt
>=20
> This work!
>=20
> Interestingly though, now the order is always:
> 1. client commit
> 2. AP commit
> 3. client confirm
> 4. AP confirm
>=20
> It is now only ~5.3 ms between AP commit and client confirm vs
> ~21.2 ms before.
>=20
> Do you have an explanation why this patch would change the timing?

Probably scheduling delay in the firmware. Before, to send the second
frame, the client would have create a new schedule and airtime
allocation in the firmware. Now it just keeps the old one so doesn't
have to.

> So this test doesn't proof that it would work with the order the other wa=
y
> around. Maybe I should try making iwd sleep while generating the commit.

I guess you could, right.

johannes

