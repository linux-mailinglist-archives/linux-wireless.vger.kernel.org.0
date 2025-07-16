Return-Path: <linux-wireless+bounces-25558-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CD18B07FAC
	for <lists+linux-wireless@lfdr.de>; Wed, 16 Jul 2025 23:32:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D41A1C42BBA
	for <lists+linux-wireless@lfdr.de>; Wed, 16 Jul 2025 21:32:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 949782EBB95;
	Wed, 16 Jul 2025 21:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aRS7DB9/"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBCE52EBDCC
	for <linux-wireless@vger.kernel.org>; Wed, 16 Jul 2025 21:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752701522; cv=none; b=JRtM1F5wE4ZrUq3xrXR9S0NyU6rbsK0TYzmM1deAqiQ4jDWpmLhg0UiUIfw65WSmTdsRVLGK8MlPIhzBkAGzEPVLMC49AXE8ufE28TnVuu6G6/Kx2RvOe6cj+eFVM0nmT+0P13KbUBQ/bURmeXUZJ+NB0l5ggkBSaJLqoOffJsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752701522; c=relaxed/simple;
	bh=WD1bZzwFyI5Fi4OzA+pYP40Yl21WGqXanjHH3MrAYfw=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=UEf5Lyfbu5WNvDpGQrBvTlwgPXwN5ZgVPG0kAaM08J6AbzZq6hF5IymaC+tZh21WEv1RYPEhkh8umnMjDusC3doSOBQAvN1mi7+PrdzZKT2YuwcA3HxeLO3g1I+wplJMZF3UyfhylPui8Zi63ASDoLqcCRoJjXB6vMAH5Dl2VTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aRS7DB9/; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-ae6fa02d8feso48005266b.0
        for <linux-wireless@vger.kernel.org>; Wed, 16 Jul 2025 14:32:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752701519; x=1753306319; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WV1UAZjH4MPVzLTWNEZMAbmjemP2og7AexIEde37b4M=;
        b=aRS7DB9/O+YXiiM4K8xgwRELpxjTcKc87PTJ4Pgt4uys4Q/qtyRjH2vcqrzFeXANBC
         pry4QqtXGqF32SEuM5vcj0N6lNUkOYn2RonIg2UgLGgK/lRhIT7pyqgYB6C6b+iDV3qQ
         0RypjX4reVrCS1IGEjLOUHhkIRAOBEHkg7qC+BC5HDu032hlc8WvJQAlquvl+J6ngF0B
         Gf1hMCnhwKfDnMZOpUEF1HloEwSz0fNZxle9dpxe55vag2jmnTDvhKmeoFjgJteZZgHr
         o0MMWPNa9YT7UNeA+3BdJ8uLQLJ/0dCtj8RsTmaglRli38FspVwYnHkW7dyecpgDY0T1
         K6RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752701519; x=1753306319;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WV1UAZjH4MPVzLTWNEZMAbmjemP2og7AexIEde37b4M=;
        b=Wrqlc3aEfS5FfOwn803bVVCeutT4BAMG5f0hhgIEcypSjkarcz3gRVNpX00lqIMK9g
         lN3kI8x++cK2S0kQXOcAYF0C+MnTQLVcGO2b0fBLOt26TnOuTVP6UQSQN+Pk9tOXSw+l
         cuViGECReXRcxJf4q9btvUliz/g4PyQ+ntAk1muzEvINjO0LaOFrRV+I6kzJV6MiPCJm
         OVzutT32tiuGWSPXkkCMd8gUpG3kuheYD+kG/cUsdkxBQ3KzhKyE9NVENhJzedaw9XHy
         nOgAKT0+d+hEDXkOartUQEwvZqKskSsUNk1uOAj6zTTUU0+GnfNWmDrlMlLyyldVAUwt
         Zm4A==
X-Forwarded-Encrypted: i=1; AJvYcCVflvLo93bI42jWfRihKT4tShtmc4e3hEAw9TgKmWBBVjPLfHWF71Z6jxHcJGbRluul698kuz65lljJQHyHiQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzVOiCWzUma+w93oHf7DZUilQpBBYuJXxxOmxj4wUA8+D+FFLdZ
	JHPIzjZhRY4kvswWWyEnkJzqG/MxEv+2bFzpwmCAxtMLck0rk0yisRwN
X-Gm-Gg: ASbGncvbNKKi/PCQxC068Ja2Ytozhlm5PCShlMDA2xf6ULAjgzGB4nCfTPdc81VXlOv
	WRHlzHbmun2EKKBcnHXFPDcRrPY8oqHlpyt61OK1Rkjj0XQ6F7yNnfH5hHS8dBhEM+aDRIuYoFT
	230aq5ACwJ9idCmRjWC+ExrFm3m323KXOZToxuC54rU5gxkhmp9d9x7uGkP5E/qHcsVKt3RLurl
	QN2YvHtZiexMQoq5sAQMpWYK2XzxIUbpIGddLGR3oCyCEshpvG2jiihwAVN2ptA2VIp9wInIrSv
	4/XaPgsG4tW2mDDElASipvfc/L8RBElW0Xn9PY7wfR8diyiPUbJJU+PryrAE5/iBQumPA6ymDS8
	Y0PgnbEGi7kIMHAccqh/BAt5oHqqMRA==
