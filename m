Return-Path: <linux-wireless+bounces-10154-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3175B92D6A7
	for <lists+linux-wireless@lfdr.de>; Wed, 10 Jul 2024 18:38:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A96B5B2C97C
	for <lists+linux-wireless@lfdr.de>; Wed, 10 Jul 2024 16:36:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E4C31990D2;
	Wed, 10 Jul 2024 16:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H/z9ozLa"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AF351990CF
	for <linux-wireless@vger.kernel.org>; Wed, 10 Jul 2024 16:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720629136; cv=none; b=b7IViD56FdJr/TmQtl4aeLbFJSwM/yAvsEddkNowsZW1zSYjIyo0jsdmfm5uHi2hjZww0dx61Suo208vRLZJdiwjQF5mXvuXqddQ4kSJT+XN72DNiLi725X5U1WiLOUKcK0qXsDiinMAgFRwwDeDlmXui0x3nMl66QSQo9OGFSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720629136; c=relaxed/simple;
	bh=hnFP08ghhmLsCPktOQYbAMkrQPAkxrxRGDxqtFHLWac=;
	h=Content-Type:MIME-Version:Subject:From:In-Reply-To:References:To:
	 Cc:Message-ID:Date; b=RXI2bWK7iMsNCJcYMH2bEHxBPWRqqbJZY0cD6NC4eP7RHqAHiRyGIlOqNOeeAv32LOwZIUJmUfsBO4iDCWGvMO21zz40yU2HSU8SdJJ8BukSwhl0DWKzj/0S+9C+Pd1CAG/0NL68y7TFHcG27nx/YAtqhpxom345q+ENrd3dDIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H/z9ozLa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA39AC4AF09;
	Wed, 10 Jul 2024 16:32:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720629135;
	bh=hnFP08ghhmLsCPktOQYbAMkrQPAkxrxRGDxqtFHLWac=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=H/z9ozLaJnE23FtzBCAXlGJ5lif8GD9qsSc3lu+FnjV/xmskjTy+S0xpOH40adZPJ
	 kHonytW6QO0KljhbZequgS3jb3zNszoiSlG8IXcBcUTG6ize6w8ZK3AipWW17IF6qa
	 9UZoVkT2WLW5En2ngA2RFuC6Vy+0J/+Knte7LaZBOJ2Z8AZJNO4u92VXkEyLKL9HoV
	 W1Igv+Yky9awZAMZUIjjDfxRS+yat220cSKMXU294aijVHYAFtA15YwmqMMank9iq1
	 61KI94qNZGvEqrDyMhjK9B10e+t1Xz7ulFW9M1w4V+Y1/KpTBi2ohkYlrG6xN74TDD
	 unXQOERVoCLEg==
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
Message-ID: <172062913268.1204645.7974155470467589425.kvalo@kernel.org>
Date: Wed, 10 Jul 2024 16:32:14 +0000 (UTC)

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

In the future, please include Acked-by from v1 unless there are major changes:

https://patchwork.kernel.org/project/linux-wireless/patch/20240626042221.3090812-1-quic_rdevanat@quicinc.com/

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20240704090535.827680-1-quic_rdevanat@quicinc.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


