Return-Path: <linux-wireless+bounces-9072-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 47A6C90B032
	for <lists+linux-wireless@lfdr.de>; Mon, 17 Jun 2024 15:51:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B527CB2993E
	for <lists+linux-wireless@lfdr.de>; Mon, 17 Jun 2024 13:24:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F562194C70;
	Mon, 17 Jun 2024 13:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K8B6KX3T"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7755E194A4E;
	Mon, 17 Jun 2024 13:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718630396; cv=none; b=O3Z8bABXp4z1RYDeD9mk2RtcDiCsOx4SgAx/RKD9nBQ69e0RhzjhYa/E8bDLMF9Ig2KxZ2jMB/9svYsrap0+G0fWaf3ejy0e/4cq7NJMNwyPyO08T/RtIQRVp6eyfG3/XzAhDR0eFOByHkBa/P5oav86hwH8jlipjMt5qCRZlLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718630396; c=relaxed/simple;
	bh=9hACNZampJn6nK9Lw3MnzI2p/LIpPq2mzaJcb+mZ0oc=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=ts4CRv7hGH5YszestJ6EEv3sGVEjc3akUGMnbnxTEOgKpgnIvyP0oAeQja2Ab4K9LLGwJinRl3cd1I5EDUp4/BUnjm2ufcdpZdrjVBPuMs+9Z3uyQjNlwgYdVTDlMTifq05gUIt2UNEERkS0qzei7Qu7Otk2RUnXM++4aX/1NN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K8B6KX3T; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47DA0C4AF1C;
	Mon, 17 Jun 2024 13:19:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718630396;
	bh=9hACNZampJn6nK9Lw3MnzI2p/LIpPq2mzaJcb+mZ0oc=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=K8B6KX3ToDkgIiM4a8ovDS8hTzxzqTCReaffYM46+UKbSe4pqqqxIy9AdycC6PLpF
	 qhH61rnQ1JiQmdFTgyJZJO8g4sUxE5rvAYTJDOEdR88cZq9tFNaTj2YSMd6wcYxtLh
	 J6MjvlJaHOnbGwf5LgI1WwUMdyt7g9sxoXvAkM5mF+y4UZlXrL4mcjKGT6/4Q/8kJN
	 c9GM/whlyT/hAwAU0DOhRMdRpGaVtLndu/BR1Z1x/keDpYz4EUG2FihkdcxFB2Okye
	 2roMwxCxNxpuIe30kjLPtl8donYJITTU7sgMuPVhTvTvNekwEeFGSI4UdKSsLHOpOR
	 SxPS3Bc7UTWMA==
From: Kalle Valo <kvalo@kernel.org>
To: Arend van Spriel <arend.vanspriel@broadcom.com>
Cc: brcm80211@lists.linux.dev,  linux-wireless@vger.kernel.org
Subject: Re: brcmfmac: implement basic AP-follow-STA
References: <Zmqf7jCqwlQNGM_j@x1.vandijck-laurijssen.be>
Date: Mon, 17 Jun 2024 16:19:53 +0300
In-Reply-To: <Zmqf7jCqwlQNGM_j@x1.vandijck-laurijssen.be> (Kurt Van Dijck's
	message of "Thu, 13 Jun 2024 09:29:50 +0200")
Message-ID: <87v827k8p2.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be> writes:

> /* context */
> We (Yamabiko) have an application where we migrated to a bcm4339 sdio wifi chip.
> We use it in AP+STA mode: when the chip is detected (wlan+ add uevent),
> we call 'run iw dev wlan0 interface add wap0 type __ap' and start
> wpa_supplicant on wlan0 and hostapd on wap0.
> The STA is more important than the AP.
> We have 'roamoff' parameter set. We observed problems with the firmware roaming
> before and switched to wpa_supplicant roaming.
>
> We run a linux v5.4.24 derivative.
>
> /* problem */
> We observed that the chip is able to switch channel for wpa_supplicant to
> connect to a different channel, but it soon looses connection because hostapd
> does not change channel too.
>
> This did work with our previous wifi chip (realtek 88x2 something), which notifies
> hostapd that it switched.
>
> /* patch description */
> I went down and ended up modifying the brcmfmac driver, patch appended below.
> For contributing on these mailing lists, I ported it to yesterday's master.
> The idea is that whenever a STA issues a connect with channel info, the AP's
> will switch to it too. This implies a small glitch in the AP radio, which already
> occurred before my patch. it seems that the wifi chip cannot modify radio settings
> per virtual interface, although the API to the wifi chip suggests it can (that is
> most probable a more generic communication used for other chips that can do this).
> The channel switch is also reported to userspace.
>
> To be less invasive, this new behaviour is put behind
> a module parameter 'ap_follow_sta'.

FWIW module parameters should be avoided, especially for 802.11 protocol
level functionality.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

