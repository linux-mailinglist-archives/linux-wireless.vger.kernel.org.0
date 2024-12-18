Return-Path: <linux-wireless+bounces-16548-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E9D79F6C76
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Dec 2024 18:39:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4EFE4188FECA
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Dec 2024 17:39:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 430431C5CA2;
	Wed, 18 Dec 2024 17:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="KT+lld7o"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 989541FA179
	for <linux-wireless@vger.kernel.org>; Wed, 18 Dec 2024 17:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734543591; cv=none; b=CYKEAgd/GzS7nCXuKtzo8Q1Al9UH/boz3tsSP+miHTzI2H1hC6iFEzPWGayVLwwvAx7KlR9hlUC9utbgFq7rS8fBdd2GRSrex3at+d2imEwgE258ir9kvaNvP84FJvZhZLKgZbV9R3DST9iFuFT8mwa8GnO+I/HwAeD+c2q/1bo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734543591; c=relaxed/simple;
	bh=etqc+draL/EN5oB5fAemIFcUkS74UnWTAZeTNVzU49Q=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=civ8mcDza8WQOVvIhjXnp0sVtRQ4ZD//+9szUHm2dKokGlOmIJKOEgYVP+fgsIdhd+UibH2sIaj6RZ+GnGZh2uJvRfRdXKyPsU4rZucCukE426re5ppNr2osh8toafq00bXjLE8LrtP62MtuAcg9fWkoWDFkec53O7O/ydT49Yc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=KT+lld7o; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=etqc+draL/EN5oB5fAemIFcUkS74UnWTAZeTNVzU49Q=;
	t=1734543589; x=1735753189; b=KT+lld7o96i9X2vFypFUTzS9jAp4BM75rwdDs4c8MPs0CSl
	4NjSfHEgBZCbM3vYT5l9TxltctNTYmP7xQa66K51NrLjtUThE3iWak+YjkNpdGcwd2CrefOlnRLgK
	WE1XBLGVRngziPSci35TBMvqFOWOokE+x0m1koDSnHuBqeBRdEOr2cD3HoJH5ogy1TE9+OHnwRIIQ
	mZ1f0f4CQ3+0RfQH5kwNJ0omcPdPpShZb2j6v31y8Sj1kvUvkEa8fFeQkwIzN3T+aQWTJauy9y9nv
	sQwbygodLv3haepZk405SKdrWLmPj71iQEQ55g8C9eovIcnHmdlQXfRBGRnfJYmQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98)
	(envelope-from <johannes@sipsolutions.net>)
	id 1tNy1R-00000003LXg-2mBi;
	Wed, 18 Dec 2024 18:39:45 +0100
Message-ID: <289cc87e7ddbbcebd9aef7e8454974146bde5e30.camel@sipsolutions.net>
Subject: Re: [PATCH] wifi: ieee80211: update Indoor AFC standard power type
 definition
From: Johannes Berg <johannes@sipsolutions.net>
To: Veerendranath Jakkam <quic_vjakkam@quicinc.com>, Jeff Johnson
	 <quic_jjohnson@quicinc.com>, Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Cc: linux-wireless@vger.kernel.org
Date: Wed, 18 Dec 2024 18:39:44 +0100
In-Reply-To: <82c78aac-8870-c809-e6f5-5fa1c0b2a2ef@quicinc.com>
References: <20241213121146.2398269-1-quic_vjakkam@quicinc.com>
	 <a850fd692db3458301eb5b7388110a3ec6ec0d01.camel@sipsolutions.net>
	 <11d8f3a6-3942-44dd-9c41-fdc645e5fdeb@oss.qualcomm.com>
	 <42e0e767b0dd55c8ddaca0cbf6aa123ec8fa3942.camel@sipsolutions.net>
	 <a78e51f4-ea73-4d46-8893-07dbf4c9a2a3@quicinc.com>
	 <82c78aac-8870-c809-e6f5-5fa1c0b2a2ef@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.2 (3.54.2-1.fc41) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Wed, 2024-12-18 at 22:21 +0530, Veerendranath Jakkam wrote:
>=20
> As per my understanding, if client supports reading the 4th bit of=20
> regulatory info sub-field (i.e, dot11ExtendedRegInfoSupport is true) in=
=20
> HE Operation Element. it needs to use the values from "Table E-13,=C2=A0=
=20
> P802.11Revme_D7.0". I didn't keep the value 4 definition as it is=20
> reserved currently in "Table E-13" .
>=20
>=20
> If we need to support both "Table E-12" (applicable when=20
> dot11ExtendedRegInfoSupport is not true) and "Table E-13" (applicable=20
> when dot11ExtendedRegInfoSupport is true) with same client, then I think=
=20
> value "12" also should be considered as Indoor AFC standard power type=
=20
> as per "Table E-12". So, we need to map to 4, 8 and 12 to Indoor AFC=20
> standard power type. Please let me know if this is fine.

I don't know, you tell me. However, you cannot claim that we are a (non-
AP) STA that implements dot11ExtendedRegInfoSupport since clearly the
code doesn't follow the other requirements resulting from that.

johannes

