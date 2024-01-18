Return-Path: <linux-wireless+bounces-2184-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 84D54831A5E
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Jan 2024 14:18:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3D20928769B
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Jan 2024 13:18:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E75BC25544;
	Thu, 18 Jan 2024 13:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UzbGJE68"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC23F25116;
	Thu, 18 Jan 2024 13:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705583869; cv=none; b=h5wRfkhNE/8lT8CwXSeV2gpeB7n0gjuCRab6M9fc8C4aa/HoJ6BJwpl0Gv+xnGNMwGT+QOpbyb+s4BEBBRD5Y9ZVfjxE1CuIFjF0Uf1gtq1oJyIhA5JfRAyjCzJyiK8cqbbwoRtVLuZWjndaFgBcf+Ad7mGPJUj6ulnvLqsG32s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705583869; c=relaxed/simple;
	bh=g9i2go98VUUbiB+yc/sTccAnH2UaalOetc9Dl79sWhY=;
	h=Received:DKIM-Signature:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:In-Reply-To:References:To:
	 Cc:User-Agent:Message-ID:Date; b=Z1z0kpINkoQAv88Z1IOymdNVoGoHNeBNwQfgYLH3/WA1ayIORG2hIxIoGIKnb17Bv9UsbgQIugwBTs91qfRX55i30i54EP61r5OGcUCW7fb6Qbm+5/hb8t6SyN/6C8QZjoYMKCG0kPrWzOs98pn2/GBpMOooPzvcwfJ8obRYW9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UzbGJE68; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12687C43390;
	Thu, 18 Jan 2024 13:17:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705583869;
	bh=g9i2go98VUUbiB+yc/sTccAnH2UaalOetc9Dl79sWhY=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=UzbGJE68Ei7MsbP9A83mwKokqnkYIIzIyBHmTlmFwft3P58TiTVEPm5lkc76+M213
	 hpJcGjQR2jkYFXOB8mNEN9T9UDXl9ZKzdwd3YQh98zHZBM420kNBtYFfDp1QnzczeI
	 URT48WQLi50Nflno8jMo3ZhI+DI8zauCwWINXjeqj7btjIsj4UBQP8HuYJi9+yoKcs
	 gR/3UyzHjcocTieIweh8pNQObowxtuXShJAtioy/6R+ufVbuZD0bGD7xoTwCs5T1IC
	 1afF2D7/RTUyLe1iIqRAd3h5vxmrVnYZkHgdnUyvQRL72nCh65Yqx1ERc7b+7RFDQO
	 cetWh8H65oDGQ==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH V6] wifi: brcmfmac: Fix use-after-free bug in
 brcmf_cfg80211_detach
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20240107072504.392713-1-arend.vanspriel@broadcom.com>
References: <20240107072504.392713-1-arend.vanspriel@broadcom.com>
To: Arend van Spriel <arend.vanspriel@broadcom.com>
Cc: linux-wireless@vger.kernel.org, Zheng Wang <zyytlz.wz@163.com>,
 stable@vger.kernel.org, Arend van Spriel <arend.vanspriel@broadcom.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <170558386628.2924528.18082567611022970252.kvalo@kernel.org>
Date: Thu, 18 Jan 2024 13:17:47 +0000 (UTC)

Arend van Spriel <arend.vanspriel@broadcom.com> wrote:

> From: Zheng Wang <zyytlz.wz@163.com>
> 
> This is the candidate patch of CVE-2023-47233 :
> https://nvd.nist.gov/vuln/detail/CVE-2023-47233
> 
> In brcm80211 driver,it starts with the following invoking chain
> to start init a timeout worker:
> 
> ->brcmf_usb_probe
>   ->brcmf_usb_probe_cb
>     ->brcmf_attach
>       ->brcmf_bus_started
>         ->brcmf_cfg80211_attach
>           ->wl_init_priv
>             ->brcmf_init_escan
>               ->INIT_WORK(&cfg->escan_timeout_work,
> 		  brcmf_cfg80211_escan_timeout_worker);
> 
> If we disconnect the USB by hotplug, it will call
> brcmf_usb_disconnect to make cleanup. The invoking chain is :
> 
> brcmf_usb_disconnect
>   ->brcmf_usb_disconnect_cb
>     ->brcmf_detach
>       ->brcmf_cfg80211_detach
>         ->kfree(cfg);
> 
> While the timeout woker may still be running. This will cause
> a use-after-free bug on cfg in brcmf_cfg80211_escan_timeout_worker.
> 
> Fix it by deleting the timer and canceling the worker in
> brcmf_cfg80211_detach.
> 
> Fixes: e756af5b30b0 ("brcmfmac: add e-scan support.")
> Signed-off-by: Zheng Wang <zyytlz.wz@163.com>
> Cc: stable@vger.kernel.org
> [arend.vanspriel@broadcom.com: keep timer delete as is and cancel work just before free]
> Signed-off-by: Arend van Spriel <arend.vanspriel@broadcom.com>

Patch applied to wireless-next.git, thanks.

0f7352557a35 wifi: brcmfmac: Fix use-after-free bug in brcmf_cfg80211_detach

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20240107072504.392713-1-arend.vanspriel@broadcom.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


