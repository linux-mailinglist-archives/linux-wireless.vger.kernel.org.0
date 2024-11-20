Return-Path: <linux-wireless+bounces-15536-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 934719D429C
	for <lists+linux-wireless@lfdr.de>; Wed, 20 Nov 2024 20:39:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 67BFA1F2151D
	for <lists+linux-wireless@lfdr.de>; Wed, 20 Nov 2024 19:39:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC7EA1A9B45;
	Wed, 20 Nov 2024 19:39:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Whk6ClMG"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A89C7155352
	for <linux-wireless@vger.kernel.org>; Wed, 20 Nov 2024 19:39:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732131540; cv=none; b=Y63oQvLC3CYZQEkpApTckO4hz+8/1XYfFnXi0eE7IW8Ta+kFBiaJnhxkxJmicn6CslubdvO1tTLquPRF+ltol/I08QgAbsbSk4wsfcpFRktJxsWlPhC46nGQWbpWvOkp8KEp+0O71VOOi1JxpZskEockLG1wuf+/cOION5OYDPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732131540; c=relaxed/simple;
	bh=Yi3WJy6m5CwXAjlwhr4BdhlMShZCbdJseWCmo3EP5W8=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=SuwEQwGQzYtvbcjJ8uDbP6lbscIHD/OGLmZpuP/tqpSz+vSj0j71uZLu+xjLND8xHe79/oMy8k5bUToGcyBYN+9fb4IuaE7SYngpHj14y106N6alz2QopOwhJYU1H9ReG3Fe31QsPTwPDwZE/uNMireo3pCkrcCoKkhuO4Gm7eQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Whk6ClMG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03D39C4CECD;
	Wed, 20 Nov 2024 19:38:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732131540;
	bh=Yi3WJy6m5CwXAjlwhr4BdhlMShZCbdJseWCmo3EP5W8=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=Whk6ClMGEjtJL7VGPsmtVupTwozwKyMyS0W6cdkFiuX+mgZ4VPqL70fM7DFszf+au
	 9K5XWkSyZSljsLBcIsS6xVbSwMTXhXlx/KH6lyi4VIbWhto6Am5hF7Kq/aqPMNFi86
	 U1h1oaz6oCK5u+AiYb/VEgmYaPHRzFCzFAkfAJvpXsouvfHDoRWNPpFaWbD/LP2dXo
	 IQL8LBJ/83SdGwGTnY7v1WehlRK8dhCXpKKYIelQPmq9McmpI4McoNJ8IXVKQHXBL1
	 0p0VEYjidSWghRi2GGNHswekrrFueXpF8vk4kyWTrRz/eO0pRz14Bmst9feWLdW3Hv
	 DPD/9gPpnYt6g==
From: Kalle Valo <kvalo@kernel.org>
To: Jeff Johnson <quic_jjohnson@quicinc.com>
Cc: Roopni Devanathan <quic_rdevanat@quicinc.com>,
  <ath12k@lists.infradead.org>,  <linux-wireless@vger.kernel.org>,  Dinesh
 Karthikeyan <quic_dinek@quicinc.com>
Subject: Re: [PATCH v6 2/4] wifi: ath12k: Support phy counter and TPC stats
References: <20241115062854.1919672-1-quic_rdevanat@quicinc.com>
	<20241115062854.1919672-3-quic_rdevanat@quicinc.com>
	<13d6d7a6-5073-4dc0-b229-c9b4365756d1@quicinc.com>
Date: Wed, 20 Nov 2024 21:38:56 +0200
In-Reply-To: <13d6d7a6-5073-4dc0-b229-c9b4365756d1@quicinc.com> (Jeff
	Johnson's message of "Fri, 15 Nov 2024 13:16:26 -0800")
Message-ID: <877c8xzodr.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff Johnson <quic_jjohnson@quicinc.com> writes:

> On 11/14/2024 10:28 PM, Roopni Devanathan wrote:
>
>> From: Dinesh Karthikeyan <quic_dinek@quicinc.com>
>> 
>> Add support to request counters and Transmission Power Control
>> (TPC) stats through HTT stats type 37. These stats give
>> information about counters like received packet count, CRC pass
>> count, error count, transmit abort count, etc., about counter reset
>> like reset cause, channel frequency, number and mode, channel flags,
>> etc., about TPC like transmit power scale, maximum transmit power,
>> gain cap, EIRP, etc.
>> 
>> Note: MCC firmware version -
>> WLAN.HMT.1.0-03427-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1.15378.4 does not
>> support HTT stats type 37, i.e., the firmware does not respond to the
>> command requesting stats.
>> 
>> Sample output:
>> -------------
>> echo 37 > /sys/kernel/debug/ath12k/pci-0000\:06\:00.0/mac0/htt_stats_type
>> cat /sys/kernel/debug/ath12k/pci-0000\:06\:00.0/mac0/htt_stats
>> HTT_PHY_STATS_TLV:
>> bdf_nf_chain[0] = -92
>> bdf_nf_chain[1] = -94
>> bdf_nf_chain[2] = -94
>> bdf_nf_chain[3] = -93
>> .....
>> 
>> HTT_PHY_COUNTERS_TLV:
>> rx_ofdma_timing_err_cnt = 18068
>> rx_cck_fail_cnt = 0
>> mactx_abort_cnt = 2612
>> macrx_abort_cnt = 0
>> .....
>> 
>> HTT_PHY_RESET_STATS_TLV:
>> pdev_id = 0
>> chan_mhz = 0
>> chan_band_center_freq1 = 0
>> chan_band_center_freq2 = 0
>> .....
>> 
>> HTT_PHY_RESET_COUNTERS_TLV:
>> pdev_id = 0
>> cf_active_low_fail_cnt = 0
>> cf_active_low_pass_cnt = 0
>> phy_off_through_vreg_cnt = 0
>> .....
>> 
>> HTT_PHY_TPC_STATS_TLV:
>> pdev_id = 0
>> tx_power_scale = 0
>> tx_power_scale_db = 0
>> min_negative_tx_power = 0
>> .....
>> 
>> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
>> 
>> Signed-off-by: Dinesh Karthikeyan <quic_dinek@quicinc.com>
>> Signed-off-by: Roopni Devanathan <quic_rdevanat@quicinc.com>
> Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>
>
>> +struct ath12k_htt_phy_stats_tlv {
>> +	a_sle32 nf_chain[ATH12K_HTT_STATS_MAX_CHAINS];
>> +	__le32 false_radar_cnt;
>> +	__le32 radar_cs_cnt;
>> +	a_sle32 ani_level;
>> +	__le32 fw_run_time;
>> +	a_sle32 runtime_nf_chain[ATH12K_HTT_STATS_MAX_CHAINS];
>> +} __packed;
>
> it just occurred to me that these structs are actually misnamed.
> these represent the payload of the tlv, not the actual tlv.
> Kalle, as a future cleanup I suggest that we either rename these or modify
> them plus the parsing code such that the TLV header is included in the struct.

Yeah, that would be good to do.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

