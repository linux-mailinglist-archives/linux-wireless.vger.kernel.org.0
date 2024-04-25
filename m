Return-Path: <linux-wireless+bounces-6876-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D017D8B29FE
	for <lists+linux-wireless@lfdr.de>; Thu, 25 Apr 2024 22:38:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B6EB7B224CD
	for <lists+linux-wireless@lfdr.de>; Thu, 25 Apr 2024 20:38:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E469A39847;
	Thu, 25 Apr 2024 20:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="sGtivDMC"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 016972E642
	for <linux-wireless@vger.kernel.org>; Thu, 25 Apr 2024 20:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714077494; cv=none; b=QJ9zm2Uhc7/hGYqGheaaOvmCwcHlNTYzOoVmhhicLcbRkgJPCKcsGbhFf/66OJhoLuvdd96yi1CqlsHAyCk2jUg39tAEiPWUDpaKyFizI866ZcoOP91WdnvoiviLTyX36JML5KaGBeqIImQUsc9kyRPT4gCvIL8GRFBPkcv2CNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714077494; c=relaxed/simple;
	bh=tukXefnXgrYi4DFy/pd/jhDD2LCZPtue1afxoaK8+70=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=rqyas7pzUF9xkMk8ieESdyPfI8JXNETMcNiMCZY6IA2QubUt/AJ1jeyB/kF5vgHcNkaxCXpl19linjes9aBSqkwg+/d6da+RaAfMLbAJxOng/RBgGwUawSpy29wRe92WztoWKlbGDF9HK62hKiAzxzCVYihEPH4diUTg6obDL/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=sGtivDMC; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:To:From:Subject:Message-ID:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=tukXefnXgrYi4DFy/pd/jhDD2LCZPtue1afxoaK8+70=;
	t=1714077492; x=1715287092; b=sGtivDMCZU5UTo33YR53s/b2yzpuTfuXJmP44qRn2gCLRIp
	HptojeoGgIT/b7iUwYMuF6CLM3BLAHuY+pBxNk9bOd1KTVBghqMEeG7ydPa+kb4rhDvQ6XJIAaob2
	xavijmZ09GClcBRtYxEVuP068ECGN91NYuk6RkfTi4k5QcQQQFyUacHvYvirZQYnQseeVDODWtZjr
	zptLgGfAKycr2FN6Hsb0OjqmmqXC7rqTpqhvfJA73sFZxIOa97kldR2PgzGELks5BhVSEyvstrC0z
	VPDHbXZZcdBDZd1+XLlubGUoTj9NiyPpfVJkKTKdt1T0NsNHMYghcld3P7MMnHTw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1s05r1-00000005b46-2hyP;
	Thu, 25 Apr 2024 22:38:03 +0200
Message-ID: <0309b10ba482db1e89a6ae05c897b6e58d262b8a.camel@sipsolutions.net>
Subject: Re: [PATCH] wifi: iwlwifi:  Use request_module_nowait
From: Johannes Berg <johannes@sipsolutions.net>
To: greearb@candelatech.com, linux-wireless@vger.kernel.org
Date: Thu, 25 Apr 2024 22:38:02 +0200
In-Reply-To: <20240424174748.957641-1-greearb@candelatech.com>
References: <20240424174748.957641-1-greearb@candelatech.com>
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

On Wed, 2024-04-24 at 10:47 -0700, greearb@candelatech.com wrote:
> From: Ben Greear <greearb@candelatech.com>
>=20
> This appears to work around a deadlock regression that came in
> with the LED merge in 6.9.
>=20
> The deadlock happens on my system with 24 iwlwifi radios, so maybe
> it something like all worker threads are busy and some work that needs
> to complete cannot complete.
>=20
> For reference, see mail to lkml with subject
> "6.9.0-rc2+ kernel hangs on boot (bisected, maybe LED related)"

You should use a Link: tag with a lore link for that :)

> Fixes: f5c31bcf604d ("Merge tag 'leds-next-6.9' of git://git.kernel.org/p=
ub/scm/linux/kernel/git/lee/leds")
>=20
> Signed-off-by: Ben Greear <greearb@candelatech.com>

And no blank lines between tags, please.

johannes


