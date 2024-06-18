Return-Path: <linux-wireless+bounces-9143-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 105E390C7C7
	for <lists+linux-wireless@lfdr.de>; Tue, 18 Jun 2024 12:53:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B7A2E1F27648
	for <lists+linux-wireless@lfdr.de>; Tue, 18 Jun 2024 10:53:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB25A1C68A3;
	Tue, 18 Jun 2024 09:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qVyHeanm"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4ACA156C4D;
	Tue, 18 Jun 2024 09:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718702231; cv=none; b=KEFY/kbwDzaU6jabzGejV56Atcz9hqt+me3dj7Oxj+NRvkxgRR1nQIH2gSIxKqpGReh+VKwZADS+Mdxf4gpR2npcyVhLihLm5nvlcAjNc3Wm2ML7H6OGccLioHm2mHF1iAB6welq+qLTJHdnM234ukS7/Nj6ZMShHOxDtcZ4TiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718702231; c=relaxed/simple;
	bh=bVM/wNshXVKtKxNQEyic/R88Vg3RjF7v2rfuUQOJzq8=;
	h=Content-Type:MIME-Version:Subject:From:In-Reply-To:References:To:
	 Cc:Message-ID:Date; b=h19p078vHTIQ2PXVO9FMWxMs25HRKtKKQviCRmYie9nFBab7obXvgV9tOBspitzZm1mfNyxqAHbDU7bCthd3aWHbk8miq0RzF6yZyUkC7aH4v3ZM2QVp//9LsDY/dFHbPEhqGG4IM96TUFVKaS596HY08+XSs/+AUvS/AgOxc4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qVyHeanm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 113EAC4AF1A;
	Tue, 18 Jun 2024 09:17:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718702231;
	bh=bVM/wNshXVKtKxNQEyic/R88Vg3RjF7v2rfuUQOJzq8=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=qVyHeanmhYTc2upUTpLxu7lmzE0z9cTjZCBV6o54CbhBnkdaxvZrxfFacUb7bRiXc
	 8oi+lnFIb5wVUXGVyxgUqwmqp1gL9nu1MZxAkWePyFGcV6O/KuTTvrRZhla2GqeUYv
	 ezcKLwjMvztm5+2dpNvV3yQdnUSyXGSaUODonMwBxb3L0KgM4X4wsc7nLRolG2/GLS
	 +zjid6DHE68fIXpD2XdCXEH0Aija3+TDN+6F6jFYzjp8vBQj9Pbg29Wr0FXU+7ommf
	 26UqdPT8CD6daBp191IfeV2aneXTTFZf0CLs146i40tiZeKXKdVVOeZcccAXhp2uPs
	 YjN79p460qpcQ==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH wireless v2] wifi: wlcore: fix wlcore AP mode
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: <E1sClp4-00Evu7-8v@rmk-PC.armlinux.org.uk>
References: <E1sClp4-00Evu7-8v@rmk-PC.armlinux.org.uk>
To: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Cc: Johannes Berg <johannes.berg@intel.com>,
 Michael Nemanov <michael.nemanov@ti.com>, linux-kernel@vger.kernel.org,
 linux-wireless@vger.kernel.org
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <171870222832.352833.18243842149594040098.kvalo@kernel.org>
Date: Tue, 18 Jun 2024 09:17:09 +0000 (UTC)

"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk> wrote:

> Using wl183x devices in AP mode with various firmwares is not stable.
> 
> The driver currently adds a station to firmware with basic rates when it
> is first known to the stack using the CMD_ADD_PEER command. Once the
> station has finished authorising, another CMD_ADD_PEER command is issued
> to update the firmware with the rates the station can use.
> 
> However, after a random amount of time, the firmware ignores the power
> management nullfunc frames from the station, and tries to send packets
> while the station is asleep, resulting in lots of retries dropping down
> in rate due to no response. This restricts the available bandwidth.
> 
> With this happening with several stations, the user visible effect is
> the latency of interactive connections increases significantly, packets
> get dropped, and in general the WiFi connections become unreliable and
> unstable.
> 
> Eventually, the firmware transmit queue appears to get stuck - with
> packets and blocks allocated that never clear.
> 
> TI have a couple of patches that address this, but they touch the
> mac80211 core to disable NL80211_FEATURE_FULL_AP_CLIENT_STATE for *all*
> wireless drivers, which has the effect of not adding the station to the
> stack until later when the rates are known. This is a sledge hammer
> approach to solving the problem.
> 
> The solution implemented here has the same effect, but without
> impacting all drivers.
> 
> We delay adding the station to firmware until it has been authorised
> in the driver, and correspondingly remove the station when unwinding
> from authorised state. Adding the station to firmware allocates a hlid,
> which will now happen later than the driver expects. Therefore, we need
> to track when this happens so that we transmit using the correct hlid.
> 
> This patch is an equivalent fix to these two patches in TI's
> wilink8-wlan repository:
> 
> https://git.ti.com/cgit/wilink8-wlan/build-utilites/tree/patches/kernel_patches/4.19.38/0004-mac80211-patch.patch?h=r8.9&id=a2ee50aa5190ed3b334373d6cd09b1bff56ffcf7
> https://git.ti.com/cgit/wilink8-wlan/build-utilites/tree/patches/kernel_patches/4.19.38/0005-wlcore-patch.patch?h=r8.9&id=a2ee50aa5190ed3b334373d6cd09b1bff56ffcf7
> 
> Reported-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> Co-developed-by: Johannes Berg <johannes.berg@intel.com>
> Tested-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> Signed-off-by: Johannes Berg <johannes.berg@intel.com>
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Patch applied to wireless.git, thanks.

14f89946b6b3 wifi: wlcore: fix wlcore AP mode

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/E1sClp4-00Evu7-8v@rmk-PC.armlinux.org.uk/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


