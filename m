Return-Path: <linux-wireless+bounces-3275-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2849B84C5E4
	for <lists+linux-wireless@lfdr.de>; Wed,  7 Feb 2024 08:58:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 595311C20F4B
	for <lists+linux-wireless@lfdr.de>; Wed,  7 Feb 2024 07:58:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18E42200AE;
	Wed,  7 Feb 2024 07:58:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="LJRmEfpY"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6DD71F958
	for <linux-wireless@vger.kernel.org>; Wed,  7 Feb 2024 07:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707292722; cv=none; b=cNl4gO/AixDB0kOo9qOoppOIjM/2Ml/1aLkKmenM+5cSCNTunlKtf67mVowRWb1x3xp7kCU/6eca9HGqmFPA/JQaDZSVM0H0iBAyemNTDOKojK6RK/mAAhQ/9FcwokgB0hrzZGc/QipEkzoaHpk5ICzq6yVjVQ3PUrvF4rmrt+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707292722; c=relaxed/simple;
	bh=YtqAbPVWmPXLGPgC1Qk/vzSJnpj9T9IFhd8HgU72vjc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Ii2IbbGAIb3pJKps3/TjgW7Ry8xU8Za7Ozsa4OqrrQ/Z4fhp9OEeeqqop/hq4YyXmiNwmz37Bb9MM2VMsJLD7Zf6ReHU3ezCVZvdtkhkn6yh9U2nAmMxJ6SywjKXhVYkOPBNAo87RfXiCQORX53ZfG6xRuHKV2cWXKRM8NgQWD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=LJRmEfpY; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=YtqAbPVWmPXLGPgC1Qk/vzSJnpj9T9IFhd8HgU72vjc=;
	t=1707292718; x=1708502318; b=LJRmEfpYbYNWNOvTQ8hZuFDH41uk9CVnUwv3Q4gnKnGDhX6
	5J0IEbEpPw1xfAzszxoxFEWPjTjHJCoN9TmOHtajpeH0Ksjj3wf4LIL5j16QINaATpG1oqM+HEITn
	Jr5semY3dnzag2cDrwTXEn/AIuPKjgquOS4p44g6TR/FDN8aGYxevssOKpDh5aqOcudG5FzVs+Y3o
	qMuX+YPRZWh/3jmfVBTPcI3DFBmso19v9XsfzPWZRWD2eSV0hXgpeS3OTwk6TZYtiGoA58fbZ4FZZ
	zviv2mX3JCSQ6jBzaWCVPrHvPpw79g8CpEiC7IB1QKbDucOI6LXO99v/Gii7CDYg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1rXcpH-0000000Fnus-0KYA;
	Wed, 07 Feb 2024 08:58:35 +0100
Message-ID: <240506b19c6671cfce2587f4c1152359066146c7.camel@sipsolutions.net>
Subject: Re: wireless-regdb key change broke crda tests after 37dcea0e6e5
From: Johannes Berg <johannes@sipsolutions.net>
To: Sergei Trofimovich <slyich@gmail.com>
Cc: linux-wireless@vger.kernel.org, wireless-regdb@lists.infradead.org, 
	Chen-Yu Tsai <wens@kernel.org>, Seth Forshee <sforshee@kernel.org>
Date: Wed, 07 Feb 2024 08:58:34 +0100
In-Reply-To: <20240206222757.238a24f8@nz.home>
References: <ZcIXGjzrZrXPCBcp@nz.home>
	 <455bafff0d609eb182ba30a5fbf319888e0e961d.camel@sipsolutions.net>
	 <20240206222757.238a24f8@nz.home>
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

On Tue, 2024-02-06 at 22:27 +0000, Sergei Trofimovich wrote:
>=20
> Great point! `nixpkgs` uses `crda` only as a `hostapd` depend and
> looking at modern `hostapd` it does not use it at all. I'll spend some
> time removing it downstream. Thank you!

Note that hostapd never directly depended on crda, it just needs/wants
it to have the correct regulatory information in the kernel (crda puts
it there) after switching the country (hostapd can do that if possible)
and then hostapd retrieves the information.

But in any case, the whole step with crda is no longer needed if you
have the regulatory file (and possibly signature) in place, the firmware
will load them as firmware files.

johannes

