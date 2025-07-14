Return-Path: <linux-wireless+bounces-25409-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 44607B049E8
	for <lists+linux-wireless@lfdr.de>; Tue, 15 Jul 2025 00:01:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 63E4F1A65D2C
	for <lists+linux-wireless@lfdr.de>; Mon, 14 Jul 2025 22:02:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E39B1A5B8C;
	Mon, 14 Jul 2025 22:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gFILxDw2"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E34F92114
	for <linux-wireless@vger.kernel.org>; Mon, 14 Jul 2025 22:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752530511; cv=none; b=ierPBZiKceyjKXG578bRCrP3Mjo9iHBsXi6t8azx+tCELUlDRkZWDuuKLiOWU9QUE+PoZu5c2F9iA6/QZbjydopXnY+VvhKvtUvgTjNTHEr3x0X5+5Zbi5kAas+N7JNG1ftHh1Fz90nf8exZXySdASo284HMMvqIJ3/YMBKo6cY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752530511; c=relaxed/simple;
	bh=wxbCheCM0TF/+o8N3PZRFtrzX1IHHsx6VlmrXZqeqVI=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=ooMmeJEMKNsNcdKpiSliYFRojwMjCgClNxgEIyeFVzW39BfqbqmVC0zs045vXlWbf2zNb+YMRm7aS+zsooVLB1HpN1c/gspPRIaSWEYMYawFri4pfxw/7R+PhPKwYRXVLn0DQgv8s2PpolnMxIF3h9nyJahQx+xfDMgg50rlWhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gFILxDw2; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-ae0dd7ac1f5so978003466b.2
        for <linux-wireless@vger.kernel.org>; Mon, 14 Jul 2025 15:01:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752530508; x=1753135308; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=OPNT2xCHTaOazBCbT/vKHhBNwR6vmrrJbhdL78R8Tg4=;
        b=gFILxDw2sMRr8tiKsFKO71fNhSPaGobaqINILqBGHpkbTXJ+9PBUTyaeOb8JZZcqUf
         0nMABAv+Ui4XWd+SzP17ARZgZ8QYq0yvIKueS9QH6K265UONsmCs7qUGc9KIy4Sgan0L
         FvBCI6l9IEDpJhv7hybDTE4RtwU0CVNAzxThehm+SdwwXOqzeEG14eYQ8z9BoDYksh07
         Q41T2p59b0TQeXwM5sITWLIofWJoh7fHWBazUxEVhgy+RNQxh5kgwB7kyaRcgoaIRHA2
         Zy+Y2RJXiIP6/VrICFf5i+EEYVRU7IS2rBxU11oEH3xHpJYXqm5AcPm6Ztjq730qLdKD
         oFOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752530508; x=1753135308;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OPNT2xCHTaOazBCbT/vKHhBNwR6vmrrJbhdL78R8Tg4=;
        b=RcilzQ58XZuuo93yM6UaGnEXwqC9xMDmrT9l0JGQjunBqZAFQgFlWOtMGm9bwOkHqG
         AuZ/VUgg4uukX9T32zURiu2XHJGks2sc/e4SUQN1wnpV5WodJSabt29rEYGXDAwSX7CU
         clpZG9dIe8f68gTFtxz0WNawsfgs1qNdwlD2G56bfiWo5Johbd5mecXqFuWW0WusJyW0
         fCQsWM5WiIR+VeKW27woVau3WWdSrp5TJ4KkWHpM5/Waf24ODxuQwwDqdBIhG2oiMERM
         FkKMWzo+NtaWrZv8V5Tu6gLYX/VeKAHBXmRmz/c/dWnPfIbb2jUsTT+tPycvFzjYLfl9
         vNpw==
X-Forwarded-Encrypted: i=1; AJvYcCXsqxzQGq1DyFiDXgK3XXBM2BpAjhI4RoMf8RewMNjx1q/Rzj7X4IQC2/4VYCZ8BigrPA0XGFzXCvTr6EslTQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzZpuJZ4h1/tvEMJ5ssL8Pw/vG1ap0+8qJc/I3zNg1A7MTnLLDK
	hIG7OdICQwcWwUMNIe5HZkIuv/Jhr8D9mhcU7Fjh6gzzLVdU5Ux28Lhk
