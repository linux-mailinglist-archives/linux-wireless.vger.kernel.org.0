Return-Path: <linux-wireless+bounces-11249-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F13B894DBB8
	for <lists+linux-wireless@lfdr.de>; Sat, 10 Aug 2024 11:08:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1939F1C20D88
	for <lists+linux-wireless@lfdr.de>; Sat, 10 Aug 2024 09:08:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D422314B957;
	Sat, 10 Aug 2024 09:08:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YCHzy3lH"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9671214A4E7;
	Sat, 10 Aug 2024 09:08:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723280881; cv=none; b=nvR0+4/L/Wvh4WHXX3W6G/ueOfFhG7U42TiDvMt9R8QVYxetr8DJR9VJ4pEkSL9P4AcIuLiGrLtANh3KZbVfL32vyfvDPtuEnHlMcGHDUPK6XckoTIcId73GXPOtRizGiaku41+oUQepGH58PwlsoWhldpBBSfKF5/K10ZtYuEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723280881; c=relaxed/simple;
	bh=LSEYZZaYbNQKdqepD0wrNbt38kVeyCJHNCV1B8OLWb0=;
	h=Content-Type:MIME-Version:Subject:From:In-Reply-To:References:To:
	 Cc:Message-ID:Date; b=OOIcbLEFvJgCZ217LGy5zS0BRjXhS91bZeUDzACplPgH3YxZKH1jjhgzsn+BX07atOtbKOZniIlXWAsO/EJQjZher/OqEfKV+Me1mbE9GvrLFBW2UgZ2AAOL3WXSw9S5OHeSsBKc7Ie3NryFgIV/6TkgqTyvDLZhjtD0QTkoaJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YCHzy3lH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE5A4C32781;
	Sat, 10 Aug 2024 09:07:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723280881;
	bh=LSEYZZaYbNQKdqepD0wrNbt38kVeyCJHNCV1B8OLWb0=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=YCHzy3lHvOir9DBkkeH+WRA2Snnc7MgU8kc8LFFsWRjSD8Pmd9zly3f7URUg/zqNy
	 FlkyhiK4D+Ae6eAsK5w4GNnbLl8w03DCr6pCyKiGVrNSYYHHZvkTqQgeIPzmyG8Cbk
	 L55ovnJ276uICnKbf5A8Bey2EoAz69wS1BYCDkEYbHzSq76pOFKOIAB4G57OXNDgth
	 hE5vSnoMGwm311bfOlJZiJ6IwBjwruCcQq8ahuoII2Hdc23KMx6W3K97mW4cxEaYk9
	 aXBt3xDft7dWQfJ7RYg4BNYp146um824zbV5TuKRIHdC6LMpTzs5fVqRcu+E7kbDwu
	 2hnlhOz9aA6gA==
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
Message-ID: <172328087714.488646.5392085332216751958.kvalo@kernel.org>
Date: Sat, 10 Aug 2024 09:07:58 +0000 (UTC)

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
> Cc: stable@vger.kernel.org # 6.4.x
> Signed-off-by: Janne Grunau <j@jannau.net>
> Reviewed-by: Neal Gompa <neal@gompa.dev>
> Acked-by: Arend van Spriel <arend.vanspriel@broadcom.com>

Patch applied to wireless.git, thanks.

2ad4e1ada8ee wifi: brcmfmac: cfg80211: Handle SSID based pmksa deletion

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20240803-brcmfmac_pmksa_del_ssid-v1-1-4e85f19135e1@jannau.net/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


