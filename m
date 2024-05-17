Return-Path: <linux-wireless+bounces-7793-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DDF18C8A66
	for <lists+linux-wireless@lfdr.de>; Fri, 17 May 2024 18:57:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B1168B2121C
	for <lists+linux-wireless@lfdr.de>; Fri, 17 May 2024 16:57:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0165813D8A4;
	Fri, 17 May 2024 16:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mCvO2tws"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78B6712F5A3;
	Fri, 17 May 2024 16:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715965061; cv=none; b=VmjnQ8718FQOw2nIkkU9QEQe+4Dw2gjdJivmMGORxHB74WszpB8dMxLia/fqlnPLeq3bXDPTaf1vfbo7XhD/9irPb7EKFWXntbaLl9kw1HvyiXsx4tBJt8bV34xAgMhSMHW4Rp34U+baX2rA+hdPJckTU/TlP/xI1TtXQSowjdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715965061; c=relaxed/simple;
	bh=G5y7fYlCIS/vQUhWu9GANqMr1dvW8z6d76b7fq7R1Q8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=goqXs4yUmYG6/Jynk8GZfa3Zkm9Grr4x3c95kkaQYPqKBkXwpnLXvFMN6FGmgY0sVwTnKS8rkHpTg/un3ymkDrWl9gfRCQYHwYW3qR9fh0xuYj0oikTUZZY+q8ow9MUqvW/c0MArARxiicaYAv9BkIcIhg3coPIn2NZ7q6zgOHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mCvO2tws; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-69b24162dd6so5009996d6.2;
        Fri, 17 May 2024 09:57:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715965059; x=1716569859; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=siRLjok91NGHey9v30Ita/YRAFgeSTbR5TDyJ6gAeEU=;
        b=mCvO2twsl5MZFAIcWFPqe9C7TLNgdrQiVY6+PQwOLs8yKc2jJ0keE8POuB2s38mCRl
         CYhFEOrO/WVDEtEd6sK0wIl2ZH9eVgF0ihJewfWSByobGuJhgBJzKoKk0xBtwLvXK6dH
         Oqo/hbJ47CpIRD2yXopKVuBRVwH0g89Wg6exgnKwtjkSczGVtJ2WXsIirCXmH5R2hbAz
         w/pN+KCnlvbdFVDepH0kZzRvya3dv8TcCcDyq0xhTPqIoo2uTs8KPqPDYqYBMKrP3ZFW
         6eGKexACkAEHAFbFO17af+Ux0lUZx7bf9v/AEWqp8U3XZSdsiNFxoS6t9N+d8uMki/CA
         BxKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715965059; x=1716569859;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=siRLjok91NGHey9v30Ita/YRAFgeSTbR5TDyJ6gAeEU=;
        b=YsCN75u3ALwulfOYgWym6jjxZH7IRo75HFIUcZ+CKrTJqs69QvShKfDv8ylswqrtby
         sk912Vv5VgHqJMpk3RPWrxSzeygfJW52unbtM3z+vzexAaglg2LVBcnnbi5e5v4IZp1A
         M7/yw3P5pljJ4nKFOqkfFDUf5DdQ4Z+uAzInnAx1xBtTwnci4WiRyq4B8Mps5hV+R7lD
         eo7J0+QIAwRY7gz8VXsr+IOim5vnk+vl7lEgzAATj70zumQ2fXTTE3kvNi0mFw0++G2Q
         Mmk+XPf+vc3+avISxCgZOlmG9ZCBDqdZsCXZmyeemuUzAloSEE0Iq9G1tGGZ0Ox3pRvJ
         kiUg==
X-Forwarded-Encrypted: i=1; AJvYcCX+VFlz6ZpiWMw++74RaVN09ZfxsPTcmHZ4qmqRPd18xDxOABcLEOVaWxo2bPrNNsYlurNJSPrfjf4nEcebTHqpMxAiNFi9aeA0RvT9
X-Gm-Message-State: AOJu0YweLZqnq+84Alh2/bL3kfAUZ0y4Out4doe8ZY/EvVw7SEVvSjYN
	I10FpPb9/jmEBwKPqxpZNcrOr9VJ4cHf9mTFhzxQaHKftEvlrkhuIbwUUlSD
