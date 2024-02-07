Return-Path: <linux-wireless+bounces-3294-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 73B9784CDAD
	for <lists+linux-wireless@lfdr.de>; Wed,  7 Feb 2024 16:08:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 02F3FB279E6
	for <lists+linux-wireless@lfdr.de>; Wed,  7 Feb 2024 15:08:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8DFA7F48C;
	Wed,  7 Feb 2024 15:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VD+Ura7k"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AC1C7E791;
	Wed,  7 Feb 2024 15:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707318496; cv=none; b=DwhnTU5GsEK+6ticAISkPtuzJfpSY9FwA+b4YmdmLHmRQ45IXqHaIHYduEltUuJQtVWN3/V6B72d5YRoMCvlgd2R2M5qlrJgLynaI6ELjjCDIXg4sf6FbrXklg/5FwS9ZNsuCS2GU8vnuhE2DxSzrIUdNQkJrQ2BOmSGjajDEVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707318496; c=relaxed/simple;
	bh=y/x282TGyBYCjdhcKYKHYG/kynm2rucyoPS3V5ieUbM=;
	h=Content-Type:MIME-Version:Subject:From:In-Reply-To:References:To:
	 Cc:Message-ID:Date; b=l13NEFv7dXiTPKc9lJaBzpOXGhiVPPF2iwkroW+sIUx+dedxwkODLvDUZeVidQ0ewGSkaLQuuvmG82gNPJQ6taoXTheixe6mMlUikPSa9A9WDFeYfBAnfuMrqLUwcfjwKk/Y7KD8zhTa7vTtraMVzFDfE5bb9+tRmgtBH+HmEks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VD+Ura7k; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AB68C433C7;
	Wed,  7 Feb 2024 15:08:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707318496;
	bh=y/x282TGyBYCjdhcKYKHYG/kynm2rucyoPS3V5ieUbM=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=VD+Ura7ktRstWIYsHIa0uBGaRlrylJuQiMb0G/Z1Ou/klx3BKPrNCku8O1PnAr1UU
	 rvp/vWbyITQnsJpu6D0bAB2etGy+Jbz1Sg0TxzhabyHBx3/EM1OHrG3m36ha5EumsV
	 S+Q/7b38B4inl0Pw3jRCNOqCHK4PYZcb0e7lmHvDjw4GFKD7rPTj+AcLx5BupeHXCH
	 Uc+/e8h83XnknucKPCfn4oFURhl7giw8RzjKTPTXLYp9kBcXEluB06St/WY5frZlcO
	 h5tm2ekwL3m/MMf/j+w6iLZp9qqcgCYebibORvCinj+uiNxqiF3sAJyp0Abj9RvDlR
	 HNfC1dJlP4NTA==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] wifi: ath12k: Fix uninitialized use of ret in
 ath12k_mac_allocate()
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20240205-ath12k-mac-wuninitialized-v1-1-3fda7b17357f@kernel.org>
References: <20240205-ath12k-mac-wuninitialized-v1-1-3fda7b17357f@kernel.org>
To: Nathan Chancellor <nathan@kernel.org>
Cc: quic_jjohnson@quicinc.com, morbo@google.com, justinstitt@google.com,
 quic_periyasa@quicinc.com, ath12k@lists.infradead.org,
 linux-wireless@vger.kernel.org, llvm@lists.linux.dev,
 patches@lists.linux.dev, Nathan Chancellor <nathan@kernel.org>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <170731849247.2220494.17976129376947521581.kvalo@kernel.org>
Date: Wed,  7 Feb 2024 15:08:14 +0000 (UTC)

Nathan Chancellor <nathan@kernel.org> wrote:

> Clang warns (or errors with CONFIG_WERROR=y):
> 
>   drivers/net/wireless/ath/ath12k/mac.c:8060:9: error: variable 'ret' is uninitialized when used here [-Werror,-Wuninitialized]
>    8060 |         return ret;
>         |                ^~~
>   drivers/net/wireless/ath/ath12k/mac.c:8022:9: note: initialize the variable 'ret' to silence this warning
>    8022 |         int ret, i, j;
>         |                ^
>         |                 = 0
>   1 error generated.
> 
> Commit 6db6e70a17f6 ("wifi: ath12k: Introduce the container for mac80211
> hw") added a completely uninitialized use of ret. Prior to that change,
> -ENOMEM was returned to the callers of ath12k_mac_allocate() whenever
> ath12k_mac_hw_allocate() failed. Assign that value to ret to make sure
> it is always initialized when used and clear up the warning.
> 
> Closes: https://github.com/ClangBuiltLinux/linux/issues/1989i
> Fixes: 6db6e70a17f6 ("wifi: ath12k: Introduce the container for mac80211 hw")
> Signed-off-by: Nathan Chancellor <nathan@kernel.org>
> Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

Patch applied to ath-next branch of ath.git, thanks.

04edb5dc68f4 wifi: ath12k: Fix uninitialized use of ret in ath12k_mac_allocate()

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20240205-ath12k-mac-wuninitialized-v1-1-3fda7b17357f@kernel.org/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


