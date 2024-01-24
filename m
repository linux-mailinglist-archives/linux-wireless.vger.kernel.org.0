Return-Path: <linux-wireless+bounces-2450-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0924683AE27
	for <lists+linux-wireless@lfdr.de>; Wed, 24 Jan 2024 17:16:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3B9601C21909
	for <lists+linux-wireless@lfdr.de>; Wed, 24 Jan 2024 16:15:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D09D97E580;
	Wed, 24 Jan 2024 16:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=egauge.net header.i=@egauge.net header.b="onBf5WlQ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from o1.ptr2625.egauge.net (o1.ptr2625.egauge.net [167.89.112.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A5FE7E562
	for <linux-wireless@vger.kernel.org>; Wed, 24 Jan 2024 16:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=167.89.112.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706112919; cv=none; b=lxZg0PM8WLesj3J8CDKJ2G8wL0vix+4NN92okVCT9dkWP8vOe9cDLKpP0pWQfPS4UE9WT0otKTJzvwuaS4q2wCbG7pBemKLCi/drKGdDpGx1l6I/Pl4Y0WoTt76LwdSgHcNUK/ThXfH8v2gfyp1so+RfeHbwAgNvGVSVYiUt2J0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706112919; c=relaxed/simple;
	bh=dKiAv/uivPzoiGhxG2IKUFAnOQNxuPlFeWhprbt8OQU=;
	h=Message-ID:Subject:From:Date:In-Reply-To:References:Content-Type:
	 MIME-Version:To:Cc; b=E3iEhLLPxnjJvTmcFKAuacNHtyS7uxr0OIoR1ZhgmOWD0JMWZ45sBw+k/mX1sUIDelTbTqpEqcFH0xUuXb/M5l+e0eEJ46c2f+qf6g1ZrUFf6myfLxHTgtumD1jSJGIg6n54zxvFomNgLVTo9OPPgsRQkyjj0eVnKSYTO4DRNEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=egauge.net; spf=pass smtp.mailfrom=em1190.egauge.net; dkim=pass (2048-bit key) header.d=egauge.net header.i=@egauge.net header.b=onBf5WlQ; arc=none smtp.client-ip=167.89.112.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=egauge.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=em1190.egauge.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=egauge.net;
	h=subject:from:in-reply-to:references:content-type:
	content-transfer-encoding:mime-version:to:cc:cc:content-type:from:subject:to;
	s=sgd; bh=P0h+Q+0tLepJtPjIopUI7mcyX5TnBT5b8Kc9+K+8eTs=;
	b=onBf5WlQ/ng/2mXXy1np12+40ULiSgBIAeKReFvomqILI+FeCp5ObhSi+v4RR7IdCm7Y
	iSTWdB07BMzHZV2GM2NABPwGn/eowpUf8Oz3J2atlbEjUTkb4em35lMxt2B4AGMS+qrqJR
	iwzNemRn2JzfCDeMpxh1vZB4Vxvl8TeiYA+2GmzwCJMv5yvFuE9Cyk5BX9duQJwbXhPlwh
	lSwspR/QmDMAQpefhF4ZBUdtY5gm6eQ26/G6JeERLWWYcZBm2juCLIU5+CAU9TOfz0Dcas
	wdXXR4X/+r7tLQZUYky+ns74LO6LJLAZHyBnqwFMSBcV1RmTP1sSD4GlI7JoBm+Q==
Received: by filterdrecv-5bbdbb56cd-fdw6s with SMTP id filterdrecv-5bbdbb56cd-fdw6s-1-65B13794-5A
        2024-01-24 16:15:16.708559711 +0000 UTC m=+1133900.830562834
Received: from bixby.lan (unknown)
	by geopod-ismtpd-26 (SG) with ESMTP
	id Bg1IXzs3RB-5Mjk55BGNwg
	Wed, 24 Jan 2024 16:15:16.486 +0000 (UTC)
Message-ID: <8892ba59b6307e82eb203b60042e605443bf91e2.camel@egauge.net>
Subject: Re: [PATCH] wifi: wilc1000: validate chip id during bus probe
From: David Mosberger-Tang <davidm@egauge.net>
Date: Wed, 24 Jan 2024 16:15:16 +0000 (UTC)
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
 =?us-ascii?Q?ET6RJF6+Prbl0h=2FEtF1rRLvG91yd+1zkhLPuO8B?=
 =?us-ascii?Q?bsb2o55qZdxG26=2FghdW5nDLDPvFkYp8ciozUc6q?=
 =?us-ascii?Q?BUz=2FmVWd59RwJ4uf1Hun=2F5lgIPKyP5xXCHg6baP?=
 =?us-ascii?Q?3fElVzPcfdu4gfyyci2lTO9mycyVu4lnJl7JPhY?=
 =?us-ascii?Q?WvaKC9Z3lHP9WWlv0+r7PeAeJSkIxGyHw=2F+7yJz?=
 =?us-ascii?Q?wlDTH6TBnSvndWi9REL2w=3D=3D?=
To: Alexis =?iso-8859-1?q?Lothor=E9?= <alexis.lothore@bootlin.com>,
	linux-wireless@vger.kernel.org
Cc: Ajay.Kathat@microchip.com, kvalo@kernel.org
X-Entity-ID: Xg4JGAcGrJFIz2kDG9eoaQ==

On Wed, 2024-01-24 at 10:01 +0100, Alexis Lothor=E9 wrote:
> On 1/23/24 18:39, David Mosberger-Tang wrote:
>=20
> >=20
> > > What does KASAN actually complain about?  A double free or something =
else?
>=20
> I see that the kasan dump from my last email is truncated, but the first =
line
> clearly mentions a use-after-free:
>=20
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> BUG: KASAN: slab-use-after-free in wilc_netdev_cleanup+0x294/0x2c0

Ah, that's helpful, thanks!  Can you map wilc_netdev_cleanup+0x294 to the
corresponding source line?  Are you on ARM64 or something else?

  --david


