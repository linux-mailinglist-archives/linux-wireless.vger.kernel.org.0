Return-Path: <linux-wireless+bounces-28911-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B9558C57AEE
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Nov 2025 14:34:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 73DCE4E4375
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Nov 2025 13:32:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5372A610B;
	Thu, 13 Nov 2025 13:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jn2r5/aQ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81A8B18024
	for <linux-wireless@vger.kernel.org>; Thu, 13 Nov 2025 13:32:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763040764; cv=none; b=M4YgtRBDjR5tc7wR7TpQs81sigqP9IUkFZeW+LpX2axgRFACRtnfDgUrLg+wEkZ7taMROZsGlOzx98U1xg5VgswABMMJB8890wb0EX5GWbSMr3pghZGg/gquQIIiQKDbtRSGP33gnTE/Un4Qc2etr3TK2qgRGiHJNi3AQEwumnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763040764; c=relaxed/simple;
	bh=8mLsdmPZLtU40P3ILotHJtHzQMnztAgvjjG/yoXbO/Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mFTjT7xTDO95fzCYxZQE3+UxEOMLKLMJ2wtI4XEoWgkWAly46YDePDxttKikQLonlmjHFjdn1tusE+50D4TqPjtjuXc2Mo4b4Our3b0k7qXDN/yJHhFirLItFQXvM1zURN3TSd8CPQgWSalHnrSBtCtmG0sdXjyMjSgyCkh7R/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jn2r5/aQ; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-64080ccf749so1224828a12.2
        for <linux-wireless@vger.kernel.org>; Thu, 13 Nov 2025 05:32:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763040761; x=1763645561; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uFu7xtT5wVjiM4h3amB0fafHvCtiAuW0GdZeZ9lI7yM=;
        b=Jn2r5/aQ0uYzTlmzxJwXAKFVQvH+z9C9nHhvj3uBSk+ZfhPiu+vCAR2Ri/maPbFi9z
         t0OfHJmt2Ds5do6aSKmlFctduwbStsBvwiAvTQ7HKXqkaYl4xfXDdcB6D3TdyKimqDr0
         MbtdDcG6XyM05Gx6j2PBDWxHGZ/Q4eVp63JSF1Mu3TflSWOhkyK14rFz9wmFBxqdRKb/
         MS2YkdVCqDUQDhJ34Dutp71WvzOYCALTtJ8ldFT9DJ89AVVlJYX/TU8RQrZjAvgAx0mK
         AJi2AnNe4tESwOnhdqlKM7Qn/HS07cJdwYbkPTqRsjW9PdK9oGYtHQznRd15Aj6s6gCy
         ix5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763040761; x=1763645561;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uFu7xtT5wVjiM4h3amB0fafHvCtiAuW0GdZeZ9lI7yM=;
        b=CcIGyO2tCdSumaUwtqC3VhXqpPb3W68Gwx/S5GLBNR4c5vABfsWrZPPs84/dCyC2CD
         Dpbg5miqQ3kYAfiKn0XQ5sgjWq5KV2lwjGcmAQDPG+YXWP7RjrPePh/xtRMhpohgSOdS
         2yDwbiT7ix1ERmTnTrPI2VHnIhp+xcgW+pJdnThK61IcG9FLJRNznprcilZL/hOf+s3z
         O4czHDJfE1gCUzD4us2pDH2L26aAdzUf3z/t0HHHFE6FZKJYs5DI1nPqZNVA+3+cfn4A
         KSWoqNKmBAtoHkXQw01CNBlGO6ODWVzATlOZl4Lk5eUL+0aEC+ZnyGrK3a4eKfy/e18h
         sziA==
X-Forwarded-Encrypted: i=1; AJvYcCXLWdziqAYKuLsgoNQIK22i1dWF23qpGdL//tghJNduVMOKEQuga7xa1waYx7z9QdPP+OMceLzQk2G0cRlLLA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwtG8fiV0a8Dhr9Tk7EXlLQxdM8Bvpx8c89RyZg9YJjXf0Jh+X6
	VfBt0rW83u027yL6vPACUGkZ4RLDRDcNoSslZ/c3/n29oCRpUcrc60dXFNO8Zw==
X-Gm-Gg: ASbGncv5q8r4VMEtptHYK6H/Rwl7Fwq5TOnGdLP1xC4uak8LTTkiNCqAqoWLYLlZZTu
	1+LkUZTFvZ1/dlVnSyXh8oqsq5bHV2Gm3mTsG4MEVld6OG2nUma/Zzw+T1NGLUdHiqd6lOL26N8
	T0lKsps1aeoBhP2soie8QsmgEsWBWP+ciy7rgtR6jTY6cUiV1hlSfB3kM1Vv6KOh4PO1BsTKJxF
	CH9rogFw6ez3UbrK4uUbyG1D+1fbcWm737hUUMKIw+7SQDh4udhK/VF6AoDBj3MzjY8pqKeabV9
	4Cci7YIAmQvqcnk3AXO0dGxhzobMm2Nx7fQEcXCtEWedlciDQlC0zJClNKQtp3E5Fj8Nk2J7Ux7
	pXIwwKc443QlXsPohiYBsdpnBfDhjMHGhk19PZBAr2Dd8ZF2aAfGkP0Ec9cjgR8lvIuaj4zNha2
	SoPrkf80tP
