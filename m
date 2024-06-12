Return-Path: <linux-wireless+bounces-8854-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D1D5905112
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Jun 2024 13:06:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 891DF1F22CCA
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Jun 2024 11:06:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF63B16EC1B;
	Wed, 12 Jun 2024 11:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="Jwu7Rk+m"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EF563D388
	for <linux-wireless@vger.kernel.org>; Wed, 12 Jun 2024 11:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718190378; cv=none; b=A38CMlPGIIDV4aki3M4Lv9h4ptV/DWGmnP5dH8a2wrqM2pnkwVks+CSQDCDEdEp0396jKlV+HenU2U4+qMd1iXpXhqmr7mYs+Y71iVbDKmhnY2ve+euQjlnAX44qgwue6KLcW4k57mk1jKW3wAJ674HV80zbhU4MjgRtAzSicT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718190378; c=relaxed/simple;
	bh=9HxlKVUDBe1qZeoGLrRCe2lMtSVBlFdHwBPRzlwSVxE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KjG9FJ0RwnNsRqFSN5A4neljLBo6Navx9TqWivxKSZIduoKSRH8xcPLae1QzjlBTM8qizXrcgJTEJLbOgEuX+wUATcF5qaxrqbsdLFzNWQCnvru0oTd0oJgmPrdb84r6BoSf0HF0DtPjubIptKIT4NCxMWAgUvZzoaiRN0fMbkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=Jwu7Rk+m; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=9HxlKVUDBe1qZeoGLrRCe2lMtSVBlFdHwBPRzlwSVxE=;
	t=1718190377; x=1719399977; b=Jwu7Rk+mP7gWk1/sL4X8r1et3TgbpcrmjmT8ne5qdGkr4qS
	U8wlsD5ALSESiIcI0g9jAyPXK5LyN0sLmwrvfbdQVTYDi3uFvJ5a+tU99yJYtXPbb5eCQaSytyFkJ
	9EA4jEIey4SDICyQLklvdTsV2OUwOpPN1ekKenu8UPVVBGD/hPZxT+MwCyH3+c2LKvx9L/bVVcxvP
	Lny1t4rPIR9NSDP5lOMDh6O7kQrLJ/pj4uA1+di0opK0ObJsN5nzeEcn+Br1E4QVVhavoXo0Xr8O3
	Vb4iliwdoKQCmJJHYozUO5a88W0QUVQFfE5S8WSgtSVAqqe7szpRlD9x3eRAnMbA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1sHLny-0000000ABku-10aV;
	Wed, 12 Jun 2024 13:06:14 +0200
Message-ID: <ef80a0b77fcab051e256deb310c725d4d8884fbd.camel@sipsolutions.net>
Subject: Re: [PATCH 0/4] wifi: cfg80211: fix per-STA profile BSS entry issues
From: Johannes Berg <johannes@sipsolutions.net>
To: Veerendranath Jakkam <quic_vjakkam@quicinc.com>
Cc: linux-wireless@vger.kernel.org
Date: Wed, 12 Jun 2024 13:06:13 +0200
In-Reply-To: <1718009524-5579-1-git-send-email-quic_vjakkam@quicinc.com>
References: <1718009524-5579-1-git-send-email-quic_vjakkam@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.2 (3.52.2-1.fc40) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Mon, 2024-06-10 at 14:22 +0530, Veerendranath Jakkam wrote:
> This patch set contains bugfixes and cleanups related to per-STA
> profile BSS entries.
>=20

It also has RCU bugs (per warnings in the hwsim tests).

johannes

