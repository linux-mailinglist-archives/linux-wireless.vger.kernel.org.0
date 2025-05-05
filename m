Return-Path: <linux-wireless+bounces-22454-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A98D6AA9252
	for <lists+linux-wireless@lfdr.de>; Mon,  5 May 2025 13:52:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0F9F7172F7C
	for <lists+linux-wireless@lfdr.de>; Mon,  5 May 2025 11:52:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E98831B4139;
	Mon,  5 May 2025 11:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O6Dxk400"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1777B211C
	for <linux-wireless@vger.kernel.org>; Mon,  5 May 2025 11:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746445958; cv=none; b=qFEZGZrBV2uelXNxRtstPf2vE+sgK4IwuyXKUqse06AJZi9MoJoLeDqU9SVh58CLK4YOcPu2StDSFwu/J3nRZAN8SBxfUn801CCeSu1BFBgoA69ZJa0DsA+eRv2gEmJsA61HlMrZkHTOQjslP4155Oy8Em/NPQkusvmI5dsm0uY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746445958; c=relaxed/simple;
	bh=AP8kh5nVWoLgW5ByQ50FNifi4nrRXOaA+zRkjE3xdeU=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=TUPKThTHICgfVJiaxHOPkafZ7AYXTb/z9BXHp227U6tl79inmLSRE8PRi9Gupq8czgmHNvhLLJIr+UtJarwof1uTCS43bA3qfoLSGiIFvvJwG8MBiFHj/orWsHCprSPoPFaOINyePtvnAZ2WNBmE2HTQZ3uafaiXi9+hB/P6Re0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O6Dxk400; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-ad1a87d93f7so244915866b.0
        for <linux-wireless@vger.kernel.org>; Mon, 05 May 2025 04:52:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746445955; x=1747050755; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=25Cn2uybMKdaRRO5ihnmpX+XnIs+npWPFHYudcezBsY=;
        b=O6Dxk4008+3EW408PoHOs3mNLHEgikt2s7TH3rF53QTmZiC0hYn6F5/P34mZbUoQ+u
         qNoCsqWFwsfrtsz1WCVPpTXvfdM11GhUPfFx5A9ASEUqwvRG15U4995rLsowyV8BHZgb
         HfD2O5Exu4Mztm4Zyo2xjvONLIbVA4KRrd7z6t6V7fpEp6x6glpbDxi12ynXxLH7D2QS
         ehnS8z8PO/mlcgiupicftD232xNuJtB6TuBF87m023k1ZMG4o29KUXAQjRgqgdEqqIL4
         AiO9gaeLvYIkcwREVfQHay1m7vUEdbSbIPfbgLHXFzHRaAOEkwleV8IZSiHSpH3b89s4
         iUPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746445955; x=1747050755;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=25Cn2uybMKdaRRO5ihnmpX+XnIs+npWPFHYudcezBsY=;
        b=cLlL21NLq3iJ7jk3rM6lpH7+GpV8BNo0StXURKhR3Xlbs+GBWRKo29NVzaLSB+rjBk
         kGT78u0RfvxK97sna40d5uKQfwRIwUee3cWHZhbJPPN5c49ENOFiW7iiNAniDTrrh8e8
         mjdsqO+K9TY5bawFGfiRweQ6EpHrhGu4JFb+aje5x5139qtlKmlMeUzw5JjxMAr8v/uu
         +n0/qi4W/9szamBvnJzy8ZtAuyhUDedNuCulGbB0JIX2KzBP3Lf5lHfCW8wXjD3gKQof
         rO1AFJxwL7VnwS4QXIUiR4EBmMF3z752JJtjTcyczaXLEwgJAJhLJet1Fh+QWKZhxKAT
         HhJQ==
X-Forwarded-Encrypted: i=1; AJvYcCUEXEwkOQAyDr/0I0XP6J28qCsCUny/9TASjQLDGUwDIjSIKaSwljnNeP90QZizM+DA16FhulJpAfo/c2mUzA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwC5yp/WCLtm9NoAjbYV5nECguAA4U9mpRvXEE5zxc5zcCMlMl3
	RlJsIKQ3in6guMqw4ykRv/NFCHbNbgJ9G4tZKjaDmd1UVpICgW57
X-Gm-Gg: ASbGncvVu+DC7TJi88z2kWB4JsqQjOndIGSFZ7N6VL0nVSPNxa0pTrTIl4gjvU3YaRW
	9kCKaW5JJ+dEA7qf9+4dc7fzcy/TikPRsMIXexhCyNigLaAU3XNS5y8Ijrsyi9UX9XLpEGeXIKq
	6LFCAc4cSrIeGhaCATlPehi8USg2ANQK2Lyvg6wZIsaZ1MaU/PeeX5eEe7j0Hg7hwhRiOkrGBYh
	Shj3mWUfv8nO3kihdNFggSWrfOUhwM7cz/uqh9tCoHZJd49P0g6RGvJpqfG8fdZPlDeD/NIpjMZ
	VKYYC/ziG97LO6qo2lAbS6V+sP82WXzPeeI8SN9o/xQfv/eEpw==
