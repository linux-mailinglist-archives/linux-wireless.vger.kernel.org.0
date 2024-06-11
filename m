Return-Path: <linux-wireless+bounces-8795-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B5C0E903D6F
	for <lists+linux-wireless@lfdr.de>; Tue, 11 Jun 2024 15:33:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B476A1C222CE
	for <lists+linux-wireless@lfdr.de>; Tue, 11 Jun 2024 13:33:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60B9117BB35;
	Tue, 11 Jun 2024 13:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VV2TnHwE"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2E11176AB8
	for <linux-wireless@vger.kernel.org>; Tue, 11 Jun 2024 13:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718112805; cv=none; b=jR6nHs8R5S/llI5asnCy/wRTz8eAft/aOcRojeIO/Qzel/qoLpeOcXdKjhuZBshz4+4pU1Q0PItP4xf6jAZlyKlIiDWVDlnoBbuOfGRBZKw2J/2Mp+gaLPLXhnkX4PSzw93igZsFP9AtVCzrpbroF7CK0TvW7KL/nUCVSTytzGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718112805; c=relaxed/simple;
	bh=//I627wsBxkR/EzarKKhc7J/HuUZ/n1Myg7E61V3Pls=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kE9U04NXR6W8W1XxCKAWFhBs58XRBl29AjZUwxZuAT5hAlYjfZPV82OMOFD0xmbQiRhlw5WXNEAWW7Y6J/bkwJZaA/CGzowtvXFZrHSq3ll9r6mEfbAL52NGQwMkwOQkM8Lwdsy81fMFPyp8uAbTZ5AyAdi5aMwjMNGA4mHK7RU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VV2TnHwE; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a6f04afcce1so129469866b.2
        for <linux-wireless@vger.kernel.org>; Tue, 11 Jun 2024 06:33:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718112802; x=1718717602; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wxNjVxKryxYJ0ZHKxUmIcnUZafXmjHO2bXDVcnTmwtE=;
        b=VV2TnHwEFSMagD1yRn7civCszLlwPfVBKF2UtFgZBpNy0lRWEjyCDGYwiN+3mD8oN5
         m9PDI6NclFcNtwIWWqbVQzfqjVc6tALb9cA6drc7ol1+pKdsVafTmbCXFDc1LZxZOMuc
         1J2fWMvfeK0YpQtHPs2PJDAsofQ1IbiuCs0tS3i38VmuO7lfT3T6CHwJ/V6RZSOa4uAw
         bHz4jSZrQQiczvf6Bj5SZ781H4l7w51IWvdLNkslxUDnQh8w1qKmmzjDlMEhzWMUjmHF
         Bx4QvLydCNaCiUwfZWNP6FLMaCo6K2d6+jK/yUXYJVeoKzbuciLjQ2XCCCXlgSnIh1fl
         Kn/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718112802; x=1718717602;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wxNjVxKryxYJ0ZHKxUmIcnUZafXmjHO2bXDVcnTmwtE=;
        b=fWg0cVf/2aVvLAimxrzDjNz+J0HWq1Sl2i8hi/ZynaB5nQjq0SBKIFnV4XAR/BD6rw
         coxnrTlF7qq3d8YesK2SS8b3vldG4SguK+7YWxmX8ybLr4Z8P7caIp9+bc4YKdpbOneN
         ePKfB82V/NxC21X0MY1y44uKmoOyQMil4VhgLDYyuLk/3mhWZnIEFI0Qj+ZLSfHFSkHf
         zvGnTvRjmahguVW8qFIE4uOXwGFTiMPD1MYM45kRyZiPMnc9KAG5pBzqQZ4IlfbHgxsq
         H84oagaA3KHB+u99k0YhP2mzRnXRClcGGCigJIXsAF267cuHBrTiXwyfIRMQeHGmkW79
         OL8Q==
X-Forwarded-Encrypted: i=1; AJvYcCW5ZtUOeto2FuVtVRTndFc7LexmszCQopftUXJb3u58/kYo3S4yVvhLWXoMAwQIdWHP5i2VawnNsjJJWCGGT+FlDuje+wQHUouEPBTgp/c=
X-Gm-Message-State: AOJu0YwqzubUUV/XDdUsS/LkbCfMyh4yCfxmT48/+EY6Q9aGWkDZqePD
	0gvmf4NlB100UmupTyVhdl39J/xjkdARLtZbe8b9SqFJZ8ObkiXB
