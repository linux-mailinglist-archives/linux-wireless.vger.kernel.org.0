Return-Path: <linux-wireless+bounces-32931-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MDeqFkGYsGkukgIAu9opvQ
	(envelope-from <linux-wireless+bounces-32931-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Mar 2026 23:16:33 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id C2A66258CE6
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Mar 2026 23:16:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 33C21300830B
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Mar 2026 22:16:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 990F22C2349;
	Tue, 10 Mar 2026 22:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GF/e5au9"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D778A2D73B9
	for <linux-wireless@vger.kernel.org>; Tue, 10 Mar 2026 22:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773180989; cv=none; b=pTrLR3zRUs5HJ/7BnA5iPW6DJgIx0A/Jc6Vd+IDRv6pskce5u95gr5cble8d1Cm6wSV6auWQh8/ZAxjxOAacMQKGSnvpF4KuL51Ix6fXeLDBY9dNNR825nnIwe6FOykUBuR/VvkuuJM9LhmnavAHlXHxRSTdwtyotxLKWbfVc4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773180989; c=relaxed/simple;
	bh=havpimDY8yuE8wW/Xsm0xvxbxVTXIpiqkfqS8m5C4+M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mF4ShpFZ7hZbUTmxV4A0y8lx6l7FheHoC1SEAG3+MlZONimFtHhMmO4VVxxGAzEiiGRmEJXaPQRHkkXm8IjtKPiwZfMWSSf01ZA7l6W5IHZRTZR6ygVntfO3fN571nkB0ljqe7QXeebrp/yFWWGcLw9stY7dRzSNvsQuv+pa2us=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GF/e5au9; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-439b7a87fb5so6524899f8f.3
        for <linux-wireless@vger.kernel.org>; Tue, 10 Mar 2026 15:16:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773180986; x=1773785786; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LUQLV3gti8q/uoS4nk7sG9jAvyCoDM8XyZQshbJgy2w=;
        b=GF/e5au9/pZJvpzkffxIC2640Z0IjaMBU/IlA/CSBM0WcD0yDfX2nXiwoDHJqizA+P
         c+g9rWDQxv6O/B7QFE9QhXOTRd8kE+dOWKW0RGrx6vjLEKGlxlZEhRJZ8WdyKmtOxjUz
         +lyKbBYd8F4/iV1xha5xF7aIHroTMN6R3FvspDtGl+bHuTSGGnAAYaFxYuJ2Jm8Yaq5I
         b8w9QeCoNKQudg+usSfbLQ5jhkWWC7W0lo3S2i999AWCXbcgHhFDOn1foMxmoZN7oN0C
         sy3/Sma603AvFyuteljiz1ryXpCJW7FtwiFTgTZ1Wz2IUykckydTFQveLOtMgCZ6sFCE
         /J6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773180986; x=1773785786;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LUQLV3gti8q/uoS4nk7sG9jAvyCoDM8XyZQshbJgy2w=;
        b=FM5NylqgR4mZ4m5xumfXzPSbXKSY8R2ixHc9QwB+UK677fEjJ4X2xMqO15RD8gDtfZ
         hHjzoD7d/2cfO++kG+ZL+lh1Tiafu+aH9m2favOngdvSJOlN0rn6Xr5GROSiyIQ0QdwF
         6K3HtTKa5h95QNbD3VClir5kYv2aQCu1YE+2uGWGLsKSLJwmmzqSWD8QIFAd4pz4JCdk
         Xf+voLy8O9epCZB45BqCsqmROjRLktVrlTftc7fEnMIZ8chWE7+0den//LybNp45eLp9
         C+dQKzP4778fOZlqgItrLeA9Zm8gtQ0g54XGp6GgsAUI0pBQM0CpumEug59w3sQ+yN5h
         tSng==
X-Forwarded-Encrypted: i=1; AJvYcCUJRgQ09qXKOQboiWl/JYqHSR3jgEoXi6U4cEyH/ETeheNeXqFfJar/RO2Mbnej8doQ0QUC4e+QAv2R8cwOdg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7yOfB/4j0KQrU1qAzZzDul2bKzH0zeBTVHsuziEMEGdUz4cru
	z5BPoJyzLfBaSAZbz51vCdEe+IJl4bcahgMz6XXuBe4/t3ckNxD/ECuc
X-Gm-Gg: ATEYQzzpJMrwm6Z5DOAb13EeQDJO6+sMX9og3P9wR12g3b6BLRD/U0kJVY0z6LVmD1q
	JCZBohm3jl+szDJ4qXkwA/cDi6VCIjVlG93DfMch97UWYeDfvr/WHC08doULybLJzTk4lnWpKIa
	T9upfRaeo3mgOUdnKY5v5cq9Wrdnb5oHB4pq2BU6nGMerImpfqlZZqNiD3rEIcFeRM533pr6Jh/
	zu3d+J4kCJeK1ek6YzoBUW8LAPlYq52KYMfYLFvE6x/lltyGi3S0QIRxprjUce+ziOjiYhPT/4r
	+CzUcHO3+ZPftYwrq3v2tt0dRh5jKyqFXv4ujMSYQ76+4uj1uA90DJx+Ofv+gHgfgaXL/ylFnQ3
	RdE4iEcgPociDg1Nq7u0ovToqDt+mxhCucQe3rta7efgnXVotot2PToHIgzkKz84n4qrxyO2IiR
	pwoj7ETwaZLq3laQRM3BMaTfZk3RTosA==
X-Received: by 2002:a05:6000:310b:b0:439:bc2b:cb57 with SMTP id ffacd0b85a97d-439f81f168fmr871998f8f.6.1773180985960;
        Tue, 10 Mar 2026 15:16:25 -0700 (PDT)
Received: from [192.168.1.50] ([81.196.40.93])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439f81a5143sm1393505f8f.14.2026.03.10.15.16.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Mar 2026 15:16:25 -0700 (PDT)
Message-ID: <cd41b8ba-1141-43e5-88b4-917945ad56ea@gmail.com>
Date: Wed, 11 Mar 2026 00:16:23 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH rtw-next] wifi: rtw89: usb: Rx aggregation for
 RTL8832CU/RTL8851BU
