Return-Path: <linux-wireless+bounces-6602-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EAF58ABBD5
	for <lists+linux-wireless@lfdr.de>; Sat, 20 Apr 2024 15:45:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AC6F6B20E3A
	for <lists+linux-wireless@lfdr.de>; Sat, 20 Apr 2024 13:45:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6778D1805E;
	Sat, 20 Apr 2024 13:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="jzaP9wIO"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B7EE17C72
	for <linux-wireless@vger.kernel.org>; Sat, 20 Apr 2024 13:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713620703; cv=none; b=NunO/i3/a2qvScJPKqINdBedZKAiaU6Sefs5EoRVu3rJgk9FRt3Ap1JYKHmOiov+J/LM6CQwfVb6Tpa/mLIL/vswyT0njDvZSyRspnrTX/m8PMchB7TokVnpL3ftEQx1gj5bNFDYtDPBsBSRLNp5u1bzf4d1T3KO1K6XO4RRiYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713620703; c=relaxed/simple;
	bh=zdm9KRduGP4P/it+k99aheBqGjEloiRzkkcDe9PwGtA=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Jj8JrEXDXaLm7R+1cHgBAHU0rE9aPdHZa5JvWyMDyx/tGvQ9z9C1aqi1lu/Bq7BK+ya5bCtmf4VVfghMsfEdNzNoo2oQGGH/F7hCvrKMtdPLKiiVJXpvh4FJFM7ZaZj4lrtgcWcV3G1uLjqjrlUmiHbR+hOQE8gVaV2RecE78CY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=jzaP9wIO; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:To:From:Subject:Message-ID:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=zdm9KRduGP4P/it+k99aheBqGjEloiRzkkcDe9PwGtA=;
	t=1713620701; x=1714830301; b=jzaP9wIOuOv4reaOCWTeCNujw0Lf46fFCONZ54VPTBLHENx
	+PQ0FR+zbAAWxeJ3IutAmanNS5Z9UCTWzE8xH11Ki32m7BPiMSzbthrguz2j2T6AmG6l8C4/h3agd
	7qlaa7AGuOtGGjo1021vL5S6RpRcxSAXjxbZCylvSaJq7dJbFfGfKSKArENOC1lZ7UJ7I5Czl6nG+
	d34QZZzAdsNb4oi2pxAtkT4cmPh5AOtmVJt9+2iDySaUw3fNc9cT7o5iGVQOn+xDb1BXcatLI/7vb
	ZsrJ4yGsLOisU/2MV9vSOMWo8/bVtBq46+dFnYoMVUNYlf8fXtbApDdL0CVoAQNQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1ryB1W-0000000FlNp-2029;
	Sat, 20 Apr 2024 15:44:58 +0200
Message-ID: <8fe50dcfc5159994c5976a406e27bb1df03ca0fb.camel@sipsolutions.net>
Subject: Re: 6.9 iwlwifi regression: Thinkpad 480 no Wifi
From: Johannes Berg <johannes@sipsolutions.net>
To: Stefan Seyfried <stefan.seyfried@googlemail.com>, 
	linux-wireless@vger.kernel.org
Date: Sat, 20 Apr 2024 15:44:57 +0200
In-Reply-To: <8c3f3a43-ac65-4bd1-9563-cb8d9192b0ce@message-id.googlemail.com>
References: <8c3f3a43-ac65-4bd1-9563-cb8d9192b0ce@message-id.googlemail.com>
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

On Sat, 2024-04-20 at 09:44 +0200, Stefan Seyfried wrote:
> Hello,
>=20
> I'm running a Thinkpad T480, lspci reports
> 03:00.0 0280: 8086:24fd (rev 78)
> Network controller: Intel Corporation Wireless 8265 / 8275 (rev 78)
> Subsystem: Intel Corporation Dual Band Wireless-AC 8265 [Windstorm Peak]
>=20
> Using 6.8 kernels, everything is fine (the first kernel I ever used on=
=20
> this machine was 6.8.1 from openSUSE Tumbleweed).
>=20
> Since 6.9-rc1 (using precompiled SUSE Kernel-of-the-day), wireless just=
=20
> does not work.
>=20
> Nothing suspicious in dmesg, NetworkManager does nothing and a manual
>=20
> mixi:~ # ip link set up dev wlp3s0
> RTNETLINK answers: Invalid argument

I think you may need this fix:

https://lore.kernel.org/r/20240420154435.dce72db5d5e3.Ic40b454b24f1c7b380a1=
eedf67455d9cf2f58541@changeid

johannes

