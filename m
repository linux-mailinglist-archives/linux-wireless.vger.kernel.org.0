Return-Path: <linux-wireless+bounces-3618-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 07AC085610D
	for <lists+linux-wireless@lfdr.de>; Thu, 15 Feb 2024 12:11:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8973F1F24761
	for <lists+linux-wireless@lfdr.de>; Thu, 15 Feb 2024 11:11:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A48912AADB;
	Thu, 15 Feb 2024 11:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C7Y6O0Ah"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4682712A158
	for <linux-wireless@vger.kernel.org>; Thu, 15 Feb 2024 11:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707995434; cv=none; b=nOna1tJRGn9N1maZstPm7+/j1+NVHiaJBt4vRdLAqtJfohT9sWuq26H+I92vvmTBhJkwHcZ5rp3c6BMNWBFy8lFzy9XAvjrBQJfm1e8fj0k6XLPgZ19k/RKJ/S34bHSsvQj9AH3uhqe+RgQ2WwqdQJGdrt4OF4wd5qauAaV0Mg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707995434; c=relaxed/simple;
	bh=WpMTDRqyEN7ru0+HIT2xx9gX3gThsd4h1IPUldL/5fc=;
	h=Content-Type:MIME-Version:Subject:From:In-Reply-To:References:To:
	 Cc:Message-ID:Date; b=I9GTnXC8seWHTtmJiYbYE9ByQxF5cKmGgeHj0vXbl3+aH6UpK1+aQwAKHlldU21y3aKcIqpfMOHfqpDdEiGkEkFkTrVOw5zQvuXIvsEq39VIRpYswEAkzySqcM+MXdfYvVo2sQ1qshvSNx/lCvrO5+Iniwu41dkMJy3aKoIpadc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C7Y6O0Ah; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 139EDC433C7;
	Thu, 15 Feb 2024 11:10:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707995433;
	bh=WpMTDRqyEN7ru0+HIT2xx9gX3gThsd4h1IPUldL/5fc=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=C7Y6O0AhdOMdy/ODIjS2FYJVaA03uo/EOJpcwFmOPJS+GQ/nbLag4a7MlKxrwfSoa
	 bOyFmokURfw/peWVjhX/5Kmu8kPtgCHV/3KXihJUHro+1ASuO16g0JaZv/AoSMhlhg
	 OaAkMOHJpz70gBwsMFIl+m1OUc1EFnOHfp/aWyGm2D75FQrFlQTNf0/K6sxqU1vLXu
	 WQLln9MfcCBKaS5jmi5nxfSvPudPXZRtf8Sl+i3nDr76Mq3xyAGNQPIuf1+Fv7vKi4
	 TLSRvzlV7XcP9f/D244ZLuQ5FzqtcvZwVRK0U6v3KWcZI8c5c/1RnevNDIEXNI00F1
	 lRbnhMcNNDHXQ==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] wifi: rtw89: fw: remove unnecessary rcu_read_unlock() for
 punctured
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20240213122556.9593-1-pkshih@realtek.com>
References: <20240213122556.9593-1-pkshih@realtek.com>
To: Ping-Ke Shih <pkshih@realtek.com>
Cc: <johannes.berg@intel.com>, <linux-wireless@vger.kernel.org>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <170799543107.3764215.12527136024611017239.kvalo@kernel.org>
Date: Thu, 15 Feb 2024 11:10:32 +0000 (UTC)

Ping-Ke Shih <pkshih@realtek.com> wrote:

> The rcu_read_unlock() is accidentally added, and sparse warn:
> 
>   drivers/net/wireless/realtek/rtw89/fw.c:2807:17:
>     warning: context imbalance in 'rtw89_fw_h2c_assoc_cmac_tbl_g7' - unexpected unlock
> 
> Fixes: b82730bf57b5 ("wifi: cfg80211/mac80211: move puncturing into chandef")
> Cc: Johannes Berg <johannes.berg@intel.com>
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>

Patch applied to wireless-next.git, thanks.

63d94f749623 wifi: rtw89: fw: remove unnecessary rcu_read_unlock() for punctured

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20240213122556.9593-1-pkshih@realtek.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


