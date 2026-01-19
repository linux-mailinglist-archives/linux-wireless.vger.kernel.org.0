Return-Path: <linux-wireless+bounces-30946-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B5280D3A26D
	for <lists+linux-wireless@lfdr.de>; Mon, 19 Jan 2026 10:07:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3561230046D4
	for <lists+linux-wireless@lfdr.de>; Mon, 19 Jan 2026 09:07:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBE31352948;
	Mon, 19 Jan 2026 09:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="nRH1yFlh"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A2F333ADB9
	for <linux-wireless@vger.kernel.org>; Mon, 19 Jan 2026 09:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768813627; cv=none; b=M7FRHhZfg+H+sdMZGpvuYrbR94ERAlNXh+E7TIrb8v3hUl+Z6vKf3oYdet/m+9Og5w+SIvMfzK0LvBlFb77irmEmaTzVL8FdpfxrbSyVPdw5VTBd5G9htaU/Qf690/vgAyCslaRK5oN/bmYevcARuYyGVdmA01uNtA4ph281R4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768813627; c=relaxed/simple;
	bh=yUmKGzfICBgcVDjhoiDLhfCE8S3gfooHW42osFOZeWM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XgWFUmxPdKKdBRnNpyX5iOM24Hk9CBzdJpFs18TrpxbUY2Kd/ordzMiNRNg76NuAcoHkptZQ+eSa8Dj4Qcrk4SpXTo6T4BFjrL7HIv8KFoC+WB+QR/Y6Dch/46tliNnIMq+HRrKrUpv767h/vTHac8KShyQ7A7+JBcyb2DQORf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=nRH1yFlh; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=JOUW1qy9T0O5XHErfzHrodKptBYNhGEyrLVXyYMuYuY=;
	t=1768813626; x=1770023226; b=nRH1yFlhFMayz/ld85ldP5HKSeLdD5qg2z85rnHFH08v8v9
	Z2WNjsjegHb1V22OlFzD/hoQy1Gx4pea7QLwofLda67biyaGJaotnPKeLuDOtNdHUBkYoVpZ6+laQ
	GBXT+307hgE5ngLbg9R6Kau/P3YsI87F1VMpwd8bKitDMcVL8jf1oK1D8WgPQNMTVxEb1/qv6ppE0
	mcdttfLkIzCI8JJsGqnCKUK2XPtkUDzq/A4WLqnNn5jUR9sY7NP2fakaDQfhPaWEKpurOqOZ6XEli
	qqkmm7fISKmK9MCWww2fBZmpNvbfIkAHeXGQdU+YBTmI8w7GNHz/WMSrBevvOArA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1vhlDt-0000000Fow0-1h8d;
	Mon, 19 Jan 2026 10:06:57 +0100
Message-ID: <bb4d01dc4cda7e2fdb85489e8e42f2bcfdc1fc96.camel@sipsolutions.net>
Subject: Re: [PATCH 0/3] wifi: mt76: kernel 6.18 compatibility and txpower
 reporting fix
From: Johannes Berg <johannes@sipsolutions.net>
To: Lucid Duck <lucid_duck@justthetip.ca>, nbd@nbd.name, 
	lorenzo.bianconi83@gmail.com
Cc: linux-wireless@vger.kernel.org
Date: Mon, 19 Jan 2026 10:06:56 +0100
In-Reply-To: <20260115230252.43391-1-lucid_duck@justthetip.ca> (sfid-20260116_000600_198058_1F58BA40)
References: <20260115230252.43391-1-lucid_duck@justthetip.ca>
	 (sfid-20260116_000600_198058_1F58BA40)
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

Hi,

I don't know who you are and if you're serious about this at all, since
this doesn't look like a very serious submission (against 6.18, etc.),
but even if you do that, please ensure that _every_ patch sent to this
list is actually addressed for the kernel and using the right paths.
>=20
>  mt76.h             |  1 +
>  mt7615/main.c      |  6 ++--
>  mt7615/pci_mac.c   |  4 +--
>  mt7615/usb.c       |  2 +-
>  mt76_connac_mcu.c  | 13 ++++++-
>  mt76x0/eeprom.c    |  2 +-
>  mt76x02_eeprom.c   |  2 +-
>  mt76x02_usb_core.c |  4 +--
>  mt76x2/eeprom.c    |  2 +-
>  mt7921/main.c      | 84 +++++++++++++++++++++++++++++++++++-----------
>  mt7925/main.c      |  4 +--
>  mt792x_core.c      |  6 ++--
>  12 files changed, 93 insertions(+), 37 deletions(-)

These are clearly not patches that can be applied to the kernel, and
they're erroneously routed to me.

johannes

