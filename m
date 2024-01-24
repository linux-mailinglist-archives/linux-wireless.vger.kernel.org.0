Return-Path: <linux-wireless+bounces-2454-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8025083B01F
	for <lists+linux-wireless@lfdr.de>; Wed, 24 Jan 2024 18:36:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 55EAAB32790
	for <lists+linux-wireless@lfdr.de>; Wed, 24 Jan 2024 17:34:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB2933D8E;
	Wed, 24 Jan 2024 17:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=egauge.net header.i=@egauge.net header.b="bpdncRGK"
X-Original-To: linux-wireless@vger.kernel.org
Received: from o1.ptr2625.egauge.net (o1.ptr2625.egauge.net [167.89.112.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B4A08613D
	for <linux-wireless@vger.kernel.org>; Wed, 24 Jan 2024 17:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=167.89.112.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706117521; cv=none; b=RXyQIYMxCHK7HzaFs+tCpf+e/h0uJOkk6lNJXAnkF9whtCe4zMQKgcAeSznGgZ4nB+MMm1NkHe2wPHRSArZCkZt8xCmSeXYRtTwLLrQWbx1GYDSdKXf89Bs2iIwSdotw5HOmVQNIOcFz7/pIYBF+Mt7YlXDVlyzUDE+USWMzsxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706117521; c=relaxed/simple;
	bh=AIeuOyM8TY6aXu3c6pbmcT5hK+Vl3uNIMcoEzHlfJhA=;
	h=Message-ID:Subject:From:Date:In-Reply-To:References:Content-Type:
	 MIME-Version:To:Cc; b=qWXRdhOXfzXCrbaUIhqZq56CLOAfH3oeEFaTQ4BQEqdp/JLN4WMn/ix9Pen7y78x8ZsYqOTey0pb+rtWfjUk1AF40j9SaKvmkEONInbrVwE8Y5fbqAanvCQk07GhZPR3iSGYOPnu1UddWMyKU4MRiawtzLqtPkgyM9KuAEhaAes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=egauge.net; spf=pass smtp.mailfrom=em1190.egauge.net; dkim=pass (2048-bit key) header.d=egauge.net header.i=@egauge.net header.b=bpdncRGK; arc=none smtp.client-ip=167.89.112.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=egauge.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=em1190.egauge.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=egauge.net;
	h=subject:from:in-reply-to:references:content-type:
	content-transfer-encoding:mime-version:to:cc:cc:content-type:from:subject:to;
	s=sgd; bh=yyJs6gKsIo+fb0cwkhjFc6Ot2H51UVOmkz/EFNiI6O8=;
	b=bpdncRGKmYyHdPI8yCn2PVKRYq921dIyxoX+1yoSmnejAMdKQWYlUAA1Ma01m8nQkJQe
	6p1DzMY0mDRjhBfelluQRN8RaWHFdKSVT0UgTwwxaEOreSB1FyD6X2hzaECRF8o76AMYvi
	wyKuemEJCmBP/cjpOHs7rS0ffLmFIWa2zMpxIKgV5Q60pxYTohIbyT4gbaeF0LFD2pUvvK
	EUTyhlW10tA1Fu3d8T8tNVSk6EZgRCCM4dcRA9B346gQnr+XSPjF4DyCZasxfKCL1RJmf/
	FImLiaUwKdrXSaqgMDUfjVV6LgXf2TyunFDZXV7FTrx3MLtyfJSrADi4f6lThGhA==
Received: by filterdrecv-655bd866f5-tzxlm with SMTP id filterdrecv-655bd866f5-tzxlm-1-65B1498E-35
        2024-01-24 17:31:58.762699388 +0000 UTC m=+509925.707668573
Received: from bixby.lan (unknown)
	by geopod-ismtpd-26 (SG) with ESMTP
	id 285Thze7TAiZcrQCPz-Wfg
	Wed, 24 Jan 2024 17:31:58.530 +0000 (UTC)
Message-ID: <ab077dbe58b1ea5de0a3b2ca21f275a07af967d2.camel@egauge.net>
Subject: Re: [PATCH] wifi: wilc1000: validate chip id during bus probe
From: David Mosberger-Tang <davidm@egauge.net>
Date: Wed, 24 Jan 2024 17:31:58 +0000 (UTC)
In-Reply-To: <0d77d857-35ce-43bc-aaf3-2b46c01a44ec@bootlin.com>
References: <20240122211315.1444880-2-davidm@egauge.net>
	 <20240122220350.1449413-1-davidm@egauge.net>
	 <751bf8e4-c81c-495b-9166-9f91f9c4b2d5@bootlin.com>
	 <b8e8a3f82fe240506e82322a10be7b4e9f218eca.camel@egauge.net>
	 <0d77d857-35ce-43bc-aaf3-2b46c01a44ec@bootlin.com>
Organization: eGauge Systems LLC
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-SG-EID: 
 =?us-ascii?Q?+kMxBqj35EdRUKoy8diX1j4AXmPtd302oan+iXZuF8m2Nw4HRW2irNspffT=2Fkh?=
 =?us-ascii?Q?ET6RJF6+Prbl0h=2FEtF1rRLvLA3Uz04M7dO6s6bf?=
 =?us-ascii?Q?nWDLR2lK8+Feh5EDtnMPhXHAS5JFiJs=2Fh+YdAWB?=
 =?us-ascii?Q?pgHNwSk8aTli35SI6ibdCMHmyfhm0n0xDCvgYvd?=
 =?us-ascii?Q?1ELK7VXE=2F0R+F6ghC4r+mo5QuRfnfRabyXuleul?=
 =?us-ascii?Q?OqQgVRgNKLLrnDIg6yHDkAolyMsSljtGkefFF5G?=
 =?us-ascii?Q?0SiRgma85G+O4yFlvFMuw=3D=3D?=
To: Alexis =?iso-8859-1?q?Lothor=E9?= <alexis.lothore@bootlin.com>,
	linux-wireless@vger.kernel.org
Cc: Ajay.Kathat@microchip.com, kvalo@kernel.org
X-Entity-ID: Xg4JGAcGrJFIz2kDG9eoaQ==

Alexis,

On Wed, 2024-01-24 at 10:01 +0100, Alexis Lothor=E9 wrote:
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> BUG: KASAN: slab-use-after-free in wilc_netdev_cleanup+0x294/0x2c0
> Read of size 4 at addr c3c91ce8 by task swapper/1

OK, I think I see what's going on: it's the list traversal.  Here is what
wilc_netdev_cleanup() does:

	list_for_each_entry_rcu(vif, &wilc->vif_list, list) {
		if (vif->ndev)
			unregister_netdev(vif->ndev);
	}

The problem is that "vif" is the private part of the netdev, so when the ne=
tdev
is freed, the vif structure is no longer valid and list_for_each_entry_rcu(=
)
ends up dereferencing a dangling pointer.

Ajay or Alexis, could you propose a fix for this - this is not something I'=
m
familiar with.

Thanks!

  --david


