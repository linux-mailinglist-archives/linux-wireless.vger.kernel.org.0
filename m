Return-Path: <linux-wireless+bounces-2183-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EE96831A33
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Jan 2024 14:14:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 589B628A7BB
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Jan 2024 13:14:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4717250E6;
	Thu, 18 Jan 2024 13:14:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kjS/6FVo"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C185524B55
	for <linux-wireless@vger.kernel.org>; Thu, 18 Jan 2024 13:14:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705583682; cv=none; b=WEQSI1OByAoAzBnZVwSWuUldjWCqVXVlxJt7CbJxb9d5l/Fqb5znGfgkOp1VPlUj9W0gTa1gb7N3w+vWEDbepQXpi4KdPjTUuvPEt6FPUVsTBjtmWaoVfiLHdXvFDXrSA1gXDH6bV+z7Hqx8fjytZuu1EIm3gOaSX6oqCUNnsCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705583682; c=relaxed/simple;
	bh=rXQUHQX6uok/PuDqAF7PNVEnCwmEvZdb5z67tfs6B8M=;
	h=Received:DKIM-Signature:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:In-Reply-To:References:To:
	 Cc:User-Agent:Message-ID:Date; b=BPLBTNFrny+hR+DUfVuVRawh6ViaY3Isp/DAM6TmBgQjLAraY78ZRvI0bW38lDrk+8XpJv4UDft/4m3mHk9PrM2vJH9jAOTwDqFgIJGwBPBWGUTGPc84NSgitUAG/hs0JcooYsPg7HT59qga+MguCa8TEw9bhg1czCWfhxCsVww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kjS/6FVo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E1A6C433F1;
	Thu, 18 Jan 2024 13:14:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705583682;
	bh=rXQUHQX6uok/PuDqAF7PNVEnCwmEvZdb5z67tfs6B8M=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=kjS/6FVoAxm42UjWlIeoVu96k3U5Cmr9m4iocDp926NvHkxidFGQ01H3sP8S318B9
	 MG8Y5J6mWHvehKP8/hR8HPM8LIi6m+FvRiSUoQSJ/c0Bxwo9SsH9lJDdM3CIbIchQu
	 ipkXWdKyan1+9GY5tXqc+coTrUBL45zjod/CMxGYDBFVdlbEhH4jxhtzDfyccbS1Pn
	 +uUioYLOaGavPzDOMrGYumkAjD/P+HJ+NbYqa2RFrzHIlfxWj51IxyFc1GnFSf+hLQ
	 1SDAglbXO1Fck9aoklQVSUCwnswFe00hCLnWqJo50z22T5vo8SCTz4hAs5eVyiZugj
	 OKPFEgUzQuEAA==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH V2 4/4] wifi: brcmfmac: cfg80211: Use WSEC to set SAE
 password
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20240103095704.135651-5-arend.vanspriel@broadcom.com>
References: <20240103095704.135651-5-arend.vanspriel@broadcom.com>
To: Arend van Spriel <arend.vanspriel@broadcom.com>
Cc: linux-wireless@vger.kernel.org, Hector Martin <marcan@marcan.st>,
 Neal Gompa <neal@gompa.dev>, Arend van Spriel <arend.vanspriel@broadcom.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <170558367920.2924528.10360491365838061583.kvalo@kernel.org>
Date: Thu, 18 Jan 2024 13:14:40 +0000 (UTC)

Arend van Spriel <arend.vanspriel@broadcom.com> wrote:

> From: Hector Martin <marcan@marcan.st>
> 
> Using the WSEC command instead of sae_password seems to be the supported
> mechanism on newer firmware, and also how the brcmdhd driver does it.
> 
> According to user reports [1], the sae_password codepath doesn't actually
> work on machines with Cypress chips anyway, so no harm in removing it.
> 
> This makes WPA3 work with iwd, or with wpa_supplicant pending a support
> patchset [2].
> 
> [1] https://rachelbythebay.com/w/2023/11/06/wpa3/
> [2] http://lists.infradead.org/pipermail/hostap/2023-July/041653.html
> 
> Signed-off-by: Hector Martin <marcan@marcan.st>
> Reviewed-by: Neal Gompa <neal@gompa.dev>
> [arend.vanspriel@broadcom.com: use multi-vendor framework]
> Signed-off-by: Arend van Spriel <arend.vanspriel@broadcom.com>

Should we also update the commit message to match the code? We are not removing
the Cypress codepath anymore, right?

I can do the update, just let me know what to add. Preferably something I can
just copy&paste.

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20240103095704.135651-5-arend.vanspriel@broadcom.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


