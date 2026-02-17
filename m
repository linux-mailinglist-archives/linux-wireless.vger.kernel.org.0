Return-Path: <linux-wireless+bounces-31927-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QLXhAI9RlGktCQIAu9opvQ
	(envelope-from <linux-wireless+bounces-31927-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Feb 2026 12:31:27 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id AFE3D14B629
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Feb 2026 12:31:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id EAA52300A33C
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Feb 2026 11:31:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C80812ED873;
	Tue, 17 Feb 2026 11:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="uK7jGDoK"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FB9E3346A1
	for <linux-wireless@vger.kernel.org>; Tue, 17 Feb 2026 11:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771327882; cv=none; b=CFUXYux8wxb+e7EbiL/NU4RynRGz6CafWTkM+ihranRNLxCnh3juw5GOBueR90Nw1Fk5UYF0+e77d9KFHqiYLvpPYkwKr8sbAR3flTgiqjrJqCEMW6cQQ1U87CMUlnN8FUR0Tbp122ds+LCZNNeQUlPLoCgjiWk3wGc0g+JTw74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771327882; c=relaxed/simple;
	bh=eqyYGEsWUqywfJhYXJPb03WLDek1CdMurkAbpKzyrKU=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=r682suS2W9ojiAoEeKtuCUYCpkwwMWVl1OhBJEXdqWSaXxoJrzaPeQkqCqdwOqX4SY3vDyJgzPXoNawCTLo9W2rNcAYtDnFkzMe3hQC27hTh0GxJiJ0t/nS2QrsXaavTDuR8K064brnFueVwqj0qwy0GejoUJ3YYBYJb8CL1+VM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=uK7jGDoK; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:To:From:Subject:Message-ID:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=N4VPE5nUK6DOmgPgGG6eBTWBqI/gglANFSShp++TjpA=;
	t=1771327881; x=1772537481; b=uK7jGDoKqIWKhEZWsY0CqSIw3UTBixh/Aqya942TBYfylBs
	wZqbDSpQzoywW9xTIXj3ABwviev6aE/1KB6jdnd6ZqyUQFx0nhCtvRdFpmtZxRF7cHhHNTYx0+ubC
	TSsW4otw+2h0u63oDkDkVKPNRa3PfHH3MV7Xm4WT4zBdRpY2O8yWQw7AJMs2rk36Zb1Xn5jUYndh+
	8SIg6BpTZbwt0c1bBDtJzPZhYCdErrQCIdGyRjqiMz8wTo3OhGQhDGzRMMfX3jSlple6QO8R8QP3n
	HZt3EIx5Bsa1uH5WcKJ1R4alKZH7oWeMUEx+Dn22JrWLsUlSIn+dzDyXv0zTSc3w==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1vsJIU-0000000BMYL-3hsW;
	Tue, 17 Feb 2026 12:31:19 +0100
Message-ID: <4b8a609add613f5409d7bb2ee524bb4c9288e61f.camel@sipsolutions.net>
Subject: Re: [PATCH iwlwifi-next 00/15] wifi: cfg80211/nl80211: Add NAN Data
 Path support
From: Johannes Berg <johannes@sipsolutions.net>
To: Miri Korenblit <miriam.rachel.korenblit@intel.com>, 
	linux-wireless@vger.kernel.org
Date: Tue, 17 Feb 2026 12:31:18 +0100
In-Reply-To: <20260216215452.1538316-1-miriam.rachel.korenblit@intel.com>
References: <20260216215452.1538316-1-miriam.rachel.korenblit@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[sipsolutions.net,none];
	R_DKIM_ALLOW(-0.20)[sipsolutions.net:s=mail];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWO(0.00)[2];
	FROM_NEQ_ENVFROM(0.00)[johannes@sipsolutions.net,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_FROM(0.00)[bounces-31927-lists,linux-wireless=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[sipsolutions.net:+]
X-Rspamd-Queue-Id: AFE3D14B629
X-Rspamd-Action: no action

On Mon, 2026-02-16 at 23:54 +0200, Miri Korenblit wrote:
>=20
> Daniel Gabay (1):
>   wifi: cfg80211: allow ToDS=3D0/FromDS=3D0 data frames on NAN data
>     interfaces
>=20
> Miri Korenblit (14):
>   wifi: nl80211: refactor nl80211_parse_chandef
>   wifi: cfg80211: remove unneeded call to cfg80211_leave
>   wifi: nl80211/cfg80211: support stations of non-netdev interfaces
>   wifi: cfg80211: refactor wiphy_suspend
>   wifi: nl80211: don't allow DFS channels for NAN
>   wifi: cfg80211: Add an API to configure local NAN schedule
>   wifi: cfg80211: make sure NAN chandefs are valid
>   wifi: cfg80211: add support for NAN data interface
>   wifi: cfg80211: separately store HT, VHT and HE capabilities for NAN
>   wifi: nl80211: add support for NAN stations
>   wifi: nl80211: define an API for configuring the NAN peer's schedule
>   wifi: nl80211: allow reporting spurious NAN Data frames
>   wifi: nl80211: add NL80211_CMD_NAN_ULW_UPDATE notification
>   wifi: nl80211: Add a notification to notify NAN channel evacuation

Wrong tree tag, since it's all cfg80211, and also it didn't apply on
iwlwifi-next at all.

johannes

