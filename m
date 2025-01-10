Return-Path: <linux-wireless+bounces-17304-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 71B15A08B87
	for <lists+linux-wireless@lfdr.de>; Fri, 10 Jan 2025 10:24:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 16E4F3AA4D1
	for <lists+linux-wireless@lfdr.de>; Fri, 10 Jan 2025 09:21:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC2442066FF;
	Fri, 10 Jan 2025 09:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="iSQEsc4A"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2620820C00F
	for <linux-wireless@vger.kernel.org>; Fri, 10 Jan 2025 09:19:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736500750; cv=none; b=oHFdC71Ad3+BJ2oCBfotU8PBIk7AFtbPIRJAYLIKGsjGds9XDp3RjsfE+36UuDp8RyF2IcTi75N46K92vlJ3czINxqtHdyftOe7hPqDgLYSylbewDz6i6O+RKC3ss27i7UVJTgsFcoBphTbGraGfdqXSiUhSj3D1OLq+O/xkYh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736500750; c=relaxed/simple;
	bh=KOtyy7PWnBmGQW4uLFbxRVOngOp+4UvDgw39AbVM1ek=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=YambM0MvQnwegJjUqGnfnhyoNzoxj6MTePijH7RpTRdJUVhjaI8tozhGM0w6xS9vbWuSZKLs4y2UHJcO943HeqOx9sFMOwe9N2hvLhrT3E4OI3be90uOWNvUom0Urky8m6yGbfPHaeTdlfRs3zufAKpy5bXNTUwMP2DJI1v7ADE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=iSQEsc4A; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=79Ut0GLEelWEzoVQQaAx+D7uICP4pSnAJCb8wFMwO9w=;
	t=1736500749; x=1737710349; b=iSQEsc4AmXB0LqWsDiSStX9yd+4q/xJDrJBu3BwdAVC0R9y
	RlGzcHAo7N75z4kgMo3ak16u/RNgZ7gb0c3ZpVxXOHvIuHYVZMt3iDleAOs4YkG+2X6/p4t7IbinZ
	wj/hcJ4tdsr+GsWgsl9pyHQniS7B27h8kMEQDO1Fu4y01OLi2hp3cZwyptD6anyMgEZAahR6IG/Yd
	lmhT7CIKUOaGNO3HWwPyJ/ubiSsO9BNLsAZHzpgRgOa6OGTp1fRJ+Hxgn+udRIoOv96AkNKXWoHPA
	P3uWG8UQw7jDLjoDiCKAiak6aQdzMcq9KaFnIsukAFxsWJ2TQi3+NTZsM5Llh6tg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98)
	(envelope-from <johannes@sipsolutions.net>)
	id 1tWBAX-0000000ASan-2r1v;
	Fri, 10 Jan 2025 10:19:05 +0100
Message-ID: <2f3a8f1c5e9dd41ef38e7dc7cf9411d00313a806.camel@sipsolutions.net>
Subject: Re: [PATCH RFC 2/7] wifi: cfg80211: reorg sinfo structure elements
 for MLO
From: Johannes Berg <johannes@sipsolutions.net>
To: Sarika Sharma <quic_sarishar@quicinc.com>
Cc: linux-wireless@vger.kernel.org
Date: Fri, 10 Jan 2025 10:19:04 +0100
In-Reply-To: <20250110042449.1158789-3-quic_sarishar@quicinc.com>
References: <20250110042449.1158789-1-quic_sarishar@quicinc.com>
	 <20250110042449.1158789-3-quic_sarishar@quicinc.com>
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

On Fri, 2025-01-10 at 09:54 +0530, Sarika Sharma wrote:
>=20
>  struct station_info {
>=20
> +	struct link_station_info deflink;

Having a deflink here seems kind of questionable?

Why not pass multiple pointers?

Also here I'd say you should split this better. Probably the whole
series needs some reorg for cfg80211/mac80211.

> -	if (!(sinfo->filled & BIT_ULL(NL80211_STA_INFO_TX_BITRATE)) &&
> +	if (!(link_sinfo->filled & BIT_ULL(NL80211_STA_INFO_TX_BITRATE)) &&
>=20

A little less renaming would probably also make this easier to review.

johannes

