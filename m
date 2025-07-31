Return-Path: <linux-wireless+bounces-26070-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E671B17705
	for <lists+linux-wireless@lfdr.de>; Thu, 31 Jul 2025 22:17:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D19EB1C277C1
	for <lists+linux-wireless@lfdr.de>; Thu, 31 Jul 2025 20:18:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 376E8246BB0;
	Thu, 31 Jul 2025 20:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="RCrF7CE4"
X-Original-To: linux-wireless@vger.kernel.org
Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1504F25FA3B
	for <linux-wireless@vger.kernel.org>; Thu, 31 Jul 2025 20:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753993039; cv=none; b=Q5xHItEF1mS1yFex3zPShyxNd6K8QhrriixXPOicqIgU6bjJ1oKF5NECAy51Crdpz8VLYA09/p/YJFDo9jsVix+f1Hh6t89v+imqLitxgKCYu2AsCanU5crahR9uw1l+3Eu0JkkKowOboWa95ECJoNtc46C1dR0Jde9XkF5NxHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753993039; c=relaxed/simple;
	bh=WP0RzqvWSxG08edQB1118I2IQwBuukdBOf0kog0Oa+s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HQ6JTzkB/VBOAGahxQkwcRK8zlCEwiYjgfXN8ZGCyiVsVt0GiQjuLfZq8A0O1iUtDWWMzncxb90glfEd8Vd5epzf/iyNSHyMervrvZD0hct5CRtuF2Se/cUl2QMYZB5yW5im02Kj+DN2cezEf/Ggpg0IanZMMpE0wqCbvMWnjOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=RCrF7CE4; arc=none smtp.client-ip=91.218.175.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <b4a69a44-bb9d-4c1d-b628-9204ed8c623e@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1753993025;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Z5CFG6ot/FwiezqgQLpIuULui88tdtzla/RIVFSNVXc=;
	b=RCrF7CE4JY9RDIDWbjhbapMogXqXpI29jJ4GgAw8LNhxH6BVEVL+m/3kyat1DzVABF7R/T
	tgFTabOk7gp11pm+76khqsvU+1+G9EeZ7H2t6dbj8W/czFPNqPHdGreUz/sIXNckXLuJlE
	TjplP0zimHpmPrYJRLZKQxL+lrc0IHM=
Date: Thu, 31 Jul 2025 16:16:58 -0400
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
 <e8e68a94bb9940509233153f9764c397@realtek.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Sean Anderson <sean.anderson@linux.dev>
In-Reply-To: <e8e68a94bb9940509233153f9764c397@realtek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 7/29/25 23:42, Ping-Ke Shih wrote:
> Ping-Ke Shih <pkshih@realtek.com> wrote:
>> Sean Anderson <sean.anderson@linux.dev> wrote:
>> > There are more unsupported functions than just LOWRT_RTY. Improve on
>> > commit 3b66519b023b ("wifi: rtw89: phy: add dummy c2h handler to avoid
>> > warning message") by printing a message just once when we first
>> > encounter an unsupported class.
>> 
>> Once I encounter an unsupported class/func, I'll check firmware team if the
>> C2H events can be ignored. If so, I add a dummy function to avoid the message.
>> If not, I should add code to handle the event.
>> 
>> Do you want to see the message even though it only appears once?
>> 
>> > Do the same for each unsupported func of
>> > the supported classes. This prevents messages like
>> >
>> > rtw89_8922ae 0000:81:00.0: PHY c2h class 2 not support
> 
> Is this a real example?

This is a real example.

> We have handled class 2 (RTW89_PHY_C2H_CLASS_DM), no?

If func != RTW89_PHY_C2H_DM_FUNC_LOWRT_RTY then we fall through to the
default case.

> Please point out the class / func you encountered. Then I can look up vendor
> driver or contact internal firmware team to know if we should implement or
> just add a dummy function.
> 
> If we defer it, I don't know when we can do it. 

rtw89_8922ae 0000:81:00.0: PHY c2h class 2 func 12 not supported

But the func was not printed in the base kernel, just the class.

--Sean

>> >
>> > from filling up dmesg.
>> >
>> > Signed-off-by: Sean Anderson <sean.anderson@linux.dev>
>> > ---
>> >
>> > Changes in v2:
>> > - Also suppress unsupported func messages
>> >
>> >  drivers/net/wireless/realtek/rtw89/phy.c | 18 +++++++++++++++---
>> >  1 file changed, 15 insertions(+), 3 deletions(-)
>> >
>> > diff --git a/drivers/net/wireless/realtek/rtw89/phy.c b/drivers/net/wireless/realtek/rtw89/phy.c
>> > index f4eee642e5ce..9484d80eea9b 100644
>> > --- a/drivers/net/wireless/realtek/rtw89/phy.c
>> > +++ b/drivers/net/wireless/realtek/rtw89/phy.c
>> > @@ -3535,17 +3535,25 @@ void rtw89_phy_c2h_handle(struct rtw89_dev *rtwdev, struct sk_buff *skb,
>> >  {
>> >         void (*handler)(struct rtw89_dev *rtwdev,
>> >                         struct sk_buff *c2h, u32 len) = NULL;
>> > +       static DECLARE_BITMAP(printed_ra, U8_MAX);
>> > +       static DECLARE_BITMAP(printed_rfk_log, U8_MAX);
>> > +       static DECLARE_BITMAP(printed_rfk_report, U8_MAX);
>> > +       static DECLARE_BITMAP(printed_class, U8_MAX);
>> > +       unsigned long *printed;
>> >
>> >         switch (class) {
>> >         case RTW89_PHY_C2H_CLASS_RA:
>> > +               printed = printed_ra;
>> >                 if (func < RTW89_PHY_C2H_FUNC_RA_MAX)
>> >                         handler = rtw89_phy_c2h_ra_handler[func];
>> >                 break;
>> >         case RTW89_PHY_C2H_RFK_LOG:
>> > +               printed = printed_rfk_log;
>> >                 if (func < ARRAY_SIZE(rtw89_phy_c2h_rfk_log_handler))
>> >                         handler = rtw89_phy_c2h_rfk_log_handler[func];
>> >                 break;
>> >         case RTW89_PHY_C2H_RFK_REPORT:
>> > +               printed = printed_rfk_report;
>> >                 if (func < ARRAY_SIZE(rtw89_phy_c2h_rfk_report_handler))
>> >                         handler = rtw89_phy_c2h_rfk_report_handler[func];
>> >                 break;
>> > @@ -3554,12 +3562,16 @@ void rtw89_phy_c2h_handle(struct rtw89_dev *rtwdev, struct sk_buff *skb,
>> >                         return;
>> >                 fallthrough;
>> >         default:
>> > -               rtw89_info(rtwdev, "PHY c2h class %d not support\n", class);
>> > +               if (!test_and_set_bit(class, printed_class))
>> > +                       rtw89_info(rtwdev, "PHY c2h class %d not supported\n",
>> > +                                  class);
>> >                 return;
>> >         }
>> >         if (!handler) {
>> > -               rtw89_info(rtwdev, "PHY c2h class %d func %d not support\n", class,
>> > -                          func);
>> > +               if (!test_and_set_bit(func, printed))
>> > +                       rtw89_info(rtwdev,
>> > +                                  "PHY c2h class %d func %d not supported\n",
>> > +                                  class, func);
>> >                 return;
>> >         }
>> >         handler(rtwdev, skb, len);
>> > --
>> > 2.35.1.1320.gc452695387.dirty
> 

