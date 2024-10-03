Return-Path: <linux-wireless+bounces-13451-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A106298EBA4
	for <lists+linux-wireless@lfdr.de>; Thu,  3 Oct 2024 10:31:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2E34DB20D75
	for <lists+linux-wireless@lfdr.de>; Thu,  3 Oct 2024 08:31:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54C8281742;
	Thu,  3 Oct 2024 08:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="CJ9ogBGy"
X-Original-To: linux-wireless@vger.kernel.org
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC7436F06A
	for <linux-wireless@vger.kernel.org>; Thu,  3 Oct 2024 08:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727944287; cv=none; b=iIVV0u/D38hyZbAbTF67TBg4X/x2vylneSRSNiUs0RQC7zt+Zir7D454QCtU5i4pKjywpJO9XDH6e9VmHL2jJ5Qdx6J8JVCz1dTPj4qTskI80vwbAW2cI9DxThaiNuKM/ciOS3TV/a9qlGyw3HUm1+qAAWtyV3SlTthtsgn263U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727944287; c=relaxed/simple;
	bh=UmNfXkv9A4aPfCGIHuz1dpD03yyfUYOad9Vjkjkl8hM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QcMTO+y/iTn/FJvFcejgO0wVX6eg3m1zft3MRqgAPdys0iIC+c3CMP+Rfy9+iqygTL47VS4sxWxsqy3U+aU499gEC8rJ6t9i9oc5+cUXTg4bK7HeUa1J67b+xy87xgqlTltKvtC/xGBaTvOjVXQ76TbIILTKuv0I0Fj1O2UmMd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=CJ9ogBGy; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id E750C1BF250;
	Thu,  3 Oct 2024 08:31:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1727944284;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZJAn8v01RuPs1eIcKpM/Xzk14r7FZwvKk5LHczioLu4=;
	b=CJ9ogBGy9xlxTvhncXyHhxnVbArd15Xg5j+e6l6tEFerpQ3SJQ6r/Y1X9DJkXOOIWyMBi3
	Aiu788h1nbTABPRjPwNne9F+FubVKPm3kd97bK2yz8QFksskdaCTK/+AH48xT51XNHyTY6
	Wc/AaT1RCWBenMXNYSLVY03fo9UpkVn54NMQX1lOB6164pc42brbFc47dLRzG+I+6EBcjv
	5CEbCXWaiE0WcKQ2CHG0BG2BF4YbGkKMThU5WFfDE3Wusx9SYSE4KfLDBknNlpDDIeZd5R
	uEIM8NlfrNGrmesXyZZIXuSK7UeVs5X6HKpiojmCoWQ2vwW59EQRTlvRFfDxKQ==
Message-ID: <372e6f65-79f1-4a64-a323-2939269a8a45@bootlin.com>
Date: Thu, 3 Oct 2024 10:31:23 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] wifi: wilc1000: Keep slot powered on during
 suspend/resume
To: Marek Vasut <marex@denx.de>, Kalle Valo <kvalo@kernel.org>
Cc: linux-wireless@vger.kernel.org, Ajay Singh <ajay.kathat@microchip.com>,
 Claudiu Beznea <claudiu.beznea@tuxon.dev>
References: <20240926195113.2823392-1-marex@denx.de>
 <87ed5481ro.fsf@kernel.org> <b3429a32-111b-4bab-9f4f-84c75bb3a049@denx.de>
Content-Language: en-US
From: =?UTF-8?Q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>
In-Reply-To: <b3429a32-111b-4bab-9f4f-84c75bb3a049@denx.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-GND-Sasl: alexis.lothore@bootlin.com

On 9/29/24 17:23, Marek Vasut wrote:
> On 9/28/24 1:18 PM, Kalle Valo wrote:
>> Marek Vasut <marex@denx.de> writes:
>>
>>> The WILC3000 can suspend and enter low power state. According to local
>>> measurements, the WILC3000 consumes the same amount of power if the slot
>>> is powered up and WILC3000 is suspended, and if the WILC3000 is powered
>>> off. Use the former option, keep the WILC3000 powered up as that allows
>>> for things like WoWlan to work.
>>>
>>> Note that this is tested on WILC3000 only, not on WILC1000 .
>>>
>>> Signed-off-by: Marek Vasut <marex@denx.de>
>>> ---
>>> Cc: Ajay Singh <ajay.kathat@microchip.com>
>>> Cc: Alexis Lothoré <alexis.lothore@bootlin.com>
>>> Cc: Claudiu Beznea <claudiu.beznea@tuxon.dev>
>>> Cc: Kalle Valo <kvalo@kernel.org>
>>> Cc: Marek Vasut <marex@denx.de>
>>> Cc: linux-wireless@vger.kernel.org
>>> ---
>>> V2: Rebase on next-20240926
>>
>> BTW I recommend using wireless-next as the baseline for wireless
>> patches. For example, wireless-next is not pulled to linux-next during
>> merge windows or other patches in linux-next might create unnecessary
>> conflicts. Of course most of the cases using linux-next is fine.
> I didn't know there was one such tree, added to remotes, thanks !

+1, as already mentioned in previous revisions, I would gladly test wilc3000
changes on both wilc3000 and wilc1000 on my platform, and having the series on
top of wireless-next would allow to do it on top of any change also affecting
the driver in wireless-next :)

-- 
Alexis Lothoré, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

