Return-Path: <linux-wireless+bounces-7797-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13D028C8BBA
	for <lists+linux-wireless@lfdr.de>; Fri, 17 May 2024 19:55:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE1A82837AF
	for <lists+linux-wireless@lfdr.de>; Fri, 17 May 2024 17:55:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9646A13E038;
	Fri, 17 May 2024 17:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q+gXZ9eq"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E47913E02F;
	Fri, 17 May 2024 17:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715967793; cv=none; b=CDfM9c95J2babnYf17zN4E4KURJUDTLBGoWqhvErHo/7JzvAmhGr1bCZe7mxjDMDO49ZQznjs6aHxfZV4S7/M9ozCH2g3uENFu2U1zM7TLCCD7AXYHIIXos8Kw7kpImvsKZ1al46N+SIlaBkYTVKdcVhIx9SnCRi3EnM32ZUw0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715967793; c=relaxed/simple;
	bh=cKe09rwHn+hvO59C80d/OIasI62hIJZbA5Eb140c1Vc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MElrFt7i6Dl+2EcKXyRdvPhyU1xw4dE53wB72MZsxcu0dXKbV4aiheppwP14RPkuLYnzVG2UcB/sPQagmvxbP+8FzNvPuigqrcyl2p2unEXeq7LNrQi9ZvEdg9Bpl+ha+lWD4STV/DzUYczhSdEfVNKmDbubNMLAgh+Y+HKHoWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q+gXZ9eq; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-43defa9d4f9so4032151cf.0;
        Fri, 17 May 2024 10:43:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715967791; x=1716572591; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ryqqSgZ4nUH3oYGevXgTxRYsY6XPeTcaQtxxGQHDrRM=;
        b=Q+gXZ9eqcO6qH6/vWW583ky6VGc1JtBoGrMiigAJdtlRGRNsYPHCMl4OZa9/xpdeXw
         xGAoHG5GTTKTaj/dit/i5i4WofZFIm347xKwXXf7knKvXQHvWX/NbjwLFCxlnVibYTJx
         ugcRB3EXs9u1gyBoHg3qW3WuEjG8JvcLk1kRHPz+wt5iD5eXdKHTHwufJh6tKf28RORx
         GQ8ayoRXz8H4IOxOxWSIr/kDsyWt3gu7KzETgdSO+Kc97A0S0l/PqYvZ96/dtRAgjNBh
         r7dSVqwxhi1lvkjh+tzC/SaERkbWRjROF9ypviWDlKVs3Cy/OpoeLzRF5skNg8ws7Cmc
         IgUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715967791; x=1716572591;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ryqqSgZ4nUH3oYGevXgTxRYsY6XPeTcaQtxxGQHDrRM=;
        b=KMsjruzbGSDV9eIxKwI6C2K3TZZb0qjLP0fXeBy6tn+W0uZwKj/F+jNxuPUdPNbUho
         9wtd2OKkv79gmpAqLO6EgDOBx1KxV/PZLLz0TrILJIryYMCZ6HgRKUKnw3ZdbcjUx9De
         UhXVy5XBLN+kQCzpFydxzOFQYtAChTW41nejzYldZm210CbBTdIDv2evlIWmKDyFnqWx
         LjpHOZiHfX0FwMctGBr2ajNwEKQpsImXJPeyTWo2wiy+vhHNsrPv7DNSX4ipyNDHiyI2
         XU3/0OBxmMWtimEKqERVnz93nAbxQ0RPzgSfZpsCi4IsSl+850/tIoBXDaHzaYT1IQgY
         c2tw==
X-Forwarded-Encrypted: i=1; AJvYcCWIQrkPNd+7buFqrCDDz8g7K5qXNr179nEI83nrJAHMNFsMSYozPKwO2SO1HseVevXpW9WNSPSqNLganToW3ry5cw/Xt8RylYrI9v1DzCnvwEOlx1qSZx3lUObhMEZUIQr1gzZSf3yqyxzEeuk=
X-Gm-Message-State: AOJu0YyErSdKYHn/BSFwfavPiHdTh1/+xcGNAbf5nx6u62r4cq9LUKMJ
	4g/xdL4oA3Hgp/XSK5YPuCqZRXFa+04SsJQMobUuknsu2AHhf8g2
X-Google-Smtp-Source: AGHT+IGgAE1IEXNbRI6p1LgGM0yXpCZR7R1i36UUUKT0OsOO1YDtfrzFBYamNQezxB3WHoNFZC/Hmg==
X-Received: by 2002:a05:622a:6:b0:43d:f86a:4e3b with SMTP id d75a77b69052e-43dfdd0cc51mr241105931cf.58.1715967790831;
        Fri, 17 May 2024 10:43:10 -0700 (PDT)
