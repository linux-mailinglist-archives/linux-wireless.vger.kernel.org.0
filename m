Return-Path: <linux-wireless+bounces-21058-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D0C99A78875
	for <lists+linux-wireless@lfdr.de>; Wed,  2 Apr 2025 09:01:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1DDD63B00CD
	for <lists+linux-wireless@lfdr.de>; Wed,  2 Apr 2025 07:00:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDFB8230D35;
	Wed,  2 Apr 2025 07:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="FBy6Ri1z"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 081B3153598
	for <linux-wireless@vger.kernel.org>; Wed,  2 Apr 2025 07:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743577252; cv=none; b=T7eK9CQ4pA92Vq+265DFy3cY0wTyZe+Do6OaOCZJYef5CoWW+hMk0GJOBCuWHBbr3X7stE2hMvXIVoO1OPiMSWfRcmowEU1r6YS65Y/e84S6vjgdEx3CYJxO7TL565id1mK7mPQqB94RVXyjEG088VkR5VkmNbR71OQE6FrKMD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743577252; c=relaxed/simple;
	bh=9ayiZx9rFncz6OgXPXXYnziZ70R0I5M7s00a/rkkAjg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=WUAsiEzwiYErbFaApreCGbOrqmGyp06q6ORjmECnyxLQPscgkzRtKWLyRkq3oeZ76WIsGG0+ahvUezYk9nwMJxrav/ThtAI/RQh+BzsXcE/E3AYqC4O+PpjAUWrmZkBrTVTzrsSnb/XdmxpB57VjfukuWIGqXnIFiJjbJBeWfwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=FBy6Ri1z; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=9ayiZx9rFncz6OgXPXXYnziZ70R0I5M7s00a/rkkAjg=;
	t=1743577251; x=1744786851; b=FBy6Ri1zn3y6AL4hsr1mZ+Sl+HBEA1cGB7hWS5yqtUU//CE
	nX5Mppb1NXgvUKM1imOA6NzwSWpvhtdpUYaVNYxtZEwRTdH+8sCnohbCymv6hY1B1hqClg2ozNFZG
	Flw6O5Q1zWGtd+hQ288n8/r3uqFxdaf9loNxQ69IJfoHFk3mcDhhiXoLkHaFKn1sP0oc3pMDrTvsX
	v1VVtq/M5OucZMt+k2vCnx1AKm0nJhuXgjYI3lIbgP5DlInFsB4zE2e/4bnMp8YjUVbaCsDlXHjJe
	IvVpJLPa/1h/VH7MWiYa2TKnpuavknCqTft4tbVl+U1F+rORnrEpIj4FVr81S+Ew==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98)
	(envelope-from <johannes@sipsolutions.net>)
	id 1tzs5Q-0000000DEq6-3F8O;
	Wed, 02 Apr 2025 09:00:33 +0200
Message-ID: <9481e6a3844f897d03f8f4bfef335092f4ac76da.camel@sipsolutions.net>
Subject: Re: [RFC wireless-next 0/2] wifi: allow tagged control packets
From: Johannes Berg <johannes@sipsolutions.net>
To: Janusz Dziedzic <janusz.dziedzic@gmail.com>, 
	linux-wireless@vger.kernel.org
Cc: j@w1.fi
Date: Wed, 02 Apr 2025 09:00:31 +0200
In-Reply-To: <20250401201259.50627-1-janusz.dziedzic@gmail.com>
References: <20250401201259.50627-1-janusz.dziedzic@gmail.com>
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

>=20
> This is initial version I tested using Mediatek mt7915e and hostapd.
> Guys please check/comment.
>=20

How serious are you with this? ;-)

On a very quick read: the first patch cannot build, there's a security
issue I think, the nl80211 attribute is defined wrong, you're making
unrelated changes, and you're probably breaking older hostapd versions.

johannes

