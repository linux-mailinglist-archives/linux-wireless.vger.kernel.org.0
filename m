Return-Path: <linux-wireless+bounces-8143-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 362878D097D
	for <lists+linux-wireless@lfdr.de>; Mon, 27 May 2024 19:44:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C12E2B21C83
	for <lists+linux-wireless@lfdr.de>; Mon, 27 May 2024 17:44:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B063C155CA5;
	Mon, 27 May 2024 17:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="sRW98aIf"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF72E26AE7
	for <linux-wireless@vger.kernel.org>; Mon, 27 May 2024 17:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716831848; cv=none; b=b8AmlG569o8dkzThaF7fU8Kab7wPGxgTfC3/0Vb413fe1DO1Z+mWKmS5spLUCbzmlkg4edOm2hyqerktogGe7ESxYdrhA69XDnqCRNhc1uf7ORBtlMr1PhKLNUwNFLC+dPHPEPiV+yJK448a8912V+FV4DosxDZl8ZDwYoKNKcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716831848; c=relaxed/simple;
	bh=SBlDgzF6mpmZ1Onln0HIXGug87tsPK6zVBEDdeQb8p8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=eTUQNc1jzW3y44ZdxE92lKy/GsqDtr2i47X1FerKp0VLP6/VqR2j/djrRCoQJzQtWAJyVjFY7PBmNs+dw7qcz61GEsO7pdSD+Id+DDt+5ruSaVJfqhaoI6m0hhvVrYeO8VnZ95Ue1MWLGc9AdoKv/0xIJ+xfJqzcLKn/bqDvFeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=sRW98aIf; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=SBlDgzF6mpmZ1Onln0HIXGug87tsPK6zVBEDdeQb8p8=;
	t=1716831844; x=1718041444; b=sRW98aIfg5UPjDv9iW6sjg1kxr6iSoJwIZrhcsWWrvXMz3K
	tj9dRJRIiiubJsmYHGgk7qZ6tdI0KEWmxHp2kBsuVYSUOeMtywBLOfjI+ojk6QNiym6TYlPsdZccv
	tCaWWpfamSv91PhdnluQKTvOEqklzHtFlX1htwq1ljUuhNKSgy24czwpF55mRuJ7Jsm0v9KepR3hc
	DA0qmHcfqJeV1MtbyH1K42m9Vj7kVOY6wxh7qOluPxzcv9L7QHACgF4t42HhavjoAmCHNdrM3JTOP
	tr5UuXP4ScMpXRZO4A+rkYLvxt5yl8W3Rghjg9JXD8jiQZrQ970HIRJmQtsyo27w==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1sBeO8-0000000D0C9-1i2Y;
	Mon, 27 May 2024 19:44:00 +0200
Message-ID: <56d1c2f223c032b0003029cc4956f1cfffea86ca.camel@sipsolutions.net>
Subject: Re: [PATCH] wifi: mac80211: add input validation to
 sta_stats_decode_rate()
From: Johannes Berg <johannes@sipsolutions.net>
To: James Dutton <james.dutton@gmail.com>
Cc: linux-wireless@vger.kernel.org
Date: Mon, 27 May 2024 19:43:59 +0200
In-Reply-To: <CAAMvbhGdhHUxstdrmnD6ZF_iTxOTfbAgj1QiwZMKLOYf9D2Egg@mail.gmail.com>
References: 
	<CAAMvbhGyheFdWSrDzM_i10n9s06n3G2wX6O_S68VUZyP-a9p+A@mail.gmail.com>
	 <f939f9dfb467d7a1daaf1e69b56f8599ef3eceeb.camel@sipsolutions.net>
	 <CAAMvbhGdhHUxstdrmnD6ZF_iTxOTfbAgj1QiwZMKLOYf9D2Egg@mail.gmail.com>
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

On Mon, 2024-05-27 at 18:14 +0100, James Dutton wrote:
>=20
> You mention "certainly not any pointers or the band enum!".
> How certain are you about that statement? I ask because received wifi
> packets can and do result in unwelcome values for the pointers here.
>=20

I really don't see how? Certainly the pointer is _always_ going to be
defined by the driver calling this, and I've yet to see any hardware
that actually uses nl80211 band enums directly.

johannes