X-Google-Smtp-Source: AGHT+IHZyUXZY8oOXdFKXsh+PcwBGmQSvSIOVjFzOCDJfME8FlUFFaAeutgTEHXQpGtcafecKWy6Lw==
X-Received: by 2002:a17:906:b4a:b0:a6f:2994:e0e9 with SMTP id a640c23a62f3a-a6f2994e273mr398573366b.33.1718112801676;
        Tue, 11 Jun 2024 06:33:21 -0700 (PDT)
Received: from [192.168.1.50] ([79.119.240.235])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6f2195a2a3sm224556066b.99.2024.06.11.06.33.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Jun 2024 06:33:21 -0700 (PDT)
Message-ID: <6ea2dd8b-fe9e-4434-b502-5badfe547c1f@gmail.com>
Date: Tue, 11 Jun 2024 16:33:19 +0300
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] wifi: rtw88: usb: Further limit the TX aggregation
To: Ping-Ke Shih <pkshih@realtek.com>,
 "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: Sascha Hauer <sha@pengutronix.de>
References: <0996d2d0-e7b8-4e43-ba12-63074ba9df1b@gmail.com>
 <dfb019b6-4285-4381-86d2-d85409abee4b@gmail.com>
 <3fedc4d56ac3414e8e500961b9850aa1@realtek.com>
Content-Language: en-US
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
In-Reply-To: <3fedc4d56ac3414e8e500961b9850aa1@realtek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/06/2024 06:26, Ping-Ke Shih wrote:
> Bitterblue Smith <rtl8821cerfe2@gmail.com> wrote:
>> @@ -2065,25 +2066,26 @@ const struct rtw_chip_info rtw8703b_hw_spec = {
>>         .bt_rssi_type = COEX_BTRSSI_RATIO,
>>         .ant_isolation = 15,
>>         .rssi_tolerance = 2,
>> -       .bt_rssi_step = bt_rssi_step_8703b,
>> -       .wl_rssi_step = wl_rssi_step_8703b,
>>         /* sant -> shared antenna, nsant -> non-shared antenna
>>          * Not sure if 8703b versions with non-shard antenna even exist.
>>          */
>>         .table_sant_num = ARRAY_SIZE(table_sant_8703b),
>> -       .table_sant = table_sant_8703b,
> 
> Not sure why you move array and array size apart. 
> No need to churn this as well as other similar stuffs. 
> 

I thought you wanted the members initialised in the same order
they appear in struct rtw_chip_info in main.h. Maybe I misunderstood.

> This patch can only change things required by what subject mention. Align these
> fields by another patch, or do it later. Both are fine to me. 
> 

Ah, it should be done in a different patch, okay.

I'm still not sure what you meant here:

>> diff --git a/drivers/net/wireless/realtek/rtw88/main.h b/drivers/net/wireless/realtek/rtw88/main.h
>> index 49894331f7b4..49a3fd4fb7dc 100644
>> --- a/drivers/net/wireless/realtek/rtw88/main.h
>> +++ b/drivers/net/wireless/realtek/rtw88/main.h
>> @@ -1197,6 +1197,8 @@ struct rtw_chip_info {
>>         u16 fw_fifo_addr[RTW_FW_FIFO_MAX];
>>         const struct rtw_fwcd_segs *fwcd_segs;
>>
>> +       u8 usb_tx_agg_desc_num;
>> +
>
> Please keep order of field and instance declaration, like rtw8703b_hw_spec.

and here:

>>  #define REG_DWBCN0_CTRL                0x0208
>>  #define BIT_BCN_VALID          BIT(16)
>>  #define REG_TXDMA_OFFSET_CHK   0x020C
>> diff --git a/drivers/net/wireless/realtek/rtw88/rtw8703b.c
>> b/drivers/net/wireless/realtek/rtw88/rtw8703b.c
>> index 8919f9e11f03..222608de33cd 100644
>> --- a/drivers/net/wireless/realtek/rtw88/rtw8703b.c
>> +++ b/drivers/net/wireless/realtek/rtw88/rtw8703b.c
>> @@ -2013,6 +2013,7 @@ const struct rtw_chip_info rtw8703b_hw_spec = {
>>         .tx_stbc = false,
>>         .max_power_index = 0x3f,
>>         .ampdu_density = IEEE80211_HT_MPDU_DENSITY_16,
>> +       .usb_tx_agg_desc_num = 1, /* Not sure if this chip has USB interface */
>
> The position to declare this field is very different from others. 
> 
> Not sure when we messed up the order, but please don't feel free to add one,
> keep the order.

