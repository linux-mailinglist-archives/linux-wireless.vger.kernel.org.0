Return-Path: <linux-wireless+bounces-11096-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B8A2A94AEA9
	for <lists+linux-wireless@lfdr.de>; Wed,  7 Aug 2024 19:10:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 655AE1F226B1
	for <lists+linux-wireless@lfdr.de>; Wed,  7 Aug 2024 17:10:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97C5413AA2B;
	Wed,  7 Aug 2024 17:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T51O0akm"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F1315579F;
	Wed,  7 Aug 2024 17:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723050649; cv=none; b=pU01QrnfirupxxJ2Ymnqb8S9jjwCV/JLyH1ttPtKiUEeKtUdspHnvwRtnPMJ1lz2Pr8txpLEz8cgpq7n2XFej5jUkTZbMbb94TtXqMEamJd25mkBMDTMALFzNNwdnQYJwYIlDEz0f01laI3LD+rJzYOrS2yfJy1p43iU7jl569Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723050649; c=relaxed/simple;
	bh=xk2Tv4V0cPzqzOGcfe6GJ/EbeEuKg6080Cpv25FzTos=;
	h=Content-Type:MIME-Version:Subject:From:In-Reply-To:References:To:
	 Cc:Message-ID:Date; b=uWA2f/JGxoBvtHpvTsANNkEfRCve8ChfXqWHmagJYy8G0Bcv4On5HACcb45AsbDcJuPbaFdBhX3QL2wVQ2G80PIOyjEeoHLblRWkXACeWVod18bQqzBvKNUTj4+bW/JV5JRztrqQ3gvVHsUmaDyqOBAj/IopsRpCi6DZ+rfGZ3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T51O0akm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71323C32781;
	Wed,  7 Aug 2024 17:10:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723050648;
	bh=xk2Tv4V0cPzqzOGcfe6GJ/EbeEuKg6080Cpv25FzTos=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=T51O0akmdb6M7WZ7BV+YdPR9k5Apl/8AsS086gZt8VWEPiOtc9+dIO7xCHUvZOktK
	 bB/jvmmX9RvubmvZJeBlEoWP13eNP/HWFcaGBvuADWU3yaGf0cozsofQsxyNTXrzQ5
	 u6hKzwpuQXDezevJOt9PcwiiJO7AMO3XkSD/J17jjf0FaUSGd2/QlBhkn75+lFTOsV
	 uGpnUKAXLVVNPLAw3US3TjuvNiyWCnxj0BSaBngHJZfBEmce948xON3mw5LwmQAUhM
	 4ZbGvic0TqRddzHwH8qryBHL5f5yfrQ49uixmKYr3V0RxbczkmeKeb3oMPSUJVxJm+
	 psE3awbUQl05g==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: wifi: brcmfmac: cfg80211: Handle SSID based pmksa deletion
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20240803-brcmfmac_pmksa_del_ssid-v1-1-4e85f19135e1@jannau.net>
References: <20240803-brcmfmac_pmksa_del_ssid-v1-1-4e85f19135e1@jannau.net>
To: Janne Grunau via B4 Relay <devnull+j.jannau.net@kernel.org>
Cc: Arend van Spriel <arend.vanspriel@broadcom.com>,
 Hector Martin <marcan@marcan.st>, Linus Walleij <linus.walleij@linaro.org>,
 linux-wireless@vger.kernel.org, brcm80211@lists.linux.dev,
 brcm80211-dev-list.pdl@broadcom.com, linux-kernel@vger.kernel.org,
 asahi@lists.linux.dev, stable@vger.kernel.org, Janne Grunau <j@jannau.net>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <172305064456.3967444.13744761761168806442.kvalo@kernel.org>
Date: Wed,  7 Aug 2024 17:10:46 +0000 (UTC)

Janne Grunau via B4 Relay <devnull+j.jannau.net@kernel.org> wrote:

> From: Janne Grunau <j@jannau.net>
> 
> wpa_supplicant 2.11 sends since 1efdba5fdc2c ("Handle PMKSA flush in the
> driver for SAE/OWE offload cases") SSID based PMKSA del commands.
> brcmfmac is not prepared and tries to dereference the NULL bssid and
> pmkid pointers in cfg80211_pmksa. PMKID_V3 operations support SSID based
> updates so copy the SSID.
> 
> Fixes: a96202acaea4 ("wifi: brcmfmac: cfg80211: Add support for PMKID_V3 operations")
> Cc: stable@vger.kernel.org
> Signed-off-by: Janne Grunau <j@jannau.net>
> Reviewed-by: Neal Gompa <neal@gompa.dev>

Arend, what do you think? And as this is a regression I guess this should go to wireless tree?

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20240803-brcmfmac_pmksa_del_ssid-v1-1-4e85f19135e1@jannau.net/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


