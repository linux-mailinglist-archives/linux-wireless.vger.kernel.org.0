Return-Path: <linux-wireless+bounces-12025-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DDD49603A0
	for <lists+linux-wireless@lfdr.de>; Tue, 27 Aug 2024 09:49:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0A0821F22872
	for <lists+linux-wireless@lfdr.de>; Tue, 27 Aug 2024 07:49:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDC8754F87;
	Tue, 27 Aug 2024 07:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="upEQcUvg"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95EEB18654;
	Tue, 27 Aug 2024 07:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724744984; cv=none; b=JI6dsrHT/W2QCOne2DFZbXaJyqmWfiHhAzCoGdpEVSTYDJJcVuoE6+gqQpcG+3eW7AOGlYBgo8KqyRU89u088+16WgJA7/gxwip5JVwit0j10W6BpHd1vsHmjHbuGUUHA7lWdF4M3ZCNkH3jXai+RvJAps3gyPSKVyU/k6a8+Wk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724744984; c=relaxed/simple;
	bh=q86gNMgXVgcdIVPlsT0WGRi200SjWYGch5bmRTjnh3k=;
	h=Content-Type:MIME-Version:Subject:From:In-Reply-To:References:To:
	 Cc:Message-ID:Date; b=ZgkRLhp4NCBDp792tXCsIh9taDKjZercA+1rz6rO83os7NAFo2nWYDZjIy+gA+H9+btFUtMe0/skf23ISBT04wPbZ7iL5BCDJxJSX80GOVRk1suQAxVdX/ygiGI1dGMdLmDCqYbmN75edeBrOEKIQ1NpQyXtEyXAMzLaaTatQ1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=upEQcUvg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2262C8B7A1;
	Tue, 27 Aug 2024 07:49:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724744984;
	bh=q86gNMgXVgcdIVPlsT0WGRi200SjWYGch5bmRTjnh3k=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=upEQcUvgrhfXD1WnWb8VQdcjGaWeYCG3/WiqEuzxpuDuWMaaooh6bLIZsH4V8biew
	 gBL2VXSNcj34BCHNVMdbg/6qkh7WuFqPLReHO1TgpXrz7bB8RnmrHDayxKB4z4onx1
	 j0hZIi5NazAbKh/jWO/2CPafPElVlRNYyhNZnfkz3R2h7QuNmL89XODqCOHVggIkL4
	 8VAjPQKgluOF8jk9VwTnSCqiS7WV3QVPmUQp7renX5mFp6LCiDOaMa59WJs/3vaQFp
	 g501Uy2bN2M3wsbt36M9ljM9EzmgXcs1HZlkoedYIqhONQUFCir1gQ17nAdqXjuR1L
	 RXxOm3h5cQYvA==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: wifi: wfx: repair open network AP mode
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20240823131521.3309073-1-alexander.sverdlin@siemens.com>
References: <20240823131521.3309073-1-alexander.sverdlin@siemens.com>
To: "A. Sverdlin" <alexander.sverdlin@siemens.com>
Cc: linux-wireless@vger.kernel.org,
 Alexander Sverdlin <alexander.sverdlin@siemens.com>, =?utf-8?b?SsOpcsO0?=
	=?utf-8?b?bWUgUG91aWxsZXI=?= <jerome.pouiller@silabs.com>,
 Dmitry Antipov <dmantipov@yandex.ru>, stable@vger.kernel.org
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <172474498108.2876569.5337520970531650493.kvalo@kernel.org>
Date: Tue, 27 Aug 2024 07:49:42 +0000 (UTC)

"A. Sverdlin" <alexander.sverdlin@siemens.com> wrote:

> From: Alexander Sverdlin <alexander.sverdlin@siemens.com>
> 
> RSN IE missing in beacon is normal in open networks.
> Avoid returning -EINVAL in this case.
> 
> Steps to reproduce:
> 
> $ cat /etc/wpa_supplicant.conf
> network={
> 	ssid="testNet"
> 	mode=2
> 	key_mgmt=NONE
> }
> 
> $ wpa_supplicant -iwlan0 -c /etc/wpa_supplicant.conf
> nl80211: Beacon set failed: -22 (Invalid argument)
> Failed to set beacon parameters
> Interface initialization failed
> wlan0: interface state UNINITIALIZED->DISABLED
> wlan0: AP-DISABLED
> wlan0: Unable to setup interface.
> Failed to initialize AP interface
> 
> After the change:
> 
> $ wpa_supplicant -iwlan0 -c /etc/wpa_supplicant.conf
> Successfully initialized wpa_supplicant
> wlan0: interface state UNINITIALIZED->ENABLED
> wlan0: AP-ENABLED
> 
> Cc: stable@vger.kernel.org
> Fixes: fe0a7776d4d1 ("wifi: wfx: fix possible NULL pointer dereference in wfx_set_mfp_ap()")
> Signed-off-by: Alexander Sverdlin <alexander.sverdlin@siemens.com>
> Reviewed-by: Jérôme Pouiller <jerome.pouiller@silabs.com>

Patch applied to wireless.git, thanks.

6d30bb88f623 wifi: wfx: repair open network AP mode

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20240823131521.3309073-1-alexander.sverdlin@siemens.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
https://docs.kernel.org/process/submitting-patches.html