X-Google-Smtp-Source: AGHT+IF109mu25s47I7e8THQ48j4SsbIhIwhRuyyjhRDH5DT41RX6HzVXp/6L5wbvd6oxFryTX2Jcg==
X-Received: by 2002:a05:6214:498d:b0:6a0:b3cc:ee0f with SMTP id 6a1803df08f44-6a16820682emr279546906d6.43.1715965059156;
        Fri, 17 May 2024 09:57:39 -0700 (PDT)
Received: from [10.7.1.107] (static-74-103-39-5.bltmmd.fios.verizon.net. [74.103.39.5])
        by smtp.googlemail.com with ESMTPSA id 6a1803df08f44-6a3e849f8e9sm11703836d6.33.2024.05.17.09.57.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 May 2024 09:57:38 -0700 (PDT)
Message-ID: <a1cd16d2-1fbc-6543-c17c-a321ac72a2f3@gmail.com>
Date: Fri, 17 May 2024 12:57:37 -0400
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH] thermal: adding check if the thermal firmware is running
Content-Language: en-US
To: Guilherme Giacomo Simoes <trintaeoitogc@gmail.com>,
 miriam.rachel.korenblit@intel.com, kvalo@kernel.org,
 rafael.j.wysocki@intel.com, daniel.lezcano@linaro.org,
 johannes.berg@intel.com, dmantipov@yandex.ru
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240517141655.2797-1-trintaeoitogc@gmail.com>
From: Jonathan Bither <jonbither@gmail.com>
In-Reply-To: <20240517141655.2797-1-trintaeoitogc@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 5/17/24 10:16, Guilherme Giacomo Simoes wrote:
> In the dmesg is showing the message "failed to read out thermal zone"
> as if the temperature read is failed by don't find the thermal zone.
>
> After researching and debugging, I see that this specific error is
> occurrenced because the thermal try read the temperature when is started,
> but the firmware is not running yet.
>
> For more legibiliti i change the tt.c for return EAGAIN when this was occurrence.
> After this change, in my computer I compile and install kernel in /boot
> and in my dmesg the message "failed to read out thermal zone" is not show
> any more.
>
> I would like to thanks for Rafael Wysocki <refael.j.wysocki@intel.com> for
> your suggestions in mu first patch that results in this another patch.
> ---
>   drivers/net/wireless/intel/iwlwifi/mvm/tt.c | 10 ++++++++--
>   1 file changed, 8 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/tt.c b/drivers/net/wireless/intel/iwlwifi/mvm/tt.c
> index 8083c4b2ab6b..68ab9966330c 100644
> --- a/drivers/net/wireless/intel/iwlwifi/mvm/tt.c
> +++ b/drivers/net/wireless/intel/iwlwifi/mvm/tt.c
> @@ -620,8 +620,14 @@ static int iwl_mvm_tzone_get_temp(struct thermal_zone_device *device,
>   
>   	mutex_lock(&mvm->mutex);
>   
> -	if (!iwl_mvm_firmware_running(mvm) ||
> -	    mvm->fwrt.cur_fw_img != IWL_UCODE_REGULAR) {
> +	const int res = iwl_mvm_firmware_running(mvm);
> +
> +	if (!res) {
> +		ret = -EAGAIN;
> +		goto out;
> +	}
> +

You could skip using the res variable and move the mutex lock here and 
simplify the above a bit. Ex:

         int temp;

-       mutex_lock(&mvm->mutex);
+       if (!iwl_mvm_firmware_running(mvm))
+               return -EAGAIN;

-       if (!iwl_mvm_firmware_running(mvm) ||
-           mvm->fwrt.cur_fw_img != IWL_UCODE_REGULAR) {
+       mutex_lock(&mvm->mutex);
+       if (mvm->fwrt.cur_fw_img != IWL_UCODE_REGULAR) {
                 ret = -ENODATA;
                 goto out;
         }

> +	if (mvm->fwrt.cur_fw_img != IWL_UCODE_REGULAR) {
>   		ret = -ENODATA;
>   		goto out;
>   	}

