Return-Path: <linux-wireless+bounces-13268-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC4EC988EBC
	for <lists+linux-wireless@lfdr.de>; Sat, 28 Sep 2024 11:14:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 292381C20A6E
	for <lists+linux-wireless@lfdr.de>; Sat, 28 Sep 2024 09:14:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04B4619DFBB;
	Sat, 28 Sep 2024 09:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TxMgyKRN"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D584019E962
	for <linux-wireless@vger.kernel.org>; Sat, 28 Sep 2024 09:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727514873; cv=none; b=OcoboXjx51ikus09YdS6DdjPm6cZdc8g3uLSmU6nBnuUkqJP0NoHtOEGpuW/KVyHm97gbqyMqSsOYqQ3W560kX5/lb5tdngSYahNg/xZVaayekzcA/w1LYHfG06CRhbJUpMjp7BB/6QlhaSdR7YxpbhRDihUrUapun37bP8WMHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727514873; c=relaxed/simple;
	bh=acoXH87+ZnAl4sgwm79hfBXOU936Th4WR1Mn64B6ttA=;
	h=Content-Type:MIME-Version:Subject:From:In-Reply-To:References:To:
	 Cc:Message-ID:Date; b=T7Sbnu4VJ+3j4Sd2nmVkjc15pMfH5OKL3nB4NvtbFoL/BtvSCd9dfjwpxFUrmFryCJ0VEF35SMTXJrudbS8oMFfQq8t9251mrR87JmHQFb7lfmFp4alNjz/MZriJwfv6qEaEkWwErYQgT3wVjufcUjbl7YXRPlkLox8zRglQJm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TxMgyKRN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CA8EC4CEC3;
	Sat, 28 Sep 2024 09:14:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727514873;
	bh=acoXH87+ZnAl4sgwm79hfBXOU936Th4WR1Mn64B6ttA=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=TxMgyKRN21Q96KDUfAhvZVxGkNo/W+LiJaQB22p5PCQ1djJBjNxEiAfVK0O4mVLG/
	 O/NUOJMLCOaGDlIGZaY4Qvgr7EuMxurdrO6eAM69SgSfMdINh0RhYZ0qlHWVN6BpAk
	 IxG+9CA2L9oNn3Vrdu2Z0C/7kzoBUIwI5UBfnD/YxE0yMWz5giweVHk6SWGCdaucEr
	 PCUAz4QvthJJfciIEN3xghs627jBrSwV7ntyMxSMhgDfx6oVC8igBgx5w+wWoZd857
	 D70ppDZcjpwQGk3m/WCuAvcRVQcCIidfjQPQQv8ebHURNAagH30TrHy9XcQpvCD1Rz
	 /doj9wUq27thg==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] wifi: ath11k: Fix double free issue during SRNG deinit
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20240826053326.8878-1-quic_bpothuno@quicinc.com>
References: <20240826053326.8878-1-quic_bpothuno@quicinc.com>
To: Balaji Pothunoori <quic_bpothuno@quicinc.com>
Cc: <ath11k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
 Manikanta Pubbisetty
	<quic_mpubbise@quicinc.com>, Balaji Pothunoori <quic_bpothuno@quicinc.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <172751487057.2249584.15117916727845529860.kvalo@kernel.org>
Date: Sat, 28 Sep 2024 09:14:32 +0000 (UTC)

Balaji Pothunoori <quic_bpothuno@quicinc.com> wrote:

> Currently struct ath11k_hal::srng_config pointer is not assigned
> to NULL after freeing the memory in ath11k_hal_srng_deinit().
> This could lead to double free issue in a scenario where
> ath11k_hal_srng_deinit() is invoked back to back.
> 
> In the current code, although the chances are very low, the above
> said scenario could happen when hardware recovery has failed and
> then there is another FW assert where ath11k_hal_srng_deinit() is
> invoked once again as part of recovery.
> 
> Fix this by assigning the struct ath11k_hal::srng_config pointer
> to NULL after freeing the memory.
> 
> Tested-on: WCN6750 hw1.0 AHB WLAN.MSL.1.0.1-00887-QCAMSLSWPLZ-1
> Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILICONZ_LITE-3.6510.16
> Tested-on: IPQ5018 hw1.0 AHB WLAN.HK.2.6.0.1-00861-QCAHKSWPL_SILICONZ-1
> Tested-on: QCN9074 hw1.0 PCI WLAN.HK.2.7.0.1-01744-QCAHKSWPL_SILICONZ-1
> 
> Signed-off-by: Manikanta Pubbisetty <quic_mpubbise@quicinc.com>
> Signed-off-by: Balaji Pothunoori <quic_bpothuno@quicinc.com>
> Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

Patch applied to ath-next branch of ath.git, thanks.

5094204ff5ae wifi: ath11k: Fix double free issue during SRNG deinit

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20240826053326.8878-1-quic_bpothuno@quicinc.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
https://docs.kernel.org/process/submitting-patches.html


