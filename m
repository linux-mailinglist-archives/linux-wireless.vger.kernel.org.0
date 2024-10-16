Return-Path: <linux-wireless+bounces-14104-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9031E9A100B
	for <lists+linux-wireless@lfdr.de>; Wed, 16 Oct 2024 18:48:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1421FB24AA2
	for <lists+linux-wireless@lfdr.de>; Wed, 16 Oct 2024 16:48:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50911212627;
	Wed, 16 Oct 2024 16:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="HeR5aJDR"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1C9E210C29;
	Wed, 16 Oct 2024 16:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729097292; cv=none; b=cVDVyUKihyrYqlMH+OTHMHKxqdcI4tUvI+CzB+ofW3p8j2EeoyiRPyCWiDyf+s29lIq6y10H23kAUd4VcXyWOENDU8ConOIzHrWabfnCEnNeV2wNqHeOx49YQ/TEbX7ahQGMlDYGYH/y4keaNINoGB32CLYar2KmzZ3XfgJ8Jj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729097292; c=relaxed/simple;
	bh=tI23MMyrFNzQ4V26C0Kwh6ysWlafowK/i7eD8aubeTc=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=P+pZ5RrQgUz1g6cA2j/b9BX2kMLEwyxQ+6SQoDm41oRLJ1e7zd58052x/MjRMHQOcQAlqfJpcc+wj3BW2qXThKbbdhBWzCTKp+jhaEwmjJWDI33EbbuobjoEEf7oBeupTbORvQtXe5vAeJOHIcUfXPzr+ppoVUYSB4Vu+R+TcvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=HeR5aJDR; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49GGMx8a026674;
	Wed, 16 Oct 2024 16:48:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	lqpxpkLrB7vrGD0DYWcY8NgDVOHTrLYT5IGyhTeKDSY=; b=HeR5aJDRv948XZjw
	ziphsER/eisFrxXclXFohWKUpy9QP/0DAeUSdVE95pf5dRmJbHQYbnefwcxtx5B/
	aa7HqWrNWfFF9RSQaCGHM0pgKkKfTJelHEwzszM1/HrgfYcE8eNzKOQJahzxB/1F
	dIDLarsSFLZ8t9EoN+UF5tbSLvxlJjF1glEs8NFpQM/mU65IA2a+6u2QxloZFMp/
	UPSSt97G5totzdhjo2jvUHkiXtyGukHeV3md173//rv2aLeenvtPp+smrqDiSjQe
	4eYZ+VY4DqddzVQd5u6uJmJ6Jq4XM6aWmU1wvX44rozLrqnZ7KGgDwA2+cjSI6WI
	Oz3tbg==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42a8w6huq2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 16 Oct 2024 16:48:04 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 49GGm3vq020176
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 16 Oct 2024 16:48:03 GMT
Received: from [10.48.241.64] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 16 Oct
 2024 09:48:02 -0700
Message-ID: <7edcf090-ac17-45de-a81e-33a1bb520126@quicinc.com>
Date: Wed, 16 Oct 2024 09:48:02 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] wifi: ath12k: fix warning when unbinding
To: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>, <kvalo@kernel.org>,
        <jjohnson@kernel.org>, <linux-wireless@vger.kernel.org>,
        <ath12k@lists.infradead.org>, <linux-kernel@vger.kernel.org>
CC: <stable@vger.kernel.org>
References: <20241016123722.206899-1-jtornosm@redhat.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
Content-Language: en-US
In-Reply-To: <20241016123722.206899-1-jtornosm@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: cFTx7Chvb69gkUur_L9BPDTnJgWgrMzX
X-Proofpoint-ORIG-GUID: cFTx7Chvb69gkUur_L9BPDTnJgWgrMzX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 adultscore=0
 phishscore=0 lowpriorityscore=0 clxscore=1015 mlxlogscore=999
 malwarescore=0 impostorscore=0 priorityscore=1501 suspectscore=0
 bulkscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410160107

On 10/16/2024 5:37 AM, Jose Ignacio Tornos Martinez wrote:
> If there is an error during some initialization realated to firmware,

previous review comment missed:
s/realated/related/

