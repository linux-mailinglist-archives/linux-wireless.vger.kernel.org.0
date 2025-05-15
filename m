Return-Path: <linux-wireless+bounces-23005-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C806CAB850B
	for <lists+linux-wireless@lfdr.de>; Thu, 15 May 2025 13:36:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 54E821630D0
	for <lists+linux-wireless@lfdr.de>; Thu, 15 May 2025 11:35:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DCA5199FAB;
	Thu, 15 May 2025 11:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="rLekv+fw"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB0A1297B60
	for <linux-wireless@vger.kernel.org>; Thu, 15 May 2025 11:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747308939; cv=none; b=H44RkYPHSRrWHkTWkyx9onxfp5BW9HU7jgKF2U3xFMk4T8CpUsLYGaoCGTbVVPtFlTYK33dfNwYvahryUKog0Fc0XbLdv4wrAyP9WQ/rmkd1dJ4qvhyQg2wMI6Qc6yce5C9gG8oghhSico1smWOow/rIehnf9w49f/vCR0wHNu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747308939; c=relaxed/simple;
	bh=W9s2KSD+AxSjb2hHRp6Q2gbPeytL1hvPQwKF+xelf4I=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=EmOat0lof7AHSzKRjs2WESvgap9ZwU3YJlU7kIQSVsZSNfKK3kz0iU2I1q5gmx6AJu4TO3KpA3ZNpgFtzRqyW4oVK7ZSCAFF5ZvYDSIxQv/2uOTAxCOn803hQ88rPHIejlVCoU7wxiNxG1pwcb//anjimCQP6dxdlfa2O9Aaums=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=rLekv+fw; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=iE5xOnWiBLPy3HmHElZ4FRF5mPddzLv8tkVngrf4Nz0=;
	t=1747308938; x=1748518538; b=rLekv+fwSZqnMyKtUpWL6JrOQfXaxJSbw+Feofpii491s/7
	DGwqqIQoSWEVz1/qXrySvOswdCuC8Jc9C8tQ4MwG0hgOZXMI5LpiGdERnmYBC/LTr6EjLFiXBRxpK
	kcZDBr6zIrSd0BgsI4ouU2Fuuimj6Hr0BlJtSF4ZnvwrbXZUjIBgCv4i9Zsu7x3a4wwaqjSxGlOSY
	zY8QvbstjPFTZWxATUaBemZyWVdBhEnY8vmDhkngcljAae7v/ID9p4bIZRU5xRu85TuJMWmmA6g4u
	lwZ4//ylaGbOQJk4X6tSVoBjC9ysCQX5Euq2kH3w6g1ZohnDhhIkRVeTHr4kD2/A==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.1)
	(envelope-from <johannes@sipsolutions.net>)
	id 1uFWsA-0000000B7WK-1q5l;
	Thu, 15 May 2025 13:35:34 +0200
Message-ID: <e5547e0b3e476bccbce629fa0c7d7e4db9556822.camel@sipsolutions.net>
Subject: Re: [PATCH wireless-next v8 04/10] wifi: cfg80211: add statistics
 for providing overview for MLO station
From: Johannes Berg <johannes@sipsolutions.net>
To: Sarika Sharma <quic_sarishar@quicinc.com>
Cc: linux-wireless@vger.kernel.org
Date: Thu, 15 May 2025 13:35:33 +0200
In-Reply-To: <20250515054904.1214096-5-quic_sarishar@quicinc.com>
References: <20250515054904.1214096-1-quic_sarishar@quicinc.com>
	 <20250515054904.1214096-5-quic_sarishar@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Thu, 2025-05-15 at 11:18 +0530, Sarika Sharma wrote:
>=20
> +static void cfg80211_sta_set_mld_rate_info(struct rate_info *sinfo_rate,
> +					   struct rate_info *link_sinfo_rate)
> +{
> +	sinfo_rate->flags =3D link_sinfo_rate->flags;
> +	sinfo_rate->legacy =3D link_sinfo_rate->legacy;
> +	sinfo_rate->mcs =3D link_sinfo_rate->mcs;
> +	sinfo_rate->nss =3D link_sinfo_rate->nss;
> +	sinfo_rate->bw =3D link_sinfo_rate->bw;
> +	sinfo_rate->he_gi =3D link_sinfo_rate->he_gi;
> +	sinfo_rate->he_dcm =3D link_sinfo_rate->he_dcm;
> +	sinfo_rate->he_ru_alloc =3D link_sinfo_rate->he_ru_alloc;
> +	sinfo_rate->n_bonded_ch =3D link_sinfo_rate->n_bonded_ch;
> +	sinfo_rate->eht_gi =3D link_sinfo_rate->eht_gi;
> +	sinfo_rate->eht_ru_alloc =3D link_sinfo_rate->eht_ru_alloc;
> +}

What, no. Remove this and just do

 *sinfo_rate =3D *link_sinfo_rate;

johannes


