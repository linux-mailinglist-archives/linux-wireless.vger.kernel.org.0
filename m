Return-Path: <linux-wireless+bounces-22122-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AEE4A9E9C2
	for <lists+linux-wireless@lfdr.de>; Mon, 28 Apr 2025 09:43:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3029C3A7C47
	for <lists+linux-wireless@lfdr.de>; Mon, 28 Apr 2025 07:42:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D1B51DF269;
	Mon, 28 Apr 2025 07:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="lHHFeouu"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C94A11CEADB
	for <linux-wireless@vger.kernel.org>; Mon, 28 Apr 2025 07:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745826174; cv=none; b=O6puSt+yNKB3k+u6TUI1mosoDMF4jsftT8Gxm8khUUX16RudYHR9b7T1Pu5wkY18HiBxkjnFMCm2TXcOIZns1Y2su+Tv6miLeb9Z1FUzkv9TnaQvurdrKW17vNndqR1Wzy2jmID7P0J1/KH47jF0KxwgIl5wvX/f5nGD5I+Najc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745826174; c=relaxed/simple;
	bh=MJK9I8MvsSH4dKJHVdI+L2JrqDCgU1QxPdnVNZQQQaM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=FW3BpF1ALkAdg3t3/TTX4bNgWCnl8v7+NmhYFDn9Nw0qKCkzQn/9Z+03Q8xzgcqEHVMHhvODT18g4HUQiZf9kjJv0FVvtxB4rR/mNgkERCjB50WvKFDUffe8GZXigy2dReIx91e3KmHjc2r8KHPBZVSR2SM1VUydUvvkWCfgjK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=lHHFeouu; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=2oyFGmXRU1cCsuFwlBHZe4K87fNRW2hpX7dOil9A0Nc=;
	t=1745826172; x=1747035772; b=lHHFeouu9e6hgp04yzta5VvDRYGldoYvvjKVfI1qAH11EjK
	bEfC7e5d0OoDx5pSChINMGzjRgeAMvetvofGICIg9OynNivxki6560TsAoUkBxORonc4j+3Crxcdb
	Q7bwdC0dVSIpjSRb/LgegWuaxwGGVjPCiR12VZp6eps11WDFVdBAmIfOHoHTrkmK7NUnQSOWnRuMf
	JD43tfYypp+DXy1Frv6ojb66AYTAnkPwESL9c/Ck9fahd3si76rMpujZdA6mZptj46/arBPdEGlLj
	ucRT5E9LOK1Fyx3zxmLzoZai9qSRsqwqEpP5Lb++fijMRpFFAGMeGANdEJcuO40A==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.1)
	(envelope-from <johannes@sipsolutions.net>)
	id 1u9J8c-0000000982D-0vA4;
	Mon, 28 Apr 2025 09:42:50 +0200
Message-ID: <74a0d439400875847dc3b07003faeec6be4cef3d.camel@sipsolutions.net>
Subject: Re: [PATCH iw] iw: print HE mcs correctly when mcs_len
From: Johannes Berg <johannes@sipsolutions.net>
To: Janusz Dziedzic <janusz.dziedzic@gmail.com>
Cc: linux-wireless@vger.kernel.org
Date: Mon, 28 Apr 2025 09:42:49 +0200
In-Reply-To: <CAFED-jmCc6JZhxBPUNSHoYiaXN0pNPwvSyeGf4qHzUdAQAHHAg@mail.gmail.com>
References: <20250413160455.158335-1-janusz.dziedzic@gmail.com>
	 <0c995a29d73a99084add34ef2b56b0fe673578c4.camel@sipsolutions.net>
	 <5872dd78f2f947b27f3851e3f425677a2ddcf6d4.camel@sipsolutions.net>
	 <CAFED-jmCc6JZhxBPUNSHoYiaXN0pNPwvSyeGf4qHzUdAQAHHAg@mail.gmail.com>
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

On Sat, 2025-04-26 at 22:26 +0200, Janusz Dziedzic wrote:
> > In some way though this also means your kernel patch _did_ introduce a
> > userspace regression, so I'm not entirely sure why we should do it at
> > all?
> >=20
> I think
>  - only HE report wrong MCS/PPE len - EHT report it correctly

Yeah that's unfortunate.

>  - only bug in iw, hostapd recalc it based on HE capab
>  - looks odd to skip kernel patch only due to some user mode app bug
>=20

That's ... what happens? That's how "don't break userspace" works :)

So I think we should just leave it. We can take it as a historical quirk
and try to do better in the future (as we already did for EHT), but I
don't see value in breaking iw for such a thing.

johannes

