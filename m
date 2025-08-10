Return-Path: <linux-wireless+bounces-26236-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5186EB1FC6F
	for <lists+linux-wireless@lfdr.de>; Sun, 10 Aug 2025 23:37:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F27FE3B5A82
	for <lists+linux-wireless@lfdr.de>; Sun, 10 Aug 2025 21:37:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B75FF1DE3CA;
	Sun, 10 Aug 2025 21:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cqtj0NrH"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5AD029AB03
	for <linux-wireless@vger.kernel.org>; Sun, 10 Aug 2025 21:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754861860; cv=none; b=jVI7Mc+cCL2yIufZtdrRDCQPP5zUSxX7RH8XkWMMGFJeMLztiJUCSBDHMSk2g6q+CQ+XKh2tZqjGwfOey6RiX1KAuXmrHaEXvDPabElOPRW7NUWeVxMbWeyhIDsfS3GQ5VFxojNeVo8312VSt8cR5j4nXfs73mDfd6SEEzp4e2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754861860; c=relaxed/simple;
	bh=mohnObLtzO6pWp20UWwLGjG95OuVkRSv+CLJKVJkNL8=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=CX2V/pUuH5m2o5uaQw8FCHPZ5CZWwUCaJE5sX6K0LtWr1k5K8l/PWylOy/YvEbg1Y5WGqMCe5DtPFGFYlikPWD7fMRiG5VCULohjwe/VvrP3Bcr0iSmMghJjTqUm3tlXIt7pPAQMg5CXvYYeXASWxMab0ceAoeR5vFMiYfPlzv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Cqtj0NrH; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-3b783ea5014so1937827f8f.0
        for <linux-wireless@vger.kernel.org>; Sun, 10 Aug 2025 14:37:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754861855; x=1755466655; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xsh8obCjyV9PwQBu5Kk1mifti1pdmxuSaMMmc9rCI4o=;
        b=Cqtj0NrHJ5LPnW6p/w7Hvu7VSZOmDiXhLiETFkccm3zrej0X1DZAJ+XhXlhFQjf3L8
         GsIjyBQzH/41xWLI8qpvsfO3XaGbadbircnNQpaoQYpDu6MaRJMePqWftfEUssT1RyfU
         yiyi0Q04mVrXXzZrnIxN1k/UVT/1YggD2vHRIm7pzsPgyLliFlulF8PNsYuDni3vB8bd
         2b2HLc3+JjPILDOcRNFov2SlSDZVaGZ/iphhXpAU8SSpPzN5VjW5yDVQt4E0a3250VAF
         l74YYX0wZbSbFZlK4hGvuk1zjVVQS21iran2iUj07Sem25TGefga1mBLFJ3vhW9svJim
         aFWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754861855; x=1755466655;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xsh8obCjyV9PwQBu5Kk1mifti1pdmxuSaMMmc9rCI4o=;
        b=fyZAka+rudIo9I7BW3wp18O/b34UwNbDX5f/gns4UEGqcYOg2rBzEgPP0+kEz9M7Xm
         ZYfYiK1lw+X7DNYXYN03bv5VUPckcSHP5NDQxn6jTE6seAlcZM70gV8PIj8cTCFenEIF
         MDgpg2hGQE7vCmaX9dgnc3cRwZOggcDXipmDFuiyDlEGufoDKe8NQp3IjPdUKvMX5eh+
         Y77WCOUNCFSL7jvSYRpJpTfyoKAAydlwfo1ZH6KY/ZjKK4CtwcXBUBop5BIgdyuCxVnR
         LKRQ863k5l8Dr5Z3NuX1ZdptFEU0urUcHZtBFtxi9iY6DjidMPDu9MomL/8H/05ew+7r
         ZYUw==
X-Forwarded-Encrypted: i=1; AJvYcCUaOFjbdupFu+tS6W++UXTM0iZsvTdy5SgqxOYrbIcYl5KEv6D01nNbwswpv03nA2VHKpLT6bV4DGReuZBTxw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzD5y982L3t9QVlxGjH9WS7OThrWw7fdx4orcrEfp81FYuGo7vk
	obK9aC8AkYVnvBsIJnpPRqmwSSl8SbEw1J0Bm0hACQsSczN9ptI/VyFnu0FJAg==
X-Gm-Gg: ASbGncslEavj1LCThjj17Run45+XA2LZFyMzbSY752roxEBf//OF8zv3tHL+NAPxQMw
	UFnftRiGf0xqEPancziti3oFJIkBAYlrnqCu+lEPep7HTUxJJVloAoMDItQh2JMUb+w6zguVebr
	zGcM3dH/F1euly+mkSSyY8+/jsSs9tiLsOuHEVz7pG4xtMerL/6MNAHdHFERzIOyEaSO6MM8G6a
	BvkliWKMJE/XtR24B9HLGR3g/iyFLy0myMvFx6lZXu3SC+BJUD7lWB933Ow9HDn9NutFWeNJrIe
	FVQGSGefck4JyXczyVnBcBd80itGH8ck43ROGtwDuX9SCS5y453RXqkjdoRotawAgYoYVc/q+KZ
	me8wtm2YzDBDSDjQVCAielHjXaVT0IgTjZ34qL/f4
X-Google-Smtp-Source: AGHT+IEpIra0hrrWIcaxhC3VRNx+sHn5cGdnGaH2VpruK3Oc/Ga/JinEm8wKcRsJ2R+x924+TIuqeQ==
X-Received: by 2002:a05:6000:2905:b0:3b7:9c79:32bb with SMTP id ffacd0b85a97d-3b900b54fb7mr8884967f8f.44.1754861854774;
        Sun, 10 Aug 2025 14:37:34 -0700 (PDT)
