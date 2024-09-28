Return-Path: <linux-wireless+bounces-13271-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 647C0988EC1
	for <lists+linux-wireless@lfdr.de>; Sat, 28 Sep 2024 11:17:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 14D981F211EC
	for <lists+linux-wireless@lfdr.de>; Sat, 28 Sep 2024 09:17:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B62B15B987;
	Sat, 28 Sep 2024 09:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f7PqAes0"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34BB82AF15;
	Sat, 28 Sep 2024 09:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727515035; cv=none; b=q7sHnsIRF0AN45wbU2rMxFo4g86a2COEbWbTsDZwRBIHOFJ/d5sxdoLKdgr+qrQ78SAtkqzUGlb0upJ5BL5i/PTLisp5VLYUKElenZJzV/+NMbZSn9bipI7cku8277XLp9tTjwhIs3V+30NugquGE9dltLSUWu2gFqNJzp6xDOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727515035; c=relaxed/simple;
	bh=zlFE7sjU8cNkipIRBOILe/Ow1jb6tDtCKLZpkN0gd+k=;
	h=Content-Type:MIME-Version:Subject:From:In-Reply-To:References:To:
	 Cc:Message-ID:Date; b=r37VpNNQC5RKJT7n0c5punBf1hKxV3ea2jCOZsD37/rY6Eoo2WzvyjZ7x7UNhOOYi2w+QZdEg/AQiOo/ZFQZG9nz4QPMR0BNsMtx2pAgWndcWeYNyorM+sNNxmKiM7p6b1hZ9l4Ms9n5v+nYTxptvheZlcgGKQna3WyKHH7NpCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f7PqAes0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD229C4CEC3;
	Sat, 28 Sep 2024 09:17:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727515035;
	bh=zlFE7sjU8cNkipIRBOILe/Ow1jb6tDtCKLZpkN0gd+k=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=f7PqAes02e7bGpkU2wkqWqjYg+1Xd2gKrgWRVMMEi75Th5oYb17vRfay9vDx1X08V
	 54M0K1mJsbbX4dv9ArsoAsxHCYczv+c1O4doeb2UtQ39tw2o/yLGq9tlsh1duabXmH
	 g4ZavTCCcIPFI5NZjjFk99LTeg2SrwLGoLw9XscnvFn1b67ijcUU+jClFMVDhk2oiy
	 eurNZ9xg0vWb8Ej0XgPwSa/DTLSUtdpXExx/f9vobzg2U/BUEU3b/my5fMjKc0gjzY
	 fqTBGdNmeu7KRR/BlttyKtglohpyTaBOfrBjAy0t8moxiq+q7znaHkIMLoXmdr/ZbE
	 iQrPGDyE4/3dw==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] ath11k: allow missing memory-regions
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20240904095815.1572186-2-caleb.connolly@linaro.org>
References: <20240904095815.1572186-2-caleb.connolly@linaro.org>
To: Caleb Connolly <caleb.connolly@linaro.org>
Cc: Jeff Johnson <jjohnson@kernel.org>,
 Caleb Connolly <caleb.connolly@linaro.org>, linux-arm-msm@vger.kernel.org,
 ath11k@lists.infradead.org, linux-wireless@vger.kernel.org
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <172751503199.2249584.16916308008976490497.kvalo@kernel.org>
Date: Sat, 28 Sep 2024 09:17:13 +0000 (UTC)

Caleb Connolly <caleb.connolly@linaro.org> wrote:

> On SC7280 platforms which are running with TrustZone, it is not
> necessary to manually map the memory regions used by the wifi hardware.
> However, ath11k will currently fail to load unless both memory regions
> are specified.
> 
> This breaks wifi on the rb3gen2 which only specifies the firmware memory
> region and does not use the CE region.
> 
> Adjust the order of operations in ath11k_ahb_fw_resources_init() to
> check for the wifi-firmware subnode before attempting to parse the
> memory regions.
> 
> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
> Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>
> Reviewed-by: Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

Patch applied to ath-next branch of ath.git, thanks.

095cb947490c wifi: ath11k: allow missing memory-regions

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20240904095815.1572186-2-caleb.connolly@linaro.org/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
https://docs.kernel.org/process/submitting-patches.html


