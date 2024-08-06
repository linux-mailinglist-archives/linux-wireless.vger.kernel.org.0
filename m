Return-Path: <linux-wireless+bounces-11000-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 737CC948A8E
	for <lists+linux-wireless@lfdr.de>; Tue,  6 Aug 2024 09:50:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 29CBE1F21638
	for <lists+linux-wireless@lfdr.de>; Tue,  6 Aug 2024 07:50:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06B7C16A92D;
	Tue,  6 Aug 2024 07:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UIc1fxWY"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4AC216A38B
	for <linux-wireless@vger.kernel.org>; Tue,  6 Aug 2024 07:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722930483; cv=none; b=nWnndRq8TCcENp1vZjso/ky0T45L/GKHFVs5uWmmeqn05cIcrRDmt21PCaPPpSQxZRC3oWTHkM1JNj7l6rWEteRJ66y0UpOJspAjPjW25h9BNVYKH5NOFKa/MOxDG6gYsdn2aihoLCouEwQ43hglH1GH/Xri1jG/pjdMQft53H8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722930483; c=relaxed/simple;
	bh=1wCvb7Ty0PMbbRUTsNPREmzlyJkTiNLHPiiOiYmJ0e4=;
	h=Content-Type:MIME-Version:Subject:From:In-Reply-To:References:To:
	 Cc:Message-ID:Date; b=ojRT7A1dBYpxpPkVn6d9Y0cG6KninF+x0O5AINlvpuJi9P/rpOm7/iVzX9NVhWyBaDKt+y4luEgP7WEBvOPCvzrUk0wQUog5bIvZ9xyvOM/EmeSlQe3pczjRPMpCr1mwTpDiBVCuSJw98iUV7VawIIOdaQaNyVdVb6paGg2DNrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UIc1fxWY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E777C32786;
	Tue,  6 Aug 2024 07:48:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722930483;
	bh=1wCvb7Ty0PMbbRUTsNPREmzlyJkTiNLHPiiOiYmJ0e4=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=UIc1fxWYeE3WRm1AuMFVKhGwfZJRBMbdVClAlpyORtAvjQDGjoi8Kv4feoXH/sEx2
	 xTA+JaImWXem+BtgocM5gNwNOWc7dn5WLMv2GN3HltoE/OkU9E4pXEb8DCGoZd/G9L
	 O3J1KEdw8CnOjs4XtP52PvI4U/etl87NF/BeDIE5cwGchU23He0j3yROk1PTsFjlxx
	 7OgxQfCMvFPMLfTuvMfIi5zKwY+evEYpM+/jG+/77fJ/G37KJ/PZko8lqYXh1W4cEX
	 AkZd81zyyHcN3/+lInBkkmKM+zzZ3ycF3LOQp+McaAV44aXnrMXKr4WMe/nti4cEg6
	 +4/2d0O1diWTg==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] wifi: ath11k: support HTT extended receive rate debug
 stats
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20230613071212.22180-1-quic_karm@quicinc.com>
References: <20230613071212.22180-1-quic_karm@quicinc.com>
To: Karthik M <quic_karm@quicinc.com>
Cc: <ath11k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
 Karthik M <quic_karm@quicinc.com>,
 Sathishkumar Muruganandam <quic_murugana@quicinc.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <172293048067.3540390.7860114421698371244.kvalo@kernel.org>
Date: Tue,  6 Aug 2024 07:48:02 +0000 (UTC)

Karthik M <quic_karm@quicinc.com> wrote:

> ATH11K_DBG_HTT_EXT_STATS_PDEV_RX_RATE_EXT  =  30
> 
> HTT stats, HTT_RX_PDEV_RATE_EXT_STATS has the rx stats info of
> the extended 80MHz, mainly 80+80 and 160MHz modes.
> 
> Usage:
> echo 30 > /sys/kernel/debug/ieee80211/phyx/ath11k/htt_stats_type
> cat /sys/kernel/debug/ieee80211/phyx/ath11k/htt_stats
> 
> HTT_RX_PDEV_RATE_EXT_STATS_TLV:
> rssi_mcast = -70
> rssi_mgmt = 6
> rssi_chain_ext[0] =  0:128, 1:128, 2:128, 3:128,
> rssi_chain_ext[1] =  0:128, 1:128, 2:128, 3:128,
> rssi_chain_ext[2] =  0:128, 1:128, 2:128, 3:128,
> rssi_chain_ext[3] =  0:128, 1:128, 2:128, 3:128,
> rssi_chain_ext[4] =  0:128, 1:128, 2:128, 3:128,
> rssi_chain_ext[5] =  0:128, 1:128, 2:128, 3:128,
> rssi_chain_ext[6] =  0:128, 1:128, 2:128, 3:128,
> rssi_chain_ext[7] =  0:128, 1:128, 2:128, 3:128,
> 
> rx_per_chain_rssi_ext_in_dbm[0] =  0:0, 1:0, 2:0, 3:0,
> rx_per_chain_rssi_ext_in_dbm[1] =  0:0, 1:0, 2:0, 3:0,
> rx_per_chain_rssi_ext_in_dbm[2] =  0:0, 1:0, 2:0, 3:0,
> rx_per_chain_rssi_ext_in_dbm[3] =  0:0, 1:0, 2:0, 3:0,
> rx_per_chain_rssi_ext_in_dbm[4] =  0:-128, 1:-128, 2:-128, 3:-128,
> rx_per_chain_rssi_ext_in_dbm[5] =  0:-128, 1:-128, 2:-128, 3:-128,
> rx_per_chain_rssi_ext_in_dbm[6] =  0:-128, 1:-128, 2:-128, 3:-128,
> rx_per_chain_rssi_ext_in_dbm[7] =  0:-128, 1:-128, 2:-128, 3:-128,
> rx_mcs_ext =  0:0, 1:0, 2:0, 3:0, 4:0, 5:0, 6:0, 7:0, 8:0, 9:0, 10:0, 11:0, 12:0, 13:0,
> rx_stbc_ext =  0:0, 1:0, 2:0, 3:0, 4:0, 5:0, 6:0, 7:0, 8:0, 9:0, 10:0, 11:0, 12:0, 13:0,
> rx_gi_ext[0] =  0:0, 1:0, 2:0, 3:0, 4:0, 5:0, 6:0, 7:0, 8:0, 9:0, 10:0, 11:0, 12:0, 13:0,
> rx_gi_ext[1] =  0:0, 1:0, 2:0, 3:0, 4:0, 5:0, 6:0, 7:0, 8:0, 9:0, 10:0, 11:0, 12:0, 13:0,
> rx_gi_ext[2] =  0:0, 1:0, 2:0, 3:0, 4:0, 5:0, 6:0, 7:0, 8:0, 9:0, 10:0, 11:0, 12:0, 13:0,
> rx_gi_ext[3] =  0:0, 1:0, 2:0, 3:0, 4:0, 5:0, 6:0, 7:0, 8:0, 9:0, 10:0, 11:0, 12:0, 13:0,
> ul_ofdma_rx_mcs_ext =  0:0, 1:0, 2:0, 3:0, 4:0, 5:0, 6:0, 7:0, 8:0, 9:0, 10:0, 11:0, 12:0, 13:0,
> ul_ofdma_rx_gi_ext[0] =  0:0, 1:0, 2:0, 3:0, 4:0, 5:0, 6:0, 7:0, 8:0, 9:0, 10:0, 11:0, 12:0, 13:0,
> ul_ofdma_rx_gi_ext[1] =  0:0, 1:0, 2:0, 3:0, 4:0, 5:0, 6:0, 7:0, 8:0, 9:0, 10:0, 11:0, 12:0, 13:0,
> ul_ofdma_rx_gi_ext[2] =  0:0, 1:0, 2:0, 3:0, 4:0, 5:0, 6:0, 7:0, 8:0, 9:0, 10:0, 11:0, 12:0, 13:0,
> ul_ofdma_rx_gi_ext[3] =  0:0, 1:0, 2:0, 3:0, 4:0, 5:0, 6:0, 7:0, 8:0, 9:0, 10:0, 11:0, 12:0, 13:0,
> rx_11ax_su_txbf_mcs_ext =  0:0, 1:0, 2:0, 3:0, 4:0, 5:0, 6:0, 7:0, 8:0, 9:0, 10:0, 11:0, 12:0, 13:0,
> rx_11ax_mu_txbf_mcs_ext =  0:0, 1:0, 2:0, 3:0, 4:0, 5:0, 6:0, 7:0, 8:0, 9:0, 10:0, 11:0, 12:0, 13:0,
> rx_11ax_dl_ofdma_mcs_ext =  0:0, 1:0, 2:0, 3:0, 4:0, 5:0, 6:0, 7:0, 8:0, 9:0, 10:0, 11:0, 12:0, 13:0,
> 
> Tested-on: IPQ8074 hw2.0 AHB WLAN.HK.2.9.0.1-01184-QCAHKSWPL_SILICONZ-1
> 
> Signed-off-by: Sathishkumar Muruganandam <quic_murugana@quicinc.com>
> Signed-off-by: Karthik M <quic_karm@quicinc.com>

Dropping this, please rebase if still needed.

Patch set to Changes Requested.

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20230613071212.22180-1-quic_karm@quicinc.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


