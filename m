Return-Path: <linux-wireless+bounces-28910-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id ADB55C57AE4
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Nov 2025 14:34:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id E717B341E1E
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Nov 2025 13:32:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D57418024;
	Thu, 13 Nov 2025 13:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KdcCc1UE"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3130F610B
	for <linux-wireless@vger.kernel.org>; Thu, 13 Nov 2025 13:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763040745; cv=none; b=Pda7hjM5DEnXlCV/zzv3gribaAQ1oLa+E4PIVodqcojSaogOR0AmSD8Xb0tFeAwlphkrgQ49kzkVLqjYntC/kaz/+dAnadLLrFKQQQf8/TEDdOIBY6qcvFBJBy6lwUvZt39c4nkKPZt6emFcnJngy4s0eRjxRIt0ZvcLaL6/Uys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763040745; c=relaxed/simple;
	bh=tx3gG/F+SBdYg9JNpvjlOJg9JYoEHxV4XglDx5yImNs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FEYZVUnYQSVLll4XrA5liCyHx4F+1dUypPEkiLiwk+zmq2iCQeTSXVKI4EPwGgrGCgXjK4+lRMTDu6bHfS8UDmTrXKSOS/Jo9f/wJqNV5nazOTvxhBI/lvsaisZkdAgc7z2XkVIEwgvezycP4bqPnmzEpXQrIgayus6JyaFbbh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KdcCc1UE; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-b70bee93dc4so109516666b.3
        for <linux-wireless@vger.kernel.org>; Thu, 13 Nov 2025 05:32:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763040741; x=1763645541; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5XLzdnXS0VqTSsSsqQo1Q5qaxn9F62gkjz5TRrZp300=;
        b=KdcCc1UEcow6cmPx0mTP5X+Hn3+zAPcRwqVP7mjT5FFw40uZ6xmbrXwjj61KU40uB2
         hmPtygPA+bFISnRIv3SBlWnwAWu2+G+ChzgOqA1D7hEPiqzfYq4qdVap0xlgwcD+vv3B
         Y6Bks/8EPIeqjtQJOpTrCXbrDtcc8Gccg4fVsHvSUv0P/SRfSzdjZ1UuUoEDMOCMnrkj
         3HZ9UrVIxGRFnsqL4zhdaJ8gP/wRzdFark5MWWJ4HIw272GmAS8x5R2BQruslZ5DUB+m
         ez/vBEU6gl789N8iJmhwc1B82XLFH5UoRp7m66Czs0tL5HIVWJljJ3xz+TINblqA1DYL
         +Dtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763040741; x=1763645541;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5XLzdnXS0VqTSsSsqQo1Q5qaxn9F62gkjz5TRrZp300=;
        b=FJfGvO5E4skaw06dtik93thWJwoI/HkbvX7/448Nn82wsBpp5VqiUIrUuVr9zUVyS+
         7G/SaxUFEjbYT/4QokUBC2P+xgVjGLnrhRlrEKlub6x2bb+jfxWGhbBOrUaq1haMDxvx
         B183cvaMiBSRV2wa+/TVOvmxjVeqezzDSQDMUKbYFTZQjMofa2wATp+cYYwwt77WUwCc
         df3B1X8tvNGsvRMJy8nD7ZhSuLLCDVT+0G+e6gGw9O2qi+FIgBhWGNl2lpeVfdUhioLP
         CRMGFhLfIiJ1ZcknF86+BrrEShHEAALIqHsCFYPbWRgTN5fbaXSDMLfVag6jdxOP3AHO
         0v6g==
X-Forwarded-Encrypted: i=1; AJvYcCUT1PQAO8n6ipC83i+GLOIgZiGs5RNuiichLRl3StuhfHxBq+LkGCAEiwIpYayBiGrjKBd2o3nOk2s2mLoLcg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxjxo+cRJiY25hTAEVMwZkKwOfcGDSxhW0R2oD672Jlj+0oYONp
	Gsquw4SnrOVHmfSOj5hzwPStwlH+hn7We5gA12IA2MPZT0ElNr1llDjqF8oSPw==
