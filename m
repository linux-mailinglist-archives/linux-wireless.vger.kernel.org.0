Return-Path: <linux-wireless+bounces-15025-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB37E9BFB36
	for <lists+linux-wireless@lfdr.de>; Thu,  7 Nov 2024 02:14:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 07E571C20F74
	for <lists+linux-wireless@lfdr.de>; Thu,  7 Nov 2024 01:14:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 979C679D0;
	Thu,  7 Nov 2024 01:14:24 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail.nfschina.com (unknown [42.101.60.213])
	by smtp.subspace.kernel.org (Postfix) with SMTP id 9BB77624;
	Thu,  7 Nov 2024 01:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=42.101.60.213
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730942064; cv=none; b=pztnYHFsoCFYhSNPtC7urm4DB2Jz+Wfshj5fBom9DKF9M/icENrvSzKbUFNrsFHUr61OEBBGg5WWeBObQAd+ZECotQI2J98h75cAKG0nVqNecLY4CDywwQfp20+INp2mgyOrwGSdMtO0m+XIUALbhRaIOMVtjly/ASIM5S0B68M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730942064; c=relaxed/simple;
	bh=wdYNjXTXOpW7VNLN4lVYFboD+B1sbsImAPPoIXLzBBk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type; b=XUjS1mMmZcQWlmhjuAA9Hz9nf/MiLKJzj5UXjxLtAXh8nVMtyYS+rG5908Liwr5Mg7vRWv9Lb8iLEd1IStzZu9mxglY1KCXSw/ypoOetod+VYlAz47hQLrm79KfEkCG8Mw8NnkUt1zHw3VEz98nq5muQjUKAVX1eGOA22sY9Aho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nfschina.com; spf=pass smtp.mailfrom=nfschina.com; arc=none smtp.client-ip=42.101.60.213
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nfschina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nfschina.com
Received: from [172.30.20.101] (unknown [180.167.10.98])
	by mail.nfschina.com (MailData Gateway V2.8.8) with ESMTPSA id A5DCB601059CF;
	Thu,  7 Nov 2024 09:14:07 +0800 (CST)
Message-ID: <8f57aa57-596c-174f-27b3-19d8aa60cc89@nfschina.com>
Date: Thu, 7 Nov 2024 09:14:07 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.1
Subject: Re: [PATCH] wifi: rtlwifi: rtl8821ae: phy: restore removed code to
 fix infinite loop
Content-Language: en-US
To: Ping-Ke Shih <pkshih@realtek.com>, Colin Ian King
 <colin.i.king@gmail.com>, Kalle Valo <kvalo@kernel.org>,
 "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "stable@vger.kernel.org" <stable@vger.kernel.org>
X-MD-Sfrom: suhui@nfschina.com
X-MD-SrcIP: 180.167.10.98
From: Su Hui <suhui@nfschina.com>
In-Reply-To: <c39feb8063924701b99965e6b650c993@realtek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024/11/7 08:51, Ping-Ke Shih wrote:
> Colin Ian King <colin.i.king@gmail.com> wrote:
>> A previous clean-up fix removed the assignment of v2 inside a while loop
>> that turned it into an infinite loop. Fix this by restoring the assignment
>> of v2 from array[] so that v2 is updated inside the loop.
>>
>> Fixes: cda37445718d ("wifi: rtlwifi: rtl8821ae: phy: remove some useless code")
>> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>

Thanks for your correction. I'm sorry for this stupid mistake.

Reviewed-by: Su Hui <suhui@nfschina.com>

> I tested RTL8812AE/8821AE. Luckily, parsing current PHY register parameters
> never falls into the check condition.
>
> Tested-by: Ping-Ke Shih <pkshih@realtek.com>
>> ---
>>   drivers/net/wireless/realtek/rtlwifi/rtl8821ae/phy.c | 4 +++-
>>   1 file changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8821ae/phy.c
>> b/drivers/net/wireless/realtek/rtlwifi/rtl8821ae/phy.c
>> index 1be51ea3f3c8..0d4d787e8be5 100644
>> --- a/drivers/net/wireless/realtek/rtlwifi/rtl8821ae/phy.c
>> +++ b/drivers/net/wireless/realtek/rtlwifi/rtl8821ae/phy.c
>> @@ -2033,8 +2033,10 @@ static bool _rtl8821ae_phy_config_bb_with_pgheaderfile(struct ieee80211_hw *hw,
>>                          if (!_rtl8821ae_check_condition(hw, v1)) {
>>                                  i += 2; /* skip the pair of expression*/
>>                                  v2 = array[i+1];
>> -                               while (v2 != 0xDEAD)
>> +                               while (v2 != 0xDEAD) {
>>                                          i += 3;
>> +                                       v2 = array[i + 1];
>> +                               }
>>                          }
>>                  }
>>          }
>> --
>> 2.39.5

