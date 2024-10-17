Return-Path: <linux-wireless+bounces-14165-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01A0B9A2995
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Oct 2024 18:51:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E438DB2E66C
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Oct 2024 16:50:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 986D01DF27F;
	Thu, 17 Oct 2024 16:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZEL4qK5V"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BAB71DDC24;
	Thu, 17 Oct 2024 16:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729183808; cv=none; b=hkiU9Sxb46/pvsfQst+IvESyko2TVS0dOjFiBlHqe49bsDtVtYKYMr+cseBPx+CCfitbTErqih4mAdMbs1XCpao/OYEYPhv3/LDofWDAbd0yEzsX5/7AITBR5pEeedxGzzpUrNXKrD/p700g8u2cKJmcGtoXxosaz4/8uPb09Ag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729183808; c=relaxed/simple;
	bh=20vtws0AabuYgFOqtczHXHBoZwS8yMb2WxRkFSp4RCQ=;
	h=Content-Type:MIME-Version:Subject:From:In-Reply-To:References:To:
	 Cc:Message-ID:Date; b=GumPO/z/khzUJzPK+5vhulw8OjbKKIvgImj7BJl81RmxfzeuRagLkRowKiSfeg8RDie9C1Z0F9Kf8TnwckMdjBFTQQTJdqYYcIDPhhTacsjA69Qy9dMnAyvABEnIgvbURSuDDGedEDmCl7UKOZCwWYHJHE1pvsdL+kFHWFB6aOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZEL4qK5V; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F789C4CECD;
	Thu, 17 Oct 2024 16:50:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729183808;
	bh=20vtws0AabuYgFOqtczHXHBoZwS8yMb2WxRkFSp4RCQ=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=ZEL4qK5Vtk0sFPCs9J2pjqAbiH14fx0HOOsPMovfcKS7P8IMXRk9LJlfSv59bLnyu
	 ARTOJnT4anuvO6j+o1/M04QgP2bfIpuvEABbJybZsgivdFkHYBFj1lBqPAf7CwYK1w
	 idwKXVxvnBxKw0QDpEoR4V//jUlUhx6+ApmctA36IY16tHlvjqk14sGh+afEOf5X30
	 PCG5qbiGSgNhQgXNxWlDCYrsHcQilCJ5X2zHkBHC+iysPpekgOfn+sbXZbhGxjHwhZ
	 ECLGKLSiAGytm5VgqT+x72wblxOTcg7G3/Z0KJWpO4CJSOFDC+2bL3tVJkJZrtYuY/
	 P66FNribpOl1w==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] wifi: brcmfmac: of: use
 devm_clk_get_optional_enabled_with_rate()
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20241007131639.98358-1-brgl@bgdev.pl>
References: <20241007131639.98358-1-brgl@bgdev.pl>
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Arend van Spriel <arend.vanspriel@broadcom.com>,
 linux-wireless@vger.kernel.org, brcm80211@lists.linux.dev,
 brcm80211-dev-list.pdl@broadcom.com, linux-kernel@vger.kernel.org,
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <172918380489.970100.2558339761978591101.kvalo@kernel.org>
Date: Thu, 17 Oct 2024 16:50:06 +0000 (UTC)

Bartosz Golaszewski <brgl@bgdev.pl> wrote:

> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> Fold the separate clk_set_rate() call into the clock getter.
> 
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Patch applied to wireless-next.git, thanks.

7cc7267a0163 wifi: brcmfmac: of: use devm_clk_get_optional_enabled_with_rate()

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20241007131639.98358-1-brgl@bgdev.pl/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


