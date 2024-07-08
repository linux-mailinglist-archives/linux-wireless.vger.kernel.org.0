Return-Path: <linux-wireless+bounces-10068-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 418C4929F1F
	for <lists+linux-wireless@lfdr.de>; Mon,  8 Jul 2024 11:32:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B492E1F23B0F
	for <lists+linux-wireless@lfdr.de>; Mon,  8 Jul 2024 09:32:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79F5547F4D;
	Mon,  8 Jul 2024 09:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="G38yL5nl"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9971B849C
	for <linux-wireless@vger.kernel.org>; Mon,  8 Jul 2024 09:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720431152; cv=none; b=KJASmFtW+LrV37JkBRbcWZOe2gHkXFiUZp2aiI2XQIz31h4VBKUJBf6mmSnUmPLu0ySHFH2MuxXdlV7xsknTblmwgCit1bXfxenx89CjxAEa/M4iOBJCmZuhuuU8bZpC0ppwDVCyF+LRTUEruEuJS0GchuG01JPHuS29GsP3Iyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720431152; c=relaxed/simple;
	bh=m6gvcGGOIRej5IJke6buWHrfWCy1ZyMKTQwvvL6h474=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=HjdazhWZJyAxcd8DKgO4PGlNvJADg3LiSM20Z5aTHZXheBt097bCJ36G/Ckswiag7/y1PXlwYrVHrJyRjxs9WMKBN8aboNHxtExKcflEb0XQzMil1Eqrh1UWxD3FkKlyOVKQde5h1zNulRGjUE3HOYLNpg3fPFKKArQ0prgqm9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=G38yL5nl; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=m6gvcGGOIRej5IJke6buWHrfWCy1ZyMKTQwvvL6h474=;
	t=1720431137; x=1721640737; b=G38yL5nl5wkpETy1idmU70ltpRWwgy1BkdWAUe8/mDO2DE9
	vGxTEisFxS+1Mbg5hvQ/nQ+XuQGsCI/Bdg1yoJtEFWS3+Jf8dB2PTiDFeFFrH6OhbmUgEA8GtLDXL
	UH+NVOyB7zyhObdy7zKT2eQt/oIvj3xzwfQqjAVeWYDi6XWyMU97hpVxgdu/N4pDURwIsNKDqdmwF
	WeMMsrov6DkiLEYJ+gE1J6QH2lGG0RvQ8C+pFbt5QJiizs+og/96AAqOeRUCXiRbuQgFef2Dmr3Yo
	fTQWs9hAWiw5DmjEai7XhVODKkv0rGqz2g4Km53JdAE/AM4CgtsqFZGIR6w8rjRg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1sQkj6-0000000ALR2-1oEN;
	Mon, 08 Jul 2024 11:32:04 +0200
Message-ID: <3ad1b0c648ce1757a06fceafc371d7b8d14fff33.camel@sipsolutions.net>
Subject: Re: [PATCH v2 8/9] wifi: mac80211: handle
 ieee80211_radar_detected() for MLO
From: Johannes Berg <johannes@sipsolutions.net>
To: Aditya Kumar Singh <quic_adisi@quicinc.com>
Cc: linux-wireless@vger.kernel.org
Date: Mon, 08 Jul 2024 11:32:03 +0200
In-Reply-To: <8079de14-ef9d-454f-862f-704dac821ee3@quicinc.com>
References: <20240626045216.3754013-1-quic_adisi@quicinc.com>
	 <20240626045216.3754013-9-quic_adisi@quicinc.com>
	 <9cf07d0861d6c8ee8a2004361a37a3ebb9860ea9.camel@sipsolutions.net>
	 <8079de14-ef9d-454f-862f-704dac821ee3@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3 (3.52.3-1.fc40) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Sun, 2024-07-07 at 10:42 +0530, Aditya Kumar Singh wrote:
>=20
> So I was trying to implement above suggestion, and I see this -
>=20
> * Drivers don't have chanctx visible in it. Driver visible part is=20
> ieee80211_chanctx_conf (stored in chanctx)

Sure, but you can go back and forth from these in mac80211, so that's
not really an issue.

> * In order to pass this from driver, I need to access each driver's per=
=20
> interface struct which should have ieee80211_vif. This will have=20
> bss_conf pointer and in turn which will have chanctx_conf pointer.
> (per_vif_struct)->vif->bss_conf->chanctx_conf.

Depends on the driver, but maybe, yes.

> * I see for many drivers the place where ieee80211_radar_detected() is=
=20
> called, the interface level struct is not present. So making=20
> chanctx_conf mandatory argument to pass requires a lot of code changes=
=20
> across the drivers.
>=20
> * So in order to keep things simple, we'd have to allow drivers to pass=
=20
> NULL and let the current logic kick in. Iterate over all ctxs and all tho=
se.

Seems reasonable. I'd even go so far as saying that you get a WARN_ON if
there are multiple at that point if NULL was passed, and we just set the
flag on *all* of them since we can't know which was intended?

For current drivers that's all fine, and for MLO/multi-radio drivers
they'd just need to ensure they pass the struct.

Perhaps even WARN immediately it if it's a multi-radio driver? Though
you can't do that yet since I haven't landed that series yet, but I will
soon.

> * If driver passes chanctx_conf, then while going through the ctx, if=20
> the flag is set, further process can immediately kick in and other=20
> num_ctx checks will be ignored.
>=20
> * Now if driver has clubbed multiple hardwares under single wiphy due to=
=20
> which num_ctx will be greater than 1, obviously such drivers are bound=
=20
> to pass a valid chanctx_conf or else the event will be dropped.
>=20
> Sounds fine?
>=20

Sure!

johannes

