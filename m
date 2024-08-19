Return-Path: <linux-wireless+bounces-11627-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 03085957269
	for <lists+linux-wireless@lfdr.de>; Mon, 19 Aug 2024 19:51:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 96D5DB218A9
	for <lists+linux-wireless@lfdr.de>; Mon, 19 Aug 2024 17:51:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A799186E2A;
	Mon, 19 Aug 2024 17:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d7rKYbeh"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B12CA16132E
	for <linux-wireless@vger.kernel.org>; Mon, 19 Aug 2024 17:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724089897; cv=none; b=K5WPv/PvOR75k0mYrpPrR58TeABWbYPCC82Ch2WgnOjvuC017qeKQco2mPzh6aFZ8Y5gV3fVm+sXpW/0wdfa180z+Ks3/12xRDXtzi4DJWH2CJoVgk5S75/G6VE2RzIXelF3nujKb9V30nOJJnvnHh8GiMkZE1iSvRq6iGaW48U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724089897; c=relaxed/simple;
	bh=KR39pDnsKhpR0b8J+Zug5FNKmPl4E4WCPZIRH5KH0h4=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:References:
	 In-Reply-To:Content-Type; b=BJd8Boozcvi//NKXzklorElSf6I9ojy2yeKoRVk56wLEl4/nQSsihjQk/nuTUvid+AnYrLthm/UthuJV7t992XHGN+qTvzUp2Kf1Vpl3W2H3RJMboqmL+cr8dZFx9JoSMVZihkvG0Ay+eXTUJ2dOzx/+z0E40LFqjfTe21m4KDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d7rKYbeh; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5bed83489c3so3076654a12.3
        for <linux-wireless@vger.kernel.org>; Mon, 19 Aug 2024 10:51:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724089894; x=1724694694; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :to:subject:from:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WlJp+GHSamTwJ8z6+iI75n6zs/pAv1jqNQHxBmY0XNk=;
        b=d7rKYbehOApTRqgMIOOzfUTsxQzv0Bolj4AjLTzZ/iJzVReXWLOMf2r57vMPMLk7xZ
         vIXtjMYKOzqmn1ExhciMeooVa3QmWbZwPFZ8rfY2L+33cJn0Pj7UbWGWtiS+wHARuu1Q
         1H/nfSNwnozPJ/aL/AcUzLT8HKAvK0knWidMsQ5xaqFaYJEHg+m0k2za+XUJRF+EZtVS
         TVQTEoVL8vqrc6KChT0/6uwsEv5+fsQHR2FiPmfaiSO1OMoUNKbb086LKO+dtN6hRQ+i
         tkMeKKaGwx1+4f5yQm4DG1/Mfp5l1jdDhjk9tPDW/jfHcEHiLfYBZ5Cek7182j3AUXQV
         Qh+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724089894; x=1724694694;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WlJp+GHSamTwJ8z6+iI75n6zs/pAv1jqNQHxBmY0XNk=;
        b=DZm5gLotrKlpS/H/0JTsQMpsLm6kL531vM0SnyYaQjY95kvIEx1vpBYJuo/JiEQ3e4
         W91eq8VXsciMJDicxPfQIlOEp8OK87DJ0AoPf3TAe/DAkBcxNOlIAu+pRkg8vxQY//Yf
         iWnIuoCr2l/cp+4hfUI5UW64gLdPldEkAk1B5B6d2ivw6qM7bACt5O7CJa5yUjDyA2nW
         RLTko3YmGW+x8j3grz6PLe7ezYwRaxEBXD9DAWHJSbunUp4RXsg+HXaLzWSoaOive5Es
         B/wiBOmBKaDWhBpb5JoBHCryWWJH6BR4sZw0yzXXhozeV+77nbZvlB5Yw5BjeavEjfH5
         HE4g==
X-Forwarded-Encrypted: i=1; AJvYcCVSciOQjtxXdRYgfEDeG7lFth3sE8IbLJpeDRwvB1XMMz0tVT/gndIaIfSp80QuMEnhEAUkr+fdFjau6HRZLtBUCyajjAxUj6K0yUo7ZOc=
X-Gm-Message-State: AOJu0YyIDUywqABNlVpT/+3QPfCPWHfE/2ij2sDYltt6O7JCnoy1bjSl
	xXAh24GBjVFZ4pkWkFmbnb/1CsvlmlGhALw01T9sH36djKcZEPeY
