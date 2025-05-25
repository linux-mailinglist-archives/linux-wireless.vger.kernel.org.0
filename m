Return-Path: <linux-wireless+bounces-23391-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 063C7AC3727
	for <lists+linux-wireless@lfdr.de>; Sun, 25 May 2025 23:57:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B470B173E3D
	for <lists+linux-wireless@lfdr.de>; Sun, 25 May 2025 21:57:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8072619DF8D;
	Sun, 25 May 2025 21:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BFB7SxlZ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBE41163
	for <linux-wireless@vger.kernel.org>; Sun, 25 May 2025 21:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748210246; cv=none; b=JU9AF3ibK4Or2bGraejv7BCAsvn9m79Flj2klBiu3GvGVR6G11WhhXdXB99yQpLfgCEwjd3sE992DiBSoHECaQQ1RYHfztstKQ/Uhuerp0zYv2R4sU2Abfa4PLL4Z7lxL0c9QySQDiUBy/liUc9WDyZo/D/gxUaLEe6yJBPfGLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748210246; c=relaxed/simple;
	bh=VCvUOM2XbcXzlBDck9jUkurGYGGmftHZeISXtF1ifDM=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:References:
	 In-Reply-To:Content-Type; b=fc+oQf9lWTp5HY08XZn7//22LrEiWmVGpJjXgyweQiUH3axXCKR7tVELyg1Mgjt0JNo0mZX6ts46gs/oA8nnEp7dHCFxpZH+R7aQT/fa76kU5bs1zuFA9Zi83SBpl4psxK8xukGVLaaZj6hQ/HtOcY3+fL/xohCt9eB2yn+u9mw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BFB7SxlZ; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-acb5ec407b1so274065166b.1
        for <linux-wireless@vger.kernel.org>; Sun, 25 May 2025 14:57:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748210243; x=1748815043; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :to:subject:from:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zbqCCyShbXg2tcW7R0v4z3ChMlJ6ZzT/9DsTVHD/QQ4=;
        b=BFB7SxlZpJ2fWl3Kmh+PbQj2uuWXZIPwg443OHfgA7B+EOFNjBsVDB9KckMzq8IFON
         FVTuT77JagDhiTGBqnfPIkoF0a2HX7EXVIetz47bNtmV+cVZbpyEdHIYLt3M3KvV9QFv
         oyi4xbA7t1xZWoyEzcCzMHXMiB3/zfCQBm5kHdsgrsDgjXgIuRqHfr7Fila/z4jVvCVE
         P0Iz5ZNXOAuQYqafZmiRM40jXF1AXS/BhewFNJ6DBJ0MiCExOZTQRla6n2Ls6YUQ2jRM
         p4CpGV5BVFkJz+IV3cVjiJ/tZW2ddSyycb3EGeWNSfrRNnyyTBEciYg7Gn3Vt4LXyEyW
         bNJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748210243; x=1748815043;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zbqCCyShbXg2tcW7R0v4z3ChMlJ6ZzT/9DsTVHD/QQ4=;
        b=K5s6W8CYm66buPj2bFkRhxqhHIf1h134xCYj2QXbdGWZd2na3baWPsrKS/C8OIob3X
         eV/UxsrVNxB+9gZWzlJj0nRidvGLPiDV2aRFdiTSrdrF6DDq4MuowO/RPxdo+tYXEUuc
         nysfbE7phOWTXpbjd+oENFUl6Jnx63mYG9+xZ9QYmCouBXqCneqt+OoNFXKwQCcBrXyE
         pnrn/6KN/QnCMF/p7KctgSdFJis4+7UQlmW+3hBHA1X0KsteQIG4Bn3jk9URvlq+4ED9
         RZ3kHIxepKCWw7walqPJ2lUQ0s7F3gugRQBmqp8d6a4CctEIJvg23zxfaVSxbcrQI5qE
         TW+w==
X-Forwarded-Encrypted: i=1; AJvYcCVLeya2s14cUMJ11lRTyw+8jipm3Ao1a5zrvwQNf4A7F6denxCtZAqoPYUS8Tvl3hyDStIRAFIb5JOocKWc3g==@vger.kernel.org
X-Gm-Message-State: AOJu0YyeZGCcsiib2B0FQZ5htG7vClBH/fyfk9NQNiyzBGuW4PERmPdS
	Ve4OXFngWexqZdoKY/ekPw/nJaEDf5yhv8wtrbAI/wGVl4SqV0GYJNiqSej/zg==
X-Gm-Gg: ASbGncvjl+p04m+u7e1i7OapDTYpQyGDEMHK7qmFU+4+JW7qKpbRkH5YGgOy2lkw0zn
	ZeVIQVbfZYx0NIg4NP2+PDveh+l+IyfRNR9H7hqqBdw064nretr+TVYYc8KHPgrCchopAmPsKD7
	i0AV3/HJXlpqoE7WaA5I9G1FxUSpDKw9tK43n6gd8Rf/mwy0xQbI53pj9pNSGq2cNAfTnNP7JX0
	NabWEQtPzkVzqNZDXcBB/aR/Kgf+t06SZ+TOlBE0rILGRGGoFX6zKUZlSPBTcfwAac3WyVblVor
	B5A4iqHBYoJeC9MJQQDaF44hhPiPmKir+ye/8sSFx948J+SgUljD31d3qFQ=
