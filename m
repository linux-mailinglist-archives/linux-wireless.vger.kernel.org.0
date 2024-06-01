Return-Path: <linux-wireless+bounces-8369-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F3FB8D6F39
	for <lists+linux-wireless@lfdr.de>; Sat,  1 Jun 2024 11:58:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0EC171F214BA
	for <lists+linux-wireless@lfdr.de>; Sat,  1 Jun 2024 09:58:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9623B14EC41;
	Sat,  1 Jun 2024 09:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nUEVUUm7"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7277214EC40
	for <linux-wireless@vger.kernel.org>; Sat,  1 Jun 2024 09:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717235879; cv=none; b=OdAHtC2XGj2/RhVx2WaCu5nZfdXRCVMDMgcPNW3t48brq4j5M2uZmygLVkWqjnQhnDwmFcP7teiA0ifRmuQRrizrpVtye37gKl0y0vCWV3LAwtmL04dcA6jSoF08ud1KHvTt01k03UZbjvum0miShw2HZNK9HVhfEOSe5XjIDyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717235879; c=relaxed/simple;
	bh=ABPZwTl98JqWjY9l5L1A3Pf6ulH1Xx1AiunqIWYybpw=;
	h=Content-Type:MIME-Version:Subject:From:In-Reply-To:References:To:
	 Cc:Message-ID:Date; b=seKD/XRkDua4j1hUCeFzc7HJzjpj6pN0LVfelxU5SlaNZ2YFEXZDvYJBd7cZ9UK0TdT1LrjUguwuYi9sZjJgpV5/Iz+foTfmToNzq9WXz/FvvDM1qyKFYuroiPeqtcGTvwbg4KGtho8FMUtOBy9XBucbhvnQIVOyZexcYAvPnJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nUEVUUm7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A92D0C116B1;
	Sat,  1 Jun 2024 09:57:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717235879;
	bh=ABPZwTl98JqWjY9l5L1A3Pf6ulH1Xx1AiunqIWYybpw=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=nUEVUUm7eSNS5laRl59xNobBEKQP0WW2fCspCPBBM9SDbjXRDElexohcHagse0Dz4
	 mcaLPiGc7LkdxgynDO7uhGBoYOx+aoqGpdTnwmlyrr4E8jCtX3vL4uipXK+Dm1kuxf
	 siPiLDzBRKBaLZA+/YP7naIWhEsFdzXUcsQUpp78tpVNufEl1feSWL4fMdgpY/DgCh
	 XK9rqSHiptRdzorr1PleYuOzpTHhNYykLQ4K+c/zPpZsb6Nonhm7o5T4kdZjqeJujw
	 eKJeNg/Kjh8cP77a3D5HUDh/21qKJUrN7c6T1vi2Km41a+A5eRwSvfBFSflkD7IpkJ
	 fFtPzm3pxSaSA==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: pull-request: ath-current-20240531
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: <87ttidvrup.fsf@kernel.org>
References: <87ttidvrup.fsf@kernel.org>
To: Kalle Valo <kvalo@kernel.org>
Cc: linux-wireless@vger.kernel.org, ath10k@lists.infradead.org,
 ath11k@lists.infradead.org, ath12k@lists.infradead.org,
 quic_jjohnson@quicinc.com
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <171723587573.967328.5470768065737630382.kvalo@kernel.org>
Date: Sat,  1 Jun 2024 09:57:57 +0000 (UTC)

Kalle Valo <kvalo@kernel.org> wrote:

> Hi,
> 
> Please pull, more information in the tag below.
> 
> Kalle
> 
> The following changes since commit 1d60eabb82694e58543e2b6366dae3e7465892a5:
> 
>   wifi: mwl8k: initialize cmd->addr[] properly (2024-05-07 15:08:14 +0300)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/kvalo/ath.git tags/ath-current-20240531
> 
> for you to fetch changes up to 6e16782d6b4a724f9c9dcd49471219643593b60c:
> 
>   wifi: ath11k: move power type check to ASSOC stage when connecting to 6 GHz AP (2024-05-23 15:45:52 +0300)
> 
> ----------------------------------------------------------------
> Merge ath-current from git://git.kernel.org/pub/scm/linux/kernel/git/kvalo/ath.git
> 
> ath.git fixes for 6.10. Two fixes for user reported regressions in
> ath11k. One dependency fix and one error path fix.
> 
> ----------------------------------------------------------------
> Baochen Qiang (1):
>       wifi: ath11k: move power type check to ASSOC stage when connecting to 6 GHz AP
> 
> Breno Leitao (1):
>       wifi: ath11k: Fix error path in ath11k_pcic_ext_irq_config
> 
> Carl Huang (1):
>       wifi: ath11k: fix WCN6750 firmware crash caused by 17 num_vdevs
> 
> Dmitry Baryshkov (1):
>       wifi: ath10k: fix QCOM_RPROC_COMMON dependency
> 
>  drivers/net/wireless/ath/ath10k/Kconfig |  1 +
>  drivers/net/wireless/ath/ath11k/core.c  |  2 +-
>  drivers/net/wireless/ath/ath11k/mac.c   | 38 ++++++++++++++++++++++-----------
>  drivers/net/wireless/ath/ath11k/pcic.c  | 25 +++++++++++++++-------
>  4 files changed, 44 insertions(+), 22 deletions(-)

Pulled, thanks.

10bc8558b59a Merge tag 'ath-current-20240531' of git://git.kernel.org/pub/scm/linux/kernel/git/kvalo/ath

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/87ttidvrup.fsf@kernel.org/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


