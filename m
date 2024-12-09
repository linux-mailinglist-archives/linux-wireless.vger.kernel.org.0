Return-Path: <linux-wireless+bounces-16077-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 417389E9B03
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Dec 2024 16:58:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 612A22828DC
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Dec 2024 15:58:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F6F913665B;
	Mon,  9 Dec 2024 15:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HzeqfDen"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1395D132122;
	Mon,  9 Dec 2024 15:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733759910; cv=none; b=iuMHOC3Ne4HP52sngOyBjx57Sbz/YO2TcC/lsEcRdZD8t/B24Q43S+fZmVPnpNNEAKFQEFTDRWBVatBuz+HJgzQ8WD3DrDJSt+7o1FjOaA4MUQaZbVVBUXlGL9tW7KAmHgNKP3j3kgSf3idAHYQYadi1npjyLt9OrjiFNfe6VYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733759910; c=relaxed/simple;
	bh=b/BWXOW4C5BHuN5jt5sHWd88sXYszdCVTaD+HT3YLZY=;
	h=Content-Type:MIME-Version:Subject:From:In-Reply-To:References:To:
	 Cc:Message-ID:Date; b=cT2a1wyVrTZ2GWIdbM1Fa8pU4CWemCF57YA/k7vNQGJmQwuVK48AtDNBYBoRcBUJfKG7fPjlQnCTffppnhUr90fsYAlSo4LVqJ1hdaEh2LhmC64oY5W0v+L+iwp6NtCIJXf31/DcqNus6H6+ZvvtKO0GhJt6SWaFzfgpi1JMChU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HzeqfDen; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B66BC4CED1;
	Mon,  9 Dec 2024 15:58:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733759909;
	bh=b/BWXOW4C5BHuN5jt5sHWd88sXYszdCVTaD+HT3YLZY=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=HzeqfDenLhXlStbpUky8L79eIQOsav0BrDclQV/kTnESJ+2+e+hqLOWHsbpaV85Es
	 GBpGU0tZ9IOw9QiP0ayJrkznLxrEmHTOw4MlwM1Ax8Hn/HmOH2aSJn2xeczeCLOELR
	 joqhEk+5zPA57CpDwD5gPwyJSUQFGUOystFUnFluQJHKdvaVf6zBm5yRkuZ6v7uUxv
	 1VLwRhMBKmT0XYpEAZAQ1L833Zum78EZ9xrpE7NvMT9j6kRBOCWKfdzfE4gbZYZ5je
	 jYEI9x6EaoNjOVttHt905i8AYEDjVR+yqVb9u1GNPbMj0u1iIlpxVrOnbWWd6dhhvF
	 qVnu3TPdK0b2Q==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] wifi: brcmfmac: fix scatter-gather handling by detecting
 end
 of sg list
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20241108125609.107016-1-nvbolhuis@gmail.com>
References: <20241108125609.107016-1-nvbolhuis@gmail.com>
To: nvbolhuis@gmail.com
Cc: brcm80211@lists.linux.dev, linux-wireless@vger.kernel.org,
 arend.vanspriel@broadcom.com, Norbert van Bolhuis <nvbolhuis@gmail.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <173375990682.157598.6631561096455255097.kvalo@kernel.org>
Date: Mon,  9 Dec 2024 15:58:28 +0000 (UTC)

nvbolhuis@gmail.com wrote:

> From: Norbert van Bolhuis <nvbolhuis@gmail.com>
> 
> The scatter-gather handling uses a pre-allocated list (with nents entries).
> If the driver runs out of sg entries it will result in an oops. Let's detect
> this instead and make the SDIO block transfer fail.
> 
> Signed-off-by: Norbert van Bolhuis <nvbolhuis@gmail.com>

Patch applied to wireless-next.git, thanks.

52e8726d6782 wifi: brcmfmac: fix scatter-gather handling by detecting end of sg list

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20241108125609.107016-1-nvbolhuis@gmail.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


