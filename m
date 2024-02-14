Return-Path: <linux-wireless+bounces-3568-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A0558543E7
	for <lists+linux-wireless@lfdr.de>; Wed, 14 Feb 2024 09:16:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6CE241C2251B
	for <lists+linux-wireless@lfdr.de>; Wed, 14 Feb 2024 08:15:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56A39125A6;
	Wed, 14 Feb 2024 08:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ATUooogL"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 324C5125A4
	for <linux-wireless@vger.kernel.org>; Wed, 14 Feb 2024 08:15:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707898556; cv=none; b=btPRzWwzQHwC3DliPyMvYbnSrVdDwwC9FRGpvVnBxoZrDBntgeMQ7Rnj7Rer1fOAjxASE3DNuy2rnqcQBK86G5emKqu1T3LjF/G8P/MW7tQxszQa/57q9OHHgAJtx6tmwg96p6W7xu5gwHQmITBQ6+LzCAbr4Mbf34/mfcKAmFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707898556; c=relaxed/simple;
	bh=qOkqjcmIQarjisBZIh76v+uAW3kG2nLiaTnmAU/OxKE=;
	h=Content-Type:MIME-Version:Subject:From:In-Reply-To:References:To:
	 Cc:Message-ID:Date; b=j1+lrNPc1nfCRpyI4tz5qpoYIHgmig2x6BeOI3wgYb/uqKwU17FYvCLOMqQfF2Qgw/Ex8t7shBB+z2DX0J0TUiJsstMrXTsRVc+Rk6e+uekRY4DE6ggndGiH3yk+UuA2gMDkiwFT2t7K3E0DImt+zqUeV/2fhrAgDkX3415bur0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ATUooogL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2E30C433C7;
	Wed, 14 Feb 2024 08:15:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707898555;
	bh=qOkqjcmIQarjisBZIh76v+uAW3kG2nLiaTnmAU/OxKE=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=ATUooogL91zyqTu4hUp+29S6PPukUun34xRjWuGPqQXULkgg9YxXLDwaCWN4oThBP
	 dO34VIlgfE3ATsV+//lDip4CmQ+zqKanyFKcH8WQ9d1ymLZxZmQQ8rM5KRtWbTEQa4
	 xMo0D1skN5l+jSVOcoCZSQbslJErtZ+jq+PoH250QCPsDutJAn5jeK9bARM/ZBJZHq
	 e7pR5fYOkkMZf4x9roPWKH4awBXX203wrnQ/MvfaZWanEqLymCOKXrloH3S62mfB/P
	 jdSe0+RQBnC613toTxXnxNQhl0aZcjE/dDn84dp9uC5mDe3OlDIfgjeUWUmycoK8Hx
	 R/1pPmNWNbSfQ==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2 1/2] wifi: ath11k: Do not directly use scan_flags in
 struct
 scan_req_params
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20240209113536.266822-2-nico.escande@gmail.com>
References: <20240209113536.266822-2-nico.escande@gmail.com>
To: Nicolas Escande <nico.escande@gmail.com>
Cc: ath11k@lists.infradead.org, linux-wireless@vger.kernel.org
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <170789855274.3088943.4437243850124616394.kvalo@kernel.org>
Date: Wed, 14 Feb 2024 08:15:54 +0000 (UTC)

Nicolas Escande <nico.escande@gmail.com> wrote:

> As discussed in [1] lets not use WMI_SCAN_XXX defines in combination with
> scan_flags directly when setting scan params in struct scan_req_params but use
> the underlying bitfield. This bitfield is then converted to WMI_SCAN_XXX when
> filling the WMI command to send to the firmware.
> 
> [1] https://lore.kernel.org/all/871qae51wx.fsf@kernel.org/
> 
> Tested-on: QCN9074 PCI WLAN.HK.2.7.0.1-01744-QCAHKSWPL_SILICONZ-1
> 
> Signed-off-by: Nicolas Escande <nico.escande@gmail.com>
> Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

2 patches applied to ath-next branch of ath.git, thanks.

64493a7ff74b wifi: ath11k: Do not directly use scan_flags in struct scan_req_params
79ad70c6df0a wifi: ath11k: Remove scan_flags union from struct scan_req_params

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20240209113536.266822-2-nico.escande@gmail.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


