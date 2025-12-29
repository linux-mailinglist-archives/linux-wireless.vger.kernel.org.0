Return-Path: <linux-wireless+bounces-30162-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E84FCCE678C
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Dec 2025 12:12:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E57C03013399
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Dec 2025 11:11:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E26F52FB085;
	Mon, 29 Dec 2025 11:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="E9E2qEvA"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3568C2FA0C6;
	Mon, 29 Dec 2025 11:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767006690; cv=none; b=LVAEF9saGhM7BKjD0tH2ClY0mHEHU6Inp7QnEHqKzs5k5wzJSWFcLg+Gow/Uwil3tayRhhqBsQbiNcfmGn+gQGujXPEhRfVRUTUx91yckLLfpRhXZhI7C6aGyo9ePQnHKvxufbypmJqqs58aVI9qZ5LflbNTfvcFKSSPUbTXMbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767006690; c=relaxed/simple;
	bh=CeWtfXoQuDQXYXiGZTjxqllhDtPsRxAFjeuCZvLHAvU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=UeYFTUqYLOGpgY2vkm4L0SH/GhfGtvGMR8cdgvpaJpuUg9MREThbT6276X3ELjHCD+peKwuo3FRQSukRRgGFApQ4dnGI5XDqLLASPcVNzNS47FJmo+DHYHw879Z7zZn6YqoWy6H6t3XYqHR0Za7FXfybFAkItxQjNJkENo71haw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=E9E2qEvA; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=CeWtfXoQuDQXYXiGZTjxqllhDtPsRxAFjeuCZvLHAvU=;
	t=1767006689; x=1768216289; b=E9E2qEvA/5GrGAo6MrhbEXI0Y+07sFfsWpKoSdh/5/sfT7A
	/pTnchsS2KMTviX5gi5MjUQCHrtm0+CpDzspdnxPtdCKkIpjl7gyQuWjdjyPKflQ9on+Y58gIuOmG
	pwCpoyh2/y83hAj1elMSNdbesG5eiup7x5jNXTuQy15EcuQG+W+f8fMcg/Rt9dHjfwX/3yjljn6v3
	wrF2C7EOAlHsFga3BNIdNy6DoOZ0tsMZPRW+uweH2wRQNCC6O+RK96xKCNgjhzjjkNb3Jy7yV9pOh
	DN+xlhheElG9jsRxfBlNN/CysyTd1AppuyfwJSKyrfzq1ChNT5ts4acMjGvdlgsg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1vaAbb-0000000CV0d-3cir;
	Mon, 29 Dec 2025 11:36:04 +0100
Message-ID: <21f1759416ae907b8504605cd8a814dc85a99a0c.camel@sipsolutions.net>
Subject: Re: [PATCH v1 2/4] wifi: rsi: sdio: Reduce use of #ifdef for
 CONFIG_PM
From: Johannes Berg <johannes@sipsolutions.net>
To: Uwe =?ISO-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@baylibre.com>, 
 Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org, linux-wireless@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Date: Mon, 29 Dec 2025 11:36:02 +0100
In-Reply-To: <f291cca2741f6ac994b2bde1fb9d21194fec4d3e.1765968841.git.ukleinek@kernel.org>
References: <cover.1765968841.git.ukleinek@kernel.org>
	 <f291cca2741f6ac994b2bde1fb9d21194fec4d3e.1765968841.git.ukleinek@kernel.org>
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

On Wed, 2025-12-17 at 12:09 +0100, Uwe Kleine-K=C3=B6nig wrote:
> This drops two #ifdefs (which is good because they are ugly) without
> changing semantics. This also improves compile coverage because all the
> code in the first #ifdef block is now compiled even for configurations
> without CONFIG_PM (and then thrown away).

This didn't build, and given that we never got 1/4 I'm going to assume
it wasn't destined to the wireless tree.

johannes

