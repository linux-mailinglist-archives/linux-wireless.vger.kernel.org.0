Return-Path: <linux-wireless+bounces-11798-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 884B395B3A5
	for <lists+linux-wireless@lfdr.de>; Thu, 22 Aug 2024 13:17:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3EC641F214C6
	for <lists+linux-wireless@lfdr.de>; Thu, 22 Aug 2024 11:17:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BE491C173F;
	Thu, 22 Aug 2024 11:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="THJbabcw"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 085D11C1730
	for <linux-wireless@vger.kernel.org>; Thu, 22 Aug 2024 11:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724325437; cv=none; b=tPZf2+G8BuZ53fdOP9mx/1Fu1MS68ibYowy6lRMrYJc8mZS8aC/KY3ufAdP+9lovqy4DR7jgJvfSOZXWG4A5D3V1KI+nl/ZkvorjijDfANNqMEZshAfdBChxN2k1IHYxOCOnWIxQUzDJvNooR/nyt8EZeg43BY5jQ5moS+arqEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724325437; c=relaxed/simple;
	bh=q6nA+xULn1IKnQ25AEemK++PTuEK3oiJ89ePjZL2ASY=;
	h=Content-Type:MIME-Version:Subject:From:In-Reply-To:References:To:
	 Cc:Message-ID:Date; b=TqS1kFdrzY/naD89ksd6YicOnkVBqD/Nv85xaNTEIRyJhWgHCh+HQ8lLvOfMtLBqDaIwMW1bBK6oY7y2G45J4Ux0hH3vIVK6hhIk9DJtRgCPmbFngBPLyK/mXOWlI1yRwRk1NFlLYPcaAT+zWpurrY+cI9c5PGTyAMUMX08Udhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=THJbabcw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C4B9C32782;
	Thu, 22 Aug 2024 11:17:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724325436;
	bh=q6nA+xULn1IKnQ25AEemK++PTuEK3oiJ89ePjZL2ASY=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=THJbabcw7PmRrS6KFY8aT4EY4FpcJukzShgbi2Q5qMHZg592AblJqaLRgb17hIodQ
	 5IhJwsLToIXs6nKLmL478qiP32fQe3nzLqrQ7FL4LC5KPWtnXhC0EpKQa2XOrGV/UX
	 5FZZ4M5ci/SfvkjoV8uRyrMYFtpK6sL02jgVsatgQRucZPdQorTCEv5uJoopqF5fFT
	 glo2mitgtGO8KJ6ieQZ34JfMpmCiY+BAEHQppFN7CP44aVzNSMbsr9ycQ79K+zXhEv
	 S5wU+Cjx3j7phQnJ9pkg9uqgFS/+cg27S9d1ZTuPxu3VigD6jHURa/FcL7zPQR/ABk
	 piEnIznB8pqXA==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH ath-current] wifi: ath11k: fix NULL pointer dereference in
 ath11k_mac_get_eirp_power()
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20240813083808.9224-1-quic_bqiang@quicinc.com>
References: <20240813083808.9224-1-quic_bqiang@quicinc.com>
To: Baochen Qiang <quic_bqiang@quicinc.com>
Cc: <ath11k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
 <quic_bqiang@quicinc.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <172432543412.2365229.4521966986927365757.kvalo@kernel.org>
Date: Thu, 22 Aug 2024 11:17:15 +0000 (UTC)

Baochen Qiang <quic_bqiang@quicinc.com> wrote:

> Commit 39dc8b8ea387 ("wifi: mac80211: pass parsed TPE data to drivers") breaks
> ath11k, leading to kernel crash:
> 
> BUG: kernel NULL pointer dereference, address: 0000000000000018
> RIP: 0010:ath11k_mac_get_eirp_power.isra.0+0x5b/0x80 [ath11k]
> Call Trace:
>  <TASK>
>  ath11k_mac_fill_reg_tpc_info+0x3d6/0x800 [ath11k]
>  ath11k_mac_vdev_start_restart+0x412/0x4d0 [ath11k]
>  ath11k_mac_op_sta_state+0x7bc/0xbb0 [ath11k]
>  drv_sta_state+0xf1/0x5f0 [mac80211]
>  sta_info_insert_rcu+0x28d/0x530 [mac80211]
>  sta_info_insert+0xf/0x20 [mac80211]
>  ieee80211_prep_connection+0x3b4/0x4c0 [mac80211]
>  ieee80211_mgd_auth+0x363/0x600 [mac80211]
> 
> The issue scenario is, AP advertises power spectral density (PSD) values in its
> transmit power envelope (TPE) IE and supports 160 MHz bandwidth in 6 GHz. When
> connecting to this AP, in ath11k_mac_parse_tx_pwr_env(), the local variable
> psd is true and then reg_tpc_info.num_pwr_levels is set to 8 due to 160 MHz
> bandwidth. Note here ath11k fails to set reg_tpc_info.is_psd_power as TRUE due
> to above commit. Then in ath11k_mac_fill_reg_tpc_info(), for each of the 8
> power levels, for a PSD channel, ath11k_mac_get_psd_channel() is expected to
> be called to get required information. However due to invalid
> reg_tpc_info.is_psd_power, it is ath11k_mac_get_eirp_power() that gets called
> and passed with pwr_lvl_idx as one of the arguments. Note this function
> implicitly requires pwr_lvl_idx to be no more than 3. So when pwr_lvl_idx is
> larger than that ath11k_mac_get_seg_freq() returns invalid center frequency,
> with which as the input ieee80211_get_channel() returns NULL, then kernel
> crashes due to NULL pointer dereference.
> 
> Fix it by setting reg_tpc_info.is_psd_power properly.
> 
> Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILICONZ_LITE-3.6510.30
> 
> Fixes: 39dc8b8ea387 ("wifi: mac80211: pass parsed TPE data to drivers")
> Reported-by: Mikko Tiihonen <mikko.tiihonen@iki.fi>
> Tested-by: Mikko Tiihonen <mikko.tiihonen@iki.fi>
> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=219131
> Signed-off-by: Baochen Qiang <quic_bqiang@quicinc.com>
> Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

Patch applied to ath-current branch of ath.git, thanks.

9abf199943a6 wifi: ath11k: fix NULL pointer dereference in ath11k_mac_get_eirp_power()

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20240813083808.9224-1-quic_bqiang@quicinc.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
https://docs.kernel.org/process/submitting-patches.html


