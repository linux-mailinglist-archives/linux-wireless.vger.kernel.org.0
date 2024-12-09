Return-Path: <linux-wireless+bounces-16074-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 211C99E9AE8
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Dec 2024 16:51:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7EB1A280E27
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Dec 2024 15:51:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3071126F1E;
	Mon,  9 Dec 2024 15:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZnDoptEG"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C88A878C9C;
	Mon,  9 Dec 2024 15:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733759478; cv=none; b=QMqAE2jAKRYQ5/sP56+VWAxWy+awzBNn6VH6ZcMqUU8ypxBrshTD495PthKDRbU0NAbVnIgBd3pNhBNaGJBFeC/o7iNe83J2mcyuvc6AYAZvMZ0AV5b1nQpnWMJOn1z95A8+kaYPMe5IBvhLOLLPzCBwhkrvLsiaZTiMRVf58VU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733759478; c=relaxed/simple;
	bh=JVerLY/R5ex77RCp2JkuVu4YnL7bEhF/hr/WI/k6+f0=;
	h=Content-Type:MIME-Version:Subject:From:In-Reply-To:References:To:
	 Cc:Message-ID:Date; b=UT+iwIFXMpPBy0oqsmNrjCGIBXPXINVUnWdRcVU+Fuu/3/POVtNqGNiEh6ltl7QqNrx0whb44F8OQyLMYex1LhHCF57H7v0H5A5vR6ckjfhnkbwTlbkY90zXVpi3CMDT08Do2D20ZFP/EPixYZOZ1Ms1M+By39mtxLE8iHhrrhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZnDoptEG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB4E3C4CED1;
	Mon,  9 Dec 2024 15:51:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733759478;
	bh=JVerLY/R5ex77RCp2JkuVu4YnL7bEhF/hr/WI/k6+f0=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=ZnDoptEGPQd377O3B2C59RujbxgZTrOT23FQZLDv8Rgi8/8l25/+n+wmU318ZstNf
	 UxD6cQ7JmhlHTou/z4uPJydJFY5cht1M0OGB3io3Jfr/lMhyLZ0uZmaW01FKB+mdx7
	 ZU+6+EE7rUmnf7lWY7GWAfMEP2jTpuKzRs+4VQfOtTLf3/LQlAfx8fD9h1lauHaUSJ
	 DS6LVYiwRSTmke6SOd0rtp2h0TgV3YtBnoCXk/3/MU6A/V0urmEpio93cOEuOkFq49
	 Lts7pV0rcJMJvhnd+if4Rij0xjBfGU1cp6Rnh5KJvMFk3jEaaAch9o+ZuEb9W7yRQX
	 u6Nqe52NQZNGA==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] wifi: wlcore: fix unbalanced pm_runtime calls
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20241107181531.1774550-1-andreas@kemnade.info>
References: <20241107181531.1774550-1-andreas@kemnade.info>
To: Andreas Kemnade <andreas@kemnade.info>
Cc: rmk+kernel@armlinux.org.uk, johannes.berg@intel.com, andreas@kemnade.info,
 leitao@debian.org, emmanuel.grumbach@intel.com,
 linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <173375947536.157598.1252176440647591956.kvalo@kernel.org>
Date: Mon,  9 Dec 2024 15:51:16 +0000 (UTC)

Andreas Kemnade <andreas@kemnade.info> wrote:

> If firmware boot failes, runtime pm is put too often:
> [12092.708099] wlcore: ERROR firmware boot failed despite 3 retries
> [12092.708099] wl18xx_driver wl18xx.1.auto: Runtime PM usage count underflow!
> Fix that by redirecting all error gotos before runtime_get so that runtime is not put.
> 
> Signed-off-by: Andreas Kemnade <andreas@kemnade.info>

Do we know what commit broke this? A Fixes tag would be good to have.

Why not change this also to use out_unlock:

	role_type = wl12xx_get_role_type(wl, wlvif);
	if (role_type == WL12XX_INVALID_ROLE_TYPE) {
		ret = -EINVAL;
		goto out;
	}

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20241107181531.1774550-1-andreas@kemnade.info/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


