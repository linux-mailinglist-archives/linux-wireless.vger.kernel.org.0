Return-Path: <linux-wireless+bounces-3251-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D12484BCB4
	for <lists+linux-wireless@lfdr.de>; Tue,  6 Feb 2024 19:08:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9031B1C24A08
	for <lists+linux-wireless@lfdr.de>; Tue,  6 Feb 2024 18:08:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE31C13FE5;
	Tue,  6 Feb 2024 18:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b/ynmLG+"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB13413FE2
	for <linux-wireless@vger.kernel.org>; Tue,  6 Feb 2024 18:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707242889; cv=none; b=OHoe1QtEisOP1/b0xlriVCXoybw6nt3y8PHwEcfiHHiNsd/nZaMa5YFOGanpcqLriIx7ZAzFvA0hQRBLhaMYAP1IEvhCeZ+m162Z+fPz6K+4cXt4f9UwaTfqk1xv5MWiePloE17flPAags4t8nUff09q28z1AYxFPbkg9fRcYck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707242889; c=relaxed/simple;
	bh=vhcVBMZ4ckx0a36MeZ4piTJM24iC7PFwjhZJh0U0wlU=;
	h=Content-Type:MIME-Version:Subject:From:In-Reply-To:References:To:
	 Cc:Message-ID:Date; b=fobtZDBXB7hC7oqAQLrpcz+Oi3fuVsDn5lXgCRsC4lHdV7LXHNpSOqwqdYLqGDdvIdppmxX/f7HvSRzHzlyjvqhz9+lubBOTQY0M29om/mBhSntjwKwjO3pDYXbcvdeYFyd+a/HA4YS7eLlQ0V3fpa5ENa52C7qxe+4hdrP2oNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b/ynmLG+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5E57C433F1;
	Tue,  6 Feb 2024 18:08:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707242889;
	bh=vhcVBMZ4ckx0a36MeZ4piTJM24iC7PFwjhZJh0U0wlU=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=b/ynmLG+nys+rQGGN3A6p/Xu07rywIEtgERbRPdXa9wry4iv8ZXb5MmdBROT1vUlN
	 KcGGN61m7yRxK0KgwCg3fxCwd5HUxzYK449Fg1x+Okl4GWGQHqFplug493XH3rxJUb
	 MH5c6bbJl1tLYHFH60kJTFbCIBjenlzf9Z81GYGCNo6uPgNG/umL/Rgd9CUaEq7onP
	 kZXeqY6EmF7ikUVYZpe34LI2CrHqmVIVhArc4bQn++jyaICF7xarWpPv2xRKJLt5VS
	 TxIuDm85Oiig90pUmRGiLokgYX0guZY790gT43q1CkA2BZX0wLav4cro6CYoi2/avI
	 4w2V4visO+Jsw==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v3] wifi: rtl8xxxu: update rate mask per sta
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20240205093040.1941140-1-martin.kaistra@linutronix.de>
References: <20240205093040.1941140-1-martin.kaistra@linutronix.de>
To: Martin Kaistra <martin.kaistra@linutronix.de>
Cc: linux-wireless@vger.kernel.org, Jes Sorensen <Jes.Sorensen@gmail.com>,
 Ping-Ke Shih <pkshih@realtek.com>,
 Bitterblue Smith <rtl8821cerfe2@gmail.com>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <170724288621.1979906.8357092372743137291.kvalo@kernel.org>
Date: Tue,  6 Feb 2024 18:08:07 +0000 (UTC)

Martin Kaistra <martin.kaistra@linutronix.de> wrote:

> Until now, rtl8xxxu_watchdog_callback() only fetches RSSI and updates
> the rate mask in station mode. This means, in AP mode only the default
> rate mask is used.
> 
> In order to have the rate mask reflect the actual connection quality,
> extend rtl8xxxu_watchdog_callback() to iterate over every sta. Like in
> the rtw88 driver, add a function to collect all currently present stas
> and then iterate over a list of copies to ensure no RCU lock problems
> for register access via USB. Remove the existing RCU lock in
> rtl8xxxu_refresh_rate_mask().
> 
> Since the currently used ieee80211_ave_rssi() is only for 'vif', add
> driver-level tracking of RSSI per sta.
> 
> Signed-off-by: Martin Kaistra <martin.kaistra@linutronix.de>
> Reviewed-by: Ping-Ke Shih <pkshih@realtek.com>

Patch applied to wireless-next.git, thanks.

94dd7ce1885e wifi: rtl8xxxu: update rate mask per sta

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20240205093040.1941140-1-martin.kaistra@linutronix.de/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


