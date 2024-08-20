Return-Path: <linux-wireless+bounces-11710-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B971958D99
	for <lists+linux-wireless@lfdr.de>; Tue, 20 Aug 2024 19:46:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA39E280D60
	for <lists+linux-wireless@lfdr.de>; Tue, 20 Aug 2024 17:46:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 754984CDEC;
	Tue, 20 Aug 2024 17:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qr6Pm9oB"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FFCD2F5E
	for <linux-wireless@vger.kernel.org>; Tue, 20 Aug 2024 17:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724175962; cv=none; b=tsBHnRMFjpbYrsGeMmtqeUgr4q7d1/U6SSjVEztCzLfNt7wrUsnNYjHmz2Xt3kiVuANk1FsaecLYmZddWnl0P3zV6VptGDS34CD0iYJtIOMakcbXAOnGdpNi0avuB+cQEZJjnfe0vLjhXWsba7KI/Em5kDx5P2PyNJRxFKYRd1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724175962; c=relaxed/simple;
	bh=hU+bLAc95/LPfVm78qGUD1RNuIZJfdCNMrpWlh++Bd4=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=kc6L+RpJMrwJNTsDzllhjrYSTVo0ofGrFpJkKa/WWmSiXmwPnl+8falT54eOLc85WJkuFnMmGA3vfxwt+zM7wf5NCY790ek4bRo8pzOuF9x7+a/gGtuSMSf21jJxcOPQmsOXZqnIESEBo2wYKp3chy1+qn1zB6RsMsiYMQWHP3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qr6Pm9oB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14C39C4AF0B;
	Tue, 20 Aug 2024 17:46:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724175961;
	bh=hU+bLAc95/LPfVm78qGUD1RNuIZJfdCNMrpWlh++Bd4=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=qr6Pm9oBzfw37F2jjD7n6iUIpthVAiDGqyEsbo3SeWxoThoGDXoBwzJSZRUTvtKlY
	 ErRmUdvpigwWtOtu3feZfSUCzWK297bQorSa5/TfgQjEb88Yl1Rqh+XAE3h47SX2dK
	 zdGVX5fRyRo9QE1afen2OGc6LktGYzi0Ak8KSiOkvSABF/qdwbB/CvGTvepgLl5mEi
	 F6IECBgGec4yjUarg1BvkRa1QoTfh0DKp5rtf6g4R75F7ZPGSrg36+jLTYPuLI0goY
	 uynOXIF8SJemPQIc7sNZA4CBpfs11LDgnTo7aSyp1Y13c4T2+DE5s+6etTlDXbYoHp
	 TJgelwFbKaAbw==
From: Kalle Valo <kvalo@kernel.org>
To: Baochen Qiang <quic_bqiang@quicinc.com>
Cc: <ath11k@lists.infradead.org>,  <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH ath-current] wifi: ath11k: fix NULL pointer dereference
 in ath11k_mac_get_eirp_power()
References: <20240813083808.9224-1-quic_bqiang@quicinc.com>
Date: Tue, 20 Aug 2024 20:45:59 +0300
In-Reply-To: <20240813083808.9224-1-quic_bqiang@quicinc.com> (Baochen Qiang's
	message of "Tue, 13 Aug 2024 16:38:08 +0800")
Message-ID: <87jzgbw0iw.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Baochen Qiang <quic_bqiang@quicinc.com> writes:

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
> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=219131
> Signed-off-by: Baochen Qiang <quic_bqiang@quicinc.com>

The reporter confirmed that this fixes the issue and asked to add:

Tested-by: Mikko Tiihonen <mikko.tiihonen@iki.fi>

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

