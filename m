Return-Path: <linux-wireless+bounces-12967-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CFBD97BF67
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Sep 2024 19:05:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 549E3282AF1
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Sep 2024 17:05:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 260361C8FD6;
	Wed, 18 Sep 2024 17:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jjPYsi5a"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8E7710A1C;
	Wed, 18 Sep 2024 17:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726679098; cv=none; b=Ymm2QBGamYwyo5C4jghZCPBKddH7y1RA9/YwsJBISuwmz81Nr1I/8JGFcgezWPLecDB3u7aXl9i0tUpUxESLUfUIXNUjqIwJZreJ5jWuT6iDnpm8ry0tjxaZakUQepituEGaWqkJQ0n2ba2cCIRkX2aJxVOAiZFgqtzDbIdD/JM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726679098; c=relaxed/simple;
	bh=KnB4EQHrwjJxDvJe54tg1tcHnSgfSx3LnvsC0siunAE=;
	h=Content-Type:MIME-Version:Subject:From:In-Reply-To:References:To:
	 Cc:Message-ID:Date; b=PgTcrgLkXZSXaYbWszRT+OWuaLatMKy+fEL1m/VNQK6t3Hwv1wnbSsuODRHifitkPC3IGDYn5Q7FSVk20neSa/1NzAQjPOsFayp/3Mu3Ta4BsJBwsiIVeUyOVeW2H/AX7ShAiXlt2w4FC9WRW8cOx+W+fvifWb27t7vyOL5pkFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jjPYsi5a; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC1DFC4CEC2;
	Wed, 18 Sep 2024 17:04:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726679097;
	bh=KnB4EQHrwjJxDvJe54tg1tcHnSgfSx3LnvsC0siunAE=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=jjPYsi5aTjrC7NDThFBZHIx3rJ6LJqqA91FlrHL1zHL79lItxmKnjDquA67dcKnkt
	 CDeFTcTmSxTuEgGR9mKL+2BEtEgrAUYDEIxQIB3M+RRwobKNuzujoFDgSyyKV82TBx
	 27bjWqOaM37eTwxAhohWrEgBfp+4gUQK3vviEIv5C722cJs+1e+mFpUNt1zCV89piY
	 dQUKR3dHXt6pGuIZTDnLjkvTb2ksbXhozNLUl6XRLXyDdWt5l+f8JkazNR2t4OetlC
	 nn/eak6UFbwv+xfpdNYrivj6oeGzb3PTajE7IEK5ngTat8RrZKa+l55ROHLJW9BYUh
	 zrCeXK5DwEV1A==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] wifi: wcn36xx: fix a typo
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20240913094319.13718-1-algonell@gmail.com>
References: <20240913094319.13718-1-algonell@gmail.com>
To: Andrew Kreimer <algonell@gmail.com>
Cc: Loic Poulain <loic.poulain@linaro.org>, wcn36xx@lists.infradead.org,
 linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
 kernel-janitors@vger.kernel.org, Andrew Kreimer <algonell@gmail.com>,
 Matthew Wilcox <willy@infradead.org>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <172667909414.4089263.7060582994040911136.kvalo@kernel.org>
Date: Wed, 18 Sep 2024 17:04:55 +0000 (UTC)

Andrew Kreimer <algonell@gmail.com> wrote:

> Fix a typo in comments.
> 
> Reported-by: Matthew Wilcox <willy@infradead.org>
> Signed-off-by: Andrew Kreimer <algonell@gmail.com>
> Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>

The subject should be unique so in the pending branch I changed it to:

wifi: wcn36xx: fix a typo in struct wcn36xx_sta documentation

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20240913094319.13718-1-algonell@gmail.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
https://docs.kernel.org/process/submitting-patches.html


