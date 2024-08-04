Return-Path: <linux-wireless+bounces-10887-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EF5F0946CB6
	for <lists+linux-wireless@lfdr.de>; Sun,  4 Aug 2024 08:27:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9A5191F22117
	for <lists+linux-wireless@lfdr.de>; Sun,  4 Aug 2024 06:27:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54E18D531;
	Sun,  4 Aug 2024 06:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="AUB4Fw2Q"
X-Original-To: linux-wireless@vger.kernel.org
Received: from msa.smtpout.orange.fr (smtp-74.smtpout.orange.fr [80.12.242.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB12B17999;
	Sun,  4 Aug 2024 06:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722752841; cv=none; b=UvFDvX8ITvxPquhCEaHEKRG36GC0eBj38Z6Mey+497iE/xbCVE2mk/FPoNl7pqvbLT5H+4y8eXBMJg9iI33FctkyNmulC2bIqP4/ImVaAmX4aFhWl8gRW4WQsDjEc/H4pDNpHErq6E+Xu13E6X8IBhety4usRnqaGi6SWox0d+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722752841; c=relaxed/simple;
	bh=lhndWAeFHr6FlmVuGr0sHq7jlCpyqORUtsItvsC44ts=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CuRlqjgXb+39stNGu8XnWj3SwxPsk42bfnvrB8rdyl72Z53CLk8FlWvjmXhJf8ipEiFGL9l1q+GhsthTlfvGKEiqqKz/6JjaYDCMbVpbsbPgA2PWnqSrJhz21gVk/ZPmN7N4R3lAZPQkkfQEo9jpn4xaCIvbxAp0q++YH0dGPe0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=AUB4Fw2Q; arc=none smtp.client-ip=80.12.242.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from [192.168.1.37] ([90.11.132.44])
	by smtp.orange.fr with ESMTPA
	id aUi4szd3e95X4aUi4sqB7f; Sun, 04 Aug 2024 08:27:17 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1722752837;
	bh=8X9F99mm4QYNIwKVcFQ2SYZwZgY/uQ0zZxFeYsHM8Sc=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=AUB4Fw2QEDgEJT7xUvaaoBKaLQVSpWdHt69uOZFyI+G56TcYraHSoIi60t74XUmWZ
	 ha0OIm4aplGvzOAlMtMW280QcyKfM8bUcLK65dgQzfrtKpUeXTupRvP7fJrq9gxjfa
	 xaAbSzyFTDhvTV19v1oWv/yLsbU83oDwP3i0FE4wVOUkKc2iZcVtMNQwNAmhdNf1X9
	 lzC0rbEXz134298XZBibcQ/SZiSjpBsSeXrUAmrK5hgmLx3aahfQPzZUUIbCdVX7uk
	 R349TFhMHjn6U6kdbOtYTQzriFVyfkNylVMP8gdCta1Nk/7AsVD5L6YQz70yR3pu+k
	 zSoM7oxhA42lg==
X-ME-Helo: [192.168.1.37]
X-ME-Auth: bWFyaW9uLmphaWxsZXRAd2FuYWRvby5mcg==
X-ME-Date: Sun, 04 Aug 2024 08:27:17 +0200
X-ME-IP: 90.11.132.44
Message-ID: <68d63e24-ccd7-48ad-af38-0c9e2202a8f9@wanadoo.fr>
Date: Sun, 4 Aug 2024 08:27:15 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: b43: Constify struct lpphy_tx_gain_table_entry
To: =?UTF-8?Q?Michael_B=C3=BCsch?= <m@bues.ch>
Cc: Kalle Valo <kvalo@kernel.org>, linux-kernel@vger.kernel.org,
 kernel-janitors@vger.kernel.org, linux-wireless@vger.kernel.org,
 b43-dev@lists.infradead.org
References: <38528f48c8069187823b774a6b2a53088f6c9599.1721161231.git.christophe.jaillet@wanadoo.fr>
 <20240717195743.31bdb01d@barney>
Content-Language: en-US, fr-FR
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <20240717195743.31bdb01d@barney>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Le 17/07/2024 à 19:57, Michael Büsch a écrit :
> On Tue, 16 Jul 2024 22:21:13 +0200
> Christophe JAILLET <christophe.jaillet@wanadoo.fr> wrote:
> 
>>   static void lpphy_rev0_1_write_gain_table(struct b43_wldev *dev, int offset,
>> -				struct lpphy_tx_gain_table_entry data)
>> +				const struct lpphy_tx_gain_table_entry data)
>>   {
>>   	u32 tmp;
>>   
>> @@ -2356,7 +2356,7 @@ static void lpphy_rev0_1_write_gain_table(struct b43_wldev *dev, int offset,
>>   }
>>   
>>   static void lpphy_rev2plus_write_gain_table(struct b43_wldev *dev, int offset,
>> -				struct lpphy_tx_gain_table_entry data)
>> +				const struct lpphy_tx_gain_table_entry data)
>>   {
>>   	u32 tmp;
>>   
>> @@ -2383,7 +2383,7 @@ static void lpphy_rev2plus_write_gain_table(struct b43_wldev *dev, int offset,
>>   }
>>   
>>   void lpphy_write_gain_table(struct b43_wldev *dev, int offset,
>> -			    struct lpphy_tx_gain_table_entry data)
>> +			    const struct lpphy_tx_gain_table_entry data)
>>   {
>>   	if (dev->phy.rev >= 2)
>>   		lpphy_rev2plus_write_gain_table(dev, offset, data);
>> @@ -2392,7 +2392,7 @@ void lpphy_write_gain_table(struct b43_wldev *dev, int offset,
>>   }
> 
> These three changes look like they are not necessary.
> 

Correct. I'll send a v2.

CJ

