Return-Path: <linux-wireless+bounces-8056-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E8F78CEE3C
	for <lists+linux-wireless@lfdr.de>; Sat, 25 May 2024 10:54:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EAC8A1F21544
	for <lists+linux-wireless@lfdr.de>; Sat, 25 May 2024 08:54:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94E7714AB4;
	Sat, 25 May 2024 08:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ddZCxgbf"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F40846A4
	for <linux-wireless@vger.kernel.org>; Sat, 25 May 2024 08:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716627294; cv=none; b=JVYhFcIyz8NUTK0HagXPJe59wtS4U/lFgqVnKvSowGedE6VvK8lnDlRdtvyhR2jbkNxfyKab/YoN7wxGEo61fBJyrGA+PCqE8tF3SgO/1y2NkjskJUYyi9P+Z92V6KpYcnvGfea0/6vAPdU26Z3+POmyR/BCAgGOw+M3zENcB68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716627294; c=relaxed/simple;
	bh=Kpixmm+1/z3WzvujAUF+JyjqlGx9bGig4lkBXVLamCM=;
	h=Content-Type:MIME-Version:Subject:From:In-Reply-To:References:To:
	 Cc:Message-ID:Date; b=YXHtYUIYQcjswB1YxY/XZBj6je7u5QVovC+ptb2oFQlzQ01TtTQoyhw7nUCCcPwgifN3q8IcGM7lPBW5OIYkNFEfiLtzEx5yytY2r9/SVolXJrJTleoU91H0JfTDLSQvhTnpw0nOOxhaxCzGwiCNVgIkA7a2fNZb75eXrdyQGLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ddZCxgbf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01C87C3277B;
	Sat, 25 May 2024 08:54:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716627294;
	bh=Kpixmm+1/z3WzvujAUF+JyjqlGx9bGig4lkBXVLamCM=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=ddZCxgbfeb9hF6fHQfEj/ybs/PsCQRdF28QbkwR/Mb149qxg/cbi7yWjcLYmJRjkZ
	 kLX2oo3r70Xu/uNLl2PLBGIo8fSOPgwtzrpPFqZ0MQv9SLpYLv2T7cLVnmSsPvVaM+
	 dMUJETwnvcCM+jVa1pvhFlf0Fq7rWo0X40YO3OmHHp2yQH75JRieoHMpb0FmNXDWDZ
	 t+QNqNrcYlgyNzctYo9H4FEgN+zar2Q/z5ON4Gv7ef2BZwn70l3zsg/0uAD6dutIA8
	 xFBmj+ZyEcBVJzZnwK9kJWV2oDmUwc6VTKERL4pGMrX9XsSSm+9esMVT+7By3FMYbD
	 dqQevWFon9K9g==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 1/2] wifi: ath12k: Refactor Rx descriptor CMEM
 configuration
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20240516000807.1704913-2-quic_periyasa@quicinc.com>
References: <20240516000807.1704913-2-quic_periyasa@quicinc.com>
To: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
Cc: <ath12k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
 Karthikeyan Periyasamy
	<quic_periyasa@quicinc.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <171662729107.564311.13966579301897980199.kvalo@kernel.org>
Date: Sat, 25 May 2024 08:54:52 +0000 (UTC)

Karthikeyan Periyasamy <quic_periyasa@quicinc.com> wrote:

> Currently, data path Rx descriptor placed in the CMEM memory respective
> to the Rx offset. This Rx descriptor CMEM placement is not meeting the
> requirements to support inter device MLO. In inter device MLO, multiple
> devices participate in a group. The device specific Rx descriptor buffers
> transmit to multiple device REO rings. To distinguish between device
> specific Rx descriptor buffers, the CMEM setup configuration need to
> choose a different placement based on the unique identifier (device index).
> 
> Below are the CMEM configuration placement representation:
> 
> Intra-Device MLO scenario:
> 
>         Device 0                                Device 1
> 
>      +-------------+                         +-------------+
>      |             |                         |             |
>      |     Tx      |                         |     Tx      |
>      |             |                         |             |
>      +-------------+                         +-------------+
>      |             |                         |             |
>      |     Rx      |                         |     Rx      |
>      |             |                         |             |
>      +-------------+                         +-------------+
> 
> Inter-Device MLO scenario:
> 
>         Device 0                                Device 1
> 
>      +-------------+                         +-------------+
>      |             |                         |             |
>      |     Tx      |                         |     Tx      |
>      |             |                         |             |
>      +-------------+                         +-------------+
>      |             |                         |             |
>      |     Rx      |                         |   Reserved  |
>      |  Device 0   |                         |             |
>      |             |                         |             |
>      +-------------+                         +-------------+
>      |             |                         |     Rx      |
>      |   Reserved  |                         |   Device 1  |
>      |             |                         |             |
>      +-------------+                         +-------------+
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
> Tested-on: WCN7850 HW2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
> 
> Signed-off-by: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
> Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

2 patches applied to ath-next branch of ath.git, thanks.

4f82a8d5c277 wifi: ath12k: refactor rx descriptor CMEM configuration
35864b62fa12 wifi: ath12k: improve the rx descriptor error information

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20240516000807.1704913-2-quic_periyasa@quicinc.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