X-Gm-Gg: ASbGnct2k5NXwbKi61zIh+56o7qBdQn9BTCExDM7LPXVntiDlWwpHaTJjsY0lERGQ27
	KnvTSH4cruvYo/TXLDzwmeR5rOuxOFjb7lBtFyrA/GxKwmdg0LKjjQLkOZTOebMzdundpg/Zlh8
	VeN/XEUUIYEhoaStgoV2dXEXN4nP8b8WwKjPoLomyY3yciLoJwcBOO1svwsif+7lrpnEPpK+Bni
	iSm46KtAwwL7IPQG99tFeOT1WQXqTISmsDQouaEcxvmF5TaP9FvliXmdme9Lich9xCEEvfhLFFr
	JSEUhRoBJDSl/dKGBgUpTVqyorM8KrFi0E7gOaDc/437LgiQq43BP2BG5/vFIU/0ZYWJm4Bv61c
	kHAgDW66h6p0ZNV7EWqkp2wQY0fakvTknXLki+I2n
X-Google-Smtp-Source: AGHT+IH/18OcSIFh2iMe39dWlv15qDxxFWHLU3J1aGbyL9xWM5/fM/ahAG3oZHeSjhz7m3NREe8/FA==
X-Received: by 2002:a17:907:d510:b0:ae6:dd93:d7d1 with SMTP id a640c23a62f3a-ae6fc1fae63mr1410314866b.56.1752530507694;
        Mon, 14 Jul 2025 15:01:47 -0700 (PDT)
Received: from [192.168.0.50] ([81.196.40.253])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae6e8291bbesm873590466b.126.2025.07.14.15.01.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Jul 2025 15:01:47 -0700 (PDT)
Message-ID: <b24bb8a2-d635-4312-b451-065b8d8e950c@gmail.com>
Date: Tue, 15 Jul 2025 01:01:45 +0300
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH rtw-next 1/2] wifi: rtw89: Increase polling delay in
 rtw89_fw_read_c2h_reg() for USB
To: Ping-Ke Shih <pkshih@realtek.com>,
 "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
References: <73f8bdbf-ff7f-4741-a6ea-b1d9026833c3@gmail.com>
 <9ce9b78535d74f08927ce2ac9c7731e9@realtek.com>
Content-Language: en-US
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
In-Reply-To: <9ce9b78535d74f08927ce2ac9c7731e9@realtek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 14/07/2025 05:49, Ping-Ke Shih wrote:
> Bitterblue Smith <rtl8821cerfe2@gmail.com> wrote:
>> This read_poll_timeout_atomic() with a delay of 1 µs and a timeout of
>> 1000000 µs can take ~250 seconds in the worst case because sending a
>> USB control message takes ~250 µs.
> 
> I was not aware of the change of [1]. The behavior of atomic version becomes
> different from non-atomic version. 
> 
> For this patch, I feel we can keep delay_us to 1 and treat timeout_us as
> 'count', which USB devices do smaller retries. The smaller delay_us can
> reduce total polling time, especially for PCIE devices (see my comments below)
> 
> Though I don't measure total polling time of patch 2/2, I feel we can apply
> similar idea. 
> 

Yes, a smaller timeout also works. I tested 4000 for this patch and 3200
for patch 2. (4000 * 250 = 1000000 and 3200 * 125 = 400000. I don't know
why rtw89_read8() in the second patch takes only 125 µs.)

> [1] 7349a69cf312 ("iopoll: Do not use timekeeping in read_poll_timeout_atomic()")
> 
>>
>> Increase the delay to 250 µs in order to reduce the maximum polling
>> time to ~2 seconds.
>>
>> This problem was observed with RTL8851BU while suspending to RAM with
>> WOWLAN enabled. The computer sat for 4 minutes with a black screen
>> before suspending.
>>
>> Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
>> ---
>>  drivers/net/wireless/realtek/rtw89/fw.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/net/wireless/realtek/rtw89/fw.c b/drivers/net/wireless/realtek/rtw89/fw.c
>> index c613431e754f..27d84464347b 100644
>> --- a/drivers/net/wireless/realtek/rtw89/fw.c
>> +++ b/drivers/net/wireless/realtek/rtw89/fw.c
>> @@ -6665,7 +6665,7 @@ static int rtw89_fw_read_c2h_reg(struct rtw89_dev *rtwdev,
>>
>>         info->id = RTW89_FWCMD_C2HREG_FUNC_NULL;
>>
>> -       ret = read_poll_timeout_atomic(rtw89_read8, val, val, 1,
>> +       ret = read_poll_timeout_atomic(rtw89_read8, val, val, 250,
> 
> As my experiments, PCIE devices take about 30us for this polling, when
> setting delay 1. But it will take 256us, if delay is changed to 250.
> I feel we need to set this value by HCI type if needed.
> 
>>                                        RTW89_C2H_TIMEOUT, false, rtwdev,
>>                                        chip->c2h_ctrl_reg);
>>         if (ret) {
>> --
>> 2.50.0
> 


