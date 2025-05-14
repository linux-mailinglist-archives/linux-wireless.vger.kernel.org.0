Return-Path: <linux-wireless+bounces-22961-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 08849AB7630
	for <lists+linux-wireless@lfdr.de>; Wed, 14 May 2025 21:53:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C64F3AF2BB
	for <lists+linux-wireless@lfdr.de>; Wed, 14 May 2025 19:52:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2019170A37;
	Wed, 14 May 2025 19:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="pLoVNpRi"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FB0320311
	for <linux-wireless@vger.kernel.org>; Wed, 14 May 2025 19:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747252389; cv=none; b=aiK6MMvt/uL3fKiFNn5mQputj2xb4Wi0TR3M4iz0N0EytOOFC4gWJ+Aqx90JKZzVVQrhEwAW8mejNqv3BNPap7oPoEFwAXJ9XT8hx/dt7raEsa3TVRHE8E35pgSu9ph+Mqp+Fb/5mZqoH92ct1QdJQouaR1absSIEaSDtVaVZoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747252389; c=relaxed/simple;
	bh=o5jY+CIO5RkHpHkYk7HHcZ7xNl3RNkDDfBuK10E+BGs=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=UBWlnAHRSAiwmDporVCf1Pd+0VWjNo9ySWJKkJOwuPsYvxTcnsPHi13MqVOKUvGNjvYDAjOyEAfPH0MWwsw6kzs0jY2sLGqPDLPgKg77pVRX+dMMr3b/joNtRnwGlFtMq6epQeTnGOO7udoV5pNR1Rk2/JdzWaPHokbpX3mvbpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=pLoVNpRi; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=o5jY+CIO5RkHpHkYk7HHcZ7xNl3RNkDDfBuK10E+BGs=;
	t=1747252388; x=1748461988; b=pLoVNpRilMaD3ngKlBaD1yqcNSHNYyeQMfuHx4xdo//Fcgn
	PIZORyayqPk50aizs4XxfizMdfeqdDD9DKkCUjTP5GlRfNlAmHaoi1Ir2QIS8E7VkBjDQxaoViV3j
	84ZkG+5xrm6NWfWZHkm6S9cjqKVDmQf/9ev8KjhSgDQe4su0zrIQLHxHPKM2fbHmttPqZRH/MAlKI
	HTf6ZoHGxT6FOmzGOHzOZ3C2Hfyf7pWD+rzR+wMoBPNTeN3lS2RCYOkbanFCpRIng/9iadGi+s+re
	UgehZowN8mKKBU9+lEPmny7SzX+4PEqHJTeTv704bUVnWz2/gGz1S8CaUWgqnuSA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.1)
	(envelope-from <johannes@sipsolutions.net>)
	id 1uFIA4-00000008kkk-2AAW;
	Wed, 14 May 2025 21:53:04 +0200
Message-ID: <25b89deed3bb6871109fa94c3c967a27a35e3d90.camel@sipsolutions.net>
Subject: Re: [PATCH wireless-next v7 05/10] wifi: cfg80211: allocate memory
 for link_station info structure
From: Johannes Berg <johannes@sipsolutions.net>
To: Sarika Sharma <quic_sarishar@quicinc.com>
Cc: linux-wireless@vger.kernel.org
Date: Wed, 14 May 2025 21:53:03 +0200
In-Reply-To: <20250514164857.227540-6-quic_sarishar@quicinc.com>
References: <20250514164857.227540-1-quic_sarishar@quicinc.com>
	 <20250514164857.227540-6-quic_sarishar@quicinc.com>
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

On Wed, 2025-05-14 at 22:18 +0530, Sarika Sharma wrote:
> Currently, station_info structure is passed to fill station statistics
> from mac80211/drivers. After NL message send to user space for requested
> station statistics, memory for station statistics is freed in cfg80211.
> Therefore, memory allocation/free for link station statistics should
> also happen in cfg80211 only.
>=20
> Hence, allocate the memory for link_station structure for all
> possible links and free in cfg80211_sinfo_release_content().

I'll probably take a look myself tomorrow in the interest of getting all
things lined up for 6.16 quickly, but chances are you'll be at work a
couple of hours before me (and I'm not really all that awake now), so
pointer to this bug report from the bot:

http://wifibot.sipsolutions.net/results/962902/14088291/build_allmodconfig_=
warn/summary

Says some locking issue.


Also, is there any specific reason to want to allocate each link
individually? Why not allocate them all together in one bigger
allocation? Doesn't matter much though I guess.

johannes

