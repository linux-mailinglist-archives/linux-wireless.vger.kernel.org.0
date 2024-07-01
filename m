Return-Path: <linux-wireless+bounces-9789-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 55D2491E88A
	for <lists+linux-wireless@lfdr.de>; Mon,  1 Jul 2024 21:25:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EF9A61F21A72
	for <lists+linux-wireless@lfdr.de>; Mon,  1 Jul 2024 19:25:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8649B16F0F0;
	Mon,  1 Jul 2024 19:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EDQ7k4fR"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61FF115DBD6
	for <linux-wireless@vger.kernel.org>; Mon,  1 Jul 2024 19:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719861930; cv=none; b=ZudcRv8t3dJmqqoSG7ZvYW29qHPqjknPZsUKeEPDnjjKuxQ8+RfGhZ2pyzomxrR3UZoCi7OYFi8fSZiwWDni0WDt/a2NxTaHjbi1X1jV4CyZ+osq3c3tE0vMPWaJ12LUCTT9+45vaXIW/gxppEiPzPqGVZUbgFmMTyE85yj0Rms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719861930; c=relaxed/simple;
	bh=CuuO2HOqnBwxeM0TOUK/GsPm1OxlPPVBOb/1Q853tGc=;
	h=Content-Type:MIME-Version:Subject:From:In-Reply-To:References:To:
	 Cc:Message-ID:Date; b=VzCZjeSuSwrnzFaswV0VC+0wzaUMNslAr1qvKGDlyKnj/Kmg+da5SOOssok5VltcfwF0wTO6krQfgclZT4oVVC4DFSi/fnL+4r+RX4n3Bvb6Bd6MPzN8hofyYhmQDkj4m5Cp4jjsGljdiZs7RYO7FrEofZ7/TwmKgKw6Rtp7qiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EDQ7k4fR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14A27C116B1;
	Mon,  1 Jul 2024 19:25:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719861930;
	bh=CuuO2HOqnBwxeM0TOUK/GsPm1OxlPPVBOb/1Q853tGc=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=EDQ7k4fRpNib3zFMJIbLH4IfZNvYTiOx6t+Tg/xdsPxCbUOdwJFiIIIJS59WGqwMw
	 b2y59EQC7DpzrdN9zliuKLRtoZt3biuvHR7XGqpeGt59Dz6kddzkH9JpBmZfd2Xgy7
	 eEB/j/1LggdBlCUD3YmiCxNhqOUzw2SLXdoW9Hn+I/3O60dFg3YFVvzwJ1ZpCxmqr0
	 5h3d4va+soCXNMnOcL+DURnAYJLuqSznfRpK2/RbELesq3ApQXDIPCuS3gZxnDpaj5
	 8k2aIMEGnkrRu6ZtlzIudvBIGMMEYTc7DV8aGBOg/wKG6TvZxyYxD6cXvFE+YIyZa+
	 SzYnLOAXV1U3Q==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] wifi: ath12k: Support Transmit DE stats
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20240626042221.3090812-1-quic_rdevanat@quicinc.com>
References: <20240626042221.3090812-1-quic_rdevanat@quicinc.com>
To: Roopni Devanathan <quic_rdevanat@quicinc.com>
Cc: <ath12k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
 Dinesh Karthikeyan
	<quic_dinek@quicinc.com>, Roopni Devanathan <quic_rdevanat@quicinc.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <171986192703.3074425.2338122973158538260.kvalo@kernel.org>
Date: Mon,  1 Jul 2024 19:25:28 +0000 (UTC)

Roopni Devanathan <quic_rdevanat@quicinc.com> wrote:

> From: Dinesh Karthikeyan <quic_dinek@quicinc.com>
> 
> Add support to request transmit DE stats from firmware through HTT stats
> type 8. These stats give information about enqueued packets, discarded
> packets, failed packets and other information such as power, bandwidth
> information, number of retries, etc.
> 
> Sample output:
> -------------
> echo 8 > /sys/kernel/debug/ath12k/pci-0000\:06\:00.0/mac0/htt_stats_type
> cat /sys/kernel/debug/ath12k/pci-0000\:06\:00.0/mac0/htt_stats
> HTT_TX_DE_CMN_STATS_TLV:
> mac_id = 0
> tcl2fw_entry_count = 0
> not_to_fw = 0
> .....
> 
> HTT_TX_DE_EAPOL_PACKETS_STATS_TLV:
> m1_packets = 0
> m2_packets = 0
> m3_packets = 0
> .....
> 
> HTT_TX_DE_CLASSIFY_STATS_TLV:
> arp_packets = 0
> igmp_packets = 0
> dhcp_packets = 0
> .....
> 
> HTT_TX_DE_CLASSIFY_FAILED_STATS_TLV:
> ap_bss_peer_not_found = 0
> ap_bcast_mcast_no_peer = 0
> sta_delete_in_progress = 0
> .....
> 
> HTT_TX_DE_CLASSIFY_STATUS_STATS_TLV:
> eok = 0
> classify_done = 0
> lookup_failed = 0
> .....
> 
> HTT_TX_DE_ENQUEUE_PACKETS_STATS_TLV:
> enqueued_pkts = 0
> to_tqm = 0
> to_tqm_bypass = 0
> 
> HTT_TX_DE_ENQUEUE_DISCARD_STATS_TLV:
> discarded_pkts = 0
> local_frames = 0
> is_ext_msdu = 0
> 
> HTT_TX_DE_COMPL_STATS_TLV:
> tcl_dummy_frame = 0
> tqm_dummy_frame = 0
> tqm_notify_frame = 0
> .....
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0-03427-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1.15378.4
> 
> Signed-off-by: Dinesh Karthikeyan <quic_dinek@quicinc.com>
> Signed-off-by: Roopni Devanathan <quic_rdevanat@quicinc.com>
> Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>

Doesn't apply, please rebase.

error: patch failed: drivers/net/wireless/ath/ath12k/debugfs_htt_stats.c:410
error: drivers/net/wireless/ath/ath12k/debugfs_htt_stats.c: patch does not apply
error: patch failed: drivers/net/wireless/ath/ath12k/debugfs_htt_stats.h:125
error: drivers/net/wireless/ath/ath12k/debugfs_htt_stats.h: patch does not apply
stg import: Diff does not apply cleanly

Patch set to Changes Requested.

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20240626042221.3090812-1-quic_rdevanat@quicinc.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