X-Google-Smtp-Source: AGHT+IHfMAh6GhbR5XddIzDn4BNuWui1CQhnF+PEf75KanV+P7U5dxUPcT15tv7Vt5XTrpt83vJ51A==
X-Received: by 2002:a17:907:60d3:b0:b3b:5fe6:577a with SMTP id a640c23a62f3a-b733195dd65mr665959666b.8.1763040760450;
        Thu, 13 Nov 2025 05:32:40 -0800 (PST)
Received: from [192.168.1.50] ([79.119.240.87])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b734fa81296sm170840266b.6.2025.11.13.05.32.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Nov 2025 05:32:39 -0800 (PST)
Message-ID: <e5e2ecf9-ef8f-4eeb-886a-8c8a01ade9f1@gmail.com>
Date: Thu, 13 Nov 2025 15:32:37 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH rtw-next 09/14] wifi: rtw89: fw: print band and port where
 beacon update on
To: Ping-Ke Shih <pkshih@realtek.com>, linux-wireless@vger.kernel.org
Cc: gary.chang@realtek.com
References: <20251113025620.31086-1-pkshih@realtek.com>
 <20251113025620.31086-10-pkshih@realtek.com>
Content-Language: en-US
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
In-Reply-To: <20251113025620.31086-10-pkshih@realtek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 13/11/2025 04:56, Ping-Ke Shih wrote:
> The C2H event of BCN_UPD_DONE is to notify driver that firmware changes
> beacon content on certain band/port asked by driver. Print the
> notification for debug purpose for now.
> 
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
> ---
>  drivers/net/wireless/realtek/rtw89/fw.h  |  9 +++++++++
>  drivers/net/wireless/realtek/rtw89/mac.c | 13 ++++++++++++-
>  2 files changed, 21 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/wireless/realtek/rtw89/fw.h b/drivers/net/wireless/realtek/rtw89/fw.h
> index 87c55a1a9d94..bb3e7bbb41de 100644
> --- a/drivers/net/wireless/realtek/rtw89/fw.h
> +++ b/drivers/net/wireless/realtek/rtw89/fw.h
> @@ -3648,6 +3648,15 @@ struct rtw89_fw_c2h_log_fmt {
>  #define RTW89_C2H_FW_LOG_SIGNATURE 0xA5A5
>  #define RTW89_C2H_FW_LOG_STR_BUF_SIZE 512
>  
> +struct rtw89_c2h_bcn_upd_done {
> +	struct rtw89_c2h_hdr hdr;
> +	__le32 w2;
> +} __packed;
> +
> +#define RTW89_C2H_BCN_UPD_DONE_W2_PORT GENMASK(2, 0)
> +#define RTW89_C2H_BCN_UPD_DONE_W2_MBSSID GENMASK(6, 3)
> +#define RTW89_C2H_BCN_UPD_DONE_W2_BAND_IDX BIT(7)
> +
>  struct rtw89_c2h_mac_bcnfltr_rpt {
>  	__le32 w0;
>  	__le32 w1;
> diff --git a/drivers/net/wireless/realtek/rtw89/mac.c b/drivers/net/wireless/realtek/rtw89/mac.c
> index 21f5023c4f69..b120507729ae 100644
> --- a/drivers/net/wireless/realtek/rtw89/mac.c
> +++ b/drivers/net/wireless/realtek/rtw89/mac.c
> @@ -5309,8 +5309,19 @@ rtw89_mac_c2h_bcn_cnt(struct rtw89_dev *rtwdev, struct sk_buff *c2h, u32 len)
>  }
>  
>  static void
> -rtw89_mac_c2h_bcn_upd_done(struct rtw89_dev *rtwdev, struct sk_buff *c2h, u32 len)
> +rtw89_mac_c2h_bcn_upd_done(struct rtw89_dev *rtwdev, struct sk_buff *skb_c2h, u32 len)
>  {
> +	const struct rtw89_c2h_bcn_upd_done *c2h =
> +		(const struct rtw89_c2h_bcn_upd_done *)skb_c2h->data;
> +	u8 band, port, mbssid;
> +
> +	port = le32_get_bits(c2h->w2, RTW89_C2H_BCN_UPD_DONE_W2_PORT);
> +	mbssid = le32_get_bits(c2h->w2, RTW89_C2H_BCN_UPD_DONE_W2_MBSSID);
> +	band = le32_get_bits(c2h->w2, RTW89_C2H_BCN_UPD_DONE_W2_BAND_IDX);
> +
> +	rtw89_debug(rtwdev, RTW89_DBG_FW,
> +		    "BCN update done on port:%d mbssid:%d band:%d",

\n ?

> +		    port, mbssid, band);
>  }
>  
>  static void


