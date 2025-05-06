Return-Path: <linux-wireless+bounces-22659-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1141CAAC18D
	for <lists+linux-wireless@lfdr.de>; Tue,  6 May 2025 12:40:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B94ED1C013A4
	for <lists+linux-wireless@lfdr.de>; Tue,  6 May 2025 10:40:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CACD2459D8;
	Tue,  6 May 2025 10:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gi20R0q4"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D21EF1F2BB5
	for <linux-wireless@vger.kernel.org>; Tue,  6 May 2025 10:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746527990; cv=none; b=o3D5Ghzz+itoQ8IAc/6NV5pATEjFca3IwUaRGzOLUudTwX8RE+xkgXH6lPPGmTn4FhNaZkL1VgIcj3Fkf4ZekPWxl77G9foF6rE3tqSUEHBUJYD1m1oqdkEy61VdVRbmffLUPzeM8wgh2B65nRJqVFhRBG4A1ZS39u2Ac4wJPfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746527990; c=relaxed/simple;
	bh=UMPzWo9N6HRvGrsZ52/UEh5x6iHvHqUOItRrXHR1lNs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=La7xv7+04cK0GmIDixhws546bgAppf4lbsZD9NnogxmP2miwHb4l5SQXKCBDMhca/FOH2hD75VhoYcnZU/fXzSYFMle1Mg0Yi0VqiGNoOB2tes6sZasJWXiPiATtbTLqXSpCmqVjIipYgycobNSPd4Re6O2p+DxDwOV2LGBJtaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gi20R0q4; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-739525d4e12so5309509b3a.3
        for <linux-wireless@vger.kernel.org>; Tue, 06 May 2025 03:39:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746527988; x=1747132788; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iZ7wr+TP5KQIJS/QzakF5Qi2XH46Y72f1UENvfbzHUo=;
        b=gi20R0q46plxWoFRg5RfRhrhOh0Br41l07i0KnY/fhIzmITQBfEIeNHJedayZzlHKv
         l1g4tFw01VzhWHjq1EMACxCx8Ww7m59xIiYsM88LJ8R6sOUxkqxTGP50n51W4vgNv64R
         IC9JJXSl/OTievTOlEuEJI5iRFGHakwtJufui3W0HfxDT6PXXvM+b5K/v83q3mYaF0h2
         YqebEtUt7N7Xa249sqgqfvVRFRpF1iiikhSnG/JsO15Ozktu0HcrrNs6TD1RQWXwvAMr
         SPJm3IdWGWQTBqODgHhf21eClRA+iE3UfKL805RRTmOfPeCxHo+UT9+34otPaQfMQddi
         5DGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746527988; x=1747132788;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iZ7wr+TP5KQIJS/QzakF5Qi2XH46Y72f1UENvfbzHUo=;
        b=U6QdlO4Rvsrh4eqW6DmmhV4EHsCX4tK4Vkor5XO3tgpqwvCn5Hr/K143eEE4mlqSLQ
         /prKp2WBuZ5tqo/saztZ48Ct7siDLLPIMSppHA4MnjpJEM7a0QxKWu+fP7OOo5biYnhe
         f96gD6tra5nt06tHe8D1rHvszsTiCS+5xgqRVJ/qrU0CMh2q8+aSbWbGIBudFOm8xCrA
         nCXbJNUO4Oo1Fdund4/2XHD2HmGvJ2taT9jHjhHBu+uhCbcx4UmsI11iVICtYuGcZz52
         H66W54OedYnOt4jkY7nxrns9fPFW6FCIPYY5DU8nqpoHGG3k35SLQlNmBVnpULAmnOKE
         uM+A==
X-Gm-Message-State: AOJu0YwvBRtlDDsPoReRddT2yznx++MC/AHH43Y4Qp5/rwDX2SLYocjQ
	JIR4xvMFn4+x1+zre663SvMGRJFQKnHfUbKqlNFt6CXTI6WU7XQctEqa1GpApD4=
X-Gm-Gg: ASbGncvajMx+8s9NRPOj72g8fbjgscjVkIfPjLeJb9NYeZJCCu1cR6UwJhwoREJGHRq
	sSdm7MyJOIBO3MedhJDHLrxs/wuQD8G/E3V72hxMaQaKJqQR8eKDYBye0hXCaWRQZ7wTgffnp9D
	7Nrba5V6k3NDl/5xmeMDa33d9FYLr5ESP25gcIRhdN8Nx2c4nzoawSBjJPpTOAcKZCFFseoAEG3
	QYfCmoQyKF8rqau1MDp5rDzQKR6kp3KzlbqpAAvviFwBGcqkBHMTSFnXlkyFKUPG4ZYtSryXwv1
	OdVsam12TsNqFhdd1ID2qT/6NimmB+/zsn6Gs8NVTcJjV/Us5u5SwSmjly4reoRUhFi+A1F/iWW
	Geb6zHOkuO5gNYheVZhU=
