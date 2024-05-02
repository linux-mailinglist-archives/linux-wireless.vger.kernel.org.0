Return-Path: <linux-wireless+bounces-7110-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CABBD8B98A2
	for <lists+linux-wireless@lfdr.de>; Thu,  2 May 2024 12:16:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC3AF2837B7
	for <lists+linux-wireless@lfdr.de>; Thu,  2 May 2024 10:16:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDAAC56B8B;
	Thu,  2 May 2024 10:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kHR5z81P"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 958BE56B85
	for <linux-wireless@vger.kernel.org>; Thu,  2 May 2024 10:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714645007; cv=none; b=lzzV4wDC7QTeKKK/rFAI+UHBJ55J2XGDQEdUT6aZSkDYunEiKi5I7kxLnSgrU9VNZgii5X+Kx45mG21XrCDdsgv1D1RwMpY09sLlOXJCy1OyKkMZwYto+cu/6nIz8ekETHuMrBVhiLC18jyg4YHisGMzPaeY7hM3a+TIvOa5YMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714645007; c=relaxed/simple;
	bh=RC+YsNvF5u9BaYOcoKiAusrWX9nqtl9ZOmyWCsuEoj4=;
	h=Content-Type:MIME-Version:Subject:From:In-Reply-To:References:To:
	 Cc:Message-ID:Date; b=gWXZu8DTK7PUCkdZdG4wEiNtU7rGh2RPk/xuUNpM+6Xz/RqVm3p6vDfe8dWpFw+KbXnDWOs1LNvUZLg7ptkvUsJ/GlEo8nJrU3PHe2JH5WhsqXJ66qGs9gNXlsoevtSG98Sn+rmv4Es/C89/qxQcPyZUebfQ6pelr4Iw+IatjuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kHR5z81P; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 165C7C113CC;
	Thu,  2 May 2024 10:16:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714645007;
	bh=RC+YsNvF5u9BaYOcoKiAusrWX9nqtl9ZOmyWCsuEoj4=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=kHR5z81P7ZS/PzfaXM6qZwUMqD7IbD6nBK7h8WN2EHZTglsXeyG/wEo7Q+22V/Lxz
	 bMs68s3kDk/jNVWWVZ7GQOYRTInuKIxSx+AY/qfvparJls4FTZho4I+u80V0ipOWG3
	 xj5nT7nwwUDKCibQos9NXyM+OZRU/GYQusQMEeb6Zws0a+0d5EUqqamwllgD6MJN9O
	 jukiIl7hTKgQJnlFDs8tgCy3fEXgZCF60IfKJvdAC4SYcvn0BaLX0092FO1rE+FCAT
	 7pqhPGRT9fc9POf6FTneRO3BqgE49OEXcYcJG+tBXLmpDNdBw2CTMfX1QF8eJHyu3w
	 y/voEH4VqyJHQ==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] wifi: ath12k: fix the problem that down grade phy mode
 operation
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20240425083837.5340-1-quic_lingbok@quicinc.com>
References: <20240425083837.5340-1-quic_lingbok@quicinc.com>
To: Lingbo Kong <quic_lingbok@quicinc.com>
Cc: <ath12k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
 <quic_lingbok@quicinc.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <171464500387.548512.12268613053950785024.kvalo@kernel.org>
Date: Thu,  2 May 2024 10:16:45 +0000 (UTC)

Lingbo Kong <quic_lingbok@quicinc.com> wrote:

> Currently, when using WCN7850 or QCN9274 as AP, ath12k always performs down
> grade phy mode operation regardless of whether the firmware supports EHT
> capability or not and then vdev will start in HE mode. When stations that
> support EHT capability try to connect to the AP, the AP will set phy mode
> to EHT after receiving the association request packet, and then send
> WMI_PEER_ASSOC_CMDID command to firmware, AP’s firmware will crash.
> 
> This is because when the ath12k_mac_copy_sband_iftype_data() function
> handles EHT capability, it does not copy the EHT capability into the
> iftype[band][type] array according to the interface type. So, interface
> type should not be used as an index to get eht_cap in
> ath12k_mac_check_down_grade_phy_mode() function.
> 
> To address this issue, use types_mask to select the eht_cap in
> ath12k_mac_check_down_grade_phy_mode() function.
> 
> This patch affects QCN9274 and WCN7850 because they have the same issue.
> 
> Hostapd log:
> wlo1: STA 02:03:7f:37:12:34 IEEE 802.11: Could not set STA to kernel driver
> 
> Kernel log:
> [270894.816076] ath12k_pci 0000:03:00.0: failed to send WMI_PEER_SET_PARAM cmd
> [270894.816111] ath12k_pci 0000:03:00.0: failed to setup peer SMPS for vdev 0: -108
> [270894.816122] ath12k_pci 0000:03:00.0: Failed to associate station: 02:03:7f:37:12:34
> [270894.843389] ieee80211 phy5: Hardware restart was requested
> [270894.843517] ath12k_pci 0000:03:00.0: failed to lookup peer 02:03:7f:37:12:34 on vdev 0
> [270894.843616] ath12k_pci 0000:03:00.0: failed to send WMI_PEER_DELETE cmd
> [270894.843650] ath12k_pci 0000:03:00.0: failed to delete peer vdev_id 0 addr 02:03:7f:37:12:34 ret -108
> [270894.843663] ath12k_pci 0000:03:00.0: Failed to delete peer: 02:03:7f:37:12:34 for VDEV: 0
> 
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
> 
> Signed-off-by: Lingbo Kong <quic_lingbok@quicinc.com>
> Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>
> Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

Patch applied to ath-next branch of ath.git, thanks.

bf76b144fe53 wifi: ath12k: fix the problem that down grade phy mode operation

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20240425083837.5340-1-quic_lingbok@quicinc.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


