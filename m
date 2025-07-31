Return-Path: <linux-wireless+bounces-26071-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AA25B1770B
	for <lists+linux-wireless@lfdr.de>; Thu, 31 Jul 2025 22:19:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 371711725F3
	for <lists+linux-wireless@lfdr.de>; Thu, 31 Jul 2025 20:19:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA45C1A7AE3;
	Thu, 31 Jul 2025 20:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="p5AT7MjZ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7009921FF40
	for <linux-wireless@vger.kernel.org>; Thu, 31 Jul 2025 20:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753993158; cv=none; b=T1LCWJQ0zUuAgssK3fHpxkTzeSmv9qW8R4pLswcSIRoXp8G9SiDRLzwO60s5GOAUWEa+tZzx9QEpYXtFMoSfviQGZDfnOOOJ5kNmCFH10M15q/fIIPkzYzcQaPnFQ9YYkzNlUHUthAGueA7IqOvfVZnOjxPXX2CiZF3DZ9MfHnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753993158; c=relaxed/simple;
	bh=M1wGUFoGwSBNtl0EAEpuSRNInuY6DP6zBL/VTRBSBpQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AFH9VYFe5xJrgLAcgcyhYuyx8hkChdeuahW0y2ZA6l6+ma3g88MK6VD1w3L/y6im417o1ywgr1mWK2GnJ7i5K9RafaoF8uiK512HjQajhPtMbfRS19e11sswS/hyDyzfUEeqmDsYUYEHhuEEqaJG4i3iyfLeIilZMZs01DBST+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=p5AT7MjZ; arc=none smtp.client-ip=91.218.175.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <7865d95f-a92e-405d-bc71-f1e1382ad24c@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1753993154;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LZp1m8pcMkSudYnC+ixvkpaNmPsQEuz7a5hSG6WIj4Y=;
	b=p5AT7MjZpi4n7M6TTNe6f81+NgZcuNti4Lxsm9adW1IRO8UHbjJ8JZSkPknqViynlUGGfZ
	0vOrNQBFw3MRdtBo7/UzNesZMmkblbh29vWvGelKtH2sR4SFuKna/TIvZ585/iVAQWP5Mm
	77JcXKsvDfSihOgPWO3iWjJ+kG4bSJE=
Date: Thu, 31 Jul 2025 16:19:12 -0400
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v2] wifi: rtw89: Print just once for unknown C2H classes
To: Ping-Ke Shih <pkshih@realtek.com>,
 "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Bitterblue Smith <rtl8821cerfe2@gmail.com>
References: <d2d62793-046c-4b55-93ed-1d1f43cff7f2@gmail.com>
 <20250729204437.164320-1-sean.anderson@linux.dev>
 <c034d5cc40784bfa859f918806c567de@realtek.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Sean Anderson <sean.anderson@linux.dev>
In-Reply-To: <c034d5cc40784bfa859f918806c567de@realtek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 7/29/25 20:36, Ping-Ke Shih wrote:
> Sean Anderson <sean.anderson@linux.dev> wrote:
>> There are more unsupported functions than just LOWRT_RTY. Improve on
>> commit 3b66519b023b ("wifi: rtw89: phy: add dummy c2h handler to avoid
>> warning message") by printing a message just once when we first
>> encounter an unsupported class. 
> 
> Once I encounter an unsupported class/func, I'll check firmware team if the
> C2H events can be ignored. If so, I add a dummy function to avoid the message.
> If not, I should add code to handle the event. 
> 
> Do you want to see the message even though it only appears once?

I mean, maybe it should just be a debug? Are these messages useful for anyone
other than the developers?

Maybe we should just print only the very first unsupported message at info level
and print the rest at debug.

--Sean

>> Do the same for each unsupported func of
>> the supported classes. This prevents messages like
>> 
>> rtw89_8922ae 0000:81:00.0: PHY c2h class 2 not support
>> 
>> from filling up dmesg.
>> 
>> Signed-off-by: Sean Anderson <sean.anderson@linux.dev>
>> ---
>> 
>> Changes in v2:
>> - Also suppress unsupported func messages
>> 
>>  drivers/net/wireless/realtek/rtw89/phy.c | 18 +++++++++++++++---
>>  1 file changed, 15 insertions(+), 3 deletions(-)
>> 
>> diff --git a/drivers/net/wireless/realtek/rtw89/phy.c b/drivers/net/wireless/realtek/rtw89/phy.c
>> index f4eee642e5ce..9484d80eea9b 100644
>> --- a/drivers/net/wireless/realtek/rtw89/phy.c
>> +++ b/drivers/net/wireless/realtek/rtw89/phy.c
>> @@ -3535,17 +3535,25 @@ void rtw89_phy_c2h_handle(struct rtw89_dev *rtwdev, struct sk_buff *skb,
>>  {
>>         void (*handler)(struct rtw89_dev *rtwdev,
>>                         struct sk_buff *c2h, u32 len) = NULL;
>> +       static DECLARE_BITMAP(printed_ra, U8_MAX);
>> +       static DECLARE_BITMAP(printed_rfk_log, U8_MAX);
>> +       static DECLARE_BITMAP(printed_rfk_report, U8_MAX);
>> +       static DECLARE_BITMAP(printed_class, U8_MAX);
>> +       unsigned long *printed;
>> 
>>         switch (class) {
>>         case RTW89_PHY_C2H_CLASS_RA:
>> +               printed = printed_ra;
>>                 if (func < RTW89_PHY_C2H_FUNC_RA_MAX)
>>                         handler = rtw89_phy_c2h_ra_handler[func];
>>                 break;
>>         case RTW89_PHY_C2H_RFK_LOG:
>> +               printed = printed_rfk_log;
>>                 if (func < ARRAY_SIZE(rtw89_phy_c2h_rfk_log_handler))
>>                         handler = rtw89_phy_c2h_rfk_log_handler[func];
>>                 break;
>>         case RTW89_PHY_C2H_RFK_REPORT:
>> +               printed = printed_rfk_report;
>>                 if (func < ARRAY_SIZE(rtw89_phy_c2h_rfk_report_handler))
>>                         handler = rtw89_phy_c2h_rfk_report_handler[func];
>>                 break;
>> @@ -3554,12 +3562,16 @@ void rtw89_phy_c2h_handle(struct rtw89_dev *rtwdev, struct sk_buff *skb,
>>                         return;
>>                 fallthrough;
>>         default:
>> -               rtw89_info(rtwdev, "PHY c2h class %d not support\n", class);
>> +               if (!test_and_set_bit(class, printed_class))
>> +                       rtw89_info(rtwdev, "PHY c2h class %d not supported\n",
>> +                                  class);
>>                 return;
>>         }
>>         if (!handler) {
>> -               rtw89_info(rtwdev, "PHY c2h class %d func %d not support\n", class,
>> -                          func);
>> +               if (!test_and_set_bit(func, printed))
>> +                       rtw89_info(rtwdev,
>> +                                  "PHY c2h class %d func %d not supported\n",
>> +                                  class, func);
>>                 return;
>>         }
>>         handler(rtwdev, skb, len);
>> --
>> 2.35.1.1320.gc452695387.dirty
> 


