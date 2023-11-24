Return-Path: <linux-wireless+bounces-47-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CBB717F70CC
	for <lists+linux-wireless@lfdr.de>; Fri, 24 Nov 2023 11:06:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 860702813C9
	for <lists+linux-wireless@lfdr.de>; Fri, 24 Nov 2023 10:06:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C48A1803D;
	Fri, 24 Nov 2023 10:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail.nfschina.com (unknown [42.101.60.195])
	by lindbergh.monkeyblade.net (Postfix) with SMTP id 05156D73;
	Fri, 24 Nov 2023 02:06:15 -0800 (PST)
Received: from [172.30.11.106] (unknown [180.167.10.98])
	by mail.nfschina.com (Maildata Gateway V2.8.8) with ESMTPSA id 35883613FF940;
	Fri, 24 Nov 2023 18:06:12 +0800 (CST)
Message-ID: <cb551005-eff0-1391-92a0-d956b3d2b930@nfschina.com>
Date: Fri, 24 Nov 2023 18:06:11 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH v2 2/2] wifi: rtlwifi: rtl8821ae: phy: fix an undefined
 bitwise shift behavior
Content-Language: en-US
To: Ping-Ke Shih <pkshih@realtek.com>,
 "dan.carpenter@linaro.org" <dan.carpenter@linaro.org>,
 "kvalo@kernel.org" <kvalo@kernel.org>, "nathan@kernel.org"
 <nathan@kernel.org>, "ndesaulniers@google.com" <ndesaulniers@google.com>,
 "trix@redhat.com" <trix@redhat.com>
Cc: "lizetao1@huawei.com" <lizetao1@huawei.com>,
 "linville@tuxdriver.com" <linville@tuxdriver.com>,
 "Larry.Finger@lwfinger.net" <Larry.Finger@lwfinger.net>,
 "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "llvm@lists.linux.dev" <llvm@lists.linux.dev>,
 "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>
X-MD-Sfrom: suhui@nfschina.com
X-MD-SrcIP: 180.167.10.98
From: Su Hui <suhui@nfschina.com>
In-Reply-To: <167fbc7a77db447d90f696666f6f0a9b@realtek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2023/11/24 16:51, Ping-Ke Shih wrote:
> Subject: [PATCH v2 2/2] wifi: rtlwifi: rtl8821ae: phy: fix an undefined bitwise shift behavior
>
> [...]
>> diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8821ae/phy.c
>> b/drivers/net/wireless/realtek/rtlwifi/rtl8821ae/phy.c
>> index 6df270e29e66..52ab1b0761c0 100644
>> --- a/drivers/net/wireless/realtek/rtlwifi/rtl8821ae/phy.c
>> +++ b/drivers/net/wireless/realtek/rtlwifi/rtl8821ae/phy.c
>> @@ -31,7 +31,12 @@ static u32 _rtl8821ae_phy_calculate_bit_shift(u32 bitmask)
>>   {
>>          u32 i = ffs(bitmask);
>>
>> -       return i ? i - 1 : 32;
>> +       if (!i) {
>> +               WARN_ON_ONCE(1);
>> +               return 0;
>> +       }
>> +
>> +       return i - 1;
>>   }
> Personally, I prefer to use __ffs(), because in normal case no need additional '-1',
> and abnormal cases should not happen.

Hi,  Ping-Ke

Replace _rtl8821ae_phy_calculate_bit_shift() by __ffs(bitmask) is better,
but I'm not sure what callers should do when callers check bitmask is 0 before calling.
Maybe this check is useless?

I can send a v3 patch if using  __ffs(bitmask) and no check for bitmask is fine.
Or could you send this patch if you have a better idea?
Thanks for your suggestion!

Su Hui


