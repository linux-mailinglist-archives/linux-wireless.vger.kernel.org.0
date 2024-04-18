Return-Path: <linux-wireless+bounces-6529-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 410538A9E2A
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Apr 2024 17:21:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7328B1C21941
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Apr 2024 15:21:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B09A11635B3;
	Thu, 18 Apr 2024 15:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rkpf1/3r"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D26815FA73
	for <linux-wireless@vger.kernel.org>; Thu, 18 Apr 2024 15:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713453669; cv=none; b=uorcI2B6BoPPQXRHyYAb8MZjE0xioVMgRxMABO43/UNSRZsIY8D8PT0l+N4Ha7uo93dXcGscBWY3tTwsuDSdQpPy7a9EoOfDwYcGpqy0jMZhHmBrWXhqiIIKsCvo2ybo1OuR5GYZg6Xn1KWJe4CRAeuldAiVlmzTdtp/JgjSTZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713453669; c=relaxed/simple;
	bh=J43tWxGE4Ftm9L6Xm+zZd/z0nH+wgtacixPnL6lkcyA=;
	h=Content-Type:MIME-Version:Subject:From:In-Reply-To:References:To:
	 Cc:Message-ID:Date; b=Xv/kMNqoPbAxslr5EeenvIZikN2xZexOTHoheBjhq3Jsz7ROwp9TSPhmltIoCN3rDuHLV7SKf0y+ykAbCiFF99aQ0FNgap3fQRfopx70/uV81lISNzusMO36ejUn5z4P0Zqt61kMw9bi/y3weQLdVvcbFPrUVHK85izVbFxmXng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rkpf1/3r; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65B75C113CC;
	Thu, 18 Apr 2024 15:21:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713453669;
	bh=J43tWxGE4Ftm9L6Xm+zZd/z0nH+wgtacixPnL6lkcyA=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=Rkpf1/3rSiWpY3X5zVkX3aJ3HnXgiz2PqisdcREJFkjwOM+rDLe6ExTwEE9z4j8pB
	 //It2sSXGCfflIl8ECzPD0Xc/PcER84jTSDaLSTCbZMOopN8oG5Qi8YlRR2Zf+b/5K
	 MTj0m8QuoBlfrl9BDwHCEBtOUAAfgreI1hY5eJvf7hGdHUM2mBm+KyOiBeKcphRHBG
	 y44cs8leGgN5qW/jIlruSF5LXjdo9Y2vsonN8ENPW7FHooOO56yv1VVYjR1y5ON7g+
	 bw4dzbsTLobTsMoxTPyvM7GP1HqKLXzZCQAebLfhor+/+fpUfQzRPCZjAEaWIOVK+U
	 CZ7IrnK0aqNuA==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] wifi: ath12k: enable WIPHY_FLAG_DISABLE_WEXT
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20240411165645.4071238-1-kvalo@kernel.org>
References: <20240411165645.4071238-1-kvalo@kernel.org>
To: Kalle Valo <kvalo@kernel.org>
Cc: ath12k@lists.infradead.org, linux-wireless@vger.kernel.org
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <171345366633.934743.2036599275611507986.kvalo@kernel.org>
Date: Thu, 18 Apr 2024 15:21:08 +0000 (UTC)

Kalle Valo <kvalo@kernel.org> wrote:

> ath12k will support Multi-Link Operation (MLO) in the future but not yet. A
> major change with MLO is that cfg80211 will disable Wireless Extension (WEXT)
> user space interface. To avoid having inconsistent user experience, first
> supporting WEXT and later not, disable WEXT already now.
> 
> Now ath12k claims that WEXT is not supported:
> 
> $ iwconfig wlan0
> wlan0     no wireless extensions.
> 
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
> 
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>
> Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>

Patch applied to ath-next branch of ath.git, thanks.

03a509740b5d wifi: ath12k: enable WIPHY_FLAG_DISABLE_WEXT

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20240411165645.4071238-1-kvalo@kernel.org/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


