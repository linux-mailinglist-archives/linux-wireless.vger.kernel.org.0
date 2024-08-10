Return-Path: <linux-wireless+bounces-11243-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AF7B894DB39
	for <lists+linux-wireless@lfdr.de>; Sat, 10 Aug 2024 09:39:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5F4FF1F21BF9
	for <lists+linux-wireless@lfdr.de>; Sat, 10 Aug 2024 07:39:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 437F845BE3;
	Sat, 10 Aug 2024 07:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JzQOOFha"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1841D4409;
	Sat, 10 Aug 2024 07:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723275547; cv=none; b=U7I8p8NUFeihZ7zfnsDG6WSXGEhmVjH0aiEvXLIrxLNoqTQXqJtOI7NgVnEDkYU2uAiIWhUM9jUNjOEFutfSFvQ1sLx1W2HxBI4eVMjqqkiLwbjubtZdwCPjFFF3YK2X6/GGQsPb+ujENrGRHfYca+S7r0lAYkbIL6aSyipTYwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723275547; c=relaxed/simple;
	bh=BKN7eEO6247XJ7M0uWy7T9SpOKqKHpaK9T5Y77p68p4=;
	h=Content-Type:MIME-Version:Subject:From:In-Reply-To:References:To:
	 Cc:Message-ID:Date; b=d/hO00KbJDKas8o2q8VHl/wc2SmFMZpLqh3tiTLk5nBbVB4abwijYBqeI/ik2QqkX0T3s6TTaShogQWnsBB9uUZlkYRQh/1XqA5iQ8EB/nzFqXrQt6Cgt1wsnKIwzPM8tmHUqZU5FWfo4DtlTAt7L2pKSTM5gSzhgx76l0UaWOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JzQOOFha; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C2D1C32781;
	Sat, 10 Aug 2024 07:39:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723275546;
	bh=BKN7eEO6247XJ7M0uWy7T9SpOKqKHpaK9T5Y77p68p4=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=JzQOOFhauxRbDpcktDviZlJigf82beXA4eI6nJ7HxpulQOPpGtOF7YErqiiutxs+h
	 oqpglHNYEAghn/J7yp5A5gfWfVjPmhBmJG5xyIzpNG1G4AUgY9J61w9bASJ4BQ0sIE
	 DwEK0rqHCnErWkY6KGENAqtXJYiuYCwhhDE16cR5Ya4HCMEFwLDaKm1zvDYggrTntq
	 D5DXfYSwsJhpMgL2LNED4nxCMAs/WpnXeEwRF4WGem1jVxR0PPLO0zbrmITXybIq47
	 5ZOHqfVshmywOoTxy4qSMgfKr/GF32FkjIpGJn6L3RkOkSxkgN0zIXfPPLFTJTirnn
	 wZL/UxhFO/GWQ==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v4 1/3] wifi: mwifiex: simplify WPA flags setting
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: 
 <20240805-mwifiex-wpa-psk-sha256-v4-1-e1eee80508e6@pengutronix.de>
References: <20240805-mwifiex-wpa-psk-sha256-v4-1-e1eee80508e6@pengutronix.de>
To: Sascha Hauer <s.hauer@pengutronix.de>
Cc: Brian Norris <briannorris@chromium.org>,
 Francesco Dolcini <francesco@dolcini.it>, David Lin <yu-hao.lin@nxp.com>,
 linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
 Sascha Hauer <s.hauer@pengutronix.de>,
 Francesco Dolcini <francesco.dolcini@toradex.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <172327554335.395581.13187629837954009763.kvalo@kernel.org>
Date: Sat, 10 Aug 2024 07:39:04 +0000 (UTC)

Sascha Hauer <s.hauer@pengutronix.de> wrote:

> The WPA flags setting only depends on the wpa_versions bitfield and not
> on the AKM suite, so move it out of the switch/case to simplify the code
> a bit. Also set bss_config->protocol to zero explicitly. This is done
> only to make the code clearer, bss_config has been zero alloced by the
> caller, so should be zero already. No functional change intended.
> 
> Reviewed-by: Francesco Dolcini <francesco.dolcini@toradex.com>
> Acked-by: Brian Norris <briannorris@chromium.org>
> Link: https://lore.kernel.org/r/20240723-mwifiex-wpa-psk-sha256-v3-1-025168a91da1@pengutronix.de
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>

3 patches applied to wireless-next.git, thanks.

eb84567e7208 wifi: mwifiex: simplify WPA flags setting
36aa64991543 wifi: mwifiex: fix key_mgmt setting
ca0107c3aa30 wifi: mwifiex: add support for WPA-PSK-SHA256

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20240805-mwifiex-wpa-psk-sha256-v4-1-e1eee80508e6@pengutronix.de/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


