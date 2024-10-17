Return-Path: <linux-wireless+bounces-14164-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B6B79A2989
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Oct 2024 18:49:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5D14B1C27D0C
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Oct 2024 16:49:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A15031DF723;
	Thu, 17 Oct 2024 16:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t3wxXO51"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78AD81DEFF7;
	Thu, 17 Oct 2024 16:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729183788; cv=none; b=aO6qNbwbF5rrWnj5iJJB3rE52AfWPjgOINYQM0rc6Kia1l7wK31iFTujiz/10EggCcL17TW4s5sskQ+DVFq+6nuSaeLVJpDDuM4PWI9E2P/pLHerWHs4ScI8Lo36jNFgQ/Jpt95w/WU324Z0/8zCMWZaSOQSO6nlTXz7MAPitVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729183788; c=relaxed/simple;
	bh=ShurCmcH4ocxaYHzd0vDlAt6279kxwen//FJNqqRIbs=;
	h=Content-Type:MIME-Version:Subject:From:In-Reply-To:References:To:
	 Cc:Message-ID:Date; b=VmObvdc4NFJW9FnZ/UikG4WQBlO3plKOq9OUcvIVEsQTdyvCaMvm0sEYHN41RYcfIDbPqTsxHIkDJVUB+zcn5voNoLB4//uydz08WNs5ybZn0LcYknk6qXPNh0+Gg9wSr06Bc8/LZIe+pUKh9/SHwOKMtnBg5wMnwJQ5Jj7V3zw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t3wxXO51; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD931C4CEC3;
	Thu, 17 Oct 2024 16:49:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729183788;
	bh=ShurCmcH4ocxaYHzd0vDlAt6279kxwen//FJNqqRIbs=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=t3wxXO51jFHy3LLa+uwCbWziYqWblBumgdzGC/4HlmzbGRh2vxYFup+dVp9r514iZ
	 +N3MSu/iIPwmMq+2BzlizVmd/Tr9AvzK51f143uu2tzboakgnEmy0WYc8TLxmO5/xX
	 k5s6dmcntzgjW0zP70B5fWfFLfst9S/yEk70dPwADsramE0QeZCsgR4+Xj+13896bT
	 aiGxkc9Fk8IUcqJ/wxCTD/esMW4JnBraiPFiDWrWIKaB6su0h03E7eo1NK4x4La+6y
	 r6frH8O8VwRcquPgvxY/8YXXXl2Xq2RHNbVIvH8v381c4vuQZlvTjFFpsbbz28WQHf
	 e9S74aeTKvEzg==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: wifi: brcmsmac: Remove unused brcms_debugfs_get_devdir()
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20241004004259.470853-1-linux@treblig.org>
References: <20241004004259.470853-1-linux@treblig.org>
To: linux@treblig.org
Cc: arend.vanspriel@broadcom.com, linux-wireless@vger.kernel.org,
 brcm80211@lists.linux.dev, brcm80211-dev-list.pdl@broadcom.com,
 linux-kernel@vger.kernel.org, "Dr. David Alan Gilbert" <linux@treblig.org>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <172918378518.970100.54201875296781170.kvalo@kernel.org>
Date: Thu, 17 Oct 2024 16:49:46 +0000 (UTC)

linux@treblig.org wrote:

> From: "Dr. David Alan Gilbert" <linux@treblig.org>
> 
> brcms_debugfs_get_devdir() has been unused since it was added by commit
> 8e21df23894e ("brcmsmac: hardware info in debugfs")
> 
> Remove it.
> 
> Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>

Patch applied to wireless-next.git, thanks.

13d21a289608 wifi: brcmsmac: Remove unused brcms_debugfs_get_devdir()

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20241004004259.470853-1-linux@treblig.org/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


