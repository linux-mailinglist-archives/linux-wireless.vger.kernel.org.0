Return-Path: <linux-wireless+bounces-8856-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C8EA9051E2
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Jun 2024 14:01:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A23AD1C2127B
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Jun 2024 12:01:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E04BF16D306;
	Wed, 12 Jun 2024 12:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="plBA+azh"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B57F45B5B6;
	Wed, 12 Jun 2024 12:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718193688; cv=none; b=MrqV8WSy8dn2GVz/jdJ04TCrkj8y54Tk0OmTQuQ9qJxEcEYvBIOeIIiJyTR3E8kR5/+INRPWHgQXetA1T8GZ+d0DIv/+gXKCqdbi4yX/fAjcrSsF9UgoD3ngYHFb8Xt7/NkX8yoG0OKqHiFdPWqDy3T9raayoZZBiEaKC1WhzPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718193688; c=relaxed/simple;
	bh=Tsv48oPtlgTHvx9V3xuPXgrjcGCvx5oPY+03wCrBLEY=;
	h=Content-Type:MIME-Version:Subject:From:In-Reply-To:References:To:
	 Cc:Message-ID:Date; b=aSt6Kaw4l/FBz5qLk7xXAF+2Fb3iWdiGgqpAsREHA52K8WspNkBF+Nbt6iYFqiNgMFZ0SsxaxNXDaH+RoAymEwBge0RIumyRQy2EHfAmxQisL7yoCpXBwJyk3K+RUbF7YJDZvwyXSo1jFSj1E0A6NN0Ydir/aODsKfQcG/gABAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=plBA+azh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1C11C3277B;
	Wed, 12 Jun 2024 12:01:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718193688;
	bh=Tsv48oPtlgTHvx9V3xuPXgrjcGCvx5oPY+03wCrBLEY=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=plBA+azhUxAd+ard8rlBITJU9CNxUf3NphVbg3hPOtXGvTdlhRXdinrNQEpQJJ5yk
	 ICHrhCEz1pyGznF2m2oeCkiGMVBHVaB4aiufbin9W55/7TsZxl0nK9NUKAUrtZuxhU
	 KTug8AMd7s8cmYAmyBe2E0Hlu9Mng2il8mj67zmFHrG5Axx527Fa8revTlGPeK7zSW
	 HU2iBuWUtVt2Sa2Jl7R/Bzvmhw7b71rXASKG8fQR6PfRSYmzo8snAb1RYFjNhZeM0v
	 qcb7gS6d/CEplW0Zn8Bd52ZaPci/c7o1uB9tT6s5XD4nvZ8KAOQMzOSzJpC6C135/y
	 y0Um1IfNWo18g==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 2/6] wifi: brcmfmac: use 'time_left' variable with
 wait_event_timeout()
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20240603091541.8367-3-wsa+renesas@sang-engineering.com>
References: <20240603091541.8367-3-wsa+renesas@sang-engineering.com>
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: linux-kernel@vger.kernel.org,
 Wolfram Sang <wsa+renesas@sang-engineering.com>,
 Arend van Spriel <arend.vanspriel@broadcom.com>,
 linux-wireless@vger.kernel.org, brcm80211@lists.linux.dev,
 brcm80211-dev-list.pdl@broadcom.com
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <171819368496.3856519.10394049739413295100.kvalo@kernel.org>
Date: Wed, 12 Jun 2024 12:01:26 +0000 (UTC)

Wolfram Sang <wsa+renesas@sang-engineering.com> wrote:

> There is a confusing pattern in the kernel to use a variable named 'timeout' to
> store the result of wait_event_timeout() causing patterns like:
> 
> 	timeout = wait_event_timeout(...)
> 	if (!timeout) return -ETIMEDOUT;
> 
> with all kinds of permutations. Use 'time_left' as a variable to make the code
> self explaining.
> 
> Fix to the proper variable type 'long' while here.
> 
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> Acked-by: Arend van Spriel <arend.vanspriel@broadcom.com>

4 patches applied to wireless-next.git, thanks.

158d5a1b3caa wifi: brcmfmac: use 'time_left' variable with wait_event_timeout()
0c0668813cc0 wifi: mwl8k: use 'time_left' variable with wait_for_completion_timeout()
a37f6947ff07 wifi: p54: use 'time_left' variable with wait_for_completion_interruptible_timeout()
a2ead3445a63 wifi: zd1211rw: use 'time_left' variable with wait_for_completion_timeout()

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20240603091541.8367-3-wsa+renesas@sang-engineering.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


