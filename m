Return-Path: <linux-wireless+bounces-4630-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F9B18797DF
	for <lists+linux-wireless@lfdr.de>; Tue, 12 Mar 2024 16:44:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF00D286B33
	for <lists+linux-wireless@lfdr.de>; Tue, 12 Mar 2024 15:44:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A53A47C09F;
	Tue, 12 Mar 2024 15:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kHQ3wnPd"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 818FC1E534
	for <linux-wireless@vger.kernel.org>; Tue, 12 Mar 2024 15:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710258257; cv=none; b=CbAlX/oDPO9tA5AV4SAcg0YXVbagjIzWDTvnGnWyg8AM1fd0HAslRiDOmQ7ahFr3DEXE2JwHiW1WfmHF/6a65+uIxrEjIXB/Nj6AlqfvajQz3yvbTVciQEaRfBMrCFSg83EhbXxDjVU/+LTMKKqMreCuCHKq60oNruQLbM0G+Fc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710258257; c=relaxed/simple;
	bh=snpqoaWKx8iTXyE2sCbCJPAM5Y7erY06kxvvCuQSX40=;
	h=Content-Type:MIME-Version:Subject:From:In-Reply-To:References:To:
	 Cc:Message-ID:Date; b=u7tp+oDm1/Q26eK1dSli4BZ9iQ9UdqzW+3E3vDE6M5rihmA6U+1NpPRSjuYGEWg1YKxqiwnJuVkv/jnmGFlyPCYaB9S/Niqq53ZPxsfOPdiV6DpXny3er8KhQF1+mN+fr4noB19shnn9Uwb49CEq1ts8Kgq7swdjubKfYfMNRqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kHQ3wnPd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25F0DC43390;
	Tue, 12 Mar 2024 15:44:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710258257;
	bh=snpqoaWKx8iTXyE2sCbCJPAM5Y7erY06kxvvCuQSX40=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=kHQ3wnPdos0Weuu7tWpl2eoIblEHFdZJbAPZ3lbwAwx5Dk7v2Haq35rKDKwmcYixW
	 CvsltBENLsCxSm6jtePFJk21jxwjcUyZC6rw+8wj+cLyiYVIUze6+SMEY69ONDPzE/
	 +YLGgzptUAyLm8u9fLJk/TAdz13Qsi3HysfQMtPYPZrGfGYRduVV3PASv8HqgE16lm
	 1RwOs1N8rfPdHGnmgP5XGordeXGVUb8gK9QIfDiYzw0W2FmlpYecwYFJPprAisIdM9
	 0hrVtqfG5AbuQWEw3neJAdFX9RGXUGp8byLLZB3VgBrhkyUek9e1cFjbplxTvYohl+
	 O4CNWr/D+bHaQ==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] wifi: ath11k: don't force enable power save on
 non-running
 vdevs
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20240309113115.11498-1-quic_bqiang@quicinc.com>
References: <20240309113115.11498-1-quic_bqiang@quicinc.com>
To: Baochen Qiang <quic_bqiang@quicinc.com>
Cc: <ath11k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
 <quic_bqiang@quicinc.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <171025825444.2014319.13788313325908699695.kvalo@kernel.org>
Date: Tue, 12 Mar 2024 15:44:15 +0000 (UTC)

Baochen Qiang <quic_bqiang@quicinc.com> wrote:

> Currently we force enable power save on non-running vdevs, this results
> in unexpected ping latency in below scenarios:
>         1. disable power save from userspace.
>         2. trigger suspend/resume.
> 
> With step 1 power save is disabled successfully and we get a good latency:
> 
> PING 192.168.1.1 (192.168.1.1) 56(84) bytes of data.
> 64 bytes from 192.168.1.1: icmp_seq=1 ttl=64 time=5.13 ms
> 64 bytes from 192.168.1.1: icmp_seq=2 ttl=64 time=5.45 ms
> 64 bytes from 192.168.1.1: icmp_seq=3 ttl=64 time=5.99 ms
> 64 bytes from 192.168.1.1: icmp_seq=4 ttl=64 time=6.34 ms
> 64 bytes from 192.168.1.1: icmp_seq=5 ttl=64 time=4.47 ms
> 64 bytes from 192.168.1.1: icmp_seq=6 ttl=64 time=6.45 ms
> 
> While after step 2, the latency becomes much larger:
> 
> PING 192.168.1.1 (192.168.1.1) 56(84) bytes of data.
> 64 bytes from 192.168.1.1: icmp_seq=1 ttl=64 time=17.7 ms
> 64 bytes from 192.168.1.1: icmp_seq=2 ttl=64 time=15.0 ms
> 64 bytes from 192.168.1.1: icmp_seq=3 ttl=64 time=14.3 ms
> 64 bytes from 192.168.1.1: icmp_seq=4 ttl=64 time=16.5 ms
> 64 bytes from 192.168.1.1: icmp_seq=5 ttl=64 time=20.1 ms
> 
> The reason is, with step 2, power save is force enabled due to vdev not
> running, although mac80211 was trying to disable it to honor userspace
> configuration:
> 
> ath11k_pci 0000:03:00.0: wmi cmd sta powersave mode psmode 1 vdev id 0
> Call Trace:
>  ath11k_wmi_pdev_set_ps_mode
>  ath11k_mac_op_bss_info_changed
>  ieee80211_bss_info_change_notify
>  ieee80211_reconfig
>  ieee80211_resume
>  wiphy_resume
> 
> This logic is taken from ath10k where it was added due to below comment:
> 
>         Firmware doesn't behave nicely and consumes more power than
>         necessary if PS is disabled on a non-started vdev.
> 
> However we don't know whether such an issue also occurs to ath11k firmware
> or not. But even if it does, it's not appropriate because it goes against
> userspace, even cfg/mac80211 don't know we have enabled it in fact.
> 
> Remove it to fix this issue. In this way we not only get a better latency,
> but also, and the most important, keeps the consistency between userspace
> and kernel/driver. The biggest price for that would be the power consumption,
> which is not that important, compared with the consistency.
> 
> Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILICONZ_LITE-3.6510.30
> 
> Fixes: b2beffa7d9a6 ("ath11k: enable 802.11 power save mode in station mode")
> Signed-off-by: Baochen Qiang <quic_bqiang@quicinc.com>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

Patch applied to ath-next branch of ath.git, thanks.

01296b39d351 wifi: ath11k: don't force enable power save on non-running vdevs

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20240309113115.11498-1-quic_bqiang@quicinc.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