To: Ping-Ke Shih <pkshih@realtek.com>, linux-wireless@vger.kernel.org
Cc: mh_chen@realtek.com, isaiah@realtek.com
References: <20260309085819.25174-1-pkshih@realtek.com>
Content-Language: en-US
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
In-Reply-To: <20260309085819.25174-1-pkshih@realtek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: C2A66258CE6
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-32931-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCPT_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rtl8821cerfe2@gmail.com,linux-wireless@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,realtek.com:email]
X-Rspamd-Action: no action

On 09/03/2026 10:58, Ping-Ke Shih wrote:
> From: Shin-Yi Lin <isaiah@realtek.com>
> 
> USB RX Aggregation is a performance optimization technique used
> in USB network devices to increase throughput.
> 
> Instead of sending every received network packet to the host computer
> individually, the device hardware groups multiple smaller packets
> into a single, large USB Bulk Transfer.
> 
>  * toAP/toNB use iperf3 respectively.
> 
> With BE6000 - iperf3 tcp 10 pair (to another NB)
> 
> RTL8832CU-USB3.0
>       before   after
> TX    941      941
> RX    847      919
> 
> RTL8832CU-USB2.0
>       before   after
> TX    864      877
> RX    864      902

I wonder if these numbers are actually from a different scenario?
USB 2.0 can't go that fast.

> 
> RTL8851BU
>       before   after
> TX    115      114
> RX    295      306
> 
> Signed-off-by: Shin-Yi Lin <isaiah@realtek.com>
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
> ---
> This one is to add USB RX aggregation to improve performance. The other
> one is TX aggregation, which we are working on.

That is wonderful news.

