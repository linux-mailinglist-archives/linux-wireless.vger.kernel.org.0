Return-Path: <linux-wireless+bounces-16603-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 97CAB9F7AD6
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Dec 2024 12:58:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 777661885752
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Dec 2024 11:58:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72FE1223C75;
	Thu, 19 Dec 2024 11:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NQSMeYCl"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EA3422371E
	for <linux-wireless@vger.kernel.org>; Thu, 19 Dec 2024 11:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734609505; cv=none; b=ecgWFjz3HYpC8bpYK2U4U+TpyqPs+9TYCf+j14voCJ7USr/4cD01HP5wDhU/L7t0FqpbyklA4riWK41P7AU/ZQG5mMRRc99UgjSP7S6FjjRjYA8+DOLolksCnYPSBSHDjGChG2VaGWrjjHhduiJNJ4J2ia93RHGWH/1Q6lvcGjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734609505; c=relaxed/simple;
	bh=AxwDxt2ifzL4QpLmUI5qivVmIl60JW9wAMJVxJ1ZzBs=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=izkXSE0UTnNSZGmMb+4WVckfdD5cUz3U6JKjT1elurhUoQpXPalU5xZPyfDTQHUShbJSdBIxI6WYIZ3n3u44W644B7JIcCGL3LO0XbpNquYV/V/v1BtoRyJ9JzsSumKC3kBv3XqxF8cl3gMhdIlbaYVoOfzFiSO+O+9pEho3b3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NQSMeYCl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29E9CC4CECE;
	Thu, 19 Dec 2024 11:58:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734609504;
	bh=AxwDxt2ifzL4QpLmUI5qivVmIl60JW9wAMJVxJ1ZzBs=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=NQSMeYCl63k5FF6Qsy6dwCIGVRImkP9QD4vKcZeU/m38xrWs0ioCCi9IGMzVYNKL6
	 66eCKlA2QljfmFEEFHfKnaDdCGLitcXandAEGX/zPLuUtFpx0Ql1yQKOcMUf0tvke+
	 q7dtHD0StQl3b0+tNr1rwMqEgNK/bsTFo+uZP5CPEZPQ8c8Xbq/HoE33C7Y08n2/VN
	 KIHObwdljFOr+8BXyYiNiOBMgCKNHO8fu9m3rmmMBoP5wUH6Zi2nwgWMIs9wDmSWAL
	 QfWRjPZJgC6DPbipYE0rqBCLSypq5HyMojEMImgVCvDLwnXYR8YZeWI1jrtryskQoU
	 UH/FO3kMeeHQQ==
From: Kalle Valo <kvalo@kernel.org>
To: Roopni Devanathan <quic_rdevanat@quicinc.com>
Cc: <ath12k@lists.infradead.org>,  <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH 4/6] wifi: ath12k: Add API to print s8 arrays in HTT stats
References: <20241217095216.1543923-1-quic_rdevanat@quicinc.com>
	<20241217095216.1543923-5-quic_rdevanat@quicinc.com>
Date: Thu, 19 Dec 2024 13:58:22 +0200
In-Reply-To: <20241217095216.1543923-5-quic_rdevanat@quicinc.com> (Roopni
	Devanathan's message of "Tue, 17 Dec 2024 15:22:14 +0530")
Message-ID: <87zfkrhokh.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Roopni Devanathan <quic_rdevanat@quicinc.com> writes:

> Currently, print_array_to_buf() is used to print arrays to HTT
> stats buffer. This API supports printing only arrays with 32-bit
> unsigned integers. Add API print_array_to_buf_s8(), which
> implements print_array_to_buf()'s functionality to all the
> arrays with 8-bit signed integers.
>
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0-03427-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1.15378.4
>
> Signed-off-by: Roopni Devanathan <quic_rdevanat@quicinc.com>

s/API/function/

And maybe not even use the term 'function' that, saying foo() should be
clear anyone that it's a function.

An example output would be nice.

> ---
>  .../wireless/ath/ath12k/debugfs_htt_stats.c   | 28 +++++++++++++++++++
>  1 file changed, 28 insertions(+)
>
> diff --git a/drivers/net/wireless/ath/ath12k/debugfs_htt_stats.c b/drivers/net/wireless/ath/ath12k/debugfs_htt_stats.c
> index 4569ff40e9d8..621676daf971 100644
> --- a/drivers/net/wireless/ath/ath12k/debugfs_htt_stats.c
> +++ b/drivers/net/wireless/ath/ath12k/debugfs_htt_stats.c
> @@ -48,6 +48,34 @@ print_array_to_buf(u8 *buf, u32 offset, const char *header,
>  					footer);
>  }
>  
> +static u32
> +print_array_to_buf_s8(u8 *buf, u32 offset, const char *header, u32 stats_index,
> +		      const s8 *array, u32 array_len, const char *footer)
> +{

I would rather have a separate buf_len variable instead of silently
assuming it's ATH12K_HTT_STATS_BUF_SIZE, much safer that way.

> +	int index = 0;
> +	u8 i;
> +
> +	if (header) {
> +		index += scnprintf(buf + offset,
> +				   ATH12K_HTT_STATS_BUF_SIZE - offset,
> +				   "%s = ", header);
> +	}

Empty line here.

> +	for (i = 0; i < array_len; i++) {
> +		index += scnprintf(buf + offset + index,
> +				   (ATH12K_HTT_STATS_BUF_SIZE - offset) - index,
> +				   " %u:%d,", stats_index++, array[i]);
> +	}

Empty line.

> +	index--;
> +	*(buf + offset + index) = '\0';

Avoid pointer arithmetic:

buf[offset + index] = '\0'

But first check that 'offset + index < buf_len'.

> +	if (footer) {
> +		index += scnprintf(buf + offset + index,
> +				   (ATH12K_HTT_STATS_BUF_SIZE - offset) - index,
> +				   "%s", footer);
> +	}

Empty line.

> +	return index;
> +}
> +
>  static const char *ath12k_htt_ax_tx_rx_ru_size_to_str(u8 ru_size)
>  {
>  	switch (ru_size) {

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

