Return-Path: <linux-wireless+bounces-19531-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1068BA47804
	for <lists+linux-wireless@lfdr.de>; Thu, 27 Feb 2025 09:40:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E5163AD00A
	for <lists+linux-wireless@lfdr.de>; Thu, 27 Feb 2025 08:39:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72D86225408;
	Thu, 27 Feb 2025 08:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="TVo0fduK"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1A8E2222A5
	for <linux-wireless@vger.kernel.org>; Thu, 27 Feb 2025 08:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740645604; cv=none; b=hNDwKRK57IgtLmFZwCb6RVOaZKoMdRePaCCVJ/DDpx6ycG8yGs6xSefiAa64gmuEHBCtnaGQI9fmdcUeOlzgvgvYyWcRolh6uFg7IOaHUP1F323GYnSZzG6ih7PkrGP59FAb70gXd6F/4RqQQRCFueFVEl9qJgDbcxYfD2b+NX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740645604; c=relaxed/simple;
	bh=npucXcIsLX4eT2P50JolKo///ViBAmNLy6VT/0Wpaxs=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Zsex5cAyeQYHh94lVSFwWDYjgtpQ+GlX6MtSDGkS6wc57n01FWfw+W41b0UBnLaHVVpSNCNudMNsmM1Jvn3NRMThky6yV7tDU3A8Md07GRwi7FHj3kV95Hme8Bypk21hCPTQh/HaiAUhEqja6ILCzJTEMPG9vaFusLqKZMVkMIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=TVo0fduK; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=h7C+0lqY/EdZ414tGuEKVPpob8c2v9e2BIuDXx4PtYU=;
	t=1740645602; x=1741855202; b=TVo0fduKTnEVjGV/YV7OJYugNXPR3TNShRCb/r9hrHxUlEW
	q0WUGhVMhbiAk0I9rWAtL/QVIPjL5b10Yxl0yFwFSyJLdewI+DMm6+UWNSe5CYyi8eaVNJLvP7Tn7
	JDUJO3ZNCl/iqZIxdtgAbDyIvOlEIuL96Z2x5POH0L2eQ3iD/31WKTetTXdC/RFvDqAzRSnPBUtY/
	9vmg4yO6mShNoZn2id+UOfLn/GPF2HbAPeyyc6lPy0cnTom2m9a2sBVMTUlIcrnGbFoH7HcLaGROr
	2+T53wpNWns5CBhXpynTw9l/40Vc+ELTOLmxuDqthJPqwKEmC4xKhdXMgLBDRj2g==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98)
	(envelope-from <johannes@sipsolutions.net>)
	id 1tnZR0-0000000CV3L-2A77;
	Thu, 27 Feb 2025 09:39:58 +0100
Message-ID: <bac3fdc3bd39e45150e5b7d60be01b5d732a04bf.camel@sipsolutions.net>
Subject: Re: [PATCH v3 0/5] wifi: mac80211/ath12k: add support to fill link
 statistics of multi-link station
From: Johannes Berg <johannes@sipsolutions.net>
To: Sarika Sharma <quic_sarishar@quicinc.com>, ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org, Jeff Johnson
 <jeff.johnson@oss.qualcomm.com>
Date: Thu, 27 Feb 2025 09:39:57 +0100
In-Reply-To: <20250227045824.91480-1-quic_sarishar@quicinc.com>
References: <20250227045824.91480-1-quic_sarishar@quicinc.com>
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

On Thu, 2025-02-27 at 10:28 +0530, Sarika Sharma wrote:
> Currently, station statistics are filled at deflink for both non-ML and
> multi-link(ML) station.
>=20
> Hence, add support to fill station statistics for the corresponding
> link of station.
>=20
> Depends-On: [RFC,v3,00/12] wifi: cfg80211/mac80211: add support to
>             handle per link statistics of multi-link station
> Link: https://patchwork.kernel.org/project/linux-wireless/cover/202502131=
71632.1646538-1-quic_sarishar@quicinc.com/

That can't work for the automation...

Also, even _with_ that, this series doesn't apply on wireless-next,
likely because it requires some changes from the ath tree.

Given that we want to run the automation now, that really means you need
to adjust your workflow to send only series to the list that can
actually apply on a single tree...

So I guess in this case it means you should split it. In fact I'm not
even sure why this is one series in the first place - the first patch
fixes an issue but it _doesn't_ introduce any API or anything that'd
actually be _required_ for the remaining patches, so it shouldn't be a
single series anyway.

johannes


