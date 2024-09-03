Return-Path: <linux-wireless+bounces-12398-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F279296A4E1
	for <lists+linux-wireless@lfdr.de>; Tue,  3 Sep 2024 18:55:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 309C91C23AD3
	for <lists+linux-wireless@lfdr.de>; Tue,  3 Sep 2024 16:55:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4518518BBBD;
	Tue,  3 Sep 2024 16:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f4fp8a5D"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2173A189BBF
	for <linux-wireless@vger.kernel.org>; Tue,  3 Sep 2024 16:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725382499; cv=none; b=AuHT6YIjMETwNLisuaI9x/CiLh15K065wcRjVIOmFGnYybP77XdOBoXMkHRNvf02L8N8XSLb1RsA6hv7xZDbJpAF2mKlTf0uaN8dXKX5ULVTySrHvfnu+qXzIzNqXWg6oBtP90T++g9ZEzcRO8LR++WI9u2mcNiAmBBtF0VGfkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725382499; c=relaxed/simple;
	bh=7x+YrA8eBSCwHO38MdsmJ0ad5kmlhnw1+vLAFBPFl4o=;
	h=Content-Type:MIME-Version:Subject:From:In-Reply-To:References:To:
	 Cc:Message-ID:Date; b=AOdmhv70+XWhUN4B616TZ/m6B11CjTM3lXwWeZCW0x/1EG2ti5NyJ0zlhoBPj9uZ6VLpDCisHPfwY1V2T4dSov25xcugjzY5Fou3SbzDE47eWwtM+pPB+8ZK4MGCOhZzexN6Ucrphltv8DPXFB6YzpDawpHLuLW5epcLlMXomtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f4fp8a5D; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30150C4CEC4;
	Tue,  3 Sep 2024 16:54:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725382498;
	bh=7x+YrA8eBSCwHO38MdsmJ0ad5kmlhnw1+vLAFBPFl4o=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=f4fp8a5DSCUzZA6OLozVL5Vq0o0ttbuBEuruPREnT2ln3KFQazSb2Rk68yXYrTSzP
	 Hj5svlhqs3Pz8rcMcXYJQRFx8jW8p/pnyzsA2XRYcCS1l4IJZPk14+Bc6Q2ja9YWAR
	 7LB1S5pqHATXbW2lM8V4YZPfOqfwTkpmqHXocoSfHH141WCgBAweO/EPyQZwcSoISC
	 b5IkyemjLZFWep88hG+bJuYXxUj43N0HeSkhIytvnOGYIM6db2E3ja7ioHWCmWPNEg
	 RKrFecCz/K5ciqEjsj9bGJ5bWgbmaHRn8aVJJ6mgccHZWKPj5Qpu3rwDNGxDhZLPzB
	 AbkfVjmC9ARUw==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: pull-request: ath-current-20240903
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: <8a9375eb-3205-4a78-a8c1-bd85df106ec9@quicinc.com>
References: <8a9375eb-3205-4a78-a8c1-bd85df106ec9@quicinc.com>
To: Jeff Johnson <quic_jjohnson@quicinc.com>
Cc: <linux-wireless@vger.kernel.org>, <ath10k@lists.infradead.org>,
 <ath11k@lists.infradead.org>, <ath12k@lists.infradead.org>,
 <quic_jjohnson@quicinc.com>, <quic_kvalo@quicinc.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <172538249548.948898.11503528023921018995.kvalo@kernel.org>
Date: Tue,  3 Sep 2024 16:54:56 +0000 (UTC)

Jeff Johnson <quic_jjohnson@quicinc.com> wrote:

> The following changes since commit 38055789d15155109b41602ad719d770af507030:
> 
>   wifi: ath12k: use 128 bytes aligned iova in transmit path for WCN7850 (2024-08-05 12:28:07 +0300)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/ath/ath.git tags/ath-current-20240903
> 
> for you to fetch changes up to 2f833e8948d6c88a3a257d4e426c9897b4907d5a:
> 
>   Revert "wifi: ath11k: support hibernation" (2024-09-02 19:33:00 +0300)
> 
> ----------------------------------------------------------------
> ath.git patches for v6.11-rc7
> 
> We have three patch which address two issues in the ath11k driver
> which should be addressed for 6.11-rc7:
> 
> One patch fixes a NULL pointer dereference while parsing transmit
> power envelope (TPE) information, and the other two patches revert the
> hibernation support since it is interfering with suspend on some
> platforms. Note the cause of the suspend wakeups is still being
> investigated, and it is hoped this can be addressed and hibernation
> support can be restored in the near future.
> 
> ----------------------------------------------------------------
> Baochen Qiang (3):
>       wifi: ath11k: fix NULL pointer dereference in ath11k_mac_get_eirp_power()
>       Revert "wifi: ath11k: restore country code during resume"
>       Revert "wifi: ath11k: support hibernation"
> 
>  drivers/net/wireless/ath/ath11k/ahb.c  |   4 +-
>  drivers/net/wireless/ath/ath11k/core.c | 115 +++++++++------------------------
>  drivers/net/wireless/ath/ath11k/core.h |   4 --
>  drivers/net/wireless/ath/ath11k/hif.h  |  12 +---
>  drivers/net/wireless/ath/ath11k/mac.c  |   1 +
>  drivers/net/wireless/ath/ath11k/mhi.c  |  12 +---
>  drivers/net/wireless/ath/ath11k/mhi.h  |   3 +-
>  drivers/net/wireless/ath/ath11k/pci.c  |  44 ++-----------
>  drivers/net/wireless/ath/ath11k/qmi.c  |   2 +-
>  9 files changed, 49 insertions(+), 148 deletions(-)

Pulled, thanks.

e88b9ed3e03a Merge tag 'ath-current-20240903' of git://git.kernel.org/pub/scm/linux/kernel/git/ath/ath

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/8a9375eb-3205-4a78-a8c1-bd85df106ec9@quicinc.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
https://docs.kernel.org/process/submitting-patches.html


