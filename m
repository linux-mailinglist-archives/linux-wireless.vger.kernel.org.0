Return-Path: <linux-wireless+bounces-3141-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB18984A023
	for <lists+linux-wireless@lfdr.de>; Mon,  5 Feb 2024 18:00:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7502E281C09
	for <lists+linux-wireless@lfdr.de>; Mon,  5 Feb 2024 17:00:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79E673CF4B;
	Mon,  5 Feb 2024 17:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DynhfXa3"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56F9E3C46F
	for <linux-wireless@vger.kernel.org>; Mon,  5 Feb 2024 17:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707152427; cv=none; b=V/pFmic8E0RBC8h/a1jArwULsRBHqAAWifhSqCSjgfr3YDU20sSpZsOxxLkV5AU+qaVKWlA2jYvIMslK4vBuMujg9x1CvhMzSQ7mR+Lrdd/hft/J7Am5nn1R3Rbj1MaLLVAPqGZIsvv4Uw2L1UFlJBuMZHfzeILzNdkVGP0VKgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707152427; c=relaxed/simple;
	bh=bxL+BxvlQHAe89NWKzDQGbw1Dc3qITGhBAJv+A1KpVQ=;
	h=Content-Type:MIME-Version:Subject:From:In-Reply-To:References:To:
	 Cc:Message-ID:Date; b=nlE5Lzp3xS6VomSE7m+hdedc/cnTSUBds/Xh+FyyiPSdEBjyU8Lw6IakQz1N6dEbsl/WYe7xQllZKet3s48lnwC3Dzu07eiJcLq4+tMwVSmJlZcmnXT3hwFcpiY6e0ObovPK66xVczVy7xLji3znVsQj811yAIuWo6T1fZuIEuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DynhfXa3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBCC2C433C7;
	Mon,  5 Feb 2024 17:00:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707152426;
	bh=bxL+BxvlQHAe89NWKzDQGbw1Dc3qITGhBAJv+A1KpVQ=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=DynhfXa3itEgXiADpdPXsXsUDAc/xgcQIoLO7tcfu7hIrYlWWiLsN8drA9qvEDdqW
	 9QriOuTuL7XSYytb1Hzinx6MRR/u7S9DeXE+EJsTa9/u1gtj0Kf+hy2cprQVdU8eKK
	 Fm/1bdUp4+bNWCLRTPLJ931CqWVkzr4z1EyQfjHtFtH7CfoUOKlMxhMfIbX37sGJuc
	 rWqJfBnqptbCxkZxWUTK2XkQwesE3UAildRPudh6YOmj4UIIoHDM0RE77y5jP/CThg
	 8gzR2Yahyb8gMrCUeV6rmy0/MxM6hC8Yd0VAwSC1319BB/MkZmPA8Zcfy4tCMSWPU8
	 jtZpmRHS7a1yg==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] wifi: ath11k: initialize rx_mcs_80 and rx_mcs_160 before
 use
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20240202023547.11141-1-quic_bqiang@quicinc.com>
References: <20240202023547.11141-1-quic_bqiang@quicinc.com>
To: Baochen Qiang <quic_bqiang@quicinc.com>
Cc: <ath11k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
 <quic_bqiang@quicinc.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <170715242424.1233901.13688011305726669667.kvalo@kernel.org>
Date: Mon,  5 Feb 2024 17:00:25 +0000 (UTC)

Baochen Qiang <quic_bqiang@quicinc.com> wrote:

> Currently in ath11k_peer_assoc_h_he() rx_mcs_80 and rx_mcs_160
> are used to calculate max_nss, see
>         if (support_160)
>                 max_nss = min(rx_mcs_80, rx_mcs_160);
>         else
>                 max_nss = rx_mcs_80;
> 
> Kernel test robot complains on uninitialized symbols:
> drivers/net/wireless/ath/ath11k/mac.c:2321 ath11k_peer_assoc_h_he() error: uninitialized symbol 'rx_mcs_80'.
> drivers/net/wireless/ath/ath11k/mac.c:2321 ath11k_peer_assoc_h_he() error: uninitialized symbol 'rx_mcs_160'.
> drivers/net/wireless/ath/ath11k/mac.c:2323 ath11k_peer_assoc_h_he() error: uninitialized symbol 'rx_mcs_80'.
> 
> This is because there are some code paths that never set them, so
> the assignment of max_nss can come from uninitialized variables.
> This could result in some unknown issues since a wrong peer_nss
> might be passed to firmware.
> 
> Change to initialize them to an invalid value at the beginning. This
> makes sense because even max_nss gets an invalid value, due to either
> or both of them being invalid, we can get an valid peer_nss with
> following guard:
>         arg->peer_nss = min(sta->deflink.rx_nss, max_nss)
> 
> Tested-on: WCN6855 hw2.1 PCI WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILICONZ_LITE-3.6510.23
> 
> Fixes: 3db26ecf7114 ("ath11k: calculate the correct NSS of peer for HE capabilities")
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202401311243.NyXwWZxP-lkp@intel.com/
> Signed-off-by: Baochen Qiang <quic_bqiang@quicinc.com>
> Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

Patch applied to ath-next branch of ath.git, thanks.

b802e7b7e771 wifi: ath11k: initialize rx_mcs_80 and rx_mcs_160 before use

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20240202023547.11141-1-quic_bqiang@quicinc.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