X-Gm-Gg: ASbGncsszdZsQh4StsKb6PwldlV0iQykemS8fJHTo0U6XfsSue2Ci5pN5wwPTAjf06+
	n6pqzp7n82peHWVFa3tt9Vqt8zhA0DPsKBWj/q2UdH8VgWDxGK4kNoUroDg87fFh5R20bJqq7ha
	f1NIF4FRa/xJFdmYcJR83WLA1GMYUW+VPo7RkRSHoAfQFKx1X18x8h1qf2NJxxdo3eq/kSq0LfU
	K80BvRgZLyBUNEhQ5SJ6U1LQ86ILzcczGPyg9s9chAdS148KG7hzincfIgW7BUcNdvG10ELn0Kb
	1MNPx7EtZf0EBg3PF6aJcVxoHSAZpTZPCkhx7DWqMmS81SxNnOkpihGPI/S6uvpdwTlZ0uaAuFb
	BinzQ6prMAzpPOttQAadwC0YisHX6vj+KBTvza7f7Akm7U2Z/T4rqpea6XZ6GzE/6jEEPZ5PcLL
	AWXja/z3A5IKGW9egyZaE=
X-Google-Smtp-Source: AGHT+IF5HJ0wHEU6Q3pQ9TmrpjBp+0qwo/Sh2rqF8lpebVsxfiTN44If7L828n2v0YNeF+tt1QeANw==
X-Received: by 2002:a17:907:3f8a:b0:b72:5d9c:b47b with SMTP id a640c23a62f3a-b7331a70c25mr602843566b.36.1763040741225;
        Thu, 13 Nov 2025 05:32:21 -0800 (PST)
Received: from [192.168.1.50] ([79.119.240.87])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b734fdac50csm161429866b.61.2025.11.13.05.32.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Nov 2025 05:32:18 -0800 (PST)
Message-ID: <92a76505-7b2a-4eda-9645-edf81a1f1cd4@gmail.com>
Date: Thu, 13 Nov 2025 15:32:15 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH rtw-next 06/14] wifi: rtw89: mac: update wcpu_on to
 download firmware for RTL8922D
To: Ping-Ke Shih <pkshih@realtek.com>, linux-wireless@vger.kernel.org
Cc: gary.chang@realtek.com
References: <20251113025620.31086-1-pkshih@realtek.com>
 <20251113025620.31086-7-pkshih@realtek.com>
Content-Language: en-US
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
In-Reply-To: <20251113025620.31086-7-pkshih@realtek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 13/11/2025 04:56, Ping-Ke Shih wrote:
> The RTL8922D does more settings before downloading firmware, so add them
> accordingly. Also, update the missed settings for RTL8922A.
> 
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
> ---
>  drivers/net/wireless/realtek/rtw89/mac_be.c |  7 +++++++
>  drivers/net/wireless/realtek/rtw89/reg.h    | 23 +++++++++++++++++++++
>  2 files changed, 30 insertions(+)
> 
> diff --git a/drivers/net/wireless/realtek/rtw89/mac_be.c b/drivers/net/wireless/realtek/rtw89/mac_be.c
> index c3620db8aff6..33e39191b7c3 100644
> --- a/drivers/net/wireless/realtek/rtw89/mac_be.c
> +++ b/drivers/net/wireless/realtek/rtw89/mac_be.c
> @@ -458,6 +458,7 @@ static void set_cpu_en(struct rtw89_dev *rtwdev, bool include_bb)
>  
>  static int wcpu_on(struct rtw89_dev *rtwdev, u8 boot_reason, bool dlfw)
>  {
> +	const struct rtw89_chip_info *chip = rtwdev->chip;
>  	u32 val32;
>  	int ret;
>  
> @@ -479,6 +480,7 @@ static int wcpu_on(struct rtw89_dev *rtwdev, u8 boot_reason, bool dlfw)
>  
>  	rtw89_write32(rtwdev, R_BE_UDM1, 0);
>  	rtw89_write32(rtwdev, R_BE_UDM2, 0);
> +	rtw89_write32(rtwdev, R_BE_BOOT_DBG, 0x0);
>  	rtw89_write32(rtwdev, R_BE_HALT_H2C, 0);
>  	rtw89_write32(rtwdev, R_BE_HALT_C2H, 0);
>  	rtw89_write32(rtwdev, R_BE_HALT_H2C_CTRL, 0);
> @@ -493,6 +495,11 @@ static int wcpu_on(struct rtw89_dev *rtwdev, u8 boot_reason, bool dlfw)
>  			  B_BE_WDT_WAKE_PCIE_EN | B_BE_WDT_WAKE_USB_EN);
>  	rtw89_write32_clr(rtwdev, R_BE_WCPU_FW_CTRL,
>  			  B_BE_WDT_PLT_RST_EN | B_BE_WCPU_ROM_CUT_GET);
> +	rtw89_write32_clr(rtwdev, R_BE_SECURE_BOOT_MALLOC_INFO, 0);

This doesn't change the value of the register. Did you mean to use
rtw89_write32() ?