X-Google-Smtp-Source: AGHT+IEfH2r/VtHfqt7SbYAAALwnYLPNGKRMI8uBv4ycfUjwaFrszNimEtAPXtn3qDzguD9/T8qE3Q==
X-Received: by 2002:a17:907:1b02:b0:ad2:3f54:1834 with SMTP id a640c23a62f3a-ad85b2d76b7mr595615366b.40.1748210242980;
        Sun, 25 May 2025 14:57:22 -0700 (PDT)
Received: from [192.168.0.50] ([79.119.240.16])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ad52d04e821sm1593578866b.17.2025.05.25.14.57.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 25 May 2025 14:57:22 -0700 (PDT)
Message-ID: <2ce556de-7ccb-4c6e-be09-da1d3e8d8274@gmail.com>
Date: Mon, 26 May 2025 00:57:21 +0300
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
Subject: Re: [PATCH rtw-next v1 06/13] wifi: rtw89: Disable some power saving
 for USB
To: Ping-Ke Shih <pkshih@realtek.com>,
 "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
References: <b146b670-d91c-41a7-96f0-c37945040aea@gmail.com>
 <c64fe6a4-b48c-4a80-9d6c-5c90fb7f7bbd@gmail.com>
 <8350f850345248b4bcef32204c944168@realtek.com>
Content-Language: en-US
In-Reply-To: <8350f850345248b4bcef32204c944168@realtek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 13/05/2025 06:27, Ping-Ke Shih wrote:
> Bitterblue Smith <rtl8821cerfe2@gmail.com> wrote:
>> Disable rtw89_ps_power_mode_change() and rtw89_mac_send_rpwm() for
>> USB because they are called in atomic context and accessing hardware
>> registers results in "scheduling while atomic" errors.
> 
> I feel rtw89_ps_power_mode_change() should be not in atomic context.
> Please check this. 
> 

I think you're right, only rtw89_mac_send_rpwm() is called in atomic
context. rtw89_ps_power_mode_change() is disabled for other reasons:

1) It calls rtw89_mac_power_mode_change(), which prints errors when
rtw89_mac_send_rpwm() is disabled.

2) With RTL8852CU it calls rtw89_ps_power_mode_change_with_hci()
which calls napi_schedule(). That results in dereferencing a null
pointer.

>>
>> Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
>> ---
>>  drivers/net/wireless/realtek/rtw89/mac.c | 3 +++
>>  drivers/net/wireless/realtek/rtw89/ps.c  | 3 +++
>>  2 files changed, 6 insertions(+)
>>
>> diff --git a/drivers/net/wireless/realtek/rtw89/mac.c b/drivers/net/wireless/realtek/rtw89/mac.c
>> index a316864ad137..1a03355b340f 100644
>> --- a/drivers/net/wireless/realtek/rtw89/mac.c
>> +++ b/drivers/net/wireless/realtek/rtw89/mac.c
>> @@ -1338,6 +1338,9 @@ static void rtw89_mac_send_rpwm(struct rtw89_dev *rtwdev,
>>  {
>>         u16 request;
>>
>> +       if (rtwdev->hci.type == RTW89_HCI_TYPE_USB)
> 
> I think SDIO devices have the same problems as USB, so I prefer to return
> if "!= PCIE".
> 
>> +               return;
>> +
>>         spin_lock_bh(&rtwdev->rpwm_lock);
>>
>>         request = rtw89_read16(rtwdev, R_AX_RPWM);
>> diff --git a/drivers/net/wireless/realtek/rtw89/ps.c b/drivers/net/wireless/realtek/rtw89/ps.c
>> index ac46a7baa00d..edff9f8e1016 100644
>> --- a/drivers/net/wireless/realtek/rtw89/ps.c
>> +++ b/drivers/net/wireless/realtek/rtw89/ps.c
>> @@ -56,6 +56,9 @@ static void rtw89_ps_power_mode_change_with_hci(struct rtw89_dev *rtwdev,
>>
>>  static void rtw89_ps_power_mode_change(struct rtw89_dev *rtwdev, bool enter)
>>  {
>> +       if (rtwdev->hci.type == RTW89_HCI_TYPE_USB)
>> +               return;
>> +
>>         if (rtwdev->chip->low_power_hci_modes & BIT(rtwdev->ps_mode) &&
>>             !test_bit(RTW89_FLAG_WOWLAN, rtwdev->flags))
>>                 rtw89_ps_power_mode_change_with_hci(rtwdev, enter);
>> --
>> 2.49.0
> 


