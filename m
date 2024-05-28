Return-Path: <linux-wireless+bounces-8214-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A1AC68D22BB
	for <lists+linux-wireless@lfdr.de>; Tue, 28 May 2024 19:44:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3E4781F22CFD
	for <lists+linux-wireless@lfdr.de>; Tue, 28 May 2024 17:44:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3047481A5;
	Tue, 28 May 2024 17:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IHotNmS6"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E16B481A3
	for <linux-wireless@vger.kernel.org>; Tue, 28 May 2024 17:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716918235; cv=none; b=a97h4LkF6B7jWK/zAFSQsPjtlWp8YXr7i+RJeE6uRqPha9CmHXu5ILI/1uopnZnU2vWEIXFqZcDLZLq91uXRQ+AB/nDFdruGdkIK5Hfm9tyhdioqUaPSVsr9KwzTnBLsFRW5Rw4NID9pUhxOHVSxl/eYYvOj2y9aeDeS8nPRlbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716918235; c=relaxed/simple;
	bh=acMf32fu0JN28eSlBB0qI0jOAiIbnSOa9UfPdAOD10o=;
	h=Content-Type:MIME-Version:Subject:From:In-Reply-To:References:To:
	 Cc:Message-ID:Date; b=o8HdV6EbWGIrDvrend6mUNL5Zo/8RZRkNI0ZVFYVzoB9tOM50ZbANefLgFJowR3LCCTz7THKLRAoQfNjBcpKBuU1uPoU1/klGJ3grruvTHOIOv3KJ1u5UOJ3qV1S7OIRjReUD70c29SMEYe4w9RxuAxM++m0FXttrQO3rkeV2XI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IHotNmS6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 421FDC3277B;
	Tue, 28 May 2024 17:43:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716918235;
	bh=acMf32fu0JN28eSlBB0qI0jOAiIbnSOa9UfPdAOD10o=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=IHotNmS6iLNBAJLqukMUe67QExDQ5+rTAQE43QRz51r5YDgALRLNvI+UZ1TosINDB
	 jVqW+R6OmgDfXH0eP5mE+QeDX5NiprilwRL9jFiE9+Zs7sK/Xw2Cb3evi27V3NzfUi
	 ycanzFwTH5AGOVYylaDVSar4rwwlyEmlTYn11JxE0mbW1vsBYddU1JaetWwSIcdD9u
	 EYn6QxgnvgPKg6LX3dCfF/yxf9HhPAe3bAJnSUKhUoVAa2NJkhUEytzI8QRksUa9PJ
	 xmo8ONR+UC255qAbBHWVl8s27BuerQ+NmEHP+WkHxUFWXc3ykC0zsO+PlQA+dMhPbr
	 /HhWFGVWHpH2w==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] wifi: ath11k: fix wrong definition of CE ring's base
 address
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20240524021558.34452-1-quic_bqiang@quicinc.com>
References: <20240524021558.34452-1-quic_bqiang@quicinc.com>
To: Baochen Qiang <quic_bqiang@quicinc.com>
Cc: <ath11k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
 <quic_bqiang@quicinc.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <171691823254.1700985.17999890257962892911.kvalo@kernel.org>
Date: Tue, 28 May 2024 17:43:54 +0000 (UTC)

Baochen Qiang <quic_bqiang@quicinc.com> wrote:

> Base address of CE ring is defined as u32, currently this works
> because coherent DMA mask configured as 32 bit:
> 
>         #define ATH11K_PCI_COHERENT_DMA_MASK    32
> 
> However this mask could be changed once firmware bugs are fixed
> to fully support 36 bit DMA addressing. So to protect against any
> future changes to the DMA mask, change the type of the fields that
> are dependent upon it.
> 
> This is found during code review. Compile tested only.
> 
> Fixes: d5c65159f289 ("ath11k: driver for Qualcomm IEEE 802.11ax devices")
> Signed-off-by: Baochen Qiang <quic_bqiang@quicinc.com>
> Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

Patch applied to ath-next branch of ath.git, thanks.

5714e25f1d18 wifi: ath11k: fix wrong definition of CE ring's base address

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20240524021558.34452-1-quic_bqiang@quicinc.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