X-Google-Smtp-Source: AGHT+IH8Nuni1S6TZDICiE5sytocwJMG06eg8Qpgn3r3aXfJhpBZND41EXCE4eekkga7AL1g2PUvAA==
X-Received: by 2002:a17:907:6d14:b0:ac3:48e4:f8bc with SMTP id a640c23a62f3a-ad1a4b0dc03mr605940266b.48.1746445955035;
        Mon, 05 May 2025 04:52:35 -0700 (PDT)
Received: from [192.168.0.50] ([79.119.240.158])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ad1891a68a6sm481367866b.71.2025.05.05.04.52.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 May 2025 04:52:34 -0700 (PDT)
Message-ID: <ff57b627-5842-44ee-adcf-f1b4bdfac1b9@gmail.com>
Date: Mon, 5 May 2025 14:52:33 +0300
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH rtw-next v2 1/2] wifi: rtw88: Fix RX aggregation settings
 for RTL8723DS
To: Ping-Ke Shih <pkshih@realtek.com>,
 "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
References: <4c79fdc1-54bc-4986-9931-bb3ceb418b97@gmail.com>
 <43ff8b6babd649b895e8af8993d53c36@realtek.com>
Content-Language: en-US
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
In-Reply-To: <43ff8b6babd649b895e8af8993d53c36@realtek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 05/05/2025 03:45, Ping-Ke Shih wrote:
> Bitterblue Smith <rtl8821cerfe2@gmail.com> wrote:
>> Use the same RX aggregation size and timeout used by the out-of-tree
>> RTL8723DS driver. Also set mystery bit 31 of REG_RXDMA_AGG_PG_TH. This
>> improves the RX speed from ~44 Mbps to ~67 Mbps.
>>
>> Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
>> ---
>> v2:
>>  - Restore the original behaviour for RTL8821A and RTL8812A.
> 
> This patch actually restores the behavior of RTL8821A and RTL8812A. But
> they are 802.11ac chips [1] [2], somehow defined as RTW_WCPU_11N. 
> 
> I can accept this patch ahead. Please help to think how we can correct
> this mistake. 
> 

Yes, the enums RTW_WCPU_11AC and RTW_WCPU_11N have wrong names.
RTL8821A and RTL8812A are 11ac chips but their MCU is the
RTW_WCPU_11N type. RTL8733BU (not supported in rtw88) is 11n but its
MCU is the RTW_WCPU_11AC type.

I was thinking to rename them:

RTW_WCPU_11N  -> RTW_WCPU_8051
RTW_WCPU_11AC -> RTW_WCPU_3081

8051 and 3081 are the names used in the vendor drivers:

#define PHYDM_IC_8051_SERIES	(ODM_RTL8881A | ODM_RTL8812 | ODM_RTL8821 |\
				 ODM_RTL8192E | ODM_RTL8723B | ODM_RTL8703B |\
				 ODM_RTL8188F | ODM_RTL8192F | ODM_RTL8721D |\
				 ODM_RTL8710C)
#define PHYDM_IC_3081_SERIES	(ODM_RTL8814A | ODM_RTL8822B | ODM_RTL8197F |\
				 ODM_RTL8821C | ODM_RTL8195B | ODM_RTL8198F |\
				 ODM_RTL8822C | ODM_RTL8812F | ODM_RTL8814B |\
				 ODM_RTL8197G)

> Acked-by: Ping-Ke Shih <pkshih@realtek.com>
> 
> [1] https://www.realtek.com/Product/Index?id=577&cate_id=194
> [2] https://www.realtek.com/Product/Index?id=590&cate_id=194
> 
>> ---
>>  drivers/net/wireless/realtek/rtw88/sdio.c | 14 ++++++++++++--
>>  1 file changed, 12 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/net/wireless/realtek/rtw88/sdio.c b/drivers/net/wireless/realtek/rtw88/sdio.c
>> index c57f683d9af8..71cbe49b6c59 100644
>> --- a/drivers/net/wireless/realtek/rtw88/sdio.c
>> +++ b/drivers/net/wireless/realtek/rtw88/sdio.c
>> @@ -677,12 +677,22 @@ static void rtw_sdio_enable_rx_aggregation(struct rtw_dev *rtwdev)
>>  {
>>         u8 size, timeout;
>>
>> -       if (rtw_chip_wcpu_11n(rtwdev)) {
>> +       switch (rtwdev->chip->id) {
>> +       case RTW_CHIP_TYPE_8703B:
>> +       case RTW_CHIP_TYPE_8821A:
>> +       case RTW_CHIP_TYPE_8812A:
>>                 size = 0x6;
>>                 timeout = 0x6;
>> -       } else {
>> +               break;
>> +       case RTW_CHIP_TYPE_8723D:
>> +               size = 0xa;
>> +               timeout = 0x3;
>> +               rtw_write8_set(rtwdev, REG_RXDMA_AGG_PG_TH + 3, BIT(7));
>> +               break;
>> +       default:
>>                 size = 0xff;
>>                 timeout = 0x1;
>> +               break;
>>         }
>>
>>         /* Make the firmware honor the size limit configured below */
>> --
>> 2.49.0
> 


