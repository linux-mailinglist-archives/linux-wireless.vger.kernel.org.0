Return-Path: <linux-wireless+bounces-26080-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D6DCB18414
	for <lists+linux-wireless@lfdr.de>; Fri,  1 Aug 2025 16:39:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AF9C87B4765
	for <lists+linux-wireless@lfdr.de>; Fri,  1 Aug 2025 14:38:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A832B26E6FF;
	Fri,  1 Aug 2025 14:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="TkzPCibs"
X-Original-To: linux-wireless@vger.kernel.org
Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4038822069A
	for <linux-wireless@vger.kernel.org>; Fri,  1 Aug 2025 14:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754059191; cv=none; b=PabzjaCxKI8Ho/pJcboepT6/7bhwOqfRUHFL6uQvxuAnHEH+fyuoeA3RypTR2K/WIrr4fFJQTEgWFBTDNmVSY6649sOkHamRwVVinUvkTIEttwPFAjDePvkLF6tcQNE7AwGhsYpPLqSWJpRhOfz8dlJ8GRFBtPzw3Us55h4UjfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754059191; c=relaxed/simple;
	bh=U6/epH0hJ+ApfTd5Na0K3Dw9MJYRu1affSBvnM4hn4U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AnkLZQLVI4qcNuR9CMJ05C3TzPLCA+XHyEe6PiELJvGQcKZELzm2WyH10QlQ00SUaN5+AeQZmB+1Zw9rbKswSP8Q9vSTMkyTzsW1vq8CglPtauAAP5DqMyUPXtPjZPf2gdwNB03cM8Ex77zBfnKugOxhTPF2HFUR6XEUqz+m6vc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=TkzPCibs; arc=none smtp.client-ip=91.218.175.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <5d503670-6acb-4957-b209-b55f0fa70c32@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1754059187;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=U0l4pOecHy84hXNiWe8EPCjXNXfgPGWH4yzTD/8eK+4=;
	b=TkzPCibsKnHKNi2CqS9euWpAYWqKPxH3Lzw74pRgsP6CconhK3jZoU326YMq4EFfKqCbLW
	UnSM92lcOv8BSnelwIX52ZmpcD9TEbH58BA8I68LaEBxj3SOKDQM+THLmcsHOo4bHAMUNw
	0gW+N2QnxJY2EriLZSsGyRbt6nLdDOE=
Date: Fri, 1 Aug 2025 10:39:46 -0400
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
 <b4a69a44-bb9d-4c1d-b628-9204ed8c623e@linux.dev>
 <3de4e7b1ff574e90bef6d670d0e941a4@realtek.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Sean Anderson <sean.anderson@linux.dev>
In-Reply-To: <3de4e7b1ff574e90bef6d670d0e941a4@realtek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 7/31/25 20:36, Ping-Ke Shih wrote:
> Sean Anderson <sean.anderson@linux.dev> wrote:
>> On 7/29/25 23:42, Ping-Ke Shih wrote:
>> > Ping-Ke Shih <pkshih@realtek.com> wrote:
>> >> Sean Anderson <sean.anderson@linux.dev> wrote:
>> >> > There are more unsupported functions than just LOWRT_RTY. Improve on
>> >> > commit 3b66519b023b ("wifi: rtw89: phy: add dummy c2h handler to avoid
>> >> > warning message") by printing a message just once when we first
>> >> > encounter an unsupported class.
>> >>
>> >> Once I encounter an unsupported class/func, I'll check firmware team if the
>> >> C2H events can be ignored. If so, I add a dummy function to avoid the message.
>> >> If not, I should add code to handle the event.
>> >>
>> >> Do you want to see the message even though it only appears once?
>> >>
>> >> > Do the same for each unsupported func of
>> >> > the supported classes. This prevents messages like
>> >> >
>> >> > rtw89_8922ae 0000:81:00.0: PHY c2h class 2 not support
>> >
>> > Is this a real example?
>> 
>> This is a real example.
>> 
>> > We have handled class 2 (RTW89_PHY_C2H_CLASS_DM), no?
>> 
>> If func != RTW89_PHY_C2H_DM_FUNC_LOWRT_RTY then we fall through to the
>> default case.
> 
> Oh. I see. 
> 
>> 
>> > Please point out the class / func you encountered. Then I can look up vendor
>> > driver or contact internal firmware team to know if we should implement or
>> > just add a dummy function.
>> >
>> > If we defer it, I don't know when we can do it.
>> 
>> rtw89_8922ae 0000:81:00.0: PHY c2h class 2 func 12 not supported
>> 
> 
> The C2H event handler has been added by [1].
> 
> [1] d31c42466b1a ("wifi: rtw89: phy: add C2H event handler for report of FW scan")

OK, but func 12 is still not handled by that commit.

--Sean

