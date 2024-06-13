Return-Path: <linux-wireless+bounces-8970-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8785A906D93
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Jun 2024 14:01:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EDDD5B21742
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Jun 2024 12:01:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0F6E143895;
	Thu, 13 Jun 2024 11:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lGukLQ3m"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AC7B144D10
	for <linux-wireless@vger.kernel.org>; Thu, 13 Jun 2024 11:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718279873; cv=none; b=D5ar/pidDKRKNL8UP5jvoEC++OXNNkY/KkN4OkhN5qWUm9YmIA5YK5pZNbHPBp7pxJEy5VeyBsTdBHVOqVX8nkT9ig+g7tp0mvsMHuSWlifCy9TKOfZ8IKgSaeqzEgRqHdfhHTukzRsKY43FaMJi3sa5gkBN3A3n3rs6wCjbwnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718279873; c=relaxed/simple;
	bh=WdR2uKbi+aE3mfW1aKqsMSFkOLeigSEjXjuPzUtAIus=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EZgb3YDO63VZDLLlPRqskg9JxIrrlHs07CkaJguMqSlQAC7jmgWn2KclZdNrkCfq4JIdxv7teSgFkUD54/af74CbGfp/lhPieNNJnkuakqPtNFeJjtQ9GDC7RxW0JeTj+q61NysTvIhBw8oVC4jFPqBbuB3Lm0vnt423DLzPFBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lGukLQ3m; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-797e2834c4eso78196585a.0
        for <linux-wireless@vger.kernel.org>; Thu, 13 Jun 2024 04:57:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718279871; x=1718884671; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cGp5SUbhfiYEXAvDC6yfHjc6QfvFVYKkhcb4+jdxCaE=;
        b=lGukLQ3mMQfn8lfKBb4uge6fU25ON4+mdTd3W8P6KjxX5bh8Oi9aCgEL+KtBd2+Tlr
         jMCg45MiHnJK7cLQr9rrq+vw1cGYj7VskEQ5BM8Ou5jmzyk8f07N134QhwdwKATA16Yv
         tMjXY8hye1vmoSOtGnqEDHoovkobhTPELy1B6RfCoq/D6+gzLaaFJyNF5VArWZpOF39r
         NTluHDSDWrJZ5W5pQVplHCPjq9HsQyYGAEOSDxdL4dYVLx/jfxyKIz4zEWQmy2fpKCME
         DSyUy0yFqS7BoBl21yKKCMb5F09/hoZU7vyrApuCSb4hu2C/DMTeTmUfc4j8s13run1F
         xkRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718279871; x=1718884671;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cGp5SUbhfiYEXAvDC6yfHjc6QfvFVYKkhcb4+jdxCaE=;
        b=DN/MLRQnOfeU+X4ezM9CWd34wK0UcjMs+5E6S3yhpiQAAb2dW9LQ+nryN2n9EvoEWI
         6nSSq02mGKjSk/KFHlT6m6zBofLwwo3btjnDEHorc+6BhIRtTtAIpkaBi//SUhMeoH0L
         kOkqb/k09/lH+y4lXQzDbWa8F88gm2OC3qYBNTZQoYc0zHlZtfdCMzY8jGqrf8En3Fb5
         1gsHk2765taAGrVC6yl8Yiaw6E/WxZG0g6BNIeMg+hD33E0QDVgWs2zhRSn/1uBSA5K2
         cRrJ/HD0QAIUDhbFw+OuKMP4FNHeoditnZGbh38+QEjE0FflYkWyuDz4u5o9tADnbAlw
         tzdA==
X-Gm-Message-State: AOJu0Yxsm6dS6bJBlljaHU0uEx2WrEyzc3KUM/m2FVCqelCbTXISIhsb
	7yVHF1OI8mOvY6UhuP8LU0O8gaIe1hPBTkE/xmzpzNhZF8aVrCFY
