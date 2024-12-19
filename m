Return-Path: <linux-wireless+bounces-16601-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C8CB9F7AA7
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Dec 2024 12:48:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 781F9170278
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Dec 2024 11:47:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00318222D4A;
	Thu, 19 Dec 2024 11:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ClZirRkG"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D041F223338
	for <linux-wireless@vger.kernel.org>; Thu, 19 Dec 2024 11:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734608775; cv=none; b=aVxgejT/Y9L3ARYAvA7gg9DmiFib4n+nGEoH+5ZWQYTtjfH+63o8xkYN8s0jwc6IswgIcVnFbL4K3fpOQjKIWqzI8emINFPXnW1Bi8RLX/UU17MwDdyPt4pqvcuriCxvZU2SkSuMuZwH4kHrvaIDt7ViYgAmSWS/5dwnBEBSd8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734608775; c=relaxed/simple;
	bh=n3HMUDrXAKQ0ZHThIwTcbqyp/9E14hjGqx7tT5uN5gM=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=LoplHgoj12KGzkD8PvtZ2iZQUXLcSv6n6lmqKxOhO/R7ynvCpSiqrnX8sL6u19MBeRC/bO2t/7FlYBxIzhrtP0FN/rsdLfps1oXTX899VjENlGrOGyIif99t//aePX+54TZIf8xcU020G+PMjfROF2R8aM1w97at+ICLbZ+zm4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ClZirRkG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B70B7C4CECE;
	Thu, 19 Dec 2024 11:46:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734608775;
	bh=n3HMUDrXAKQ0ZHThIwTcbqyp/9E14hjGqx7tT5uN5gM=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=ClZirRkGA6SwR2F2O7PSVZQ+QtQsJNqjQDRrgd/71otCvJpGEsyPTTuUT9VGSeNut
	 aLRs7R3g9PDw82V0ttsT6p3RLBZ6c4GM3NLNctTCYymrvCsjz1izNyuUpFO6qPGY0i
	 30vSgBwvA92LH1Md962Pg94s8iTvvgLMI68CrXj5+wPI+hs5F+uFLh8SAqT9ePZx7A
	 kma8iLNjgf+A03ijKcAqWJHt+k4q3NJTaQA9Pk72lhdI5/kY1PBC7drrZ14YB2DmcV
	 wDI8uY45uEJdzfgq8hL/IBdjQTLv32pF9Rc7kdVI8F6kmdcKYibxZ6uWdVms6JDajo
	 SYtNupId2rm1g==
From: Kalle Valo <kvalo@kernel.org>
To: Roopni Devanathan <quic_rdevanat@quicinc.com>
Cc: <ath12k@lists.infradead.org>,  <linux-wireless@vger.kernel.org>,  Dinesh
 Karthikeyan <quic_dinek@quicinc.com>
Subject: Re: [PATCH 3/6] wifi: ath12k: Support Uplink OFDMA Trigger Stats
References: <20241217095216.1543923-1-quic_rdevanat@quicinc.com>
	<20241217095216.1543923-4-quic_rdevanat@quicinc.com>
Date: Thu, 19 Dec 2024 13:46:12 +0200
In-Reply-To: <20241217095216.1543923-4-quic_rdevanat@quicinc.com> (Roopni
	Devanathan's message of "Tue, 17 Dec 2024 15:22:13 +0530")
Message-ID: <874j2zj3p7.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Roopni Devanathan <quic_rdevanat@quicinc.com> writes:

> From: Dinesh Karthikeyan <quic_dinek@quicinc.com>
>
> Add support to request uplink trigger stats from firmware through
> HTT stats type 26. These stats give information about uplink
> OFDMA bandwidth, received RSSI, power headroom, QoS, data size,
> PPDU info and pass/fail info for each user.
>
> Note: MCC firmware version
> WLAN.HMT.1.0-03427-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1.15378.4
> does not support tags HTT_STATS_RX_PDEV_UL_TRIG_STATS_TAG(94) and
> HTT_STATS_RX_PDEV_UL_OFDMA_USER_STATS_TAG(95), currently.
>
> Sample output:
> -------------
> echo 26 > /sys/kernel/debug/ath12k/pci-0000\:06\:00.0/mac0/htt_stats_type
> cat /sys/kernel/debug/ath12k/pci-0000\:06\:00.0/mac0/htt_stats
> HTT_RX_PDEV_UL_TRIGGER_STATS_TLV:
> mac_id = 0
> rx_11ax_ul_ofdma = 0
> ul_ofdma_rx_mcs =  0:0, 1:0, 2:0, 3:0, 4:0, 5:0, 6:0, 7:0, 8:0, 9:0, 10:0, 11:0
> ul_ofdma_rx_gi[0] =  0:0, 1:0, 2:0, 3:0, 4:0, 5:0, 6:0, 7:0, 8:0, 9:0, 10:0, 11:0
> ul_ofdma_rx_gi[1] =  0:0, 1:0, 2:0, 3:0, 4:0, 5:0, 6:0, 7:0, 8:0, 9:0, 10:0, 11:0
> ul_ofdma_rx_gi[2] =  0:0, 1:0, 2:0, 3:0, 4:0, 5:0, 6:0, 7:0, 8:0, 9:0, 10:0, 11:0
> ul_ofdma_rx_gi[3] =  0:0, 1:0, 2:0, 3:0, 4:0, 5:0, 6:0, 7:0, 8:0, 9:0, 10:0, 11:0
> ul_ofdma_rx_nss =  1:0, 2:0, 3:0, 4:0, 5:0, 6:0, 7:0, 8:0
> ul_ofdma_rx_bw =  0:0, 1:0, 2:0, 3:0
> half_ul_ofdma_rx_bw =  0:0, 1:0, 2:0, 3:0
> quarter_ul_ofdma_rx_bw =  0:0, 1:0, 2:0, 3:0
> .....
>
> HTT_RX_PDEV_UL_OFDMA_USER_STAS_TLV:
> rx_ulofdma_non_data_ppdu_0 = 0
> rx_ulofdma_data_ppdu_0 = 0
> rx_ulofdma_mpdu_ok_0 = 0
> rx_ulofdma_mpdu_fail_0 = 0
> rx_ulofdma_non_data_nusers_0 = 0
> rx_ulofdma_data_nusers_0 = 0
> .....
>
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
>
> Signed-off-by: Dinesh Karthikeyan <quic_dinek@quicinc.com>
> Signed-off-by: Roopni Devanathan <quic_rdevanat@quicinc.com>

Acked-by: Kalle Valo <kvalo@kernel.org>

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