X-Google-Smtp-Source: AGHT+IH6OsV+QLFaSZthBhlxAX/hjJ9ASBrt7Xuqf3LW1JjTCAgtSgDBX7JJeRHfZVglNOKNLuQFAA==
X-Received: by 2002:a17:907:894b:b0:ae3:90cc:37b3 with SMTP id a640c23a62f3a-ae9cddddbd9mr439133966b.17.1752701518668;
        Wed, 16 Jul 2025 14:31:58 -0700 (PDT)
Received: from [192.168.0.50] ([81.196.40.253])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae6e8266992sm1234830066b.82.2025.07.16.14.31.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Jul 2025 14:31:58 -0700 (PDT)
Message-ID: <0dab5755-4801-46c4-b78d-d8d3f0cf042b@gmail.com>
Date: Thu, 17 Jul 2025 00:31:56 +0300
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH rtw-next v2 1/2] wifi: rtw89: Lower the timeout in
 rtw89_fw_read_c2h_reg() for USB
To: Ping-Ke Shih <pkshih@realtek.com>,
 "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
References: <09313da6-c865-4e91-b758-4cb38a878796@gmail.com>
 <e3db33c50a7b4729947816551c5eba17@realtek.com>
Content-Language: en-US
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
In-Reply-To: <e3db33c50a7b4729947816551c5eba17@realtek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 16/07/2025 03:17, Ping-Ke Shih wrote:
> Bitterblue Smith <rtl8821cerfe2@gmail.com> wrote:
>> This read_poll_timeout_atomic() with a delay of 1 µs and a timeout of
>> 1000000 µs can take ~250 seconds in the worst case because sending a
>> USB control message takes ~250 µs.
>>
>> Lower the timeout to 4000 for USB in order to reduce the maximum polling
>> time to ~1 second.
>>
>> This problem was observed with RTL8851BU while suspending to RAM with
>> WOWLAN enabled. The computer sat for 4 minutes with a black screen
>> before suspending.
>>
>> Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
>> ---
>> v2:
>>  - Lower the timeout for USB instead of increasing the delay.
>> ---
>>  drivers/net/wireless/realtek/rtw89/fw.c | 9 +++++++--
>>  drivers/net/wireless/realtek/rtw89/fw.h | 2 ++
>>  2 files changed, 9 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/net/wireless/realtek/rtw89/fw.c b/drivers/net/wireless/realtek/rtw89/fw.c
>> index 73a4ec988d16..b774a329e7c7 100644
>> --- a/drivers/net/wireless/realtek/rtw89/fw.c
>> +++ b/drivers/net/wireless/realtek/rtw89/fw.c
>> @@ -6755,13 +6755,18 @@ static int rtw89_fw_read_c2h_reg(struct rtw89_dev *rtwdev,
>>         const struct rtw89_chip_info *chip = rtwdev->chip;
>>         struct rtw89_fw_info *fw_info = &rtwdev->fw;
>>         const u32 *c2h_reg = chip->c2h_regs;
>> -       u32 ret;
>> +       u32 ret, timeout;
>>         u8 i, val;
>>
>>         info->id = RTW89_FWCMD_C2HREG_FUNC_NULL;
>>
>> +       if (rtwdev->hci.type == RTW89_HCI_TYPE_USB)
>> +               timeout = RTW89_C2H_TIMEOUT_USB;
> 
> Should we have different timeout times for USB2 and USB3? 
> The same question for patch 2/2.
> 

I measured the time it takes to read R_AX_WCPU_FW_CTRL (patch 2/2):

		USB 2		USB 3
RTL8851BU	125 µs		not supported
RTL8852BU	250 µs		40 µs
RTL8852CU	375 µs		40 µs

In my setup the same timeout works for both. Even with the faster reads
it still waits long enough.

> Otherwise, looks good to me.
> 
> 
>> +       else
>> +               timeout = RTW89_C2H_TIMEOUT;
>> +
>>         ret = read_poll_timeout_atomic(rtw89_read8, val, val, 1,
>> -                                      RTW89_C2H_TIMEOUT, false, rtwdev,
>> +                                      timeout, false, rtwdev,
>>                                        chip->c2h_ctrl_reg);
>>         if (ret) {
>>                 rtw89_warn(rtwdev, "c2h reg timeout\n");
>> diff --git a/drivers/net/wireless/realtek/rtw89/fw.h b/drivers/net/wireless/realtek/rtw89/fw.h
>> index 98be7e72c685..a731c242f389 100644
>> --- a/drivers/net/wireless/realtek/rtw89/fw.h
>> +++ b/drivers/net/wireless/realtek/rtw89/fw.h
>> @@ -115,6 +115,8 @@ struct rtw89_h2creg_sch_tx_en {
>>  #define RTW89_C2HREG_HDR_LEN 2
>>  #define RTW89_H2CREG_HDR_LEN 2
>>  #define RTW89_C2H_TIMEOUT 1000000
>> +#define RTW89_C2H_TIMEOUT_USB 4000
>> +
>>  struct rtw89_mac_c2h_info {
>>         u8 id;
>>         u8 content_len;
>> --
>> 2.50.0
> 