Received: from [10.7.1.107] (static-74-103-39-5.bltmmd.fios.verizon.net. [74.103.39.5])
        by smtp.googlemail.com with ESMTPSA id d75a77b69052e-43dfd2dbd68sm102430101cf.12.2024.05.17.10.43.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 May 2024 10:43:10 -0700 (PDT)
Message-ID: <aa9abbd9-32c7-1f4d-34e8-a07956e775a5@gmail.com>
Date: Fri, 17 May 2024 13:43:09 -0400
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
To: =?UTF-8?Q?Guilherme_Gi=c3=a1como_Sim=c3=b5es?= <trintaeoitogc@gmail.com>
Cc: miriam.rachel.korenblit@intel.com, kvalo@kernel.org,
 rafael.j.wysocki@intel.com, daniel.lezcano@linaro.org,
 johannes.berg@intel.com, dmantipov@yandex.ru,
 linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240517141655.2797-1-trintaeoitogc@gmail.com>
 <a1cd16d2-1fbc-6543-c17c-a321ac72a2f3@gmail.com>
 <CAM_Rzfb8f4ki4UB2+9EtnpJL8oMY6x0q=HmDm92mdbhLQafFOQ@mail.gmail.com>
From: Jonathan Bither <jonbither@gmail.com>
In-Reply-To: <CAM_Rzfb8f4ki4UB2+9EtnpJL8oMY6x0q=HmDm92mdbhLQafFOQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 5/17/24 13:25, Guilherme Giácomo Simões wrote:
> Em sex., 17 de mai. de 2024 às 13:57, Jonathan Bither
> <jonbither@gmail.com> escreveu:
>>
>> On 5/17/24 10:16, Guilherme Giacomo Simoes wrote:
>>> In the dmesg is showing the message "failed to read out thermal zone"
>>> as if the temperature read is failed by don't find the thermal zone.
>>>
>>> After researching and debugging, I see that this specific error is
>>> occurrenced because the thermal try read the temperature when is started,
>>> but the firmware is not running yet.
>>>
>>> For more legibiliti i change the tt.c for return EAGAIN when this was occurrence.
>>> After this change, in my computer I compile and install kernel in /boot
>>> and in my dmesg the message "failed to read out thermal zone" is not show
>>> any more.
>>>
>>> I would like to thanks for Rafael Wysocki <refael.j.wysocki@intel.com> for
>>> your suggestions in mu first patch that results in this another patch.
>>> ---
>>>    drivers/net/wireless/intel/iwlwifi/mvm/tt.c | 10 ++++++++--
>>>    1 file changed, 8 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/tt.c b/drivers/net/wireless/intel/iwlwifi/mvm/tt.c
>>> index 8083c4b2ab6b..68ab9966330c 100644
>>> --- a/drivers/net/wireless/intel/iwlwifi/mvm/tt.c
>>> +++ b/drivers/net/wireless/intel/iwlwifi/mvm/tt.c
>>> @@ -620,8 +620,14 @@ static int iwl_mvm_tzone_get_temp(struct thermal_zone_device *device,
>>>
>>>        mutex_lock(&mvm->mutex);
>>>
>>> -     if (!iwl_mvm_firmware_running(mvm) ||
>>> -         mvm->fwrt.cur_fw_img != IWL_UCODE_REGULAR) {
>>> +     const int res = iwl_mvm_firmware_running(mvm);
>>> +
>>> +     if (!res) {
>>> +             ret = -EAGAIN;
>>> +             goto out;
>>> +     }
>>> +
>> You could skip using the res variable and move the mutex lock here and
>> simplify the above a bit. Ex:
>>
>>           int temp;
>>
>> -       mutex_lock(&mvm->mutex);
>> +       if (!iwl_mvm_firmware_running(mvm))
>> +               return -EAGAIN;
>>
>> -       if (!iwl_mvm_firmware_running(mvm) ||
>> -           mvm->fwrt.cur_fw_img != IWL_UCODE_REGULAR) {
>> +       mutex_lock(&mvm->mutex);
>> +       if (mvm->fwrt.cur_fw_img != IWL_UCODE_REGULAR) {
>>                   ret = -ENODATA;
>>                   goto out;
>>           }
>>
>>> +     if (mvm->fwrt.cur_fw_img != IWL_UCODE_REGULAR) {
>>>                ret = -ENODATA;
>>>                goto out;
>>>        }
> Hey Jonathan, Thank you for your suggestion.
> I sended a v2 patch of this patch
> https://patchwork.kernel.org/project/linux-wireless/patch/20240517171311.3705-1-trintaeoitogc@gmail.com/
>
> If you want, you can send this suggestion in this patch v2.
Hey Guilherme, no worries.
>
> Thanks.

