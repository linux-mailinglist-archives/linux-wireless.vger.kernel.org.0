Return-Path: <linux-wireless+bounces-14767-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C3D99B76EB
	for <lists+linux-wireless@lfdr.de>; Thu, 31 Oct 2024 09:57:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 27C55B211AA
	for <lists+linux-wireless@lfdr.de>; Thu, 31 Oct 2024 08:57:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98C871865E5;
	Thu, 31 Oct 2024 08:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="Nj30kEgX"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C4D2153836;
	Thu, 31 Oct 2024 08:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730365059; cv=none; b=Rbiba82ejaLIptov7M0aI6g0KBFTwQZ0hjQKOYjcc+R0qDBcgOiTY5fmPCXgEjDS4dkROU7Sec8/Ce9Bqi1Xf6NfUwBvmp+NUQPOSqImIz4+j4eWXLKSSPFkTgPNsNgGHdDWnJAQvQm+9WxGPnO8fbdxRMiNTpf/+Vf9Dae6JBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730365059; c=relaxed/simple;
	bh=Twx6Crm80z64xzTeY2/dQLvMK9L9SpCg8NqAAwAtz5A=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=PB7xu75V0svY3BLidPItX5/cdimpoedurIlyvz+75rD7xSrivhmA6aDMdBodI1BKGNfx4gwkZfxeFRTZGFg3zA/TCXO2cep3UWucDBP0OlSO+Mtjo+is7TySLnyPDbpIZAGnAW+B8JGq9QmmZxHEtEZo5pemhFPnoIUUCXUMmNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=Nj30kEgX; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=Twx6Crm80z64xzTeY2/dQLvMK9L9SpCg8NqAAwAtz5A=;
	t=1730365057; x=1731574657; b=Nj30kEgXbesWsWEamPX3+aUVP0HoT16vD0kofdkXWT+8Vkt
	t8rfsG0LME/vmjwZThzp6VICoaeVuI2Nu5bFkBrqpcydQ/eqvSctvVNIN6heGOnXcRa/R0NxvPb+I
	e4NxN6dfX1erw6TvvJrSo/27W7QGDuUgTNLQaLzHp9VYoQdbAbtfkwH5b8t5b4mYVpSUZIB3kBCmq
	WavMULykMWmEKbObseHKmo6S6pQluqVA6UgT1Us8JOzC93PSLdLeg1qZfabD7vsiKykd4c2HWln2t
	SKM35pyikuKosORYTlFzcO1b11RPgLCVh0CAjnuYJd2t1JwKQ0yWsoc4qsbdr7yw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98)
	(envelope-from <johannes@sipsolutions.net>)
	id 1t6Qzm-0000000AMpa-1K7e;
	Thu, 31 Oct 2024 09:57:34 +0100
Message-ID: <5fc092da11b3d81c99fc4bc4b78e87783280414f.camel@sipsolutions.net>
Subject: Re: Issue with iwlwifi Firmware Loading When Compiled into the
 Kernel
From: Johannes Berg <johannes@sipsolutions.net>
To: Gang Yan <gang_yan@foxmail.com>, "miriam.rachel.korenblit"
	 <miriam.rachel.korenblit@intel.com>, kvalo <kvalo@kernel.org>
Cc: linux-wireless <linux-wireless@vger.kernel.org>, linux-kernel
	 <linux-kernel@vger.kernel.org>
Date: Thu, 31 Oct 2024 09:57:33 +0100
In-Reply-To: <tencent_7DC9187727BD32FEEC99045E754751A0CA08@qq.com>
References: <tencent_2C31282B61589DFCC908B3831384D569440A@qq.com>
	 <7100cb98b8e46793cfb1197c3af0f151a9628c9d.camel@sipsolutions.net>
	 <tencent_7DC9187727BD32FEEC99045E754751A0CA08@qq.com>
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

On Thu, 2024-10-31 at 16:52 +0800, Gang Yan wrote:
>=20
> In fact, I'm using Ubuntu's userspace, but I've simply replaced Ubuntu's=
=20
> kernel with the mainline 6.12.rc2 version (x86_64_defconfig). By merely=
=20
> changing CONFIG_IWLWIFI from 'm' to 'y', the network functionality normal=
ized,=20
> which is inevitably confusing. By the way, both of my computers encounter=
ed=20
> this issue, with network devices being Intel Wireless 8265 and Intel AX21=
0, respectively.=20

Yeah well, so Ubuntu integrated everything in a certain way, and because
they build everything as modules they didn't integrated anything to make
it possible to build modules in the kernel.

When you change it, you own the integration. I gave you a few ways to
solve this, simplest is just specifying the firmware to build into the
kernel in the .config file.

> I still think some clarification will be helpful to make the configuratio=
n process
> here clearer.

I don't think we need to change anything. Whoever makes some changes to
a distro needs to actually do the integration too. This is in no way
specific to iwlwifi, every other devices with firmware has the problem,
and generic ways of fixing it already exist.

johannes

