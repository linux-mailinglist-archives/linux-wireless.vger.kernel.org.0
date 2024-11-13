Return-Path: <linux-wireless+bounces-15283-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DAE79C7EF7
	for <lists+linux-wireless@lfdr.de>; Thu, 14 Nov 2024 00:53:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 42672B22785
	for <lists+linux-wireless@lfdr.de>; Wed, 13 Nov 2024 23:53:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06FA818C01A;
	Wed, 13 Nov 2024 23:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jADJj31k"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 236D018A6A0
	for <linux-wireless@vger.kernel.org>; Wed, 13 Nov 2024 23:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731542007; cv=none; b=k65ifw9p04NTlItdAGhwuh5oajZtchTDlNmvEuhYH8gDWHmzK+Qe4Doxpiuh4SxCaAFPdCyVsgM4uWu8snTs81+CD05xZnjjtLOkhhiqR0a9Ma65gKDu1W8nVqJiksjduWBFwOU9CHXSdUTfkS38HUy7lXgkP4LVj5QRIlHmhYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731542007; c=relaxed/simple;
	bh=DCr5X77cAcShmSW6ZHC2JRxKtF/yAaihWtjq3TNiNsc=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=GrRUWVpp0FQwq35uh+mI/zjduix7a3iQ2w+IfYeuUr/4aKzdXp9yd7rqyXsVbFq0/7CGOzwpe6if9ox2O3fSV7r9pCL9Jpu2h9c4NfX2aTPn+bA9WQ2+ae6Xqa8S1JYwu3edyQi5LzHWYH1/sCeqrtbiFl29yq0D/wyOPIiXRwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jADJj31k; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a9ed49ec0f1so512666b.1
        for <linux-wireless@vger.kernel.org>; Wed, 13 Nov 2024 15:53:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731542004; x=1732146804; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=DCr5X77cAcShmSW6ZHC2JRxKtF/yAaihWtjq3TNiNsc=;
        b=jADJj31kxeibebJg09e/0ZJkTlttVjsw91gvbH7srIEM/cWfUSW1AYTKp7nBYlrRVJ
         tm93ovN81aqDgDP9WbAts3vH3ktNw+aIU8uAAfmbEmFZmDKtxPvaKeMRXLtYhFdJGJTn
         MwiAxMs2GCiUrhq+5oLI7ahpe47HhbFnau2yVwep2d7tTcuSZws2mdR+qSZAQW43NBdh
         6g78EoFHeA/MUXLPnvLYY+honTDM+V1wBv6IdQHFuVE80KoApkswkK6DPws5dMtNGViI
         +t1GfTWaSfbQ25JKb7m9Qxdz/GYM4PLC87Wnn32NAMhRJ5s/NaxWP32OIK2SveVbFx+o
         taXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731542004; x=1732146804;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DCr5X77cAcShmSW6ZHC2JRxKtF/yAaihWtjq3TNiNsc=;
        b=CDsjPNZk0tquJPwsNwx5U5GSKSdVB8i7o55rhTtpYkJNxN3io1q6RgGwPxlsXI+iSV
         2qVRaaCINzT2h4/ZTSieRpFeZaEltrEKCCiI1Kyx6Ru9gV5RT3CCpD8rxAXMYS9eow7G
         t/L8gZ3cKMeUIZxHGGlAfCJENbBOYuEQuXZ4VigRXSJeNO5b5gG/CPuNiaFAbM/PjFjB
         n449oMKpwfa70bVTqIiH23iW3WSLZ6Mv32EddJ/PsI5yfh0e7qGK8RSu+EugBuuRZAnM
         kXePrLvOoWYAEE7eLhE3VN7zJtjrXGphrWTJxDBJSbRbhCv4BymKjfwUUhoRSgFRTFSj
         OYBg==
X-Forwarded-Encrypted: i=1; AJvYcCXJkEyamzE8Vg+YY7MkpT8bojR3jrQDUz95LLmUR/dtj9K2viulZPUnamAcPxHVc5Mz3UX1KJV3/UukbTcYqA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwSMeZG4UYKXlAH0TzYTvOyqaCIw4L7wabBu/6XRuHS+3GUDFru
	Yk0J35jtQH9l7D8bU3InKESPHJ3Nvx+GgRtwokaMFEDF5Rgnl9pr
X-Google-Smtp-Source: AGHT+IHiV6tPKJU6xFMFKChTRvEoSmEhzOHxZY6ROFGufEmzbeWXU2MDxsZIoFwYfMUj+4BZGq9rtg==
X-Received: by 2002:a17:907:c29:b0:a9e:b0a3:db75 with SMTP id a640c23a62f3a-aa1b10a4aaemr815730066b.35.1731542004284;
        Wed, 13 Nov 2024 15:53:24 -0800 (PST)
Received: from [192.168.0.50] ([79.113.150.231])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9ee0def026sm930823266b.163.2024.11.13.15.53.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Nov 2024 15:53:23 -0800 (PST)
Message-ID: <cffda704-eba8-4c5b-bdad-5176c3f11af9@gmail.com>
Date: Thu, 14 Nov 2024 01:53:19 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
Subject: Re: [PATCH v4 4/7] wifi: rtw88: Add rtw8821a.{c,h}
To: Kees Bakker <kees@ijzerbout.nl>,
 "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: Ping-Ke Shih <pkshih@realtek.com>
