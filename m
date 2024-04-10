Return-Path: <linux-wireless+bounces-6117-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 643C089F99C
	for <lists+linux-wireless@lfdr.de>; Wed, 10 Apr 2024 16:13:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 95D081C21E14
	for <lists+linux-wireless@lfdr.de>; Wed, 10 Apr 2024 14:13:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBF1E15EFAD;
	Wed, 10 Apr 2024 14:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VmFto3ze"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6F4115EFA8
	for <linux-wireless@vger.kernel.org>; Wed, 10 Apr 2024 14:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712758364; cv=none; b=dqxiwe/Q+RBxxi56r5vXsSxI66BtHp69Vxzx8ThpOr6r9ldJMb7uMxf0PljbkGHT5WwwCcxqiMWeScxpszYK72uP3zegnh4vrMxhES9KBHU0No8WBNonpe/gUn8Kc+gjPFKJ0YYg8pjQw+KnQD7wVt6YYQkwV9vPDAWb1YENRJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712758364; c=relaxed/simple;
	bh=BXGtyS18Uukci2HwGWwcuVTHGU7yyftxekIlybw6Ye4=;
	h=Content-Type:MIME-Version:Subject:From:In-Reply-To:References:To:
	 Cc:Message-ID:Date; b=VRGtWQuqlwyualoicYIwVq9KsPCl/Vqmd5/dwp3BWXZQB5q/DSJZewlsxfUOFY/q7y62z/GR9LYihZ8nbPMO4SWus3tJyOLvynDIv5BeaWTzRpk0y0P0Ay6X+e8ziOT8wg4gJ6oPA8bMI47Ge8EDGlRMSNUVnAdkPzyrkBPHdCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VmFto3ze; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9BD7C433F1;
	Wed, 10 Apr 2024 14:12:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712758364;
	bh=BXGtyS18Uukci2HwGWwcuVTHGU7yyftxekIlybw6Ye4=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=VmFto3zeOwuxZuydrRcp2fu8oQE+TptliJRsvi5nvtmbUhfLMakxSXSvBVUOoZVy1
	 P8w4VSwJ573NYEcxtC6T4Jt0wjAJuW+B7l2CmxXSvJD7C1iHCMvInUH09RMCkCZADv
	 u05yWuTo/dy+R3CvLbTK2/vvq7L44gSOJHNbX0xOlraR/2ZPiVGncM0mTvrHJC9ieu
	 7syxEK48KnmDRMlPAWTK+feYH5CX/hqYXYpodnUJWDaiBg29fA3InyLmVbTaVF0cOi
	 HQu2x313+PWhSH/UqdUX8olhO865GEL7GnK51hy6jwukUPCCAmJS18tQbddGzDxOqW
	 eeGbnyRIOUyCA==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v7 01/12] wifi: ath12k: add multiple radio support in a
 single
 MAC HW un/register
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20240405194519.1337906-2-quic_ramess@quicinc.com>
References: <20240405194519.1337906-2-quic_ramess@quicinc.com>
To: Rameshkumar Sundaram <quic_ramess@quicinc.com>
Cc: <ath12k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
 Karthikeyan Periyasamy
	<quic_periyasa@quicinc.com>, Sriram R <quic_srirrama@quicinc.com>,
 Rameshkumar Sundaram <quic_ramess@quicinc.com>, Jeff Johnson
	<quic_jjohnson@quicinc.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <171275836091.3687247.13367447879167874394.kvalo@kernel.org>
Date: Wed, 10 Apr 2024 14:12:42 +0000 (UTC)

Rameshkumar Sundaram <quic_ramess@quicinc.com> wrote:

> Currently MAC HW un/register helper function support the single radio.
> To enable single/multi link operation in the future, the following helper
> functions need to be refactored to accommodate multiple radios under a
> single MAC HW un/register:
> 
>         * ath12k_ah_to_ar()
>         * ath12k_mac_hw_allocate()
>         * ath12k_mac_hw_register()
>         * ath12k_mac_hw_unregister()
> 
> This refactoring will make it easier to scale these functionalities and
> support Multi link operation.
> 
>                          Current Multi wiphy Model
> 
>  +---------------+          +---------------+            +---------------+
>  |  Mac80211 hw  |          | Mac80211 hw   |            | Mac80211 hw   |
>  |  private data |          | private data  |            | private data  |
>  |               |          |               |            |               |
>  |ath12k_hw (ah) |          |ath12k_hw (ah) |            |ath12k_hw (ah) |
>  |               |          |               |            |               |
>  | +-----------+ |          | +-----------+ |            | +-----------+ |
>  | | ar (2GHz) | |          | | ar (5GHz) | |            | | ar (6GHz) | |
>  | +-----------+ |          | +-----------+ |            | +-----------+ |
>  |               |          |               |            |               |
>  +---------------+          +---------------+            +---------------+
> 
>                            Single wiphy Model
> 
>                             +--------------+
>                             | Mac80211 hw  |
>                             | private data |
>                             |              |
>                             |ath12k hw (ah)|
>                             | +----------+ |
>                             | |ar (2GHz) | |
>                             | +----------+ |
>                             | |ar (5GHz) | |
>                             | +----------+ |
>                             | |ar (6GHz) | |
>                             | +----------+ |
>                             +--------------+
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
> 
> Signed-off-by: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
> Signed-off-by: Sriram R <quic_srirrama@quicinc.com>
> Signed-off-by: Rameshkumar Sundaram <quic_ramess@quicinc.com>
> Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

12 patches applied to ath-next branch of ath.git, thanks.

ba12f08f3167 wifi: ath12k: add multiple radio support in a single MAC HW un/register
d01c08ed6fdb wifi: ath12k: Modify add and remove chanctx ops for single wiphy support
b8ce837ea264 wifi: ath12k: modify ath12k mac start/stop ops for single wiphy
314876885bdc wifi: ath12k: vdev statemachine changes for single wiphy
0d6e6736ed9f wifi: ath12k: scan statemachine changes for single wiphy
0148e40c9f0a wifi: ath12k: fetch correct radio based on vdev status
b5068bc9180d wifi: ath12k: Cache vdev configs before vdev create
cec77a252407 wifi: ath12k: Add additional checks for vif and sta iterators
0da00e45ee9a wifi: ath12k: modify regulatory support for single wiphy architecture
5a6af83c397d wifi: ath12k: Modify set and get antenna mac ops for single wiphy
d258f16ba10f wifi: ath12k: Modify rts threshold mac op for single wiphy
4f242b1d6996 wifi: ath12k: support get_survey mac op for single wiphy

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20240405194519.1337906-2-quic_ramess@quicinc.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