X-Google-Smtp-Source: AGHT+IGbulldIQ6ndZKMmC35x6E6LeO+Me6iULcntPI41WPqcwy684YHn2wcjnQpWOVqC8065q7RqA==
X-Received: by 2002:a17:906:f595:b0:a77:dd1c:6273 with SMTP id a640c23a62f3a-a83928a9930mr886528866b.12.1724089893366;
        Mon, 19 Aug 2024 10:51:33 -0700 (PDT)
Received: from [192.168.0.50] ([79.119.240.114])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a83838c6687sm661597766b.33.2024.08.19.10.51.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Aug 2024 10:51:33 -0700 (PDT)
Message-ID: <dbef5db6-9455-4b75-8bc9-baacc93d3492@gmail.com>
Date: Mon, 19 Aug 2024 20:51:31 +0300
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
Subject: Re: [PATCH 02/20] wifi: rtw88: Dump the HW features only for some
 chips
To: Ping-Ke Shih <pkshih@realtek.com>,
 "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
References: <ade57ca1-444f-49e2-b49e-f4b9da65b2cc@gmail.com>
 <32cce43e-8495-4f82-8ab4-527e1606fee3@gmail.com>
 <25cc8b40a3754e5c8e444aedaae5e8aa@realtek.com>
Content-Language: en-US
In-Reply-To: <25cc8b40a3754e5c8e444aedaae5e8aa@realtek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 15/08/2024 09:10, Ping-Ke Shih wrote:
> Bitterblue Smith <rtl8821cerfe2@gmail.com> wrote:
>> RTL8821AU and RTL8812AU don't support this. They hit the "failed to read
>> hw feature report" error.
>>
>> Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
>> ---
>>  drivers/net/wireless/realtek/rtw88/main.c     | 4 ++++
>>  drivers/net/wireless/realtek/rtw88/main.h     | 1 +
>>  drivers/net/wireless/realtek/rtw88/rtw8703b.c | 1 +
>>  drivers/net/wireless/realtek/rtw88/rtw8723d.c | 1 +
>>  drivers/net/wireless/realtek/rtw88/rtw8821c.c | 1 +
>>  drivers/net/wireless/realtek/rtw88/rtw8822b.c | 1 +
>>  drivers/net/wireless/realtek/rtw88/rtw8822c.c | 1 +
>>  7 files changed, 10 insertions(+)
>>
>> diff --git a/drivers/net/wireless/realtek/rtw88/main.c b/drivers/net/wireless/realtek/rtw88/main.c
>> index ff045dfdca4a..aeb21ac25e2e 100644
>> --- a/drivers/net/wireless/realtek/rtw88/main.c
>> +++ b/drivers/net/wireless/realtek/rtw88/main.c
>> @@ -1923,6 +1923,9 @@ static int rtw_dump_hw_feature(struct rtw_dev *rtwdev)
>>         u8 bw;
>>         int i;
>>
>> +       if (!rtwdev->chip->hw_feature_report)
>> +               goto print_hw_cap;
> 
> Since chips don't support of hw_feature_report, printing hw capabilities seems
> useless. Just 'return'?
> 

efuse->hw_cap is filled earlier in rtw8812a_read_usb_type(),
so printing here is not entirely useless. But maybe it is
cleaner to return here and print these things in
rtw8812a_read_usb_type().

>> +
>>         id = rtw_read8(rtwdev, REG_C2HEVT);
>>         if (id != C2H_HW_FEATURE_REPORT) {
>>                 rtw_err(rtwdev, "failed to read hw feature report\n");
>> @@ -1947,6 +1950,7 @@ static int rtw_dump_hw_feature(struct rtw_dev *rtwdev)
>>             efuse->hw_cap.nss > rtwdev->hal.rf_path_num)
>>                 efuse->hw_cap.nss = rtwdev->hal.rf_path_num;
>>
>> +print_hw_cap:
>>         rtw_dbg(rtwdev, RTW_DBG_EFUSE,
>>                 "hw cap: hci=0x%02x, bw=0x%02x, ptcl=0x%02x, ant_num=%d, nss=%d\n",
>>                 efuse->hw_cap.hci, efuse->hw_cap.bw, efuse->hw_cap.ptcl,
> 
> [...]
> 