References: <435af284-0794-48e0-81a5-5a88b3c454bf@gmail.com>
 <37218648-ada7-4fad-b7bd-d2aee28cefb9@gmail.com>
 <4737329a-6d7d-4244-92f0-3ec4849f5893@ijzerbout.nl>
Content-Language: en-US
In-Reply-To: <4737329a-6d7d-4244-92f0-3ec4849f5893@ijzerbout.nl>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 12/11/2024 22:29, Kees Bakker wrote:
> Op 30-10-2024 om 19:28 schreef Bitterblue Smith:
>> These contain code specific to RTL8821AU.
>>
>> Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
>> ---
>> v2:
>>   - Patch is new in v2.
>>   - All of this used to be in patch 18/20 in v1.
>>   - Use "k < 3" instead of "k <= 2" in the IQK code.
>>   - Replace some while loops with for loops in the IQK code.
>>   - Use rtw_write8 instead of rtw_write8_mask in
>>     rtw8821a_coex_cfg_ant_switch. The mask was 0xff.
>>   - Constify structs/arrays.
>>
>> v3:
>>   - No change.
>>
>> v4:
>>   - No change.
>> ---
>>   drivers/net/wireless/realtek/rtw88/rtw8821a.c | 1197 +++++++++++++++++
>>   drivers/net/wireless/realtek/rtw88/rtw8821a.h |   10 +
>>   2 files changed, 1207 insertions(+)
>>   create mode 100644 drivers/net/wireless/realtek/rtw88/rtw8821a.c
>>   create mode 100644 drivers/net/wireless/realtek/rtw88/rtw8821a.h
>>
>> diff --git a/drivers/net/wireless/realtek/rtw88/rtw8821a.c b/drivers/net/wireless/realtek/rtw88/rtw8821a.c
>> [...]
>> +        for (cal_retry = 0; cal_retry < 10; cal_retry++) {
>> +            /* one shot */
>> +            rtw_write32(rtwdev, REG_IQK_COM64, 0xfa000000);
>> +            rtw_write32(rtwdev, REG_IQK_COM64, 0xf8000000);
>> +
>> +            mdelay(10);
>> +
>> +            rtw_write32(rtwdev, REG_RFECTL_A, 0x00000000);
>> +
>> +            for (delay_count = 0; delay_count < 20; delay_count++) {
>> +                iqk_ready = rtw_read32_mask(rtwdev,
>> +                                REG_IQKA_END,
>> +                                BIT(10));
>> +
>> +                /* Originally: if (~iqk_ready || delay_count > 20)
>> +                 * that looks like a typo so make it more explicit
>> +                 */
>> +                iqk_ready = true;
> This looks a bit suspicious. Why ignore the result from rtw_read32_mask()?
> What do you mean by "Originally ... so make it more explicit"?

Yes, that's strange. I'm guessing the practice didn't align
with the theory--the hardware is not working as expected.
I tried it, bit 10 of REG_IQKA_END doesn't turn 1 in those
20 iterations.

"Originally" means as seen in the driver released by Realtek:
https://github.com/morrownr/8821au-20210708/blob/0b12ea54b7d6dcbfa4ce94eb403b1447565407f1/hal/phydm/halrf/rtl8821a/halrf_iqk_8821a_ce.c#L328

>> +
>> +                if (iqk_ready)
>> +                    break;
>> +
>> +                mdelay(1);
>> +            }
>> +
>> +            if (delay_count < 20) {
>> +                /* ============TXIQK Check============== */
>> +                tx_fail = rtw_read32_mask(rtwdev,
>> +                              REG_IQKA_END,
>> +                              BIT(12));
>> +
>> +                /* Originally: if (~tx_fail) {
>> +                 * It looks like a typo, so make it more explicit.
>> +                 */
>> +                tx_fail = false;
> This also looks suspicious. Again, why ignore the result of rtw_read32_mask()?
>> +
>> +                if (!tx_fail) {
>> +                    rtw_write32(rtwdev, REG_RFECTL_A,
>> +                            0x02000000);
>> +                    vdf_x[k] = rtw_read32_mask(rtwdev,
>> +                                   REG_IQKA_END,
>> +                                   0x07ff0000);
>> +                    vdf_x[k] <<= 21;
>> +
>> +                    rtw_write32(rtwdev, REG_RFECTL_A,
>> +                            0x04000000);
>> +                    vdf_y[k] = rtw_read32_mask(rtwdev,
>> +                                   REG_IQKA_END,
>> +                                   0x07ff0000);
>> +                    vdf_y[k] <<= 21;
>> +
>> +                    *tx0iqkok = true;
>> +                    break;
>> +                }
>> +
> The next rtw_write32_mask()'s are dead code because of tx_fail = false

Yes, looks that way.

>> +                rtw_write32_mask(rtwdev, REG_IQC_Y,
>> +                         0x000007ff, 0x0);
>> +                rtw_write32_mask(rtwdev, REG_IQC_X,
>> +                         0x000007ff, 0x200);
>> +            }
>> +
>> +            *tx0iqkok = false;
>> +        }
>> +    }
>> +
>>


