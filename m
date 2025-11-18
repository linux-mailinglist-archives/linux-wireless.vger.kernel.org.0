Return-Path: <linux-wireless+bounces-29106-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 123CDC6AB0A
	for <lists+linux-wireless@lfdr.de>; Tue, 18 Nov 2025 17:43:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1EAD24E3B1F
	for <lists+linux-wireless@lfdr.de>; Tue, 18 Nov 2025 16:34:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D09336A03B;
	Tue, 18 Nov 2025 16:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="DsVHBMvN"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F4733730ED
	for <linux-wireless@vger.kernel.org>; Tue, 18 Nov 2025 16:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763483484; cv=none; b=s8VThooPQfsZneMvNJxwlubCVMpzquJQD6kCAH5iSxL7cbElHv1IsQUTJO6HZ/0oReb+9ow7vQ6QE8wLopg9pmBXg1i6Z5BTE1dAutZ+nMvBpTRUn1JDnR/2z1wKYLJ7zohzue13I2LMARXY4gFm8V6oazDxqxNqmHruclt8gfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763483484; c=relaxed/simple;
	bh=GvG+FArLxFnNo/bk4jWzamO53Hg6Yc3jF3AGihirxKo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=HGJ4H6wKHg+qFByOt9v7N95Md2n5YO30y2+TYty5lUNGB9yf9KhowO0aIAEV/o4p0dt6vN9pAjTDn1HtE66jBDNNKFAqNuynToo17UFzkCD1JeYAL2So0rz2pH+pV+tIwOLXu8s1uNhj9XQhhUgLbtX/zKERqWmIl2aM5NSWsSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=DsVHBMvN; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=GvG+FArLxFnNo/bk4jWzamO53Hg6Yc3jF3AGihirxKo=;
	t=1763483482; x=1764693082; b=DsVHBMvN5H5rj4psvpHAsRsj+KSuQcLcdr6TPZ9/sgKeI9G
	+FxL4oCKwEVOykbf1Scof1sy4Nossnfkrps2SrnH6xZIwCwia8BAAds7/QZpc8X47hncPSYNtQvNX
	tBUFMB83hJcSc/cxL5eWlXFIPDGNhXu2+I2mqlLyLwea0aCy3mVHXPhNOSwKGXajB3AmUlmCsWK8D
	LrEzPNuQ9G3gxcafcHixahlGGWSRLY5+tFQdMqD2krXKuRiRg+0xprVu/3PaQWDfmnHBs53AHDhTs
	nIXmTE79VT4QK8vaM4hgVvhiwlGC6b06Yt2m4kQ8MmDxoo2HPWb4TQR2WMwvCfHQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1vLObv-0000000018F-44Vo;
	Tue, 18 Nov 2025 17:31:20 +0100
Message-ID: <5ec4190eb06c2b3763b8eb9d114a200d07437c11.camel@sipsolutions.net>
Subject: Re: [PATCH wireless-next v2 0/3] wifi: correctly represent S1G
 channels
From: Johannes Berg <johannes@sipsolutions.net>
To: Lachlan Hodges <lachlan.hodges@morsemicro.com>
Cc: linux-wireless@vger.kernel.org, arien.judge@morsemicro.com
Date: Tue, 18 Nov 2025 17:31:19 +0100
In-Reply-To: <20250918051913.500781-1-lachlan.hodges@morsemicro.com>
References: <20250918051913.500781-1-lachlan.hodges@morsemicro.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

Hi Lachlan,

On Thu, 2025-09-18 at 15:19 +1000, Lachlan Hodges wrote:
> This patchset correctly supports S1G channels within cfg80211 and mac8021=
1.
> Preliminary discussion can be found in [1] and the v1 RFC can be found in=
 [2].

I was just looking at chandef stuff for NPCA (see the other thread), and
noticed that S1G isn't really (fully) represented in

 - cfg80211_chandef_identical()
 - _cfg80211_chandef_compatible() (not sure about this regarding primary 2m=
hz)
 - nl80211_send_chandef()

Seems to me that some things should be added there?

johannes

