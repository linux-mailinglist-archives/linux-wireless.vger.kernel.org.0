Return-Path: <linux-wireless+bounces-12164-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C569F962725
	for <lists+linux-wireless@lfdr.de>; Wed, 28 Aug 2024 14:33:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7FD332850A4
	for <lists+linux-wireless@lfdr.de>; Wed, 28 Aug 2024 12:33:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D99016C6AD;
	Wed, 28 Aug 2024 12:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="C7/67SW7"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CE7916BE11
	for <linux-wireless@vger.kernel.org>; Wed, 28 Aug 2024 12:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724848432; cv=none; b=OWjrJKWfh1ZsfggG41QMmWd8noDtJenfH/UjSUp5ptFLNndjYoTGFma/JWi+I4s742xI8Z11nFmw1pe+joyeCRMJvQ8zUOGEw2Mg6IgI3eQ1K291/I9bVopoF8gYB6NuDB6VbBDGIq8Nz4qajXTPuiduNtUfs/Qcc0rkAT7wOow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724848432; c=relaxed/simple;
	bh=0zzSRsj/gdZfT5mDTKAItdcP16hs9+FVdSpVjYGP/n4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=TTLfPAn8s12yogE0Nwb5LuX+bndLF9cz86SYTLeRQGg7tvet5tdbRPgUuMF1fBI9N32kCSoN+cSMNuuVmHk8Zyo2NYY654wMOmNiK98mZJKVUXpw1KDoO+8leA97lN07/XdGUWFAjxpUpMPaUBmOOJCA9oderjk5S9ks1ttKNgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=C7/67SW7; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=0zzSRsj/gdZfT5mDTKAItdcP16hs9+FVdSpVjYGP/n4=;
	t=1724848431; x=1726058031; b=C7/67SW7t99QTzxCGbGo/lCI6in4jfCPnAHZivQk4lx+34P
	+rS9uzDL2L3neo7us9x6FHjUC4bMNtzEWkMgSss8IS7fJfmtrHM/RXkNM1f+hIJdeRYl/0/uKQlTg
	mmhYiHVQ4MP3NnbBDnffPd2fZKg+LlUhGUng2PBUVRYl7jq8lt5DaIHyj2QHETlndNGajOGLT6T2p
	K/gRQVMIsuWBexKX61fWPXcfZZnK/QKjHmOkNa1DspIEUF11fiEgFkDT1byFyHcyuqGDo3GsFNDwD
	j1g+Y8C8wyVgIj386TmIwY/DX+4CvR8adNNkepXJ9bnFXbhCAk/5KPj5shzt0sBQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1sjHrv-000000077d1-20dA;
	Wed, 28 Aug 2024 14:33:47 +0200
Message-ID: <b8fa2b9bb687ce3df711b494ab577dce6df9b193.camel@sipsolutions.net>
Subject: Re: [PATCH] wifi: mac80211: override HE/EHT capabilities if NSS is
 zero
From: Johannes Berg <johannes@sipsolutions.net>
To: Ajith C <quic_ajithc@quicinc.com>
Cc: linux-wireless@vger.kernel.org
Date: Wed, 28 Aug 2024 14:33:46 +0200
In-Reply-To: <c700b251-8300-4d58-be9d-7f78057d84ac@quicinc.com>
References: <20240807041933.3196761-1-quic_ajithc@quicinc.com>
	 <30ec97d6ecfc4bf83fbd1477c0dba255bce9e6fa.camel@sipsolutions.net>
	 <c700b251-8300-4d58-be9d-7f78057d84ac@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Fri, 2024-08-23 at 18:55 +0530, Ajith C wrote:
>=20
> I=E2=80=99ve noticed that stations are sending association requests with =
zeros
> in the EHT-MCS and NSS fields. According to draft 6.0 (Table 9-417p),
> a value of zero is allowed for NSS to indicate =E2=80=98Not supported.=E2=
=80=99
> Therefore, I believe we shouldn=E2=80=99t consider these as invalid reque=
sts.

OK, that sounds different...

> Additionally, since other lower bandwidths are supported, I thought
> it would be more appropriate to select the next available bandwidth
> rather than dropping the request.

I'm not sure I see why. You're talking about ieee80211_sta_cap_rx_bw(),
and if the STA says it has a certain capability we should probably
believe it?

Munging the capabilities there seems pretty wrong, and *especially*
doing it if it e.g. has no RX or TX for a given bandwidth - I guess in
theory then it's possible that it's saying it can receive but won't
transmit (which we should probably not care about), or it can transmit
but not receive (which should impact rate control).

It doesn't seem right to assume that it will not use say 160 MHz if it
doesn't have RX MCS/NSS support for 160 MHz, I'd say? Or only has
partial support, for some NSSes?

It seems you should solve whatever problem you have here in rate control
instead, but I'm not even sure what problem you have.

johannes

