Return-Path: <linux-wireless+bounces-2441-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4328583A67E
	for <lists+linux-wireless@lfdr.de>; Wed, 24 Jan 2024 11:16:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7C4131C214F7
	for <lists+linux-wireless@lfdr.de>; Wed, 24 Jan 2024 10:16:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A708218AE8;
	Wed, 24 Jan 2024 10:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mn2/xZ51"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83F9718658
	for <linux-wireless@vger.kernel.org>; Wed, 24 Jan 2024 10:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706091413; cv=none; b=QCL72fBC8r24UZXLmETOEBxgU8gwa4TvDoiVJiqxFnXns3/65sj/stDdzlsbusa3pr/Ngm1tJpuMVBl85nZFIJ89xpZwp/FQ3QqGUjQrvlDpvSnZNytpH1MhjyNhVu5EpTGLVmHG8g4lZR69/CfmTng40wjcsuZ3FVpqcvCXCWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706091413; c=relaxed/simple;
	bh=NLdkkXoTiIMolocfXm6PVQHmv3SB01JgzPmD0mLfXN4=;
	h=Content-Type:MIME-Version:Subject:From:In-Reply-To:References:To:
	 Cc:Message-ID:Date; b=QXlKlr8FqDS0SU1C0LXN3TSOrWkSBVGvokN/h5T+MpLLnS7V3gkMt9qUckkckg+I9WrIVKq6aGyfX/FhouI/4rjIqMp8EiB/L3hmO7T2Ee66vsRwlcNK4CT2NWISE+CSnuFlEgI9jvOEj86PtznqB587WBj/GX37tBetoIFNk/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mn2/xZ51; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D405C433F1;
	Wed, 24 Jan 2024 10:16:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706091413;
	bh=NLdkkXoTiIMolocfXm6PVQHmv3SB01JgzPmD0mLfXN4=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=Mn2/xZ51ozbd77hsmxQAinFOoollD7b3iJVKPkEzPvO3/9oHyHJP733Ls/nJoX1pF
	 MtJs2IevlOkOu7ds7GQMSRPjExzrZWjqF12Et+7QP31VUuGcUjzeT1hOLS9VTSuUk3
	 nsQABS6+1RrN+RPIU/ynQ3AdM7kz19D514y4M3fFgm32uy64O3YU3C945EG7KWr78w
	 thhZGqTJp13TojQIVU8ArlIHl94MlCty1/c3YPui95oEB67gNh3fWl/vgknVVeiT4I
	 swV3FZ7B9egnjQB/JoCaolXhvGJExypyLdm5PUzlzbMEZESKXLpSJqi3mIN6uJhi8v
	 dN3MyrCKc1fMw==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] wifi: ath12k: Fix issues in channel list update
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20240117062628.8260-1-quic_srirrama@quicinc.com>
References: <20240117062628.8260-1-quic_srirrama@quicinc.com>
To: Sriram R <quic_srirrama@quicinc.com>
Cc: <ath12k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
 Sriram R <quic_srirrama@quicinc.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <170609140987.4105728.14737574219710540443.kvalo@kernel.org>
Date: Wed, 24 Jan 2024 10:16:51 +0000 (UTC)

Sriram R <quic_srirrama@quicinc.com> wrote:

> Currently, the logic used to select the 6 GHz band is incorrect,
> which may cause 6 GHz supported channels to not be updated properly.
> This is because the 6 GHz Max frequency supported by the driver is
> being compared to the Max frequency supported on the board. If in
> some cases, the 6 GHz Max frequency supported on the board is less
> than the defined 6 GHz Max frequency, all 6 GHz channels are disabled.
> To address this, compare the max frequency supported by the board to
> the defined 6 GHz Minimum frequency by the driver.
> 
> Similarly, when a dual mac card supports both 6 GHz and 5 GHz radios,
> if the 5 GHz radio gets enumerated first before 6 GHz, the checks in
> ath12k_mac_setup_channels_rates() can cause the 5 GHz channels which
> were enabled earlier to get disabled when the 6 GHz channel list is
> updated. This is because the Min 6 GHz frequency defined in the driver
> is 5945 MHz, which should be 5925 MHz since channel 2 is not considered
> currently, but the firmware can pass 5925 MHz as the minimum.
> Hence, update the Min frequency supported by the driver to 5925 MHz.
> 
> In addition, ensure that the channel list update to firmware updates
> only the channels that the current radio (ar) supports rather than
> considering the wiphy support. This would be required when multiple pdevs
> are supported in a wiphy and they support different ranges of frequencies
> or bands as in single wiphy support.
> 
> Fixes: d889913205cf ("wifi: ath12k: driver for Qualcomm Wi-Fi 7 devices")
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.1.1-00188-QCAHKSWPL_SILICONZ-1
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
> 
> Signed-off-by: Sriram R <quic_srirrama@quicinc.com>
> Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

Patch applied to ath-next branch of ath.git, thanks.

67a48d937fac wifi: ath12k: Fix issues in channel list update

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20240117062628.8260-1-quic_srirrama@quicinc.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


