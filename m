Return-Path: <linux-wireless+bounces-23265-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C6747AC03AB
	for <lists+linux-wireless@lfdr.de>; Thu, 22 May 2025 07:03:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 85E8116C85C
	for <lists+linux-wireless@lfdr.de>; Thu, 22 May 2025 05:03:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E39B158DD4;
	Thu, 22 May 2025 05:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="t+jG0B2h"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7837B288CC
	for <linux-wireless@vger.kernel.org>; Thu, 22 May 2025 05:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747890202; cv=none; b=eZ+5RcA0hV64hA+ZTrcJJqj/A//qnh1ouMRab++/9jsEYaH5uzJuqiM/Gcr3kZ2WdII4rwsvOloQXLPo4GEaDHy0Ekfq0TIuc0RkCBpcK7W6Ck+RDYzb7M7klKS3SrtFcGdpHfIDOXSIZD8w6nbyHH6zEC3p7DAw1U9eoAmA9zQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747890202; c=relaxed/simple;
	bh=2RWQTJsyrAiM9B9qOaNCL9XvzcuObrK0iyusrlA4Ur8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=m/lx8Qmzc0Iv9jpp3EmnHtSgMPrPuSdBuV5WyrWXfGy0vqvVLo7dapq4IbMchC4OV1xzbm1fgDxQIJtDEUAqF5g7buqFUP36pomjLHQ8Uapbvo8rW/crN31+Vlqf/3DiscOc6dHvoZR+9hcgu9tDYlDGlVaVnbPCimvdOeBXXAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=t+jG0B2h; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=2RWQTJsyrAiM9B9qOaNCL9XvzcuObrK0iyusrlA4Ur8=;
	t=1747890200; x=1749099800; b=t+jG0B2hbe7jF6/R6NCMmqBb+VLT154x/4ZdTJgY3kyo7TH
	8Y22NkqkA48Xr6qRzfvB0s3dFW7sdWzNGUwXjyePbAsjh/y2Oaqlq1c/kFUX5BR9cEfpm0BrHy9dp
	S0m8Q+mlzhzJvFCJJEwU4AuAhrIhYIIui2bNOKkU0lWRydw7Jr+Im5ekaO/tpkVVWv99Fk4O4ngCZ
	uapX3opXZfh6WIUTYR9iS5VgLebqJuu6IAMx0a4x++hXnVJah0wnHTqui+kLyoRMxNBOKTVhsB0bU
	lz6s2zscon++vhrGAqOPu1Wlc1OdZR/U1KAs910C95TTtEmw4jnT+TJduXkTsSpw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1uHy5M-0000000G7MQ-3tpc;
	Thu, 22 May 2025 07:03:17 +0200
Message-ID: <df3d08425fc7d5db127ccf2e84c258b7c728b751.camel@sipsolutions.net>
Subject: Re: [PATCH wireless-next v8 06/10] wifi: mac80211: add support to
 accumulate removed link statistics
From: Johannes Berg <johannes@sipsolutions.net>
To: Sarika Sharma <quic_sarishar@quicinc.com>
Cc: linux-wireless@vger.kernel.org
Date: Thu, 22 May 2025 07:03:16 +0200
In-Reply-To: <4bf37331-5989-4b60-8981-ed20cd79969b@quicinc.com>
References: <20250515054904.1214096-1-quic_sarishar@quicinc.com>
	 <20250515054904.1214096-7-quic_sarishar@quicinc.com>
	 <7930179174c97d598a40b789abc43cb36c947dde.camel@sipsolutions.net>
	 <6aca52d3-b8d1-4e71-a51c-1fb6250859c3@quicinc.com>
	 <45ce63e59fbf1c49ca295f23f802c2a6eebfdfaf.camel@sipsolutions.net>
	 <4bf37331-5989-4b60-8981-ed20cd79969b@quicinc.com>
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

On Thu, 2025-05-22 at 10:13 +0530, Sarika Sharma wrote:
>=20
> > Indeed, weird, why do we even bother counting them per AC?
> >=20
>=20
> Currently, tx_packets and tx_bytes are maintained per AC only in mac80211=
.
> I'm not entirely sure why this per-AC tracking was introduced, as I=20
> haven't come across a specific use case that justifies maintaining these=
=20
> metrics separately per AC.
>=20
> I also checked to see if there are any other parameters tracking=20
> tx_packets and tx_bytes, but couldn't find any.
>=20
> Would you like me to consolidate tx_packets and tx_bytes instead of=20
> maintaining them per AC?
> Or should we consider this change separately as different patch?

Let's say that's different and unrelated, maybe we had something
accessing it in the past.

johannes

