Return-Path: <linux-wireless+bounces-12817-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D348976E4F
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Sep 2024 17:59:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8E70DB2339F
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Sep 2024 15:59:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D625154C0B;
	Thu, 12 Sep 2024 15:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J35agp4o"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D7871BB68F
	for <linux-wireless@vger.kernel.org>; Thu, 12 Sep 2024 15:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726156763; cv=none; b=A+dd5TUeT/yugCbBykVGDrhf46r+2U1hCnoa8WOVJpWTxc90RFZu90F/DSWPbXV9oi43gj6shU01ydg2lk7MycpkwnPua6cde19oKNnI5VipS2YpTs7p9hwsS3LmycAxoM+krKCJYjTg2FJlPQV2PsjdpQsHbSlWj5z6jerEACg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726156763; c=relaxed/simple;
	bh=cUVAmOKS+GzNzNME+uCoWVNZmnZ5yeUjLuhOHB0ni7g=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:References:
	 In-Reply-To:Content-Type; b=kvksMVD6sLs602doq7zuYrXyOKzMeoFaGmzd3a2zo/XsX8rMFflmN7f06LvSOZZySuUUUcIrQnJ4Hl8P5VwTR3SolqE2TV+A5d9H7iXhyQ5kcZj/fjrEErseF5a2aWTxE0pso5AY5c/1WqjHZN9MN/HCcHmvrPToAi/nL2+9Xpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J35agp4o; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4280ca0791bso10755885e9.1
        for <linux-wireless@vger.kernel.org>; Thu, 12 Sep 2024 08:59:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726156760; x=1726761560; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :to:subject:from:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gWQAPYnnOGbsN8xsMGALK7LYG7mcRPMFo06DpDTU8r4=;
        b=J35agp4orNm0cLgNdZXiWQnFvyt6e4AlZPZBBqQScXxhvJcjQ6kXGSLM6yI/1sS3UU
         9QtIuxHLEhDE8dFJaTJHpSZIZMjXrr/iP04WlVKJex4ObaRlJXrb3W7ijodUCbAdSqKB
         hxqk+S8tHIXxMcxIEUfcJkPCNqPlxAxbZi77t5AKsbXZrTtsr4WiKRHCfZuvxPPd3Y4f
         S1mLy5mq6zVgSEDMlGaqfYzjKpVNoKc3wIJiMpMBsxR0++9YgIXiSd575DThRNFuYlo3
         6MA0w+DNSxK1k7VU8osS3+AEtGAJc6nbmO5fxJBxnxpYfGs4LTVvS8x8AcDIqxll5xAB
         BqPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726156760; x=1726761560;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gWQAPYnnOGbsN8xsMGALK7LYG7mcRPMFo06DpDTU8r4=;
        b=cc4Y/LsjbbHuUlyRudNPFelWYj34jHE1e0+2yU7KQPlxjVeY5L6lOSOvnK1Pk6oQYI
         53vUlJc9C3OOp2FAS4UgF09LjqtONfydgmbmTTosUEXpQU7dO3hel7Yu/XPbJy2yq3I1
         VXLrz21zJ9c+r5alZcGyYWt0IxFylgjkuTf/ozlkIsfIefywTrtYuSYIA9HrrZpwSsUB
         rAHotNvLmMbCb8Xsmf1J4qudOMtiJ6k7GimoZgQgOQgjHdBoQtph11CDOFGVG6W5K4UY
         C3WFxH7ywUAN5yJgx5JJouqx9oS/K1Q6dgOPXhQOR5n/35gaiJ0lQos9dVTbVwRc6aXS
         s0/g==
X-Forwarded-Encrypted: i=1; AJvYcCV2ehYafRJCaxejj1/tSXEYpEVH7AS+ASgxJv1voMlLdXzMZgk7nLDq9E2DUxwb4PdRDB+o5kTiQ3ySPXfiXA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzl73BjJWNlygFuZx9drrUQUh+SstMYiSVd8N4cmYYN3VtMUStp
	UVXCN9uxsBCyegaD64G7yn02tmxOzEsBRSimFvkw8RnqvoqbseFH