Received: from [192.168.1.50] ([81.196.40.253])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b8e1cb7deesm28249144f8f.2.2025.08.10.14.37.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 10 Aug 2025 14:37:33 -0700 (PDT)
Message-ID: <de899380-fe3c-4b9e-86cf-3677fb0b4f92@gmail.com>
Date: Mon, 11 Aug 2025 00:37:32 +0300
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH rtw-next v2 01/11] wifi: rtw89: Fix
 rtw89_core_get_ch_dma() for RTL8852CU
To: Ping-Ke Shih <pkshih@realtek.com>,
 "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
References: <f4a7a1c4-3d64-4af3-bc77-b12d7c1320e7@gmail.com>
 <5b1210f3-499d-44d8-9433-7beac2a2800d@gmail.com>
 <11f3e864-7509-4e5f-86ed-997f8a9b63e9@gmail.com>
 <4203c4ab09df4975be85e341f5e24264@realtek.com>
Content-Language: en-US
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
In-Reply-To: <4203c4ab09df4975be85e341f5e24264@realtek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 05/08/2025 03:40, Ping-Ke Shih wrote:
> Bitterblue Smith <rtl8821cerfe2@gmail.com> wrote:
>> On 01/08/2025 23:51, Bitterblue Smith wrote:
>>> It seems RTL8852CU can only use TX channels 0, 2, and 8 (for band 0),
>>> otherwise the chip stops working after downloading at maximum speed
>>> for a few seconds.
>>>
>>> Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
>>> ---
>>> v2:
>>>  - No change, messed up sending v1.
>>> ---
>>>  drivers/net/wireless/realtek/rtw89/txrx.h | 19 +++++++++++++++++++
>>>  1 file changed, 19 insertions(+)
>>>
>>> diff --git a/drivers/net/wireless/realtek/rtw89/txrx.h b/drivers/net/wireless/realtek/rtw89/txrx.h
>>> index ec01bfc363da..318fd0ac8726 100644
>>> --- a/drivers/net/wireless/realtek/rtw89/txrx.h
>>> +++ b/drivers/net/wireless/realtek/rtw89/txrx.h
>>> @@ -734,6 +734,25 @@ rtw89_core_get_qsel_mgmt(struct rtw89_dev *rtwdev, struct rtw89_core_tx_request
>>>
>>>  static inline u8 rtw89_core_get_ch_dma(struct rtw89_dev *rtwdev, u8 qsel)
>>>  {
>>> +     if (rtwdev->hci.type == RTW89_HCI_TYPE_USB &&
>>> +         rtwdev->chip->chip_id == RTL8852C) {
>>> +             switch (qsel) {
>>> +             default:
>>> +                     rtw89_warn(rtwdev, "Cannot map qsel to dma: %d\n",
>>> +                                qsel);
>>> +                     fallthrough;
>>> +             case RTW89_TX_QSEL_BE_0:
>>> +             case RTW89_TX_QSEL_VO_0:
>>> +                     return RTW89_TXCH_ACH0;
>>> +             case RTW89_TX_QSEL_BK_0:
>>> +             case RTW89_TX_QSEL_VI_0:
>>> +                     return RTW89_TXCH_ACH2;
>>> +             case RTW89_TX_QSEL_B0_MGMT:
>>> +             case RTW89_TX_QSEL_B0_HI:
>>> +                     return RTW89_TXCH_CH8;
>>> +             }
>>> +     }
>>> +
>>>       switch (qsel) {
>>>       default:
>>>               rtw89_warn(rtwdev, "Cannot map qsel to dma: %d\n", qsel);
>>
>> I see now that RTL8922AU needs the same change. And same in patch 2/11
>> as well.
> 
> The coming chip RTL8922DE uses different mapping rule, so I add a new
> chip_ops:
>  
> --- a/core.h
> +++ b/core.h
> @@ -4072,6 +4072,7 @@ struct rtw89_chip_ops {
>         void (*fill_txdesc_fwcmd)(struct rtw89_dev *rtwdev,
>                                   struct rtw89_tx_desc_info *desc_info,
>                                   void *txdesc);
> +       u8 (*get_ch_dma)(struct rtw89_dev *rtwdev, u8 qsel);
>         int (*cfg_ctrl_path)(struct rtw89_dev *rtwdev, bool wl);
>         int (*mac_cfg_gnt)(struct rtw89_dev *rtwdev,
>                            const struct rtw89_mac_ax_coex_gnt *gnt_cfg);
> @@ -7428,6 +7429,14 @@ void rtw89_chip_fill_txdesc_fwcmd(struct rtw89_dev *rtwdev,
>         chip->ops->fill_txdesc_fwcmd(rtwdev, desc_info, txdesc);
>  }
> 
> +static inline
> +u8 rtw89_chip_get_ch_dma(struct rtw89_dev *rtwdev, u8 qsel)
> +{
> +       const struct rtw89_chip_info *chip = rtwdev->chip;
> +
> +       return chip->ops->get_ch_dma(rtwdev, qsel);
> +}
> +
>  static inline
>  void rtw89_chip_mac_cfg_gnt(struct rtw89_dev *rtwdev,
>                             const struct rtw89_mac_ax_coex_gnt *gnt_cfg)
> 
> Also the rtw89_core_get_ch_dma() is moved to core.c, and add
> rtw89_core_get_ch_dma_v1() for RTL8922DE. 
> 
> However, USB can use different mapping rule, so we should extend the size
> to RTW89_HCI_TYPE_NUM. Then, 
> 
>   return chip->ops->get_ch_dma[rtwdev->hci.type](rtwdev, qsel);
> 
> If you want my patch as first patch of this patchset, I can share it as RFC.
> 

Yes, that would be good.

> 
> Since this is called in data path, I'd like to avoid if-condition to save
> a little execution time.
> 


