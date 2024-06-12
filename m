Return-Path: <linux-wireless+bounces-8895-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A1F7905BB5
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Jun 2024 21:10:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D0960B25000
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Jun 2024 19:10:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8CB9548F7;
	Wed, 12 Jun 2024 19:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="pM1UwC9+"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECC3F381AF;
	Wed, 12 Jun 2024 19:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718219435; cv=none; b=G2NK6pNSCUf3b9HjqcvQ0f7VFXOU5kFQibd8iqF3Gq6DVfzbRLJjs8JFU1P+6RfR0XOYPGbIIEBAXLCSu6G29wP0Xjdkpg7spOGoIAvKhjFopc9VlcD0aY31Y2rYkIhRRmKvacth96RufuR/Z8dsscPrDCX1X9EgfGujo/cDNuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718219435; c=relaxed/simple;
	bh=2k/gWxaq2eVBS0Lg9oheC5lg4XYwNNy97AePLIeBdnc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=EPKXcHJPgv/oo/OScP/HpYWyIHbo8Ib8yYcsoU6vIHJSYAtxvXN5uS8IY/0itOCD0KxusURK2GZIVkyI44llSFLeRN11o8+2KoL0hnzFjos2D0pBXdDZX7mPQgiVdRkm68QD/Ld2/5AxkmqkQhxVkFMSuEBy9z3EvwlJmgV5OXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=pM1UwC9+; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=2k/gWxaq2eVBS0Lg9oheC5lg4XYwNNy97AePLIeBdnc=;
	t=1718219434; x=1719429034; b=pM1UwC9+Yw6wTH1WCLhqWVywh3PtjwhpHTnhcSh+3GYAqM0
	rJRBKKsr6jY83pnJ9z1aYhM8iVaVvXCXi6ns57xFQO/3Eqd4ezsjNczBl+k/GCK4nviCThY3raCc9
	GvL9yY4vdRMBe2aAAWZfcFeroW1DaOsKxBCM2NANywb+XMbHFzraNCpf0Hn8xvP1l4ctTIHbd6eOC
	30aowAXlfLAQxo3shQRgy22KvTgKXYtVVfB7tVqoujjAXDLi11PR/EjWqB+Fa8GjYBRQiZ27LJXeK
	Ifm4wLEWNBMUNsqz8fPDnindumFla9INJ++8jnrHnP748ih+3q1nVr2uSEx6mWVQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1sHTMc-0000000AbTp-3c9q;
	Wed, 12 Jun 2024 21:10:31 +0200
Message-ID: <fb60b7f5bcf5ba47be54398225075a5bfab7c141.camel@sipsolutions.net>
Subject: Re: iwlwifi: Regression after migrating to 6.6.32
From: Johannes Berg <johannes@sipsolutions.net>
To: Fabio Estevam <festevam@gmail.com>
Cc: miriam.rachel.korenblit@intel.com, kvalo@kernel.org, Jakub Kicinski
	 <kuba@kernel.org>, linux-wireless <linux-wireless@vger.kernel.org>, 
 linux-kernel <linux-kernel@vger.kernel.org>
Date: Wed, 12 Jun 2024 21:10:30 +0200
In-Reply-To: <CAOMZO5BktgtaSPzCf3WOOnkD2n+fj3FeQEfHeT7CYFL+tCHeaw@mail.gmail.com>
References: 
	<CAOMZO5A7+nxACoBPY0k8cOpVQByZtEV_N1489MK5wETHF_RXWA@mail.gmail.com>
	 <3fbb5317d9ff33ef1b60ca8297537335ce86a79d.camel@sipsolutions.net>
	 <CAOMZO5Aufe7zAE7TFVprvRreamYd9=RHjybjaEz2O9WaPksV=Q@mail.gmail.com>
	 <95163ee547da95964c16f87a38d3326ae4da3253.camel@sipsolutions.net>
	 <CAOMZO5CYDsh70u3To7HYXVki_MzzhFyCCHkigt_Es7o_+XG3oA@mail.gmail.com>
	 <7a8e220d77d7e30a0cfaf984404ef2f57eaa785f.camel@sipsolutions.net>
	 <CAOMZO5BktgtaSPzCf3WOOnkD2n+fj3FeQEfHeT7CYFL+tCHeaw@mail.gmail.com>
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

On Tue, 2024-06-11 at 11:59 -0300, Fabio Estevam wrote:
> On Tue, Jun 11, 2024 at 11:50=E2=80=AFAM Johannes Berg
> <johannes@sipsolutions.net> wrote:
>=20
> > It should be an address (so that's fine), but I don't see how it ends u=
p
> > not being page-aligned if we request to map a page and 4096 bytes??
> >=20
> > Is that platform "weird" with strange page size, or something?
>=20
> It is an NXP i.MX8MM, which is ARM64 with a 4KB page size.
>=20

Strange. Is there an IOMMU involved on this platform?

johannes

