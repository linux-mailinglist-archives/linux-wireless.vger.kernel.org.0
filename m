Return-Path: <linux-wireless+bounces-2896-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ABB1F8444DB
	for <lists+linux-wireless@lfdr.de>; Wed, 31 Jan 2024 17:49:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 469262838C8
	for <lists+linux-wireless@lfdr.de>; Wed, 31 Jan 2024 16:49:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 909D512BF1B;
	Wed, 31 Jan 2024 16:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ohEADtoR"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 623EB12BE99;
	Wed, 31 Jan 2024 16:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706719720; cv=none; b=VQ1t+6u6bI4Ix6K1nvWaObqFRrTWdQ9b5+faf1Daswu+p+UYj4MkRx51wHHIJ8Ryg/CD4XrjFRQDtEKpgPME1qYl/HOEvytrN9haxsY4iFxEbAFbLJkuJ9g92dUEf4wB0z7uIM4020877FipgV8OfOBEvWcKd2cVLSJNTh4XfU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706719720; c=relaxed/simple;
	bh=ig2DrAaRcdJiqJ2BSSzDUtJadSAf9WNhvatAlYeOSS4=;
	h=Content-Type:MIME-Version:Subject:From:In-Reply-To:References:To:
	 Cc:Message-ID:Date; b=ivbxZUHRjcVNfWQqUkkJoxW8wvfoqRAu5mskCjNT6Tis73Ai8luGYp3nLpyjrVXftkqQtvqCV3zNCFQT6BhDEoC+ama8/uCpO4JUimZ4FAaSNh4qLtpHaFIci90+rQCnf2c5ANwiwuITBSQvheh7AAOuAvfZYtlI92416774cVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ohEADtoR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6593C43390;
	Wed, 31 Jan 2024 16:48:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706719719;
	bh=ig2DrAaRcdJiqJ2BSSzDUtJadSAf9WNhvatAlYeOSS4=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=ohEADtoRDg9AEzaPQKCEONz5c2wXdAHdVkvf0TqrhCyXdyb6E0Tew6TxuHRsXB0eV
	 060Xwduh/wpLgXxAo9Nvl4C2CoUNmGO+XuezTzSB0F9bLUgFGpWpMNONutLnl8Zi1F
	 UCqhVnweRVoAdy5Oec9z8n74h0filRPoC8j42Flz/43t1QFS7Qz3SsHJVoCQ5epaw8
	 ZdvF3B+uQDTMucgpjz36jZwynwmxU+EAZlFbYHJLoiCqBufmg8k74/I5L5rjSbRyGo
	 YSxAYEh4PeQH6wkPmcFIOVpfcWhdAv671pr+PHhCSBXkvLKLVEdsPLvGp1fbpkoqAe
	 /9tb+cYvXEJsw==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 1/2] wifi: brcmfmac: add linefeed at end of file
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20240128093057.164791-2-arend.vanspriel@broadcom.com>
References: <20240128093057.164791-2-arend.vanspriel@broadcom.com>
To: Arend van Spriel <arend.vanspriel@broadcom.com>
Cc: linux-wireless@vger.kernel.org, brcm80211@lists.linux.dev,
 Arend van Spriel <arend.vanspriel@broadcom.com>,
 Jakub Kicinski <kuba@kernel.org>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <170671971663.2518225.18207642319405520913.kvalo@kernel.org>
Date: Wed, 31 Jan 2024 16:48:38 +0000 (UTC)

Arend van Spriel <arend.vanspriel@broadcom.com> wrote:

> The following sparse warning was reported:
> 
> drivers/net/wireless/broadcom/brcm80211/brcmfmac/fwil.c:432:49:
>   warning: no newline at end of file
> 
> Fixes: 31343230abb1 ("wifi: brcmfmac: export firmware interface functions")
> Reported-by: Jakub Kicinski <kuba@kernel.org>
> Closes: https://lore.kernel.org/all/20240125165128.7e43a1f3@kernel.org/
> Signed-off-by: Arend van Spriel <arend.vanspriel@broadcom.com>

2 patches applied to wireless-next.git, thanks.

26f0dc8a705a wifi: brcmfmac: add linefeed at end of file
2a71528427c6 wifi: brcmfmac: fix copyright year mentioned in platform_data header

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20240128093057.164791-2-arend.vanspriel@broadcom.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


