Return-Path: <linux-wireless+bounces-7867-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B2E68CA895
	for <lists+linux-wireless@lfdr.de>; Tue, 21 May 2024 09:12:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B6B9E1F22480
	for <lists+linux-wireless@lfdr.de>; Tue, 21 May 2024 07:12:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D3904B5A6;
	Tue, 21 May 2024 07:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="gcEqeiaI"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 128274AEEF;
	Tue, 21 May 2024 07:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716275556; cv=none; b=SLDVcZ/cgRS5Sy2nNXvjzdmdLyxkRyhSDr4wG/bDMMhg4JzrPIUFMUWA9zKGaCsxsf3J0nhtWMqqhuFIZ3unMcPis7w3zrzTnAYaTQWwl5wZiJcXW0Gk8KIkoS3ybl1lV5OSuj7vkbS36x39L21mmVY9Uv4EAdG5xOdfX2lp28s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716275556; c=relaxed/simple;
	bh=kDc7UT5LoZBe6PeytpnUZ/gKC0Dp4tl9wAP7S5bANS0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=nHs0qtGisTZRF2wobFKrknQVIL66t6IR+cYRbfNiEPdKDoYCJLqexJ7JjxtgEDRTlemNxynh0lkfEdUV4hdETHkZRM+nK9neF2Det+DUZrG8BNQiH+FIgB0VCjkolfJSbvOpFksNHAYpKraiwdtCHKa3hqFkB3d1recPMc+r10g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=gcEqeiaI; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=kDc7UT5LoZBe6PeytpnUZ/gKC0Dp4tl9wAP7S5bANS0=;
	t=1716275553; x=1717485153; b=gcEqeiaIBAEQlA3ZdaifoTh8dKXjtyYu5wDQFVQ2ewFCSbm
	BZjeQQMiHPWUDMxe/ZkHJDKxDamYkg8O6EX12AyW8/rRqRv2gxKJlDwNdczPbjIVQ2Jnn/VsBwVJx
	LO6VI75mUuVdPcClssLJGEJKektZL40inuU+szJEEbs8uUnA/Wcmr+tGqI4ScV/O7azP1+/CcpSbo
	z4KIcxD/Dv0flaRa9NGI2kIOxxhsDxq6t1RTu36dKGNEWMThWd4+586jKAEQVIy1zIcw1DdNBeF6x
	sTs6HX8zVGPLzXdmVxB/nMhtEyB+xKGNBQQrnYiw2NsrM2243y2vj5yes536+6aA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1s9Jfg-00000001uhb-32p0;
	Tue, 21 May 2024 09:12:28 +0200
Message-ID: <0f42ab000dc2cdaf7a9b781a9ca7dad9478b705f.camel@sipsolutions.net>
Subject: Re: [PATCH] wifi: cfg80211: Lock wiphy in cfg80211_get_station
From: Johannes Berg <johannes@sipsolutions.net>
To: Remi Pommarel <repk@triplefau.lt>
Cc: Antonio Quartulli <antonio@open-mesh.com>,
 linux-wireless@vger.kernel.org,  b.a.t.m.a.n@lists.open-mesh.org,
 linux-kernel@vger.kernel.org
Date: Tue, 21 May 2024 09:12:26 +0200
In-Reply-To: <983b24a6a176e0800c01aedcd74480d9b551cb13.1716046653.git.repk@triplefau.lt>
References: 
	<983b24a6a176e0800c01aedcd74480d9b551cb13.1716046653.git.repk@triplefau.lt>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Sat, 2024-05-18 at 17:50 +0200, Remi Pommarel wrote:
> Wiphy should be locked before calling rdev_get_station() (see lockdep
> assert in ieee80211_get_station()).
>=20
> This fixes the following kernel NULL dereference:

How do you get a NULL pointer dereference from a locking issue? Was
something else removing the station simultaneously?

johannes