> the buffers dp->tx_ring[i].tx_status are released.
> However this is released again when the device is unbinded (ath12k_pci),
> and we get:
> [   41.271233] WARNING: CPU: 0 PID: 2098 at mm/slub.c:4689 free_large_kmalloc+0x4d/0x80
> [   41.271246] Modules linked in: uinput snd_seq_dummy snd_hrtimer nft_fib_inet nft_fib_ipv4 nft_fib_ipv6 nft_fib nft_reject_inet nf_reject_ipv4 nf_reject_ipv6 nft_reject nft_ct nft_chain_nat nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 ip_set nf_tables nfnetlink sunrpc qrtr_mhi intel_rapl_msr intel_rapl_common intel_uncore_frequency_common intel_pmc_core intel_vsec pmt_telemetry pmt_class kvm_intel kvm rapl qrtr snd_hda_codec_generic ath12k qmi_helpers snd_hda_intel snd_intel_dspcfg snd_intel_sdw_acpi iTCO_wdt intel_pmc_bxt mac80211 snd_hda_codec iTCO_vendor_support libarc4 snd_hda_core snd_hwdep snd_seq snd_seq_device cfg80211 snd_pcm pcspkr i2c_i801 snd_timer i2c_smbus snd rfkill soundcore lpc_ich mhi virtio_balloon joydev xfs crct10dif_pclmul crc32_pclmul crc32c_intel polyval_clmulni polyval_generic ghash_clmulni_intel sha512_ssse3 sha256_ssse3 sha1_ssse3 virtio_net virtio_blk virtio_console virtio_gpu net_failover failover virtio_dma_buf serio_raw fuse qemu_fw_cfg
> [   41.271284] CPU: 0 UID: 0 PID: 2098 Comm: bash Kdump: loaded Not tainted 6.12.0-rc1+ #29
> [   41.271286] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-2.fc40 04/01/2014
> [   41.271287] RIP: 0010:free_large_kmalloc+0x4d/0x80
> [   41.271289] Code: 00 10 00 00 48 d3 e0 f7 d8 81 e2 c0 00 00 00 75 2f 89 c6 48 89 df e8 82 ff ff ff f0 ff 4b 34 0f 85 59 0e ce 00 e9 5b 0e ce 00 <0f> 0b 80 3d c8 29 3c 02 00 0f 84 2d 0e ce 00 b8 00 f0 ff ff eb d1
> [   41.271290] RSP: 0018:ffffa40881a33c50 EFLAGS: 00010246
> [   41.271292] RAX: 000fffffc0000000 RBX: ffffe697c0278000 RCX: 0000000000000000
> [   41.271293] RDX: ffffe697c0b60008 RSI: ffff8d00c9e00000 RDI: ffffe697c0278000
> [   41.271294] RBP: ffff8d00c3af0000 R08: ffff8d00f215d0c0 R09: 0000000080400038
> [   41.271294] R10: 0000000080400038 R11: 0000000000000000 R12: 0000000000000001
> [   41.271295] R13: ffffffffc0ef8948 R14: ffffffffc0ef8948 R15: ffff8d00c1277560
> [   41.271296] FS:  00007fd31e556740(0000) GS:ffff8d011e400000(0000) knlGS:0000000000000000
> [   41.271297] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [   41.271298] CR2: 00007f778d3ffb38 CR3: 00000000065dc000 CR4: 0000000000752ef0
> [   41.271301] PKRU: 55555554
> [   41.271302] Call Trace:
> [   41.271304]  <TASK>
> [   41.271304]  ? free_large_kmalloc+0x4d/0x80
> [   41.271306]  ? __warn.cold+0x93/0xfa
> [   41.271308]  ? free_large_kmalloc+0x4d/0x80
> [   41.271311]  ? report_bug+0xff/0x140
> [   41.271314]  ? handle_bug+0x58/0x90
> [   41.271316]  ? exc_invalid_op+0x17/0x70
> [   41.271317]  ? asm_exc_invalid_op+0x1a/0x20
> [   41.271321]  ? free_large_kmalloc+0x4d/0x80
> [   41.271323]  ath12k_dp_free+0xdc/0x110 [ath12k]
> [   41.271337]  ath12k_core_deinit+0x8d/0xb0 [ath12k]
> [   41.271345]  ath12k_pci_remove+0x50/0xf0 [ath12k]
> [   41.271354]  pci_device_remove+0x3f/0xb0
> [   41.271356]  device_release_driver_internal+0x19c/0x200
> [   41.271359]  unbind_store+0xa1/0xb0

FYI I didn't comment on this previously but
<https://www.kernel.org/doc/html/latest/process/submitting-patches.html#backtraces-in-commit-messages>
has some guidance on trimming backtraces in commit messages.

> ...
> 
> The issue is always reproducible from a VM because the MSI addressing
> initialization is failing.
> 
> In order to fix the issue, just check if the buffers were already released
> and if they need to be released, in addition set to NULL for the checking.
> 
> cc: stable@vger.kernel.org
> Fixes: d889913205cf ("wifi: ath12k: driver for Qualcomm Wi-Fi 7 devices")
> Signed-off-by: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
> ---
> v2:
>   - Fix the commit size in Fixes
> v1: https://lore.kernel.org/linux-wireless/20241010175102.207324-3-jtornosm@redhat.com/
> 
>  drivers/net/wireless/ath/ath12k/dp.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/wireless/ath/ath12k/dp.c b/drivers/net/wireless/ath/ath12k/dp.c
> index 789d430e4455..9d878d815f3c 100644
> --- a/drivers/net/wireless/ath/ath12k/dp.c
> +++ b/drivers/net/wireless/ath/ath12k/dp.c
> @@ -1277,8 +1277,12 @@ void ath12k_dp_free(struct ath12k_base *ab)
>  
>  	ath12k_dp_rx_reo_cmd_list_cleanup(ab);
>  
> -	for (i = 0; i < ab->hw_params->max_tx_ring; i++)
> -		kfree(dp->tx_ring[i].tx_status);
> +	for (i = 0; i < ab->hw_params->max_tx_ring; i++) {
> +		if (dp->tx_ring[i].tx_status) {

I still don't understand why this check is necessary.

Why isn't just adding the "dp->tx_ring[i].tx_status = NULL" inside the loop
sufficient?

You previously wrote the "warning comes from free_large_kmalloc". Is that
warning due to a NULL pointer, or due to a double free?

I don't see how it could be from a NULL pointer since in kfree() the 1st thing
it does is trace the entry, but then the 2nd thing it does is return "if
(unlikely(ZERO_OR_NULL_PTR(object)))"

So I'm suspecting a double free, and setting dp->tx_ring[i].tx_status = NULL
should fix that issue.

> +			kfree(dp->tx_ring[i].tx_status);
> +			dp->tx_ring[i].tx_status = NULL;
> +		}
> +	}
>  
>  	ath12k_dp_rx_free(ab);
>  	/* Deinit any SOC level resource */


