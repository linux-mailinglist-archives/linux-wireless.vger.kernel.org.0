Return-Path: <linux-wireless+bounces-22733-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 48EABAAF645
	for <lists+linux-wireless@lfdr.de>; Thu,  8 May 2025 11:04:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CDE5C163F31
	for <lists+linux-wireless@lfdr.de>; Thu,  8 May 2025 09:03:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A1A822D4D6;
	Thu,  8 May 2025 09:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="IfX21O2n"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0067D1714AE
	for <linux-wireless@vger.kernel.org>; Thu,  8 May 2025 09:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746695035; cv=none; b=aSqzssGT43s4i+wu+ary/HnkRGbuG+xXpXy0UIpqqPG1rjsSOgL3krEylibSazREJRkzxHmhti4emvFnMD6O3xrxZq5abB6oVODvWW2vtfOTLQSGYDftUR3lb+WFCzQyq0Vb06zfSYfLpmTAOOF3e1FFL1mn6o2dsOMol10Av0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746695035; c=relaxed/simple;
	bh=p0+5BwgD7eb74xWHVqEIZ2aBN9fRhyEAS76RwwR3pU8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=mWV6/xkzAWiM9eTcAA+PxjUJQIvfFOwBMnaIQVoExmjuDxVaw2+jd529X8HcnUphO2xBEX8Pke/owStS/jZcCqNSZK7GLHRRIs10hguLUYr2IbiGDiu9tPQEKOSMjAEgwp/dpTh5uEgpuTncxsIWfVXsE9n0jklmzzph/LBov94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=IfX21O2n; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=tEE+s1DBueuupukwl+OW8Kxfgdt6pFiIi31AGgim4WQ=;
	t=1746695034; x=1747904634; b=IfX21O2nl7xsNIocx+YQzVVCLvyF4R05E6r05gbOAOs2cru
	2VJX9fuSEMfMexlxl4K+FE0YM5MpFlHIKdQAlxVlEVIGI6UAxqAWaXrpI5dLAzjO4c6LjFRZhNNv3
	k7p6FC+6Qki6EPmtLQ9HHL28WbefrdOPFMAAdEocVLIF3/vrvCyXc9rLNiM1E/A6gZQTRaPiy2h3b
	V/88MBWkhjSJhIzhHFwoi1D/PJM9s8gk9ibe7GqFuMjEkIq7yFomceLarzFPTqgdfatCxdsve8Q7y
	jf36Q4plQBTQgfgMwwrxV4AzwZxdikRxsw/AXcoSdY5BEHe0dcNwu3lqBXjQDerw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.1)
	(envelope-from <johannes@sipsolutions.net>)
	id 1uCxAU-00000009zW5-2PEu;
	Thu, 08 May 2025 11:03:50 +0200
Message-ID: <21c62e54bc0a6e00731694c62972adbae30ac0da.camel@sipsolutions.net>
Subject: Re: [PATCH wireless-next v6 06/11] wifi: cfg80211: add flag to
 indicate driver supports ML station statistics
From: Johannes Berg <johannes@sipsolutions.net>
To: Sarika Sharma <quic_sarishar@quicinc.com>
Cc: linux-wireless@vger.kernel.org
Date: Thu, 08 May 2025 11:03:49 +0200
In-Reply-To: <6a9b8f49-3a0d-49d9-82cd-d48b0c0930b8@quicinc.com>
References: <20250415042030.1246187-1-quic_sarishar@quicinc.com>
	 <20250415042030.1246187-7-quic_sarishar@quicinc.com>
	 <3311a7a3afac8c9b5f5e5df16dec23c33df90af4.camel@sipsolutions.net>
	 <6a9b8f49-3a0d-49d9-82cd-d48b0c0930b8@quicinc.com>
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

On Thu, 2025-05-08 at 14:27 +0530, Sarika Sharma wrote:
>=20
> This is added, to indicate driver supports link level stats.

Right, but why, the driver also returns back which link level stats it
filled up. If none then you don't have any.

> With upcoming changes, I believe for allocating memory for links[15] in=
=20
> cfg80211, can use this flag?

Oh I wasn't even suggesting *allocating* it separately, but rather
really just - at least for now - putting

	struct link_station_info links[15];

into the struct station_info.

johannes

