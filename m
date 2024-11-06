Return-Path: <linux-wireless+bounces-14975-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 716CF9BE549
	for <lists+linux-wireless@lfdr.de>; Wed,  6 Nov 2024 12:11:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C5670B24AF2
	for <lists+linux-wireless@lfdr.de>; Wed,  6 Nov 2024 11:11:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24C4D1DE3C3;
	Wed,  6 Nov 2024 11:11:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="mhysxzOW"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8939E1D9341
	for <linux-wireless@vger.kernel.org>; Wed,  6 Nov 2024 11:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730891477; cv=none; b=R20YadHCTEtINZSsBpwqaodoGr9lKJCEgOqIdG3M0EMwvSc1W51OT0Zy7W+mk2tS2zsodsbatd2elorPPtyZKoC8/MXhN7W/HGZQL4jAmQo0qJ60fv4Sh8RmG+A2TqHDB/8OxsAQ/0tAgzLHeY4S+b1GHrg79tc92yQvix1o7XA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730891477; c=relaxed/simple;
	bh=ZniFLLxVctCq3DrorMNc3dPMw1BX3lwQ/KZ2ZHuAbEs=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=VHB/XP2d/Jwdgh9XBkXw4kiiGGxb3J3weRtovZlG0YHFqQMvL0VhD0EiXOQst88R82lgOzeb/7MNGS9W2j4ucaVvv11FtCfo44kVTtkwKkxm9KbeV/r5NgeKgN0JMeTrxJjvGSDtF/TKnKniUP0X5TowvFkJ/GzpoMmbFOxMmCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=mhysxzOW; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=ZniFLLxVctCq3DrorMNc3dPMw1BX3lwQ/KZ2ZHuAbEs=;
	t=1730891475; x=1732101075; b=mhysxzOWTjoNvYwkxC7ywJneJsEYTBxEnf/lbDy5gCg67Eq
	ixNolfJwVa/Pb7wvm7CWBfCbmpBhWfZZ1GwaMr8cbcDe06I2IpEfpNCrZqQeHtkZmH+V6efquCsbc
	o6unxrFVBFgSH5/VUI6omAOMS16AU1BQ1Tb9XtNHoKa/SwOos8EyI8Ebs1h8JeoF3T2y96UiWvf8S
	kdKR61I1GUHktIfj0rA66qLe/zCjU5MTVAU0eSwz2p8fxdAYFa0MsVB3BRPlv0VepTcr7dLOf79AB
	RFnzfe8qSH1NyaE4wPuA/m4wCOthjUGlgNMrwsLivcwzHnGgaOIn+xBKGECx8DgQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98)
	(envelope-from <johannes@sipsolutions.net>)
	id 1t8dwP-0000000Fal4-0Gy5;
	Wed, 06 Nov 2024 12:11:13 +0100
Message-ID: <eb4b7856fe814038de1673d47afabbbfef8e97c5.camel@sipsolutions.net>
Subject: Re: [PATCH] wifi: mac80211: fix mbss changed flags corruption on 32
 bit systems
From: Johannes Berg <johannes@sipsolutions.net>
To: Issam Hamdi <ih@simonwunderlich.de>
Cc: linux-wireless@vger.kernel.org, sw@simonwunderlich.de, Kretschmer
 Mathias <mathias.kretschmer@fit.fraunhofer.de>
Date: Wed, 06 Nov 2024 12:11:12 +0100
In-Reply-To: <df6c3317a71c8fa76f2b64623a0278f1fd0a68dd.camel@sipsolutions.net>
References: <20241104172415.3790038-1-ih@simonwunderlich.de>
	 <df6c3317a71c8fa76f2b64623a0278f1fd0a68dd.camel@sipsolutions.net>
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

On Wed, 2024-11-06 at 12:09 +0100, Johannes Berg wrote:
>=20
> > +++ b/net/mac80211/mesh.c
> > @@ -1164,7 +1164,7 @@ void ieee80211_mbss_info_change_notify(struct iee=
e80211_sub_if_data *sdata,
>=20
> You evidently have _hundreds_ of out-of-tree lines, probably some of
> those cause this bug too.

Ahrg, sorry, no. I take it all back, I was looking at the completely
wrong tree by accident.

Still this seems like the wrong fix, it would be better to take care of
all the 64 bits?

johannes

