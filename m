Return-Path: <linux-wireless+bounces-5097-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B4CB885B6B
	for <lists+linux-wireless@lfdr.de>; Thu, 21 Mar 2024 16:09:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8B1E2B254F2
	for <lists+linux-wireless@lfdr.de>; Thu, 21 Mar 2024 15:09:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1478F85943;
	Thu, 21 Mar 2024 15:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fo0cDsDh"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4EC93A1DD
	for <linux-wireless@vger.kernel.org>; Thu, 21 Mar 2024 15:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711033744; cv=none; b=t7dNb8fQCpybVx8y770na3vZDVmOdrGUnj5eCYoFia0n2dU4xWEHz4eyeJNcQELvJ8WS6Z5tAeZjZuDOoY/y2m6IM2XHDFqJHMVql2T1K2dR+uxUwRvYqi6X9/d/ouL+PdR/Z0DZxJ4FpjKhfHxiUUYmzLR0dh0qLSEZBO4LeBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711033744; c=relaxed/simple;
	bh=AVrisdTo0YcYwUkt5rVAKmDOumoM56vN0yTSAF9NJ48=;
	h=Content-Type:MIME-Version:Subject:From:In-Reply-To:References:To:
	 Cc:Message-ID:Date; b=kCr41KDca1vk1jlxQwp3fKIiaj2u3o5BmxhAfpaVa4L12GElnSqGH72ej8bqKICC37iDHp9ZnnifvB4XlVmKqIzCaggQX3+CHnRZBkc1tlIv7guOIcdcpCqLYAx8bzKAyQwSrA/UM6ysJ0tqg4Eh0+iciTk88kyV4eznuIjQWy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fo0cDsDh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F423C433F1;
	Thu, 21 Mar 2024 15:09:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711033743;
	bh=AVrisdTo0YcYwUkt5rVAKmDOumoM56vN0yTSAF9NJ48=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=fo0cDsDh42wDwAEnnoYwPMSKwRPFcPdvxbcvLMYQopYwIs3unlByGaU3Hi0506jQs
	 EsXxVcvBzJbHACL4ECC8eL77PDPjP7eS3PJcetj3VQDWoOxEwtoubNcECwrjNMOkjk
	 nTYTLZTsVNaDWYBC47X3TWeKSRpuJ5IO/WWT1kn7MnPTtNvbIGXkfWxnJ4OiWOccW+
	 2i47omdvnkaSg8w2sFJpuP9NF9uv86San1oetPLIWT0JHzJnBWfikb2dck2m/DknXY
	 UCbNbP3S/Qo/p5eoMgoPn8nx/qqQys7YDuJ3Gnqj/7ED9VXpuJQDX8mbQtgrknSiwt
	 qSfFG0MmvHhfQ==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] wifi: mt76: mt7915: workaround too long expansion sparse
 warnings
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: 
 <5457b92e41909dd75ab3db7a0e9ec372b917a386.1710858172.git.lorenzo@kernel.org>
References: 
 <5457b92e41909dd75ab3db7a0e9ec372b917a386.1710858172.git.lorenzo@kernel.org>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: nbd@nbd.name, linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com,
 shayne.chen@mediatek.com, ryder.lee@mediatek.com
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <171103374029.103792.2953656896517563053.kvalo@kernel.org>
Date: Thu, 21 Mar 2024 15:09:02 +0000 (UTC)

Lorenzo Bianconi <lorenzo@kernel.org> wrote:

> Fix the following sparse warnings:
> 
> drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c:1133:29: error: too long token expansion
> drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c:1133:29: error: too long token expansion
> drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c:1133:29: error: too long token expansion
> drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c:1133:29: error: too long token expansion
> 
> No functional changes, compile tested only.
> 
> Fixes: e3296759f347 ("wifi: mt76: mt7915: enable per bandwidth power limit support")
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> Acked-by: Felix Fietkau <nbd@nbd.name>

Patch applied to wireless-next.git, thanks.

2d5cde1143ec wifi: mt76: mt7915: workaround too long expansion sparse warnings

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/5457b92e41909dd75ab3db7a0e9ec372b917a386.1710858172.git.lorenzo@kernel.org/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