> ---
>  .../net/wireless/realtek/rtw89/rtw8851bu.c    |  1 +
>  .../net/wireless/realtek/rtw89/rtw8852au.c    |  1 +
>  .../net/wireless/realtek/rtw89/rtw8852bu.c    |  1 +
>  .../net/wireless/realtek/rtw89/rtw8852cu.c    |  1 +
>  drivers/net/wireless/realtek/rtw89/usb.c      | 84 ++++++++++++++++---
>  drivers/net/wireless/realtek/rtw89/usb.h      | 12 +++
>  6 files changed, 87 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/net/wireless/realtek/rtw89/rtw8851bu.c b/drivers/net/wireless/realtek/rtw89/rtw8851bu.c
> index 959d62aefdd8..6a8d31544314 100644
> --- a/drivers/net/wireless/realtek/rtw89/rtw8851bu.c
> +++ b/drivers/net/wireless/realtek/rtw89/rtw8851bu.c
> @@ -15,6 +15,7 @@ static const struct rtw89_usb_info rtw8851b_usb_info = {
>  	.usb3_mac_npi_config_intf_0	= R_AX_USB3_MAC_NPI_CONFIG_INTF_0,
>  	.usb_endpoint_0			= R_AX_USB_ENDPOINT_0,
>  	.usb_endpoint_2			= R_AX_USB_ENDPOINT_2,
> +	.rx_agg_alignment		= 8,
>  	.bulkout_id = {
>  		[RTW89_DMA_ACH0] = 3,
>  		[RTW89_DMA_ACH1] = 4,
> diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852au.c b/drivers/net/wireless/realtek/rtw89/rtw8852au.c
> index ccdbcc178c2a..4cced4619b7d 100644
> --- a/drivers/net/wireless/realtek/rtw89/rtw8852au.c
> +++ b/drivers/net/wireless/realtek/rtw89/rtw8852au.c
> @@ -15,6 +15,7 @@ static const struct rtw89_usb_info rtw8852a_usb_info = {
>  	.usb3_mac_npi_config_intf_0	= R_AX_USB3_MAC_NPI_CONFIG_INTF_0,
>  	.usb_endpoint_0			= R_AX_USB_ENDPOINT_0,
>  	.usb_endpoint_2			= R_AX_USB_ENDPOINT_2,
> +	.rx_agg_alignment		= 8,
>  	.bulkout_id = {
>  		[RTW89_DMA_ACH0] = 3,
>  		[RTW89_DMA_ACH2] = 5,
> diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852bu.c b/drivers/net/wireless/realtek/rtw89/rtw8852bu.c
> index 84cd3ec971f9..37111fed276f 100644
> --- a/drivers/net/wireless/realtek/rtw89/rtw8852bu.c
> +++ b/drivers/net/wireless/realtek/rtw89/rtw8852bu.c
> @@ -15,6 +15,7 @@ static const struct rtw89_usb_info rtw8852b_usb_info = {
>  	.usb3_mac_npi_config_intf_0	= R_AX_USB3_MAC_NPI_CONFIG_INTF_0,
>  	.usb_endpoint_0			= R_AX_USB_ENDPOINT_0,
>  	.usb_endpoint_2			= R_AX_USB_ENDPOINT_2,
> +	.rx_agg_alignment		= 8,
>  	.bulkout_id = {
>  		[RTW89_DMA_ACH0] = 3,
>  		[RTW89_DMA_ACH1] = 4,
> diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852cu.c b/drivers/net/wireless/realtek/rtw89/rtw8852cu.c
> index 3b9825c92a0d..0c5aebaed873 100644
> --- a/drivers/net/wireless/realtek/rtw89/rtw8852cu.c
> +++ b/drivers/net/wireless/realtek/rtw89/rtw8852cu.c
> @@ -15,6 +15,7 @@ static const struct rtw89_usb_info rtw8852c_usb_info = {
>  	.usb3_mac_npi_config_intf_0	= R_AX_USB3_MAC_NPI_CONFIG_INTF_0_V1,
>  	.usb_endpoint_0			= R_AX_USB_ENDPOINT_0_V1,
>  	.usb_endpoint_2			= R_AX_USB_ENDPOINT_2_V1,
> +	.rx_agg_alignment		= 8,
>  	.bulkout_id = {
>  		[RTW89_DMA_ACH0] = 3,
>  		[RTW89_DMA_ACH2] = 5,
> diff --git a/drivers/net/wireless/realtek/rtw89/usb.c b/drivers/net/wireless/realtek/rtw89/usb.c
> index da1b7ce8089e..4482ce61592b 100644
> --- a/drivers/net/wireless/realtek/rtw89/usb.c
> +++ b/drivers/net/wireless/realtek/rtw89/usb.c
> @@ -408,11 +408,14 @@ static int rtw89_usb_ops_tx_write(struct rtw89_dev *rtwdev,
>  static void rtw89_usb_rx_handler(struct work_struct *work)
>  {
>  	struct rtw89_usb *rtwusb = container_of(work, struct rtw89_usb, rx_work);
> +	const struct rtw89_usb_info *info = rtwusb->info;
>  	struct rtw89_dev *rtwdev = rtwusb->rtwdev;
>  	struct rtw89_rx_desc_info desc_info;
> +	s32 aligned_offset, remaining;
>  	struct sk_buff *rx_skb;
>  	struct sk_buff *skb;
>  	u32 pkt_offset;
> +	u8 *pkt_ptr;
>  	int limit;
>  
>  	for (limit = 0; limit < 200; limit++) {
> @@ -425,23 +428,38 @@ static void rtw89_usb_rx_handler(struct work_struct *work)
>  			goto free_or_reuse;
>  		}
>  
> -		memset(&desc_info, 0, sizeof(desc_info));
> -		rtw89_chip_query_rxdesc(rtwdev, &desc_info, rx_skb->data, 0);
> +		pkt_ptr = rx_skb->data;
> +		remaining = rx_skb->len;
>  
> -		skb = rtw89_alloc_skb_for_rx(rtwdev, desc_info.pkt_size);
> -		if (!skb) {
> -			rtw89_debug(rtwdev, RTW89_DBG_HCI,
> -				    "failed to allocate RX skb of size %u\n",
> -				    desc_info.pkt_size);
> -			goto free_or_reuse;
> -		}
> +		do {
> +			memset(&desc_info, 0, sizeof(desc_info));
> +			rtw89_chip_query_rxdesc(rtwdev, &desc_info, pkt_ptr, 0);
>  
> -		pkt_offset = desc_info.offset + desc_info.rxd_len;
> +			pkt_offset = desc_info.offset + desc_info.rxd_len;
> +			if (remaining < (pkt_offset + desc_info.pkt_size)) {
> +				rtw89_debug(rtwdev, RTW89_DBG_HCI,
> +					    "Failed to get remaining RX pkt %u > %u\n",
> +					    pkt_offset + desc_info.pkt_size, remaining);
> +				goto free_or_reuse;
> +			}
>  
> -		skb_put_data(skb, rx_skb->data + pkt_offset,
> -			     desc_info.pkt_size);
> +			skb = rtw89_alloc_skb_for_rx(rtwdev, desc_info.pkt_size);
> +			if (!skb) {
> +				rtw89_debug(rtwdev, RTW89_DBG_HCI,
> +					    "failed to allocate RX skb of size %u\n",
> +					    desc_info.pkt_size);
> +				goto free_or_reuse;
> +			}
> +
> +			skb_put_data(skb, pkt_ptr + pkt_offset, desc_info.pkt_size);
> +			rtw89_core_rx(rtwdev, &desc_info, skb);
>  
> -		rtw89_core_rx(rtwdev, &desc_info, skb);
> +			/* next frame */
> +			pkt_offset += desc_info.pkt_size;
> +			aligned_offset = ALIGN(pkt_offset, info->rx_agg_alignment);
> +			pkt_ptr += aligned_offset;
> +			remaining -= aligned_offset;
> +		} while (remaining > 0);
>  
>  free_or_reuse:
>  		if (skb_queue_len(&rtwusb->rx_free_queue) >= RTW89_USB_RX_SKB_NUM)
> @@ -745,6 +763,44 @@ static int rtw89_usb_ops_mac_pre_deinit(struct rtw89_dev *rtwdev)
>  	return 0; /* Nothing to do. */
>  }
>  
> +static void usb_rx_agg_cfg_v1(struct rtw89_dev *rtwdev)

Maybe give the new functions the usual "rtw89_" prefix?

> +{
> +	const u32 rxagg_0 = FIELD_PREP_CONST(B_AX_RXAGG_0_EN, 1) |
> +			    FIELD_PREP_CONST(B_AX_RXAGG_0_NUM_TH, 0) |
> +			    FIELD_PREP_CONST(B_AX_RXAGG_0_TIME_32US_TH, 32) |
> +			    FIELD_PREP_CONST(B_AX_RXAGG_0_BUF_SZ_4K, 5);
> +
> +	rtw89_write32(rtwdev, R_AX_RXAGG_0, rxagg_0);
> +}
> +
> +static void usb_rx_agg_cfg_v2(struct rtw89_dev *rtwdev)
> +{
> +	const u32 rxagg_0 = FIELD_PREP_CONST(B_AX_RXAGG_0_EN, 1) |
> +			    FIELD_PREP_CONST(B_AX_RXAGG_0_NUM_TH, 255) |
> +			    FIELD_PREP_CONST(B_AX_RXAGG_0_TIME_32US_TH, 32) |
> +			    FIELD_PREP_CONST(B_AX_RXAGG_0_BUF_SZ_K, 20);
> +
> +	rtw89_write32(rtwdev, R_AX_RXAGG_0_V1, rxagg_0);
> +	rtw89_write32(rtwdev, R_AX_RXAGG_1_V1, 0x1F);
> +}
> +
> +static void usb_rx_agg_cfg(struct rtw89_dev *rtwdev)
> +{
> +	switch (rtwdev->chip->chip_id) {
> +	case RTL8851B:
> +	case RTL8852A:
> +	case RTL8852B:
> +		usb_rx_agg_cfg_v1(rtwdev);
> +		break;
> +	case RTL8852C:
> +		usb_rx_agg_cfg_v2(rtwdev);
> +		break;
> +	default:
> +		rtw89_warn(rtwdev, "%s: USB RX agg not support\n", __func__);
> +		return;
> +	}

The subject only mentions RTL8832CU and RTL8851BU, but looks like you
implemented it for every chip currently supported.

> +}
> +
>  static int rtw89_usb_ops_mac_post_init(struct rtw89_dev *rtwdev)
>  {
>  	struct rtw89_usb *rtwusb = rtw89_usb_priv(rtwdev);
> @@ -773,6 +829,8 @@ static int rtw89_usb_ops_mac_post_init(struct rtw89_dev *rtwdev)
>  		rtw89_write8(rtwdev, info->usb_endpoint_2 + 1, NUMP);
>  	}
>  
> +	usb_rx_agg_cfg(rtwdev);
> +
>  	return 0;
>  }
>  
> diff --git a/drivers/net/wireless/realtek/rtw89/usb.h b/drivers/net/wireless/realtek/rtw89/usb.h
> index 203ec8e993e9..afc62c1f687f 100644
> --- a/drivers/net/wireless/realtek/rtw89/usb.h
> +++ b/drivers/net/wireless/realtek/rtw89/usb.h
> @@ -20,6 +20,17 @@
>  #define RTW89_MAX_ENDPOINT_NUM		9
>  #define RTW89_MAX_BULKOUT_NUM		7
>  
> +#define R_AX_RXAGG_0_V1			0x6000
> +#define B_AX_RXAGG_0_EN			BIT(31)
> +#define B_AX_RXAGG_0_NUM_TH		GENMASK(23, 16)
> +#define B_AX_RXAGG_0_TIME_32US_TH	GENMASK(15, 8)
> +#define B_AX_RXAGG_0_BUF_SZ_K		GENMASK(7, 0)

Is it missing a number before the letter K ?

> +
> +#define R_AX_RXAGG_1_V1			0x6004
> +
> +#define R_AX_RXAGG_0			0x8900
> +#define B_AX_RXAGG_0_BUF_SZ_4K		GENMASK(7, 0)
> +
>  struct rtw89_usb_info {
>  	u32 usb_host_request_2;
>  	u32 usb_wlan0_1;
> @@ -27,6 +38,7 @@ struct rtw89_usb_info {
>  	u32 usb3_mac_npi_config_intf_0;
>  	u32 usb_endpoint_0;
>  	u32 usb_endpoint_2;
> +	u8 rx_agg_alignment;
>  	u8 bulkout_id[RTW89_DMA_CH_NUM];
>  };
>  
> 
> base-commit: 039cd522dc70151da13329a5e3ae19b1736f468a


