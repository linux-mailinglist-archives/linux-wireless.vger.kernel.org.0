Return-Path: <linux-wireless+bounces-26795-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8ACCFB3A2FB
	for <lists+linux-wireless@lfdr.de>; Thu, 28 Aug 2025 16:58:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B15BD16F9F1
	for <lists+linux-wireless@lfdr.de>; Thu, 28 Aug 2025 14:54:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 745C8314A7C;
	Thu, 28 Aug 2025 14:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="ohl0HbJb"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF2FC313540;
	Thu, 28 Aug 2025 14:54:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756392854; cv=none; b=CjjfNkPU3oTzf8ZMaAAeaKQ13MOYqi9GC+4GbaLLcUURGxFcyvPVQviwVfZCb6jq9g6xVFu94rZ1aYvxwVWjm4ebw/aXZ3lRGVKNVX5aqF24K5U58VRvItKtsiPUC0f7vdJmsmINpsR5bviIIpjg4dvsn4Lurd60hASYpKoo28Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756392854; c=relaxed/simple;
	bh=Axe3GiX0KWuHdq648BBKxhYTpI0L6SMgldy+5//9F5w=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qgPHFWtZuZzsxUmPq8dVeBePtMfhzKgjFnWdEvfq4hLjXCHQaLQ8BRFZ0t55FflDG8CxxLCj3J6Rj8H0pZG/xfaGA9iMcyZI5fDlnYjDR1kYJ1+feh+NRLfw23WRrfdjUvIPjP31+q8KxescWuLTmtXjCMxwTQgS7a3hu82Rv/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=ohl0HbJb; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=Axe3GiX0KWuHdq648BBKxhYTpI0L6SMgldy+5//9F5w=;
	t=1756392852; x=1757602452; b=ohl0HbJbeOMI0sSW/B1e09UbTTQuuKFYPkD0FvPV/RfqZ3D
	TuhnQ2CnMYdo+fDnvjeZxM05oHDZgciRvBGIlzXt6mj8inD7G6WaY0N6pwDK4r1PYGFMsGhMrfR8s
	Dmy3J6+rnAX6ka3UySwGpGidX4yGmbzFWU3pJrM7JcrO0/e5cKdCv1hE6WDIbKtapBWYBEe4O9m+y
	rp6RXT1779TYqrbznAE9A+PsuzTaqYpB5v86E7DSaGsrMB6uoy6JveUH0VyfPEXhVJsfWA/gNNDhR
	PcNnkRLPX7Zf6LG8Pqec2oMKO9/+f1eM7fZGwycU1XUjic8SRlWInP1G/P3X7NMQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1ure0v-00000007j58-3z8W;
	Thu, 28 Aug 2025 16:54:10 +0200
Message-ID: <def5293e36f56b004f43192126fb5832c73f32cc.camel@sipsolutions.net>
Subject: Re: [GIT PULL] wireless-2025-08-28
From: Johannes Berg <johannes@sipsolutions.net>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, linux-wireless@vger.kernel.org
Date: Thu, 28 Aug 2025 16:54:09 +0200
In-Reply-To: <20250828075305.46c22eb5@kernel.org>
References: <20250828122654.1167754-8-johannes@sipsolutions.net>
	 <20250828075305.46c22eb5@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Thu, 2025-08-28 at 07:53 -0700, Jakub Kicinski wrote:
> On Thu, 28 Aug 2025 14:25:58 +0200 Johannes Berg wrote:
> > Back from vacation, and a bunch of things accumulated
> > for everyone. Nothing really stands out much though,
> > except perhaps the various iwlwifi regressions for old
> > devices, which were all my fault...
>=20
> This missed today's PR.=C2=A0

Yeah, I figured that would happen, I was late, but also got things late.

> Would you like me to pull before
> merging back to net-next? Or no preference?

No preference. Probably more regular to pull back first?

johannes