X-Google-Smtp-Source: AGHT+IH7bfo2JBMMTGS0lCNOyO0nkcvmeq+7ONTfC8oHlWwK+fIQYTopP0G6tYtHSe3zqLzPhGgPmQ==
X-Received: by 2002:a05:6000:1247:b0:374:c29f:8ddc with SMTP id ffacd0b85a97d-378c2d638bemr2154407f8f.40.1726156758818;
        Thu, 12 Sep 2024 08:59:18 -0700 (PDT)
Received: from [192.168.1.50] ([79.119.240.114])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37895665ba0sm14781551f8f.48.2024.09.12.08.59.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Sep 2024 08:59:18 -0700 (PDT)
Message-ID: <bebaa40a-1c7a-4b1e-99cd-7c7aac7c76f4@gmail.com>
Date: Thu, 12 Sep 2024 18:59:16 +0300
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
Subject: Re: [PATCH 18/20] wifi: rtw88: Add rtw8821a.{c,h}
To: Ping-Ke Shih <pkshih@realtek.com>,
 "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
References: <ade57ca1-444f-49e2-b49e-f4b9da65b2cc@gmail.com>
 <f25d00ab-4481-4540-956b-bc1028a501e1@gmail.com>
 <e365c61d730d4f49915b543dcb0063d5@realtek.com>
 <dafaac0c-fb55-4406-b8ff-69aa66d3fd06@gmail.com>
 <1aca96c68f914f90b6d1baf8780e6ce4@realtek.com>
Content-Language: en-US
In-Reply-To: <1aca96c68f914f90b6d1baf8780e6ce4@realtek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/09/2024 05:30, Ping-Ke Shih wrote:
> Bitterblue Smith <rtl8821cerfe2@gmail.com> wrote:
>> On 16/08/2024 09:06, Ping-Ke Shih wrote:
>>> Bitterblue Smith <rtl8821cerfe2@gmail.com> wrote:
>>>> +       pkt_stat->phy_status = GET_RX_DESC_PHYST(rx_desc);
>>>> +       pkt_stat->icv_err = GET_RX_DESC_ICV_ERR(rx_desc);
>>>> +       pkt_stat->crc_err = GET_RX_DESC_CRC32(rx_desc);
>>>> +       pkt_stat->decrypted = !GET_RX_DESC_SWDEC(rx_desc) &&
>>>> +                             GET_RX_DESC_ENC_TYPE(rx_desc) != RX_DESC_ENC_NONE;
>>>> +       pkt_stat->is_c2h = GET_RX_DESC_C2H(rx_desc);
>>>> +       pkt_stat->pkt_len = GET_RX_DESC_PKT_LEN(rx_desc);
>>>> +       pkt_stat->drv_info_sz = GET_RX_DESC_DRV_INFO_SIZE(rx_desc);
>>>> +       pkt_stat->shift = GET_RX_DESC_SHIFT(rx_desc);
>>>> +       pkt_stat->rate = GET_RX_DESC_RX_RATE(rx_desc);
>>>> +       pkt_stat->cam_id = GET_RX_DESC_MACID(rx_desc);
>>>> +       pkt_stat->ppdu_cnt = 0;
>>>> +       pkt_stat->tsf_low = GET_RX_DESC_TSFL(rx_desc);
>>>> +       pkt_stat->bw = GET_RX_DESC_BW(rx_desc);
>>>
>>> More and more chips use these macros. Please add a patch using struct to
>>> access these fields. More, query_rx_desc() are very similar across chips,
>>> please move them to mac.c or phy.c as a common function.
>>>
>>
>> Why not rx.c?
> 
> Also fine to me.
> 
>>> Can you collect undefined register addresses? I can try to lookup them in one go.
>>>
>>
>> Here are the addresses I could find and a few bits/bit masks:
>>
>> 0x765
> 
> #define REG_GNT_BT 0x765
> #define BIT_PTA_SW_CTL GENMASK(4, 3)
> 
>> 0x90c
> 
> #define REG_DAC_RSTB 0x90c
> 
>> 0x978
>>         31, 0x03ff8000, 0x000007ff
>> 0x97c
>>         31
>> 0x980
>> 0x984
> 
> #define REG_IQK_COM00 0x978
> #define REG_IQK_COM32 0x97c
> #define REG_IQK_COM64 0x980
> #define REG_IQK_COM96 0x984
> 
>> 0xa0a
> 
> #define REG_CCK_PD_TH 0xa0a
> 
>> 0xc00
>>         0xf
>> 0xe00
> 
> #define REG_3WIRE_SWA 0xc00
> #define REG_3WIRE_SWB 0xe00
> 
> (0xc00 page for path A, 0xe00 page for path B)
> 

