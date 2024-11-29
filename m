Return-Path: <linux-wireless+bounces-15801-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 98B3C9DC2AE
	for <lists+linux-wireless@lfdr.de>; Fri, 29 Nov 2024 12:18:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4AFFC16206A
	for <lists+linux-wireless@lfdr.de>; Fri, 29 Nov 2024 11:18:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 273F7199953;
	Fri, 29 Nov 2024 11:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jrkvyFq2"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02FAE199949
	for <linux-wireless@vger.kernel.org>; Fri, 29 Nov 2024 11:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732879095; cv=none; b=qUG1jqN4IoZFYGk3060inupHxftM9mkcIkMeM/xcRd6OOsDFozg6vlslxendJ1A0Xgc1Sp5ujGAnDus3OYciKSjp1SHfrfWyoMMlt6jj27pDuOqJhKdCUt9XjiK5CSgjlJAN62Cfe89X9qXqkHtSiwqRyJBO0s71GNhsJchLfOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732879095; c=relaxed/simple;
	bh=L7FEE3bo3MjpveP8AdFhKLca7ndLKC43nXLD1+RJwD4=;
	h=Content-Type:MIME-Version:Subject:From:In-Reply-To:References:To:
	 Cc:Message-ID:Date; b=JjChpB2Glc8aj9Pdy3KNH60+gCQs68B/4HuWrGbUMsyBcEsbsSr9BLM+w7gnDVns13z/5E9v1/rjD+WqzjcDd17/SxM3GwQieMpZnN4NTCEe5/k8HUbjWXns7yuPnfDjJ++lPElr5FnpI7mTfTT6e3DqQuhvt9OYUVl+0uEdPpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jrkvyFq2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EAB65C4CECF;
	Fri, 29 Nov 2024 11:18:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732879094;
	bh=L7FEE3bo3MjpveP8AdFhKLca7ndLKC43nXLD1+RJwD4=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=jrkvyFq2nquwh/lK6hhi3EsqkffOX2v4iKgUgBkX1CCaj8x0gwKXBIP4sPY+EISXi
	 bClmteav4VEI27chnqLv7OkrHtGlDA2sSNKaOcc6+ofoP1qQnUWlisvTk5to4+GO6o
	 299ElkZvKDkLrQzh1zC5bMnc7l3Ef1kwd1jPV6HRH/Wj+7LMIAOgHxBvweAQShwqMt
	 Yali7TO01xbyX+Glq+wr9buigitpn+ntPgqMyzt7b5cWTDfTWviezwnxMoxAeFfA3y
	 rxSqMZ0B6jfL3M2aThKicRQrxWjr5p0Msb5VHOOeN+/xXI7c977XBS6/2pQZ9/8H1D
	 2q8eqSdFbOSqQ==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 01/10] wifi: ath12k: convert struct
 ath12k::wmi_mgmt_tx_work
 to struct wiphy_work
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20241126171139.2350704-2-kvalo@kernel.org>
References: <20241126171139.2350704-2-kvalo@kernel.org>
To: Kalle Valo <kvalo@kernel.org>
Cc: ath12k@lists.infradead.org, linux-wireless@vger.kernel.org
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <173287909210.2696951.465159497492949082.kvalo@kernel.org>
Date: Fri, 29 Nov 2024 11:18:13 +0000 (UTC)

Kalle Valo <kvalo@kernel.org> wrote:

> To simplify locking for the next patches convert struct
> ath12k::wmi_mgmt_tx_work to use wiphy_work. After this
> ath12k_mgmt_over_wmi_tx_work() is called with wiphy_lock() taken. In
> ath12k_core_suspend() we need to take wiphy_lock() because
> ath12k_mac_wait_tx_complete() requires it.
> 
> Also add lockdep_assert_wiphy() to document when wiphy_lock() is held.
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.3.1-00173-QCAHKSWPL_SILICONZ-1
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
> 
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

10 patches applied to ath-next branch of ath.git, thanks.

56dcbf0b5207 wifi: ath12k: convert struct ath12k::wmi_mgmt_tx_work to struct wiphy_work
648a121bafa3 wifi: ath12k: ath12k_mac_op_tx(): MLO support
2197feb0249d wifi: ath12k: ath12k_mac_op_flush(): MLO support
5419ef950da4 wifi: ath12k: ath12k_mac_op_ampdu_action(): MLO support
85edf16384d1 wifi: ath12k: ath12k_mac_station_add(): fix potential rx_stats leak
90570ba4610b wifi: ath12k: do not return invalid link id for scan link
1833a2ce5d7d wifi: ath12k: ath12k_bss_assoc(): MLO support
aa80f12f3bed wifi: ath12k: defer vdev creation for MLO
ad969bc9ee73 wifi: ath12k: ath12k_mac_op_set_key(): fix uninitialized symbol 'ret'
8c2143702d07 wifi: ath12k: ath12k_mac_op_sta_rc_update(): use mac80211 provided link id

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20241126171139.2350704-2-kvalo@kernel.org/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
https://docs.kernel.org/process/submitting-patches.html


