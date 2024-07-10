Return-Path: <linux-wireless+bounces-10153-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1557592D690
	for <lists+linux-wireless@lfdr.de>; Wed, 10 Jul 2024 18:34:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4608C1C20DF0
	for <lists+linux-wireless@lfdr.de>; Wed, 10 Jul 2024 16:34:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D2EA197A88;
	Wed, 10 Jul 2024 16:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fzF+BBSU"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2861F194AF8
	for <linux-wireless@vger.kernel.org>; Wed, 10 Jul 2024 16:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720629050; cv=none; b=bpSKpiO/DNM1fQKTWgpIOywpFg7BSaynDkOLCGe+IVm3GxJm7+RVu7HjYRbAV7Ctzl797k5AlyHj56M2DMMDCv7aUBC33Os0rJ+2FgDKuDiApfd3y7FV05Y3xwzipjwY775Vf4cawySOKyMifFx8UwrM0KPwQaWO0NgVn6PSDGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720629050; c=relaxed/simple;
	bh=RIfeF0gvxy9BzoF97850w13AzsyU+nnXz4c10sLPe5Y=;
	h=Content-Type:MIME-Version:Subject:From:In-Reply-To:References:To:
	 Cc:Message-ID:Date; b=J2odE+T125QclLDyawHYjwzQ3CKdAjVBVZ5AjvrUR8ahCF75/7fG14SJBO1cLnn3isZ4QMuQ08PQx0mBo78xf30+FKj4ejDrQkHCR7bPTy1erY57vK1cwi46yibdCchj1y9sF0RRmQG6nH+BVP1S9YkfRem0c8mBZHea+LvtWi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fzF+BBSU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E59FC4AF07;
	Wed, 10 Jul 2024 16:30:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720629049;
	bh=RIfeF0gvxy9BzoF97850w13AzsyU+nnXz4c10sLPe5Y=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=fzF+BBSUcBn+0kvjD1qkyvPvaN5956DMgQi8GzZ7WJmvdUQ8LoKbnuHJmOubH6Vqu
	 Qn+eUXdLfUOvqvUo8n79mGPqtPrKuuKDHyQndZDKtPJ9q/rbO3989Moxwje2uNSiI6
	 M4ky5bevxRBIazm4jqcgJaU7SYo8n7tBtSNepR9vbgf9VSHCSfQxnu9KJOboZgu+Ch
	 y8zlsasypgHrdppgtxTlKhaK/rF6FhxbHrZLsNk+oxVKeMCA0q9riZmRDe5E9oQvvM
	 Nw6Xldf3rdomHaocSghetU/Nr73k8NgRzLZtsZbvNZcfYRkYoeFiOjN9xNOGipPktS
	 k0WekHkoBr9vw==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2] wifi: ath12k: Support Transmit DE stats
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20240704090535.827680-1-quic_rdevanat@quicinc.com>
References: <20240704090535.827680-1-quic_rdevanat@quicinc.com>
To: Roopni Devanathan <quic_rdevanat@quicinc.com>
Cc: <ath12k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
 Dinesh Karthikeyan
	<quic_dinek@quicinc.com>, Roopni Devanathan <quic_rdevanat@quicinc.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <172062904694.1204645.4938880576628428164.kvalo@kernel.org>
Date: Wed, 10 Jul 2024 16:30:48 +0000 (UTC)

Roopni Devanathan <quic_rdevanat@quicinc.com> wrote:

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
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

Patch applied to ath-next branch of ath.git, thanks.

04aee7a84779 wifi: ath12k: Support Transmit DE stats

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20240704090535.827680-1-quic_rdevanat@quicinc.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