X-Google-Smtp-Source: AGHT+IFKOj3pRPTDrZ715JOcNvFxzBff9igcRI1OezZ3h97UPywKbb9UA4fsdhQc92qUJzERVTrNDQ==
X-Received: by 2002:a05:620a:4005:b0:795:5711:a212 with SMTP id af79cd13be357-79810109f03mr331143985a.23.1718279870992;
        Thu, 13 Jun 2024 04:57:50 -0700 (PDT)
Received: from [10.102.4.150] ([208.195.13.130])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-798aaecc068sm45834885a.34.2024.06.13.04.57.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Jun 2024 04:57:50 -0700 (PDT)
Message-ID: <4bdf84bf-0d6f-4391-a529-134ccde53aae@gmail.com>
Date: Thu, 13 Jun 2024 04:57:48 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: ath11k: fix ack signal strength calculation
To: Lingbo Kong <quic_lingbok@quicinc.com>, ath11k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
References: <20240611022550.59078-1-quic_lingbok@quicinc.com>
Content-Language: en-US
From: James Prestwood <prestwoj@gmail.com>
In-Reply-To: <20240611022550.59078-1-quic_lingbok@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Lingbo,

On 6/10/24 7:25 PM, Lingbo Kong wrote:
> Currently, the calculation of ack signal strength is incorrect.
>
> This is because before calculating the ack signal strength, ath11k need
> to determine whether the hardware and firmware support db2dbm. If the
> hardware and firmware support db2dbm, do not need to add noise floor,
> otherwise, need to add noise floor.

This oatch got me checking on some devices we have running ath11k 
(WCN6855). I don't see any "ack signal" property but I noticed the 
signal avg does not seem correct:

signal:      -55 [-62, -56] dBm
signal avg:    105 dBm

Every other device besides ath11k has a signal avg close to or equal to 
the signal. Do you think there is also an issue with this property? not 
just the ack signal?

Thanks,

James

