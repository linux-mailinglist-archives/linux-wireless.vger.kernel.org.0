Return-Path: <linux-wireless+bounces-26153-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47C20B1A93B
	for <lists+linux-wireless@lfdr.de>; Mon,  4 Aug 2025 20:40:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF0193BFF54
	for <lists+linux-wireless@lfdr.de>; Mon,  4 Aug 2025 18:40:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB9101BCA07;
	Mon,  4 Aug 2025 18:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="d0k632fL"
X-Original-To: linux-wireless@vger.kernel.org
Received: from out-180.mta1.migadu.com (out-180.mta1.migadu.com [95.215.58.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D4D2EEAB
	for <linux-wireless@vger.kernel.org>; Mon,  4 Aug 2025 18:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754332802; cv=none; b=WSn49FXuebm8yfDin5nhd6ZQOvUlIJcuwVduIxkS3wkbBvAX15i5pSTdu2lkL8lZG8pmz9q6l4RGxk9HF+iYdyXan2SrOvJn6NFxC1YylYnFJTTX0/O2ee4eYUTqWpodAfp+XUPj+W2Xqtgs9oqeGynTdmh8RJWvpnV8N/sIAK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754332802; c=relaxed/simple;
	bh=aMnk53DEPzeGkyp2XOGO4nyQZdCR2jQNe+9TvJr+47M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ld5c0jhrDPLQhFLZe5n1kWsjGoCF6lbqAQH7FcLzMJzHoQs2nnJrzhzDsWX/onkKakeuad8Bl66dyatgM2giOKWsGyQqRn01H78mBLpVlNzwz+ThPTr4is8U52mlBueO6I4I2Hh31tNjCRvKAzrJY4uC1R9g40ZY/Wb4mTyCi9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=d0k632fL; arc=none smtp.client-ip=95.215.58.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <c523eee7-1eaa-4114-bfeb-b354cc970b94@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1754332797;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YGZXKrA8rnwnyTP2zmWKI/TNJqFTbDjzrn44Gleqp+c=;
	b=d0k632fLD8Fxo6Y66hXStTiqtlbeLDS85h89xtaOnl9LfE9yUPdzLAYnqjZGM7R9eaG/oS
	3UB3/oZHm8oXAzaGLuOIKyQfiqWq8CD3iguMq1rqqUdlasVP+U6LaANABpl2BTCJKpEuxR
	ZWfYJQG3FHRzamsmJDJDCO7/8t8g0+g=
Date: Mon, 4 Aug 2025 14:39:53 -0400
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH rtw-next 2/2] wifi: rtw89: add dummy C2H handlers for BCN
 resend and update done
To: Ping-Ke Shih <pkshih@realtek.com>, linux-wireless@vger.kernel.org
Cc: rtl8821cerfe2@gmail.com
References: <20250804012234.8913-1-pkshih@realtek.com>
 <20250804012234.8913-3-pkshih@realtek.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Sean Anderson <sean.anderson@linux.dev>
In-Reply-To: <20250804012234.8913-3-pkshih@realtek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 8/3/25 21:22, Ping-Ke Shih wrote:
> Two C2H events are not listed, and driver throws
> 
>   MAC c2h class 0 func 6 not support
>   MAC c2h class 1 func 3 not support
> 
> Since the implementation in vendor driver does nothing, add two dummy
> functions for them.
> 
> Reported-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
> Closes: https://lore.kernel.org/linux-wireless/d2d62793-046c-4b55-93ed-1d1f43cff7f2@gmail.com/
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
> ---
>  drivers/net/wireless/realtek/rtw89/mac.c | 13 ++++++++++++-
>  drivers/net/wireless/realtek/rtw89/mac.h |  1 +
>  2 files changed, 13 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/wireless/realtek/rtw89/mac.c b/drivers/net/wireless/realtek/rtw89/mac.c
> index ef17a307b770..33a7dd9d6f0e 100644
> --- a/drivers/net/wireless/realtek/rtw89/mac.c
> +++ b/drivers/net/wireless/realtek/rtw89/mac.c
> @@ -5235,6 +5235,11 @@ rtw89_mac_c2h_bcn_cnt(struct rtw89_dev *rtwdev, struct sk_buff *c2h, u32 len)
>  {
>  }
>  
> +static void
> +rtw89_mac_c2h_bcn_upd_done(struct rtw89_dev *rtwdev, struct sk_buff *c2h, u32 len)
> +{
> +}
> +
>  static void
>  rtw89_mac_c2h_pkt_ofld_rsp(struct rtw89_dev *rtwdev, struct sk_buff *skb_c2h,
>  			   u32 len)
> @@ -5257,6 +5262,11 @@ rtw89_mac_c2h_pkt_ofld_rsp(struct rtw89_dev *rtwdev, struct sk_buff *skb_c2h,
>  	rtw89_complete_cond(wait, cond, &data);
>  }
>  
> +static void
> +rtw89_mac_c2h_bcn_resend(struct rtw89_dev *rtwdev, struct sk_buff *c2h, u32 len)
> +{
> +}
> +
>  static void
>  rtw89_mac_c2h_tx_duty_rpt(struct rtw89_dev *rtwdev, struct sk_buff *skb_c2h, u32 len)
>  {
> @@ -5646,7 +5656,7 @@ void (* const rtw89_mac_c2h_ofld_handler[])(struct rtw89_dev *rtwdev,
>  	[RTW89_MAC_C2H_FUNC_EFUSE_DUMP] = NULL,
>  	[RTW89_MAC_C2H_FUNC_READ_RSP] = NULL,
>  	[RTW89_MAC_C2H_FUNC_PKT_OFLD_RSP] = rtw89_mac_c2h_pkt_ofld_rsp,
> -	[RTW89_MAC_C2H_FUNC_BCN_RESEND] = NULL,
> +	[RTW89_MAC_C2H_FUNC_BCN_RESEND] = rtw89_mac_c2h_bcn_resend,
>  	[RTW89_MAC_C2H_FUNC_MACID_PAUSE] = rtw89_mac_c2h_macid_pause,
>  	[RTW89_MAC_C2H_FUNC_SCANOFLD_RSP] = rtw89_mac_c2h_scanofld_rsp,
>  	[RTW89_MAC_C2H_FUNC_TX_DUTY_RPT] = rtw89_mac_c2h_tx_duty_rpt,
> @@ -5661,6 +5671,7 @@ void (* const rtw89_mac_c2h_info_handler[])(struct rtw89_dev *rtwdev,
>  	[RTW89_MAC_C2H_FUNC_DONE_ACK] = rtw89_mac_c2h_done_ack,
>  	[RTW89_MAC_C2H_FUNC_C2H_LOG] = rtw89_mac_c2h_log,
>  	[RTW89_MAC_C2H_FUNC_BCN_CNT] = rtw89_mac_c2h_bcn_cnt,
> +	[RTW89_MAC_C2H_FUNC_BCN_UPD_DONE] = rtw89_mac_c2h_bcn_upd_done,
>  };
>  
>  static
> diff --git a/drivers/net/wireless/realtek/rtw89/mac.h b/drivers/net/wireless/realtek/rtw89/mac.h
> index 241e89983c4a..25fe5e5c8a97 100644
> --- a/drivers/net/wireless/realtek/rtw89/mac.h
> +++ b/drivers/net/wireless/realtek/rtw89/mac.h
> @@ -419,6 +419,7 @@ enum rtw89_mac_c2h_info_func {
>  	RTW89_MAC_C2H_FUNC_DONE_ACK,
>  	RTW89_MAC_C2H_FUNC_C2H_LOG,
>  	RTW89_MAC_C2H_FUNC_BCN_CNT,
> +	RTW89_MAC_C2H_FUNC_BCN_UPD_DONE = 0x06,
>  	RTW89_MAC_C2H_FUNC_INFO_MAX,
>  };
>  

It's not how I would fix it, but fine with me.

Reviewed-by: Sean Anderson <sean.anderson@linux.dev>