Previously, you called 0xe00 REG_HSSI_WRITE_B. Are both names correct?
(I'm not sure why I put 0xc00 and 0xe00 on the list if you already gave
them a name.)

>> 0xc5c
>> 0xe5c
>>         GENMASK(26, 24)
> 
> #define REG_CK_MONHA 0xc5c
> #define REG_CK_MONHB 0xe5c
> 
>> 0xce8
>>         31, 0x3fff0000
>> 0xee8
> 
> #define REG_INTPO_SETA 0xce8
> #define REG_INTPO_SETB 0xee8
> 
>> 0xd00
>>         10, 11, 12, 0x07ff0000
> 
> #define REG_IQKA_END 0xd00
> 
>> 0xd40
>>         10, 11, 12
> 
> #define REG_IQKB_END 0xd40
> 
>>         GENMASK(26, 24)
>> 0xe80
> 
> #define REG_TXTONEB 0xe80
> 
>> 0xe84
> 
> #define REG_RXTONEB 0xe84
> 
>> 0xe88
> 
> #define REG_TXPITMB 0xe88
> 
>> 0xe8c
> 
> #define REG_RXPITMB 0xe8c
> 
>> 0xe90
> 
> #define REG_PREDISTB 0xe90
> 

I put 0xe90 on the list by mistake. We already have a name for it
in the official driver:

./include/Hal8812PhyReg.h:66:#define rB_LSSIWrite_Jaguar                        0xe90 /* RF write addr */

I translated that as REG_LSSI_WRITE_B. Is REG_PREDISTB also a valid
name? Do we need both names?

>>         7
>> 0xe94
> 
> #define REG_INIDLYB 0xe94
> 
>>         0
>> 0xec4
>>         18, 29
> 
> 
> #define REG_BPBDB 0xec4
> 
>> 0xec8
>>         29
> 
> #define REG_PHYTXONB 0xec8
> 

Some of these names are very different from their counterparts
from page C. In your previous email you said:

> I think we can reuse existing definitions:
>
> rtw8723x.h:#define REG_OFDM_0_XA_TX_IQ_IMBALANCE        0x0c80
> rtw8703b.h:#define REG_OFDM0_A_TX_AFE 0x0c84
> rtw8723x.h:#define REG_OFDM_0_XB_TX_IQ_IMBALANCE        0x0c88
>
> #define REG_TSSI_TRK_SW 0xc8c
>
> rtw8821a.h:#define REG_TXAGCIDX                         0xc94

Can we reuse these definitions?

>> 0xecc
> 
> #define REG_IQKYB 0xecc
> 
>> 0xed4
> 
> #define REG_IQKXB 0xed4
> 
>> 0xf008
>>         3, 4
>> 0xf050
> 
> I can't find these two, but just follow comments above.
> 
> #define REG_USB_MOD 0xf008
> #define REG_USB3_RXITV 0xf050
> 
> 
>>
>> And some RF registers: 0x8, 0x58, 0x65, 0x8f
>>
> 
> #define RF_DTXLOK	0x08 (already existing)
> #define RF_TXMOD	0x58
> #define RF_TXA_PREPAD 0x65
> #define RF_RXBB2 0x8f 
> 
> 
>> [...]
>>
>>>> +
>>>> +const struct rtw_chip_info rtw8812a_hw_spec = {
>>>
>>> Is it possible moving 8812a to individual file?
>>> Since you have rtw8812au.c and rtw8821au.c.
>>>
>>
>> I think it is possible. But most of the code is common to both chips.
>> Only the IQ calibration could be moved.
> 
> Yep, depend on how much IQK code echo chip has.
> 

The IQ calibration for RTL8812AU is about 700 lines.

>>
>> Another possibility is to move rtw8812au.c into rtw8821au.c and have
>> only one module handle both chips.
> 
> Prefer two modules as was. That is clear to people we have two chips. 
> 