>
> Besides, the value of ack_rssi passed by firmware to ath11k should be a
> signed number, so change its type to s8.
>
> After that, "iw wlan0 station dump" show the correct ack signal strength.
>
> Such as:
> root@CDCCSTEX0799733-LIN:~# iw wlp88s0 station dump
> Station 00:03:7f:12:df:df (on wlp88s0)
>          inactive time:  75 ms
>          rx bytes:       11599
>          rx packets:     99
>          tx bytes:       9029
>          tx packets:     81
>          tx retries:     4
>          tx failed:      0
>          rx drop misc:   2
>          signal:         -16 dBm
>          signal avg:     -24 dBm
>          tx bitrate:     1560.0 MBit/s VHT-MCS 9 80MHz VHT-NSS 4
>          tx duration:    9230 us
>          rx bitrate:     1560.0 MBit/s VHT-MCS 9 80MHz VHT-NSS 4
>          rx duration:    7201 us
>          last ack signal:-23 dBm
>          avg ack signal: -22 dBm
>
> Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILICONZ_LITE-3.6510.30
> Tested-on: QCN9074 hw1.0 PCI WLAN.HK.2.7.0.1-01744-QCAHKSWPL_SILICONZ-1
>
> Signed-off-by: Lingbo Kong <quic_lingbok@quicinc.com>
> ---
>   drivers/net/wireless/ath/ath11k/dp_tx.c  | 16 ++++++++++++----
>   drivers/net/wireless/ath/ath11k/dp_tx.h  |  4 ++--
>   drivers/net/wireless/ath/ath11k/hal_tx.h |  4 ++--
>   3 files changed, 16 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/net/wireless/ath/ath11k/dp_tx.c b/drivers/net/wireless/ath/ath11k/dp_tx.c
> index 21819b741701..8522c67baabf 100644
> --- a/drivers/net/wireless/ath/ath11k/dp_tx.c
> +++ b/drivers/net/wireless/ath/ath11k/dp_tx.c
> @@ -353,8 +353,12 @@ ath11k_dp_tx_htt_tx_complete_buf(struct ath11k_base *ab,
>   	if (ts->acked) {
>   		if (!(info->flags & IEEE80211_TX_CTL_NO_ACK)) {
>   			info->flags |= IEEE80211_TX_STAT_ACK;
> -			info->status.ack_signal = ATH11K_DEFAULT_NOISE_FLOOR +
> -						  ts->ack_rssi;
> +			info->status.ack_signal = ts->ack_rssi;
> +
> +			if (!test_bit(WMI_TLV_SERVICE_HW_DB2DBM_CONVERSION_SUPPORT,
> +				      ab->wmi_ab.svc_map))
> +				info->status.ack_signal += ATH11K_DEFAULT_NOISE_FLOOR;
> +
>   			info->status.flags |=
>   				IEEE80211_TX_STATUS_ACK_SIGNAL_VALID;
>   		} else {
> @@ -584,8 +588,12 @@ static void ath11k_dp_tx_complete_msdu(struct ath11k *ar,
>   	if (ts->status == HAL_WBM_TQM_REL_REASON_FRAME_ACKED &&
>   	    !(info->flags & IEEE80211_TX_CTL_NO_ACK)) {
>   		info->flags |= IEEE80211_TX_STAT_ACK;
> -		info->status.ack_signal = ATH11K_DEFAULT_NOISE_FLOOR +
> -					  ts->ack_rssi;
> +		info->status.ack_signal = ts->ack_rssi;
> +
> +		if (!test_bit(WMI_TLV_SERVICE_HW_DB2DBM_CONVERSION_SUPPORT,
> +			      ab->wmi_ab.svc_map))
> +			info->status.ack_signal += ATH11K_DEFAULT_NOISE_FLOOR;
> +
>   		info->status.flags |= IEEE80211_TX_STATUS_ACK_SIGNAL_VALID;
>   	}
>   
> diff --git a/drivers/net/wireless/ath/ath11k/dp_tx.h b/drivers/net/wireless/ath/ath11k/dp_tx.h
> index 61be2265e09f..795fe3b8fa0d 100644
> --- a/drivers/net/wireless/ath/ath11k/dp_tx.h
> +++ b/drivers/net/wireless/ath/ath11k/dp_tx.h
> @@ -1,7 +1,7 @@
>   /* SPDX-License-Identifier: BSD-3-Clause-Clear */
>   /*
>    * Copyright (c) 2018-2019 The Linux Foundation. All rights reserved.
> - * Copyright (c) 2021, 2023 Qualcomm Innovation Center, Inc. All rights reserved.
> + * Copyright (c) 2021, 2023-2024 Qualcomm Innovation Center, Inc. All rights reserved.
>    */
>   
>   #ifndef ATH11K_DP_TX_H
> @@ -13,7 +13,7 @@
>   struct ath11k_dp_htt_wbm_tx_status {
>   	u32 msdu_id;
>   	bool acked;
> -	int ack_rssi;
> +	s8 ack_rssi;
>   	u16 peer_id;
>   };
>   
> diff --git a/drivers/net/wireless/ath/ath11k/hal_tx.h b/drivers/net/wireless/ath/ath11k/hal_tx.h
> index c5e88364afe5..46d17abd808b 100644
> --- a/drivers/net/wireless/ath/ath11k/hal_tx.h
> +++ b/drivers/net/wireless/ath/ath11k/hal_tx.h
> @@ -1,7 +1,7 @@
>   /* SPDX-License-Identifier: BSD-3-Clause-Clear */
>   /*
>    * Copyright (c) 2018-2019 The Linux Foundation. All rights reserved.
> - * Copyright (c) 2022 Qualcomm Innovation Center, Inc. All rights reserved.
> + * Copyright (c) 2022, 2024 Qualcomm Innovation Center, Inc. All rights reserved.
>    */
>   
>   #ifndef ATH11K_HAL_TX_H
> @@ -54,7 +54,7 @@ struct hal_tx_info {
>   struct hal_tx_status {
>   	enum hal_wbm_rel_src_module buf_rel_source;
>   	enum hal_wbm_tqm_rel_reason status;
> -	u8 ack_rssi;
> +	s8 ack_rssi;
>   	u32 flags; /* %HAL_TX_STATUS_FLAGS_ */
>   	u32 ppdu_id;
>   	u8 try_cnt;
>
> base-commit: a116bf2be795eb1db75fa6a48aa85c397be001a6

