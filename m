Return-Path: <linux-wireless+bounces-7281-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B66FC8BE05C
	for <lists+linux-wireless@lfdr.de>; Tue,  7 May 2024 12:56:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E874D1C2213B
	for <lists+linux-wireless@lfdr.de>; Tue,  7 May 2024 10:56:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B30FF152E0F;
	Tue,  7 May 2024 10:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oRSHGPst"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D6B01514D4;
	Tue,  7 May 2024 10:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715079265; cv=none; b=CMZcBI2tIrBzratrMIEaP6XtvKIhTDFBcZBtdQhyicQmcG3KNeuaEKRXiQ23j+mH+5EiIc+fmA9a/f2llQ0bivxCckNRA5WHhS2LP4bOUxryI4GSN7yq/viiggngUvXTAvsN/ZItuMHbgEzZPS0VYUh/guTe/ts+BnK/3LMKFKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715079265; c=relaxed/simple;
	bh=x3+TjIsYg6xVZcpqHsEC6+vHNVSJS+vbAGLYUkgzoHY=;
	h=Content-Type:MIME-Version:Subject:From:In-Reply-To:References:To:
	 Cc:Message-ID:Date; b=tFRGOQgcZonpDCAW6Gk9HbFdpxDRqBBTfLeDrTkCmvoDzIYrZ/6ITHI9pY+50X2oJRs5hb7Od81nyJzOr57uqjBvqM9BEnvQPFgAWRcw/o5P3p0YrGwThczMuo1/efMstiPMHbOW3Nr1DLLoKvSHmxoRgcsgr6F7BcG+tMyWxwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oRSHGPst; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B813BC2BBFC;
	Tue,  7 May 2024 10:54:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715079265;
	bh=x3+TjIsYg6xVZcpqHsEC6+vHNVSJS+vbAGLYUkgzoHY=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=oRSHGPstoXLM047W8nTxzF4tFZ7raDGOAmpEJB9rhPiCcoLHBjWwoJHmZdtkfxVdT
	 QlvDSgvEJ0EqXM8xPMHtTlgczZ5QHkPZ3fPmGCCKqB3hMo+Hg9TczVvCyVRUhZ5KS0
	 lW4QVQBKoYUw0pfodhxPlPviHpbaAwWaKmGQQ+ru/UK9uLfQMvXuDy0XwvifE8iM/s
	 uy+ts1jMRRXeEf0A0meDdPNcItDiu6+r0YdalFc2DvKJhOdZw/XLrvET70SLOvLDAD
	 y4Fs984dyHSmDEy5VsJQpr5U5NlrD3NTo5lutoEo0wKZ0ZRYwnqHuZxI7hS2aPEbmv
	 Mvd9r2RSrNLYw==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 1/2] wifi: ath12k: fix misspelling of "dma" in
 num_rxmda_per_pdev
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: 
 <20240504-ath12k_dp_rxdma_ring_sel_config_wcn7850-ret-v1-1-44d2843a2857@quicinc.com>
References: 
 <20240504-ath12k_dp_rxdma_ring_sel_config_wcn7850-ret-v1-1-44d2843a2857@quicinc.com>
To: Jeff Johnson <quic_jjohnson@quicinc.com>
Cc: Jeff Johnson <jjohnson@kernel.org>, <linux-wireless@vger.kernel.org>,
 <ath12k@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
 Jeff Johnson <quic_jjohnson@quicinc.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <171507926213.4120318.15441054563934456845.kvalo@kernel.org>
Date: Tue,  7 May 2024 10:54:23 +0000 (UTC)

Jeff Johnson <quic_jjohnson@quicinc.com> wrote:

> The ath12k_hw_params member num_rxmda_per_pdev contains a misspelling
> of "dma" so fix it.
> 
> No functional changes, compile tested only.
> 
> Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

There was a trivial conflict in ath12k_dp_rx_pdev_srng_free(), please check my changes:

https://git.kernel.org/pub/scm/linux/kernel/git/kvalo/ath.git/commit/?h=pending&id=238d04b67c32e99181b0249bb847b11ce702960b

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20240504-ath12k_dp_rxdma_ring_sel_config_wcn7850-ret-v1-1-44d2843a2857@quicinc.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


