Return-Path: <linux-wireless+bounces-13272-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F16FF988EC4
	for <lists+linux-wireless@lfdr.de>; Sat, 28 Sep 2024 11:19:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2E4571C20BBA
	for <lists+linux-wireless@lfdr.de>; Sat, 28 Sep 2024 09:19:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98EDC15B987;
	Sat, 28 Sep 2024 09:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jLX0mI7T"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 735F72AF15
	for <linux-wireless@vger.kernel.org>; Sat, 28 Sep 2024 09:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727515187; cv=none; b=N1xn9Xncjj3GNNp0DTa3okvG7I96cBQb+j69QV5m5jQP24O3pEB456RvAKgxreDZDvYiWOLt0eTpszgSgagzT5IlouztwbVnEcGPqNpRYZigWGwKhA0owrfxxBPv5SeTORQ8Vi7W9Hb2rReVQH6C0h7IFbRlevwtMVM6YZ4CGeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727515187; c=relaxed/simple;
	bh=0HpofGMU4EYTwavpEVFLiZ98wyxVSyXqgct2C7t40e8=;
	h=Content-Type:MIME-Version:Subject:From:In-Reply-To:References:To:
	 Cc:Message-ID:Date; b=WHByTFm1dENWZhyOCsnFbvn/MQXVgKlwdU41P25WuXHwT8c8JuCjA7IbFpWeAFyGhMwvWoKMu9zZ5MDiiIphOCZrjpTvFX1fXb6dWEJ2bXyY0UnxKZGH03oPfztVe5XCTdbnwwCJ79CdhFowaJLuZ8vYxIJzZCN9f7QIEcAhS2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jLX0mI7T; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A23DC4CEC3;
	Sat, 28 Sep 2024 09:19:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727515187;
	bh=0HpofGMU4EYTwavpEVFLiZ98wyxVSyXqgct2C7t40e8=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=jLX0mI7TlnZyZXYSud21sSwyNRwWpt5tKrkLInKgaA4Ugdt6DtEd8F8pIRidmFI+u
	 pzNCL+xL7AepHINke3jKi8+Ww5Epv8bpfXIJ/S08juRiK25y4oFTpIX2/R8wBD3Y00
	 uJqiCqsXtRYFG3vTVKDDUmqFqup7658NVwGt2v3KNQey0QWXSrDwYHRwUHWFymfhwE
	 /5cJkVQxykG4gZ4jwcYVtWmYYwA4IOplVY9Z9ofUrLGt5lGRlZ+rlbW/IvwWBU+WO+
	 e9mTRht+uoTmtg/Y5khCTKYbihgpVlZpva+pBdqYiQU3MClWl9QwUnKlVfnpHSgnZJ
	 Wx1PBkcvYoHlg==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] wifi: ath12k: move txbaddr/rxbaddr into struct ath12k_dp
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20240830081942.3623380-1-nico.escande@gmail.com>
References: <20240830081942.3623380-1-nico.escande@gmail.com>
To: Nicolas Escande <nico.escande@gmail.com>
Cc: ath12k@lists.infradead.org, linux-wireless@vger.kernel.org
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <172751518486.2249584.15339812073510249276.kvalo@kernel.org>
Date: Sat, 28 Sep 2024 09:19:46 +0000 (UTC)

Nicolas Escande <nico.escande@gmail.com> wrote:

> Those two fields are used to store the per SPT page of tx/rx descriptors send to
> the firmware for cookie conversion. Right now they are in struct ath12k_spt_info
> which means they are duplicated PPT page times while we only need one instance
> of them. This works for now as we always use the first spt_info as a global
> storage for all PPT pages.
> 
> Let's move them into struct ath12k_dp where they belong, alongside of the
> spt_info array they are tied to, to avoid waisting a good bit of memory.
> 
> Tested-on: QCN9274 hw2.0 PCI CI_WLAN.WBE.1.3-03283.1-QCAHKSWPL_SILICONZ-2
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
> 
> Signed-off-by: Nicolas Escande <nico.escande@gmail.com>
> Reviewed-by: Remi Pommarel <repk@triplefau.lt>
> Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

Patch applied to ath-next branch of ath.git, thanks.

3ed5cb8dfbeb wifi: ath12k: move txbaddr/rxbaddr into struct ath12k_dp

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20240830081942.3623380-1-nico.escande@gmail.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
https://docs.kernel.org/process/submitting-patches.html


