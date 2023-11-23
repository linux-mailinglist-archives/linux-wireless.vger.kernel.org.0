Return-Path: <linux-wireless+bounces-2-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CCBC7F55E9
	for <lists+linux-wireless@lfdr.de>; Thu, 23 Nov 2023 02:33:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B07851F20E7A
	for <lists+linux-wireless@lfdr.de>; Thu, 23 Nov 2023 01:33:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AF151385;
	Thu, 23 Nov 2023 01:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail.nfschina.com (unknown [42.101.60.195])
	by lindbergh.monkeyblade.net (Postfix) with SMTP id 7436912A;
	Wed, 22 Nov 2023 17:33:17 -0800 (PST)
Received: from [172.30.11.106] (unknown [180.167.10.98])
	by mail.nfschina.com (Maildata Gateway V2.8.8) with ESMTPSA id D4D2F6027E05F;
	Thu, 23 Nov 2023 09:33:06 +0800 (CST)
Message-ID: <a9032c3a-8221-11fb-ed15-2c57c3933d28@nfschina.com>
Date: Thu, 23 Nov 2023 09:33:06 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH wireless-next 2/2] rtlwifi: rtl8821ae: phy: fix an
 undefined bitwise shift behavior
Content-Language: en-US
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: pkshih@realtek.com, kvalo@kernel.org, nathan@kernel.org,
 ndesaulniers@google.com, trix@redhat.com, lizetao1@huawei.com,
 linville@tuxdriver.com, Larry.Finger@lwfinger.net,
 linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
 llvm@lists.linux.dev, kernel-janitors@vger.kernel.org
X-MD-Sfrom: suhui@nfschina.com
X-MD-SrcIP: 180.167.10.98
From: Su Hui <suhui@nfschina.com>
In-Reply-To: <2ec14802-78b0-4a3f-a730-19e95ec8d359@suswa.mountain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2023/11/22 21:02, Dan Carpenter wrote:
> On Wed, Nov 22, 2023 at 05:02:12PM +0800, Su Hui wrote:
>> Clang staic checker warning:
>> drivers/net/wireless/realtek/rtlwifi/rtl8821ae/phy.c:184:49:
>> 	The result of the left shift is undefined due to shifting by '32',
>> 	which is greater or equal to the width of type 'u32'.
>> 	[core.UndefinedBinaryOperatorResult]
>>
>> If the value of the right operand is negative or is greater than or
>> equal to the width of the promoted left operand, the behavior is
>> undefined.[1][2]
>>
>> For example, when using different gcc's compilation optimizaation options
>> (-O0 or -O2), the result of '(u32)data << 32' is different. One is 0, the
>> other is old value of data. Adding an u64 cast to fix this problem.
>>
>> [1]:https://stackoverflow.com/questions/11270492/what-does-the-c-
>> standard-say-about-bitshifting-more-bits-than-the-width-of-type
>> [2]:https://www.open-std.org/jtc1/sc22/wg14/www/docs/n1256.pdf
>>
>> Fixes: 21e4b0726dc6 ("rtlwifi: rtl8821ae: Move driver from staging to regular tree")
>> Signed-off-by: Su Hui <suhui@nfschina.com>
>> ---
>>   drivers/net/wireless/realtek/rtlwifi/rtl8821ae/phy.c | 8 ++++----
>>   1 file changed, 4 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8821ae/phy.c b/drivers/net/wireless/realtek/rtlwifi/rtl8821ae/phy.c
>> index 6df270e29e66..89713e0587b5 100644
>> --- a/drivers/net/wireless/realtek/rtlwifi/rtl8821ae/phy.c
>> +++ b/drivers/net/wireless/realtek/rtlwifi/rtl8821ae/phy.c
>> @@ -106,7 +106,7 @@ u32 rtl8821ae_phy_query_bb_reg(struct ieee80211_hw *hw, u32 regaddr,
>>   		regaddr, bitmask);
>>   	originalvalue = rtl_read_dword(rtlpriv, regaddr);
>>   	bitshift = _rtl8821ae_phy_calculate_bit_shift(bitmask);
>> -	returnvalue = (originalvalue & bitmask) >> bitshift;
>> +	returnvalue = (u64)(originalvalue & bitmask) >> bitshift;
> This is a right shift, not a left shift. << vs >>.

Hi,

It's same for right shift and having a really weird result.

The result of '(u32)data >> 32' is different when using different compiler.
Clang: "(unsigned int)41 >> 32" = 2077469672
Gcc: "(unsigned int)41 >> 32" = 0
>
>>   
>>   	rtl_dbg(rtlpriv, COMP_RF, DBG_TRACE,
>>   		"BBR MASK=0x%x Addr[0x%x]=0x%x\n",
>> @@ -128,7 +128,7 @@ void rtl8821ae_phy_set_bb_reg(struct ieee80211_hw *hw,
>>   		originalvalue = rtl_read_dword(rtlpriv, regaddr);
>>   		bitshift = _rtl8821ae_phy_calculate_bit_shift(bitmask);
>>   		data = ((originalvalue & (~bitmask)) |
>> -			((data << bitshift) & bitmask));
>> +			(((u64)data << bitshift) & bitmask));
> The checker is printing an accurate warning, however, I'm not sure the
> fix is correct.  Obviously, shift wrapping is bad and your patch would
> eliminate that possibility.  However, data is a u32 so we end up
> discarding the high 32 bits.  I can imagine a different static checker
> would complain about that.

Oh, it's my negligence...

Su Hui


