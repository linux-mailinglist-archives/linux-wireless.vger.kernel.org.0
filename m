Return-Path: <linux-wireless+bounces-4396-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F25B8872707
	for <lists+linux-wireless@lfdr.de>; Tue,  5 Mar 2024 19:54:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8B58A1F26512
	for <lists+linux-wireless@lfdr.de>; Tue,  5 Mar 2024 18:54:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A400918E28;
	Tue,  5 Mar 2024 18:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bMN0TxcD"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8045A7C092
	for <linux-wireless@vger.kernel.org>; Tue,  5 Mar 2024 18:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709664863; cv=none; b=TxGXX8mP8n9V3hsat41dqLypmjxoZOotUPP0tlgxcsrj2h+YcDk0vCVZ3BpE7z/SzeVHkPrejaCyz2VgeHUYAukfhi/02PErDt3cMOKQ0D31kN6j8nLNCkb6gxrHIrlRKY1yWrXMvw2cnSSEbAG7gxvqSaTUVges99czwOc8+oU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709664863; c=relaxed/simple;
	bh=3lY4m/6cJGW8FKoKv7kry2BGRk7q/bXXnh/7Lg083AA=;
	h=Content-Type:MIME-Version:Subject:From:In-Reply-To:References:To:
	 Cc:Message-ID:Date; b=ExHvkvz8v+uLdJP0fxF1FtkZL/qYE4uRrwQ5m+APbPqjqbi9Dld/EdlxZ0/oXeXnTM7+8OoIeeCOQwKwqHYd77EPjSu40uw5+eJeP6YyXRWGYvP2tuVNhTgkquH15ho5NWncIQVhsbMF9UdSMTjvj7TImbUfur6Z1PrEAxqU/iA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bMN0TxcD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0B0AC433C7;
	Tue,  5 Mar 2024 18:54:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709664863;
	bh=3lY4m/6cJGW8FKoKv7kry2BGRk7q/bXXnh/7Lg083AA=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=bMN0TxcDK7arqjbK2YQxyQisbBZjPGJPKLBsclWJdtIPX3wqCdcXKTKjepuJ7+75j
	 715dDeN+Um/pWlsxPnYCo28as8G/EtFJBfF1grqj41Al095ndXSCz/IfZTT+pM1l6x
	 c+qdt20mcFCrg5uHD1npeb0xQwYUUc7sdMiyWaTz1XfFJAUA/tDiIm3XIvl4uu9ckE
	 6/ON2C7ir8APhsAEcbR/1qqcTw/bT0UsOzWqcY4uux61yc397LCZi1mfAn4XK3UzqV
	 PGzVzGrTYA0ycp2CrewzlKjDBjz9jDrzLru7ogoKZd5mQmXrOw2Yeyz3AT6fVbdADj
	 b20pNa2t1DUCw==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] wifi: cw1200: restore endian swapping
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: 
 <20240228121156.62f820aa6dfb.Ia63314e4d0ed1ee76f100846d68f0722abf6b793@changeid>
References: 
 <20240228121156.62f820aa6dfb.Ia63314e4d0ed1ee76f100846d68f0722abf6b793@changeid>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-wireless@vger.kernel.org, Johannes Berg <johannes.berg@intel.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <170966486094.424347.11119875384963522018.kvalo@kernel.org>
Date: Tue,  5 Mar 2024 18:54:22 +0000 (UTC)

Johannes Berg <johannes@sipsolutions.net> wrote:

> From: Johannes Berg <johannes.berg@intel.com>
> 
> The code here looks well thought-out, so it seems likely
> that the byte-swaps are actually needed, due to SPI bus
> and device behaviour. Restore the byte-swapping, in a way
> that doesn't result in sparse warnings.
> 
> Fixes: 7ceade653429 ("wifi: cw1200: fix __le16 sparse warnings")
> Signed-off-by: Johannes Berg <johannes.berg@intel.com>

Patch applied to wireless-next.git, thanks.

81e060584f1d wifi: cw1200: restore endian swapping

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20240228121156.62f820aa6dfb.Ia63314e4d0ed1ee76f100846d68f0722abf6b793@changeid/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


