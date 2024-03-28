Return-Path: <linux-wireless+bounces-5489-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DE7289084C
	for <lists+linux-wireless@lfdr.de>; Thu, 28 Mar 2024 19:29:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7D5B7B22050
	for <lists+linux-wireless@lfdr.de>; Thu, 28 Mar 2024 18:29:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 255F742AA1;
	Thu, 28 Mar 2024 18:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="fiptjXpb"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83B503BBDC
	for <linux-wireless@vger.kernel.org>; Thu, 28 Mar 2024 18:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711650538; cv=none; b=FpaUFWr7FfLONcEHYTVaTad3Ozgh5LG+FygT1OtUr0Zw1Ifc2AhxFiAatzZjtHhRg8U2YjyKPNhmouTcDsmHHpulgXmRYYFydZZBDI1EruykCaPz8cqyUkCEM0fk3cgBZN3O+wfOlZNlIkgj7c5sGOjsfHIuND3XAVM/xhgznVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711650538; c=relaxed/simple;
	bh=Os7iyALeJRu+Egif75ri/2HcOX0TV1ifT7zdnaFb2TM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jPDoIxwAGTe49LOmgmIpwaCZXq7jnTuXyhxygTi0DszrcmvEAUvLLqlyEA49xBKMTSPI5XNOeVREUClJIYY0BWmAh3TZTudapNHb+CFPPAyY3NlZnbpoupDtZhcq95odx1o2irCLLGaavOF9tGxvAznzAFRcOd+F2K76JV3IU5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=fiptjXpb; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=Os7iyALeJRu+Egif75ri/2HcOX0TV1ifT7zdnaFb2TM=;
	t=1711650536; x=1712860136; b=fiptjXpbx4HGSaw3SljP0ZlMZCquzCK6yh1V2HUkW4wyq86
	r4ONyeM1JLpnn/MVS7714wsHr+LgKbn+FrGi1lkcjB+lRgfTfn8BcfcNXH92rnr7uog5imYisuJZv
	hp17yocvDkuPJLeC8PSW9fkrua+6ffy023+TtO7XetUhE4BEI4c6QaACAYUQUzqZJ3BX/h6TOBCqX
	JV9fsdpy1YiJM+qJQGzQ8OE9fMeNvhz6zRN0eCLmhy2dzztIjP0PYsE2gNwsSf6AC7d0pe9oktX6J
	5KnXGCZqqJwfjksV9mclAYTym8D2i6xKsg/Z3/SLVBg8SGyaANXx8x35vebQKEVQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1rpuUg-00000001DvG-1EWo;
	Thu, 28 Mar 2024 19:28:54 +0100
Message-ID: <3009b152cd9f95065860d2de6b7ff8ee5775e579.camel@sipsolutions.net>
Subject: Re: [PATCH] wifi: mac80211: ensure beacon is non-S1G prior to
 extracting the beacon timestamp field
From: Johannes Berg <johannes@sipsolutions.net>
To: Richard Kinder <richard.kinder@gmail.com>
Cc: linux-wireless@vger.kernel.org
Date: Thu, 28 Mar 2024 19:28:53 +0100
In-Reply-To: <20240328005725.85355-1-richard.kinder@gmail.com>
References: <20240328005725.85355-1-richard.kinder@gmail.com>
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

On Thu, 2024-03-28 at 11:57 +1100, Richard Kinder wrote:
> Logic inside ieee80211_rx_mgmt_beacon accesses the
> mgmt->u.beacon.timestamp field without first checking whether the beacon
> received is non-S1G format.
>=20
> Fix the problem by checking the beacon is non-S1G format to avoid access
> of the mgmt->u.beacon.timestamp field.

Huh, how did that end up being a problem, since iwlmvm with older
devices is the only driver using that flag, and it doesn't support S1G?

It's still correct, but it shouldn't be a problem now?

johannes