X-Google-Smtp-Source: AGHT+IEwxcPIlCKhBrlTlvmsX0jxmDbAAWt6eQlLkB+eXYhiJkqntOS5/w1zvozaqnVXGPJ5mCJluQ==
X-Received: by 2002:a05:6a00:8c04:b0:736:53bc:f1ab with SMTP id d2e1a72fcca58-74058a56812mr26072248b3a.12.1746527988058;
        Tue, 06 May 2025 03:39:48 -0700 (PDT)
Received: from ?IPV6:2400:4051:1da1:4500:3111:6953:848d:8929? ([2400:4051:1da1:4500:3111:6953:848d:8929])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74058db8f34sm8604585b3a.37.2025.05.06.03.39.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 May 2025 03:39:47 -0700 (PDT)
Message-ID: <df65e2a9-5430-47b2-853f-a04c404179ba@gmail.com>
Date: Tue, 6 May 2025 19:39:30 +0900
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] wifi:rtw88:rtw8822bu VID/PID for BUFFALO WI-U2-866DM
To: Ping-Ke Shih <pkshih@realtek.com>
Cc: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
References: <CA+Tmi=P0kFARoU3yrbMTOBhXz=1Q8MoroaSNbQDw_NZye6r60A@mail.gmail.com>
 <20250503003227.6673-1-wf.yn386@gmail.com>
 <deb6f384a0bf4f96b2c3092fd7f767e1@realtek.com>
Content-Language: en-US
From: Yuuki NAGAO <wf.yn386@gmail.com>
In-Reply-To: <deb6f384a0bf4f96b2c3092fd7f767e1@realtek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2025/05/05 9:34, Ping-Ke Shih wrote:
> Yuuki NAGAO <wf.yn386@gmail.com> wrote:
>>
>> Add VID/PID 0411/03d1 for recently released
>> BUFFALO WI-U2-866DM USB WiFi adapter.
>>
>> Signed-off-by: Yuuki NAGAO <wf.yn386@gmail.com>
> 
> For the subject, need spaces after "wifi:" and "rtw88:".
> I can add spaces when I merge.
> 
> Acked-by: Ping-Ke Shih <pkshih@realtek.com>

Sorry for inconvenience. Could you please add spaces to the subject
when you merge this patch?
If I should repost patch myself, I will repost this patch
after modifying subject.

> 
>> ---
>> Changes since v1:
>> - Fixed malformed patch.
>> ---
>> ---
>>  drivers/net/wireless/realtek/rtw88/rtw8822bu.c | 2 ++
>>  1 file changed, 2 insertions(+)
>>
>> diff --git a/drivers/net/wireless/realtek/rtw88/rtw8822bu.c
>> b/drivers/net/wireless/realtek/rtw88/rtw8822bu.c
>> index 572d1f31832e..ab50b3c40562 100644
>> --- a/drivers/net/wireless/realtek/rtw88/rtw8822bu.c
>> +++ b/drivers/net/wireless/realtek/rtw88/rtw8822bu.c
>> @@ -77,6 +77,8 @@ static const struct usb_device_id rtw_8822bu_id_table[] = {
>>           .driver_info = (kernel_ulong_t)&(rtw8822b_hw_spec) }, /* Mercusys MA30N */
>>         { USB_DEVICE_AND_INTERFACE_INFO(0x2001, 0x3322, 0xff, 0xff, 0xff),
>>           .driver_info = (kernel_ulong_t)&(rtw8822b_hw_spec) }, /* D-Link DWA-T185 rev. A1 */
>> +       { USB_DEVICE_AND_INTERFACE_INFO(0x0411, 0x03d1, 0xff, 0xff, 0xff),
>> +         .driver_info = (kernel_ulong_t)&(rtw8822b_hw_spec) }, /* BUFFALO WI-U2-866DM */
>>         {},
>>  };
>>  MODULE_DEVICE_TABLE(usb, rtw_8822bu_id_table);
>> --
>> 2.43.0
> 


